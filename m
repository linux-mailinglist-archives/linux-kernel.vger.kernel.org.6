Return-Path: <linux-kernel+bounces-265614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5FA93F3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3299C1C21395
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51F1448E0;
	Mon, 29 Jul 2024 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFrHCY5f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0D21373
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251939; cv=none; b=ekwg8JyW1siuTNqvO33Qrc0blXRz18iTlc/es7QX4aOrtVMuE8GxzlaxKPQv3w9XAMVrhpeKz8XJOBDLQAqWu3Aj3eWPdxopWVVHzaPXqqnufkTVTerD5yzHGUZkCKEIhRo+5IvjdhpohB6jUhJ8jAp2IV39xAj+BjJ/Aom9WPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251939; c=relaxed/simple;
	bh=TZWnzVzliccEj7Fu28VQJqcjmzU0UNXPAtXxgl5zVdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWl6FERABbcWwTaSGB+YEL3HJo06/H88zYSu6BnpnMEEqbEfcSPDTistL3O8liVCyk2EMH6yobbLBpmMjB/hMyqE7RdNOmrW9WP+8uie//fk3Ji2cLhLQvhp+H63NtUUTHk/7FUivZ2wQ9R3dnA+jz/tU0cF4ESAFsUwZ1OsPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFrHCY5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F963C32786;
	Mon, 29 Jul 2024 11:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722251939;
	bh=TZWnzVzliccEj7Fu28VQJqcjmzU0UNXPAtXxgl5zVdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qFrHCY5fm/HSbjL6v49B02WHi0ZkxUrwfWoFvLZ2A1VzKTzNqXGe3KoB8UCxI6mCK
	 1Q2wolZY4SfT4wWPX+k07zbxZIBRjQcc2uCFbm2BrYRf1YLZMFfhDyh23jcLoB8IEK
	 U/T+cXjfDYnKn5QBMfjRRvBh+XXYHeCh20HwgLgjuKb0O9w0GgU2AdT4b6rXB9cPLN
	 wzxeItsj9VwwAiwc/jWRI/IbcEOtZTsoVIM12lg+H9xXDToR37zLbcMXjdLtvPnHPC
	 MBIDzbkAi/b8eahJRX1WcvNCqiVTruvwGLoiuP7D4/h0+Y2dt8hHXG/wENbTrTTrBI
	 7R3WOIKCjKBlg==
Date: Mon, 29 Jul 2024 13:18:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Beraldo Leal <bleal@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas
 Huth <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 7/7] acpi/ghes: extend arm error injection logic
Message-ID: <20240729131852.0b850c15@foz.lan>
In-Reply-To: <87y15ppz3x.fsf@pond.sub.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<89e8a63b5e54409dd9bc4e7f4f4c12290838371b.1721630625.git.mchehab+huawei@kernel.org>
	<87y15ppz3x.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Thu, 25 Jul 2024 12:03:46 +0200
Markus Armbruster <armbru@redhat.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > Enrich CPER error injection logic for ARM processor to allow
> > setting values to  from UEFI 2.10 tables N.16 and N.17.
> >
> > It should be noticed that, with such change, all arguments are
> > now optional, so, once QMP is negotiated with:
> >
> > 	{ "execute": "qmp_capabilities" }
> >
> > the simplest way to generate a cache error is to use:
> >
> > 	{ "execute": "arm-inject-error" }
> >
> > Also, as now PEI is mapped into an array, it is possible to
> > inject multiple errors at the same CPER record with:
> >
> > 	{ "execute": "arm-inject-error", "arguments": {
> > 	   "error": [ {"type": [ "cache-error" ]},
> > 		      {"type": [ "tlb-error" ]} ] } }
> >
> > This would generate both cache and TLB errors, using default
> > values for other fields.
> >
> > As all fields from ARM Processor CPER are now mapped, all
> > types of CPER records can be generated with the new QAPI.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> =20
>=20
> [...]
>=20
> > diff --git a/qapi/arm-error-inject.json b/qapi/arm-error-inject.json
> > index 430e6cea6b60..2a314830fe60 100644
> > --- a/qapi/arm-error-inject.json
> > +++ b/qapi/arm-error-inject.json
> > @@ -2,40 +2,258 @@
> >  # vim: filetype=3Dpython
> > =20
> >  ##
> > -# =3D ARM Processor Errors
> > +# =3D ARM Processor Errors as defined at:
> > +# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.=
html
> > +# See tables N.16, N.17 and N.21.
> >  ## =20
>=20
> This comes out badly in HTML.
>=20
> Try something like
>=20
>    # =3D ARM Processor Errors
>    #
>    # These are defined at
>    # https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.=
html
>    # See tables N.16, N.17 and N.21.

