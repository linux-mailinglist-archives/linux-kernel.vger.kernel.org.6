Return-Path: <linux-kernel+bounces-410080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E1E9C9646
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1501F227DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B471B4F21;
	Thu, 14 Nov 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lxpxzRH7"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5E1AF0AA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627714; cv=none; b=id2xWPR1Yi/ZcbqrbX25wFQB4pjwhyXQGY6DPMkt93ktGOa5X4e/Jhg+ZlaAZqrXaY0SKoSxQpX8i3RqR//h1oSiO7/9W+wFMLOzk2QQfhRAYxaOMg7FilGDTmy2Of8I8dJBVFsblWxHC2fE+KdHgmgWEIktCmHOO3wrQq92XXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627714; c=relaxed/simple;
	bh=kZ5epRbgKZ6233Ap65Xnl6vzoB2UfCoHzYBeuVIZIO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy9+7AgPYjFJNRici02dxm4pdHN4z89oaRFth0F/ERs6KgJtKCBtEIUrlqM+qI99sAv7IUpUk6f4WsNH3C7i5uOJQlYG/3vE67R/mfJAjGgS82Ws4eAKb90yG4nv75Q07l0kzITNDNSkI1YoGP+6acEPd+apo9fsRTRx+PdF1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lxpxzRH7; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Nov 2024 15:41:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731627709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XGno1wzgEqV1HjDJxj9LHzlYSckAa8qAlmfgXnpAYiI=;
	b=lxpxzRH7YHlU9JZigMCrAD4rc1j+I82rtFNeiX2onDLGHNiW5TctQ/EXB1fi7t0ow3U4mS
	x6PLEj7hijpjZwIfhJfs8umi4eRva+moQbTrnVflibJa41FzfCGgfkpPSwAoU0TWStkw/8
	rcMLueG4oVxGpPDL2ZJFbrIcy5hVXWs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: syzbot <syzbot+4727d10d6a805738b0f2@syzkaller.appspotmail.com>
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com,
	syzkaller-bugs@googlegroups.com, will@kernel.org,
	yuzenghui@huawei.com
Subject: Re: [syzbot] [kvmarm?] WARNING in kvm_handle_mmio_return
Message-ID: <ZzaKsQ7-mqK78BdT@linux.dev>
References: <673634e0.050a0220.1324f8.009d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673634e0.050a0220.1324f8.009d.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 14, 2024 at 09:35:28AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1393335f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0d77fb8077b4744
> dashboard link: https://syzkaller.appspot.com/bug?extid=4727d10d6a805738b0f2
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1793335f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144ff4e8580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-2d5404ca.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9fafeb95420d/vmlinux-2d5404ca.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/498f7a357ea2/Image-2d5404ca.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4727d10d6a805738b0f2@syzkaller.appspotmail.com

#syz fix: KVM: arm64: Don't retire aborted MMIO instruction

I sent out the pull request for 6.13 yesterday, which includes this fix [*]

[*]: https://lore.kernel.org/kvmarm/ZzWo7_GSUNXe7Ip_@linux.dev/

-- 
Thanks,
Oliver

