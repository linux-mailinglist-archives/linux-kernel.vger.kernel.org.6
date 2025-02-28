Return-Path: <linux-kernel+bounces-538043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00255A493E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1603B8878
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2576254842;
	Fri, 28 Feb 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1bJD5HCj"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE0F1FE451
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732453; cv=none; b=nYjH1ugkPsdXJX2JNUKmZoua116ntrJtoyNtvFw4F8Y41NBftahWiEReNxdKKad/V+YAq2a2waI7y1kvccR5JHuHZ2216fZxT0CCum55okeGwpDItcLidd7WNS3GN73HideFXECr2tRjMbEBQKfsynXQSr0MYQIZRPLRTXvS95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732453; c=relaxed/simple;
	bh=1OVn0KFkB01R+Uuw/kKOKy7v+s712lF+9kQIDXUwMBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfEYUV+IkWSiRtL28LWJPMssIsa1J/DW3BpjeHQpALi2Fh9VelgrzznuRmIlxjmc3wtr91GCn3Fy3pzBH1medpuMPBU+9THhfQvV1+qoX/tULpbRJIvNsmGZnKJRJ8bs5EShQEcWzl8+yIilWIyiBSOHgb0TGcxHBgu6CP2OkIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1bJD5HCj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso12258555e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740732450; x=1741337250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl2IwG7HZDSCHcpQxlhObcRhTNm+twA6A6MmUqt9Yl0=;
        b=1bJD5HCjyL/JZ3w6fGtkWh6BkrXurLDhcl5bCVn3cu2Fhdopxpr/uOStCGn7B79PCo
         B80OR+ohbkKXhdgRTuAS2T9EwDH0KwGt6GyAuWrdxdYBp+XfciLyP9fc7+ZfYYy5ur93
         E/04In0Nl30hy5I8zoBXOdjs7QrWSY6k1nTk0K2nPQ1A/VzDB8W6n6Re7eN1o2sSohpV
         S5Fx+7AINkhRO01r5Cdw8/pU7onB25Eefrjje+k6d8DbcXqg6ruW8NQZYtUvElhgUI+h
         kcY96n+Ws4YwzDakwqhLGjV/TIz2UDyXIDeSOlXVH6mpn4SXMcdmqUYiClyzI/0HaKEJ
         VQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732450; x=1741337250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kl2IwG7HZDSCHcpQxlhObcRhTNm+twA6A6MmUqt9Yl0=;
        b=Q1hHrzIf8as3Eeo9YtMYCwgxfgMAhkwuX3Zt7/hvDZBADI9hhW7GtCgcmh7wn1eWtI
         gQdXq5vlBeu5Fiu+VfW/0RSJAOjsg68I1+7zFR8SCkAIIrnQFmdUumwamotCc6hIgQ/a
         aEO+RreW/iOQBqA3zfCiu53WQCoehIeFXWK4uIKuk4ldQs8ZRxM5Jy3jpUZLsb2EcVe7
         dLRIGMvo6RzZPSEmgliuQGfWWl7SbicacY75eLLH3M13axWRtJdhJNCNe9aEYhf/Bijx
         9HoA0W7eslummDP1a9NWGEvJLZiMNEUnCmAQq6XYqfutOQHgmo283O92SVoqDhMSrrEO
         T/IA==
X-Forwarded-Encrypted: i=1; AJvYcCU8T3bs5i4EbLcA8v9JS2J64TrezbbKx+GhxeyPvDOeijm2npo4jUpZUJdmkBjZo1VnuiFHpoiTUqyv76g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoPxCHwXyTRJs+ZzzfRxIYiqbkNJOVDqnjmEyyc1DAPtmjsbjI
	NLV0RAy9gFCRVswlap0kjq8gV54g5JLrNQrT7GvnUhMSnD5wouSN3R6svvPoOTw0KIaIJAUd4tz
	iSTmx0XORzp82BNMTzcX4wG1+O/GurrW7VzjY
X-Gm-Gg: ASbGncs2Luj5z4f2ajUlrMJjE8r0TFKO4gaZqrm1TMkwbz6Fr8Mt8bWwjkx++F4AOEj
	N60t1D1LqhfWxaCj69fBNQzRAZN/Bdy7pDIK8XAkR+VcSzukwISdlYugVMEIvsejOhfnhYtiRQQ
	DWdD01qUJ0h+BIXD8psVFzS+Kg4tzUCVHRe+9d
X-Google-Smtp-Source: AGHT+IGwcgUW5OnvmV3QPHuKOrrO6Iuoq2TPQDupN4J9DP9Kay+XkSy1sz9g+96PyICWN0k33yRcOLiRB6A5tuChr1M=
X-Received: by 2002:a05:600c:1c93:b0:439:a1ef:c238 with SMTP id
 5b1f17b1804b1-43ba6704511mr18768095e9.13.1740732449733; Fri, 28 Feb 2025
 00:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-export-macro-v1-0-948775fc37aa@google.com> <2025022714-specked-refocus-b701@gregkh>
In-Reply-To: <2025022714-specked-refocus-b701@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Feb 2025 09:47:17 +0100
X-Gm-Features: AQ5f1JpfAFri8l7nY7vFVmBZQXd_HNmIqbMhkShc48OxhVuvQ8No9II9fNH8noU
Message-ID: <CAH5fLgiFEUrKRdOPJ7HLaD5GqgOmz8wPNXqvkREksL=C1KmvMg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Check Rust signatures at compile time
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>, 
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

On Thu, Feb 27, 2025 at 8:31=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 27, 2025 at 05:01:58PM +0000, Alice Ryhl wrote:
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> It's a bit odd to sign off on a 0/X email with no patch or description
> :)
>
> Seriously, nice work!  This resolves the issues I had, and it looks like
> you found a needed fix already where things were not quite defined
> properly.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Greg, did you have any input on the choice of header file in the third patc=
h?

Alice