Ok. I double-checked the results of both manpage and html on the
version I'm about to submit. The parsed macros should now be OK
for both.

>=20
> If any part of this is relevant in PATCH 4 already, squash the relevant
> parts into that patch please.

Ok. I ended squashing patch 7 with patch 4.

>=20
> > =20
> > +##
> > +# @ArmProcessorValidationBits:
> > +#
> > +# Indcates whether or not fields of ARM processor CPER record are vali=
d. =20
>=20
> docs/devel/qapi-code-gen.rst section "Documentation markup":
>=20
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.

Ok.

> > +#
> > +# @mpidr-valid:  MPIDR Valid
> > +#
> > +# @affinity-valid: Error affinity level Valid
> > +#
> > +# @running-state-valid: Running State
> > +#
> > +# @vendor-specific-valid: Vendor Specific Info Valid
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'enum': 'ArmProcessorValidationBits',
> > +  'data': ['mpidr-valid',
> > +           'affinity-valid',
> > +           'running-state-valid',
> > +           'vendor-specific-valid']
> > +}
> > +
> > +##
> > +# @ArmProcessorFlags:
> > +#
> > +# Indicates error attributes at the Error info section.
> > +#
> > +# @first-error-cap: First error captured
> > +#
> > +# @last-error-cap:  Last error captured
> > +#
> > +# @propagated: Propagated
> > +#
> > +# @overflow: Overflow
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'enum': 'ArmProcessorFlags',
> > +  'data': ['first-error-cap',
> > +           'last-error-cap',
> > +           'propagated',
> > +           'overflow']
> > +}
> > +
> > +##
> > +# @ArmProcessorRunningState:
> > +#
> > +# Indicates if the processor is running.
> > +#
> > +# @processor-running: indicates that the processor is running
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'enum': 'ArmProcessorRunningState',
> > +  'data': ['processor-running']
> > +}
> > +
> >  ##
> >  # @ArmProcessorErrorType:
> >  #
> > -# Type of ARM processor error to inject
> > -#
> > -# @unknown-error: Unknown error
> > +# Type of ARM processor error information to inject.
> >  #
> >  # @cache-error: Cache error
> >  #
> >  # @tlb-error: TLB error
> >  #
> > -# @bus-error: Bus error.
> > +# @bus-error: Bus error
> >  #
> > -# @micro-arch-error: Micro architectural error.
> > +# @micro-arch-error: Micro architectural error
> >  #
> >  # Since: 9.1
> >  ##
> >  { 'enum': 'ArmProcessorErrorType',
> > -  'data': ['unknown-error',
> > -	   'cache-error',
> > +  'data': ['cache-error',
> >             'tlb-error',
> >             'bus-error',
> >             'micro-arch-error']
> > + } =20
>=20
> Squash the changes to this type into PATCH 4, please.

Ok.

> > +
> > +##
> > +# @ArmPeiValidationBits:
> > +#
> > +# Indcates whether or not fields of Processor Error Info section are v=
alid.
> > +#
> > +# @multiple-error-valid: Information at multiple-error field is valid
> > +#
> > +# @flags-valid: Information at flags field is valid
> > +#
> > +# @error-info-valid: Information at error-info field is valid
> > +#
> > +# @virt-addr-valid: Information at virt-addr field is valid
> > +#
> > +# @phy-addr-valid: Information at phy-addr field is valid
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'enum': 'ArmPeiValidationBits',
> > +  'data': ['multiple-error-valid',
> > +           'flags-valid',
> > +           'error-info-valid',
> > +           'virt-addr-valid',
> > +           'phy-addr-valid']
> > +}
> > +
> > +##
> > +# @ArmProcessorErrorInformation:
> > +#
> > +# Contains ARM processor error information (PEI) data according with U=
EFI
> > +# CPER table N.17.
> > +#
> > +# @validation:
> > +#       Valid validation bits for error-info section.
> > +#       Argument is optional. If not specified, those flags will be en=
abled:
> > +#       first-error-cap and propagated. =20
>=20
> Please format like this for consistency:
>=20
>    # @validation: Valid validation bits for error-info section.
>    #     Argument is optional.  If not specified, those flags will be
>    #     enabled: first-error-cap and propagated.

