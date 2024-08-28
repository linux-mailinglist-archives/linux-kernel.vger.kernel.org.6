Return-Path: <linux-kernel+bounces-304713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D4E9623DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0DFB21046
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072916A396;
	Wed, 28 Aug 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="or4cHeG4"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8C16728E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838428; cv=none; b=Hgqm05GfyR50bGze2uxScl3U0y64ucvPLclmRNA4FQ8jGe4ruWZTE8+cek7c50TcHFh0YF25ZPxYD529a7aRB+4rIPOGu8gzi4tS2yS5gnkKQv8LawoJG9L0RWXNbbKDk5HuZv0ppa8LhqpepiMaZQKGglIeMGxt55yWvFmYkl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838428; c=relaxed/simple;
	bh=JaahmtBNvMYpYGDI8TfWiHxXUqqgkc9FlY7+LPCUrzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1BvBQ5ngs2TL1n8BGASZvLkag0JV4CCcspEf4Ok/yse08RuPp5EqSPcRKo+gJugDiEonv6sESwwtPzDCNyMr6o2fH4BaQ94BJLoWmajIRg4dSHgdUzOS8FdL/429imespg1upN+M9PH1BP5g/oks/zUV+qNRziVlcvOB91UQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=or4cHeG4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371afae614aso3427978f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724838425; x=1725443225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4FnjsYFSElhR+3f7IugFyQV34/agqN5SguHwrwKdRE=;
        b=or4cHeG4LREv2WCATRM1JdsEkUyYTm03bcdXlgfrhCGX7AhQY/hHX8ao5qn7FcSorp
         8x6uYfJmWkMAJNUKHOzdPS0aCXEsYbXGf+vfPVjiQ7LHqIQC3Pigmin84W3YKpBbDHbz
         bxB9d6eRmh69mx+NPI5KF20gGCthAlElKQDhid26YhB03C71tGGeAF2t3sZs3CtkzE1Y
         WnqJouMgGhxNRABuLDkza4yfVVa8D/ERhDSmfhrx9Wnh7S3RVj9G7YoZ7czx8jmyc9AQ
         Deyz1Jk/woPBYJhVHr4cBQRJUCKbupX2j/7hov/FMbYU2Zbpf80uou5q6/7NsyBgIVEj
         4mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724838425; x=1725443225;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4FnjsYFSElhR+3f7IugFyQV34/agqN5SguHwrwKdRE=;
        b=kri1LukkGScTDY+I0VgcfZpMT0eVPsJEwAauqfCIBS8sA/RIwk64s9XfumtR5Rnkqy
         9FMo1C14EnSJX9f037rHyEMlE9oMPx9iYVANUoxgKGGJfkoH8bHsevPBUat0lxri08nZ
         cd7xlGCpZrce5OiRCnBRCzbCaCNJyTHJANtHMDESmCyH3beS/MJ308905QFFj3yVvwS1
         XNF6lRfye76xmHCGomvz+iNRkxZhO9L4CaHoQqSUigIxei4P+uaJPmPxb5PjbuPG9LmG
         wV8mB6ghKUsubWNiCljmIR4MeJ5qInyGRKl2yv6jmzDNQCrI8TpuoK4g4j7LP0dQuwb+
         EO1A==
X-Gm-Message-State: AOJu0Yz+TE9HSl4gfo7W/xKy2tKHBY1tRQ8bif3vFJk/Rh6NXmWQ11z8
	aILZm5nz1rYRXTUOyvh68umRtiXiFVjw1NS0jYdAivN9+5JOW1gkgzJo9/KfDdE=
X-Google-Smtp-Source: AGHT+IH0KC6Z0HHx3zEIhScnAd0zosTOFRut+SoaKBSOi0hUzOh0yIoDnTQbgYeiAVq0L8twAXC6cQ==
X-Received: by 2002:adf:f7d2:0:b0:368:77f9:fb34 with SMTP id ffacd0b85a97d-37311857bf9mr9665467f8f.15.1724838424122;
        Wed, 28 Aug 2024 02:47:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c0dcsm15170235f8f.37.2024.08.28.02.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:47:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 999935F796;
	Wed, 28 Aug 2024 10:47:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: D Scott Phillips <scott@os.amperecomputing.com>
