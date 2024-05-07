Return-Path: <linux-kernel+bounces-171085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE018BDF9B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66418282D08
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A3D14EC65;
	Tue,  7 May 2024 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdNtBAnE"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384614E2DE
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077464; cv=none; b=Nm+7nkO8xj7lM8Izb41NOVMxMsvIBdmhoRgmKaNWtkqj+xAWQ1KmGIBgqbuWMv7f9O9hP1W6ThqupwCcOSTzuLW67zSN55TEf8+PX8rjje7HDAk+C7pNqpgR+lr5h+L/EvXnPu/hNn/4Ev/9csOUEpWqJNF9xnED/lAsuyuedmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077464; c=relaxed/simple;
	bh=RrYjROTDfJeyKc0YGUAw8FfKa4f5MwRcggN89Y+XeJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MOLYUbCQ+THGSHQnXJ2aVwV1GxiVjZyJRAT/CVvXcfxx2D3OTo1vINZ77D04snd9FEy9knCfyPKykGGOPyyQtXBLANnj3cYQXKK55BM0UrA5AWAMj2dYObOFCQoRePiS5qotWfJ8W1VfePdkcX5WOQFw5bVWN9Szk5WoQQSiark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rdNtBAnE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b794510cdso24032185e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 03:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715077461; x=1715682261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YZbBZ6dudLkSPwyvQd1bbhClktoit8Kjm89gQzGu+Q=;
        b=rdNtBAnEucN3YdI40w4sUuqJTUm5C+AYaucpckcTImNb51RBNrDmsL7s3Fn6tUhhJS
         7T/rpu/xl89zwXU2nUjKSWq3hBUDQWWkMgEh2P+OmNwK0WAHQOupgfpLU9IXOT8JZygR
         6H0fZl33TV1aRQ3fZVVkBPBmOIR00df/ozjXa5r5vI4YcQU/ZneSEk5xPUYtEwRAqxmk
         QG3gyb2EabypiqrPrMwP6pVisyKtXR5sOC/jKNu2BNfhXQFQ7c8QCD3DDZ0JWLTlJ9yL
         er8zYZf2XTxFtmwvISzmaLsNoIB5DKXsVxgRi6jougxfp++ss2lK1oErjn66CcLVE2El
         q1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715077461; x=1715682261;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YZbBZ6dudLkSPwyvQd1bbhClktoit8Kjm89gQzGu+Q=;
        b=MjvZffjkQug8TfKpJq2abu3nfd42RUGnbjuBC+IRhFdovO7YpU7HWo4DEeSqG7V/5O
         XGOkcNgRl9YWfJcYtJQFjrs78Z7gXN8IO+ZgodeaIjt0hSgg3sCK5wZ/BFUiN/gpG1UC
         YQPMRGMtckm/EbyuVLBfI66mMIfohFs0RPO5v4AODXskXSky3fUCqulFUr/4ZFlqCnli
         XlOb44qpLKMmzLWKZlm0+Qnx+bsRvGvocA+MAV7oDzsOEeCQucXdRzRXc3GtnJhHqCj9
         q+p0unrG0X5Lswl6zv9ZmfLVHg2Jm5YCMjTo3nF73I1/pVIfnHnfkIEEIzbDhfVdE621
         vNBg==
X-Forwarded-Encrypted: i=1; AJvYcCVNZFnALXJUtH/P79mn7Xvutj9A2hnV8cvEWf27kgsLylh15wjAllmK9lqKSCR6th9cayr/rQGFOF64Uj/k61uBRC/og1F597t7jZnY
X-Gm-Message-State: AOJu0Yz69jZINkIwZ0/1cqBn1BpFoKRVqHmEkSFTLHcHZSqOYRQJbo3h
	YkKO2JJoq406evWlXiLNylEejZDH1F8ZO+zUJQNDcUIZwUbB1K0TuuG2LJg7wMk=
X-Google-Smtp-Source: AGHT+IGBnROswMr6fiz4/nCludnMfVTnbGRYLGjJVGEbGLobnst3vIfHHqoUXu/8DrmIadb42FmShQ==
X-Received: by 2002:a05:600c:3b29:b0:41b:8206:2c3e with SMTP id m41-20020a05600c3b2900b0041b82062c3emr8788581wms.40.1715077461332;
        Tue, 07 May 2024 03:24:21 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id fm9-20020a05600c0c0900b0041c23148330sm22850929wmb.10.2024.05.07.03.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:24:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 6C67E5F87D;
	Tue,  7 May 2024 11:24:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Will Deacon <will@kernel.org>
