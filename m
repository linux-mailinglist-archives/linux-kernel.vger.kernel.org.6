Return-Path: <linux-kernel+bounces-439320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166DC9EAD9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EE22832F8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54FE23DEA6;
	Tue, 10 Dec 2024 10:08:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2F823DE8E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825328; cv=none; b=jHGskEvCwAM6zvfpas7iMSyHgPbakb81FyvIU0bzjZzQwHD8xzdVa/86zMmYt7VJLqETM0dsQ0fa1qIfaSAVhiig1PzNc4GiUaXT8GJkHqLWKLFkAVHqcvEckO6/2SvaRIpfLGGiRqzzW3vivWlNM2KyuqO+/MzqRNomRjesIw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825328; c=relaxed/simple;
	bh=vWQFvYMAcR0ETDNF0juPM8Vf+AK1edeFKXi3QB/t/R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bze364zYj3iaN2v+3MAGKYCEHMOw/1BA4aiNq5/HfCogxngMGS/IbsHqCak/8wUyepCq5NYgYB/t7PiUv/i717/3I/EJb4Wm0TrTHXK3XQlguE6jaN43gAXXcI2uWAVQN8aB3j8MlZXUNhbkLMYHxdXtKt2Dqxy6c0aUj/T6oBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17024113E;
	Tue, 10 Dec 2024 02:09:13 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D3FB3F58B;
	Tue, 10 Dec 2024 02:08:44 -0800 (PST)
Date: Tue, 10 Dec 2024 10:08:41 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Yeoreum Yun" <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	nd@arm.com
Subject: Re: [PATCH v2 2/2] firmware/arm_ffa: remove __le64_to_cpu() when set
 uuid for direct msg v2
Message-ID: <Z1gTKRZGyE7VuJo0@bogus>
References: <20241203143109.1030514-1-yeoreum.yun@arm.com>
 <20241203143109.1030514-3-yeoreum.yun@arm.com>
 <9e60e996-070e-43a7-80e9-efdfda9f6223@app.fastmail.com>
 <Z1ch52AthTYVhtH4@bogus>
 <0cb655ee-9401-41bb-b9cd-580e0aeef2be@app.fastmail.com>
 <Z1fvkpYvqpnjPZA8@e129823.arm.com>
 <d750f114-8a25-4c84-912e-b6fb407a5150@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d750f114-8a25-4c84-912e-b6fb407a5150@app.fastmail.com>

On Tue, Dec 10, 2024 at 09:45:51AM +0100, Arnd Bergmann wrote:
> On Tue, Dec 10, 2024, at 08:36, Yeoreum Yun wrote:
> >> On Mon, Dec 9, 2024, at 17:59, Sudeep Holla wrote:
> >> > On Mon, Dec 09, 2024 at 04:27:14PM +0100, Arnd Bergmann wrote:
> >>
> >> Looking through the other functions in drivers/firmware/arm_ffa/driver.c,
> >> I see that most of them just match the specification. One exception
> >> is ffa_notification_info_get(), which incorrectly casts the
> >> argument response arguments to an array of 'u16' values. Using
> >> the correct bit shifts according to the specification would
> >> make that work on big-endian and also more readable and
> >> robust. Another one is __ffa_partition_info_get_regs(), which
> >> does an incorrect memcpy() instead of decoding the values.
> >>
> > Conclusionly, Yes. But the RFC 4122 said with network byte order.
> > to describe how uuid is saved.
> >
> > but I think the endianess to load the register is not a choice.
> > because the spec says:
> >
> >     UUID Lo  x2  Bytes[0...7] of UUID with byte 0 in the low-order bits.
> >     UUID Hi  x3  Bytes[8...15] of UUID with byte 8 in the low-order bits.
> >
> > this means UUID.bytes[0] should be loaded to x2.bytes[0].
> >            UUID.bytes[1] should be loaded to x2,bytes[1]
> >            ...
> 
> I meant they had the choice and chose to specify little-endian
> 64-bit word to encode the sequence of bytes of the standard
> in-memory representation of UUIDs. 
> 
> > That's why other software spec (i.e tf-a) doesn't loads UUID from register
> > wihtout swapping byte with endianess but just copy it.
> 
> If the uuid is transferred in memory, you obviously don't want to
> swap it. If they pass it in registers across different endianess
> code without specifying the byteorder in the caller, then they
> would have the same bug.
> 
> > The bug is "not send UUID according to spec" in kernel side
> > That's why it fails when I send message  with direct message version 2.
> > So, it''s not change code unportable to portable but it fixes according
> > to spec (load UUID as it is in register wihtout endianess).
> 
> Sorry, but you are not making sense here.
>

Agreed. The patch is clearly wrong. Thanks for refreshing my knowledge and
helping me to clear my confusion.

> Sudeep, should I just cherry-pick your other fix from the pull
> request and ignore this patch?
>

I will remove the wrong patch and retag and send PR if that helps. It should
be quick.

-- 
Regards,
Sudeep

