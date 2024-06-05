Return-Path: <linux-kernel+bounces-202178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE48FC8BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BDAB22E98
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2F519048D;
	Wed,  5 Jun 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P+S9AzXT"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857A190076
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582510; cv=none; b=nNgAgqrrXoPWnLIfRR2a4+FeZy+KQyeznQh1ihCN1xBz8S9jaIkHnE1fITDVf+G4zhBc2jjS90lVYMtNiGZJWKmPJF3GpVhciEaDY2cLbyRmmYlePVgfaGohBCb+ZcGbnfAmJfoLfuMptgbeqQpOscQArZ2R1ssBjV4WbcVJXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582510; c=relaxed/simple;
	bh=HtGAESEB5A4ifQnCilFXSr6+jFmp7L7fR5ovmv6VOLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai4hAGUsdcMN8XyzGn5hhptmvYjOTe0bxKZxllCU3w07fWodAc+DOnu8ts9RRww1QcNuGYMhEGx0k4+f8khFJBPPRxEy3QvewDZeENY1gE/dTakxwHayZi+3CzVi4TntXLSxMDyDmEwT+qoLbu0fmzIWwadMc5s7g1hWRchukPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P+S9AzXT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35dceef429bso404905f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717582506; x=1718187306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxyCUVpRxT9r4WcxUsE/s7yKzpPU3+jmGl5p/EECmd8=;
        b=P+S9AzXT4qUzdg3Q8sFz20HLKR3Y48m0Cjf4GiZLRdtHEAB1cSed60Wcm0N83kSpMR
         snoi6SRAc18AOnjuBZBdxS46x1Q3KYD7ZRr9wZQY/ipa/4WaXjWYJ4Z2tRnrTqkYIhTd
         PbT5uIASqHG3c0+xpX12vLEVfzoF0jubg1I2opMfsNu6TJ/+XAtLjFONE10t7eM7eZtt
         5364hpudXMjzX+v3KGI9fcNcJHIe3nxhH5HUcFQLmh9Y4lnHCr52MdEgQYNhZJ1uwe6t
         sprBOlsxX7RXWOIj/yZ9IBEG0QqpYpb0UpRp2YHvKCFG3egK+8VC/AqMIl037TvgF2Cb
         duvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582506; x=1718187306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxyCUVpRxT9r4WcxUsE/s7yKzpPU3+jmGl5p/EECmd8=;
        b=B7bVb/46/C+oPTarLKvLQGsVzS/b3r/3rDEus3e2O23dhE7+VuSgU3GBiegWo1B7e6
         j1EgmlxQ3v6OeDkunRZNbG+q6dFgQtO66mPVwX3uvqQuYqIp5dFkNIsp34EsqpYx3jvg
         KpadYEOmUxkcTp5joc4WK1jz/No72glLG3yitwo0z6Ipfkag/iSwHZnva0oAexlJN2h2
         vOwODBIqnSSC6nptwnG+0NCltfTzJVuFhh5Rrqcnlb4ANyd3RJXU71+KzRvWUusUZUKJ
         tnbSje59kqqVZOAz4ZSG3o40YtjWD1guGiYmCGFSP7a7lxQpitftpbQNIgwhHrjEjwZZ
         dToQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgS7r9ut02ZTeY4zFakQuLJhjy31ABy1cZPZJWTnQ/jFzzuIzR6+0FkzEpKugeTU88cZWd9WUxINwuDCMxJCJIwlQPqIDocETrjVme
X-Gm-Message-State: AOJu0YzCh9TrFrqZi9fPCTi3hNRjo9GinrR0BlNKLSnDuC7mvulXHeJj
	XWtLQH++WIVUkquFTFnWO/6R4uAaM4mpx/F74qn0O+8YkSYlpVlVEI0RAEr0KsnwYLOXhj9+tAG
	W
X-Google-Smtp-Source: AGHT+IHlsyaSK+z56mrklM5jykYlSjK8tWb2sNaVuZk0ryedcd43/wbhrOlsz6C5ljOByT6CxIWoQQ==
X-Received: by 2002:adf:fcca:0:b0:35a:e093:7682 with SMTP id ffacd0b85a97d-35e7c591326mr4996354f8f.30.1717582506511;
        Wed, 05 Jun 2024 03:15:06 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703599758b6sm1426482b3a.173.2024.06.05.03.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:15:06 -0700 (PDT)
Date: Wed, 5 Jun 2024 12:14:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH linux-next] printk: nbcon: Fix
 nbcon_cpu_emergency_flush() when preemptible
Message-ID: <ZmA6oGrO1YVF-IYj@pathway.suse.cz>
References: <87zfrzvhsp.fsf@jogness.linutronix.de>
 <ZmA5oIkImclKM0vx@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmA5oIkImclKM0vx@pathway.suse.cz>

On Wed 2024-06-05 12:10:50, Petr Mladek wrote:
> On Wed 2024-06-05 11:57:34, John Ogness wrote:
> > nbcon_cpu_emergency_flush() can be called in a preemptible
> > context. In that case the CPU is not in an emergency state.
> > However, in order to see that the CPU is not in an emergency
> > state (accessing the per-cpu variable), preemption must be
> > disabled.
> > 
> > Disable preemption when checking the CPU state.
> > 
> > Reported-by: Juri Lelli <juri.lelli@redhat.com>
> > Closes: https://lore.kernel.org/aqkcpca4vgadxc3yzcu74xwq3grslj5m43f3eb5fcs23yo2gy4@gcsnqcts5tos
> > Fixes: 46a1379208b7 ("printk: nbcon: Implement emergency sections")
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Great catch!
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I am going to push it...

Juri, should/could I add your Tested-by ?

Best Regards,
Petr

