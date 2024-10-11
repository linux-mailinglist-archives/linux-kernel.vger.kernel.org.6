Return-Path: <linux-kernel+bounces-361794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A572499AD1D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D001F2219F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB5F1D0E0A;
	Fri, 11 Oct 2024 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykLRA7OY"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443319E998
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676431; cv=none; b=D+5W9Ps6Hk1hL/bozsj/Yorog8VdSTXR0t68w9YMLenfGFKJ9KcbtSjhW5FSW3YUuA6QcYFqtB6utOSSVUgQwtA9Y7Lc287VGhtc+NCOXJ+crmPhEFEDzwU4Zai7nCieQNx0swvijoo2JyKgMEddfKS5rG8nzFjdmGYtIRM2Ym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676431; c=relaxed/simple;
	bh=Q1S0l5bqrCwAJE2B4cYVKcDGAaSdEGWZdPav2c6jOXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMmMgtTeWMEgiYBpPKoQMfhC3OP1pwSzf+FY1f2z+h8kJv/Sd2HD2ZiPUeun9RlVpKvS4HMXzO2RKyMjv01Bi/o6P8uvWwh5j35VfSFcY+XfmliY8Gr5E1OmoJyxCTkB4rDuvxEm8kd3JJpoPcgJ+tPNhnUCrVKOwvgUg1aj/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ykLRA7OY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6dbb24ee34dso21494757b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728676429; x=1729281229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1S0l5bqrCwAJE2B4cYVKcDGAaSdEGWZdPav2c6jOXQ=;
        b=ykLRA7OYQ5Ec0ufU7EhhstmGYutoYTpf17zjILB3a2LtP/Ek5saC7Nfjj5TPla7/eX
         vQcz4QCc8Y5KXl7nduSzYG7jNMnZEua9vCgUIjRaKmkbYBV8lhG1W2E7gqQ7KWjIqWTu
         eJVnLUvtQCCdZZwhuvvVbfcORtxF7SfKWoar17VR7aRZJ1/rmHCy6W3tLV/X3v+0eQLa
         qBb/mge4dxkiCcoTcxKKVNOJ66C+FdGYl8ukRcijjeKye3Ynu4n4yvoXkGiTBAinWvl1
         TYN6PbJvEzBQaPseKahqdSMyE5wU+jNr/YrVH1ZxhhQWghZ23GKxdB/DuTsoyH3yBO93
         R2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676429; x=1729281229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1S0l5bqrCwAJE2B4cYVKcDGAaSdEGWZdPav2c6jOXQ=;
        b=ZWQqUCsQNvyTRlP0OuArei7c4lvMONi4s1yMvtkoXqWNT43lBk5tlK26O6cNvTDW8t
         HLupXlciaakwybypM42teDoPCNSQ2vSioWPpKhTisQXIIEPPf9iyQNm+KBFKDzHBG/Vy
         FNwhFIwWjnB5aq1IZSmqa1j5tZSTiyIGV+KHJP7IdQs73V6nEc7QmZEmBld7pklPvBid
         LJY1d9BccpYk5YRVqT1RpCl0zuQiZs1IUtqL0x3vsAjkD/US8sZj3L7Zps5OZY4NWCz3
         hXpKXiBLlrXDifmNDF1xKtT0DiiBjBtOuywxyCNggQJiIHWs7bfAAo1t9dfn28jXt8y5
         ePnw==
X-Forwarded-Encrypted: i=1; AJvYcCVl/ah2KhRnPVWv57GFqnNXSnpuf9H6iHkbApLmwRMVgptUnfVlMm7JXziX3vQ0PTbEL3oz5qhQVi7BVJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdh6LS8MuNCnPNXNuqiY0YHkwz4yfKKOHzBLL7jKFhjVGLzQ21
	vZCBASUYh2PyjuUUfXpOWM5Uigg4lF2dRgGecT59BDIqRddRfxqrRj+JL4/17KTJTW4XDUm/Mz9
	zYjBw97jrtWcmAsMnaAOGQQVRS+bLVMJ2gA5YWQ==
X-Google-Smtp-Source: AGHT+IEHFBjlZz97FIa9PukcMmi8TZq/8cMlUE9lnXcka8rn5cesotys6U1UbJ3A7nRbAy9qk3PKHL+XgC4aX3ra/EU=
X-Received: by 2002:a05:690c:4e89:b0:6dd:c8e9:6655 with SMTP id
 00721157ae682-6e347c52d0amr20589117b3.45.1728676429175; Fri, 11 Oct 2024
 12:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009151249.2086702-1-marc.ferland@sonatest.com>
In-Reply-To: <20241009151249.2086702-1-marc.ferland@sonatest.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:53:37 +0200
Message-ID: <CACRpkdbJSM+gB2rzkLYt6VmmpCUeF5QaJ1NhDJxekU6qJPuiNA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Fix two small typos
To: marc.ferland@gmail.com
Cc: Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marc Ferland <marc.ferland@sonatest.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:13=E2=80=AFPM <marc.ferland@gmail.com> wrote:

> From: Marc Ferland <marc.ferland@sonatest.com>
>
> Found those two while reading the code:
>
> EDGE_TRAGGER -> EDGE_TRIGGER
> BOTH_EADGE -> BOTH_EDGES
>
> No functional changes, compile tested only.
>
> Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>

Patch applied.

Yours,
Linus Walleij

