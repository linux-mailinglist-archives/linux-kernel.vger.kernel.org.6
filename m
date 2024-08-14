Return-Path: <linux-kernel+bounces-286048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4829515E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED2DB289B9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BFF13D52A;
	Wed, 14 Aug 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOjVb8DM"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396AF13CFAB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621715; cv=none; b=C8v1zj9Bgyw+3vq8WVUd9jIiIZ9wIEq6xU78UJQfCeEuY4SuJCItKvSgqYgG9MEtcgKGKanmzHggsnvkpJ3oDigFQXpc6CCQqTAuBc3TzAQHpbU2dN2j6NbCul5lm+CklkL71oR/Q1KZTridvKB1KDu5RWZ8CWHSo2/fDLID7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621715; c=relaxed/simple;
	bh=P7D+VZW1XS1Gzk5chH+qiZmPvALantpIIOGu3WIMPsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tytSXbWl2KqzvaivP7Vegkktym/YHu+bGxXqSVt00oMBDZD6mAYRcvLjK3Txr2FuFcqGXXRaYu+MifX81puRPA6fEv9RbX6OcyRTTRm98rzDCdBR7zanr64CVhXQgsorad6cp9+Df4Byzzl/c8haqutu/Exk7VYYxriROmRo5/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOjVb8DM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so44035505e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723621712; x=1724226512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRLxSfggsbxe3d7cfCO7JzeyIYzJnFmhVfUunHaRPJs=;
        b=jOjVb8DMA/+t5Yi7Vcg+nUWzTTTYTpi2cHbOB7hWR0Y6lR5iEy/wRmAx6Ym20g9cca
         5UW68ERolMqNN1o5wsLUTlpmiQZe//HLjcKkqCOg4mWFonlaFrBTXUV4SJWSmCiKvuit
         5UvEdZaDKS3Gln0gnEH+Ab0c84fqOcCN+BfrQBA4jjZYlQlMaWG3dw4v9NDia8tyXGTA
         3SNxXIHZNm6Mq5aYJCfTTOH8X85JXYOhneWWY2X/krCMSXdQ/msF+B++VzeJAQP/tsjn
         Jhd48abq4Hg+OWr4qeCDiYEC1MURbHgjWDj/riFf8kX//W1AZAWzyjDlUkggxc1R/S/f
         39iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723621712; x=1724226512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRLxSfggsbxe3d7cfCO7JzeyIYzJnFmhVfUunHaRPJs=;
        b=eyRG1V2CbaXlJ/0jL4zi746+00BowRMH/81+f3uHSdRIg9yNJqWu0RikJFfpeC7BHh
         VTChMFwjQc3nqAmKRgra85kZvLjK1KBUSIdjWycu7GCZ1JfvWCp2TrmymWDrYF/JeyPF
         lZF1+5TO1VP9gT0izk7FmIoA51C9HyTJztbeCQrr6nkd1ubg4yHCB6zIZWuZ1XIrK+qy
         LzMQcag+mFQsF8fxJUMMWpmqJA675mA07/8DzLyiezeKFHzKez64bizq6T2aw9SbIZv6
         dGPjyTaBEWLEF4G843SIsb3d8FLT4kGgmZ9fM7zmkaUmG8WaLy8jFq5Bf05Jwxll+W+B
         Xdcg==
X-Forwarded-Encrypted: i=1; AJvYcCU4v7Gr9xgNIAS55eA/0JSd18hO6DFUCEhP/DlRNK8+Z73QKa1PX9yG9g6L3f0JYI4MVNG1iDJclHy29QL8Ag/8MQDEI6HtM3VIIO9c
X-Gm-Message-State: AOJu0YymU++gCCl5e3iBnMw6h/tfS9BvB7Tu3yDZp0j7ndcsL9ohcTd4
	3vlAoyswDN89UtlcA4bswBsKKFcJSaWoQNWg4UONtPWtka7GLbh9J9QbZYgJXZqNAqqUF5iCWdO
	NJGsExQAW3O0kxtpvROVlEpfH8naejXVMPIvH
X-Google-Smtp-Source: AGHT+IFszK04DfhyjnHB8HAsiUvfKiYaTBLS5Cci2eet/nobda0BRm8km1MdiKanezp8dm7Kg4wNR4OK+iD9anVVD1g=
X-Received: by 2002:adf:f5cc:0:b0:366:e9f3:c242 with SMTP id
 ffacd0b85a97d-37177756be4mr1218451f8f.12.1723621712012; Wed, 14 Aug 2024
 00:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-9-dakr@kernel.org>
In-Reply-To: <20240812182355.11641-9-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 14 Aug 2024 09:48:19 +0200
Message-ID: <CAH5fLggyf=MAKvryzU5vEWFs9RSzjNOiPcz-V-MvCx8WKNiAQg@mail.gmail.com>
Subject: Re: [PATCH v5 08/26] rust: alloc: add __GFP_NOWARN to `Flags`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 8:24=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Some test cases in subsequent patches provoke allocation failures. Add
> `__GFP_NOWARN` to enable test cases to silence unpleasant warnings.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/bindings/bindings_helper.h | 1 +
>  rust/kernel/alloc.rs            | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index b940a5777330..7f781256fda9 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -31,4 +31,5 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT =3D GF=
P_KERNEL_ACCOUNT;
>  const gfp_t RUST_CONST_HELPER_GFP_NOWAIT =3D GFP_NOWAIT;
>  const gfp_t RUST_CONST_HELPER___GFP_ZERO =3D __GFP_ZERO;
>  const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM =3D ___GFP_HIGHMEM;
> +const gfp_t RUST_CONST_HELPER___GFP_NOWARN =3D ___GFP_NOWARN;
>  const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL =3D BLK_FEAT_=
ROTATIONAL;
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index f0c80ab78602..295107777a12 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -91,6 +91,11 @@ pub mod flags {
>      /// use any filesystem callback.  It is very likely to fail to alloc=
ate memory, even for very
>      /// small allocations.
>      pub const GFP_NOWAIT: Flags =3D Flags(bindings::GFP_NOWAIT);
> +
> +    /// Suppresses allocation failure reports.
> +    ///
> +    /// This is normally or'd with other flags.
> +    pub const __GFP_NOWARN: Flags =3D Flags(bindings::__GFP_NOWARN);
>  }
>
>  /// The kernel's [`Allocator`] trait.
> --
> 2.45.2
>

