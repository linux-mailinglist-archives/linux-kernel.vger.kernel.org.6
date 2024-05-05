Return-Path: <linux-kernel+bounces-169178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009838BC483
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FFC1C20944
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98787137740;
	Sun,  5 May 2024 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjtHe+N5"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16567EF0F;
	Sun,  5 May 2024 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948122; cv=none; b=INyE9wSDJip91spGmGi7cimM28E27zWSM+O9Tjg+7gRMftvv90h80hi7h0MYKR44ipvkFbuI1HbTwA4bys4jVZmP+h4vInBpL5pJS3i4iRN4OjGve3naxAEuHQYpNvLmP20Ldkny/3k0JHFDmV2bBmFxv6Rbu8pXz8D0IW0ZJ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948122; c=relaxed/simple;
	bh=dOMv06zfp+EfFEk9ksXdm4XuRLTgcKDRnrVHao70bRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nt3aONqLf0KCOC62kHnMCUY6ugX4f0vPr0296ZR/pmyo1rgmUvALPf+5CYL5xyatp703xboZgnKHfT5ZcbJHJPl272SpUO1xAsbCF9d0FQWHixRoeWyRsSynoxWEMZ6uU3xIAgt6vNjHRkj+sNId7exaZI1OuFAKsQVIiEx3Mpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjtHe+N5; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso1214287a12.2;
        Sun, 05 May 2024 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714948121; x=1715552921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOMv06zfp+EfFEk9ksXdm4XuRLTgcKDRnrVHao70bRc=;
        b=YjtHe+N5YGgyKPdVSxLzyiBU4AIH1iDbDzyvEu7iWY1P3KIutFKJaN/F7hbAmlBWD3
         OomuTE6ZwyN1HqM3UpfjQWUAh7UQS4Bbpc9ShGuBfhJJSfD6n3mSrsLvxpnJikrR+Mpr
         8zg1W8Jx5X4A42KE66Il0VKFpKuFe/yba4c+BLN/4Bj7FesZNtmyfIFu90Jnti8aTXOK
         875YpPOY+GzYmuqsdqO2psc3tjja8dT2bn65C8F8OwC1PIXuYpJ21LO6EoZr/5ybqi2y
         TTO19kwYijwMJNoPBO6i8X6kntm1h4mLnjr+fGQx/1ARg0SEqiNt5TBa7ZN5a88E3iKB
         gdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714948121; x=1715552921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOMv06zfp+EfFEk9ksXdm4XuRLTgcKDRnrVHao70bRc=;
        b=HJXSnIIVEs52YLglaxmRPZ2fF98ugbjOQn+pR61MgeaoJgKFtQlQu9DPrTXBWn1ibh
         XwYN4Iw67K4509M9TShnaBV+H/o4u8V8qhsZLntX5dlr8g29h3r1Y4Pz7U3/uuX/dp0n
         aOcjZNErzvmuIwSJarvgh5IX6OZFB0QFH0XG2QhRBWspoMWbfWqD/Oxu8VmnNKe4kaF+
         rObKNBVloFzDIjVPmLMGfa8ESIiskN95oug3B04g2DYd4kYP88PhXRjlxT38l/NXNlhM
         yY15aTTYRdUk2FcWi53PsNCsxKkNfw5bmX4RlMAPxLipR7cJeccN/tYlR2mnns/nLclc
         tPsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjYBo80LMsv0j8BAJ4r9BLxPZsQdat28fxXpmd0salditvdxmXJyEHFXsXroLXUfWLbxNvBjWjUPTlQKHHrnAxpddWpXC+7yYTgtkTP5hkbZjkyvBDME41N8Pjso1Of0IufcU8H4ZM1/VVoPw=
X-Gm-Message-State: AOJu0YzHAK9QzXj5Y3oTRzr1GdppCrxXNMHjv8ZL20/n+rxZUIEEpDPr
	A1gWs1gTW24kb5ZWN0Z+IY2XT9rCHbVQX2532kLRfPzkmz1I01dmDsWmJEVZ0BmUXx2dmXq9+u2
	wXfzeyOr6QVyj6kprlqpSKpXz2BU=
X-Google-Smtp-Source: AGHT+IFpBns3DJkAT9PiPBuCMSjmLQYVP6LQs/9/sJPI+idAdC4t6wp4kkoSe/2MeKmk4zePFseW29ptJ55KYe2TPIY=
X-Received: by 2002:a05:6a21:3395:b0:1a7:5780:1f4b with SMTP id
 yy21-20020a056a21339500b001a757801f4bmr12340587pzb.24.1714948120941; Sun, 05
 May 2024 15:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-arc-for-list-v4-0-54db6440a9a9@google.com>
In-Reply-To: <20240402-arc-for-list-v4-0-54db6440a9a9@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 May 2024 00:27:17 +0200
Message-ID: <CANiq72m6bgxtjax2not-8YVe88WFO6tLhqeK5wmYAzgVmKmh0A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Arc methods for linked list
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 3:07=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> This patchset contains two useful methods for the Arc type. They will be
> used in my Rust linked list implementation [1], which Rust Binder uses. S=
ee
> the Rust Binder RFC [2] for more information.
>
> Link: https://lore.kernel.org/rust-for-linux/20240402-linked-list-v1-0-b1=
c59ba7ae3b@google.com/ [1]
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08=
ba9197f637@google.com/ [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

[ Replace `try_new` with `new` in example since we now have the new
allocation APIs. - Miguel ]

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

