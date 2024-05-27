Return-Path: <linux-kernel+bounces-190721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B4C8D01AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9280A1C21EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D20F15FA8F;
	Mon, 27 May 2024 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKKJ1hJp"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91FA15F300
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816772; cv=none; b=OaJikVzuD1O2Vxd+plKRNHNXiLqYXsBc4rFUh6x5HfvhXN7wdt+TjBJ8O2qZ1Oxsg2xZRM8Lfzj42BGAYutCdn9zzBOKM7kTpbviw4TruW9wC5ihauoz2NynWdVEAY3a1Ss/Sur7u0/RFwAeMYUd8j6SG0vqyxarmAZJO6bhJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816772; c=relaxed/simple;
	bh=re0qxFe2nuEnVA2exGP9LuAkNJPYPSelsBcOw7WJz7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdGIcBdcvKoeda7GwUuUXuP+TOZqxtlCdEhXCqpdN3svIfjJMgkEiaaDrBU61vqNAagXl/TdauBDPB8Ajk1G9HKP/d07AsYONUd+Cd0ojjJUjyFA0FDaptbfbZduTP3QvJIFJi69lTGJ+Xt4BqUMti9AiYqJ7pZKtxHST99eFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UKKJ1hJp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a0809c805so34441727b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716816770; x=1717421570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re0qxFe2nuEnVA2exGP9LuAkNJPYPSelsBcOw7WJz7U=;
        b=UKKJ1hJpUbF14OX+9SWEvRMj5KV9+vR2K4IDLPVOCfEnulek/COiWjciORlKJVdGeZ
         Tt5uPIgxCJiOGa6saMCjOM4NlBuNWD979/eG3dceM2/ntzFjZHsfBz68SmzobLykdIOr
         2UDT5SV7TQ2Fbh5TaVDCbHHLLNNeNx58rRp6M6+nFyM3mlGSugOsRnUIImt8pWK0OQjy
         aFes90JMSP+DNN6l46x7hL8vI819LN71nCFFKdDTeiROLHCdIBAaiOfbC3J+VE35UJgE
         o9GT8hsoQ7BZex6w1x0NqiddkGe02wSI2yukkA5cXj16KP85lkkjZeEaLr3VMKuh9gKT
         OqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816770; x=1717421570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re0qxFe2nuEnVA2exGP9LuAkNJPYPSelsBcOw7WJz7U=;
        b=Vfe0jbS+f9EwvSjbqOiWV+R92vGij0XUQL2HFZN4F1boKnw3LihuXMT4OlqHcxGV8q
         wOmBU4F5ruqCgkm0ZbxAPcxTvRA+5K2GDi9DVwUt/co4EbXnmy7kg9q1g+EtnYpj7z2B
         B8WHb7vYgqVs7t5Ewuzy1qCYVv0DAuffN7tTMospzXzCywlnaeKX8nXGheOLdOXA4N/5
         q1dnmtBSjP0jKp1yffTNeoKKFcebzk3l9mtRK3l8jzPq0OC5ZdioJuvVbATJs6/FK49Y
         9TeDyIAJA/vUbhJDmJAcj3DgRbyUAsH5/fILqCjLOG0PazIRM64GEb16vyKcGsXnD4OB
         uBNA==
X-Forwarded-Encrypted: i=1; AJvYcCUctiWMNkpfGeA9ms4CNzmQEw8FJpzjdDpOerRCDNXAOdr1T2AeGbIb246IiN9n1rx1tp0z8cQ4XclK5PhMZAjyZbXDjYBClqpEENsM
X-Gm-Message-State: AOJu0YwlndkCfChlx08DYs+IRaU4i89Vh6JrKbW0GoREcAvs3mMXGWeG
	4RI3gyJp/9A22BaszorAQKIwTzzcvplonjTnlNkoaFbwAElinR58rEZ0CawGb+zB6ZLXvDwtK9E
	2KAqbyW9BAbH+f6N9TueKnYT8u0ALYi3Xm54HOA==
X-Google-Smtp-Source: AGHT+IGz+uC/fA/a54O+l/V2P4epiaXRsMHq+gj8E8PqFpxrunoU60HcVV8bog04E9h4Gp0Ydl2e4lolznVLBOsTqNM=
X-Received: by 2002:a25:b42:0:b0:df7:9380:fbe7 with SMTP id
 3f1490d57ef6-df7938100fbmr4779513276.3.1716816769156; Mon, 27 May 2024
 06:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506150830.23709-1-johan+linaro@kernel.org> <20240506150830.23709-2-johan+linaro@kernel.org>
In-Reply-To: <20240506150830.23709-2-johan+linaro@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:32:37 +0200
Message-ID: <CACRpkdZbe31=7uL1XA=Spj4pOmLYpx+Bouwdo1t446hq_wGJ9A@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: mfd: pm8008: add reset gpio
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Satya Priya <quic_c_skakit@quicinc.com>, Stephen Boyd <swboyd@chromium.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 5:10=E2=80=AFPM Johan Hovold <johan+linaro@kernel.or=
g> wrote:

> Describe the optional reset gpio (which may not be wired up).
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

