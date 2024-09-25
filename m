Return-Path: <linux-kernel+bounces-339487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA70D9865C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951951F23AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCD584A2C;
	Wed, 25 Sep 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IdZe2uNK"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15822233B;
	Wed, 25 Sep 2024 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286000; cv=none; b=ikD/K+FpvP4jayQKrRHxz338OfbB+LUmhDaQrbcyVFr1azggbFAe3iQZO0f6oc/LE6sCshiAxli8wMyv66S6y61X6evj89uJDPE1tWNIKOjAxfNyKu0qI8bdH13w6e5vVNfZkgHWd8IV0PBAtZZItOOkLPmVtiBYjPMlCBXfDCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286000; c=relaxed/simple;
	bh=/R3LA99Gi2CXJVExlDwm1IdzJtL3fb0pPwM874TZYvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwjCf7e+8JWNInumeNcQsqUQ8gauIlAVzPXzf8wpJUVmcGE9qNTX/r3zj4Rz+x3oc50UppKmowDxRT0I0u+GH4bMZ60ussyOilJzdFdyF2fMTwB0F0PS8wzV51NsLEwfg6D4+jc0G4UgJUV6i6bMzq1LASo72TBKZUTr65oGibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IdZe2uNK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-208cf673b8dso452235ad.3;
        Wed, 25 Sep 2024 10:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727285997; x=1727890797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht2EcEikcbIMJuaEwdOngsMiZXk7fRHIUcBV9+yWZRY=;
        b=IdZe2uNKpfNbvYFnxBkPVT2reKiwWs0Tp3x4dQBFPiLzdNDMO1NDIJljkRhpuJUvf/
         cA5W4HUk+/0Kr/9/DHG83IE2o1jCFTbjGMTcQLkFILmt92FHWSSGEOdcX8PKra5mLce3
         NjCLup++B22pGEsQLUKfiY4Xkvf1i3v9r+cCcMZ2gz5xC1AGB+u8U2RNb0eXUgFtvF5d
         JrqcKHgUP3AWvUZO9VmnRq/qwOPqTBhJXruP59okHPsRv3VxBNVzzTQldWLOi3KpDItk
         OCi89hl12NpiFg6keCxGtWMVre+iJZZYpTe8jVr6ssRM+aEMWBONiHbX0EAfHYGWO1iz
         +S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285997; x=1727890797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ht2EcEikcbIMJuaEwdOngsMiZXk7fRHIUcBV9+yWZRY=;
        b=qezOq7qHYu/mp8JqsR1McDIL3WBP3K5oeErqLx1vnOGy38/exjjewVLCpiD80nM9D+
         CPgaEdAO3kK8KDdjOPdXuyGzfv6+dqgcYMyyQa4FUR0sXIA7ArNkJsAQwq3fCCBRfDUQ
         wnF37F9O6ZHtK+WTgxQy4VgHTjj+ItNAfR/40KPSnOhZExz72mQ2MtMy7MfQGZ07RP40
         IxqHKjeRa4MAFUON3/motwx2Mijlxyaejo8A3h/tYkXRzdnkKuykS2RPaBXXxWFdfRVF
         ORarJCQyrYQEMzG0RXHUeQG1Cxx3OzYzvHxjzzs49V1f42HIUEqoDCsoqv6WyzTbY7Xk
         ECeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB3EdzexUzLrUr7nMCKYRALjk4jUyrC2bU4qMo54aQNL5trOevu7vJx7GE/Q8+07xn8nXYctUeEmjD+43O@vger.kernel.org, AJvYcCWWzIKueafIJZKUtGUoTIxzI70PI/gID0rlTlOhc+bWiIecHpxnENdg8jzU6YSR8XlorjhpTnEZyyTj@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhWTOgMMFKieEwXgmTivzLTArwZvBjI2XmFga/e5wyZ4ElobB
	hzhaskTtXE9Thyud9LUy8HzHoCgtHMFQkCnr1KFXdtgiISm7WMmKDcs3kIbJNc3hN8HfTNOi6G1
	ITVSFPXkBkhJ4cS0DImhvOdhdtuk=
X-Google-Smtp-Source: AGHT+IEh/Hcmf4a9J5+Nv/qry1eE5XkIyECg8/8feJZSd1MXroHW0wCb4gcU5w5yYvWtw92GkfOB27kZBc3v20BuGcQ=
X-Received: by 2002:a17:903:3390:b0:206:d6ac:85e1 with SMTP id
 d9443c01a7336-20afc401bb4mr35681795ad.2.1727285997005; Wed, 25 Sep 2024
 10:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
 <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-9-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-9-0b20ed4f0571@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 25 Sep 2024 19:39:46 +0200
Message-ID: <CAFBinCCDwGLGtd1i+Umtt154s6Vm0tRDJ02TV4MpawwCGnoXrg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] ARM: dts: amlogic: meson8-minix-neo-x8: fix
 invalid pnictrl-names
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 10:08=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> The property pnictrl-names is wrong, rename it to pinctrl-names and fix:
> ethernet@c9410000: Unevaluated properties are not allowed ('clock-names',=
 'clocks', 'interrupt-names', 'interrupts', 'pnictrl-names', 'power-domains=
' were unexpected)
>         from schema $id: http://devicetree.org/schemas/net/amlogic,meson-=
dwmac.yaml#
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

