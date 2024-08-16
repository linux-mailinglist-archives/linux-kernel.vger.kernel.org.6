Return-Path: <linux-kernel+bounces-290284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075C39551C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42416B23146
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C951C4630;
	Fri, 16 Aug 2024 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="gmjtW+Qc"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938211BDA8C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723839117; cv=pass; b=mj1MtLTvcKVWcvtLJjYd8LyJA8UYpxTZ16kXeBGfLeNFbDFax/SmQtL4qKKQpxcDOZmtLtUSe0GtSZ6W0AsHeHGHoGJxzL1uyTZw3A9DzzkOmcZPHHclf/8zgomM1jbrvS2LfBE0bT/UnPD3roRXXheNSDucS4rmobNIcwa9cPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723839117; c=relaxed/simple;
	bh=5jSdaseODLxprLn/5g7oz80qKCqir9JPRFdfZgmSoH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=in76pql+txph++sAJe3y5u2yJ9iLiOXfLnIj2kTY2YupLqsPz/mZGJKlj4vUqoM91foHTkC0kD4WNTWTO6Uiqzh4cvFru68+aXlQP2TphocDfDdzNTunxUn8RFQ9QTzV7n1TuBtLjl4fgVCq6JVVWXx9+ejp/CSJj8Kmrb8hkes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=gmjtW+Qc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723839093; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K9dDzFuVzSwzPJ3U6GZsseJscm4NPX+V2CxGomcoL++GXAKec3+1nDsZrq8b0MlA1XMiJ7T6FKKj9S4d1fcfKZSnHNIr39V6nQ/d2NNf2rA3sHTMClgVesirbeam0wdYZ6AYeDU59iEKfEOH8priL7CT8jpFJ+LVZMs0XDrysqU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723839093; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xbMw+FjqjctWYRGwhTvERYdzOW8pPOAeEpavfgfPgDg=; 
	b=JDZf+Ww8T+icLEXDeZ2TVNvnMsi28+mV857a3Qk0AJsAEGXRa8jW2GPsWJ0k1pVJ0lQ0+wevOQbdxc6S+knPBjAG8W0+7hnMJKXel8nK0UARf6sF+av3motrxKa1n9WZgD4884vIXoj/bkfxxMK8+fN2xMZC605TOH0cAyCqp90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723839093;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xbMw+FjqjctWYRGwhTvERYdzOW8pPOAeEpavfgfPgDg=;
	b=gmjtW+Qc7lENOTWHzu2CutO5iSYMGncFCDJsdP7kVg/MhPv9oCz/PS/Og4bfSBEx
	xyikEmGOcb7ualtyAvEtzJb01Gb7qzqf9MnY/aFYGL6FTC7B1zMXpTBmz9WMEEROi1r
	si14fhVgoCluCobyteQZ/6VGVm/e0XfdPhebgoCU=
Received: by mx.zohomail.com with SMTPS id 1723839091084928.364721398085;
	Fri, 16 Aug 2024 13:11:31 -0700 (PDT)
Message-ID: <9cb322ba-4c08-474b-bdc2-d21cc1904ecf@collabora.com>
Date: Fri, 16 Aug 2024 23:11:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] regmap: maple: Switch to use irq-safe locking
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20240814-regcache-maple-irq-safe-v1-1-1b454c5767de@collabora.com>
 <4a8c9f85-3785-4cbd-be9b-dc6da9bd7324@sirena.org.uk>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <4a8c9f85-3785-4cbd-be9b-dc6da9bd7324@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/14/24 10:04 PM, Mark Brown wrote:
> On Wed, Aug 14, 2024 at 01:20:21AM +0300, Cristian Ciocaltea wrote:

[...]

> I'd have a bigger question here which is why the driver is using a
> dynamically allocated register cache in a hardirq context, especially
> with no defaults provided?  Anything except the flat cache might do
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

AFAIKT, all registers accessed in IRQ context are volatile, hence the
register cache should not be involved at that point.

The deadlock scenario indicated by lockdep actually points to the lock
acquired by regcache_maple_exit(), which has been triggered during module
unload operation, and the lock acquired by regcache_maple_write(), in the
context of vop2_plane_atomic_update() called within the DRM stack.

[   48.466666] -> (&mt->ma_lock){+...}-{2:2} {
[   48.467066]    HARDIRQ-ON-W at:
[   48.467360]                     lock_acquire+0x1d4/0x320
[   48.467849]                     _raw_spin_lock+0x50/0x70
[   48.468337]                     regcache_maple_exit+0x6c/0xe0
[   48.468864]                     regcache_exit+0x8c/0xa8
[   48.469344]                     regmap_exit+0x24/0x160
[   48.469815]                     devm_regmap_release+0x1c/0x28
[   48.470339]                     release_nodes+0x68/0xa8
[   48.470818]                     devres_release_group+0x120/0x180
[   48.471364]                     component_unbind+0x54/0x70
[   48.471867]                     component_unbind_all+0xb0/0xe8
[   48.472400]                     rockchip_drm_unbind+0x44/0x80 [rockchipdrm]
[   48.473059]                     component_del+0xc8/0x158
[   48.473545]                     dw_hdmi_rockchip_remove+0x28/0x40 [rockchipdrm]

[...]

[   48.482058]    INITIAL USE at:
[   48.482344]                    lock_acquire+0x1d4/0x320
[   48.482824]                    _raw_spin_lock+0x50/0x70
[   48.483304]                    regcache_maple_write+0x27c/0x330
[   48.483844]                    regcache_write+0x6c/0x88
[   48.484323]                    _regmap_read+0x198/0x1c8
[   48.484801]                    _regmap_update_bits+0xc0/0x148
[   48.485327]                    regmap_field_update_bits_base+0x74/0xb0
[   48.485919]                    vop2_plane_atomic_update+0x9e8/0x1490 [rockchipdrm]
[   48.486631]                    drm_atomic_helper_commit_planes+0x190/0x2f8 [drm_kms_helper]

I experimented with a reduced scope of this patch by limiting the use of
the irq-safe lock to regcache_maple_exit() only, and I can confirm this 
was enough to make lockdep happy.

> It might be safer to fall back to the rbtree cache for this device since
> rbtree doesn't force an extra level of locking on us, though like I say
> I'm not convinced that what the driver is doing with caching is a super
> good idea.  Though probably what the driver is doing should work.

I actually gave the flat cache a try on a Rock 3A board and didn't
encounter any (obvious) issues, but my testing capabilities are rather
limited at the moment.

@Andy: Could you, please, shed some light on the topic? i.e. the rational
behind going for an rbtree cache over a flat one, since the latter would be
better suited for MMIO devices.
 
> My first thought here is that if we've got a regmap using spinlocks for
> the regmap lock and a maple tree cache we should arrange things so that
> the maple tree lock is used for the regmap's lock.  That would however
> involve some unpleasant abstraction violation, and possibly some macro
> fun since we'd need to elide the locking from the cache itself when
> using the same lock at the regmap level.  I think that's going to be a
> case of choosing the least unpleasant option.

Thanks, Mark, for the detailed feedback on this!

Regards,
Cristian

