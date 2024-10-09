Return-Path: <linux-kernel+bounces-356997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3469C996A12
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6651B1C220EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4715A194147;
	Wed,  9 Oct 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1Ztz3Eg"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127A192B6B;
	Wed,  9 Oct 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477146; cv=none; b=Q9GDyYz6gACC0zfrx6bkpJGmvsSz5yu5dqVuObDEVBElRDiK0NMrklgOplVGBOgGYadj5Q2qtw3Gys71lnOiGH7xErI/8CexsZavoPyDXoGiy23lnzfXYX5M2ZzlqTg/Gs0bsducKsIWV8RqgmDz0HXWffIxGkUA9G2wZG5c0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477146; c=relaxed/simple;
	bh=ZCH7AEVp8yz/8UK3lIBATKhHCBdELuNOK9/9lnJSnAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSvyXMf3KG7EsNZJi75tIWe6iwPMyq2nsJVN7FQ+5RQs4ATQ4M3cpBuLHOmD3tDumZRFJS4/Ek6SnIL89AgDzQWl8dZ6jk40nuhA02t459DISJJc54RKUBDtRtF4g3OqL7oL3GHwNVBsWgxIHc4EnVBSnLol+Pnus3aml3JMQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1Ztz3Eg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71defa23174so694181b3a.3;
        Wed, 09 Oct 2024 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728477145; x=1729081945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoL22N1zkJY5+zHlWx6b9rySvR2NnQPaN7lfDWm/21o=;
        b=N1Ztz3Egu0T6YhRbxFwA/jFaF6BzuAdZRN1KNFH0qppe/71Pzc1n+2Sh63pXdY/MkE
         D4nPtcrKWpUCK0fTlJ+RLfVBFs0Jv1GJnC+rqvvhzum5a7TswX6hVvC4HxyrDrcVzK9U
         qFLLjpbs+4BBlqa8TMKE1ukDrIiEyG9EJdF3xiCR7ZF3+TO3+VvSu2KIsHIjvN33Aape
         fBgXqPOFYcS740kcFSgNwrHCgwPjXGJ1ULF/dnIg0lWzVoDrDm68jAbADWOUu+RM3rWC
         R98d3zBigTIq0und/Ir+VaRqrCAUm7lHp8gcQikhlPInTR6g1JGDSptMajuZcDodXcCd
         co9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477145; x=1729081945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoL22N1zkJY5+zHlWx6b9rySvR2NnQPaN7lfDWm/21o=;
        b=ZvKVShtHVcH4tiYav07ykdjGTM3yeCpJCLiuhrZTy8U9ck4xVbWLlvb7a7ijQ/3hxE
         ekPe3ZP6LdNy+xPrICh30FnbYwdsJDcVrY9VY3CVUlHXPJBV1o7AyYX46NFXv+a+v0nl
         QPV9VcX8pM3jHwOzPU9kKxpN/ObDXw4DzTBCEKbJqLzLgqhEfiu/2ibRk8hS31sfgUz/
         f2fF7MKmjVnIdAuk3ZS1fCrBYLXykAvOE9i5E4pWrnlCThE8F/c9C6m7FN72mvKzZeky
         IShRK8MPhPMbDkn2WqPjXWfFMbWzCpAKbMWEVLGcr/0pCl4hhHB4vbYPyHy9HwwJJOWB
         JICQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU5AzlMt///j50Mr7fUCTzjtGVSQhb93JHlbASVSEcPtzOmWu4ZVXyPHNGZDWlJ2GUCmPvRGMBgRprbms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvojlBeenSGStVoApZqWv/aR5vnkc3DcmWGNGaP3/1MXq7jjyi
	SAZH9/cPNubOkgahA0OJOON3AeXfzYVr/SFj2tzQ15spoSe1XnNdXMbeadsFIgBAafbXOrCJ2Cs
	O1Fsh4GqROe1k55x4xnv1iXc/BJQ=
X-Google-Smtp-Source: AGHT+IF+xs7+Yd6jeDsyH3nhGnSr+++9BwB2Y4D9T9/6pnlJ1sPHN85IM1Q1zku2QTFGp4eEKu5yffwKFAgNG8V1V2Y=
X-Received: by 2002:a05:6a00:2314:b0:70d:2289:4c55 with SMTP id
 d2e1a72fcca58-71e1dbcabd4mr1565577b3a.5.1728477144542; Wed, 09 Oct 2024
 05:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009014810.23279-1-christiansantoslima21@gmail.com>
In-Reply-To: <20241009014810.23279-1-christiansantoslima21@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 9 Oct 2024 14:32:11 +0200
Message-ID: <CANiq72m9_DUG67keD+Sa660X08_Sm1MSm9NB2K2iEUme5DpozQ@mail.gmail.com>
Subject: Re: [PATCH] rust: transmute: Add implementation for FromBytes trait
To: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 3:48=E2=80=AFAM Christian dos Santos de Lima
<christiansantoslima21@gmail.com> wrote:
>
> +pub unsafe trait FromBytes {
> +    ///Converts a slice of Bytes into a Reference to Self
> +    ///
> +    /// # Examples
> +    /// ```
> +    ///    pub unsafe trait FromBytes {

Apart from what Alice mentions (which is critical, since we are
looking to get into stable Rust as soon as feasible -- please see
https://rust-for-linux.com/unstable-features#usage-in-the-kernel),
please also format the code, documentation and examples appropriately
(please see other files to see how it is usually done, we mostly
follow Rust's standard library conventions).

> +        unsafe {
> +            let slice_ptr =3D slice_of_bytes.as_ptr() as *const Self;
> +            &*slice_ptr
> +        }

Please note that we require `// SAFETY` comments too. Missing those is
already a warning/error (depending on the kernel configuration) in
rust-next.

Thanks for the patch!

Cheers,
Miguel