Cc: Hector Martin <marcan@marcan.st>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Marc Zyngier <maz@kernel.org>,  Mark Rutland
 <mark.rutland@arm.com>,  Zayd Qumsieh <zayd_qumsieh@apple.com>,  Justin Lu
 <ih_justin@apple.com>,  Ryan Houdek <Houdek.Ryan@fex-emu.org>,  Mark Brown
 <broonie@kernel.org>,  Ard Biesheuvel <ardb@kernel.org>,  Mateusz Guzik
 <mjguzik@gmail.com>,  Anshuman Khandual <anshuman.khandual@arm.com>,
  Oliver Upton <oliver.upton@linux.dev>,  Miguel Luis
 <miguel.luis@oracle.com>,  Joey Gouly <joey.gouly@arm.com>,  Christoph
 Paasch <cpaasch@apple.com>,  Kees Cook <keescook@chromium.org>,  Sami
 Tolvanen <samitolvanen@google.com>,  Baoquan He <bhe@redhat.com>,  Joel
 Granados <j.granados@samsung.com>,  Dawei Li <dawei.li@shingroup.cn>,
  Andrew Morton <akpm@linux-foundation.org>,  Florent Revest
 <revest@chromium.org>,  David Hildenbrand <david@redhat.com>,  Stefan
 Roesch <shr@devkernel.io>,  Andy Chiu <andy.chiu@sifive.com>,  Josh
 Triplett <josh@joshtriplett.org>,  Oleg Nesterov <oleg@redhat.com>,  Helge
 Deller <deller@gmx.de>,  Zev Weiss <zev@bewilderbeest.net>,  Ondrej
 Mosnacek <omosnace@redhat.com>,  Miguel Ojeda <ojeda@kernel.org>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
In-Reply-To: <20240411132853.GA26481@willie-the-truck> (Will Deacon's message
	of "Thu, 11 Apr 2024 14:28:54 +0100")
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
	<20240411132853.GA26481@willie-the-truck>
Date: Tue, 07 May 2024 11:24:18 +0100
Message-ID: <87seythqct.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Will Deacon <will@kernel.org> writes:

> Hi Hector,
>
> On Thu, Apr 11, 2024 at 09:51:19AM +0900, Hector Martin wrote:
>> x86 CPUs implement a stricter memory modern than ARM64 (TSO). For this
>> reason, x86 emulation on baseline ARM64 systems requires very expensive
>> memory model emulation. Having hardware that supports this natively is
>> therefore very attractive. Such hardware, in fact, exists. This series
>> adds support for userspace to identify when TSO is available and
>> toggle it on, if supported.
>
> I'm probably going to make myself hugely unpopular here, but I have a
> strong objection to this patch series as it stands. I firmly believe
> that providing a prctl() to query and toggle the memory model to/from
> TSO is going to lead to subtle fragmentation of arm64 Linux userspace.
>
> It's not difficult to envisage this TSO switch being abused for native
> arm64 applications:
>
>   * A program no longer crashes when TSO is enabled, so the developer
>     just toggles TSO to meet a deadline.
>
>   * Some legacy x86 sources are being ported to arm64 but concurrency
>     is hard so the developer just enables TSO to (mostly) avoid thinking
>     about it.
>
>   * Some binaries in a distribution exhibit instability which goes away
>     in TSO mode, so a taskset-like program is used to run them with TSO
>     enabled.

These all just seem like cases of engineers hiding from their very real
problems. I don't know if its really the kernels place to avoid giving
them the foot gun. Would it assuage your concerns at all if we set a
taint flag so bug reports/core dumps indicated we were in a
non-architectural memory mode?

> In all these cases, we end up with native arm64 applications that will
> either fail to load or will crash in subtle ways on CPUs without the TSO
> feature. Assuming that the application cannot be fixed, a better
> approach would be to recompile using stronger instructions (e.g.
> LDAR/STLR) so that at least the resulting binary is portable. Now, it's
> true that some existing CPUs are TSO by design (this is a perfectly
> valid implementation of the arm64 memory model), but I think there's a
> big difference between quietly providing more ordering guarantees than
> software may be relying on and providing a mechanism to discover,
> request and ultimately rely upon the stronger behaviour.

I think the main use case here is for emulation. When we run x86-on-arm
in QEMU we do currently insert lots of extra barrier instructions on
every load and store. If we can probe and set a TSO mode I can assure
you we'll do the right thing ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

