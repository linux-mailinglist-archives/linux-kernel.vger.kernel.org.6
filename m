Return-Path: <linux-kernel+bounces-294283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB05958B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FB428853E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C305194094;
	Tue, 20 Aug 2024 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VEvZny5t"
Received: from mail-m49245.qiye.163.com (mail-m49245.qiye.163.com [45.254.49.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE7179A7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168865; cv=none; b=coOfupDLRyLOI4jzJJucJhRX/BuYkCm2FElkAwZ4/jgj5pNKm1VylPK5UzAWsftV1dVl0xAYLLv8eVdSHVdywDXnu/79B87L+RA82KHRhylzTPHiV4ll9cNvnv1k2vSdu1tEWfsYzx6AFPZOikOEDcg+PLHtCeH5UHGbK4YtxsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168865; c=relaxed/simple;
	bh=NFixkqEq5u9J3OZGZyFpT1sem5zAhhhtcMXvrK77k4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMcYBk34ggyT36TP9L0wy+Xi9BqUGC4jJfzoQmE44IwTixQFbIx7mdRUDAYXokmyHpK/Xz4SYAFa1U14XlUCvPeWv2iMEmqCdZkp6i0+akNVBtgHUANAq+idMzmZgJSMV/zn6NLSN/wNh+KQEs01C3y9FwH9h5nG6T3DztIQyME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VEvZny5t; arc=none smtp.client-ip=45.254.49.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=VEvZny5t2PFktgZagkfz73Qca0BvjD6zl5bmc8dYduh8R8WFwSp8rL7MRn+GNcapmQFgmqN2KSFxWrJU7zfVn14rnAUPsbGk0XDAtnkKPDvuee7NiLRN6epAx52+KqQVYVpBuj084kVSdjMA1B6TwGq4dwnqHG1Z3QJfNcB2LLk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=jRtqTMqqfKD8sE4muKg4BLmPLxPC5az11Nkd+ZieOS4=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.69] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 43705840A33;
	Tue, 20 Aug 2024 14:20:05 +0800 (CST)
Message-ID: <c5b252a7-4b39-4a93-9e2b-e79c7598b2ee@rock-chips.com>
Date: Tue, 20 Aug 2024 14:19:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] regmap: maple: Switch to use irq-safe locking
To: Mark Brown <broonie@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>
References: <20240814-regcache-maple-irq-safe-v1-1-1b454c5767de@collabora.com>
 <4a8c9f85-3785-4cbd-be9b-dc6da9bd7324@sirena.org.uk>
Content-Language: en-US
From: Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <4a8c9f85-3785-4cbd-be9b-dc6da9bd7324@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9KS1YZGkNNSUJJGk4YGUxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
X-HM-Tid: 0a916e7150e403a4kunm43705840a33
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxA6Ayo*TjI8NDYCHAM9Di0o
	Gj8KCkNVSlVKTElPSkhPQ0tNT09IVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBTk9MTDcG

Hi Mark and Cristian,
also cc Sasha,

On 8/15/24 03:04, Mark Brown wrote:
> On Wed, Aug 14, 2024 at 01:20:21AM +0300, Cristian Ciocaltea wrote:
> 
>> Commit 3d59c22bbb8d ("drm/rockchip: vop2: Convert to use maple tree
>> register cache") enabled the use of maple tree register cache in
>> Rockchip VOP2 driver.  However, building the kernel with lockdep support
>> indicates locking rules violation when trying to unload the rockchipdrm
>> module:
> 
>> [ 48.360258] ========================================================
>> [ 48.360829] WARNING: possible irq lock inversion dependency detected
>> [ 48.361400] 6.11.0-rc1 #40 Not tainted
>> [ 48.361743] --------------------------------------------------------
>> [ 48.362311] modprobe/685 just changed the state of lock:
>> [ 48.362790] ffff0000087fa798 (&mt->ma_lock){+...}-{2:2}, at: regcache_maple_exit+0x6c/0xe0
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.
> 
>> The problem is that the regmap lock could be taken by an IRQ context,
>> interrupting the irq-unsafe maple tree lock, which may result in a lock
>> inversion deadlock scenario.
> 
>> Switch to use irq-safe locking in the maple tree register cache.
> 
> I'd have a bigger question here which is why the driver is using a
> dynamically allocated register cache in a hardirq context, especially
> with no defaults provided?  Anything except the flat cache might do

Do you mean the current code we call devm_regmap_init_mmio in vop2_bind function ?

> allocations at runtime which might include in interrupt context unless
> the caller is very careful and since the lockdep warning triggered it's
> clear that this driver isn't.  The core will be doing atomic allocations
> for MMIO but that's not something we want to be doing as a matter of
> course...  I would generally expect drivers to try to ensure that any
> registers are cached outside of the interrupt handler, usually by
> specifying defaults or touching all registers during setup.
> 
> Without having done a full analysis it also looks like the marking of
> volatile registers isn't right, it's not immediately clear that the
> interrupt status and clear registers are volatile and they ought to be.
> None of the registers accessed in interrupt context look like they
> should be cached at all unless there's something triggered via the DRM
> vblank calls.
> 

I think the interrupt status and clear registers should also be marked as volatile.
But this is not releated to the current issue, right?
> It might be safer to fall back to the rbtree cache for this device since
> rbtree doesn't force an extra level of locking on us, though like I say

I also think fall back to rbtree would work. I had a similar thought the first
time I encountered this issue[0]. But i try to  keep maple tree as is based
on a much more modern data structure.

> I'm not convinced that what the driver is doing with caching is a super
> good idea.  Though probably what the driver is doing should work.
The registers of VOP are quite special: Each write operation to the register
does not take effect immediately, it only take effect after the next VBLANK if
we write the CFGONE register.
So we need a cache to record what we wrote to register before.

> 


[0]https://patchwork.kernel.org/project/linux-rockchip/patch/20231217084415.2373043-1-andyshrk@163.com/

