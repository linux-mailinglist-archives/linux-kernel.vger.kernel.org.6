Return-Path: <linux-kernel+bounces-414443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418059D2824
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65451B2DE82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411961CDFC9;
	Tue, 19 Nov 2024 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8qr3mDF"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9401CCB59;
	Tue, 19 Nov 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026304; cv=none; b=Yp8QyhZxVPyrE588v5CuHz3ckUo9fJJLTiComQTBSCG43rUz8l+ugYS1uSL9/v+AhHzLDyHRjPoisSN1b3EhNSmwScTSWbLNHsQseSEYAmhPfynfkl+FMs/IrkUK1jD9QXoo6Q/Fv5ssHJ+IlG/23c7mB82lRNozocCvV5EcrFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026304; c=relaxed/simple;
	bh=f9+ZXpPOPig3xx8es3Ad+e/idZjq8WPG824uifMLItg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzF3W4IIjb3k1eO29nRGUE8CpXpQ1r8XQfb+yx/fYFXUJr++kigvoQk6hTnu37yOerpbF4MR42XDlD7B9N3oKgmYxRv7/Ry8m2zYn2tecFzsW7fCgq4Nr0sP9clAabfhYuNpD3H2/uCsNgTjQqzBRN2eOM2WKhpb+fbZdBkjfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8qr3mDF; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ff64e5d31bso10628331fa.0;
        Tue, 19 Nov 2024 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026301; x=1732631101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9+ZXpPOPig3xx8es3Ad+e/idZjq8WPG824uifMLItg=;
        b=m8qr3mDFWZvr9q+xpkmP9fl26CXvleVS8EQeCNMg+95u0vy2DT/fVKigO0C7f4U2Xj
         uC2poptA/4eaKFfUpLh07u4EiiTZjtkVSjFTCEIdUf82ZHmXnt7cyQnhi3YXbLrFn0kk
         b9sX3kT4vlmZ80dJH3UZGSl9VL3orI78Q2dOG34ArQ23R3yjxQyYlfu3MWPCr712zE00
         91uR2gqDHm2vv4rQMvgOtTIUTBwkzDa1MvUM0p7aTmQeFkA+hOj+TBxLeMoFM0SohOxu
         hQGJxptnlfunSgR9Hpcz1Y/3tOahgw9/G3pNDFlHyJNWP52sNJWn6QtnxlVYlw0in+rS
         DwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026301; x=1732631101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9+ZXpPOPig3xx8es3Ad+e/idZjq8WPG824uifMLItg=;
        b=asj+o4WyiQKZ4mhdCZXjoMOElFctw4349c1KkXcJkUrXkG61BU9IJAppS/YgW635Bx
         cbUkMUOoFoY4Kxr1LZ4gO1xDA7gQAFghE4zY1sC6/OEPK2N2iyOdb7ZRIBpiKYkF9vFQ
         l3baw19XHmZiScM6sW9b+nkG/EpiJ86hxhVRaW+9iv5FROS6V3MBpt6Z1/aMrGMzpg38
         YpSdec3Z8OASUkah4sbeze8fjQyqVVqquQ4zvaxlwIy4W+KDb1MutyUQVfULnwRQvTEU
         mCq7FfomX+7GZ7eH2bIpVs1WJQVLc/6NauUmbvjlLK3WO+pbksS9uBR9Wgwpd1i4VUmv
         FiBA==
X-Forwarded-Encrypted: i=1; AJvYcCUa0wR9OOTnSRkiq5tzB0P7REjyxY5/MHg3NCpgUfKthnu/IMfbC4e7wsPQ/mmBzyM1IZmomB0Viqw+ELs=@vger.kernel.org, AJvYcCWcv9Tk+tZpEcwxNQRMawdhuTsbkQYaAcnf8TOGzHYFlvLvnckb60tU+SS97nyEMIjpnnzIej76ShMANPlLTHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNBq23ju4EqjeyQcdeY/XzpjI+iBX0QcewaGXvCkZQi+IfhRd
	AYAzk8BmM73LJChLpNMYbQtwehJNUSPKWW9/uWvzsOS6s/8+0UT3Y+TUbjAVpu4c956ph6Y6ktZ
	HO1mD2V93c57Jv4zrsVJaBAZOpdg=
X-Google-Smtp-Source: AGHT+IGDQuZvYxpeBWOu0zWh0kgnWDlKHJRMUgF7I3RbprVTCPL0DLTqlOu8A9d7MCZlQoLSdVAaq3cVsJv5vAu1cfw=
X-Received: by 2002:a2e:bd0a:0:b0:2f9:cc40:6afe with SMTP id
 38308e7fff4ca-2ff6090e9c2mr77071141fa.14.1732026301218; Tue, 19 Nov 2024
 06:25:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <CANiq72=13uaXS+mptTiQZ7OLpyO_=r7-06cXEujFqtej=150YQ@mail.gmail.com>
 <CAJ-ks9nqcrOhOSuw+fN9+871W4YEs_rwRJehm=mnAx+M_v8Pqw@mail.gmail.com>
 <b4c1e64b-daef-4181-a3fb-98b4ab3a9c1e@igalia.com> <962f49a8-0d0c-4a1d-836f-e12c0f621917@asahilina.net>
 <CAJ-ks9mVHLC5EpiEp5t1=vNfDqPnn3bmYMgPRYr=K6DvRn0GgA@mail.gmail.com>
In-Reply-To: <CAJ-ks9mVHLC5EpiEp5t1=vNfDqPnn3bmYMgPRYr=K6DvRn0GgA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 19 Nov 2024 09:24:25 -0500
Message-ID: <CAJ-ks9nd_sMQ5KwOLMtbRwa=eA1snC8Ne=OR_oDf9974MUs8pA@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] rust: xarray: Add a minimal abstraction for XArray
To: Asahi Lina <lina@asahilina.net>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 9:21=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
> Ah yes - will add in v2.

Err, I meant v10.