Ok.

>=20
> > +#
> > +# @type:
> > +#       ARM processor error types to inject. Argument is mandatory.
> > +#
> > +# @multiple-error:
> > +#       Indicates whether multiple errors have occurred.
> > +#       Argument is optional. If not specified and @validation not enf=
orced,
> > +#       this field will be marked as invalid at CPER record..
> > +#
> > +# @flags:
> > +#       Indicates flags that describe the error attributes.
> > +#       Argument is optional. If not specified and defaults to
> > +#       first-error and propagated.
> > +#
> > +# @error-info:
> > +#       Error information structure is specific to each error type.
> > +#       Argument is optional, and its value depends on the PEI type(s).
> > +#       If not defined, the default depends on the type:
> > +#       - for cache-error: 0x0091000F;
> > +#       - for tlb-error: 0x0054007F;
> > +#       - for bus-error: 0x80D6460FFF;
> > +#       - for micro-arch-error: 0x78DA03FF;
> > +#       - if multiple types used, this bit is disabled from @validatio=
n bits.
> > +#
> > +# @virt-addr:
> > +#       Virtual fault address associated with the error.
> > +#       Argument is optional. If not specified and @validation not enf=
orced,
> > +#       this field will be marked as invalid at CPER record..
> > +#
> > +# @phy-addr:
> > +#       Physical fault address associated with the error.
> > +#       Argument is optional. If not specified and @validation not enf=
orced,
> > +#       this field will be marked as invalid at CPER record..
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'struct': 'ArmProcessorErrorInformation',
> > +  'data': { '*validation': ['ArmPeiValidationBits'],
> > +            'type': ['ArmProcessorErrorType'],
> > +            '*multiple-error': 'uint16',
> > +            '*flags': ['ArmProcessorFlags'],
> > +            '*error-info': 'uint64',
> > +            '*virt-addr':  'uint64',
> > +            '*phy-addr': 'uint64'}
> > +}
> > +
> > +##
> > +# @ArmProcessorContext:
> > +#
> > +# Provide processor context state specific to the ARM processor archit=
ecture,
> > +# According with UEFI 2.10 CPER table N.21.
> > +# Argument is optional.If not specified, no context will be used.
> > +#
> > +# @type:
> > +#       Contains an integer value indicating the type of context state=
 being
> > +#       reported.
> > +#       Argument is optional. If not defined, it will be set to be EL1=
 register
> > +#       for the emulation, e. g.:
> > +#       - on arm32: AArch32 EL1 context registers;
> > +#       - on arm64: AArch64 EL1 context registers.
> > +#
> > +# @register:
> > +#       Provides the contents of the actual registers or raw data, dep=
ending
> > +#       on the context type.
> > +#       Argument is optional. If not defined, it will fill the first r=
egister
> > +#       with 0xDEADBEEF, and the other ones with zero.
> > +#
> > +# @minimal-size:
> > +#       Argument is optional. If provided, define the minimal size of =
the
> > +#       context register array. The actual size is defined by checking=
 the
