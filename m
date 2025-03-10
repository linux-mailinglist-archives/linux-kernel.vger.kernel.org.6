Return-Path: <linux-kernel+bounces-554945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66982A5A3B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21EF3ACF61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96800236437;
	Mon, 10 Mar 2025 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/xn6iaE"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357D235C0F;
	Mon, 10 Mar 2025 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634080; cv=none; b=JhAkbY6EL7eg7z3f4Qln4b+EMo9anO5Kk2mkiv2nK5qad0ieJBFnCANsZ6suZUSv9w9rxlY3xPwtwNmq4VfKisi4U6fc2Iy0N+8l6f6Xf0nwj1ly8OplzcsXodeZY/t2qTccACuD2GQryy96eL5Sa8A1LvDUWDaTFiAS6aMYZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634080; c=relaxed/simple;
	bh=1bJsGPctA0eovE383xm4/wXYvNGOKsjZeYReAtPFtxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC+zYDZDsdJdiawVXWRYlUL7KIcpRnS357QEw7BGMXXn107zZ/pIzFQEapLb1uwhaPLJKv0xu16n0S4qUwzYQqEL4nmIjnFWiRXOF7uTVIBRcMHk5CQrL9safDMRdXYdl/n1n1qEkOcpVQITJZyJGNUCw+9sG2QL+8OUZpCCTJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/xn6iaE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso1240998a91.2;
        Mon, 10 Mar 2025 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741634078; x=1742238878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bJsGPctA0eovE383xm4/wXYvNGOKsjZeYReAtPFtxI=;
        b=i/xn6iaEvD8CHinRa1YuUe/18493Pslgyxoyxry2lFG/HYWjch3hNwQUBH9NvDsNDP
         RfNf/PgngFcEZNW9Fauy7r8ercFY0qD8c6Dz/KqeRmQJHJlNEZDDQkNMhPn0MTZcyzGh
         knaur4JGTXABQfa1CkWAN34PcSgLhH6A/1I2O0+93xm/6spYMehoGPOJ3JeVofvWHJGu
         BZRcvMnrhkWReyyh/uQ2obWPBu6TUcFyYl49JOBY6KTFKr/GU7hmDQMrw+sWwudjDRcG
         oT5ccHGFNNyeXKSFn4jH9KGxz/oOi3f0IB9PAhtKPH1wvdShB9ckRs94DxR/EkmCDZc+
         Yngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741634078; x=1742238878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bJsGPctA0eovE383xm4/wXYvNGOKsjZeYReAtPFtxI=;
        b=NHxivuiJ8iMFIGI3ZfGnJk2e1joQ1L+TY+fi+cvJMhXDCwA5AQDv80vkS2UmowwfyZ
         CTJd/yY25U4GxNF5xboraxaPdElYzS6umrSOtdrSgp7Lg/L194E8ArANh29kf58F4j9M
         9OFkGs+7mKBZ5V5UO1jfuA+jt9Jt+MpOKJCZKPR19u07X8vZAzpwm2AYVcy67h6GEkmX
         EeSciXQf/PVsF3HSOAeRAzt81cFT+WeDfvxPnQQpSw6jL7kMOnbaQzSVBh2qcn24LvLi
         T4M8YxyWwPVnxPXDl6aamUk62xE9BNozXPFCmdweoKKP3hu3bioVXPQLsB1XwSYq7+ay
         1hfw==
X-Forwarded-Encrypted: i=1; AJvYcCWPolZv6RBxeRjFgYRu6jFHO62baZdNd/Q/1GPcF9fxlnodSsQax+HjoePvX223KfsNbiS002rjVJcqoZm867Y=@vger.kernel.org, AJvYcCXxsw+EhnvceghlH90wnH0wQIxLncL3QEy/3HPMTCuYe/EbhSZcqxgNfNmWdHsdCkogda6ZTOUn8Cux23s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBUZwWRRyqPjsFJIRdYWqSF3fKLSdW6J6sD99NI/1WXy0d0LwL
	Zdv1qPPDJ2ByQsjDT/AauySxBlR96riC0T74l0ng5Zh0zvHc1SfpYYIgTrnroHcvnAsHL1do6IW
	ZQKOSN/NBWd1+K7OnQVFws6HihK8=
X-Gm-Gg: ASbGncvrV3q7BydC5ZCJsUdFwcJNg+RGiFChg+d46yVxipoRCl4la+ejWFTEQnAvI1U
	jOKL43YaRYbSklwtlb7i2x2LVq1/1oeq1Ir6Y991u1fV8aj+BExv/AbFYDXcp2g/nsl6odLcx2m
	rstSObnw61vh3A5GCmYw8YTBxRpw==
X-Google-Smtp-Source: AGHT+IHcImStYiFhxdCN7BbQW3tWj0JE4J7rB9uymZy81aClLkhuvbWPsuk6L1MdbTyoiclzdpBgRuIlNOtnXoa6408=
X-Received: by 2002:a17:90b:3812:b0:2ff:4a6d:b359 with SMTP id
 98e67ed59e1d1-300ff91fb2fmr412741a91.7.1741634077849; Mon, 10 Mar 2025
 12:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310161947.1767855-2-bqe@google.com> <CANiq72=uBYDBn2CS9OW-+S0=rCZEJFdrcBAk8yBQdNB+0Yjq=A@mail.gmail.com>
 <Z88tDeoZ8lyI14w2@thinkpad>
In-Reply-To: <Z88tDeoZ8lyI14w2@thinkpad>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Mar 2025 20:14:24 +0100
X-Gm-Features: AQ5f1Jp8zdeiqlXAckC_spF5ZIqU0Pnj_7UoOLIv_JnxOk4fywaS7Vc7N4-1oWI
Message-ID: <CANiq72nrPwOpY4GtwO-fHaL49bVthzfNBTcSnMbowd0DgiWcww@mail.gmail.com>
Subject: Re: [PATCH v3] rust: add bindings and API for bitmap.h and bitops.h.
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 7:18=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> There's no such a thing like 'struct bitmap'. It's internally an array
> of unsigned longs.

Yeah, that is why I said it, i.e. the docs seemed to imply it was
wrapping a C structure.

(There happens to be a `struct bitmap` in a driver, though! I noticed
because I double-checked with Elixir... :)

Cheers,
Miguel

