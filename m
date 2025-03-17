Return-Path: <linux-kernel+bounces-563587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57824A644D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514213AF4A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D9921B9F1;
	Mon, 17 Mar 2025 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gTeC5J3"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A920217709
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199195; cv=none; b=tYYx2qp5hYghc4itlT0UEndPGz0CNjSqbJVJqgaSFgi1vfVwEFgHF3/PWaEbsBR4uoWzLS77H8rRHrSezvnUytWpmv1Oou9P8567q89dvnk2cOEe+hM+jlZVU66TwM5DxlPcjbP6cisyLYb4UGNWC2XLkAc9q+zuegjg2GJ4cxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199195; c=relaxed/simple;
	bh=Fjl481HJMJi5cqaKfICLtln5DZ73Bg73coVms1LmTro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4qchNQsp2LGbUzKlsirauqzYFJrhqzRDVwIhr0DKUHYRz8OQOler6rnGwhezoj8sDoJ6Y2EETAsKVzzPk63sHn5grvJ+aBArrMwjvnGOM9Ss4lOQ1pPCW6NUXyXpYkBAlVjgtYL3qbhxDeJs7jR4bT5BgIZOA3UvEPLYLl28AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gTeC5J3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso2694807f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742199191; x=1742803991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fjl481HJMJi5cqaKfICLtln5DZ73Bg73coVms1LmTro=;
        b=1gTeC5J3/3cHqIo6pQ6vs88zlxImJvpz2Gh9a/6+t90lyLDe1Dl4NhtOXFyHp47+IO
         L4eR1z942iAZWXORIeS80n6ksz+51GA4Any9Vbq1b2PlRaotRLaHWaYaGbw6wLHjJPCI
         3S81krcLT9gj+5ogjJLROp0ospECcPKPbTGsOxnSF5I9LRNlKriHuA6cffIe0cVGUvBw
         rGy1AqXt/6npU5mvqhHM3Z/jYj1C2lcoRvc2+rCV7xjx6nGYQP5bHBfjLO+JkcwczBKo
         900/C0JdrgmrPfdtdr3tjgSdK2Pil25hmK19jdi4T0cqU56xOsTD+OUZGi/ODi+d0adm
         dFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742199191; x=1742803991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjl481HJMJi5cqaKfICLtln5DZ73Bg73coVms1LmTro=;
        b=OTwZC/fWKu8G6qxM6buLKowDdi+IpNqOJB27j0dzjoBrs97jcQdWwsHvEG0l9GZZHD
         LpQwT9RzgFaPULN/OSfOau6P+tc+WyGO1EVJZRCAvdeycJGGz+Fh+g3c18zhVRbHhBiL
         77pdDCF+ZzPahcQdt7sq7EYbe9rFYelUWqF4jlIFD7fZD+3l3dZgdzMY4mr6K1I7G7Bj
         Hdlhx6YgZo9oCNSFXo1YYX4DOBNLnLppx0Z6f/Erha/HRLF/3PFSWA2TrVgEXcqqOK7/
         ByqCjfPGiNMXSp8CoQgYUdUGTBKgOfS22MXy9pmcWoq8jqTPSw1zb2nq0AgYAuBPxp7A
         dIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0vcG66AAgAlFqdMagC7O/2ToHSJRdCABisoJUUHHLUHJmMTMSe54GNy4uVCPspwLYZSNmmXU/fCU7dyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNmBbjitAlN0VA8tqHFzmqVbyUkEh0eNpWXMLIp0CmTY8tEtk
	Ke2UDkLZGnY7YKDej9cgUSpAmr2FYAYsgpC6ftJM2I1Axbjv9a+4iT75WLcEPnd1RKj65LuUUK4
	IYwR/QzArqr1pZlZGEqhA2opEAm9ypaTc88KM
X-Gm-Gg: ASbGnctgXKq4PFU86EAgsOyfLtZ574rMl+fnaWLRN2aNw2gd4l7kv/CkEdfTmoGZ8EI
	kVkju/LlLcYFiEXVuXhA/eS7/+HCYptJwhZXQn6Obm4OCXhkjjalh3H2Nnq4Og7Eo85YnY2ISpO
	4gQ5/bOta7UjmaqXTN7dDzvcRBQ9heh8MYdtA/wVONm1+n6ahsps1jwySi
X-Google-Smtp-Source: AGHT+IHcLqG5WHE0LOJYXKmJh7WPwmg2PfwcibN1in7y/66c7Db4/DiFnCA71g1wAecSs71bQBHGcgcFUkpKlphRHMU=
X-Received: by 2002:a05:6000:381:b0:397:8f09:600 with SMTP id
 ffacd0b85a97d-3978f185592mr10169130f8f.13.1742199190815; Mon, 17 Mar 2025
 01:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317030418.2371265-1-kunwu.chan@linux.dev>
In-Reply-To: <20250317030418.2371265-1-kunwu.chan@linux.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 17 Mar 2025 09:12:58 +0100
X-Gm-Features: AQ5f1Jov4Za46UZWu9q06eR2JvM-UobNRlaF7fBfeVOrdeJd7W9eiP7leVAj_5A
Message-ID: <CAH5fLgjOvytFDnz0Ms_3R3bA7GymCNrF-T=Du=UQi5GaqfZYJQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: optimize rust symbol generation for SeqFile
To: Kunwu Chan <kunwu.chan@linux.dev>, Christian Brauner <brauner@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>, 
	Grace Deng <Grace.Deng006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Christian Brauner who picked up the original SeqFile patch.

On Mon, Mar 17, 2025 at 4:05=E2=80=AFAM Kunwu Chan <kunwu.chan@linux.dev> w=
rote:
>
> From: Kunwu Chan <kunwu.chan@hotmail.com>
>
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=3Darm64, the following symbols are generated:
>
> $nm vmlinux | grep ' _R'.*SeqFile | rustfilt
> ffff8000805b78ac T <kernel::seq_file::SeqFile>::call_printf
>
> This Rust symbol is trivial wrappers around the C functions seq_printf.
> It doesn't make sense to go through a trivial wrapper for its functions,
> so mark it inline.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

