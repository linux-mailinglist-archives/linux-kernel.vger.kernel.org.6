Return-Path: <linux-kernel+bounces-295569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4416959E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050711C2178C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F8199FCB;
	Wed, 21 Aug 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBzpeznu"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8B199FBF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246109; cv=none; b=YCtHMYebToeRWoTIkjtpO5RpoVPUDeh2DS6exCLOTCobjQp+OeVigY5gdib3LLy/9WJnYEnRQL1JMjIY7tFC4QRqrEf0Dnj7Bwj81u0i4YOW7NUhrzZx5vY4ROSD5nuFTlxLa47ts/bGswN1ZE4WWGxKq5zV1Ng8BijAeJZo+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246109; c=relaxed/simple;
	bh=IkVS+yXH5uK6Jq76r3978Yrciq8PclOcH40H0ePGu2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHwSlZgxJZMyLg9bKRNWjFsqH6yoj6JrtmTRbqes96AULc4qTDgR07sPKkYN0F3SD9EtQ9efOIylNdYFudJ7obiIeap4ADz+3pXRqHK/kPLi1YuYbr0L5s1gvi3+SR61N8Fgh79D/9WCGxbFERCLyX+aEGMMMMMgzJbIgvwGCSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WBzpeznu; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e13c2ef0f6fso4990857276.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724246107; x=1724850907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ND82RYn7MaNSpzb7NAOhxgHIKl6E8lI43wkdqiWtnl8=;
        b=WBzpeznuXKf/kt8GFDnyng4YUZxyo7nB/UTSrpi0K/KB7NbyjWYZmFuQqrbFEnbyoU
         F1lr/6WO9rRjPM7r/bDU5Lw/a/bx6x6zFjsOvSMfD/uO1ZYNncmBKPqMlwZzEgdx9hsX
         O3/VpzgIXPAhd+WjK+NqV+aG/22dHKTdDqf5fX8zpm+Qr9JvsHyIE2OYAPek547/iLhR
         kJjLQP2bPc98NtFt31cVZWCMlEHASmK9qrvo3sVgDZ9TzP3Sk6uUypIE3/6CY0JFxb2z
         mHH+zAT7xElNWWWuD1tGv/VRWUIwQfkkhjfxBFXEcm10hIwep+GtWlO9s0XbWLWztKAA
         pnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724246107; x=1724850907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ND82RYn7MaNSpzb7NAOhxgHIKl6E8lI43wkdqiWtnl8=;
        b=She720H54nxC+TIaEEZ8fKB0dHpvv6woDlQi41Yl7VesJzY6VC9Ts/LCr/pKKzXGZo
         s1Yal1MyDgZ/O3rw0EOYdgoNxshaoCtQOZUS3TIPiLyFzNwAoOmL/7+B0PLvVl7v8/S5
         zL4mtnjKFrHtMVLgs/I6UxCJnJWO0OpfyK+gHgjX89WgGm7vItyFxSWwgZyJr+STe4rN
         49FPmpy0P7H30XPBbHUWLKXEEsal3vVoMErc+ZXL/HYgjEvUnk0udz/MTeAGMOXvEBa5
         x/94XN6bvb+IPHe3v98HFXRiOiArYz7UkwXNMZYMSAojXcr+BKWK4J5BnNJbQ02oOIt6
         tVng==
X-Forwarded-Encrypted: i=1; AJvYcCUPrvxbsaWZjz1+GmCbaj7iu38c9MvkOPYQnNWgE77IjPO6I8qSktUEOh+7FNyvKWAeszW6KN3IodgnhQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBI8NralImGyOnPmdFc+LKXcu0dthlfx2niuqNVOOfo0SXB3G5
	LfqG78VjQKow7SMWFSGAgI3f4QrrrNvumjqdZf+JtmGnKr3C36S9zCVP8JXts1dqDQlnJFgmdPM
	m9NzgoZJU73sQd7tG/fHIePaxe0u9tZIwgk8rCA==
X-Google-Smtp-Source: AGHT+IHMFrZYqcZ+YKGN6ef7K45igq5+avAhanl2GUzgRB1IEkFvh06daR52Rd2yBylT0BHej583UvwMIolio13isH8=
X-Received: by 2002:a05:6902:1244:b0:e0e:8319:c6e4 with SMTP id
 3f1490d57ef6-e16663ec35cmr2880278276.8.1724246106550; Wed, 21 Aug 2024
 06:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809172106.25892-1-ansuelsmth@gmail.com> <20240809172106.25892-4-ansuelsmth@gmail.com>
 <20240813200734.GA1659224-robh@kernel.org> <66c5b8ec.5d0a0220.11ef1f.b572@mx.google.com>
In-Reply-To: <66c5b8ec.5d0a0220.11ef1f.b572@mx.google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Aug 2024 15:14:29 +0200
Message-ID: <CAPDyKFq0cR10d1jUc5gnoUR5P=cbDEZy2iA-HOq9oNcWZevbDg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: mmc: add property for partitions node
 in mmc-card node
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Joern Engel <joern@lazybastard.org>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Saravana Kannan <saravanak@google.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 11:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Tue, Aug 13, 2024 at 02:07:34PM -0600, Rob Herring wrote:
> > On Fri, Aug 09, 2024 at 07:21:01PM +0200, Christian Marangi wrote:
> > > Add property for defining partitions node in mmc-card node to define
> > > partitions in DT by the use of the block2mtd module to use block
> > > devices as MTD.
> >
> > You justified patch 1 saying eMMC already supported this, but then here
> > you add support.
> >
> > Both are a NAK for me as both already have a way to describe partitions
> > with GPT.
> >
>
> I think this got a bit confused and hope we can find a way to add
> support for this.
>
> What is "already supported" is assigning an OF node so driver can
> reference it. This patch was just adding the nodes in the schema to say
> that partitions can be defined.
>
> I think what is not clear is that block devices might be used as raw
> devices without a partition table defined in the device. In such case
> it's the kernel that define a fixed partition table.
>
> One example is [1] where the partition table is provided by cmdline.
> Similar to cmdlinepart MTD parser.
>
> The use of block2mtd is just to make use of the MTD parser system.
>
> Considering
> - eMMC is soldered to the device (no dynamic scan)
> - cmdline might be not tunable and hardcoding it might also be
>   problematic (as some cmdline needs to be used)
> - concept of fixed partition for block device is already a thing and
>   used a lot (android AFAIK)

Sorry for sidestepping your discussion, but I just wanted to add a few comments.

It's not clear to me why we need something different than what we
already have today.

If it's a partuuid/uuid/label or a fixed block-partition from the
command line, we still need to know what partition we shall use for
what. So why is this problem different from how we manage filesystem
mounts, for example?

>
> I think it should be acceptable to introduce in DT support for defining
> fixed partition for block devices and some kind of parser system similar
> to MTD. What do you think? Would this be more acceptable? Idea is to
> just have a DT schema that makes use of the values that can be set in
> [1].

In DT we can describe that there is an eMMC card soldered to the
board, because it's a description of the HW. But describing what
stored inside the eMMC-flash doesn't belong in DT.

>
> Hope we can find a solution to this, I'm totally OK for dropping NVMe as
> I understand it's PCIe stuff and very dynamic but OEM are making lots of
> use of eMMC and are starting to use these strange way (block2mtd) as we
> currently don't give a proper and easy solution for the task.

I certainly appreciate that you are trying to solve the fragmentation
issue around this, but it looks like we need a different approach than
using DT to describe partitions.

>
> [1] https://github.com/torvalds/linux/blob/master/Documentation/block/cmdline-partition.rst
>

Kind regards
Uffe

