Return-Path: <linux-kernel+bounces-263618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE75493D84D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1C51C232E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F4E3BBCB;
	Fri, 26 Jul 2024 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AebCUaq4"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB913BBC0;
	Fri, 26 Jul 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018318; cv=none; b=JxNVzk3SrwdpIrxlvB+lu5Dy3LVigh1DtGCRDT1HGfvgVwhC6VQ33q1h2XPfASt6cbrY6b8o21iIMe6OA0nEsIJhIr0/2N6xPiQrPaAZYStDhMzvYZrwqX7IFTM4ua0vdIWZOAEgLX2e+B9FUGStEL9HRPEWViEWdHCg6VoSm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018318; c=relaxed/simple;
	bh=ut2hyZo6SH2O756PtxowzvobdP6bZ/pBU1w2wzpkuM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ifm7bhs9PbNKvgO1zKKC+xbHq4ZtrK80QGjP4Qs4aSEUFtq5MxvlJExnEVhKvm/C5JADpGM1poqiPVh3h1SQTUnQaGWE2qZQUkh06hISJ8ncXyoFwXp0LaxxiK3ZiMslstQRU6HRNqK603C6/PzlkobTi1t36g7xIkCthgKMF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AebCUaq4; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5cbe88f70so360708eaf.0;
        Fri, 26 Jul 2024 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722018316; x=1722623116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut2hyZo6SH2O756PtxowzvobdP6bZ/pBU1w2wzpkuM8=;
        b=AebCUaq4ElV4fxR4XSIX9kCDw2QK/n1VsIqi9qObxj5yetCGf70yJb7iXgg8wp1iKF
         SzcZDI2k2s44YJ6ybsdy64pwD61ffBon2cNJNghHEXK9TLhZaEmFwaF6WZrqYnXJiaF8
         gTRuWjVVma4yaYp+D80/XHrY3N8Vg4aUqUgOd5kKxIkGaTueAmwu+AYrmj2MndWSP7Xj
         0oqUW3VSD+J+9m/poH/x19gUqPwdhhR+xc4GAdBCA6p2+WC80cm44Xo+cVTYqWYdvnuk
         DPjjY+xtHbzSbCMyRKeNUPOOLOS3o4LjeU3rjiNUUBD0f3zWnhXD4bvJXvxjAwRDx5fu
         Mgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722018316; x=1722623116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ut2hyZo6SH2O756PtxowzvobdP6bZ/pBU1w2wzpkuM8=;
        b=VFjn3kSEvx1bHu+/xqsPqzGtr6pDOYjBy3u3LlUlsERLnaibHTsrN2DdMDSDCiOkZg
         X1PojQNaadWiv8GaU6vWf4OJUNoNn2RjiuUC6gyMhjcbu+L0azjwWjnipQn6c1E0Cv5T
         GptCkRa8mo4+NcshorIIs8dK10IFXUuy5nIhV6PALH9SxauppRsZ8wdSgwkMlLj7rtHD
         7MvnuH1TOmpLiKeXWS7Mt58aUGc/3mMrGeChZiOihAA3yUk1WqGVVB+Pr2Ea9IBPR9Kg
         MMjA7T5+uDSrjBGWGHBjN7N876ZlkOGf7f6FdkG4MIeaT508byHQHtNo2wCuO2mfgiL/
         l3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/X/Ac543cnNyRfF2vPc3KSD3+4wqeGMdwWHBKPcksNhSiC8dinpVky9MRwaXgQHyGihqkpehDg5710QVhNuBPtHMPCfk0D8ajJizj0mWnIq7fFCcjjv2jQi6a1W2FS+YCnmy1iOjq
X-Gm-Message-State: AOJu0Yyc9iQnxjlv2jQkfzMcdIDp3g9UDyH71xW2ovVyhlqDgdYX1004
	XKSFYxwDYn7cfuEjazsS0XU2KZR09Li3V6WkkOYtYLSdoYAibid/UPiOfKcHe/6dFIESWhyYYiU
	+DGawZQLqQhVEYyKcLc5YSOLfFj02cxqDFn4=
X-Google-Smtp-Source: AGHT+IEPAQF2SwoGCbqRZK+18tKIE0m2hxAOPK5RGlsSx86RqrZMVsZIG7vUNUMSLtBwPgmYJwCXONEvsdsTqyFtOY0=
X-Received: by 2002:a05:6358:7245:b0:1a5:3627:feb9 with SMTP id
 e5c5f4694b2df-1ade0894084mr65225955d.19.1722018316486; Fri, 26 Jul 2024
 11:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <CAKEwX=NL1gOe9k5+JB8Q-UAoZ4ie8SBGg7XTjaqM7j4-hiHv=A@mail.gmail.com>
 <CAPpoddefXD1RAjyW2+X_ankGYNpQgY0Y0+xd1yOFgCc_egaX8A@mail.gmail.com>
 <CAKEwX=MFdjryQRDm9b-Oxquhw954HUipCCpABSLwH9mrV4D3WA@mail.gmail.com>
 <CAPpoddfNfrGjhHzQ4KURv2y_z-iyY8cTzG+7d2ooQFU5NcU80w@mail.gmail.com> <CAKEwX=PhhAiZ_P6YmdsJrtrftuHwzjbR7Hn6n-3aaYD4mVdPYQ@mail.gmail.com>
In-Reply-To: <CAKEwX=PhhAiZ_P6YmdsJrtrftuHwzjbR7Hn6n-3aaYD4mVdPYQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 26 Jul 2024 11:25:05 -0700
Message-ID: <CAKEwX=OjTJciGD8zxLFShOK7Y-=iOBWYfb4y+t5yLcXra47c9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: zswap: global shrinker fix and proactive shrink
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 11:13=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> __read_swap_cache_async(), or in shrink_lruvec()), we are doing block

/s/__read_swap_cache_async()/swapin_{cluster|vma}_readahead()

We're initiating the plugging at the swapin callsites.

