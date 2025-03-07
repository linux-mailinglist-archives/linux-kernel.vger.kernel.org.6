Return-Path: <linux-kernel+bounces-551022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8DBA5670A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DD93B1F1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59221858E;
	Fri,  7 Mar 2025 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRu4OUH2"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F1217673;
	Fri,  7 Mar 2025 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348124; cv=none; b=WBqGk3ZWGdVOc6nwxzq+LEK1V9WVUsNPuKEdefuq/ZOypLAhpAR4sHjMBPQp7tapK9K909bKBpsN9jS4PiDBgz/a1qxI2yMzTN2U3CL/EKaK7zw9896jrntALz2X4XYKIPn/17EPjCD3Dad0tUYCw16AnVXZYvzTDIjUQrSKuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348124; c=relaxed/simple;
	bh=mS83hYzU6EdawZ4RXVjmVIjBQ0ky7khcAtS5JCNcy7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzzRtMAsPtyZfxhGEg/zzWEMoWNsW6a6BlrIOLNH0p2BikymnA6x0GtE+7S7srJ9KcYZ2HaRoU3FXNJFBZbJ9cWEhF6k/GDtnG4LkeIWKm256VRF17nheBOv3q5aZwPpOlz45dql0CauUpO2IF9Njsk3m7CwyL/3Sj0X9PoHCHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRu4OUH2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff611f2ed1so431117a91.0;
        Fri, 07 Mar 2025 03:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741348122; x=1741952922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mS83hYzU6EdawZ4RXVjmVIjBQ0ky7khcAtS5JCNcy7I=;
        b=MRu4OUH2kx3wBHdu41lc0byQKWx+7s00+4vsPR9DWbTzqr4syRVweK8T2SX93IbKy0
         Th4zob84wSKnzxFUEY9COO3ldHEVdq4gS9i09q0xcXAT210oRVvBvG+jOC2y4U+lSzat
         q/h/GiXEUNibLdG2uSWqeVJsPoH+UaSSl0bwrtNvettjb+wRGIyVIdGcgqwcq88tq/G8
         vLa8iAj/oABR3S8PYRGYHUlc8gh85bduP6uU/e20e30/+xHv+RvG8/Q2ycbG24LrCgCy
         9DfNvVU/F+OkKK+A+/8/0fpznVRWxNnqvbCojEMeJ54hXQMQq/umQWFfw0MaGx8eRsEF
         0fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741348122; x=1741952922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS83hYzU6EdawZ4RXVjmVIjBQ0ky7khcAtS5JCNcy7I=;
        b=Gg/SvbLLY/nXrOpdwXPlvrpyfmGJM243QTE7RYv+ytYTrK5HDTywatNRBNbQTzoIQM
         WeSUzWFvcr2JtUq894/uxfRtSjCWkBIBiofTMVFb00anY3mgQKhDOR/fhZ6F+eu+td04
         cKoNCj2aWsagWhpeobd4nzs0c9e3D88bmISPuQCyTZoJTb8DrHlnDWEJ4Hd+FltJFpag
         xohcm5A90hPx0V0CghlWMNmc9pvjrIfGHgu4PouS+L9490RPYF+pjJaWmy7x+fgqlZOj
         lkuqaIbGaFbYLObP70DKAsa3+CyhYHbpcUqNAn2sl5W9kiLrdwWZJ1KDIF4X1LA0uOx4
         3Hcg==
X-Forwarded-Encrypted: i=1; AJvYcCU71mEoWgFY/CZ/yIMJsszBiphqHNUMV4jACp6Uh7T/yaZRZmLKBF7BHrIqvC6vwmIPIOwHDYyFah1v+EUdXKE=@vger.kernel.org, AJvYcCUslDDhH1oAtmXv5/KhCWiAfhxhympOzbW5rhZECYLk+4+H1+BHx2K+hIwuxmicZEBIPjb4mG7kJ8dqQzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8viKK6krVVDFKJowqMWLfrgkpMaqw8COZC+e0JH+tBh+pW83A
	xswm279pgEV1qKiND+lWpZ729AABGz2j/9kjzXrDFbWkRirhFAFLBX/0mAZV47kxhAZ00NmgckC
	Vgzag5o2VXqJkX6MbKBUMgOaxKnM=
X-Gm-Gg: ASbGncu1AHEUtvJwXxPhCX6FLHqZi0S8DYkkQ9kJRW7Gd6hgWoE9cBcv+sCA8K81rtn
	jrd83umDTj/AQVYnviZx3kXQHhSaYJ1BNYOHedrIQngyKjrqXwnIq/Ab7acBsG2/9Hovq9BGwS0
	f0AZCWaz7ZnGS4GgSBAGUB8lJH8w==
X-Google-Smtp-Source: AGHT+IHPZqtCGbMEoElsXHCKwfjspW3Ti4qZFOBDwPjafv3DWqQR3PBGuSRuV15GcsExvjUcH4JxxbsOVBuuMFtjAqU=
X-Received: by 2002:a17:90b:4b48:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2ff7fcf0a67mr1302493a91.0.1741348121973; Fri, 07 Mar 2025
 03:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6-mv8ahCblqal1f_T1RcVPPPb6QEedsAXlhmcyCNC-lnvAj1USOInn0YNogItuEdy_KthnPdFDElN1F6A9ncwA==@protonmail.internalid>
 <20250210-rust-analyzer-macros-core-dep-v3-1-45eb4836f218@gmail.com>
 <874j055csy.fsf@kernel.org> <CAJ-ks9mofNbtGqoYBummkfxZ+zrmEHg5P6viVwwgs9-BuNGbZg@mail.gmail.com>
In-Reply-To: <CAJ-ks9mofNbtGqoYBummkfxZ+zrmEHg5P6viVwwgs9-BuNGbZg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Mar 2025 12:48:29 +0100
X-Gm-Features: AQ5f1JoRmczSy095oDMl7fazeSgHgV-7LfARQvsiTrt41sD_aG9uRcEj1QmcNu4
Message-ID: <CANiq72=_LW8dBbFbQz=tuuck07OhpPdPGuiEtq-SQ1=g-PyNFw@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: generate_rust_analyzer.py: add missing macros deps
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Boris-Chengbiao Zhou <bobo1239@web.de>, Fiona Behrens <me@kloenk.dev>, 
	Kees Cook <kees@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chayim Refael Friedman <chayimfr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:06=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> It's in anticipation of this follow up patch
>
> https://lore.kernel.org/all/20250209-rust-analyzer-host-v1-2-a2286a2a2fa3=
@gmail.com/
>
> where the return value is used to identify the crate. I developed the
> two in parallel so I added this return to reduce overall churn.

For this case, it is not a big deal (and sometimes it is a good idea,
e.g. a `return` in a public API that wouldn't make sense not to have),
but in general, please avoid doing things to avoid churn across series
if that can confuse others -- future patches may or may not end up
getting merged, so it is best not to rely on the future.

Thanks!

Cheers,
Miguel

