Return-Path: <linux-kernel+bounces-445879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275FB9F1D0B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 07:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B28718851C0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 06:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E313B29F;
	Sat, 14 Dec 2024 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJhCI6I+"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCABA522F;
	Sat, 14 Dec 2024 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734158120; cv=none; b=SKoZYpm3Kecde9wpzwSLQo83f8gfeOpNvmGx4/BGMqSNABb3czOyvRA65D9QicHZKoSnNxowyFro0PiJNto5LawweT9+uOYUg1bVhX1tbvOL8lrcD5UL46KA89RsAfTVYohu5fRfhmR0EWqCE+Ezs+ezk5XbcY1+dKxop2tQI4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734158120; c=relaxed/simple;
	bh=zFKziE+ipoVbd2wXkCULZt2X9OhiD1E2pZBMKUsBaRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8mjN1CNWctk1jTVtQtSvPF69y+GrrzqaXdGISBtnbWno4erADIor403v1IdCFb33090Q9wEBxv5hCkpWTdYyTsIQTG4UXvP3aZ0Ri4F4p5c4M+yO+8bvrD8Lli4R0tCirckojKkuPdvCjz0Evw8tj1OmVkOx/BRFlviDW35nco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJhCI6I+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21634417587so3608295ad.3;
        Fri, 13 Dec 2024 22:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734158118; x=1734762918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czn2tePC66dPj1Yi7rQxNU6WF4uHph8JSF5w70bMmx4=;
        b=HJhCI6I+eYj7UBSe6Sdc+JtOeJxml081SY6EGSqBfMuABO9XwUqb2P7+mj5l6fRrrY
         4cGbvLqVt7OzSYVan63Oj+UhmThDziXPc00ZpsyP4A2K76O8cmIhZcFQ7VCBiCbzxjsH
         nYZcBJdumLl8EN2bZYPS018RBEZNZ8n7xuMVpQVQl846U2w4WH+f9W9WiPYJRrKUivjT
         9cq6SRh0dXSxH+I0CtHiEN/ktksmCXupeF/ZUYK8tf27KunkaJttNMygCcfeNrW+9L6T
         0gud3BMzy4YabKwer+7/JQ5A09N9dXxcGTeGYLg5h+XZ/oiKN28j9ScU3zpQvCQMaJtj
         FTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734158118; x=1734762918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czn2tePC66dPj1Yi7rQxNU6WF4uHph8JSF5w70bMmx4=;
        b=vA72Uvb/UWj51/zcpIv3uXKQphKTk00VufuDoI0Kj2Xlyvf+cjLF3Bk7sbS5TtUDFI
         kAnNl3lpATOfBTw3PjGPqtsNP4MmrGnXJ2f8R11UjTWY5IourgXUxG0SOHs0QrhTASVr
         Gv/M9zjlcWIVfAD2+QjceqEai3cI7fuy4CfZ9abCK3zIz6AuvMjxFrSDCNmL2hylLzKg
         kO386TIYR6aepcV3n1YZoVhStO5ue4abQ84B5nrORLC/CUibHpwBTnakZ0vwlCwqx0yT
         KhoyI7gBA+hcLZEMvHYNfTPsRgIoyhBdXv0dBcB3wYLvNihyeKOfiRV/TwVf8eC1g8A/
         18bg==
X-Forwarded-Encrypted: i=1; AJvYcCWHeKfsk58gp5rbZV4xHGpvi6jsUb82NHifTF294PpjM8jBpEuieg62T0JtBNkgZ/ItGQuhqavUpShRUNQ=@vger.kernel.org, AJvYcCX7IvRf5vTNGsq7TXnx+JkbJKk37ApfcF9xewqBsM59KDIXsKp0Soy8Rm3D8xIn/+9AiZ0bCTMqKB3cdRWZPRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJIyUwMR4lOJBoAbu8yxVlP+zxpR8hgFwSWOS4QAYpA437tdab
	NU7U06s8U6AsMqWjpw8kfnzb2uYqGpfpm1CfQ+rildF7Buiya4EtjSTJBilbSx26IyBo9JrLYSH
	dBKZM5fq2mXzbEKNIAug9NimiATMWRsrZ
X-Gm-Gg: ASbGncuLiPcyzD/KCHIZbrW/z/dumVR0hanKAsytiAC6e0Nd9VtiqZm9SKpcBcD0RMt
	j8XQczgfJvvmsmqutqBVPrGgU+DYr44m2yOrn7w==
X-Google-Smtp-Source: AGHT+IH6zwBEOjsZhIdW1ZC/oKRUJnDIyzp5DRFpEUSyWKCG353lhiAS0MKdqsbFxiMXrFEbfuVTq3Go37U1wJDNgKY=
X-Received: by 2002:a17:902:ce8c:b0:215:8d29:af0b with SMTP id
 d9443c01a7336-21892a47c21mr30163265ad.14.1734158118104; Fri, 13 Dec 2024
 22:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123180323.255997-1-ojeda@kernel.org> <CANiq72kTX5o2rs=A51keKQiV=6fT0sN+FjWygL4=ddytnNM8Cg@mail.gmail.com>
In-Reply-To: <CANiq72kTX5o2rs=A51keKQiV=6fT0sN+FjWygL4=ddytnNM8Cg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 14 Dec 2024 07:35:06 +0100
Message-ID: <CANiq72kDuaT5082br3PBHmD5xxPpWGD1q-ro_p0DWb+ai4ZywA@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: set `bindgen`'s Rust target version
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Christian Poveda <git@pvdrz.com>, =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 1:09=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Applied to `rust-fixes` -- thanks!
>
> I added the following note to the commit message and added a small
> sentence to the comment too:
>
>     Starting with `bindgen` 0.71.0 [4], we will be able to set any future
>     Rust version instead, i.e. we will be able to set here our minimum
>     supported Rust version. Christian implemented it [5] after seeing thi=
s
>     patch. Thanks!
>
> I also queued it for stable:
>
>     Cc: stable@vger.kernel.org # needed for 6.12.y; unneeded for
> 6.6.y; do not apply to 6.1.y
>     Fixes: c844fa64a2d4 ("rust: start supporting several `bindgen` versio=
ns")

This is now also needed to support `bindgen` >=3D 0.71.0 and higher
together with `rustc` < 1.82.0, since a week ago `bindgen`'s release
started using `unsafe extern` blocks.

Cheers,
Miguel

