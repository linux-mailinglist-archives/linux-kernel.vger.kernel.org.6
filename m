Return-Path: <linux-kernel+bounces-536401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B413AA47F27
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2DB1898755
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1962230D3D;
	Thu, 27 Feb 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1z0o1s1q"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39E022FDF1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662720; cv=none; b=rRIqZsB6u2b6yqUYoVBxle8PULLgOowm003CXsl2h/mvmE9VICcFZdznIAOTOwcLfqVv0b4UEHsN1uDlLCHxYAUgQ1CzXOEWXH1qf3gcH4lReEZEadGdnYh4lRT5+a0St81JkoM0HWlY6aUawO0/5Yjjt6jhCfeDvWDYETTLzog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662720; c=relaxed/simple;
	bh=FPXKOnubwtxGvSabeo0XzmQUGebGPIpXPzAcK+fM3PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApPjQcxApmFVAetQ0dp/VgivGZIaj04q2XcAPXPGPnH5RJEaeAV1d+VOo+csy6zdkZKo6Ufp+1YXaWuFnDSujmoF5hObCT4s1kFN96PhkVIhhuPvg/tDx0ArUm/axfS7GI8wwY+iAlhbLvkiBOr18oIlzuLSka4J0qvkYHJlFHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1z0o1s1q; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f403edb4eso531005f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740662716; x=1741267516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPXKOnubwtxGvSabeo0XzmQUGebGPIpXPzAcK+fM3PE=;
        b=1z0o1s1qpV3PA7KU2OuzuxsDneEzppYAAQr46REPJvhCtYSzpR5omgW46NOZkRA9CJ
         tLCws3krEwuVPKg8TfUi5PVU8/yYNxmy/RJUYsjv1GQx3Bxn89XO0nJ9HHUNT/R1qx3x
         N3xg2DoLAqZI7CaZrOzqryRSzW6SK+qIDyOh/hDNqJj+k5lhwVk6JB644kd/vfAsdzNJ
         yNdTzvOiu111KXli+SHf8PJJqF/cXjFR/zIbkC+boy8kW4FC6DZ2LZtzSKOkHNhbiDqn
         2obFcUwqRfuG0DERm9owct5dUoAwZ+CWgrM6JTWkqIQZNBe9MK5QEt1Nb8tM+jc0XeGB
         ZBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740662716; x=1741267516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPXKOnubwtxGvSabeo0XzmQUGebGPIpXPzAcK+fM3PE=;
        b=R/Dm34ASFTKMzkK+55ULjFg9xebFBWIKgaAWwmMvkDHAn/EzyeHeBYY6irP1YZPO47
         AlXZDXgP3hNuww8Egly8QRmWL5RDIXNUkwKvEKW53ByqETWBPuWKWo7Y+SjTm9SBPmUv
         SzFRH355WVmAKQIgWbuUPw8A00g5/CBioZuKlsoAGUmrNi0nvYFk6A5aclMs5WSzXIVL
         tpAKp9kYT+ZWxec1GJl2M89JkIkTVRVjzpl5SzRHHaYF/ju+snTwBK6qcnlG72vI5h8x
         eKxV9GX66N/Qm3Dy5z8U+uNU0xVZEEodRNIFIWaydQ7FktHrZGNo8OZi4d+JvGBwCN8x
         e8qA==
X-Forwarded-Encrypted: i=1; AJvYcCV8+2iQ0o7mG4ziIRq7UdXqPAtGnmfUk6xu4Ed3a+zZYZXpg/5OucPOMjbDXpZqLOayOorp+zHRgrcq/Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgtc9SQ4HZLlOBHT8ffiUAxwSubI6gEoj3yuv5GsV4YSyP6fBm
	KrcDXDNe4a9WiHwVqU74dHY/ZqdISLnX5rvjo5RHC1A4FKnbUQE96OrVqjOa2BT4FXiLqVjtNBk
	UI7cdTDUuPBU/+fIKlFoTkUkNvtgvKTQo6yA/
X-Gm-Gg: ASbGncsdA9OyvNEQPr0yei5IAx854oX7meDHNq9hrT/lxPnPEDs45OkY5qoSOjlOfcz
	IQGyJT0tQElnev8VAQFiBVbU/Lz51Uo80jx7+EiajMK5r91ab9rmhUlw+CD1o/L7pR+ivFERSpC
	7+QTLptC48JH1I8AXGTTRoBOLvyUNKKGDXm+MXKw==
X-Google-Smtp-Source: AGHT+IHy8zudNpaVlhqjwf7/FFm3lrw5KuniLEdIbJqJ2VUBvOjf2KMYdUKZ0sZ8oCOKpLHJDejQPK+NStQco5k64mE=
X-Received: by 2002:a5d:6da2:0:b0:390:ea19:d167 with SMTP id
 ffacd0b85a97d-390ea19d48emr710358f8f.31.1740662715929; Thu, 27 Feb 2025
 05:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-miscdevice-fops-change-v1-1-c9e9b75d67eb@google.com>
In-Reply-To: <20250227-miscdevice-fops-change-v1-1-c9e9b75d67eb@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 27 Feb 2025 14:25:04 +0100
X-Gm-Features: AQ5f1JrHuSdLze9gYpewQ1ayC1a0iYMc-00b-ZP3qzOmuj30_LWSV5_NQTnvhXo
Message-ID: <CAH5fLgg01C-=rQEzHLp6GZVO_a5nAFvR5qhYF81Y-CFw3hfwmA@mail.gmail.com>
Subject: Re: [PATCH] rust: miscdevice: change how f_ops vtable is constructed
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Schrefl <chrisi.schrefl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 2:23=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> I was helping someone with writing a new Rust abstraction, and we were
> using the miscdevice abstraction as an example. While doing this, it
> became clear to me that the way I implemented the f_ops vtable is
> confusing to new Rust users, and that the approach used by the block
> abstractions is less confusing.
>
> Thus, update the miscdevice abstractions to use the same approach as
> rust/kernel/block/mq/operations.rs.
>
> Sorry about the large diff. This changes the indentation of a large
> amount of code.
>
> Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I think I must have misused b4 somehow, because this lost the v2 marker ...

This is version 2, and the previous version is here:
https://lore.kernel.org/all/20250117-miscdevice-fops-change-v1-1-ec04b701c0=
76@google.com/

The only change is rebase on v6.14-rc2.

Alice

