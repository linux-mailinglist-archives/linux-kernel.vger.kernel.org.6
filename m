Return-Path: <linux-kernel+bounces-265778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B6693F5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3FA62832DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C9149E1B;
	Mon, 29 Jul 2024 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9KPuP6U"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B102148304;
	Mon, 29 Jul 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257246; cv=none; b=jt2YCJ5ZvQ17aidNLIHiRqc1r9HK0T7AF8mE11TLQY2T0SL7P3oAZ1jMpTJUeXODUqm6Y5Honh2fjVIler93v15/mUHD4jnqqpr3gVFb3B01+WRZKzgP+sdUFf501dBdpNglm48ewmVX6L64Capzs/u0SFD4joigFO+ej5NTDcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257246; c=relaxed/simple;
	bh=xybrMFv0tLvK9ZzP0ZErhnNVRB+K6vPelKBUKtae6+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuyanB79jf0mJwqyVP2BGJhF8BJNqNEAmy7e6hyikQBdnoZ6Gxr7Kv4Y6wOMlwkMGe21v0vr9kJ4/4bWGNy/mE89Qj7AxeFrpaFdHLJh5xVbCSwVE9zIZQv+5Wa9x+Z+fJT/d1eBRJ1DHFwuk4MmD0tXScXa6Fe+xqfpGxG7QI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9KPuP6U; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70eb0ae23e4so2107243b3a.0;
        Mon, 29 Jul 2024 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722257245; x=1722862045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xybrMFv0tLvK9ZzP0ZErhnNVRB+K6vPelKBUKtae6+Q=;
        b=e9KPuP6UK97o/mvniq0J18Dkb329OQCzQEBQoyrhuc/jkBhX7vRFottfKHk1KTJKVU
         ARVm+xSlJ37ueIsHza3x+uSu79fugA6+cnlqwsJV8h9IeGdaDe+cxFV7XwWjBdjF8ZAY
         AUFUfdqlJnDEgjnD8Ee9Kychtit+FM7YrjyRh+GRMnqKi3v4H70IOfdz+alLOAzlwy9E
         yyakVOfO/WlquySuUuYzxAoI+8uxe1bdgpyxCOrHK1w1bA0iKAGQppXoKAmzh7Fv9T5W
         LCOIV3XRzL3ANyLrGY+Fucff8bJ4Ty8r6Ncjx2zKiSsIXLJfDv06Xff8+qrUtaVSmNMY
         5nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257245; x=1722862045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xybrMFv0tLvK9ZzP0ZErhnNVRB+K6vPelKBUKtae6+Q=;
        b=ZyZYtP5NedgdCdc/3jNigUHBop0Se15JmWRud3vASyuv41ML6uQw/5njs+6haP6Wg3
         YzINJK8dS1RZYjMeuXT3ybbQiA2b2R+NLUV95kyb53kypWwrN3G7b9CHoiTtSHMLDoBw
         vfyYD915qK+c3peV0uuK2pKLvxKCwg4pRnxgHI8bSBrGTzsQnXWIQHioNzM4demS6wFl
         g24lMzwoz7b1DMCDjYL1kIjUTA0A6JaWcdYMsZGtgehGSZ8aNBx2TcgkztAG719bDRYX
         h2ur7P+nBnrtNX1JDEynROk9UHDhHMYPZ0g0FPIr0okaiFMlftBqPgdHMKIHuf/TK4/c
         FfdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNP8Ax+oBDDoB/5f5Y7sejfM4qMZcV42pePzfXp11ez3Ay+0eovtta1F9aRkFiJqp1lRSe8d+XZjZ4lHAxn4pLZHRkv40LnAO0TSTIpVWn8nT5idAFKk0VtckyrrhOs3VjgyXqdu8O6aD5FUw=
X-Gm-Message-State: AOJu0Yx6R9m4ufUWEdgYg0bVpYYvOPvmIX1o9dxL1Y2J1o6MuILDg7Rh
	lXpRX9ugmUXrsTHuCBVqjo/AiBdsYE1MAHwNgfKO8nLqjzyfNzfllgKcKWK1jNoKlvg+Bcvx85N
	EOIP6TMUQRbQrXxLVB9u4CgW+IDI=
X-Google-Smtp-Source: AGHT+IEnmV87/lZZE/9HhfyMADvh6qBGRtFi0cyC1KcMUMEI73XyuibiYqA3Ia9nZODzBMO7wFPNvBfiyCXyd9IAf1Q=
X-Received: by 2002:a05:6a21:788e:b0:1c4:23f1:114 with SMTP id
 adf61e73a8af0-1c4a12aeaf0mr6026445637.20.1722257244884; Mon, 29 Jul 2024
 05:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725184644.135185-1-ojeda@kernel.org> <CALNs47sFD_GqhXNa7v+eC=O96A+SpPm4QtZ3=GbSxZ4zkTm3Zg@mail.gmail.com>
In-Reply-To: <CALNs47sFD_GqhXNa7v+eC=O96A+SpPm4QtZ3=GbSxZ4zkTm3Zg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Jul 2024 14:47:11 +0200
Message-ID: <CANiq72k1H_LzugFju23UdNEzcYHV5xaqVSL2Xan__Jiyvi-_Mg@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: indent list item in `module!`'s docs
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:06=E2=80=AFPM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> Not much needing review here, but
>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>

Thanks Trevor :)

Applied to `rust-fixes`.

Cheers,
Miguel

