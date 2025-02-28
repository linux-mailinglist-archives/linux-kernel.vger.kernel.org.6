Return-Path: <linux-kernel+bounces-538092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 828F3A4947E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082B87A28D6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A12255E39;
	Fri, 28 Feb 2025 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bsp+D76t"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64224C689
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733989; cv=none; b=bLVw91qiM9G5VaE80a39JFigtoaEevOFcXNf1S3xSxY6mPpPO4XIhF5XrlbinUSbW5QjEUgNMImNvLifXSTr6QcadgqvdZ7jDNWMu4OEsFLGt5LSvGbSwCMsX0TKEKck0SHwX1xR4OIsg0iAdWCJR0xjTtJt8jWoAVcRy2bfYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733989; c=relaxed/simple;
	bh=pva24aYRpNiWC9FsBo0qUGxWRT3IvW1BGETO5F3BGfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUxpTH/DQDZUGuJj2oYT0w3fC4U2cD6+LgCiTuNGHoa4gumzKfuxQ9QgkcvxTd5nMoEWZU6DUOJM1wWksN0qmaSlwxpiZf94m6zkQioPSGzDjyQ0UdpBJ1KGTNLeAru6HRseQEJ9jhR9EEhLwjlDCkvJVPdf42kTNC36BILVR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bsp+D76t; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390e88caa4dso715719f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740733986; x=1741338786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UE/YvJUupiSsgGzonLP82Lza8kORn2Q/kCp8mnpZHQ=;
        b=bsp+D76tC2OYyU+/e73gGeMvLbuJPvjRrLx45vR+z2ramIqcKTmzpD5dXyfBXG9IFG
         I976dRPP454LPE50N1Ow7LI0jIAZSXH06dli85uXTRKawH+Hb8+vTKbylj3eb7DBOHCr
         U9N3caNtx5oXZqiJmkIoGEI5UWaUX16FyPyp2/XJoj6uBVvWBYr2mVj8Irqsh/a42LX6
         2ef+TBOHsD/7furnRw8VjVa1Kj2UEpXpfv0vhLLjryWCIQXvj7lATUdyN33MevelbPOm
         jf9n+ASdmfp0jmYG2MIsUDY9SLEqsLb/Rijr/33X7pVAEVKE9qQ0nJ190BX/TdsGX5hL
         vEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733986; x=1741338786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UE/YvJUupiSsgGzonLP82Lza8kORn2Q/kCp8mnpZHQ=;
        b=bNlB5FVW9HEZvMePD2Ee52G07RIJhHT1CtE4O72qjpHvIf8GjciX50C3jETII9sDVs
         tkkTSVcSXmaS003eBmEBh3RWZ8slXA4mIg18z/QsN2mFQx02o5TPmP1mRbG7TOo83Aip
         eQ11F+x87Qr0Tb5xQjy0uXcyHrh4/JuioZiWp/KbrgidkeAPH59Kd+vkQWqolEg6wJmd
         gKfPMaCn36ojo5NIXQvw3WApPCdinkJXy7/vnTF1myr5rTpeveYGv1gR6wSvS89LEBK9
         LbVk9gEUqaP7r5Fy8KrMUt9KKslcZ+pQbYTNWS2XwgI9+TWagevCUzOXFCvGJJPeAPSC
         ctVA==
X-Forwarded-Encrypted: i=1; AJvYcCWvlpN8+TRPOL85mkAmspe/mKI9CFtbKHLOBvijap5pHtyPGhLCCDJdWMv/+YMNUE6CUvjZilsLY5MvGaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZP7x5A4gWCAGmev/hOWhotYpWOxC7ZZTbGgR5F/XcPFDyxvL
	0Mn5JCZV1d13mkwnStuXhUEPhOd+Mxpz9fJp0D90R3A7ZWVakSozRhLyUwl/t3Ljy8VMNaiL0Oj
	ZFTrLa2Sj5XssRcjgLPXZZJD8PaQlqt4/wiZN
X-Gm-Gg: ASbGnctihx1W2oZxfvK2jFz058rAM++pcQSG3LfRPpAqx18lZ0ezqNKo4FBrdsB0B1r
	9itss9YtIPGO1RdT3iF2hiv3pqw3jF0lxiUxJDm2sZWmXbYtHJN2SumEKcqemldBlHG6G68B4Dy
	cp90cZex2mnA20kLTyrlrj5dvPCmdGsYHN5s5j
X-Google-Smtp-Source: AGHT+IH7F2qgKkeGg7xN40q/xIl5BTHBoei2fR3UaAC9id06WaZp2+BesjSXAFeh/HXA6v5AlrrIvufjLCKcg3xjbbQ=
X-Received: by 2002:a5d:5c84:0:b0:38f:31b5:b33e with SMTP id
 ffacd0b85a97d-390eca07632mr1728466f8f.35.1740733985837; Fri, 28 Feb 2025
 01:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227101720.1811578-1-bqe@google.com> <20250227105130.wkklh2wpybz3kggl@vireshk-i7>
In-Reply-To: <20250227105130.wkklh2wpybz3kggl@vireshk-i7>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Feb 2025 10:12:53 +0100
X-Gm-Features: AQ5f1JqKV_1F7FuHCvDQQhhosn3DkKsdWc424rq9Od7JyKejVlawEpvwzVg8T8A
Message-ID: <CAH5fLgiP1=Kxi0L0WSOsdR3hXnNgoWs7368pM-STDcJbfrr8WA@mail.gmail.com>
Subject: Re: [PATCH] rust: add bindings and API for bitmap.h and bitops.h.
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 11:51=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 27-02-25, 10:08, Burak Emir wrote:
> > Question for Yury: What would you like us to do for the MAINTAINERS
> > file? For now I just added the new files as F: entries.
>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> >  BITMAP API [RUST]
>
> I would suggest adding this too.
>
> +  M:   Burak Emir <bqe@google.com> (bitmap)

If a new maintainer is needed, it should probably be me. Burak is
helping me out with some Binder changes, but I will be the owner of
the Binder code.

Alice

