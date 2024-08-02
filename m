Return-Path: <linux-kernel+bounces-272515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3452945D61
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589201F22229
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601C21BF306;
	Fri,  2 Aug 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KvoHxjvp"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A451C2327
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599142; cv=none; b=O9xphwce/lH5kvAhWlBIryjCl20K2mguihYlcxdYgCxqlLTn6jTbncGZPVnDW8sDZkOXuRxhoGOh6Qj2DARrWRYmMlX7+t9CU+Ngy/S7mG1/vXZMBDKoDuXV3zYQ21fbmey7tS/M7aM0o7Q0WdXG81p65QsYh40hQdKSK70Ca4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599142; c=relaxed/simple;
	bh=r+Q6n0C7hnbdyg0+yVENtcImM05kHosJoktajbB/50c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1y2oZCu419lH5PPF6u4GTT6mjOuZY7YWHhl8IegCckJnF6gSN3lMI8bMBdmVCVMZ5p4AgKMj9O6ng8HLQbMyQNbvWp9Ax6gD+my2iHODp04Bbxt/ZE64MH55+X0l0nOc8lmz7yxpbgYaRgE0hsfoX0WJSRV3vn3aht/FJSZ4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KvoHxjvp; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so7352050a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722599139; x=1723203939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7+zc65fFX4hU5vFPm41Q7JMlQqRnYszM97Fhbtr8Do=;
        b=KvoHxjvpesMC3aXUV0O/JqXD9DvK1pfaeDmgZaeieO/spUwkCSTSS0XRBtR0s+bt6Q
         OKKdhHG0jaP4dQFfEm3Ht2JOvWIRpm7qi1xUURh/DrwLQ8dxKr/yTUxsNEX2hHnPiSlf
         B/IGCWlsOl854rf2KAkh9ryP0VUWsWWFYX47B3YbXTtroNoG90Q0cOVzSgelCIKfgBwf
         d3QXIYTnAJqntlOse8EIWCEGPmG8srYeC18CQ2PV5RwAq4C3z4LIskLgJy2ZRgTK/jE0
         nQoQ5IW+RpIoaSt3Yd4uRkfrnHekyLHF3hqLf3VtxJlk9tfkv1TNpHWL3mFesIaxd31o
         2L5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722599139; x=1723203939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7+zc65fFX4hU5vFPm41Q7JMlQqRnYszM97Fhbtr8Do=;
        b=wR1by3M24m5FWBobzVnuRN1HBosns1m9C16H/TE7FsDHK9LunHRRQI9Tpdqcwxk1Sx
         u35nsZwkBpFAgWMmhs2zaNu5fwRQTqprLPyC8GTgZB8kK0dehENhhmqqSlxf9hhVk50f
         rzIiOmU7pKcbru/m2LGM8i2A3h5vQO6Fl+NdhzyCgn+elpnHW1BUQM4bsyQlx5eHzW0Q
         F4DP38osHcztXFzAeQdCr4AkUOulXLs/bYEVHXN+ehXGKnRMDaT1SzoIVOmkbMoDkiLP
         tUwyiQYkaL1Uehaan/hE1DGcSRKkbvMhsLNY5WygFfEJGmxFGnda9+M+Xa3HAN6CQGz5
         vU3w==
X-Forwarded-Encrypted: i=1; AJvYcCXhLWbHkhkKl6oE8MIXoHQ01SoLqWABoY5dbfYEHO2F+Rdvpk7+7NykNpOEA8faGX17auwkWR6ZlxN2AbYhEeBpqa25QEVI52GH9B/W
X-Gm-Message-State: AOJu0Yzv5OJ3YaW3SKsv7OCDl0oA1VK/dPCUYKq/rYfg1i0Z+/xsMCYP
	2rGJ/b/zRaZwIUNkH5F04SEKhRLRARBSqb8juIopg416KFgz9YPqTtqFV5ygsY0=
X-Google-Smtp-Source: AGHT+IEN4aPRsxPQvxljjfJvsv/1QQSADS7/TrKN1jiTH6RvqFqO357LsFt70AQoP9aMPIThal5tQQ==
X-Received: by 2002:a50:eaca:0:b0:5af:5342:c5bf with SMTP id 4fb4d7f45d1cf-5b7f540a6bcmr2655588a12.29.1722599138732;
        Fri, 02 Aug 2024 04:45:38 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b82c16dsm1013298a12.76.2024.08.02.04.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:45:38 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:45:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 17/19] printk: Implement legacy printer kthread
 for PREEMPT_RT
Message-ID: <ZqzG4Ajcm1Prrsnx@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-18-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-18-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:37, John Ogness wrote:
> The write() callback of legacy consoles usually makes use of
> spinlocks. This is not permitted with PREEMPT_RT in atomic
> contexts.
> 
> For PREEMPT_RT, create a new kthread to handle printing of all
> the legacy consoles (and nbcon consoles if boot consoles are
> registered). This allows legacy consoles to work on PREEMPT_RT
> without requiring modification. (However they will not have
> the reliability properties guaranteed by nbcon atomic
> consoles.)
> 
> Use the existing printk_kthreads_check_locked() to start/stop
> the legacy kthread as needed.
> 
> Introduce the macro force_legacy_kthread() to query if the
> forced threading of legacy consoles is in effect. Although
> currently only enabled for PREEMPT_RT, this acts as a simple
> mechanism for the future to allow other preemption models to
> easily take advantage of the non-interference property provided
> by the legacy kthread.
> 
> When force_legacy_kthread() is true, the legacy kthread
> fulfills the role of the console_flush_type @legacy_offload by
> waking the legacy kthread instead of printing via the
> console_lock in the irq_work. If the legacy kthread is not
> yet available, no legacy printing takes place (unless in
> panic).
> 
> If for some reason the legacy kthread fails to create, any
> legacy consoles are unregistered. With force_legacy_kthread(),
> the legacy kthread is a critical component for legacy consoles.
> 
> These changes only affect CONFIG_PREEMPT_RT.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

