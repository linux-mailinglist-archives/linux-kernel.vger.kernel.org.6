Return-Path: <linux-kernel+bounces-387519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3839B523F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C421F24791
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E23A206040;
	Tue, 29 Oct 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgoHfePH"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E276201022;
	Tue, 29 Oct 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228277; cv=none; b=CeYHQ5b9DyAObjlauiUQ6gkPUCZvTkkEmCXO5Btk6RuW84eSUKTv+uptYhGc5fue61Y33ZsvRs46LTasNzIKU9IOQuD2wzA11a8dhZD8g8Oy5CCvg294/ZdlrvpX8jIJKYVqVrZOba9EWB5juHyOGcPHVewgu570d1KR/ckeXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228277; c=relaxed/simple;
	bh=ySTL85gCZZkHnt5AGdEgcTbyspiCYGBvcQFbbg7bkrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJzwWMgVSwTd29VDWzQx5cWh2wsGFVNwkWu7b+ve01fLUzyx2ucmNxg/eTrB8KshD06P38QLUB5RmbLA613Bj5/6XAI6OWdFe82rE28on6c83Jthm5d3cXTF1pMIEAyAn+QXNpp+bMgl20GLA7A8Cg4nzKyRaTtXYQ7b2G4l9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgoHfePH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e56750bb13so720681a91.2;
        Tue, 29 Oct 2024 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730228275; x=1730833075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySTL85gCZZkHnt5AGdEgcTbyspiCYGBvcQFbbg7bkrY=;
        b=HgoHfePHVUtHzy3U6r4MMKcGZeAkQjRZ0TJlDEt3C01DarxjuTpuBbRVt+gPCDZZ7a
         CZw2OmRd5S8VJpC1TS8Enz+gBu0spuse0EQuCv9P614cEm50w8NkjxJdu0pSshrZ5Tmp
         GmbzO2P3cN30Twh2N5tJHs4xLrKCXwayEJ9t6ePiTwuFyvilb+AHTsCIDa3MDUXXqraU
         iUXC+HQbE1oYYsWIrCbt6aoW2n09eRRF1zKccQvS9oyz1kFBuzejeVJBeTiSZ+OBCZoW
         NE418KDrVvaV1FPwdikbmS9Iopg7w4h67ntz8/wlKQsls/YL14kHNwfjsDSMGtk24BdA
         q7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730228275; x=1730833075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySTL85gCZZkHnt5AGdEgcTbyspiCYGBvcQFbbg7bkrY=;
        b=ikbNMr7f3ehDCcKC2bA+aHHQPs9KKZ5vqxhd1k+TkST0W3gIKyDPdKIDgXDZ/CJWAM
         QC0b8bcVVjG8qa4gY1Lq3ZkusWq0PMmKW2bCRWPQfK7fncC6U5e+mj15tbK20vMOjlJw
         /QgzZ72Vnxu++RbBhDp+HyndkpcEhQEkV7OjmEqopKkh9YFocn+czSJeEBQKz7G6jafK
         T9XZsNsop1ZXGTcpH/3nIAPeAIH+HqE0EHP9y4UTl7P7Fssj7exmd8nS6CYANJ1rro+o
         awID6T4lJop19+tCdj2zq4sxbELDyuL4BljoSB+tPxNfTjd4YiQy3ayNSA+St5LvgakJ
         Zcew==
X-Forwarded-Encrypted: i=1; AJvYcCUsFMTnjW4S47GOfExqv3B2EHOnPxSmQVoQHXgDUJkDmKXh0beNPwOEeo+2pSwCbVmMSPpf6zOdogQqQnP1@vger.kernel.org, AJvYcCVbh6GVT+yiMBvJW8o8ho6sCE+C0Vpbfc/yxh2KIfmonM9uI+QAMoSWcZ28jmpjU5IRmTElj9kobkj/iHBHQDU=@vger.kernel.org, AJvYcCVjESkWYkzREJmXvm7zyXOSpMn9dixi/Z9IzYzRreyDEexJCq7stNdGvpeSsI6vcVXRVqh498syqfRi@vger.kernel.org
X-Gm-Message-State: AOJu0YyHJtOGOau3sNttlSU9D0coFOHS2FcGA+8uetYhEaNSF2eo+kFF
	rvet27lsTsz8mn8y1VKKhmeWgUtfaA/l6XqXkjwTmg5PG8+4z7mp3b82MpIjs6bpCTlxRXbPOOn
	g+OXeek6t5322LO//N9NnzAZp3s0=
X-Google-Smtp-Source: AGHT+IFk68O2VV8WqrVcbpew9zPtZW7HMmQ6dfJHfx5Kat+3TMbDp6RwBvgP+T7BGyPw79tq12gGL2xZCcPIQK+hp1w=
X-Received: by 2002:a17:90a:734a:b0:2e2:a667:1a11 with SMTP id
 98e67ed59e1d1-2e8f104f989mr6323964a91.1.1730228275431; Tue, 29 Oct 2024
 11:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
 <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com> <CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com>
In-Reply-To: <CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Oct 2024 19:57:42 +0100
Message-ID: <CANiq72kaidDJ=81+kibMNr9jNxg467HjOm9C_4G7WRvaiddGvg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Alice Ryhl <aliceryhl@google.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 7:48=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> One option is to define a trait for integers:

+1, one more thing to consider is whether it makes sense to define a
DT-only trait that holds all the types that can be a device property
(like `bool` too, not just the `Integer`s).

Then we can avoid e.g. `property_read_bool` and simply do it in `property_r=
ead`.

Cheers,
Miguel

