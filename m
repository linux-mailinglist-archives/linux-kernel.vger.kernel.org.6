Return-Path: <linux-kernel+bounces-556594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 065C1A5CC13
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C361898FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EB62620D3;
	Tue, 11 Mar 2025 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyZJmckW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716625D8EF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713929; cv=none; b=T9qqHih8WjK08WzbJOLgM031HIX3i7vxoUQ3D3LLlHA+W4yFPCtB/XKWRDbpyRmFkLzd7GG7/4V5XirvV6ZRDsDLw7zoyRo9EqdUhkpl6SJUc7zYhDwviOfEjh40jXHT5Xo1oBcFogPeRDF6ntY6HEmWEMUUNKUxOVqeIyFRHx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713929; c=relaxed/simple;
	bh=fYdyjGQENlbBBWop5wPZ4E4v3pT6J/GprpzcwR81VYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzoG4oS5M/uSfNu0CZzZsFKKI/HMUoGxvATl0zyKQEP/Mn3nAR9/NcshpE58UJZP8bB5+B9Wr/0/y8NlhQQShODF2IXD2AvJx+aInf8/NdYFjLDYluj0lRZf7p3mBI91EoWJ8oYqZgoDAFAbE+dvTJJKt2Vo7B2HsvL8zLJALgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyZJmckW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA978C4CEF1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741713928;
	bh=fYdyjGQENlbBBWop5wPZ4E4v3pT6J/GprpzcwR81VYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pyZJmckWsXHtJabUsuIypg+gvFZ9+9Wb5bfRyl+Gk3GnOxzouTX6Z7VFp1U5XPudl
	 YvMTqATepRudr618OBYeZ2yryJ7rJAMgVR/V3pz6J+AOd8vD4pr7iUi1B9JdRFKkZq
	 PPyGD0S4HJDVMscQb9MeCWnCu/nKp+dCTeFtGY25Rsl64vfrQpuzjcoKGz7auyoC44
	 w/ZL86HOVWY0gqp9jkFp41P3kZ+I6jOSsBJtPiZROlid9DhLZJHPyFFiB+z6XpHNjf
	 j2L3RFv1b8FojXtV9LKeFr3SwXlog5qf2dqWWzle7PkcKsswaI/hkoZNwxhC3bM9Z7
	 fAAGLgIpDAmJg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bfca745c7so39302131fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:25:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRt+2GHrHcNyrGhLeXLLPXyCxMEJngvm1a2WiHXaghbto+Vj+0WRrXEmVFiEE3MikPf4HH9/hJmfalLps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB6tvBT1vKOm34REMMzg7f3RkP1NNrEOp08l4j+njtDOhzo0DZ
	4+AuiM+gpSjO2rjnpgoEDQ2Y/vfyyyxjAamlBEj4Y9tXN48qbvv0bPSc5SbIewTZVwyiDkgmt9l
	VVQR/pg05r5uv4C9pvzeZALOwaP4=
X-Google-Smtp-Source: AGHT+IH7D4IUsKeREpKcYfIzNhF1CnBC4RH0E5H8i6l1Ax8pmRtMh1fpCOktzkFFAvOJHyL1yeIvWJaVIfZyz4jMcHU=
X-Received: by 2002:a05:6512:1242:b0:549:66d8:a1f1 with SMTP id
 2adb3069b0e04-54990ec56b5mr7481639e87.45.1741713927062; Tue, 11 Mar 2025
 10:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307164801.885261-2-ardb+git@google.com> <87bju7o65f.fsf@redhat.com>
 <3AD32490-F072-4C10-A732-E5BF1E303C43@zytor.com>
In-Reply-To: <3AD32490-F072-4C10-A732-E5BF1E303C43@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 11 Mar 2025 18:25:15 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHZsk68kVA=dFbCb3yCrLJmHvn7HZ-qqSjjuQkdUf9_2Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jra2JKKBjscEO5O-0UQyjrkazjeptLW3Jr9OgT7GHDGuAJIOzng1DllhIw
Message-ID: <CAMj1kXHZsk68kVA=dFbCb3yCrLJmHvn7HZ-qqSjjuQkdUf9_2Q@mail.gmail.com>
Subject: Re: [RFC PATCH resend] x86/boot: Drop CRC-32 checksum and the build
 tool that generates it
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Gerd Hoffmann <kraxel@redhat.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 18:14, H. Peter Anvin <hpa@zytor.com> wrote:
>
> >Ard Biesheuvel <ardb+git@google.com> writes:
> >
...
> >> it seems quite unlikely that this checksum is being used, so let's just
> >> drop it, along with the tool that generates it.
> >>
> >> Instead, use simple file concatenation and truncation to combine the two
> >> pieces into bzImage, and replace the checks on the size of the setup
> >> block with a couple of ASSERT()s in the linker script.
> >>
...
>
> Please leave the bytes in question as explicit zeroes if possible.

Keeping the

. = ALIGN(. + 4, 0x200);

in arch/x86/boot/compressed/vmlinux.lds.S should be sufficient to
guarantee that the last 4 bytes of the file are zero, so it is quite
trivial to implement. However, I'm not quite sure what purpose that
would serve: could you elaborate?

