Return-Path: <linux-kernel+bounces-296106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EADE95A5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C054B220A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3AA16FF2A;
	Wed, 21 Aug 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VNTU/eEH"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ECB28DCB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271222; cv=none; b=VIqgj27o5vN4ihiZyz23bT0s+Eq/bkpTfAVmKtctmJwvc0dj+85DqvPiQcV7lRaL4K5UykL8EIG6RhEt+gsDikXD01fuWE0IAGxZgbVnSI6PvQIMD75h5Inb/9HW+hbXUdKFRhQ37AzjAV2uUEK9XkFe82etahA0zptu3VFnth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271222; c=relaxed/simple;
	bh=LURSiKjo2JQN9dRGWFRkWt6N1bvrp+X/h+jx6sqK4L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+ORTNSYHvspUDQEVKszL5L5ECq9ND8Cnjri87GpC+WbMiT+mJG/HyzaObK0OWXufIPn7rh2pUea93LghT8+6NVZV32XxuilJppvmhO8fIVZzkoQup26KVa+qxzZmXcoSXq+phnEnavwrwmdZ11T0cYZ5AqsIKQx7V6kO2dU//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VNTU/eEH; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e13c23dbabdso118413276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724271220; x=1724876020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYmNcsedkOqUFLEQeKe1yqW9pGRfFKO4juWfk6FKFmU=;
        b=VNTU/eEH94wpXyGmPB1BdqE68+dwIk+Ck91tBIZz89QN/TAWRgFxnuLjLh8CWAygFd
         Oc5YbbkTAbBBiT3owI6CPH9jSCEM7/xk2Qa0L5qhjygcOgynDVKSYXVqTvx2Bi0/g+Ur
         2Rzmk+xxYtV5uNvkYoWCVcM2V9LpuO12nvIjtT+AudVjwNgRee3l7cDbSqzazsS+E4lU
         rd6ZQ7yNtfi9ng02gkbBc1ufcPxkHvWiWNEMedQX4FQ9YiZ05kW3L0WvqpVwide7o1CE
         D1lZ8PGdH5KXd8t/Cc1rPE+IkXnVAzfcYvem9QLRt56kA7epJB9I8pOC723Jf04zFtGg
         HFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724271220; x=1724876020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYmNcsedkOqUFLEQeKe1yqW9pGRfFKO4juWfk6FKFmU=;
        b=P3dIrKf4QYwUO3aFKhwOUSl7mTv2uu/tgq9ToT4aBm4x4wkrBtxxZBzIdS7v5ioQoV
         n8B7VT5OzB7zaDG+6/GBgKkhlGYyqj8Vdq5oMKUrtdaLc4F1ol4PrtPOn2W47aYLT00Z
         sGu+PatB7XnRM7EQ3YI6xyeSOcth2jtdmUcY6pixztgxohonVvDBewOleiX/b8+19MDn
         VRoBkCwRgUr0HTAD5W7yv/2AVyPQOEtPO1s5kpGj1MOL82l6Z2BNvAE2KaTIkyIjXOmg
         zoVzOzm6aBkwe9tL1ELJctIi3mFpwJwRkXhA1AunFPuxOcSuia1sUNSBMiP78fiwKkjA
         dU4g==
X-Forwarded-Encrypted: i=1; AJvYcCWPSyMHBeVXvH7W4Nd1QewV9Vth8WTphzfOKbYG4wgiM4j3N3dskPrJH19Jxe1C/i2rgi8xy6ucwZTBu+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGYJmvHjMCTVqgvMqZmY0otrQNvk1p+eQYBFQ3/9kmpruJj7Y
	d1qk6FeYL5JNrIWiLPYoWlcFMS3YUe1ScGLEySkJih9BzeSUrQS85WJSrTyfY6E=
X-Google-Smtp-Source: AGHT+IGx0uv0WJiwFWZKjviM9+GmZlu0vQylW48VVx9PfvDLz248cWEULf/z5v0Gbzu1ZFB5VbSdUw==
X-Received: by 2002:a05:6902:2508:b0:e16:4d32:adcd with SMTP id 3f1490d57ef6-e166549c3damr3770246276.29.1724271219864;
        Wed, 21 Aug 2024 13:13:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e67e660sm3818276.54.2024.08.21.13.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 13:13:39 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:13:38 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: syzbot <syzbot+dfb6eff2a68b42d557d3@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (6)
Message-ID: <20240821201338.GA2109582@perftesting>
References: <0000000000008f55e4062036c827@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008f55e4062036c827@google.com>

On Wed, Aug 21, 2024 at 12:45:25PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5c43d43bad35 Merge branches 'for-next/acpi', 'for-next/mis..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=13471a05980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c91f83ae59feaa1f
> dashboard link: https://syzkaller.appspot.com/bug?extid=dfb6eff2a68b42d557d3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10efded5980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e94093980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cc2dd4be620e/disk-5c43d43b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/81d40d99ddbf/vmlinux-5c43d43b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bc6aed0f2bc5/Image-5c43d43b.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/d55321fffedc/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dfb6eff2a68b42d557d3@syzkaller.appspotmail.com
> 
> BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

Can we disable syzbot issues for this specific error?  Btrfs uses lockdep
annotations for our tree locks, so we _easily_ cross this threshold on the
default configuration.  Our CI config requires the following settings to get
lockdep to work longer than two or three tests

CONFIG_LOCKDEP_BITS=20
CONFIG_LOCKDEP_CHAINS_BITS=20
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12

but there's no way to require that in our config (nor do I think we should
really be able to tbqh).  It makes more sense for syzbot to just ignore this
particular error as it's not actually a bug.  Thanks,

Josef

