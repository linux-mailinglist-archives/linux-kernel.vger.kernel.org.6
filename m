Return-Path: <linux-kernel+bounces-439288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAC59EAD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581F11619F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F9378F2D;
	Tue, 10 Dec 2024 09:50:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2588A1DC988
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824205; cv=none; b=HXc8EQmm41mCnLRhKS7qxCqbygPbzkJiQpVC3EiVmYZ8rVHMDnAbqgVY8EVlQyoDyG7XrzK/jrsMbNvC5Hjj9HXi92U66MifeGsG6pSTzIhgGKtLFBZWtoSm/ltsZQZ8DHPLPWhpHmSOjlppl0qKjOntmkyvpfG3QiKnByvlTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824205; c=relaxed/simple;
	bh=mjdSpYDw0YeNVNq/dKavM9Oh3O0I+ni4TpWSjS+Vgf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQRDtOBt/4KxjJYB0sU7eqzcpdUdFMt8XQUHTPEH5jxZbx49rak7ps6ic0fK4NcJG4LhDVURg4nY/P8f6DjrobJ110JJlrFe5UcEEoEJR8ntaAVyga0QsUXiYXT30SKOhD1Bc1zllfuKSJqKGBC/hkaod62HmpgmEAN2grosktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C253113E;
	Tue, 10 Dec 2024 01:50:30 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53FCE3F58B;
	Tue, 10 Dec 2024 01:50:01 -0800 (PST)
Date: Tue, 10 Dec 2024 09:49:58 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] firmware/arm_ffa: remove __le64_to_cpu() when set
 uuid for direct msg v2
Message-ID: <Z1gOxjyEajxkyHnT@bogus>
References: <20241203143109.1030514-1-yeoreum.yun@arm.com>
 <20241203143109.1030514-3-yeoreum.yun@arm.com>
 <9e60e996-070e-43a7-80e9-efdfda9f6223@app.fastmail.com>
 <Z1ch52AthTYVhtH4@bogus>
 <0cb655ee-9401-41bb-b9cd-580e0aeef2be@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb655ee-9401-41bb-b9cd-580e0aeef2be@app.fastmail.com>

On Mon, Dec 09, 2024 at 09:04:30PM +0100, Arnd Bergmann wrote:
> On Mon, Dec 9, 2024, at 17:59, Sudeep Holla wrote:
> > On Mon, Dec 09, 2024 at 04:27:14PM +0100, Arnd Bergmann wrote:
> >
> >> > That means, we don't need to swap the uuid when it send via direct
> >> > message request version 2, just send it as saved in memory.
> >>
> >> "As saved in memory" does not sound like a useful description
> >> when passing arguments through registers, as the register
> >> contents are not defined in terms of byte offsets.
> >>
> >
> > Well I didn't know how to term it. The structure UUID is a raw buffer
> > and it provide helpers to import/export the data in/out of it. So in LE
> > kernel IIUC, it is stored in LE format itself which was my initial
> > confusion and hence though what you fixed was correct previously.
> 
> The way I would phrase it, the UUID is never "stored" in
> big-endian or little-endian format, it's just remains a string
> of bytes. The endianess becomes a choice only when loading it
> into registers for passing the argument to firmware, and it's
> the firmware that mandates little-endian in the specification.
>

Thanks, I will add such a note when I get BE support fixed so that it is
clear.

> >> Can you describe what bug you found? If the byteorder on
> >> big-endian kernels is wrong in the current version and your
> >> patch fixes it, it sounds like the specification needs to
> >> be updated describe both big-endian and little-endian
> >> byte-order, and how the firmware detects which one is used.
> >>
> >
> > The firmware interface understands only LE format. And by default UUID
> > is stored in LE format itself in the structure which I got confused
> > initially. We may need endian conversion at places(found few when trying
> > to get it working with BE kernel).
> >
> > I wanted to check with you about this. The current driver doesn't
> > work with BE. I tried to cook up patches but then the upstream user
> > of this driver OPTEE doesn't work in BE, so I hit a roadblock to fully
> > validate my changes. I don't see any driver adding endianness dependency
> > in the Kconfig if they can't work with BE, not sure if that
> > is intentional or just don't care. I was thinking if we can disable
> > it to build in BE kernel until the actual support was added.
> 
> I think as long big-endian kernels remain an option on arm64, we
> should try to to write portable code and implement the specification
> The reality of course is that very few people care these days, and
> it's getting harder to test over time.
>

Indeed. I do run SCMI once in a while but hadn't tried FF-A so far for no
particular reasons. I will get that sorted this time.

> > So the current FF-A driver just supports LE and the bug was found just
> > in LE kernel itself.
> 
> What is the bug and how was it found? The only thing I see in
> the patch here is to change the code from portable to nonportable,
> but not actually change behavior on little-endian 64-bit.
>

OK you are right, I clearly got confused. There should be something
else messed up in the setup. I think fixing BE support will avoid such
things in the future, I will get on that ASAP. Sorry for the confusion.

I just dumped the buffers and UUID and it works as expected, so I blindly
assumed the firmware setup is correct and there is a bug.

> Looking through the other functions in drivers/firmware/arm_ffa/driver.c,
> I see that most of them just match the specification. One exception
> is ffa_notification_info_get(), which incorrectly casts the
> argument response arguments to an array of 'u16' values. Using
> the correct bit shifts according to the specification would
> make that work on big-endian and also more readable and
> robust. Another one is __ffa_partition_info_get_regs(), which
> does an incorrect memcpy() instead of decoding the values.

Yes these are 2 main changes I have. I think I had one more but I need to
go back and check. I plan to post them once I have done the testing with
OPTEE. I just want to run xtest they have and see if everything works for
which I may need to spend sometime.

-- 
Regards,
Sudeep

