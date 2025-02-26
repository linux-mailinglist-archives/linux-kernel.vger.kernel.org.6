Return-Path: <linux-kernel+bounces-533326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A46A4586F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA071894802
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5CB1E1DF3;
	Wed, 26 Feb 2025 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF7Nkb6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57BC258CEF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558833; cv=none; b=eeqTsOoDyb7nRi11u8nr2u060c590d7VnxaRio+mxGadLCU7Ns2zQAU1s+xIq3oAS5WiQBFhEJz9/LMNcbtq/l/tMb7oQeutipv9+buiIMfQkslwnjy/lZRbk+vj3ZMk0itZzWdJ4T0+L7rrbrgJiSjUUIUv06jq0aEdnhHWKEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558833; c=relaxed/simple;
	bh=h4n+Ms5pL1bQf2A43JK9AnzZQ4jrDTIzztujw/nMLhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFCiKL1z6N8aLZIAYGtolUcbZAW5yEhQlKM2AS0GqQeRRWZD6LvgzfKtfi2oMMlm9Qw0EXzQlEABV1YM4sbK/PjmN4EtWcHkb1bh60T4K0IF0PioyHbirpRSWlbksT7iXtg3//AZBPqSzBM3QxIRueEMP2035bcvRP0cqs0/LCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF7Nkb6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2791C4AF0B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558833;
	bh=h4n+Ms5pL1bQf2A43JK9AnzZQ4jrDTIzztujw/nMLhY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fF7Nkb6EFcuQ2nWpn6NflNcAIyCSopyGB/ujzXI044JXfu4BnqLWzNubAe+Cb33pc
	 QG2mmc4mqOTvDXR3wcjG0qPUonAST0mVOMTr9lMePVzgmTUOtnoZU0AnAa9Z74VaGr
	 e4ygJuCHnFVma1bXj/yU13S6bfSrRSKn0vL9CxIC7YAnxujdRKI2SHzQyCng6c6ZDv
	 cdNN5lNObsL930f0yNVkam1Duxxh6GzXE2pzNEPEi2b1GRXZa+hKSbEdZHKRJQNI+J
	 22596hgvl+v3/IkOocxH+vYFBtCn37e6xfSxWwSWCuoZGIszMQemuR6jOD+Qh3fF+Z
	 9JXFA9u+ROFzQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5452e6f2999so6930539e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:33:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFCW/vdB7JblhwRT57TA7Fda1vcbgL3xQU8irj9Sg3hemFnsjgaWKTWPPmXGE7NpCMiB1EFnUQRiIVK5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/yJpfp7SiWasoI/yDfD8WOcAinMy/jqToz9DRGQ3YfgiBAWkE
	Q3VL7Qs9NQ1Cb2q5jRaBnZQGefJ2uDDeS3Nvtb+DX43L5ca/QPrq0cADPJsJiodLfmR15DJ4diE
	KhPa3lLOYeo/h2f7tDY4ukU8DHS0=
X-Google-Smtp-Source: AGHT+IF/9KPwCKz/aTELvY1XPdqB6cBdhDW+Aul55vhx/tWDsKal1Jxjza19tj1JccT2kVzCsDOzqsJlMlUX/R+oPRs=
X-Received: by 2002:a05:6512:39c6:b0:545:2871:7cd5 with SMTP id
 2adb3069b0e04-548510cf95amr4870815e87.15.1740558832065; Wed, 26 Feb 2025
 00:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225114638.2038006-1-ryan.roberts@arm.com>
 <CAMj1kXHNO+iB4vNFz-4tR_9CPzv96hn+RW=eqyZXMGy_AySDpw@mail.gmail.com>
 <20250226001047.GA24197@willie-the-truck> <CAMj1kXH=tPuM+irCsKgycUTbts8h9vD4m3tEtw51YFzWafdSUA@mail.gmail.com>
 <b0578d21-95cd-4d8a-add1-87299f36b491@arm.com>
In-Reply-To: <b0578d21-95cd-4d8a-add1-87299f36b491@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 26 Feb 2025 09:33:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHJGC9aYCwwb2XTWfhAjH6GDKQptNdLwO+hfv6hazivHQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrfVJEmlrpBhoXqMjR9dAVnG364eO1ZQeuCfzmi2NJ8RHVsmdaWEeUcBJg
Message-ID: <CAMj1kXHJGC9aYCwwb2XTWfhAjH6GDKQptNdLwO+hfv6hazivHQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Luiz Capitulino <luizcap@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 09:07, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 26/02/2025 06:59, Ard Biesheuvel wrote:
> > On Wed, 26 Feb 2025 at 01:10, Will Deacon <will@kernel.org> wrote:
> >>
> >> On Tue, Feb 25, 2025 at 07:05:35PM +0100, Ard Biesheuvel wrote:
> >>> Apologies for the breakage, and thanks for the fix.
> >>>
> >>> I have to admit that I was a bit overzealous here: there is no point
> >>> yet in using the sanitised value, given that we don't actually
> >>> override the PA range in the first place.
>
> But unless I've misunderstood something, parange is overridden; Commit
> 62cffa496aac (the same one we are fixing) adds an override to force parange to
> 48 bits when arm64.nolva is specified for LPA2 systems (see mmfr2_varange_filter()).
>
> I thought it would be preferable to honour that override, hence my use of
> arm64_apply_feature_override() in the fix. Are you saying we don't need to worry
> about that case?
>

I wouldn't think so (but I'm glad you brought it up because this
didn't occur to me at all tbh)

With arm64.nolva, both the VA and PA ranges will be reduced, and so
the range of the linear map will be 47 bits. So if the PA range is
being reduced from 52 to 48, it will still exceed the size of the
linear map, and so it should make no difference in this particular
case.

The use case I had in mind was to allow the PA range to be reduced to
a value that is substantially less than the range of the linear map,
e.g, 40 bits on a 48-bit VA kernel. On the Android side, the issue of
the missing linear map randomization has come up a couple of times,
but there is no clear direction at this point, so adding this feature
here was premature (mea culpa)

