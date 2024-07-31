Return-Path: <linux-kernel+bounces-268668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C148D942793
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9BB6B21B96
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4171A4F18;
	Wed, 31 Jul 2024 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eReLRDpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271133CFC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409899; cv=none; b=bA7btzHt8ZPCCZg33Bd0Wreg4mufhpMQGohpzFayaykXGY+6oQ4DaXyAQKuh83gTPER7baUIzpppaBCBzlDf/Mgba0Sx82keaaZb7zryAmxVyRZX9t/tdu6fcpW/yqO4lYgdyhRpmNEMxViLkwqPQcVhbISCOXkPqIknZB849+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409899; c=relaxed/simple;
	bh=1mcVc1Ueop4K8tFmzU4UoOsc564uDrYB7DSVbqZjfng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+P1E1By62gH/KoA9+tDlv0c2a6CR1/NW6ggZs127nOWx/N9nDVqZD0kFWUoWjOhi2W+gpERF5W2x5CCzITKOyYRqGLuCiTUmHFaXlPR7zGwIqkBVLtoHIQmZyy7SwHPECYiYnxsIAcaabhDGFFxEilFP2lpQFAwUuAeDj6Cbuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eReLRDpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CED9C116B1;
	Wed, 31 Jul 2024 07:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722409899;
	bh=1mcVc1Ueop4K8tFmzU4UoOsc564uDrYB7DSVbqZjfng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eReLRDpaXNlyUK6zTE3tj16Cpe8H1D8jaOFIwN4MAQPBkVNDqprZyGblRQD8YBzbF
	 0LGb+x6QErM/2oWBBxcRhEzi/0aJpuzaSMhBjDAC8EqVlzBJyOe92/8DFFKweTYGU1
	 CyF04Eekq/T86cSK/5+3i+sbN4+r66beuMnNMQ+MGhrO1lEFwWicmugeHCZN/Q9hwi
	 RUQPD9Sw3+Fq56Tt9U8vJY2/TzrE/OJFyn+JSVVDc51jIKj6dPvA+ZEA2DCBZajf0V
	 d+nFTdQz+shKAyz0X7CKV4DRPNHWy7gZhCedc8yGEHvkkR4khH+ukXURjuyAmTrFuF
	 Fq/o7r/Nrtogw==
Date: Wed, 31 Jul 2024 09:11:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240731091133.07ddd58c@foz.lan>
In-Reply-To: <20240730131709.10e72c7d@imammedo.users.ipa.redhat.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
	<20240730131709.10e72c7d@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 30 Jul 2024 13:17:09 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Mon, 22 Jul 2024 08:45:56 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> that's quite a bit of code that in 99% won't ever be used
> (assuming error injection testing scenario),
> not to mention it's a hw depended one and governed by different specs.
>
> Essentially we would need to create _whole_ lot of QAPI
> commands to cover possible errors for no benefit to QEMU.
> 
> Let take for example very simple _OST status reporting,
> QEMU of cause can decode values and present it to users in
> more 'presentable' form. However instead of translating
> numbers (aka. spec language) into a made up QEMU language,
> QEMU just passes values up the stack and users can use
> well defined spec to interpret its meaning.
> 
> benefits are: QEMU doesn't have to maintain translation
> code and QAPI ABI is limited to passing raw values.
> 
> Can we do similar thing here as well?
> i.e. simplify error injection commands to
> a command that takes raw value and passes it
> to guest (QEMU here acts as proxy, if I'm not
> mistaken)?
> 
> Preferably make it generic enough to handle
> not only ARM but other error formats HEST is
> able to handle.

A too generic interface doesn't sound feasible to me, as the
EINJ code needs to check QEMU implementation details before
doing the error inject.

See, processor is probably the simplest error injection
source, as most of the fields there aren't related to how
the hardware simulation is done.

Yet, if you see patch 7 of this series, you'll notice that some
fields should actually be filled based on the emulation.

On ARM, we have some IDs that depend on the emulation
(MIDR, MPIDR, power state). Doing that on userspace may require
a QAPI to query them.

The memory layout, however, is the most complex one. Even for
an ARM processor CPER (which is the simplest scenario), the 
physical/virtual address need to be checked against the emulation
environment.

Other error sources (like memory errors, CXL, etc) will require
a deep knowledge about how QEMU mapped such devices.

So, in practice, if we move this to an EINJ script, we'll need
to add a probably more complex QAPI to allow querying the memory
layout and other device and CPU specific bindings.

Also, we don't know what newer versions of ACPI spec will reserve
us. See, even the HEST table contents is dependent of the HEST 
revision number, as made clear at the ACPI 6.5 notes:

	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#acpi-error-source

and at:

	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-source-structure-header-type-12-onward

So, if we're willing to add support for a more generic "raw data"
QAPI, I would still do it per-type, and for the fields that won't
require knowledge of the device-emulation details.

Btw, my proposal on patch 7 of this series is to have raw data
for:
	- the error-info field;
	- registers dump;
	- micro-architecture specific data.

I don't mind trying to have more raw data there as I see (marginal) 
benefits of allowing to generate CPER invalid records [1], but some of
those  fields need to be validated and/or filled internally at QEMU - if
not forced to an specific value by the caller.

[1] a raw data EINJ can be useful for fuzzy logic fault detection to 
    check if badly formed packages won't cause a Kernel panic or be
    an exploit. Yet, not really a concern for APEI, as if the hardware
    is faulty, a Kernel panic is not out of the table. Also, if the
    the BIOS is already compromised and has malicious code on it, 
    the EINJ interface is not the main concern.

> PS:
> For user convenience, QEMU can carry a script that
> could help generate this raw value in user friendly way
> but at the same time it won't put maintenance
> burden on QEMU itself.

The script will still require reviews, and the same code will 
be there. So, from maintenance burden, there won't be much
difference.

Btw, I'm actually using myself a script to test it, currently
sitting together with rasdaemon - which is the Linux tool to detect
and handle hardware errors:

	https://github.com/mchehab/rasdaemon/blob/master/contrib/qemu_einj.py

as it helps a lot when trying to simulate more complex errors.

Once QEMU gains support to inject processor errors, I can prepare a 
separate patch to move it to QEMU.

Thanks,
Mauro

