Return-Path: <linux-kernel+bounces-277981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF43894A906
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB021F2794F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD61E4EE6;
	Wed,  7 Aug 2024 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUS/lOY2"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A671E4AF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038666; cv=none; b=N4F/jx31nvFD2tLqHni9keysP0IXS869hjEN82f/Vvl85us19RRRF54gn9fwDPcx61Y5V0HfWts8qAl7sj/SdblC/myxoM88+LtpODlw66LLuqa42V0z7BFP80yg7ffMa8d7krpp7ydodacsAbmEJOYapTewXpqYu2yc+u+18nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038666; c=relaxed/simple;
	bh=dyIJ8vy5nu/QzjrtGXkXdpuUmf4fUKMdYQYha/H4XH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/59/+4yQxLt+DucJ5y2uI7MIPSTJLH3MGIUcoWolJoy1L1+naREmk+VWRknPXF/oH1cZtmZ9eViK8PnMSYZZ5GktbeorfKvBzzBwZBvMAWf9jQTEVNRtUTKkcrmx3qXcKE/gSTc6UZh2B2VG1/CTb0GVASe0/1h7eq6zAi/pps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WUS/lOY2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281c164408so12336695e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723038662; x=1723643462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyIJ8vy5nu/QzjrtGXkXdpuUmf4fUKMdYQYha/H4XH8=;
        b=WUS/lOY2MQ08TLt0L25jdshFv33t38SR/qzH/U2yAHH/Z3Kv5jZGA29+67aeOj4d1b
         4s4l7wddT3QFy8JeFHYSZ6rtKXvTbUwjVv4pXyu4BYJyggsgWtn6wgQSEYgeqp9/zo4o
         MxscnKy7bY/6l7c2hySw/6s7TKXedP5o4O591I/z1Xn5qhESGoKK7OXx0FBoq1j6UlNM
         9rRVQa+utV5czpACUwGuXmYK+bpiDiN1Mcy97bW3niBD7Rre6jEW71DGArLbkE7vk+C/
         ZQ+hJHVr1UnjHeKacKl3F4DjTEFw8OToJmwgFDJpGHMOGl75s20XgIZNvjD4bMgs6RV7
         EZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038662; x=1723643462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyIJ8vy5nu/QzjrtGXkXdpuUmf4fUKMdYQYha/H4XH8=;
        b=l7KATtXEseTXCPah2xSZx/wgys6BIUKStgwd+i4+ME6iCj2ljPMUGonIuF4ji6s8/w
         Qj7ZNPmsRlaDH3fTie4Q51EzBE1TCkWBWvA6ZKuihz/3vBdyhvSL49zghMDe94UBDCMU
         twMXwxMWIekODfQBk3XHkEYMxazQx+jroFix8Dxn0zPPIjtUd9LnHKDmum/EIgDx1n3q
         di8sYbTWxQHWzTWaKJM4/fTwidpTtB9tib8O5eQk7r4fWmJqlUOhldMjsqSnw2rC7Xjq
         cn6YpjQ3q5eu+wxdx5QH2MEtw996TU76nHzyzmXgWYPsEFdw43XFuHg+STFkzM9rK/tb
         0GiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpdPnydEosNqNZLP/2ZrHX1wEP8bHOO8dtfWjQE6rkvUyb3YgIkMiCr3lcPRHed5D2QhbqolCgGMqcNU25tAvOrgj8xn6dnOeARayQ
X-Gm-Message-State: AOJu0YwZS57b4QPDeQ2YlQsVPqDuYaIJ29oefDMCs0Wq69VmE2VFCU5w
	7aKRHWEOlGNhSEKT2ZLFIyUBfULL6H0fKhif7Wr3K9YwtdF1GTrfNP5k6zBEOBF3QiPdFMaVLWz
	vt7aNGldkmCc71B9vkRWjyREktc9Nkb9/QPnB
X-Google-Smtp-Source: AGHT+IEd7QHhGVOK7U53YpVkHfrlDIEmw3VTlnK1Ey3F6vYtEqQOJE5l4niRfuoUCTHsWMfO+JRkdS8F5zkv6WrC/nw=
X-Received: by 2002:a5d:4f11:0:b0:368:12ef:92d0 with SMTP id
 ffacd0b85a97d-36bbc1d2d8emr12968493f8f.51.1723038661904; Wed, 07 Aug 2024
 06:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-28-dakr@kernel.org>
In-Reply-To: <20240805152004.5039-28-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 15:50:50 +0200
Message-ID: <CAH5fLggziHs7Z5iVy2R-swGTXKk5xYe3jzf8bbhGkBvuVob=tQ@mail.gmail.com>
Subject: Re: [PATCH v4 27/28] rust: alloc: update module comment of alloc.rs
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:22=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Before we remove Rust's alloc crate, rewrite the module comment in
> alloc.rs to avoid a rustdoc warning.
>
> Besides that, the module comment in alloc.rs isn't correct anymore,
> we're no longer extending Rust's alloc crate.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

