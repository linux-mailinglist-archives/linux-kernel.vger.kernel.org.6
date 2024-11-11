Return-Path: <linux-kernel+bounces-404138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6651F9C3FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C2F28271A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680F19D891;
	Mon, 11 Nov 2024 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bk5lvahY"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46738194ACC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332266; cv=none; b=kSwyaG0zV8z+ocmWZ0agJOVeN1J0PeJ5ffW7LxJGtfxPCXRIA6QwBq92AgkkuHVigjyVGMyixYbGa668hbmrqdzlBmKMWiADfrRgux6R24/o32yyXUHz9Xw5zDGoc4S+F0alkR1B+wslwLK6nuTIis1qQk5iCOQ4+OObwCuppqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332266; c=relaxed/simple;
	bh=zldQuZy7Vw8Jc/U9Gqrx5DoU6JGXukbJ4pnR6Ieqjxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sh9G9LBo/0W8hLxbqG1/vC62ZnJMuK1/xTv+aWmxuOPSy9k+8t5qHitAZ5EMwQJemYOFhTMqBPcLOJbaJbfF10pDLvqtkJWMFSrQGT1sFq0pXUPEGvL94Q0tBfPSJDMNIXlyjesS1ftizcisVX2yF/6VsXOJEQm+wn5i7shibs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bk5lvahY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43193678216so43091915e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 05:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731332262; x=1731937062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3alwZykr3cxEiilJjH/3zMnNgVJKTf1Srqg5Us7D+k=;
        b=Bk5lvahYiGE4jL6tcHqoopyu1WfjPDKbyX9SCGrki38ITA/li6vQ4fSa17eLU+lIEI
         HDrsOhffM/DSoNIop0GykMihgHxucYtxYSCMHPNguohhSSp8co+Kk4SVaVwzEN0rSVQN
         SHY2N22Xf3167NC32mYBFscPBa48OzLZj63HaCbMkc6wSm4Ze82x+8gHLAwcpI04fqd0
         h4xKHtRtjYxM4aQG42Cx+4hmCi8Qyn9KSg7UptIO76TJF0Vis95OM3QDqpLEOrrt7K8L
         OQMJPHmP0VzSIxicV5aWPRJ+Kd7LQMzXMVZA1WMmKPeLPmcoCJGegf0VYyyQJB2lDtt5
         WNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731332262; x=1731937062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3alwZykr3cxEiilJjH/3zMnNgVJKTf1Srqg5Us7D+k=;
        b=awGg3e+bbT/T18A5eTjbHc7scIVpXFlG3IY1Uu2XPhBjS6QbAluAqIhyiG0MfM+PCU
         77bW28fZ2QFXqT3MVvehe3ma9m0UnndSun65Mqz1uDYgBSvs9van6xjq6HfmDJM+0Mde
         Me20WTpQNIjm4bzQuQDFoYdCH/8WTQ5iO2A8Xq1788tKh9w8HERwojx3YM0ULkTKrhrE
         YDbpElVCb1Kw2OEc9KF5z5Y1GvDvpN4jCJYUxKYtuSSZonhl8QRp/erzjaFgavsNc6tx
         OWP2hfYz+JN0tsdSB6XD4zSG67oQfSSO8rNC4O9TyBF3Vzx5UHYiuy3zSj97Wa1vbw7t
         FaBw==
X-Forwarded-Encrypted: i=1; AJvYcCV+8pt/9CNM1BBZX5iQSSHYSXNm+59i6tLWYM2+3Teugd25hXT9xfJU4zPcueLIuJQUs4nUdXXf5qTUwyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPypWceXxQr91ttsbkBSiVivoS0ZTnNJuqjR1eYYSDXzNdEvQ
	TRBCyiHgIe4OR7PMtpyc7B9LhpPlezxBiyNPwaImXaBbhOePgtIM536pB+WHbs0=
X-Google-Smtp-Source: AGHT+IHN6VX3szu3asu+FTdSapdN3XKQswp3SlPLA1xm4qyKmZWBrqljtY+pMYxuZ/VQ0J6d4xUkSQ==
X-Received: by 2002:a05:600c:8715:b0:431:93d8:e1a1 with SMTP id 5b1f17b1804b1-432b751bcc2mr103836265e9.27.1731332261641;
        Mon, 11 Nov 2024 05:37:41 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm173495965e9.17.2024.11.11.05.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 05:37:41 -0800 (PST)
Date: Mon, 11 Nov 2024 14:37:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 0/2] printk: Add force_con printk flag to not suppress
 sysrq header msgs
Message-ID: <ZzIIouTeCZiwJihg@pathway.suse.cz>
References: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
 <ZyzjcLF-wleMTpoY@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyzjcLF-wleMTpoY@pathway.suse.cz>

On Thu 2024-11-07 16:57:40, Petr Mladek wrote:
> On Tue 2024-11-05 16:45:07, Marcos Paulo de Souza wrote:
> > Hello,
> > 
> > This is the second version of the patchset. It now addresses comments
> > from John and Petr, while also mentioning that the current work solves
> > one issue on handle_sysrq when the printk messages are deferred.
> > 
> > The original cover-letter in is the v1.
> > 
> > Please review!
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > Changes in v2:
> > - Mentioned that it fixes a bug related to loglevel= dance (suggested by John)
> > - Changed to loud_con to FORCE_CON (John, Petr)
> > - Don't skip printk delay if FORCE_CON is specified (John)
> > - Set FORCE_CON when LOG_CONT is handled (John)
> > - Changed force_con from a per-CPU variable to a global variable because
> >   we can't disable migration on the callsites. (John, Petr)
> > - Used is_printk_force_console() on boot_delay_msec(), since it's used
> >   when the message is stored, instead of setting is as an argument.
> > - Link to v1: https://lore.kernel.org/r/20241016-printk-loud-con-v1-0-065e4dad6632@suse.com
> > ---
> > Marcos Paulo de Souza (2):
> >       printk: Introduce FORCE_CON flag
> >       tty: sysrq: Use printk_force_console context on __handle_sysrq
> 
> The patchset looks ready for linux-next from my POV. I am going to
> push it there tomorrow or on Monday unless anyone complains.
> 
> There was some bike-shedding about the code style in the reviews.
> But the proposals did not look like a big win. I think that it
> is not worth a respin.

JFYI, the patchset has been committed into printk/linux.git,
branch for-6.13-force-console.

Best Regards,
Petr

