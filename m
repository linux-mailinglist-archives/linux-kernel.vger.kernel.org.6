Return-Path: <linux-kernel+bounces-538040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D53A493E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF08C7A540B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEFC254843;
	Fri, 28 Feb 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKxQG0ur"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE01DDA3B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732408; cv=none; b=dbjF12T3rFdqND9QAISYGPACJmpJdtL4bZkAaYXNap3G0FmMzaTmAZ8LO6P0HLyMxFCDypP/z47z/+AhgK3u6TZJDgHc7cEN4eWNRMdmY/Tg6+SuIe8Hv8iDWC5qy7Uz6WG0xsxsa776zMxy9gHOwMrQZDJ6ZkNV1Nokvuv3v+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732408; c=relaxed/simple;
	bh=tMZPZGCZCdalLb1ZDnMoCsbeWqjCj2h9ReJgi+pJbok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiV1123AVQpzglYCIPr9n+u8EbNQ/Ns5drbEkamKSEWDEc6n8FHTwqRuozxDFzNAPlA1Nai1uwp4EKUfyAlGaHA0eqoPknktnwcSvLHMNcRw7aL+F7blb1xDiwJJj3kCzJmuNV0gMlv7O3/ls079kbqgpDNfQSH3k6PPe3wOAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KKxQG0ur; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390eebcc331so262699f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740732405; x=1741337205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMZPZGCZCdalLb1ZDnMoCsbeWqjCj2h9ReJgi+pJbok=;
        b=KKxQG0urFuzzBYjd2XKPsSnnM+eOohoRYGzbr/RyJICiuiNV9J1lRwllSe1Ghvh04U
         gkLbdv/L8K7M1mCGVi6oDI/IfvNhfwCzOvBjv7fM8Cv/lRmGKOROQfEJXUkez0KEXcdR
         RpQu7zPp8hhS7vSAIi1ME3cR6hcaRYBN2TdhmQeRtZoshW5TCwYRBv+anFLr8BDKu1qo
         tETc+QW/KcGZIyn/hU49RcPeHdvKTXeD99/9jA8V/kCsX/TijDJyenYZgBeIO3FlUxEN
         gnU+g24kt6VtbdQLnUvXOi3plR7Exz/DJfw4XujwoUHLmgIIxx92l3nuI4eCHdNE8nAK
         VnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732405; x=1741337205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMZPZGCZCdalLb1ZDnMoCsbeWqjCj2h9ReJgi+pJbok=;
        b=M1QCLQhNEGsqi3MNXNVM220zXiuejVutptRlkCiRXbC8FEvy5juyZKExLYoK00O5EI
         MGJRmE7AK1wFIjrB41EadKkfSCyYdaexFrXvx5hb+CTWPnrjC6eINwPbopJ3dWKs0GB6
         7lUCq/f/yTjTN413aBDbiJ8ZH1IorTzISOucvSAAC11nPyA4+Mpogyq8FHYarhOBc6Yb
         cJ+8DMF3vI1A/y7XZGyrKVV9pCaH5kpsh/N0Jn6ll5X3nR2svXK9jr6UoBu1wwvlzkX0
         pqtqIhmIC9t6X6oA9by8W7OAsiYhVmdjX9/4tCUgRpCTwg9nal880buUQqyjg4nN/Pfs
         /eBg==
X-Forwarded-Encrypted: i=1; AJvYcCWkc5vD/4qAikr3uLC3Jm5FFVJlzo6G0Ibf4WcEkjNlO9VXM1ADFqWSSse8JP2xn0OyRotUUU/wWe5GpnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIr9zoXHHCKBD2vgd5a4QgY8En33PwSTzAv47YkPQqw/JQVrsv
	qHvmesqX8vgwZ0jHWoWLOnGiAb1a8EnXCTK+9fRCyAimfKO59VWMCZiP7pf24m1lkEJNG+PwDd3
	4oJ5vF/x1Pobn086w3gnk6Gb9rT2DcZneXp3I
X-Gm-Gg: ASbGncszTJyqKLV3JUb7/8mR/dLsocC8zx5Qdr3qplV77hNGyFcLiQ/cZ6nrEBjN1LY
	kLmcSRkWrqpNm3hfVBS05Ka2Z0h4QbE77VKOGjz6xSKMRMo5MterMBEUspYeURQjG+LqOXTHaIi
	oqs/NDQD+jrieb1LW+mbG2JOAxLDsWW0thVkAP
X-Google-Smtp-Source: AGHT+IG/k3NIGd/8FVwXUX32UgEbYb5vZSEJFNoxaOeJplH4sY0amksfvxnLVl8qgMZGASNGrpS8AnfrJSj2egec+Ig=
X-Received: by 2002:a5d:5847:0:b0:38d:e3da:8b4f with SMTP id
 ffacd0b85a97d-390ebf7f818mr2114448f8f.0.1740732404732; Fri, 28 Feb 2025
 00:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <UXTosjUFv_CKOV-K4oqNGBhMEv64tds9NgXWhHEYdCHuKM2qSPFrpBnTqhFGkcbv5_KXYERykIXhn-sYnEeuUg==@protonmail.internalid>
 <20250227-export-macro-v1-0-948775fc37aa@google.com> <877c5apmdi.fsf@kernel.org>
In-Reply-To: <877c5apmdi.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Feb 2025 09:46:32 +0100
X-Gm-Features: AQ5f1JorcdutYNMgivy-Uv4SQylBN7HJTx4rHapLRH5N-Y1f0Jcuxa3LHpGUCrk
Message-ID: <CAH5fLgiNs-VKEQduL16eymSPnqA0_6aR8WDRYm68SE8FXGDHRw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Check Rust signatures at compile time
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 8:19=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> What is going on with the cover letter of this one?

It's empty.

Alice

