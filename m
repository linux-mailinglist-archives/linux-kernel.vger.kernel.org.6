Return-Path: <linux-kernel+bounces-396015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3432D9BC6B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFC2283C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2331CF7A2;
	Tue,  5 Nov 2024 07:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j9I4oblK"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4018A6BA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790935; cv=none; b=ELBCcnS7FfJvIjaZUZIQpOV6OAm1a/bec8fjaUP05xGzvFskzvmmeRbe3WeQmQ5LSnqbxre8rPelJeNsmxOUQ9Smc9nNsahHRph7RUDQGRu0aRtyRaO8vERYzjBfKIrNg273LLKhoK5Qny7VqEL9HbqbajJtIIOtvvz78MRO07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790935; c=relaxed/simple;
	bh=LKrupjBtkttfD9TudNheeJJdwN3xqZFDec7ws4TNMSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoUi3z7P1YaLs3GSFSbPvu9vo4I/Yc28pCfsF0flDYKTkXbZfrOtCa2+lJurdXo0NyTb3qU69AA6PGDMkMiOmFQ5v4o7Bn3yOzoy51LNHNg3BTaESjKL1qs4ISQpC1uwaswkudA1tFqRsxM7fTqAG7peISoBnPY/rCyMTpcPtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j9I4oblK; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d3d2d0775so1758004e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 23:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730790932; x=1731395732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKrupjBtkttfD9TudNheeJJdwN3xqZFDec7ws4TNMSE=;
        b=j9I4oblKim4hPplgvIVzMc4NZXPaV4bN3ZDsi/8XIs/rMl3ampSqJGA4UyojjEREb6
         C2MBRMmz8yIZSQ3Ni21VZqGL/v6dhJMAjOQIHWITU2ti2ppNoR20SHNh2rQ+oiDK1xGr
         B7BURRyKt1VpVtsO96h8GTJ37q/f2efYYPtmw1sH4G9t6nNJ85cPY+czinJ5zRHsLxH6
         w3aN3V/sDlb4nr8JWhDF5TbLNQTi+xznWS29eX83OpH8VIFyQMUAW8IAuKDP+fFwQ5Hf
         mz0T/RqENR/0UU+BGW3HPT7/cYpWIxEsnG8NFE6mQHpXgCjqq1+4Vf/vb7vi3d+6RY3c
         HTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730790932; x=1731395732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKrupjBtkttfD9TudNheeJJdwN3xqZFDec7ws4TNMSE=;
        b=EBm3N8Z/V6pLapFwk05+Lgk5Th3vBeB3o5iDopPecYDFJLGUevUf4fRcu17W3sIenI
         3jjTUMppiJiyGcyebqM7z3dCPrm7ri0hasVz+aXiJ0Ho08mtN9cU3YaWh+3wH+Wt7NeU
         W8YnlrOO8bB1hQZsZKeN0Z7IfnCPqBe1djVn8tQ7QTOtPbxMUwuWoxfVOfPlNuBUGi8U
         OU4bDIq8K43F/lagzb9wOhS/LThBBBv7hNRRoKkVZP1eLs33YBONAt2k08+9jbi4e/pc
         MNjCKcP8tsWFJ1DGPDY5R4i8f5D7aYo0Hsy6mHV6Lxr3BBonJBhEXm97qmDKqcW+I7lm
         Chpw==
X-Forwarded-Encrypted: i=1; AJvYcCU29zEpW2yJ/luJjOapo4P3C95FNZhVyAt99OQyiJM5E78mzD+kP1BlAtLlAR/6qALhESx1nJuQNDD/OT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+Nzn75knZ67KVs/qEF3MsxZ4E4hzyZJqaHI42+HyADZkJwUQ
	Ey1FFEG0GHCXpROIctTKV7csC+cXUu6/SnCGLkvtF13CJsk3cxGQbV7OcCj4tMfX+HPrbpQVOLg
	5uwIB1nmD4fP9zwF4YNFv/0aOaAgvVMOEq6QIow==
X-Google-Smtp-Source: AGHT+IFpURG4bQTnz3LG03WKBpggY5HMxzVDL0detX8WC3WRMfaoHGYLGqK7rmSsRweWcYr4Rc8qK4LRpNvTGQLpsQ8=
X-Received: by 2002:a05:6102:3707:b0:4a4:79cf:be83 with SMTP id
 ada2fe7eead31-4a9542b4691mr18047664137.10.1730790931844; Mon, 04 Nov 2024
 23:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031063707.795842-1-aardelean@baylibre.com>
 <20241031185906.064d733825c176addd48a733@linux-foundation.org>
 <CA+GgBR_tCVVo75+eOxtxEtFdCMkAWFiHjm8eAfPYt+sLBGjBFw@mail.gmail.com> <20241101130459.eb29f2ded5da3c4c850cc577@linux-foundation.org>
In-Reply-To: <20241101130459.eb29f2ded5da3c4c850cc577@linux-foundation.org>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 5 Nov 2024 09:15:20 +0200
Message-ID: <CA+GgBR8yiRAVrQx0ef2e3zpiLuky7QTx=5XvXm2kxSn7mJijkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] util_macros.h: fix/rework find_closest() macros
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, 
	bartosz.golaszewski@linaro.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 10:05=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 1 Nov 2024 11:07:04 +0200 Alexandru Ardelean <aardelean@baylibre.=
com> wrote:
>
> > I can also do a V2.
>
> That would be best, thanks.

Still working on the V2.
I ended up down a rabbit hole of signed-vs-unsigned arrays and X
(value to search for).
Will try to resolve this as elegantly as possible also with a kunit test.

