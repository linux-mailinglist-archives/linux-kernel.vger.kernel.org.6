Return-Path: <linux-kernel+bounces-408355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676B9C7DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D568A1F22DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CB918B49F;
	Wed, 13 Nov 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Bw/x0onR"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F7157A48
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534366; cv=none; b=Jte7TBWza8UHsj0QIDDCvkN2MCwMYhh8Z03Vm29H0F0Q4nsw+3+OdJumdQdBThY9BdVsv2KuLiOIbSFhRsnWAalszMh6VYaT336VqEC7wfnxGcp+ycH9YCC17gqDS0yDIPx5ZZM0rs4Aps2iYfPcjmss8CUu//t3z/cK86EnRPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534366; c=relaxed/simple;
	bh=Y1a1GvFMfFSrI6BiK6Sa4trDZsORdpDF3B4sxwPWnCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rda3I3600uWCAN55IdvwECNIOXkJ5hCVxHeE9A5pDm8J3WELIhZyRZB0TCJj7fyoZYAMdjK8QM/q8iZOjcV8zBLWAj8YJ8NAdnkITAJ+ZB8mG2Z7eOHeIEMrNdh3FtxrAfhHXAknxjeXTfq6SbhNpdd8H5yoZmTUdj5Oy3D7wT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Bw/x0onR; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83ab94452a7so301894939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731534364; x=1732139164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8MCBqkknCuR7nmUHOM5k6+ykgdCg4LD0NxXqEnZs4gk=;
        b=Bw/x0onRTZ94mlCwoiFpgdcH77AygI4dh4cGySo0X+zHVU+kSivUDtwOwHL2BNgQmc
         Ot39Wr+/TcW4GsY23fFCKPKnAHiSVWh/hzoy3HoAnDQf/4DX3G9NONN4jY/bl1zyXmIK
         6AoW8xrCMxBoedFaM41nQTBrS/XkzAzvZrvGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731534364; x=1732139164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MCBqkknCuR7nmUHOM5k6+ykgdCg4LD0NxXqEnZs4gk=;
        b=TqzKdP3Q0mhY7n/crCadrMgsPegwxL6EslHfTK/ARpEgyX6EzW1OIzj7pyVA/e/d27
         NzWeh9mHuwtu747/QHGLL8dRvOTCu+sEDCKc/cfaoxHlbI322wf0p2oYRNa4F6OdQSb3
         LrngD91Bxh2fx8NiBQ5U1ZtKoHSYapLT6iXD4EjYvTlQu5kb9ONcY7EOy8+QQEvsUAh2
         ASTQdT0aWyLzwWdubJP7Qo5N09sJ3wnC75OBNq7lWl/6w3Awt4OjjrdgHRUDeD4NRN89
         S14ESMW3eygFG3G1pOHzEla1pLKT9U+E3NW+gdJ0FicIhPA4/aBf8GmOT5BuiILp7E8j
         MtYA==
X-Gm-Message-State: AOJu0YyKIkhizMs81kN8i3K0FevePcO3htijieSodMTBBQK7UZhNKU/N
	2KxQEvJ3LmrJGX3lRuDT1Veq6RG+5EhzQIxgS3iCYW0WPZafcs/psYz8C03YK+A=
X-Google-Smtp-Source: AGHT+IHksm+ENKpBrqw1eGitvwqs3Zb/ioYQHYQMSClxA2YnM4ubXQ5EeJmUKHuNPiRN8obhDzNcrQ==
X-Received: by 2002:a05:6602:1512:b0:83a:872f:4b98 with SMTP id ca18e2360f4ac-83e43175db5mr955799939f.2.1731534364349;
        Wed, 13 Nov 2024 13:46:04 -0800 (PST)
Received: from localhost (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787f0a9bsm3128975173.128.2024.11.13.13.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 13:46:03 -0800 (PST)
Date: Wed, 13 Nov 2024 21:46:03 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC 3/3] tick-sched: Replace jiffie readout with idle_entrytime
Message-ID: <20241113214603.GB2331600@google.com>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-4-joel@joelfernandes.org>
 <20241110225545.GA1579217@google.com>
 <87y11omrsk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y11omrsk.ffs@tglx>

On Tue, Nov 12, 2024 at 03:48:43PM +0100, Thomas Gleixner wrote:
> On Sun, Nov 10 2024 at 22:55, Joel Fernandes wrote:
> >
> > +       /*
> > +        * There is some time that passes between when clocksource starts and the
> > +        * first time tick device is setup. Offset basejiff by that.
> > +       */
> > +       basejiff -= DIV_ROUND_DOWN_ULL(tick_first_period, TICK_NSEC);
> 
> We clearly need yet another division here. Especially as that division
> results in the exactly same value every time.

Yeah I fixed it in my v2 but did not post it yet:

https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=timers/tick-sched&id=60707e27418e3bca026be0bd9b1eacfe2a6ce72a

I will hold back on posting till we finish discussing on this RFC.

thanks,

 - Joel


