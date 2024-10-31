Return-Path: <linux-kernel+bounces-390478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC759B7A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3923EB212F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E14A19CC2E;
	Thu, 31 Oct 2024 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4Svqa8x"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FAB14831D;
	Thu, 31 Oct 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377405; cv=none; b=rItiCQ6jRgJAErL48pmfyzHq9aLiuYiGEjdqNh9xjv87clnM+irgBfxavvPLwTjvh1DDYA4TN/1Aa8aOcNnojimzkrI0qXNihoMfwnfZ6Rgh8kCbxBKa83et1WZJ1kPrpajLF/8RdLPmO0/kOJq5pRfDaByNaNWqZzvADKh3cXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377405; c=relaxed/simple;
	bh=dEI4cN8VmvqfpAYwfpFNw/42F1dqFbhajZKIURlL5eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azIsG7htvazxPdBlSB5uqaj43SgD9jS9WKYaI35VHHWhGOJajfLf8ngZCHOsRpBamr/1mxs6NsP2lP89NCGR/my1TiJKN0kRaUzIK8LjEv4N0ZsTABwVnf6jt1BwjkNr+AAwgLGjgQRnXWab8F3dVAEV7NYKbAeE38ClO1BfwhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4Svqa8x; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso8178741fa.0;
        Thu, 31 Oct 2024 05:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730377401; x=1730982201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEI4cN8VmvqfpAYwfpFNw/42F1dqFbhajZKIURlL5eQ=;
        b=A4Svqa8x0gf5ZduxzlOz92cVomaFnIZtsLrAP/KcM+tG48d3QWDuWtgjeD571woyG2
         6uNDDJiGeclsBhUxcMyMrMS8+MRDLuyyqrrNFRL3Q4KzfduEHRH3X7FgV8AHNTwmHf9O
         OfmdP+yEY5RAJok2u+Y7YABuq85i3aqs0nHgeM20N/e3XvtnfclTnJEcLlCx8FKRRHfT
         0r4OlbOY+otRG/Z/9TDmLT1AI2tV8kgWmr/dElfZWVbbUG36CNBeT2x+THUYyQUXa1KY
         GKw1Fuy76Fn8Yc9/4uqzGFg8FftSruWe1+LXeVXct0L3L595xzRD8a3/hY6g11DM0BQF
         v5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377401; x=1730982201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEI4cN8VmvqfpAYwfpFNw/42F1dqFbhajZKIURlL5eQ=;
        b=O0RXiGCL+9zx3+ZWVlHInK7V3wYFH0EbiabVvbsJ1CY9Nn9UxhTTnyzCuoMpO0BXHv
         qBIqHTQyXHVVg9Jme+iWcQ9lW8xHdMBI5hgq22fowmKdm2V8bapNcKSMVYnt7Wx/Bon9
         fIbibixlRUkVKHcbPQgQ0wv6BMIc4uKsN4oyXUg5FU02M+7aM7ov0qEFgDXe6h36IIjO
         8Ivc6VVJsXHdM2/C9g/uh65PsYtha98HopaJBl1vA403/GFixIp2NJgK1dpTvXm1XFwI
         XaYBIQxTtzmvAkTEPaVEp4y5rSvM7jTnGYm3mxcF8lRrY5+tOryQy34c3UQGVVj7rgR8
         v32A==
X-Forwarded-Encrypted: i=1; AJvYcCVZtHWNI0r0gqAjZHOTXK+QilK+IdpLcuodCIfvUbE+qdSIuujUod9DNDTgIfb1Fs7CmtDTJCtYlT//B5U=@vger.kernel.org, AJvYcCX3jpQ9RkSby6ZMt8GDCLzEL38eftKKrrCOkfZ9nkv0fJL50D1wUEaPov89fsIWzxkYb5OS1Q9wj3DyOyR8rdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJnMG04HeR/ghRO6fqn9y5kN/rk6V5ErzCTATUfNjjgxUFeB7
	pKDHwhO5Ahtc0cSxp+C0e8iYkmBmV32qJ7nThTg9FI6xtnTDWebPiQQy95Usi7kMrj1MiRAA+Th
	f4At9SO4zSLnYDRmxzz7CHruEtx8=
X-Google-Smtp-Source: AGHT+IGGx6w5LseHOAXVOMKE7Bhp3lbFN2cfeOJgkM+kPnbpppKpPEf3fhutM97PX6BvjDeawdgKHJHlDC202lvtZkI=
X-Received: by 2002:a05:651c:2112:b0:2fa:d604:e525 with SMTP id
 38308e7fff4ca-2fdecbf0a79mr17392671fa.28.1730377400966; Thu, 31 Oct 2024
 05:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
 <Pn1b5OU4cqz38Aiv4RL7MuzPDwDGvxLVRrLuCF7Q3_HaeLzlh4jaM0krBqB39DCFmRLWK59Do8DPaVxLNaaTNQ==@protonmail.internalid>
 <20241030-borrow-mut-v1-4-8f0ceaf78eaf@gmail.com> <871pzwpsm9.fsf@kernel.org>
In-Reply-To: <871pzwpsm9.fsf@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 31 Oct 2024 08:22:44 -0400
Message-ID: <CAJ-ks9m-THyqK1tYL39t979BagBqj3Z-MOSn8wPhDc82awjzug@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: reorder `ForeignOwnable` items
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 4:50=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > `{into,from}_foreign` before `borrow` is slightly more logical.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> I don't think this change is required, I would drop this patch.
>
> Best regards,
> Andreas
>

This change was part of the original patch. Do you prefer the code
movement in the same commit?

