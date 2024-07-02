Return-Path: <linux-kernel+bounces-237726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B89923D54
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D593B1C21EBC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F0915D5C8;
	Tue,  2 Jul 2024 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XKXQozUz"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DCB15CD54
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922340; cv=none; b=kCE84WBGNlsLFPc6EaFARt4rg9ldCYjxNJmaDKQA9G1FJ5e308md49U2Uaub2xaWo2kwCq9S0D5vfiG1/jPR7pEoU1c+tj7sdg4/os/iZhiZj3Sx6unFIpHAn0XZhrZpXMLbuAc0nZFWD/gf580Gu1Bs9h/MusbIeCiHf7Vuzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922340; c=relaxed/simple;
	bh=pQF1gmroJLyYPwVp6Y99BEq59Xm9uFxtaNDkFEsBrCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5LbnHLfKcKTLNFvKsJHGFvdIawin/YiUylL5W7hij6IyDK8WUoHwVyWn30JAirXJr4i4yYyJfeuJ9gXWYkxgm5Cp/c8uWMyDjsUayXCsIHZrWfUWZumyMXMO2/6ctI/5rM+jbnaGO2clE8qv7VzAKFZHI5xZKOQKpqChbp+zwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XKXQozUz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so42650251fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 05:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719922337; x=1720527137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xngQr25p1sZV26OzUH+Wi8Y6ZPE5TWk/yG5cCxzrxs=;
        b=XKXQozUzPq4pL0A+FXFqOsuRVFBYQA9FdTkzFWzWagHTvU/g7cvksv85USBzJoXZTP
         LY94RmODBTbw3NJRDJSFw11aeEdU2Y66L2fCaguWPjG0vfN7QmIA6Vm6sicZBfG6n4qW
         Gfc6IUhaQ5JURYm00CsEfyKhx5PJDB22YX1Kc47Np4LtkR3O+I4UuTYbjEaZlPIks9Ud
         eHNDXSM1Et3Hp4IJMuIS8qz0cYM3wUPAvZ+717JC+6kXchq0oVcgox9eDZ55v0Gco/TB
         wHXdeuQZ0sKEwfH0Xy4X4vjb6h6G38zmdm85ZtA2hktD2oNK8kebQXBPIsenZ8cO8wom
         L/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719922337; x=1720527137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xngQr25p1sZV26OzUH+Wi8Y6ZPE5TWk/yG5cCxzrxs=;
        b=vqoZxlDuwNhyGGMLNSd5zUEhXJw5SSwPeVWkLkVvG0aS+gCesuBe0oGvHXAsb892CD
         pK6jhher8i+s/lS/vL7VyVJC/fkSxDYcwTG4YrbZxm/5tJ3nUq8VAwk94XTIa6Leh5XN
         nJ8FwFuqvb0s2qj55e78lw5eWjHRdKuEcDRGBfAHI7Vr7GSRSAWN+Ft9R7E4F3Ql5yam
         lCanoKweFgRZfh7KDgMogqPD5mCBxZzvaVogukbjw/y1jslX122CWAMAudPKqhy+PFQC
         lvMTSjWI9h0iliVPIGQWYqH2vx02HA8u6eCFhIwlPrBJKJ6bz8mH4yjOBXVs6evQfBX1
         RT0A==
X-Forwarded-Encrypted: i=1; AJvYcCUWwRzEKTQtHRVKiCS074V6VdoF9AaX7lxyHrVYr83r/dhLXRiUL0yg0fcQwVqa4vQvoZn6cSvCt1c6mkMQ/Di0oz7h03yYDdTDOQJG
X-Gm-Message-State: AOJu0Yz0MXAgJaa7Wyw7BjzFacMM1J4e4L62YqIbd20R3Ik8E0+7Edn/
	TxZEIroJJW402TBgp4rY0xlOFzv/ti0UDo8KCGC+1keG6+1wyz+lIo5CvACFNkg=
X-Google-Smtp-Source: AGHT+IHDHRTrkO4CFMTeB0SmP/Wd2havgBGFo8IzqIkV5ET0LCgN/3ncN6rqzs7Vj0SBv8WfjQ70CA==
X-Received: by 2002:a05:651c:54a:b0:2ee:4ccf:ca4f with SMTP id 38308e7fff4ca-2ee5e3c3a6bmr66459021fa.31.1719922336700;
        Tue, 02 Jul 2024 05:12:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15788casm82487285ad.219.2024.07.02.05.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:12:16 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:12:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH printk v2 16/18] printk: Provide threadprintk boot
 argument
Message-ID: <ZoPullwnOGvUoCPv@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-17-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603232453.33992-17-john.ogness@linutronix.de>

On Tue 2024-06-04 01:30:51, John Ogness wrote:
> For PREEMPT_RT, legacy console printing is performed in a dedicated
> kthread. However, this behavior can also be interesting for other
> preemption models as it minimizes the duration of printk() calls by
> deferring all printing.
> 
> Provide a new boot argument "threadprintk" that will create the
> dedicated kthread for legacy console printing for !PREEMPT_RT
> systems.
> 
> The implementation is the same as the "threadirqs" boot argument.
>
> Users should be aware that if this option is enabled, the shutdown,
> reboot, and panic messages probably will not be visible on the
> legacy consoles.

printk() is _heavily_ limited in this mode. Users would see the
messages only when the system is running well.

I think that this is a _big_ difference against "threadirqs".
It still allows to handle some critical IRQ handlers directly
by using IRQF_NO_THREAD.

> Non-legacy consoles (NBCON) already have their own dedicated kernel
> threads for printing and reliable shutdown, reboot, and panic
> printing. This option really only applies to legacy consoles.

OK, the NBCON consoles might make it a bit more useful. But there
will be only one at the beginning. And it won't work with boot
consoles.

All I want to say is that this mode has big limitations
and kind of weird semantic. This semantic is basically
needed only with PREEMPT_RT.

I would prefer to remove this patch for now. It would give us
more time to think about the threaded and sync modes.

Or I would at least use "force" in the name to make it more clear
that it forces some non-default (non-optimal) behavior.
I would call it "printk_thread_force" or "printk_legacy_thread_force".

Best Regards,
Petr

