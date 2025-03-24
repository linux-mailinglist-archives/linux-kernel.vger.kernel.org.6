Return-Path: <linux-kernel+bounces-574283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E1A6E30F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2AA7A4565
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044C9266F1D;
	Mon, 24 Mar 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="LipMvCuu"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0893266EFE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843329; cv=none; b=fMnm+8WGhw4kBjnazWUFP1fP/ZgdnaDJPyGj+3V0aYgZ/CBWLirPp0jXZUdKYZKe1M2V2M29XbOH3v6bnBzRwWzSF2q5qREIklQcQ1wlyIHNE4cl3iOMbr9UVeAs8HkYp8kMOieKoZ3jp/TIUZZPCJB7a1WhkaGu7xvhtjfeK9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843329; c=relaxed/simple;
	bh=1rymG9tMU7d+EpOLvZQFkNyqfGP87y3hoGgfLC166/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvZBGz6b35Im3H0xmRj5TL7RKy4tjCOth6wfDSSoIpcv6itJgx2CcJKn5SncB9GX0fFl51/hWwbsyooaEgJ4IWk7RoAwMjyXF5ls6pR+j3WYMZ79FuSrnfKyqVgmDSopKwTBtiLy8GhQSCBZlCZwDeT7maEcLtajXb11mSrjzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=LipMvCuu; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4768f90bf36so46213401cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1742843326; x=1743448126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1dTQfcrbRLKQGYdsmVW0rTSaepqHTuYnIg8Unhl8ec=;
        b=LipMvCuuqAVFW/ay6G7/+fSJxc6SfY4PY6zXm+Vs9uIRu1FoBWfbjXGTdGz7jzspUb
         CMHZ9FygTiMqIvHgd6MQl5bvVm191GCzO9VRcTKOkaCon60HWVoM4tCsmOnmiCuc/jOe
         flhJvb6RV3o1qeYCJnRtgl0/s25v4MqjWPI9jqZp+PhkyVMPz3bem9tSi/S9ldO2HgRO
         tCab37lZEGNaTbWiZUlOl57IB9KVCfxUzlqHME+s+T+HHMazu0OVE7ijp8471oMpF0Zm
         KYV7qwLnIm+JWCW3e0xq/g8aCEnK4XAXvBnJIcmA4WJbr5XkO4thQhgT1cu/gqOAWUTg
         eqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742843326; x=1743448126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1dTQfcrbRLKQGYdsmVW0rTSaepqHTuYnIg8Unhl8ec=;
        b=JAtKW8JZQNpIs1mNaDoRrJB3dWPNv2x27qqkGVpVZ7BQ4ED+b8YU9fk9ifSMLtHbfs
         4dlx8/hUfNdAFFUTYoPdytSYWdHo3mVOfyWzlgJP6frIEVKKaAE0Ykd9jrxp5ePPAlbu
         01MBaLIeAEqcFVOtqY7CZsWWS9VQM4HP7QyHgRDTiEscgY93BgpfqyGxA+dYW7NSMoB/
         Ot0loZnx9yGjcxQw850HEij6ds4C+jfAPK+uqwXX8QEsl4jtV2lvgfnkyTzJSd9tU0b5
         hbVfEKY73YZCn2vbJG6S5QSCIWAfSINWdkpUxBMcmhyGdDzuYC6W4n5X95oqKwbtU6uO
         wYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWORCXMt68itLRldAGhY+unU6b2AirCZKsAOwttEuQ0jHh8LSIWIi4G8vHxZx8dupyXwR2wl3wtBD+izAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2DCc/klmBmvLcYRXJ+OuAO8qWCGBhlqCml7YtugSRmKW2biOL
	/tbQNq2hmK1tGzp8M5+u+ujdReaFhwjU6aWmD0ulDzokKIpu90oWZ7yuoHwW5JdvQneN/msF7cQ
	=
