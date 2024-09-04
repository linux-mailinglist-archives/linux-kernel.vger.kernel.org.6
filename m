Return-Path: <linux-kernel+bounces-315166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2297996BECA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DA31C22092
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48F21DA10D;
	Wed,  4 Sep 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FC/q76K4"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAC1146013
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457232; cv=none; b=e91rSjvJThjDv9aOyGbI8ztlL6b5Hwh+RKclqqwmhLUdPRUXE4KquJ9L6bU3VMw1ZNKWIircGaC1ma6plbPuG7AhvwXxmWg2aEiG7044iWfK/NTq59/sZEzzPncMRmFscwrU9ZPD7J0mvuC0vsShwmTqeGeOMMvKm2nxPbSVP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457232; c=relaxed/simple;
	bh=smYfVoz7HyehkJ4N7rG+pBZnCVpUUJJwaDrypw5jitg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpK86REPyk68Ni9W1Esw0ITuz8ZR7zgaWAQSWlqHUxCKBcCtTpfEgRhaN5PKgAswjghyMrhkJIHx+grxmSk8dzS4QkXwHXuosrmKiDskZ4Z/6okX4NivhzHFWNtP8SlTtpv1ibPvl5X2a1q+4YjoICR45gOkI6R3xq44/Vx3h1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FC/q76K4; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334b0e1a8eso8506985e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725457227; x=1726062027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMJbwGEh7o75QMe3HUfiS3CBt3fybw9kBaRE2c9lu9o=;
        b=FC/q76K4KrnbR1bTUP704O3X70zpF2K5EHbA/w7FfmLk2Zs3zdJHOikQsEREaSjDeH
         R6vZc0tQrZqqKf24V2BPJpT77Nxys5eRz6JgWbdONWw/2oixy/Ujv8WbzrC05LtPS2Iy
         rZDs/0VH9Df5EJwJHiCi/rR/QDFJdyRuEDtfCNQV6NIF5rL/+l9elsTTG8426gp00INl
         avi1j+8VDbAZ1aD5XqnwElcnYiUsGH4eUylqHunvFtyThpnGgXi67J1VLLjq39iaXwxm
         sqW2fFvDqQDqLI1hqPvU3hVJMhHjSei42dX6jHfk7uH/864GZTGnr623Y8nQFW7eATDa
         29hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457227; x=1726062027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMJbwGEh7o75QMe3HUfiS3CBt3fybw9kBaRE2c9lu9o=;
        b=LxH1Za43p9z9lHdwMfUjq9/0frbPRo152cdit/Q8/RHYoxCXab9foIlX2Z4J7EZtCI
         gTrunec5Jb9JpKwaZJ5SXStTDQq/885n7BUnVHFORjs7go8cGzeQEgcMm7z+pp9OX4fg
         C3y9cgmN5DFFkP5YQq+D8MzORN2+zzSE460OB/UDcus2LDym2ZfYvWOB8z5vIK96qGtN
         6SzODuxP4LTRbKmFDZItdja1B4sFfV1S7gZBzLVl4BybbrfInaqr12eJj5JG8l7yafD7
         dcAAFAORVPwIjzZhUn+aOI1WMqMuaunL2dP8tye3y9+1HiPByo+je3b2V+Mxg26ONf60
         lSsA==
X-Forwarded-Encrypted: i=1; AJvYcCUw4Qjd8LvXlyxEr7VpaG4IYLGin+LIVIq5eiiqynGounqXAEi5zJDx/XhgSIJQ8r0qMSsvZGFvhq+nDao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxORQI/H0uttexnSIeK8SE7shgBfaB1Qr8fw98IkOvMnW8zOaAf
	kjuSF3zF/ZqSoGKWtxJO/DMzCNxUirVp5TAKgzk3VnrDlkQjqv4n7aQY1HM3WqvOMZtlwkUOQO9
	T
X-Google-Smtp-Source: AGHT+IEGhjSZVySOEp3M20nDxmQFdacE6nb4j813qlgWvw3Evky6hajhjS8FMI7o+SCLuqCJ+4iBdw==
X-Received: by 2002:a05:6512:1154:b0:533:3268:b959 with SMTP id 2adb3069b0e04-53546ba8fe9mr10895257e87.53.1725457227090;
        Wed, 04 Sep 2024 06:40:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a3e78a386sm95514566b.158.2024.09.04.06.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:40:26 -0700 (PDT)
Date: Wed, 4 Sep 2024 15:40:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v6 15/17] printk: Implement legacy printer kthread
 for PREEMPT_RT
Message-ID: <ZthjSaN25qGud8wr@pathway.suse.cz>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
 <20240904120536.115780-16-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904120536.115780-16-john.ogness@linutronix.de>

On Wed 2024-09-04 14:11:34, John Ogness wrote:
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

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

