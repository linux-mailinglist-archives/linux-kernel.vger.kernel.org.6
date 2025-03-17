Return-Path: <linux-kernel+bounces-564073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50BBA64D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E2D3B4DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6601D2376E9;
	Mon, 17 Mar 2025 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3AQiK0F"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A721CC7B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212151; cv=none; b=Y4iS1wBt2xmuy9bBEceo/eK2l3+I+2+UUY6bQhbb6QlDk8NbxfLoP90uv9K0NSDURmmc+P9VYZA6dBOwsl8ran5MU3FIOTLmEyg0RkH659bXloepH7//JPwQIFeykqVgo4SLyBZXzLLJlaQmilDaU0I33W3skbEaFrIfSEDXKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212151; c=relaxed/simple;
	bh=O4rxkACoIMr0aTpUuepWNgTVZ1VF0SUZH4urO/9sbQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hY6WaM+HSPpUDuYTI3GJ2GLlN0wAdAs1r0CBRu0oKrUbFniIZ1FWAGGCzY5uyOD3o0kebTEBP6VyEmjv+31sxpN3uNtX+ZQJR9WBrjb1OyhEEAiNiqCLxAE5jSJ7rMC14Ql2Y4mWP/C0ToffJnkVJM5Tpoe8ZdX/uq3UQEhLFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3AQiK0F; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438da39bb69so16558535e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742212148; x=1742816948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mbmNCDCe88iT3v2lZir9x9mqE4OgQ+puKOgqrIfOxE=;
        b=H3AQiK0F05zlNZf020z7weiIYyX9PSjWBRLm8jg0IJg6IafRoizmtBZ/Dt/1DiagPO
         Weoo0DTpmZqlQ5P1qBfN6ba9Ff05x2O7LmgE5/6M4IkhFlVtNwQaHQOr9nDRO6albc5h
         92ujrZ5OUIHPQtmgkpBABKzAHbPg8CfJeCZR4lyr/lPwIONfLEtKn39A7DqjiVTC7jvQ
         cSGy09UcFGt0HXEM6wSU3XMTzSAu9WgjOgdXR5q0ip6uwOfV4/A74jE0Utw1wBAvRvA/
         vAV8QQuYxqh21mMvP9wnIwC3D2EsKhTOBE9TWsh956Uq88FXZA6YdN/PsA+4IUi8kKT0
         FD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742212148; x=1742816948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mbmNCDCe88iT3v2lZir9x9mqE4OgQ+puKOgqrIfOxE=;
        b=LO0Vko8tTeemHSans/oo1CtcNfHrbYaV9gE2XGrdxv/32AU8WbNx0CT8wJj/tdARGT
         p6Dk9Lla+IHQIMigjtNsOEczJk4I+xTDuKAXTRJprW2PSEonVGfLU3lcVVDRcyI9VjYa
         9/QM1XOy36EowW+hiDKlRyOs1naTAKO8mZ+U5tSQwLbTlFsoI6X51CMx/lfUknphJtVU
         80wvQRSm10VXIcpubt782l/KTCHqzHGIXpicuutje84A1levmpl0yl75FUubbnA/4eOO
         TmUVMIMMAdzpqKh6B8S8xv38c4s1ZTUaQ3XIIdtA4L8mi844mONz2v3/X3Il9nCTepe1
         LJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLrAj3hhNQjccj/Afy9mMkm/700IROhS8zf3JiTYlLMjxowdOFCYqj0Oy/Qj5oMvgiwH5e4URKBJnk3Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmviMst3jAeD0lvSjxgcBi/6DNs/+rT2yQodZECB9FhQr5Kmzn
	isqFv+gLqy/O4ccYn4B6l5wMnBRuBgRrowB34yV5piqXuPGUtB03mhwTObBsh8qFogYvb9kMmxJ
	zGFqhgw+XYt9idw==
X-Google-Smtp-Source: AGHT+IEiyp9+pMsEtIMrEBRP3da21dFJjvcd2SDLZI/bjIqBrdT2NJvvFj4p6Awul2Zl+CaLrkN22+RpYMsvF+M=
X-Received: from wmbbi17.prod.google.com ([2002:a05:600c:3d91:b0:43b:c9fc:b269])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b0a:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-43d1ecc31b8mr119276965e9.19.1742212148696;
 Mon, 17 Mar 2025 04:49:08 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:49:06 +0000
In-Reply-To: <20250317-uaccess-typo-reserve-v1-1-bbfcb45121f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250317-uaccess-typo-reserve-v1-1-bbfcb45121f3@gmail.com>
Message-ID: <Z9gMMhXdzyiwxqoM@google.com>
Subject: Re: [PATCH] rust: uaccess: name the correct function
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 17, 2025 at 07:43:03AM -0400, Tamir Duberstein wrote:
> Correctly refer to `reserve` rather than `try_reserve` in a comment.  This
> comment has been incorrect since inception in commit 1b580e7b9ba2 ("rust:
> uaccess: add userspace pointers").
> 
> Fixes: 1b580e7b9ba2 ("rust: uaccess: add userspace pointers")
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Thanks.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