X-Gm-Gg: ASbGncsTUeqMROSS+DyIZct5cB8bBzEqiAnSa4e2WNyO6cHJYLDNlBphLHI7jnoUOkn
	3DVVXEokbpZrfEs1PSAmBj+++EYtYbx17ygfecrepSW5FR+e8clUmhTVT8rYeX3hHgtg8J+73HS
	1R5FMg8MVEkT3npc5VUxfMAdDWf+oqCL0ROU8nLoldh8w6mXR4rcB5qtmGAh6Jor2voukugkEWV
	r7R2Or9lArQkHxEZMPQDW2FXS+gdaHP+s/bR3RO4+4WBgbbJV0LjBSKeLAGvgDPRRwCnr6evr8z
	VPqeBkBG8DHFG2ooGGDTnsQcc+303lkVOM3FZuHY8hVpu5ZnWwYYl+RQTtFltnVZNV6ebji013n
	M82LNgZKEGDJuTK+whYmybXmMitUHZxi/e4Hfnw==
X-Google-Smtp-Source: AGHT+IHHVjLyxs4xugjYg38o07zQ3r4VavLlX0Whe/aSGbbSEHsuX248QsM4WBhcDUcE3xWJGlSOXA==
X-Received: by 2002:ac8:5ac3:0:b0:477:1f29:e80f with SMTP id d75a77b69052e-4771f29e85fmr239847391cf.4.1742843326471;
        Mon, 24 Mar 2025 12:08:46 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d159a42sm50755791cf.11.2025.03.24.12.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 12:08:45 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:08:42 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+c38e5e60d0041a99dbf5@syzkaller.appspotmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	linux-i2c@vger.kernel.org
Subject: Re: [syzbot] [usb?] WARNING in dib0700_i2c_xfer/usb_submit_urb
Message-ID: <acfa19a7-9d24-4cd6-9d1d-580a9ac7473c@rowland.harvard.edu>
References: <67e1a1f5.050a0220.a7ebc.0029.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e1a1f5.050a0220.a7ebc.0029.GAE@google.com>

On Mon, Mar 24, 2025 at 11:18:29AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5fc319360819 Merge tag 'net-6.14-rc8' of git://git.kernel...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15445e98580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=27515cfdbafbb90d
> dashboard link: https://syzkaller.appspot.com/bug?extid=c38e5e60d0041a99dbf5
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ea4c4c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15435004580000

> ------------[ cut here ]------------
> usb 1-1: BOGUS control dir, pipe 80000f80 doesn't match bRequestType c0
> WARNING: CPU: 1 PID: 5901 at drivers/usb/core/urb.c:413 usb_submit_urb+0x11d9/0x18c0 drivers/usb/core/urb.c:411

> Call Trace:
>  <TASK>
>  usb_start_wait_urb+0x113/0x520 drivers/usb/core/message.c:59
>  usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
>  usb_control_msg+0x2b1/0x4c0 drivers/usb/core/message.c:154
>  dib0700_ctrl_rd drivers/media/usb/dvb-usb/dib0700_core.c:95 [inline]
>  dib0700_i2c_xfer_legacy drivers/media/usb/dvb-usb/dib0700_core.c:315 [inline]
>  dib0700_i2c_xfer+0xc53/0x1060 drivers/media/usb/dvb-usb/dib0700_core.c:361
>  __i2c_transfer+0x866/0x2220
>  i2c_transfer+0x271/0x3b0 drivers/i2c/i2c-core-base.c:2315
>  i2cdev_ioctl_rdwr+0x452/0x710 drivers/i2c/i2c-dev.c:306
>  i2cdev_ioctl+0x759/0x9f0 drivers/i2c/i2c-dev.c:467
>  vfs_ioctl fs/ioctl.c:51 [inline]

It appears that this problem was caused by the fuzzer requesting an i2c 
transfer containing a 0-length read (I2C_M_RD) message.  The dib0700 
driver translates this more or less literally into a USB read request of 
length 0.  But the USB protocol does not allow such things; a 
request of length 0 is always a write.  Hence the WARNING above.

As far as I can tell from the source code, the dib0700 simply isn't able 
to handle 0-length reads.  Should the dib0700_ctrl_rd() routine be 
changed simply to return 0 in such cases?

Alan Stern

