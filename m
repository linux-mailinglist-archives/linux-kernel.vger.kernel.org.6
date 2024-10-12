Return-Path: <linux-kernel+bounces-362633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3A99B778
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 00:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F99C1F21CEA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCAA19ABDE;
	Sat, 12 Oct 2024 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="kw6DyQKD"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A27414EC46
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728771023; cv=none; b=X/2u9unJGpzAgBMQtV/6Pg3C/VvQDKEQM8yRKQYdRxRDHUKuxosPv+0mitfwph1YOWsx7kiEdV90LaeQXd/Ltf7DWreR0fBLx3aJsekrPMnR4eiNuTAwewE56fPQzzb/eSQxuMEL5lID2NHRoQqcvL14SLK4ywD2phqtjRv5Mew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728771023; c=relaxed/simple;
	bh=AU7a2Zr7p8A4S+NqTS9Mrg61c7fQiRIw6QG3RcEbNY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s19FweL020jz0PCCIECKMAP1jeXb5x4d3jx+nJROcbvyXA8kFOvrjM4Pznv619qwQq9q3E6Yg87sD0fzvM9J2+WxLZ+Ior0Q9Nd016/hI88qowC9ss6Ig/SG4tkTFPIJT21m9UXRnUpf96UmHFBVdHS7aV7ihizOIzeK0zsXYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=kw6DyQKD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so1586808a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1728771019; x=1729375819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VaqY4lX3JGPy2BatECR34HXL7Or/ZJJOPUYOEdpr8xc=;
        b=kw6DyQKDlfyX1H0+MiMNKpo6M5mZVI9WgaODTVmw1/qWByxTjf/2CeW7zlYyGDxsKY
         sEO5baFAp3gtrjH1+pam3FQO5GF8wIxJ5Bd+JoPUfWKI0pIE/Jql1Ecz2q9t+yFVvJfN
         PAa/PZ8tGOgIGW5KCuHIy7GzAmJ5+xE1AYjjoGHDBZ+ln5HodekGYqlyXCMZT3hHyQTk
         A54lKcjKZW3qWlBr3QphUqVnb4zQZjey6hRkl/ShfHntsxyzrd0WBw6DkUn4buPgvCqL
         rAFM3R35PqHowIFe5RHdMWaS4WZqW6w27k5+w9aq91whe97Om58ACgl31knP5iz2OPvr
         ZWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728771019; x=1729375819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaqY4lX3JGPy2BatECR34HXL7Or/ZJJOPUYOEdpr8xc=;
        b=JKLZM6Jj31lUxNgsMlN79r59n4wYo3muj+DmSDRafaXpnxeqqKy3zJD4NvakY40vap
         RbMJLRh9iwKbI0Ito/4lPImwt5XngBK3UC0Hwbn2yAN+SW4iisz7XTzUOQSGisxSuSDA
         xzM6Ioz+Oe2mXCjwJRC3RUjaGrScpExfJXgvbk2qK8h02C0P1HWnucSfqvDEqHXDQQYl
         flFuauJhNnejVJBDYt39+7vHAamzHlgF3AaLcp5RPK/abVHO/u/6npzTFeuIPn7mQFwo
         EYIEPZi1JYlpseGgAF2L40lhkmudsAeLJ+tdTgeEJdKiB6qA/QVo/poXGy5mNKps7Sue
         27HA==
X-Forwarded-Encrypted: i=1; AJvYcCV60QUR/yVTgvB4JxmyPNGggbFR0sDYsbi77LqUFIeQrZBe+nCC4QdmoNwY1Oor7cpmtD/VE1vz2OdBZjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhf8IkTP6w8maipkUsNd6+Q1uPQQ2//ePVufm6wyLH+eybOqI6
	D27r5AF9c+fUKpWveYQLnUJSwWUgViLNpsbVvmeGvGjyf6zEOvqIMM+Smaxa2eVKDI/4y+bPG7m
	Z
