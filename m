Return-Path: <linux-kernel+bounces-564555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E564A65752
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DE44215EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7F21A264A;
	Mon, 17 Mar 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi+HyKlc"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE921A23BC;
	Mon, 17 Mar 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227049; cv=none; b=XCfeKzXsUTGl2sQyYXQ8q8Qf6d74yBf+bVyWysx90mqG0FvgOHVCG77gx3NdjjdpLIf/3lpffExojtQbTxpMjerjKEcOeHW9Lh6rHa1ET36AozY3alXx7KRPnnbf9TvODKZqNOn1tl5aAuGIbmz+TwgChn2Q/wu36KGH6/nDLok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227049; c=relaxed/simple;
	bh=laCuTv5F1A6gMhBlXcgyrlzImrJDzVe0buSdo+i4Of0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsGJF9xBMFLYf6vvuEoMsCZwy0zKVJeeHxURYorSA3ZiQqc76Zu/HNTfNkmcDyDCcUREOwuBpf2tjVLU6QMFEUoMgR512G/D4uAxmAkOaKuPXbeVqCBsWKM22ndwYXlxUBRri808wmObU6QAVsUzcramppROnRFRqtX6almjO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yi+HyKlc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so660964a91.3;
        Mon, 17 Mar 2025 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742227048; x=1742831848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laCuTv5F1A6gMhBlXcgyrlzImrJDzVe0buSdo+i4Of0=;
        b=Yi+HyKlcnMg/pLC4+1YelgxWAZpDfkAanYNVSlDHWhpboFp85s39TsU+G757OTpCEB
         1ILRjg36KGNegdFOQ7QDdjGxvnAKdDiY9uy/OpTiq7I6Eir0M/jSGy/QoHs+e5SEBY+k
         gFXzRu6FCqYUSW1WKaLQtzmwJNOjFTx9hIsM+ZZNygMO4yBzPoJTrIybdnBfkLyDxWXW
         loGGGAqFctxvp0heNvMzTsD+CT3JADnpjeZP1isIQlBctgT/omNb+mrrUFcKsdb/mbpM
         l8RAp0YQLd7A4M77LHhoIIuy2asyAOLTr8ayK7aOPaERFzklwx28OAfJV5mXsrGPwXRr
         dQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742227048; x=1742831848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laCuTv5F1A6gMhBlXcgyrlzImrJDzVe0buSdo+i4Of0=;
        b=jLVANgtFvxXmRywzG3CSfetpr9pFm4+udCqbgUDtt6sG4OyRht7GyAbjYeoOW4rQ2q
         uBVfLFjWunVpxuYYeAEsZhnc18ALtfJ2lTj4s3b+h/K+ApAb2ZV3jkdrwNJBuTSrATuY
         cqglYfflmUWGiAQYbFDGKprASAN1ZnhzBtFcupHf9+aLoSmzxIJzOLQzWVnGSFxBG6rC
         cq4MMMWInECAHm7jXfgX6AOB1iX/C5uTG74AUxxRXrueVm0lVc5/xAQCJUp5la0Nh0gX
         5zvhgPrwJDD3+81KFWAr1ZolkuNyrdtcqXRJuNghof4YNI0gcFY6/ab6LDiVeNRngSwN
         Ayzw==
X-Forwarded-Encrypted: i=1; AJvYcCVUwzn0AibiyQQiFmMxGN9/8vmx4x4n7cF4bEO5said27d021cfd9TMfMKYWjHpxl1TIDA/gf8PHP+OBug=@vger.kernel.org, AJvYcCWnd2n8t69F9NudLCb7tGRaTswvx99oVxdJH2930RUpXL5FFelBXvCB9EgGiMBatN9Hn9twbW+CnFN03esWAEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1ozipoh0faS/2S6VIcIE3GSdZkd9u7JQtjk397jgJBlYXscJ
	FDtgofEEYqJ7i0XHPI5fff3jtyp75pF1eDk5rkzxN/gsePbXpmNe7R38g6+LdSSEqZ0lGZKuZ5m
	oMHrhRplCHYE8vzkPolIyI4nzOIg=
X-Gm-Gg: ASbGncs6pBiZE1NuCGKOiAe4zD8E9Md40GOUbxu8L8Kyg3XlWQjTK6U1hRr0lGKb89Z
	JU4I3kG8dJEwBmG5fvqjgtllw1ltxTNPz1UdypbcEb1gBcuZVYU3Xs/JgoaVv88u6d7OEX0Xcok
	g250eTrMmu8vrsHpQN0MZ+Rbu+fg==
X-Google-Smtp-Source: AGHT+IEVYUxwx5E9jnbQsVPneJnZeRgJshiR/gfhI42yfApYsUWLNneAxhc+MmSkVoIX+iFteyviofpyQLBZVNXAaMM=
X-Received: by 2002:a17:90b:3850:b0:2ff:6941:9b6a with SMTP id
 98e67ed59e1d1-30151d40343mr6084294a91.3.1742227047825; Mon, 17 Mar 2025
 08:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <D8IMA0GUIPTD.34ZEZ3W8QSKTA@proton.me> <CAJ-ks9kXZDO-5utmQb2HLkxmxmQ-bg8jZ4FdvDatTj_79W2dMA@mail.gmail.com>
In-Reply-To: <CAJ-ks9kXZDO-5utmQb2HLkxmxmQ-bg8jZ4FdvDatTj_79W2dMA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Mar 2025 16:57:15 +0100
X-Gm-Features: AQ5f1JqXyKshe8vnYtXANeddPDy0kCXR7B8Tw1pBs_cBlrxTV_PWtFpByDO-91o
Message-ID: <CANiq72nVPag-9c73rVTpm5A6BOtM0jq9f9n-dobP8QDOoK5EJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 4:38=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> It is my understanding that the kernel's policy is in general not to
> add API surface that doesn't have users. Rust-for-Linux of course
> often doesn't honor this by necessity, since many abstractions are
> needed before users (drivers) can be upstream. But in this case we
> can't even mention a specific use case - so as I mentioned on the
> previous reply, I am not comfortable putting my name on such an API.

To clarify: as long as the future user is known and agreed upon, it is
fine, i.e. what cannot be done, and we do honor it, is to add things
that have no user in sight at all.

From time to time, but not really often at all, we have added things
that will obviously get users eventually even if there is currently no
one. For instance, all the `pr_*` levels, even if we do not have a
caller yet for some of them (in that case, because it is simpler to
add all at once instead of asking for reviews several times for
essentially the same code).

Cheers,
Miguel

