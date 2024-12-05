Return-Path: <linux-kernel+bounces-433123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D369E541D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D30B18828A6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C531207668;
	Thu,  5 Dec 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayGAPsCy"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A151DA60D;
	Thu,  5 Dec 2024 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398798; cv=none; b=DFDltKK3Qrxcu/oMt2emtRvqjzfOw6ZibPD7UcvcX85+QR3hJvONDXIa2DBk0xYKVe6erWU8dcGA0vTDXzmbodt9Sx50y5Zirg+vo2BGbgqnu98/fDLoPqW8Ivie8ap2dTEbFWKHLSTqzlx0lwLdK3clu6MWzjG1tT5OZ6eb+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398798; c=relaxed/simple;
	bh=oS4kCWnHf5EwueNOBpzfWfyTcUeGswKnxcEx2rRdjYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFX3EZ+VTF7NOeiGzpzS/zSP3O2+qtChZw+6dU0GAZ8MTv4j5fHJA7LJpaJOxvbdPYoHXG2sQXQiRVxPj78QxPKbiNob8kIM7KABxlUjDoXpYjN67/2+a7dkYlHuGjr+EcAofKNWV82TdmN4UEdJ4yBOJWBIjikb1b5yOcEHlPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayGAPsCy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee534d6800so125853a91.2;
        Thu, 05 Dec 2024 03:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733398797; x=1734003597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS4kCWnHf5EwueNOBpzfWfyTcUeGswKnxcEx2rRdjYs=;
        b=ayGAPsCydh1O1edPsRPvAXEoNlDlRgawHZtaVaUzBsIfE10tpK8eTjoG7pbqQu49tk
         i2q9Idl1QwBd7QYmGc5EKPjVSZhc0dM6sbu3UoA4vh1u9HLCJszRGEDh4bWe7vmaeI5b
         1El05+OPtJZ3vSnFKGmHfkaB1/d4yFM0Hf9vySeB+9Un9ZvfdG5eUJigPQpf3QzvDpUC
         ZdugoPdadci32AElWu2ABIJXDzn/7fS5GbpJwzm6HpHVn+WkiOP2vgSPG6BElKkCmUXC
         4nrPJNEosR+hKImqFDgDAsc7tDJIZ8pY2G3SRwHB7YClnqeF5OUbY6ia4CSQt4N6gPQP
         vjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398797; x=1734003597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oS4kCWnHf5EwueNOBpzfWfyTcUeGswKnxcEx2rRdjYs=;
        b=XJq+s+RGcdSYv5sGwruDt/ApWO6GpbIV3ZNArE3w0DD8wCzdFHGL0GxmkHVz+/fV8d
         LE9XMw9ssI2j+M/3Hrka6f00pQYQSEzBExtJDrd8bplqIpshO73xE0j2lxbK/Wo3qapp
         b6LMUuf59XiXHQAq8mPhmwZOuiaEPm8E/vAAOq0aOUrBVmNVKOSG2auJ+p+5ZA+AX3S5
         K1NT8zs20FGVlL9WbDBL3fOjbw4+G0bywkbxRM8Hsg/bawnqXtybLg4wzcJKvwtWxtGu
         gwCv8xqfmnUcB4XlnawfeItPrNFOEUdMJF5F7mcxxEN1HJTyPDhNY/nNcm2VDNQpiwqQ
         AcIg==
X-Forwarded-Encrypted: i=1; AJvYcCUeNHjAOFd1kwjFe1ht3AFYj+vdMWw+3xukm7pzxqfpQbC6apMhauLFkVAtBNKIefjAJ0i3DfPZDUNMjrnNwz8=@vger.kernel.org, AJvYcCVim6H2UICFPhBtU9uz+ZfTbLLhmXi4qH41ZmL41jO+SbC+gvcKhHbmcMtP+xqxVYgKAnREbFSCT7Urji8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGSCqmrSALbDrmifPYCI3Q3CeqTSniT50SOYwS0Aj2nhm3jCQo
	V8dmfOHwWol9kk/Wi9p0EhTxGvpa0kXS/4GjBAgVLZ2V8zX2+xHuKBbAzIud3lWqR1K79Abp2Jb
	+IfjjhXqKufeldNkmj1cg1TlKWms=
X-Gm-Gg: ASbGnctQ1HHZ0vZhqVFoVb/Sfw1rnc0dQmATzfYEhL8BwsPWKMXhF+8hqhKLc9MkR9/
	Ty8RBL2GMrVs7izaT7Qu4sAoyC9yLocw=
X-Google-Smtp-Source: AGHT+IH4p7Cm8F9EDS7fhluaoPIT4x7+TE7xNgkt/fT9wR7xsFO1ShGrXAVrspygEOmKekpV+XoocU5mW7O1QLpo6bM=
X-Received: by 2002:a17:90b:1b06:b0:2ee:713d:f536 with SMTP id
 98e67ed59e1d1-2ef01270cf0mr5337502a91.7.1733398796652; Thu, 05 Dec 2024
 03:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128054022.19586-1-boqun.feng@gmail.com> <20241128054022.19586-2-boqun.feng@gmail.com>
 <a696f18d6eced600972c2aaf1a0f9ae2febeb434.camel@redhat.com> <Z1DDuRp7kIm7Pf-a@boqun-archlinux>
In-Reply-To: <Z1DDuRp7kIm7Pf-a@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 5 Dec 2024 12:39:44 +0100
Message-ID: <CANiq72=KA205nyWGxaFpuq-FRV9SXsimCsiZAhrsyX9dA37+rA@mail.gmail.com>
Subject: Re: [RFC 1/5] locking: MAINTAINERS: Start watching Rust locking primitives
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Filipe Xavier <felipe_life@live.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 10:04=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Thanks! Yes, it'll be great to have more people watching this. And thank
> you for the review and contribution so far, nice job!

Indeed -- thanks Lyude!

> I'm currently waiting for both lock maintainers and Rust maintainers
> opinions on the particular changes on the MAINTAINERS file (for example,
> maybe they want something similar to "RUST [ALLOC]" entry, i.e. a
> standalone entry). My plan is to send the PR after everyone is on the
> same page. And you're welcome to send a patch adding yourself in the
> entry afterwards.

Up to you! :)

I guess it depends on whether the rest of the locking maintainers want
to see every patch related to that (which would be great) or not,
whether you want to have finer-grained control on who gets pinged,
potentially different "M:" level and so on. For instance, it would
allow you to have an explicit "L:" for the Rust for Linux list.

By the way, as a third alternative, you could also consider a
sub-entry in locking, too, i.e. "LOCKING PRIMITIVES [RUST]" as a
middle ground, which would allow you to keep routing patches through
locking but have the benefits of a sub-entry if you need them.

Whatever you decide:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

