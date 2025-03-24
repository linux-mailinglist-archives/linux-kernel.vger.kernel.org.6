Return-Path: <linux-kernel+bounces-574583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BD5A6E726
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33588188CFEA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7665D1F0E51;
	Mon, 24 Mar 2025 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8vwAsyQ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B81DED79;
	Mon, 24 Mar 2025 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742857812; cv=none; b=QK5XD5xDDzoWdwafMaxEHKHLLMElR45TLFqiHmGZTiXWA+quDsWTyxCKNsTRoiTFaZb7QqzP6/kmirk/5FdYp9UATtpvkPWux1SN7ZOo4RcY3IJVLwP/cIbD2E2OVsrqC2kmQk4iO1tE5NCZ5d3n2MTWSWvjWJSRRcf5zNg08fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742857812; c=relaxed/simple;
	bh=9I8KQKYlVXXDa2GWgnH9sokfNCoithb5dsrUI8nor1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0C2iHAqdu78xwHXrHwUpIONTZui0XfnInsS5JadXH/rASN8K97YkDlTGrVeEJLr22Bjmi1aQ4XnJaQm8wsKUwTSDZYs98xij5SASMD2x7SWWTK/Mp3sK1dddGOEBT8bCrE9Pw7+btcs/vR7gkCQhw7vTJxKrtHnykBA4byuKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8vwAsyQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so987460a91.0;
        Mon, 24 Mar 2025 16:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742857810; x=1743462610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9I8KQKYlVXXDa2GWgnH9sokfNCoithb5dsrUI8nor1s=;
        b=T8vwAsyQ0QmsHn9cX/w8ctHR7ai6w2gZLdHd8B/Ep0Ln4tNvbdBYqxKFrgO6aoj4TA
         jRgbxtZlmTyrmjsWvkRHEel0MyRlrJyfr14MUcwiZfAGTs5M/lGCI3xG/5aGcYI/xV/8
         NcuvWKg2ZVAtmDh12Gvrb+63tg5ZMSK43iSREMaVHwr+8GB3vsBj+BWR3KzguDEcXFwK
         JuVokdx+klMyG/U59bNiaefYpUGadtbIJ1KctbGKm5c5+UH3eDCjWHfEjYA2O8jkpLv7
         lGW3A+JyXAYsHpfEB1WdhP4HNlRXQCkQKVWzimEB9Kk0XM0l+3WxKM5UU+r7TAmZ6D9d
         HDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742857810; x=1743462610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I8KQKYlVXXDa2GWgnH9sokfNCoithb5dsrUI8nor1s=;
        b=N83mEAVM22Cx8zV1Q6ICSXUa2CDRziBJTe6WzWmpbvIMMD45I1airhOse0UDu1gM01
         gEpxYRmjxN36AjepDEOoAGVdHgsB0vLSC2yEZOqY2s8nLba6sEjE6DkU241Izn82sGFB
         QRh8eS3yE9EB3SD5tmTvy3ua7cE/GGqHE/ndhu7utgI4em4foDC8liE4MJQ9OQo6uhEL
         tizBWc3qOfcACKcm6VtV8UjKNS74mDVzk1y8CI5u5fk2+E1PyAshBF4DrkeiJe9wqBuo
         lH+sTPxK7YMe7kBpJb0OMF0UII6byNY5gJ0X7px+TavHRz3vIofFutPkEFmM/W06rfdv
         4MUw==
X-Forwarded-Encrypted: i=1; AJvYcCUSc6YXRRoKiVhA45aJq6k1P+jrA8wdlgORXypUunGVw1UsE28usetsxibOnlE20uHGGauByu7tETA3mLc=@vger.kernel.org, AJvYcCXt5ctIfTvIaH50Pl0EE8nxOpD3JnWpem2LPqeuXIni81Ltn4yxIcdeKeo1ORaUzq+FxbCQkykLq+732gjiOGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPP4C5HJNlpdWBl0hwdFwDP8JqPm841JbpYX1LFtn3ZVTeGZ4/
	9hBVtLiqzjkqrdCENRlPzD8l3ALbsu9ZbqgokUbx2dD0b3rLbbcK3dDLXoOj5arCUM/nLKSew6n
	wwy8eNKVBfNimfw72fmQTBI2iyxE=
X-Gm-Gg: ASbGncvZcfaJUjpGynOlRbELCV6g41H+085uHoD3GojaTymKRTszsApiVchCdi72kv3
	iPhZXrKTRp1REOU+/xSdBawutz86B56pWN6sHKcQhZXSK1a5of2ralBjNn2Q+pBX81uvORTkLFx
	RgkrMnQFCwVcYvnOf+bfcbyQy9OVr9bQ9aC2wK
X-Google-Smtp-Source: AGHT+IHiw5wJimpAjJws1j5GfyzNNmvdTmtt+Gdtx8BghKlWqDwaQomsOsLGjrJpvBuh7t+if89qAAVbaQkJFUfRQ3U=
X-Received: by 2002:a17:90b:1645:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-3030fef4ad2mr8519928a91.3.1742857809561; Mon, 24 Mar 2025
 16:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324210359.1199574-1-ojeda@kernel.org> <D8OVATSS19YC.1GXZRNM6TBA0X@proton.me>
In-Reply-To: <D8OVATSS19YC.1GXZRNM6TBA0X@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Mar 2025 00:09:57 +0100
X-Gm-Features: AQ5f1JpnGCnEckuxVoIN7plR0rZlCRqSBHxkP_kvLOHPlP1ckzapWMGe-fd5zW8
Message-ID: <CANiq72ng_ABVR5ihxMeN5Ast6Lu0-zxkgjnKzbtn4j3ghFKgZg@mail.gmail.com>
Subject: Re: [PATCH 00/10] rust: clean and enable Clippy `doc_markdown` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 11:59=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> Not sure what you mean by this, but I think we need some way to disable
> it for some acronyms.

I meant that maintaining the list in that file (i.e. globally) could
be a bit painful if we get a lot of terms, but I guess we can find
workarounds for that if it gets bad.

> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Thanks!

Cheers,
Miguel

