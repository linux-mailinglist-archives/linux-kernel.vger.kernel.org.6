Return-Path: <linux-kernel+bounces-438069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C339C9E9C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B88282D97
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F3D152E0C;
	Mon,  9 Dec 2024 16:59:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79D2C9A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763565; cv=none; b=jxrE/j/deEGlUV8q4sSJZXqUsZ1GBhwDZMJL1CjThUt2UgH8Ht3bacdIAAcLe4zBZj+RKTxPoHr2YpWzKcQddVd2y04yY/qShTJsmUdd522leGfkV3aZM+yHu+rm797QU1sIteZp76Rs3l/S7SFU7OHmuAdLBQM3ytSBD69//mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763565; c=relaxed/simple;
	bh=gVxoTEjZk5UekIl5LiZpoPTQIiZj44IpF+2LRMzW+4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiM93oS+IOpikAqpn4h5e+1mAEyhHDqmwmTg2fA4tBhqoRVTdPfJdb8vmPYLn7gB9SO4h8caLjhEHmt9LmIJi5oMnRQf5c07kMKkruINDxIr3pyqQUhXRwdPh/i8Pic/YAtuLt5lycBW57G1nLcKOnLyffa/F7RW2+OCL8UlSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F32CB113E;
	Mon,  9 Dec 2024 08:59:50 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E75893F720;
	Mon,  9 Dec 2024 08:59:21 -0800 (PST)
Date: Mon, 9 Dec 2024 16:59:19 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Yeoreum Yun" <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	nd@arm.com
Subject: Re: [PATCH v2 2/2] firmware/arm_ffa: remove __le64_to_cpu() when set
 uuid for direct msg v2
Message-ID: <Z1ch52AthTYVhtH4@bogus>
References: <20241203143109.1030514-1-yeoreum.yun@arm.com>
 <20241203143109.1030514-3-yeoreum.yun@arm.com>
 <9e60e996-070e-43a7-80e9-efdfda9f6223@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e60e996-070e-43a7-80e9-efdfda9f6223@app.fastmail.com>

On Mon, Dec 09, 2024 at 04:27:14PM +0100, Arnd Bergmann wrote:
> On Tue, Dec 3, 2024, at 15:31, Yeoreum Yun wrote:
> > From: Levi Yun <yeoreum.yun@arm.com>
> 
> I just saw this commit in the pull request, and I'm very
> confused because the description does not match the
> patch contents.
>

Sorry for that, I tried to reword to improve it but it is obvious now that I
didn't do a good job there.

> > Accoding to FF-A specification[0] 15.4 FFA_MSG_SEND_DRIECT_REQ2,
> > then UUID is saved in register:
> >     UUID Lo  x2  Bytes[0...7] of UUID with byte 0 in the low-order bits.
> >     UUID Hi  x3  Bytes[8...15] of UUID with byte 8 in the low-order bits.
>
> The specification you cite here clearly describes little-endian
> format, i.e. the low-order byte corresponds to the first
> memory address.
>


> > That means, we don't need to swap the uuid when it send via direct
> > message request version 2, just send it as saved in memory.
>
> "As saved in memory" does not sound like a useful description
> when passing arguments through registers, as the register
> contents are not defined in terms of byte offsets.
>

Well I didn't know how to term it. The structure UUID is a raw buffer
and it provide helpers to import/export the data in/out of it. So in LE
kernel IIUC, it is stored in LE format itself which was my initial
confusion and hence though what you fixed was correct previously.

> Can you describe what bug you found? If the byteorder on
> big-endian kernels is wrong in the current version and your
> patch fixes it, it sounds like the specification needs to
> be updated describe both big-endian and little-endian
> byte-order, and how the firmware detects which one is used.
>

The firmware interface understands only LE format. And by default UUID
is stored in LE format itself in the structure which I got confused
initially. We may need endian conversion at places(found few when trying
to get it working with BE kernel).

I wanted to check with you about this. The current driver doesn't
work with BE. I tried to cook up patches but then the upstream user
of this driver OPTEE doesn't work in BE, so I hit a roadblock to fully
validate my changes. I don't see any driver adding endianness dependency
in the Kconfig if they can't work with BE, not sure if that is intentional
or just don't care. I was thinking if we can disable it to build in BE
kernel until the actual support was added.

So the current FF-A driver just supports LE and the bug was found just
in LE kernel itself.

> > Remove le64_to_cpu() for uuid in direct message request version 2,
> > and change uuid_regs' type to unsigned long.
>
> 'unsigned long' makes the code unnecessarily incompatible
> with 32-bit builds.
>

Understood we may need some typecasting to avoid compiler warnings.

Just a note not related to your comment though: FFA_MSG_SEND_DIRECT_REQ2
is 64-bit only as it uses full 64-bit register to pass UUID.

--
Regards,
Sudeep