> > +#       number of register values plus the content of this field (if u=
sed),
> > +#       ensuring that each processor context information structure arr=
ay is
> > +#       padded with zeros if the size is not a multiple of 16 bytes.
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'struct': 'ArmProcessorContext',
> > +  'data': { '*type': 'uint16',
> > +            '*minimal-size': 'uint32',
> > +            '*register': ['uint64']}
> >  }
> > =20
> >  ##
> >  # @arm-inject-error:
> >  #
> > -# Inject ARM Processor error.
> > +# Inject ARM Processor error with data to be filled accordign with UEF=
I 2.10
> > +# CPER table N.16.
> >  #
> > -# @errortypes: ARM processor error types to inject
> > +# @validation:
> > +#       Valid validation bits for ARM processor CPER.
> > +#       Argument is optional. If not specified, the default is
> > +#       calculated based on having the corresponding arguments filled.
> > +#
> > +# @affinity-level:
> > +#       Error affinity level for errors that can be attributed to a sp=
ecific
> > +#       affinity level.
> > +#       Argument is optional. If not specified and @validation not enf=
orced,
> > +#       this field will be marked as invalid at CPER record.
> > +#
> > +# @mpidr-el1:
> > +#       Processor=E2=80=99s unique ID in the system.
> > +#       Argument is optional. If not specified, it will use the cpu mp=
idr
> > +#       field from the emulation data. If zero and @validation is not
> > +#       enforced, this field will be marked as invalid at CPER record.
> > +#
> > +# @midr-el1:  Identification info of the chip
> > +#       Argument is optional. If not specified, it will use the cpu mp=
idr
> > +#       field from the emulation data. If zero and @validation is not
> > +#       enforced, this field will be marked as invalid at CPER record.
> > +#
> > +# @running-state:
> > +#       Indicates the running state of the processor.
> > +#       Argument is optional. If not specified and @validation not enf=
orced,
> > +#       this field will be marked as invalid at CPER record.
> > +#
> > +# @psci-state:
> > +#       Provides PSCI state of the processor, as defined in ARM PSCI d=
ocument.
> > +#       Argument is optional. If not specified, it will use the cpu po=
wer
> > +#       state field from the emulation data.
> > +#
> > +# @context:
> > +#       Contains an array of processor context registers.
> > +#       Argument is optional. If not specified, no context will be add=
ed.
> > +#
> > +# @vendor-specific:
> > +#       Contains a byte array of vendor-specific data.
> > +#       Argument is optional. If not specified, no vendor-specific data
> > +#       will be added.
> > +#
> > +# @error:
> > +#       Contains an array of ARM processor error information (PEI) sec=
tions.
> > +#       Argument is optional. If not specified, defaults to a single
> > +#       Program Error Information record defaulting to type=3Dcache-er=
ror.
> >  #
> >  # Features:
> >  #
> > @@ -44,6 +262,16 @@
> >  # Since: 9.1
> >  ##
> >  { 'command': 'arm-inject-error',
> > -  'data': { 'errortypes': ['ArmProcessorErrorType'] },
> > +  'data': {
> > +    '*validation': ['ArmProcessorValidationBits'],
> > +    '*affinity-level': 'uint8',
> > +    '*mpidr-el1': 'uint64',
> > +    '*midr-el1': 'uint64',
> > +    '*running-state':  ['ArmProcessorRunningState'],
> > +    '*psci-state': 'uint32',
> > +    '*context': ['ArmProcessorContext'],
> > +    '*vendor-specific': ['uint8'],
> > +    '*error': ['ArmProcessorErrorInformation']
> > +  },
> >    'features': [ 'unstable' ]
> >  } =20
>=20
> This changes the command pretty much completely.  Why is the previous
> state worth capturing in git?

I was thinking on having the first patch with minimal stuff and
letting patch 7 with everything, but after yours and Jonathan's
comments, I opted to merge them altogether.

>=20
> > diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> > index 0e9490cebc72..77c800186f34 160000
> > --- a/tests/lcitool/libvirt-ci
> > +++ b/tests/lcitool/libvirt-ci
> > @@ -1 +1 @@
> > -Subproject commit 0e9490cebc726ef772b6c9e27dac32e7ae99f9b2
> > +Subproject commit 77c800186f34b21be7660750577cc5582a914deb =20
>=20
> Accident?
>=20

Yes. Working with submodules is sometimes tricky, as git commit -a wants
to merge everything including submodule changes, and manually dropping
submodule from existing commits is tricky. I added this to my environment,
but this affects only git diff porcelain:

	[diff]
	        ignoreSubmodules =3D all

I wonder is are there ways for git commit -a to also ignore submodules...
perhaps some git hook?

Thanks,
Mauro

