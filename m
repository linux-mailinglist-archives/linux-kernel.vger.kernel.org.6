Return-Path: <linux-kernel+bounces-420362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAFF9D7983
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 01:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C87BB21E81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BD72904;
	Mon, 25 Nov 2024 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAfTi2s8"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCD2376
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732495725; cv=none; b=O2MhRq0US7D3zF7ze+1jkFl38oA+vuHwRM1C/G+g3MLmT7taWZsn/mq/x3W0cUwOs5phbJS1oazx7AhqXBflKrxx/lvd1Xq60DQTK7dFzYWfAeiiT+6EwAEQxIpIRZ87yTjJPZ0b5Ee9IjT9MqTVhQ9XOaCXVn6J528HMlUiIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732495725; c=relaxed/simple;
	bh=77yKxkfFIKqm2tZqFTbUmu+3tbc09QJnytW4dcTsgn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiF6maiYf7N1CZHRAn7r/cAhCDGDNv2MT7OtFKuykJQmbdmRk0W8B7CU9o/qT4PrJXD7b/qBG0KTfHwSx+/5TOf8Hp2QO+SHaQ5PDymtMu25a1ECXYc4XVO64SidpcXejmXN5ZozzWkCBfDv3TbFkIP6TlXWlx/2k8oZqwTY0WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAfTi2s8; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so3350165a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 16:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732495723; x=1733100523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCewYiiX3qV81+XyqKLYZZ+03pJJgO4IjNKSetmN0yM=;
        b=FAfTi2s8MdUnYsgnGYSimKt4YwGRDOU1zAd76D8c8/W0FYwk9vAKHUyl6Ik5Sx36SK
         qhfqmO0KBw108wW/FBcZ5A9BzGNTlS5nObtB7OEgwmHMXcBm6gqtXShxN5gbNc5mt+ZW
         fHlPJQ+8BCLuREwHsAkqCtfwmnFwNzpcZao1ZWapzmlge7wsJmH2i4ZO52H3wIvtZkdW
         Ix+vZKU6THvBl0EPH6UwPLJNYHDWbTMB92yZbqGTCvGLDvWatzCnsYyp1Lit+CyZUvI1
         m5cqqV5ZAs4Vflzy8GPIPV6i+s8NlB7d1NYan1brjdnQxWkl9ts2JS5tf75JqxzA81Bl
         K7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732495723; x=1733100523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCewYiiX3qV81+XyqKLYZZ+03pJJgO4IjNKSetmN0yM=;
        b=tE0/LjOsI9rbyRdFshuCrjERhMU8pVAAsbN4OYBR2wrUXp1ho+7fuHY8o4MUMkwUem
         D7+vTVdL3Z/aJLpqB56XxPRbmBWeW00IIXT4k7D8fnlWuFexqBcd0Sbr+t7tkQRTBSOa
         bSX2j4O+qiN2nhOUFHnMGOf0iaXCT3SvVhAbBMs6ioU80OoK3Yi0EhStXLEdePAzFLi2
         L89dTfQrWyLwHBID8h3WDqfWn2Mcvq7w3OY395Eo9VGKiPazpVwMbA+Xcsx6lpZz7qmd
         ecAy7jCvkstxQUvVPfMORiqzCFAy1IqAEr6lwPUdHRe6jczTrnpG2QRgCNjcxVwz2NYV
         1SMA==
X-Gm-Message-State: AOJu0YyyM0FIt3I9y6uzPh3jp/7mTBckQodbflqIxbee01Dmj6Uwrige
	QSwGYrevmknQG5uvK58lkN3c7cROug/fjimagPNy32ToT5jIcV0e
X-Gm-Gg: ASbGncs0tjTh5Zase5fOWlWzen5eiRpMTTl76PH6laiQu9xAn+OYHTtH/KZLfPETWXX
	Neyh93zRyhldaZlZYtvOEPAqBOnpVCTf7i9JXkonc5cHyXSdO1RZ2gHg4dDGPY5Fud8ctyTKb6H
	AGwkVkP9blN22Rfmod+oA1Z6gMkTV6lAmY8+wWP/0MYTsl36hYN50uyrIsvvZaW5ct0jeiqYu8Q
	luZfAlRULixy4h8VRhjdqjk69aN3w3RdYH2UKKYeiRdMFrv5yDdVbrzTaZXV1g=
X-Google-Smtp-Source: AGHT+IHQLZsl1oxH+vBnf/0veuFJWSBaPWWwH32qqPyZHtsHwQsPww5BX5tlZsIylnAunlA8kr8NdA==
X-Received: by 2002:a05:6a20:4303:b0:1db:eb5b:be50 with SMTP id adf61e73a8af0-1e09e3cb546mr15661188637.4.1732495722814;
        Sun, 24 Nov 2024 16:48:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e565ba45sm4742985b3a.90.2024.11.24.16.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 16:48:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 24 Nov 2024 16:48:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <jstultz@google.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 2/2] timekeeping: Always check for negative motion
Message-ID: <387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net>
References: <20241031115448.978498636@linutronix.de>
 <20241031120328.599430157@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031120328.599430157@linutronix.de>

Hi,

On Thu, Oct 31, 2024 at 01:04:08PM +0100, Thomas Gleixner wrote:
> clocksource_delta() has two variants. One with a check for negative motion,
> which is only selected by x86. This is a historic leftover as this function
> was previously used in the time getter hot paths.
> 
> Since 135225a363ae timekeeping_cycles_to_ns() has unconditional protection
> against this as a by-product of the protection against 64bit math overflow.
> 
> clocksource_delta() is only used in the clocksource watchdog and in
> timekeeping_advance(). The extra conditional there is not hurting anyone.
> 
> Remove the config option and unconditionally prevent negative motion of the
> readout.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