X-Google-Smtp-Source: AGHT+IE1/aYbGTzCv8bfQ5hZEh6XbTmhjCnn3r7I1Fk+BDBcJvDuYxZ91eQW6Z9up6+hPtsiEHu2dg==
X-Received: by 2002:a17:90b:224c:b0:2d8:3fe8:a195 with SMTP id 98e67ed59e1d1-2e3152b0100mr4996419a91.4.1728771019476;
        Sat, 12 Oct 2024 15:10:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-209-182.pa.vic.optusnet.com.au. [49.186.209.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30c642138sm2779051a91.56.2024.10.12.15.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 15:10:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1szkJS-00HXhc-1s;
	Sun, 13 Oct 2024 09:10:14 +1100
Date: Sun, 13 Oct 2024 09:10:14 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chi Zhiling <chizhiling@163.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, cem@kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	chizhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] xfs_logprint: Fix super block buffer interpretation issue
Message-ID: <ZwrzxggtS96n72Bm@dread.disaster.area>
References: <20241011030810.1083636-1-chizhiling@163.com>
 <20241011032415.GC21877@frogsfrogsfrogs>
 <97501a36-d001-b3fa-5b57-8672bc7d71da@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97501a36-d001-b3fa-5b57-8672bc7d71da@163.com>

On Fri, Oct 11, 2024 at 11:54:08AM +0800, Chi Zhiling wrote:
> 
> On 2024/10/11 11:24, Darrick J. Wong wrote:
> > On Fri, Oct 11, 2024 at 11:08:10AM +0800, Chi Zhiling wrote:
> > > From: chizhiling <chizhiling@kylinos.cn>
> > > 
> > > When using xfs_logprint to interpret the buffer of the super block, the
> > > icount will always be 6360863066640355328 (0x5846534200001000). This is
> > > because the offset of icount is incorrect, causing xfs_logprint to
> > > misinterpret the MAGIC number as icount.
> > > This patch fixes the offset value of the SB counters in xfs_logprint.
> > > 
> > > Before this patch:
> > > icount: 6360863066640355328  ifree: 5242880  fdblks: 0  frext: 0
> > > 
> > > After this patch:
> > > icount: 10240  ifree: 4906  fdblks: 37  frext: 0
> > > 
> > > Signed-off-by: chizhiling <chizhiling@kylinos.cn>
> > > ---
> > >   logprint/log_misc.c | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/logprint/log_misc.c b/logprint/log_misc.c
> > > index 8e86ac34..21da5b8b 100644
> > > --- a/logprint/log_misc.c
> > > +++ b/logprint/log_misc.c
> > > @@ -288,13 +288,13 @@ xlog_print_trans_buffer(char **ptr, int len, int *i, int num_ops)
> > >   			/*
> > >   			 * memmove because *ptr may not be 8-byte aligned
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is important. I'll come back to it.

> > >   			 */
> > > -			memmove(&a, *ptr, sizeof(__be64));
> > > -			memmove(&b, *ptr+8, sizeof(__be64));
> > How did this ever work??  This even looks wrong in "Release_1.0.0".
> > 
> Yes, I was surprised when I find this issue

I"ve never cared about these values when doing diagnosis because
lazy-count means they aren't guaranteed to be correct except at
unmount. At which point, the correct values are generally found
in the superblock. IOWs, the values are largely meaningless whether
they are correct or not, so nobody has really cared enough about
this to bother fixing it...

> > > +			memmove(&a, *ptr + offsetof(struct xfs_dsb, sb_icount), sizeof(__be64));
> > > +			memmove(&b, *ptr + offsetof(struct xfs_dsb, sb_ifree), sizeof(__be64));
> > Why not do:
> > 
> > 			struct xfs_dsb *dsb = *ptr;
> > 
> > 			memcpy(&a, &dsb->sb_icount, sizeof(a));
> > 
> > or better yet, skip the indirection and do
> > 
> > 			printf(_("icount: %llu  ifree: %llu  "),
> > 					(unsigned long long)be64_to_cpu(dsb->sb_icount),
> > 					(unsigned long long)be64_to_cpu(dsb->sb_ifree));
> > 
> > Hm?
> 
> Yes, of course we can do it this way, I just want the fix patch to look
> smaller :)

This won't work on platforms where we can't do 4-byte aligned 64 bit
accesses (various risc archs), hence the comment above about using
memmove.

It should work if we use get_unaligned_be64() rather than
be64_to_cpu() - I would suggest that all such structure decoding in
logprint would need to do the same thing...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

