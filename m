Return-Path: <linux-kernel+bounces-518230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ECDA38BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D417A1E18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5947C23236E;
	Mon, 17 Feb 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndl/+yk+"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A24118B495
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818825; cv=none; b=NkxWi0EOcXBMbVVu3XTrewkR/jjP2Iylph/vMM95iGka30Wr6L2TKBII0/H/SbpmyNHl+rIUEacC9NJeOqsodATdljjVDoqIh8/2n0+7s3XmTpseEcRQ+ItNYzJmEy1XaMh+6WoyBxtxHPikOu05inyfePNEH3/wm0XIXNhUwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818825; c=relaxed/simple;
	bh=FbEfh1V/TCyzyVBnzOPjw0bmm27Qjtw3b9033vGjqT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvsjoBii4QWb4rYSTmZb4fkyD91x0Ax1p6YFJyU5/y1s7MdHh/Cco9hJ3KStiDqCmc3VMvqRPkuJQUjiD+nxc9iXjhY/qvHyQGNjB3PGEKVFGFkucfgVIbFKMh8v+c6F/zNBdy2XNMLi2L9/kfE8bOO1cnOmXyRoyFEe/2pXiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndl/+yk+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f31f7732dso1727477f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739818822; x=1740423622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbEfh1V/TCyzyVBnzOPjw0bmm27Qjtw3b9033vGjqT8=;
        b=Ndl/+yk+i+nYGjCVfbQ1oG9feOvhblPVOeHNH50/kYth8udY1oJpvobFVdJQpI4wMZ
         RgJtC84nwQnC2IHV0RQ8Xsdz8qr1/pAxE5TfDhfcP2PpSS/fwSWaK/SBt3QXBTSnkTMh
         oXBqMzmOujUzg0DUgYeue/W3hl186ZRV8bTD9cAW32DnR/2YarFcp+8PtXvEBRs+hzxm
         D1SxF/fhpE/Ok/9231vSiPwXiX737hd+9CkK0/ruMH9WXmJiBNV8sBbAm4MYbhFBS/YL
         +V4Yp1RHxPGK2kDQl6pcwlTBNjRfuqkFXYmFHs3kysrSP4IUS7XgXR8Da/alxZM4gJJw
         x4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739818822; x=1740423622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbEfh1V/TCyzyVBnzOPjw0bmm27Qjtw3b9033vGjqT8=;
        b=S4NCEnsoRz+sS0bepF3L63cj+uXVIiDqjvWF7vdBeuYPEQj50tnmPu5C1egJkWJrf9
         8srplLIbeDzKLobWw4YDh+JbFCBZ6gujches0ko1ThsbiDDG8UxhKXdt9HAbiQO1mw+V
         4NJyD3Tm/WAqbh9bIh7LRbouXarU7ykhr0KLsulFg1qBgCXLXAesp/IrD2k9YnSMPAsY
         I+ymerkw4pwCIuIr8u4Jk7GP4u3z1L2TvDJV6xdV3oK3urwXG6lhgxY8A3jJLkitPbYw
         jzEPVxjznhhrof2sBjWY9axav26Z+/sXKobSVBmLHkvLkZ7p6/GG9t7yKW94+NT8izAc
         QY4A==
X-Forwarded-Encrypted: i=1; AJvYcCXmoXb7oAXIZnDXQdY3DivR2wq3d8mxYvxcWfUd851SdXAfBmn/Yx0ZNVZRFMF7l12cRngRvqZqlMdGSbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyX6TyrP40Bn3hkU3xVmoR4oDSWbS7WpSUA+xmY026uwcv7/s
	JB+0nLcY/E8tvwDJZN//IfRjvCDOFysmW1bVj67tgH2FOdfDXDb3SgkI/yV+1CLxsEjuApYQ/3e
	V9aUvaCE21LgN0rOJOCrtIPBLpo0=