This patch causes the kuda-bmc qemu emulation to stall. Reverting it fixes
the problem.

Bisecting the problem was a bit difficult. I attached two bisect results.
The first is on mainline, the second from timers-core-2024-11-18 after
rebasing it on top of mainline. The second log shows how the problem is
introduced.

Guenter

---
bisect on mainline:

# bad: [06afb0f36106ecb839c5e2509905e68c1e2677de] Merge tag 'trace-v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
# good: [adc218676eef25575469234709c2d87185ca223a] Linux 6.12
git bisect start 'HEAD' 'v6.12'
# bad: [6e95ef0258ff4ee23ae3b06bf6b00b33dbbd5ef7] Merge tag 'bpf-next-6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect bad 6e95ef0258ff4ee23ae3b06bf6b00b33dbbd5ef7
# bad: [aad3a0d084513e811233ad48bf234fbfcfcd0a14] Merge tag 'ftrace-v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect bad aad3a0d084513e811233ad48bf234fbfcfcd0a14
# good: [ba1f9c8fe3d443a78814cdf8ac8f9829b5ca7095] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect good ba1f9c8fe3d443a78814cdf8ac8f9829b5ca7095
# good: [9d7d4ad222aea8ab482e78858d03b10221c7fe78] Merge tag 'objtool-core-2024-11-18' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 9d7d4ad222aea8ab482e78858d03b10221c7fe78
# good: [035238752319a58244d86facd442c5f40b0e97e2] Merge tag 'timers-vdso-2024-11-18' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 035238752319a58244d86facd442c5f40b0e97e2
# bad: [e5cfc0989d9a2849c51c720a16b90b2c061a1aeb] clocksource/drivers/timer-ti-dm: Fix child node refcount handling
git bisect bad e5cfc0989d9a2849c51c720a16b90b2c061a1aeb
# bad: [147ba943024e564e89d9ac265d6a07a0d2c03988] timekeeping: Merge timekeeping_update_staged() and timekeeping_update()
git bisect bad 147ba943024e564e89d9ac265d6a07a0d2c03988
# bad: [f36eb171410839325fff9cd9b7b7400f7e606962] timers: Update function descriptions of sleep/delay related functions
git bisect bad f36eb171410839325fff9cd9b7b7400f7e606962
# bad: [9d7130dfc0e1c53112fcbed4b9f566d0f6fbc949] ntp: Move pps_jitter into ntp_data
git bisect bad 9d7130dfc0e1c53112fcbed4b9f566d0f6fbc949
# bad: [ec93ec22aa10fb5311c0f068ee66c5b6d39788fe] ntp: Move tick_length* into ntp_data
git bisect bad ec93ec22aa10fb5311c0f068ee66c5b6d39788fe
# bad: [38007dc032bd90920463c5d2e6a27d89f7617d6d] ntp: Cleanup formatting of code
git bisect bad 38007dc032bd90920463c5d2e6a27d89f7617d6d
# bad: [66606a93849bfe3cbe9f0b801b40f60b87c54e11] ntp: Make tick_usec static
git bisect bad 66606a93849bfe3cbe9f0b801b40f60b87c54e11
# bad: [a849a0273d0f73a252d14d31c5003a8059ea51fc] ntp: Remove unused tick_nsec
git bisect bad a849a0273d0f73a252d14d31c5003a8059ea51fc
# first bad commit: [a849a0273d0f73a252d14d31c5003a8059ea51fc] ntp: Remove unused tick_nsec

---
bisect on timers-core-2024-11-18 after rebasing it on top of mainline
prior to the merge:

# bad: [997be8ee5090ece72d32e0386400a3e0046d29c7] posix-timers: Fix spurious warning on double enqueue versus do_exit()
# good: [035238752319a58244d86facd442c5f40b0e97e2] Merge tag 'timers-vdso-2024-11-18' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect start 'HEAD' 'bf9aa14fc523~1'
# good: [820128b09e6443aa6e2fc4efa1488e6c6c9d41d6] signal: Confine POSIX_TIMERS properly
git bisect good 820128b09e6443aa6e2fc4efa1488e6c6c9d41d6
# bad: [3349e563d11aa9fdb957be9ccd1a3f0db771a748] signal: Provide ignored_posix_timers list
git bisect bad 3349e563d11aa9fdb957be9ccd1a3f0db771a748
# good: [6e882ecdf76efe3846d3d327c5e17f7ca1252397] clocksource/drivers/timer-tegra: Remove clockevents shutdown call on offlining
git bisect good 6e882ecdf76efe3846d3d327c5e17f7ca1252397
# bad: [5c6b73e3bf36c30005948f072e9d5d351db4d7e0] posix-timers: Add a refcount to struct k_itimer
git bisect bad 5c6b73e3bf36c30005948f072e9d5d351db4d7e0
# bad: [6ab61583280a183828024101549d69b28ca1be9e] posix-cpu-timers: Correctly update timer status in posix_cpu_timer_del()
git bisect bad 6ab61583280a183828024101549d69b28ca1be9e
# good: [1c4cf0acb9a94d3d22ae24ba5a22b9892bf6d025] timekeeping: Remove CONFIG_DEBUG_TIMEKEEPING
git bisect good 1c4cf0acb9a94d3d22ae24ba5a22b9892bf6d025
# bad: [cc9811d2b494c3e12bab01a79be8f2a0c16b32c8] timekeeping: Always check for negative motion
git bisect bad cc9811d2b494c3e12bab01a79be8f2a0c16b32c8
# first bad commit: [cc9811d2b494c3e12bab01a79be8f2a0c16b32c8] timekeeping: Always check for negative motion

