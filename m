Return-Path: <linux-kernel+bounces-538866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEA4A49E05
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD531895914
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A4274248;
	Fri, 28 Feb 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY/0EJHz"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4705271277;
	Fri, 28 Feb 2025 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757769; cv=none; b=UMqmn5XhnvL6xmuCcFbGNHwBll98RLJHKOuywuxedDn5uRcqVoAzZLFavebOJpWB+GQ5ACUNcuk7G8bbkW/FWyWi1G0mfFpf5RybZWRX1ilcar5isMiIS2YzLojlCIs9uqVOSZefgwzgJqlDJKEEihGQy/4EbCp+6M1HAIA1wwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757769; c=relaxed/simple;
	bh=qIaJyzNn3jbBWJgu5Zoc5IbQQmzl5S7Xop0lcri8li4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTQxJxO3YtV5NUQJLWL302SwRNKn/c0rbAdYF0uJHJ2OlB9Fa11KeYN12pArwY94NIk3cet/Tj0DtXiCY9hReS4KNbuH+RJXeEqQN21X2GsD4u+FyKMABvLey7ZUl4IMAwmxxE6dw/75pr5VLrC7ByEI26qW/q4gk7xU5/CMHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY/0EJHz; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2feae7e56c6so478516a91.1;
        Fri, 28 Feb 2025 07:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740757767; x=1741362567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIaJyzNn3jbBWJgu5Zoc5IbQQmzl5S7Xop0lcri8li4=;
        b=OY/0EJHzT2UBiw6CT24QQW3dnQjcNG1I7XQPc459h3mYbGVvTLnqOiOxAX2JAN0f90
         EHQqoLmbu9DWm3DXE7X0Yipvho29obc9JtTRgc5eH0+rCpqmN32Ya/JHeYS8EfwmUDxN
         Y7EZwg8PvHy1nxEJjMkXMHxUS7Onvrx1RvCLF41oU1cvHN+LRE6L0scDU4/rBLWa1Krq
         NcBYo+AlHkiaECDtYTKQGcrqlDhE+1VW9LIUeVkA6mXgmltSyORPzxMEubeo4jZcst0h
         Pt1oGr5LLdN2sWJOv5KRFxeWzo/8sctJHfv8Oy2yvBtvu1JGg71MpNIeDnzmhOusgJP8
         oegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757767; x=1741362567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIaJyzNn3jbBWJgu5Zoc5IbQQmzl5S7Xop0lcri8li4=;
        b=o3t/kcXkQ1Kv9uNXS89s0618s+dBzvIPcJQLN/pECZp6BUSOtIcVPo+ehc5UQyFa4x
         UiUTXLDCa57DeI1cWPH2LA83Kp7igJ7J/hy3/4zJJ3XDWwAQWeA5/NUgJlhfM9PUTIpk
         5GEh66YLBaCuJhEBq8Uwx74JyjD15XOTMOIWULNf+ajZfw/W27WdyIol+7as9dOIIzw0
         e02VpFlHEbHL39rreDij9NKpF39YTEcTxgkUaMNGVFfN73VkDgmkyAKkpXCaRHh75BU3
         G+W0FSL2bhbaZJzLNZ3nDm7BQmBiKKKblnOeoRgG6HErb3vJFkTFy63peEllmGXg1cpo
         FqoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT0c3iEH7KatBNzCTolyPzZS7bNC7FO0qFIoUlYw1xrQhnYraSiN2jLtAJyPH2mvcSjiI9OqZ6OWbg8Ig=@vger.kernel.org, AJvYcCVtRTY1LPQr2jqZ3mxMkABo5pblYTByafHx1y5zoRPqWxeTKGc3WbQRh8E2vdJ2L2jXBPkOG7ulbhEd4wwyuZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1PmagMbl5ja1HrZ1BUubc80AeT1azA+L+YKctwkldarUXwKt
	Q/UXpjwrtMg6fd3tIx991Ygd0U+bRzQRdo0D3JD+2yOb9jAZ8dsMjxVV0CYW0a5HPYr1kcbsZNp
	nopNqQ+XuGfYOkgpcqlN/BU2xsYk=
X-Gm-Gg: ASbGncuXouWYcuRA8JhbqdFWVsRfJk4TMDAtucuHH5AjpEADLWpYaWTpj04mDTBJhtg
	vF1YMOYIbjz8O1SXj1FJfJDXRfZl4mAmJSJ6Y6+g8GkiktRPOs34dugXEIe2PbOhedpOvbRCVCu
	wjkcUsCaM=
X-Google-Smtp-Source: AGHT+IEPlan+8bNz7Tcm2Cq/sao9mUee5KR4Xt6d2vqL8Zd9pLVI5867TMU38qeZ2/fGLTs3luniV9Zn28xpEj2Q0mM=
X-Received: by 2002:a17:90b:2251:b0:2fb:f9de:9497 with SMTP id
 98e67ed59e1d1-2febabf4096mr2463684a91.5.1740757767202; Fri, 28 Feb 2025
 07:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
 <20250228-export-macro-v2-3-569cc7e8926c@google.com> <CAJ-ks9ng6AqmDynFebR+2_ZEpmvxkUNWdTed2vr0kede0dxcxw@mail.gmail.com>
In-Reply-To: <CAJ-ks9ng6AqmDynFebR+2_ZEpmvxkUNWdTed2vr0kede0dxcxw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Feb 2025 16:49:14 +0100
X-Gm-Features: AQ5f1JrJGmkqnoFHNmTsztUAPIP-5rVyGELe8gsmoak2AeGqALQ9rpCX3yxJr6k
Message-ID: <CANiq72=UrPX4orjgFKo8LZj0PVsmXkLvQRxrgSwJrY_AfuTfEA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rust: add #[export] macro
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 4:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This needs an update given Miguel's comments on the cover letter. I
> wonder if the code should also justify the choice (over cbindgen).

`cbindgen` is a longer term thing and more complex, assuming we use it
in the end, so I think it is fine going with this for the time being
-- it is straightforward and a net improvement.

Later on, if needed, we can just make `export` a no-op, right?

It may also be useful to have the exports "explicitly tagged" this way.

Cheers,
Miguel