X-Gm-Gg: ASbGncugA1n4HF134cdHh1u2ZgjZLiJZgrWiGF6tEl2ir6KI8bSP6z4z0zjAVtDa5WT
	Opq5IMg0tkchnd/79KxX9NI45wNTlVqy3DEK2yoogcsupZvVhQSV2vinIWoKqT5wAMIks5hbtx8
	U=
X-Google-Smtp-Source: AGHT+IHcNajZe0ENO6NqqO6ktnv6S1yT2v8yKjsxjfUHFFdU9DGQ1lgEBrKS4eB3xN2pkGDfNvSOKZpFCcjlLy+KwRc=
X-Received: by 2002:a5d:6d81:0:b0:38f:2c10:da1e with SMTP id
 ffacd0b85a97d-38f33c288cfmr8157628f8f.27.1739818822023; Mon, 17 Feb 2025
 11:00:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZeBEe3VWm=VfYvG-f4eh2jAFP-p4Xn4SLEeFCGTudVuEw@mail.gmail.com>
 <e7t5yzfw3dq5stp5xjy5yclcx6ikne4vwz7d6w2ukfw2b7gr6t@oomoynf3b2jl>
 <zjuvfdbl7q76ahdxk3lrgaznk7vjj43f5ftzfgrnca6dqtcd5x@5qj24womzgyq>
 <CA+fCnZfySpeRy0FCFidLdUUeqp97eBdjAqQyYPpz1WxYwcsW9A@mail.gmail.com>
 <aqhm7lc57srsfuff3bceb3dcmsdyxksb7t6bgwbqi54ppevpoh@apolj3nteaz6>
 <CA+fCnZdjTkreTcoo+J8wMhwDuAFM4g33U5BFy0OPtE0UCvyJbQ@mail.gmail.com>
 <CA+fCnZcoVdfXVN8VBFLx835cV0eGAT6Ewror2whLW761JnHjNQ@mail.gmail.com>
 <sjownmnyf4ygi5rtbedan6oauzvyk2d7xcummo5rykiryrpcrt@kasomz5imkkm>
 <tuwambkzk6ca5mpni7ev5hvr47dkbk6ru3vikplx67hyvqj2sw@rugqv7vhikxb>
 <CA+fCnZcHnWr0++8omB5ju8E3uSK+s+JOFZ3=UqgtVEcBzrm2Lg@mail.gmail.com> <kmibbbrtlwds6td64hloau7pf3smqth4wff33soebvujohsvli@kni5dtvpwsxf>
In-Reply-To: <kmibbbrtlwds6td64hloau7pf3smqth4wff33soebvujohsvli@kni5dtvpwsxf>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 17 Feb 2025 20:00:10 +0100
X-Gm-Features: AWEUYZlRIhjmXsKyPCZOszIx8_jhLBbTZLCGYgAeVzNSeJCRFZ5-FeRBt2Jwp0w
Message-ID: <CA+fCnZfBsQd=nJVu7QOX09w6uR5LK1Gc5UqiHS8aCxzhDJsssA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Will Deacon <will@kernel.org>, 
	Evgenii Stepanov <eugenis@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 7:38=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> >I'm a bit lost with these calculations at this point. Please send the
> >full patch, including the new values for KASAN_SHADOW_OFFSET (do I
> >understand correctly that you want to change them?). It'll be easier
> >to look at the code.
>
> Sorry, this thread became a little bit confusing. No, I think the
> KASAN_SHADOW_OFFSET values are fine. I just wanted to embrace the idea of
> overflow for the purpose of the check in kasan_non_canonical_hook().
>
> But I'll put down my train of thought about the overflow + calculations i=
n the
> patch message.
>
> >
> >Feel free to send this patch separately from the rest of the series,
> >so that we can finalize it first.
>
> I have the x86 tag-based series basically ready (just need to re-read it)=
 so I
> think I can send it as whole with this patch and 3 others from this serie=
s.

Sounds good!

