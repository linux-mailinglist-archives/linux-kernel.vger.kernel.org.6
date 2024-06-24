Return-Path: <linux-kernel+bounces-227840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B3915721
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888011C234B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D91A00FA;
	Mon, 24 Jun 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe43sEES"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994D1A00FD;
	Mon, 24 Jun 2024 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257229; cv=none; b=n+9a8Nr8467C3UR3CqgT+HuhdVCAbLGjxOPXkmz0SyzPZH6GE8uq5P1vBpuXsoMmOSC5EhVdGNcAkn7JeocwUUzy4RkBiL0Ya6gqFi0T/YO5Q8rZEVS/P6nxDSan7TQNcTocrQs8pb69hhevYLAyFkNQ+7dp9mfRf29vi9z+/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257229; c=relaxed/simple;
	bh=aQZfSwoa+l4IMNsVymSrA1l1JRzJlII9rqUvP9kMBqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYqwlvq9IDlPUTVtc1gIkSE9ZpStIJhpLr8QAksF3fG2ddvziac0dZ299MDOvW5e9SpZGhTTjTjKcomHxdXZp5Pznmzzx7cIeXc5uPwhCNwpVKbEz361xPH/EZtwU3vHdehlg5UF1rN9I8QQyQoicnlbiJf5xHL79WArl20eZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe43sEES; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f44b45d6abso36779335ad.0;
        Mon, 24 Jun 2024 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719257227; x=1719862027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6NPcKWdrsF0ORnPMJ9lUOl+tIOO+xgUu7dqqnj8kWQ=;
        b=Pe43sEESSzv5uKVVwJ39ujXq8cbaxc8X20Lig6F+9+i/KEy3Y39NytwHuUG23loNNt
         rjHfr9CmkrFR1TvNf5GwOlJf6IFeGfDJRZIp80jNZEHZHuED9Zju5fDxmwZnBXHzaBPQ
         d/MP3ZmpC1bE4mx9JqXBrdYeh2l0bLlWyFj1FYqjWbGsLWm/ab7zLhKX4wPV4EFvrpRd
         jPzqn0Fxm70CXHUvh+ofMq4eS6mGF2xgC/HRlhlOz6haTQwVry3dUv0YwuEWm4uBhopU
         lV6hwUuALy0H/qfL1dtYtjevYrzfWrgpF+QMtTZieAXkirlgWdva/UTN8IY73ShmKbiA
         G+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257227; x=1719862027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6NPcKWdrsF0ORnPMJ9lUOl+tIOO+xgUu7dqqnj8kWQ=;
        b=ToI0XoO7nAHFvjVf1M6VQKGLRoShdajUkUor40OdBNJ0Bt3dj/WmqUm/BtkETsktqM
         Pjb5ROPeShPyxMkfRYMInZddXKc2ID5nM5m7gnSTGqKYS2/dLqYgUIc4xFPwOWGhGAx0
         nuTRH4ayDV7b4SpSdZencjAsgV4y+Sjn6tU4u1PIY1RXbKRQvtFlixnHKF1aXqWdBROK
         UD4YqmgxxqlpYvhtsinYUcLBEmho1GTOk0PmYshjFlWRVgPveNhGIXXWxEm0hkS2Wuzs
         z6S1B1TuyAVlw5HpYPZi9rf6ufdTWYddDi6T1ng4bTB9s3PS/zcKgzSDhWBvdGaJnIfK
         8C8A==
X-Forwarded-Encrypted: i=1; AJvYcCXg/uhuuIDYV3o490AKKVdU/3tHy9Bw+WLojN4z0gvwsEyZ5EfS+bOXa0d8O8jYXshQWzkAZR2yhXjGSDq8Rfr5RDcDik24la4Rjq1+fMjhNJhHxK5WmB+2ZE5UEk/la8rgiUiCIsOAWF9sKHu9Dx8Ddt1ip7z2XTWOZTlCEmBpvXVK
X-Gm-Message-State: AOJu0YzcIe5g3j3GTLsh4xG9uYYi0ppLqrOQJtKy9fvPI139UEUXyU81
	Apht0WdcDcUJSi08kMgRoHA2AfF6K8rAOhc9DzqoVsL4pfpks+zGZB1OGpB6kqPLAHS1Jcc7k4q
	hEe2PPQsLG4PoLwFA5cq/8QXd5vs=
X-Google-Smtp-Source: AGHT+IGBtjhDC6P3cpTyHX222A40DKzkhUa9Vlp3o09LRMLRvr5RdM7GaIGSlUL3/mDyjjHLONQXobYxheRm3w1BZ2o=
X-Received: by 2002:a17:90b:1e43:b0:2c2:e175:4076 with SMTP id
 98e67ed59e1d1-2c85829117dmr4566018a91.32.1719257227334; Mon, 24 Jun 2024
 12:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624185312.94537-1-sj@kernel.org> <20240624185312.94537-5-sj@kernel.org>
In-Reply-To: <20240624185312.94537-5-sj@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Jun 2024 21:26:55 +0200
Message-ID: <CANiq72nBOG-oVZxMPC-XqVrYSQ95Aj-=FQFTb2y8kG2ioej=4w@mail.gmail.com>
Subject: Re: [PATCH 4/7] Docs: Move clang-format from process/ to dev-tools/
To: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Federico Vaga <federico.vaga@vaga.pv.it>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
	Avadhut Naik <avadhut.naik@amd.com>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, workflows@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 8:53=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> 'clang-format' is on 'Other material' section of 'process/index', but it
> may fit more under 'dev-tools/' directory.  Move it.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Happy either way -- thanks!

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

