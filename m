Return-Path: <linux-kernel+bounces-190656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE258D00FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67841F242BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E701E89C;
	Mon, 27 May 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOGNAHo4"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA471DFC7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815135; cv=none; b=jIYEWqPkKJwNuCeZ08uc7ltTph+VC6oFY3l2W1DnaZ9PtNVo/TlQFVQpQJ9uss3AjLI8M3Z0M0VgBfIQW03pGFTuDMOz1+UX+nXmtzoAXcbaUSpyCxyQ/IBLzxp7YUBXTTC4UvVt+qek6vEPpuqGEnkO0WYbDoIY0ofQAc4Qa5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815135; c=relaxed/simple;
	bh=FNQRqXslcuTlj0D1XEAUqh+ZTJnUTO993DPpiAkDMsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1eYIFM5EwndI+0aFqcuBoOcxPQhNAS9I85vONvNPyr12c8MNLMFMDxLtIzaidVmK/V3QpSxZwi6PcD4EjFPO1MANjAMD4/y3u5SCzYl0ImKyIe1xKFDGeK0jtxEwvlXCGjvSm0ftIMXUtaJtZ0d0Po7U9ctcHIc/xqWSEbXpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NOGNAHo4; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-df7c1a7d745so15503276.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716815133; x=1717419933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNQRqXslcuTlj0D1XEAUqh+ZTJnUTO993DPpiAkDMsU=;
        b=NOGNAHo4yjuqGSeVpP/xFujSpwU5UUA2wP7MX2Yw+E4/IwgT5nzFJAFanbyM8VWO6K
         y2UI9+24cwNN4D/vU4mDCw7C3dDFsIjHkcQejJqD6HX5Z4tXynQ58Js19b8YaBCtKsO0
         3R3aFZqB6DglWAbuDXyS69wA2KdBZs88hhD6F7NULa48Z2S03kEXvd3iggSpJRJ6T62K
         HoFPt0JHDvBCLreXNGTRhtR85kXtdLgVbgIt+/HfoVNKysQnInmYUCf90N1a1X96PjK+
         3oS6SUZ8JBAwDjjoYUSrmeQpw2KYm/BnJULBzSe49c2i6BFAStTvT0AneEf5Q2rARB98
         2WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815133; x=1717419933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNQRqXslcuTlj0D1XEAUqh+ZTJnUTO993DPpiAkDMsU=;
        b=t4sLmqJIQT/SiJOjsT7trZBhi5HeCYQUr31SB8nZHE1RvHX+4iDMOOxH7rEEXESSKq
         vpBK6OtMdJM9fsfVGKFxFv+L64zxogK/mErA5KAiFfu3UWNc9RS9iDsx7POp7Z4y6izV
         x0o+IJRzb79f62YqPrpNi0lnXLz6wVnI5J5i3ji1IMTse0pyvQuZDrJD3etH7RiTQFBL
         xRgrs4In8pOk+eiYeGKnM3+3PBDnOqhxrmTi3R9ylIO2fHd7aVbrFCfD5oVk6e1p/OR+
         i1GusjvxRk7DxkB1HDbMJ5O+rLGpYl5x97V2vZ8TK9lfqmcjvBephUQo7ECr9PI/ErPa
         Zlog==
X-Gm-Message-State: AOJu0YyNExK9sEF3A8tjilWEc4BT0lKEj5NYEcesnJMMozeMuxi/TkHK
	VF743mXwAKY393QlzW/9nvl56cL7bh+Duf3ZZoSfZgJ2HauLNdeHQLacIpELVh1Rf6dRQW7EOVh
	CdlH07gnG+dKB9QnXdFSe7jKVz4ZwpSMjgCjFpw==
X-Google-Smtp-Source: AGHT+IFR+wZHuv3IARfvmCiHiGCaqdApTHaytipHLjbenuoYylse0RP1LrgwQ1ChHXE1Xxy7tpsM7+lWB2cFbaxIKVA=
X-Received: by 2002:a25:aa53:0:b0:df4:e089:d182 with SMTP id
 3f1490d57ef6-df770c75582mr7483014276.19.1716815133380; Mon, 27 May 2024
 06:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com> <20240508104848.846580-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508104848.846580-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:05:22 +0200
Message-ID: <CACRpkdaKr1yronA=nnx14d5jsHzhRKJX=c-wqeknbA-bbUP_DQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mfd: lm3533: Move to new GPIO descriptor-based APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 12:48=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Legacy GPIO APIs are subject to remove. Convert the driver to new APIs.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Apparently only out-of-tree code uses this driver, since no board files
need to be changed. They need to adapt. Perhaps the driver should even
be deleted, but that is for another day.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

