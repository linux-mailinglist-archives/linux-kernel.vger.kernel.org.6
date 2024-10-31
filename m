Return-Path: <linux-kernel+bounces-391215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A49B83E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2571C21100
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1AB1A3BC3;
	Thu, 31 Oct 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qmx5JRG/"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBDF14D44D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404844; cv=none; b=IndCjtyDQCsJbzhB1I2WzGdK3wTgK5RFYdJPF3ZXgZ162FjsHlHZSjYuwfAmQ+nIpeWMlVPFHmaEQqEI42lXi5T+T94PBrqxuXCdKl4AFZszWTIwk+VFRq606z3sNeWEJ2BrHEm8Wc1Keqd9ZgaXwZH5KyKzVc0Myyb5h2sLBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404844; c=relaxed/simple;
	bh=iDAzPgn9vQQIclwk4KVakaDzMOUp56nE/SfuLH3hk08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8To0/gG5y1hkkPF+aSGn39X0+uJtNSxpuuJ+CXtK3NiCq6qQRj5JyXGCuMID7ed5Za//M/q/S7ODQgxnx9Lwxi+hCay7e+oMDFljKnYFZOPHoFFhT2rOT7dVLQpVRXPnDtZLcolSWVgDR6j8IgspRkQxMvFTNnr8KHzLUYN4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qmx5JRG/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e66ba398so985e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404841; x=1731009641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jkl3TjMzcf3dryOCaAILRFpWIEyfiit3GjcJM3g5SKw=;
        b=Qmx5JRG/WvY08/igfKnIIa69WHbuc/1HW5WvS5i20r3Ai+ppafazCqQLnE8dxX3FV/
         I1QY/ye7Og5rWWfPTtdXqbccGBxEQvnAIAtzkeScYnWZVCNygPnvCJOWOUpUssjqO+5K
         J8IlybxA+IqOYd5c37tHWU3SA9S/jl3m9lCBrcJe1/sBRyWLLSqRMBuuTxT5mJdNZZni
         sYo1izj3l6ptsaTZYCuLpfUgDNZtKLGPa4ysJdfV5Yvc+mML/5RElZfFbvGazsTh5qD1
         E6+msdA1dxmRntK4BMjPS4x7RmgG+P/nlzQxMX0kWVcwLMeoVdnoCNY0AR4fsA6bEyaD
         i5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404841; x=1731009641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkl3TjMzcf3dryOCaAILRFpWIEyfiit3GjcJM3g5SKw=;
        b=moLEfn+16SHLuKaO3sf5a3m5oWiTA/EITIcehmaKJrwywcSzWYpWvynYUoUPQsL1Ex
         PoIx9pEPvNRimQumHkThB8sAYDPZihtxJmEAO5FPZD0ZT+pYIQAgzU7qiTTYs1w2N6K8
         PzvwDTM45Cc9jqkHAF4gtOy+wemJEtR3PBMD70rT0XKg/Hrp5oULN9MB4nuTunmSjjbV
         PiWMAG/XsQEAPf9Fg/e2OmWxu0wJSLryJri6sW2XCeJfdcSCDgdgcSMfMteHdI+Y0bhS
         UrSuRUgcj8H6lFhaCBr7gQ1wUu3k3Qwl9SjeEcwiLYufuJMefMcFMag/8c70t9WJz654
         I73Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUVIeJNe/Sb+JBeQgZGtqMUnjtzibluu3Jo1ndq6AJZLqVm1eiRXS2Ra1wT91v+Y34ffk3PdPWB11V+6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bSv4CdVgY+oF2fS5Areg4HmO+Nwvpnbfq70X4/v5eRCy6hDb
	GvU7ca5O9U++9ly/W+Mx9iVdcj8z9ZovC1UXB6LU0aPkLDf5KZiEqKbUodBHYoU9oQpugjJ4aVr
	K4+LB2fjIX8/jI8i5ARUD5d96sm2IPoqMJcAg
X-Gm-Gg: ASbGncuRJ4v4lUJ6tv+tIDfylOYdv/sDGnLhHVz1jzMP4hdUFrHfcswhf/y8uylS1Tr
	597R/l/jelSSaQdq2KrnvO7dmb5NkBi2FUw1VeE4np+GHG0GyQvIXiGeM5UWZbA==
X-Google-Smtp-Source: AGHT+IEW2y5lzn/VGPepBdOsO+AzXleOvvzprjMKDOQXm2ENavWPeRp4bswreZ8MVte2QFNa89v1fS8lAyebQn8YFdc=
X-Received: by 2002:a05:6512:4024:b0:53b:5ae5:a9c8 with SMTP id
 2adb3069b0e04-53c7bb8e9f5mr385129e87.7.1730404840475; Thu, 31 Oct 2024
 13:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-extended-modversions-v8-0-93acdef62ce8@google.com>
 <20241030-extended-modversions-v8-2-93acdef62ce8@google.com> <ZyNr--iMz_6Fj4yq@bombadil.infradead.org>
In-Reply-To: <ZyNr--iMz_6Fj4yq@bombadil.infradead.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Thu, 31 Oct 2024 13:00:28 -0700
Message-ID: <CAGSQo00F07viDHQkwBS8_1-THxJHYwx9VkS=TXC5rz3i8zSZSw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] modpost: Produce extended MODVERSIONS information
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The question is, if only extended moversions are used, what new tooling
> requirements are there? Can you test using only extended modversions?
>
>   Luis

I'm not sure precisely what you're asking for. Do you want:
1. A kconfig that suppresses the emission of today's MODVERSIONS
format? This would be fairly easy to do, but I was leaving it enabled
for compatibility's sake, at least until extended modversions become
more common. This way existing `kmod` tools and kernels would continue
to be able to load new-style modules.
2. libkmod support for parsing the new format? I can do that fairly
easily too, but wanted the format actually decided on and accepted
before I started modifying things that read modversions.
3. Something else? Maybe I'm not understanding your comment?

