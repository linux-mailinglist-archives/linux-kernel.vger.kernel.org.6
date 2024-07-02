Return-Path: <linux-kernel+bounces-238188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8750D924694
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3921E2826D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051D11BE874;
	Tue,  2 Jul 2024 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8PEBxd1"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92D61BBBD7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941985; cv=none; b=vE/+jS+2VYrQwJ43nPPAE6A0veW5xoWCMTy1uPQCGSbaXlfB1MYJM/mXVJ6m/kIQ2e5wdB9P705fs13tuJrrrn7G/3OAnXxtKTMsYURb+uVlQZHjn2UXyiGXS18fESY//ZWFfA2qJqW9sj9Tr1VhC71Uqs+wHiM+B5/tpJ/o+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941985; c=relaxed/simple;
	bh=QlpvXG/LgibJyXK6E1rumspc8P6BBUlQPRcKtdcwxm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5A3zg9xZcfh02avgRkx6lcepVA070gCKKQXfhRtBl/a/ob5U/V/RFEHvKz3MR/VZGrDonO72YNYUNmnBpPE+0MvNKtimCfY1S2uSyeMX2UKqnCETu9E8uayxg4Ugqxv98fcgCT7xQPKVQmD2zo8roz1VZX0YaFOr6kYFqsbp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8PEBxd1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso4908397e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719941982; x=1720546782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz8pkBTyEqDD1ohwerHDRnUgJUoGMLVYZpzfAlDWlFI=;
        b=t8PEBxd1Jw8B8tiPlIDiBtZ3skhTzj974FEg0+Oz5/du0yr2FeXMOIGT7RR4cUB71a
         3roZBGs69YKh0GgWfWuI2tBVeKIeULjChj7zSbIlbkxnViBfjC+RzAS/G2W3UxmasgPo
         Fmy/8kwAuP80YUZAboo5WiZn8VvM6+4wTyiQ8Kk3j4zCqWk+lG72yzX3HoN3M8hyW52H
         8Z/PUjrLWdONLBbTLpowi4cAD1DtX6YAeAxy6u0j8Cr507p3ShYXhWilQlOt2kRcufex
         EWhDxZ22hcKcgbAFVjV0fGsiBawHVN3PMsKk9pTZMdZRtBUyoLVHI9MsJgkudt/L/v0o
         e21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719941982; x=1720546782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nz8pkBTyEqDD1ohwerHDRnUgJUoGMLVYZpzfAlDWlFI=;
        b=X3IxamdpvRdOkS0Zawu5L5QbVPlOBsdj5R5Bquk4exIWMd7XhsnNbBHMCBVxJ27iC5
         KeRv858uRT2xF5ln1kih6SqY7SHUHcr1UjgYZcf1rRXhTXymuog0k7zZxaQjL5CduIi7
         IWYir1eVE6VW/G9+TP3ypx3Jnm/2ZlZtl0l14UqrxSDAwZVVb6D+lWxDRPSKH0jtcrii
         L3KbLlhR2/a3rCiCuV3lGa/RoQi2DTi55eX/XioStGn/+SK/+39E9Vywh+tTUGrFORpQ
         yEAAhdJNcqkWaniuQNYBePM01eSahschAPKVktLf+J8dA59Xr8gGRsfSCsTgzBdW9Ygp
         v7IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLmyv+FbLvnYspl6KeoZAEfaGA7yvhLt2Y4HbshZ/CrCaF3gnBtbviY8d+yFFCSr7hUxjEE/5ogtksAtpenH0oo0D+cTt73VBhoIaZ
X-Gm-Message-State: AOJu0Ywd3gZQ7iyg5tep8XOmDSgB2hQ67mMPaxh71JFLtuqaqtT0JfG8
	RqFkqbJOjMR3bTunCWNOlDJSldJ3BcIAiLvmNUC92lXcQEWoUVSWv0RXoy/UVw0KAUzfXkKXfFZ
	f8jfKx0urtwdnqh5q8bjRNqr/E6/axMYVi6BC
X-Google-Smtp-Source: AGHT+IHNCgOfo07FxQq9CHe0uLfkDXA32xCu+2Hb4sEv5+vLc3y7mTWk1yBnPNReHksA2PW0+t33PKKBYTQLIHitJOk=
X-Received: by 2002:a05:6512:4014:b0:52e:7f23:5d8d with SMTP id
 2adb3069b0e04-52e82685f67mr6090722e87.30.1719941981475; Tue, 02 Jul 2024
 10:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702132139.3332013-1-yosryahmed@google.com> <20240702103628.61879ef17b9b01305515c634@linux-foundation.org>
In-Reply-To: <20240702103628.61879ef17b9b01305515c634@linux-foundation.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 2 Jul 2024 10:39:03 -0700
Message-ID: <CAJD7tkb7=sBdxXTmcqxe3+UWsTT7R6-rKGBhkEfgEAdTY+5jCw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] x86/mm: LAM fixups and cleanups
To: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 10:36=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue,  2 Jul 2024 13:21:36 +0000 Yosry Ahmed <yosryahmed@google.com> wr=
ote:
>
> > This series has fixups and cleanups for LAM. Most importantly, patch 1
> > fixes a sycnhronization issue that may cause crashes of userspace
> > applications. This is a resend of v3, rebased on top of v6.10-rc6.
>
> "Crashes of userspace applications" is bad.  Yet the patchset has been
> floating about for four months.
>
> It's unclear (to me) how serious this is.  Can you please explain how
> common this is, what the userspace application needs to do to trigger
> this, etc?

I don't think it would be common. The bug only happens on new hardware
supporting LAM, and it happens in a specific scenario where a
userspace task enables LAM while a kthread is using (borrowing) its
mm_struct on another CPU.

So it is possible but I certainly wouldn't call it common or easily trigger=
able.

