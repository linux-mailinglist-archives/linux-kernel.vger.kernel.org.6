Return-Path: <linux-kernel+bounces-556923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA95A5D0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBF23B817F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4322C26461B;
	Tue, 11 Mar 2025 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQxVz/tt"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7625D208
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724632; cv=none; b=uxNf6qc6q3Ei7IfGLIlThXx+oUBRt7dUWkYNjM8Ox5vrQcuX3pDSa8pIGsPhn8MA3sQrU5+sIYwBrEryNMFJLMKRVPk1vvNivv+UPAopM7n5mZQni+bxV/LBQpCqrKdzTnK/Iun/0GCoVFgPxSN6W/d2SX2y66tXAv6kIBUK7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724632; c=relaxed/simple;
	bh=sbK9cABnnz6Q1VIMb+kR5gOfZAIpJZMrTjBVB3KKKXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMuId4cO3WEfw1hJnWY3NhMi2HGDObtknenyGZPSlkDKpd6U+WfxLd4KEo6VX4O3BO33IDJEBE7hYML84O2UobjAztNGQ0JWE8r3WtSupKlP8k3sAp+xqstsBJPg7BQdW3BbmuR0/3u1qjcQEC+reWmybxlClatmozB8xeJ65uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQxVz/tt; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476693c2cc2so20421cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741724630; x=1742329430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbK9cABnnz6Q1VIMb+kR5gOfZAIpJZMrTjBVB3KKKXA=;
        b=pQxVz/tt0ci54NN7sP7iO2mIT46iJqFHK8FufU2rQQKu1cO26P8oVGmL+phQ6QLs7Q
         d9LidHQ7uRyi1WqVn8gGoDijhmiGjvpadH056Qj8PJbgL9KYubfKjawaL8wRHmy+3p6p
         lkFS0L/mMvNfZmIJRLUedE7IcyZKJE5FbxDRrcsxAj+NK3Ejt6KnvdAsrvTDYjOx591Z
         IhpOdUJ0cljRZa9CHB6vvbtGpnk7nZ7TKYid2/2z5gsZ+Hi+TzlyFCKZxSDhh0/YY1jo
         sB+C40B5Seequ9YWTq3TduDsFILCoAt2s7tT+xIeNXnj3Pi2tyB4lf1kfM8hbjIZmVd5
         VdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741724630; x=1742329430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbK9cABnnz6Q1VIMb+kR5gOfZAIpJZMrTjBVB3KKKXA=;
        b=nOkYB9M2Kzue8JlmrV3JirWZqfncpjjtApERGFoUPE4zrI++aZdtoDoSGfKEANA5W0
         dS9Mq3fY2k1sLivrTDQIr3LpipnCvCMf0Pfgu5q43KYHlDCW0gizUtkE8jGy0/dgps/7
         ES/SsSpei9mNm2+KBIOugDw7DwOBLJfRWck/2Nthxv8hAFKLIb3oyoMs3NslappcuSet
         vZ7atBt57OpgNpDfPe0KGEtsiqxKqX3gR7ZAgNAM0lWtYCGW8ycgMwN1H/5n9tG0qlOO
         bzHQCa6Zmf17vleyk/lZTlAXI9OiaWnt5cr540RIaod2cxdQsfnXH5eW9RgahI/7cTZw
         rA+w==
X-Forwarded-Encrypted: i=1; AJvYcCXfvto+VhodFy0ENemzegOT5lnxS5eMCcm+S23uGOex0jDBBX5eKFMc+ra0xI0o4bhplTDSrVxSAtDd1MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU4NZL/hgGPsUnbCDsoNvk5YNNM8YhhuG6zCZcmSCZGz82MhXk
	LuqotA99q46E0JpndGYvK+JuKH4yBT1RfG4UglRqKo1UWqY/2QA4kn4uGzBAFFIgUaAa57Aja9b
	g45cldUkSCiiXfKMvFKbDoa8GM8nBeB7jmAUA
X-Gm-Gg: ASbGncu36rkFrPU5CAiVwnfC7umRRMWRch4Y22CUvC4uOWWurnhEDz5UDMDWw2TLQA1
	OgcpfOlB80/ZcdAT0VzN4uk6vHULwhUkWTlpbuaqyoQ4xo9Mc4xWA79gF3j50m72TDygCZybPVl
	5nFnPYjf4U9z1rPAgyemlCaidIuV3kvfvA1p/kJUkNeutQ3q13+MZmkste
X-Google-Smtp-Source: AGHT+IHyVXBYlUvywadtQAERTXME+3zR0NqHXE+KArmz4mpSAh0P1v+MQYs3pjWRQzwPCecq0GLl6pwyK16HiKuZ5/0=
X-Received: by 2002:a05:622a:64b:b0:474:cd63:940d with SMTP id
 d75a77b69052e-476ac172a8bmr1042471cf.0.1741724629891; Tue, 11 Mar 2025
 13:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224124200.820402212@infradead.org> <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
 <20250226195308.GA29387@noisy.programming.kicks-ass.net> <CANiq72=3ghFxy8E=AU9p+0imFxKr5iU3sd0hVUXed5BA+KjdNQ@mail.gmail.com>
 <20250310160242.GH19344@noisy.programming.kicks-ass.net> <CAOcBZOSPBsTvWFdpwE0-ZU76yMDGBEo3p9y614XYEu+ZSnQ6Sg@mail.gmail.com>
 <CANiq72mcCEbeWb-RAXLcWRnJms2LA6xV=QqQ5=N3ii=3TC89fw@mail.gmail.com>
In-Reply-To: <CANiq72mcCEbeWb-RAXLcWRnJms2LA6xV=QqQ5=N3ii=3TC89fw@mail.gmail.com>
From: Ramon de C Valle <rcvalle@google.com>
Date: Tue, 11 Mar 2025 13:23:39 -0700
X-Gm-Features: AQ5f1JrCpGZrgzt8Rl9g-TEKoue7e8xLo-GmbseT14-jYs9UYP7jXIneC8q4GOU
Message-ID: <CAOcBZOQnGCqKut-BTvfJNgB9Rz+f5DAANwMs9DU16Js+QDGOrw@mail.gmail.com>
Subject: Re: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Maurer <mmaurer@google.com>, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	Scott Constable <scott.d.constable@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Kees Cook <kees@kernel.org>, x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 12:41=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Mar 11, 2025 at 8:09=E2=80=AFPM Ramon de C Valle <rcvalle@google.=
com> wrote:
> >
> > I've submitted a PR for it:
> > https://github.com/rust-lang/rust/pull/138368. Let me know if you're
> > able to give it a try.
>
> Thanks Ramon, that was quick!
>
> Left a comment there and linked it -- if you meant to ask Peter, then
> I guess it would be easiest for him to use the first nightly that has
> it as a `-Z` flag.
>
> i.e. I think it is simple enough to land it as-is, especially if we
> add the quick check I suggested.

Left a note there. Let me know what you think. Yes, I guess we could
just check the next nightly that has those changes.

