Return-Path: <linux-kernel+bounces-263145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204C393D1A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4ED283902
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9808C17A594;
	Fri, 26 Jul 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="FPQex2ee"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23E178CDE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991971; cv=none; b=FDuQX6m8yVbJIdEK+tSriqaNtef+tJi9T6gwjzGrZdhzc2H/GjXwngJBhdqKYb7Byoha4naMz44shJTTpEpg4z00kQzPjyjMg6myXgp28XNrBLzXz+PMnlnc8Nm0Ild/3xdC8yH7S+S8QDOhoAhmI7xI5yULsuHroTZXuTJo1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991971; c=relaxed/simple;
	bh=/sVicTNfY3cet1chvNxxWo/ZPwMTD06+KwNxAx+VxkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5YRy/3mumHBalXdwDz6MTfTTl2e1LoHziHPUgMqyE6r2sHs/Fpc/hRxP/BPyhb171goVeeNuJ6hvCXCFgE490+XAg9xhnk+ek1CUHWau9gxy8twm/dsw0aQAROY25MzR4SVEH5IhVlYCBSCa+NFvUUNxwlZXae8wqAi3aBW2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=FPQex2ee; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2642cfb2f6aso707399fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1721991969; x=1722596769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hckkNbMLOcuR+z008FLIKbuIPv1ZZE1XmBUhRiJCWk=;
        b=FPQex2eeu18tf1vDHk9gwkiNQvcSAkeMgXEaIBbI9SZ4F4yVGleDchfICyo0W75sUg
         wUkqtC15tOIL1mooHiPtQZl6mK4r39ClXOjwBwA0j53iYccc/J/nx6EZ+wljCC0B98W4
         KIBh2VUIvmJs+XdiVIX4xGLN+v4wQx1meiPXcG3eRAuqeXDm799rDY3sTl1i0u8erkQ8
         tU9TdJiLamoJWRpGmOoO4mN6VvscmfIgeNbqNx9ilnv01rneMtaqBPsSD/QBat+hv6MK
         I0HSooFbQAfEEw6K9udUMqwhchcnuPA3xBAiIixFJO6ES+EhuElh2RnlEIYXKA8FAkmf
         1f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721991969; x=1722596769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hckkNbMLOcuR+z008FLIKbuIPv1ZZE1XmBUhRiJCWk=;
        b=g1X8cNu5HHixa9nObGs5nb81kHl4YG6bvXsNOycT0Fja9JfEr03XRbA31n6EuI1H/Z
         jifzmnlm1TN9cd4a6AvafvbMY5xF1uU9/noJ+90b43M+u3g+jQXrq+zj8hc7ia+9xWzC
         E+FT5WmWCX2dybxgLyJY1gF3huthBIA4SckVjNIZNhLXR7/cUxilrA+4Yfz0L+lUaMHE
         QaVQrdenD/HdsRaS5u0/L27X8erpE9FMvosWVHfmmInTx2XNT6YUtHVmoCNpZn0oKFMD
         fCN/CVmQt2dB41+4WCahQYkn/bQbcf1ECU5uMNmJ1yA+VZanRWJ+m8TZsxiUyDi5R6oW
         8r0A==
X-Forwarded-Encrypted: i=1; AJvYcCVozan3PjmZ2R6aFL3BCzD8Tggp+4hSN45n+PGv/H2bq2Pw2/ScNYv4nfx2zB0TBliXD8lXLWe6CeRTXYx6b30YOLLWcv7KRPNHpwfk
X-Gm-Message-State: AOJu0YwM4z3XOkkraVOa5b0S4tvf+UTHhMqkjo3nF0hRpx+0xZ0TBWdm
	B0JvOtLjVu7w9v1iZcyMYcQiu5FUTeuyoThNxY8PfKyQfgiAvV6xjC1AkYLECrgoN8c5pM7V6r+
	Nd9JWy74mTnYi8yrTBcpyVSeoTjy7slDwvrgQtcEN4x4on514MkU=
X-Google-Smtp-Source: AGHT+IH9Is6Tym8XF86g8B+5uO9SsdZqfsnltWUtIJEd/+7smiIsMguxwMrcSPqNtyBKCgcvokKKDTSPDuMXdsI3m8U=
X-Received: by 2002:a0d:cd45:0:b0:651:79ee:d14b with SMTP id
 00721157ae682-675ba704897mr56298307b3.29.1721991958488; Fri, 26 Jul 2024
 04:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725184644.135185-1-ojeda@kernel.org>
In-Reply-To: <20240725184644.135185-1-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Fri, 26 Jul 2024 07:05:47 -0400
Message-ID: <CALNs47sFD_GqhXNa7v+eC=O96A+SpPm4QtZ3=GbSxZ4zkTm3Zg@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: indent list item in `module!`'s docs
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 2:47=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Like commit e516211f615f ("rust: macros: indent list item in `paste!`'s
> docs"), but for `module!`.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/macros/lib.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 159e75292970..5be0cb9db3ee 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -94,7 +94,7 @@
>  ///   - `license`: ASCII string literal of the license of the kernel mod=
ule (required).
>  ///   - `alias`: array of ASCII string literals of the alias names of th=
e kernel module.
>  ///   - `firmware`: array of ASCII string literals of the firmware files=
 of
> -/// the kernel module.
> +///     the kernel module.
>  #[proc_macro]
>  pub fn module(ts: TokenStream) -> TokenStream {
>      module::module(ts)
>
> base-commit: b1263411112305acf2af728728591465becb45b0
> --
> 2.45.2


Not much needing review here, but

Reviewed-by: Trevor Gross <tmgross@umich.edu>

:)

