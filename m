Return-Path: <linux-kernel+bounces-429635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD259E1EDB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6580C2816F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA01F4722;
	Tue,  3 Dec 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Smm9gggQ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA61E32C0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235432; cv=none; b=JaQCzp+qgI/xAPonE0QU/Zu8c1s9eWBxMKGE+vzxk+mhE/9U6juSslhhVVpWY7p41mppoXKF63AU9xehOw3IQFa44fxZgSKAzKfcwRMFfd6z5LWfcv5DHfjEavME+zoPj268x7T6Bf208qQUfq5W71OqK6P4PYVLNHXePAv40Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235432; c=relaxed/simple;
	bh=D3vLi0BRVsOigQlpV1L6zgFgKNNRBRResXrfTlbGXDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rdeLjcT6GHdE0DDrGNPn7117cG+cnztjpE2KBfeBwxdVZfokbayW+yEYD6rLdKNzLCggw9XEHE+CSAYipkCR44oeteDPcYLfh5RWmmgrbU31Y/Sljyz079EvMqrWtbt2oWUagjiaO5ZeZX0FLlYKbFKiMuu5/cdIbTLWvO0O+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Smm9gggQ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBF9C60007;
	Tue,  3 Dec 2024 14:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733235428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3vLi0BRVsOigQlpV1L6zgFgKNNRBRResXrfTlbGXDA=;
	b=Smm9gggQOgZkdaylrE1Tzj+0rQRjXrJA+Cy3RKDNf6sogA3niqhcVYD52GVdwoQb7jEfgy
	201tKO1wf6uXEndvpOyRY3esCXZVBbbPvPtgkYauR5IhNhLrqKHJhksWOriBTnrMUv4Jg9
	z7fmJKuXFrpbFBGSI4d27aloRSUxrXoQ+wjL6THdqwn/nDJ41BFSx/HiUKMDedtgz6Xzz4
	i2ljVrbcJjuda+a/ZQj5kKC4gXH1G+VdYZnuLS4AuJxfChdUtSok1jE4wIJOkARaBfMLsG
	nI62uE/2gTEz7hBPP+swCgxPCIoRJxr5ZnQJKp6Rq5oEw/wq04YS2KaEwXbHPg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pintu Agarwal <pintu.ping@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd <linux-mtd@lists.infradead.org>,
  chengzhihao1@huawei.com,  open list <linux-kernel@vger.kernel.org>
Subject: Re: Block based OTA update needs mtdblock
In-Reply-To: <CAOuPNLhhWzoBQH85zEd95LbONtrknq+b7tfcze50VPa9bEnXzw@mail.gmail.com>
	(Pintu Agarwal's message of "Wed, 20 Nov 2024 12:52:57 +0530")
References: <CAOuPNLhxBBihr38p_XMQEgkiLFc+DPxkQf4oewF8U1+ihaFn-Q@mail.gmail.com>
	<CAOuPNLhhWzoBQH85zEd95LbONtrknq+b7tfcze50VPa9bEnXzw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 03 Dec 2024 15:17:06 +0100
Message-ID: <87ldww4zrx.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 20/11/2024 at 12:52:57 +0530, Pintu Agarwal <pintu.ping@gmail.com> wrote:

> Hi,
>
> On Mon, 4 Nov 2024 at 21:31, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>>
>> Hi All,
>>
>> For one of our automotive products we have the following configuration:
>> QC chipset, arm64, Kernel-5.15, NAND Flash 1GB, A/B system, UBI
>> volumes (squashfs, ubifs), DM-verity for rootfs (squashfs), simple
>> busybox platform.
>>
>> For OTA updates we have a strong dependency with MTD_BLOCK.
>>
>> Till now, we were using ubiblock for mounting squashfs volumes and
>> completely got rid of mtd_block by configuring it as a loadable
>> module.
>> But, we also need to support OTA updates (Full, Incremental) on A/B
>> volumes using the same Android OTA framework.
>> https://source.android.com/docs/core/ota/nonab/block
>>
>> OTA update will be applied to the B (inactive) partition.
>> OTA updates prefer block based update over file based especially for
>> dm-verity enabled devices.
>>
>> Now, the problem is, on MTD we only have 2 options for block based
>> updates; ubi_block or mtd_block.
>> We cannot use ubiblock for OTA updates as it is read only.
>> For full update volume, we can use "ubiupdatevol" interface to
>> completely replace the volume content, but for partial or incremental
>> update we need to update only specific blocks and not entire
>> partitions.
>> Thus, we have to use the MTD_BLOCK (/dev/mtdblock) interface to
>> support block based OTA updates on UBI volumes.
>> Thus, during ota updates (only) we need to install the mtdblock
>> module, perform the update and then uninstall the module.
>>
>> That means, we cannot completely get rid of MTD_BLOCK from our product
>> especially for OTA use cases.
>>
>> Is this the only way, or do we have any other option to support OTA
>> updates over UBI volumes ?
>>
> Restarting this thread again...
> Any further comment on this ?
>
> Did anybody used block based OTA update NAND A/B system without using
> mtd_block ?

Not on my side, it is actually a good question. Richard, any ideas?

> Since ubiblock is read-only, it seems there is no other way to perform
> OTA update, if mtd_block is disabled.
> Or, we need to make ubiblock also as read/write.

Doesn't sound possible/a good idea.

I'm sorry for this unhelpful answer :-)

Miqu=C3=A8l