Cc: linux-kernel@vger.kernel.org,  kvm@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  kvmarm@lists.linux.dev,
  maz@kernel.org,  arnd@linaro.org
Subject: Re: [PATCH 1/3] ampere/arm64: Add a fixup handler for alignment
 faults in aarch64 code
In-Reply-To: <86frqpk6d7.fsf@scott-ph-mail.amperecomputing.com> (D. Scott
	Phillips's message of "Tue, 27 Aug 2024 14:23:16 -0700")
References: <20240827130829.43632-1-alex.bennee@linaro.org>
	<20240827130829.43632-2-alex.bennee@linaro.org>
	<86frqpk6d7.fsf@scott-ph-mail.amperecomputing.com>
Date: Wed, 28 Aug 2024 10:47:02 +0100
Message-ID: <87plpt3rop.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

D Scott Phillips <scott@os.amperecomputing.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> From: D Scott Phillips <scott@os.amperecomputing.com>
>>
>> A later patch will hand out Device memory in some cases to code
>> which expects a Normal memory type, as an errata workaround.
>> Unaligned accesses to Device memory will fault though, so here we
>> add a fixup handler to emulate faulting accesses, at a performance
>> penalty.
>>
>> Many of the instructions in the Loads and Stores group are supported,
>> but these groups are not handled here:
>>
>>  * Advanced SIMD load/store multiple structures
>>  * Advanced SIMD load/store multiple structures (post-indexed)
>>  * Advanced SIMD load/store single structure
>>  * Advanced SIMD load/store single structure (post-indexed)
>
> Hi Alex, I'm keeping my version of these patches here:
>
> https://github.com/AmpereComputing/linux-ampere-altra-erratum-pcie-65
>
> It looks like the difference to the version you've harvested is that
> I've since added handling for these load/store types:
>
> Advanced SIMD load/store multiple structure
> Advanced SIMD load/store multiple structure (post-indexed)
> Advanced SIMD load/store single structure
> Advanced SIMD load/store single structure (post-indexed)

Are you going to roll in the fixes I added or should I re-spin with your
additional handling?

> I've never sent these patches because in my opinion there's too much
> complexity to maintain upstream for this workaround, though now they're
> here so we can have that conversation.

It's not totally out of the scope of the kernel to do instruction
decoding to workaround things that can't be executed directly. There is
already a bunch of instruction decode logic to handle stepping over
instruction probes. The 32 bit ARM code even has a complete user-space
alignment fixup handler driver by procfs.

It might make sense to share some of the logic although of course the
probe handler and the misaligned handler are targeting different sets of
instructions.

The core kernel code also has a bunch of unaligned load/store helper
functions that could probably be re-used as well to further reduce the
code delta.

> Finally, I think a better approach overall would have been to have
> device memory mapping in the stage 2 page table, then booting with pkvm
> would have this workaround for both the host and guests. I don't think
> that approach changes the fact that there's too much complexity here.

That would be a cleaner solution for pKVM although we would like to see
it ported to Xen as well. There is a tension there between having a
generic fixup library and something tightly integrated into a given
kernel/hypervisor.

I don't think instruction decoding is fundamentally too complicated for
a kernel - although I may be biased as a QEMU developer ;-). However if
it is to be taken forward I think it should probably come with an
exhaustive test case to exercise the decoder and fixup handler. The
fixes so far were found by repeatedly iterating on vkmark and seeing
were things failed and fixing when they came up.

I will leave it to the kernel maintainers to decide if this is an
acceptable workaround or not.

I do have two remaining questions:

  - Why do AMD GPUs trigger this and not nVidia? Do they just have their
    own fixup code hidden in the binary blob? Would Nouveau suffer
    similar problems?

  - Will Arm SoC PCI implementations continue to see these edge cases
    that don't affect the x86 world? This is not the first Arm machine
    with PCI to see issues. In fact of the 3 machines I have (SynQuacer,
    MachiatoBin and AVA) all have some measure of PCI "fun" to deal
    with.

Thanks,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

