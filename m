Return-Path: <linux-kernel+bounces-405882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E849C5875
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7397286792
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99BC54918;
	Tue, 12 Nov 2024 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VQwUVYaf"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCA1E4AD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416445; cv=none; b=dmPP79c84hHo6KfI0IAoWHE5wvgLT0sv0qF8NxoqdrkNzvQhYJUam/zxKgx3ZelOwzpI19bsRtAthlZWL8k1HcaSIByeky31scBuNKDz0poD6Jk4KdaDdzG6z87tuN52Kw0eDqgE59hf4HJFVvY0eIrfo8zZZ7hdgmuarOtLh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416445; c=relaxed/simple;
	bh=+YFD5JvrG+ohdkgrt4NvulMpg139R8vpDc6xgL396ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trgzPrm3vhC/m3iX1/JqSuTu53YJUfL8Rz3Yren7FzML+c1R7paLXLNArCGSL9kwiWX6lEmWtPuqAfIcURKMtgdj5bC4+XrJ8kZ/zf4+8uYEcGkXo4040iruRNoKXmtcEQkbS3FS09CwqIotoPZquJheKkRgSPsygUs50tkUvWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VQwUVYaf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso5303245f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731416442; x=1732021242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rF4GwROy3d+UzNuXKIfFH88c5K1pZi8zqkt0yQGbDkQ=;
        b=VQwUVYafKUxdpHU2KWjBVhCJ9308PO6GftsNtoWRDZgCvWdQ+VgA5LUtEYvYdsOQi1
         unA1Dy7ZchX7mvCGegZHOZU9H1LgzHhcQv0FG9Jm1nBV8+tcGe3Nezew5n2p4q4e/Asc
         kxjzFGN1YdGF2RUYuctVv15WdrwZGCpZDsTt+7bp8woUvFeu1Ycwtc7Ge+9gdIW0CMy/
         8y3netEkxmU8e6keA2tgeQxqe2ZwjqFTHkqLmuvlP+R26RR5LFyVkfQEbb9vc9srrHZK
         Y9TfMZi1CNBewbBqfukDoXJauoeBPVhvwjMrhIzI8kwZm3F9+ct7XkN03sFkdyDVv4Ru
         gmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731416442; x=1732021242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF4GwROy3d+UzNuXKIfFH88c5K1pZi8zqkt0yQGbDkQ=;
        b=HD7r3Qk8ode30So1Xlhcf9eFahMo16pJrGiCM49Q4ckCFT+9DIlxEaS0+r9p63fMNv
         cWB2pVjcs2KbRvFQOweG3xJYWYQfn6P+5ucGfM44cllU3i9x17vICwZapq4/qM1j59Om
         1hTQpFUXeINm47rTpceai6WbnPbV3/6PAQmyZFKkiDn+0CcHHOB7T/v6Gq4SaosAUjT/
         o2kOST0XwW35DrmcoimRzjs626qX2cQi56dJ38bi0ETl2G/m6YApkYYbiDNa/mLT0Yoe
         dW2BX4KE5hXWyNCrftBhCOmX21D8/xilwVsR8sKs6oEl6JMdX31TLBHWOz9rNHauFBIN
         Qv1w==
X-Gm-Message-State: AOJu0YxhvykEO5ffBd6p/PBPIK4kNikntjeisAItiak2hhgw5VeB0BQH
	cAIhI/K1HI4z9C2QZOL8gFgrJ4Uukpgv4R0zTHkAxH+J2yJQ+mwNRSP3l/78w+o=
X-Google-Smtp-Source: AGHT+IHLdI50PlAE825xCioNqqYnr2wcOjK7/vM8MYuqyR7pvhk7YRRHz3F62apvQf/djMolRUMcbQ==
X-Received: by 2002:a05:6000:1868:b0:37c:d1ea:f1ce with SMTP id ffacd0b85a97d-381f1871ae1mr16983546f8f.25.1731416441802;
        Tue, 12 Nov 2024 05:00:41 -0800 (PST)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed987d33sm15611170f8f.43.2024.11.12.05.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 05:00:41 -0800 (PST)
Date: Tue, 12 Nov 2024 14:00:39 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 05/11] MAINTAINERS: Mark printk-basics.rst as owned by
 printk subsystem
Message-ID: <ZzNRd1Lqn0EYyKzq@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <62e6a36052a1759e7d01669c5c760b6a1760a9c8.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e6a36052a1759e7d01669c5c760b6a1760a9c8.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:45:43, Chris Down wrote:
> We are going to update this in the next patch, so while we're here, we
> might as well mark it as owned by us.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

