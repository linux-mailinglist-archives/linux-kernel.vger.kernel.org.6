Return-Path: <linux-kernel+bounces-269972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E33943976
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD827B2245B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB016D9D9;
	Wed, 31 Jul 2024 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iyHWzUXp"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A116CD0E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722469497; cv=none; b=gbU8sR4lmlM9mlCmvkWeuQb+sj3X9Y5QejchOtSN0ox/eY9uiCTixRxmJQdx+SjjBu8rIp8bb3eJS1qoc+Mzs6C0SmLx4aZqGYWGroiPES3SAqTz1uS2QaRmJDYsxgWt/Vnxs4CGGsViBSphRKyDGvRlQ3viwpcH4Wo4zqRzO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722469497; c=relaxed/simple;
	bh=paENHMW/2+UYl3tt357TcNttcJM7CEFJjVvZ8PpjUYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAtBLVmjPYPii9Ea4xkMzOVsERX1jSZpO7En774FkDvuSinY2FhdOnE2cJIc3SGnHF3T0G4CBJi5BkI2bagCawZhTSAooba3rzG/h0c5RKU0hDj9tdgfMZ/q08abRgNvco5J5rN4W7RXBTnAcwBpkWyMEDUl8ulfjMVBLbKL4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iyHWzUXp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d1d6369acso1116454b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722469494; x=1723074294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGN3NcBjvEDPuj/1+sYN2kLmAgP2z3leFVjhSD6EVrs=;
        b=iyHWzUXpFrq/CCVTeIBgK3IXUfPpzeqNt87d69+3eMVvMgmpQcKQxkO+Ow/hDQNkHG
         kgQggOaEwCxMy1r7oci+9/9q0iLOgnmylTZNtQjtvA3jJb5FLkyNS5zL3xUOfOjN0sTC
         5u1knx66VTS9Gc/liA208RWflIirfAlAzpNkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722469494; x=1723074294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGN3NcBjvEDPuj/1+sYN2kLmAgP2z3leFVjhSD6EVrs=;
        b=BI8lQRfrvkCesDbyKJt1MXH8psy4QPnhrfdFxRuJfi65GlxRwHggqCTO+vNZhlR0Dr
         yVlZdcuzDAm41lfd8IgghoF+Uifo7t4451HM8OWuLMF2bZ/99YYfSqD8Q7UbZkDusxBA
         H16SA0VKLHbtB85tDqjdibF5YVpRqHrSDiPABIaGlr/C0h7v6mL7aso/vTHuJXp35ioX
         z+R6a8SKypxahrEbK7ANEwGV3wse5dmJC8PE7i8IkgHjBWdy3Xvapj9FBOfN6+Ek3nnP
         fK8kOh2HORcPO44Bu0HYsWmqs4j9TzF9vvE+Lic2xUNuMyQ/lV1TD2tA6oxyphNhzXmv
         ZXmA==
X-Forwarded-Encrypted: i=1; AJvYcCVOvGniYdklL45Ns5qW3UOdmrWGoepTodjeYWNeRjqPY9ZzC11uvdruNI6LLpAGso2TsUaKVaNXTtzKoM/HskVpsc3Jf+5KAILk4ECy
X-Gm-Message-State: AOJu0YzVxGFC1rzyDu7LMVp9N59KU7LtpiFXsVHtdZBd0FQ3+B+faNEu
	IzsB5QZqXPjPXUHdxLloR2ApJA9Z7W30uoQdOHNtxQBvhkpxCuMbeM1j61EMX8GV35NGztPqQvk
	=
X-Google-Smtp-Source: AGHT+IGEEELi30YhNVc4A/7aaUz6mypp1ru/sg9GN9c+oXpsS2ej/jbC3Q1CuUrDf2Ii9Qqu9XX0PQ==
X-Received: by 2002:a05:6a20:2583:b0:1bd:1d5f:35be with SMTP id adf61e73a8af0-1c68e457c04mr1128667637.11.1722469494480;
        Wed, 31 Jul 2024 16:44:54 -0700 (PDT)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com. [209.85.214.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead7115a1sm10473071b3a.46.2024.07.31.16.44.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:44:54 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc4aff530dso339805ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:44:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXM4WwaQ+eJpAiyNvur2MuJk96GtWjruZc23sc227Eoq3ZmhQYmN+etYjsPQEhk5AmoECulQqnl/HFgIwtud7QP8+JRLl2fH5GWUhFQ
X-Received: by 2002:ac8:59d5:0:b0:44b:74aa:1838 with SMTP id
 d75a77b69052e-45181da7fe4mr1901cf.5.1722469178217; Wed, 31 Jul 2024 16:39:38
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729205726.7923-1-robdclark@gmail.com>
In-Reply-To: <20240729205726.7923-1-robdclark@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 31 Jul 2024 16:39:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wo2nVzn6qvwSAFAnrFX4wtv6_ZCVZaL1K_DBBFg9DJ=w@mail.gmail.com>
Message-ID: <CAD=FV=Wo2nVzn6qvwSAFAnrFX4wtv6_ZCVZaL1K_DBBFg9DJ=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: samsung,atna45dc02:
 Document ATNA45DC02
To: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Clark <robdclark@chromium.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 29, 2024 at 1:57=E2=80=AFPM Rob Clark <robdclark@gmail.com> wro=
te:
>
> From: Rob Clark <robdclark@chromium.org>
>
> The Samsung ATNA45DC02 panel is an AMOLED eDP panel, similar to the
> existing ATNA45AF01 and ATNA33XC20 panel but with a higher resolution.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/display/panel/samsung,atna33xc20.yaml       | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll plan to land this in drm-misc-fixes next week unless someone
objects. "fixes" instead of "next" for the same reasons discussed
previously [1] that the dts patch should probably be considered a fix
and there's a chance that the dts patch could land in an earlier
version of mainline than the bindings unless we consider the bindings
a fix.

[1] https://patchwork.freedesktop.org/patch/msgid/20240715-x1e80100-crd-bac=
klight-v2-1-31b7f2f658a3@linaro.org

