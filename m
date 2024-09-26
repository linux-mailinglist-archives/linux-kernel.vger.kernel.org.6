Return-Path: <linux-kernel+bounces-341059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E51987ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB77B1C22540
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B514F188CC2;
	Thu, 26 Sep 2024 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OITaR/9Y"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5294188CA8;
	Thu, 26 Sep 2024 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727387783; cv=none; b=nTzn0zed8y3rxxFD+6rbl+NOiKTLv3f6wkNJNsjes8ReUoKRN98pH1REVMQj1YhK+NjjwZfH7CNzShZn9IphWVg2XHckEs/wWmTf1RvrmrmOJTstAZw8e2BteFwI9UJh+AXpgowFOtCx5Ujhdlf7eiMbAJxGEF/jinpseVJRsEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727387783; c=relaxed/simple;
	bh=ezFoP7R2uJ0sajdZSA/6raNM26HoWOTGBTP99jykClI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgX7JXBUARJjbNupxPAX+idhZPPNBzA+OPzeWyNEDC7Az1NCGGUpOlgXdwRArBwsLPeccGIBXpVOf54/g+9wipyTIYKMmN5Or+oevI582N4eDROSoM24z+MwRAfgsHGZD0u0XkfAdUYj7SeSntNNqEAiC2fBkoYd05jOSToFCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OITaR/9Y; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e0b467da03so94379a91.2;
        Thu, 26 Sep 2024 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727387781; x=1727992581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezFoP7R2uJ0sajdZSA/6raNM26HoWOTGBTP99jykClI=;
        b=OITaR/9YAJWOToKPUqosB0J/lD6Vj2aeCdWCrzGkoi81SLygseTmsWeG/0j+ue9iNf
         bPzmKunrcH+gVWXp0awBmvKXebyVXmH1FgZ7LNR6dnPYxmnuUqNq8wS9L4WwVha+uGsl
         uyHu/PM89kqq4pdsqWUbH/Xuvtww7syaSxiJshJJdwa8Nznlrx3KCoayfR2CNvsIlv09
         DSkoye4FeBVDFVJJkHaDtaAl2qgR1obIcMNfd1MJQbbJRKIli9sFY48TAX6VDegTx+BQ
         BMXzi1lMgmBei/oJXiFfSg6e2bt/aKizqXdn2uWKyAp/UyMWz+D3sE8xKn6leZiA1NzU
         YuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727387781; x=1727992581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezFoP7R2uJ0sajdZSA/6raNM26HoWOTGBTP99jykClI=;
        b=KC0Ep1nhjjnaAl6Ea3LMqi3WUDw18P/cvHJJgGKkl0Bh37P85l0wO8DDrQeFtdT2YS
         vR6RxSJih4NI67tirDQydUwxFK+qp8sgEQbNsEMxyHaEEfeKBwfBd81W0QAyjIwgAEa4
         e52wymfRO1NwW24rk4lAjEh/iDD56WDithPMT9z8SSSLpDuigMs2rJecJ6c94x9KHMR4
         VQw6OgIqfRZ9S//JJkyMOiVjDqRzTFjocos2gKENOA2sy7c2A6xMoaKM46MPe20Rz594
         gGpot52IpPTT5OirlJmbPpEopboNX8wIKdXxt/GqBXMXPifVsUjNhQ0/yOloWmlnw9Dk
         7yjA==
X-Forwarded-Encrypted: i=1; AJvYcCUq5zn/YvwoR5H0/VE/WKzUD4eshdT3MPs+YrJks5ML+Qx8z8J8wNOBaNF6illzq2WygO7iXsAc0Dj2+JFP7Fc=@vger.kernel.org, AJvYcCWHagl1lmWYsPF8zqlZiJpZqwocyXpHpn34nvjp2oHbfG8RfKsXCvz8xa8X7KUcWgQIk/V4jayxdhJQIUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnFoWonrQxFUX8W+5jh7S4bw/0YbUHQTebyTOa8atfKYUiV3Os
	xtl7oOMwUgKHqXK6C65Au2Zw2xyUAVnF46OxSbzencAZCRkDAftgDOYLh/sE1v3/V3RYu8CN9e/
	zgNbOxDAP7mndKXv8TNyTD9PkGn4=
X-Google-Smtp-Source: AGHT+IHsmcvC46PFz028lt0ZLIxr1vgttBNAU5FX0Km4jEuOfHa6nXZGlkeqfS4I94ENr/SIPuehLkJubOHtVpdax8o=
X-Received: by 2002:a17:90a:e392:b0:2e0:a931:cb16 with SMTP id
 98e67ed59e1d1-2e0b863229dmr560137a91.2.1727387781203; Thu, 26 Sep 2024
 14:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925205244.873020-2-benno.lossin@proton.me>
 <202409270303.kUIAmOmY-lkp@intel.com> <42d17306-1ac6-4fc7-ab1b-69ef045039ac@proton.me>
In-Reply-To: <42d17306-1ac6-4fc7-ab1b-69ef045039ac@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 23:56:08 +0200
Message-ID: <CANiq72kXGNyLg0Ooo3Ne=KmZWBnSO9HE2tcfP=gf+WGFqnjDEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: add untrusted data abstraction
To: Benno Lossin <benno.lossin@proton.me>
Cc: kernel test robot <lkp@intel.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Greg KH <greg@kroah.com>, Simona Vetter <simona.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:40=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> I would like to use `#[cfg("rust version <=3D 1.82")]`, but I don't know
> how to do that. Do we already have support for checking the version in a
> cfg? The alternative would be `#[allow(unreachable_patterns)]`, but I
> would like to avoid that.

We can do it, but it requires adding a Kconfig symbol, sadly, since
`cfg` does not support numerical comparisons there.

See commit 93dc3be19450 ("docs: rust: include other expressions in
conditional compilation section") where I explained it.

So depending on how often we think we will hit this, we may want to
pay the "cost" of the extra Kconfig symbol. Otherwise, we can just
`allow` it as you say.

(There are discussions in Rust about `cfg(version(...))`, but that is
for the future -- I have some links at
https://github.com/Rust-for-Linux/linux/issues/354)

Cheers,
Miguel

