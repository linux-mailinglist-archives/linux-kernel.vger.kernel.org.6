Return-Path: <linux-kernel+bounces-274281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF32947606
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614031F2171E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAF71494D4;
	Mon,  5 Aug 2024 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evBW52dh"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC21494D0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842793; cv=none; b=T+IJJ8ugSx4U6AXF610hz1IV6Y8GpobsgcJR1jOHhLKRjuPjuGaRgRHcTxkWfHqP10umk9VuRYrrzqX47/ZupjFQth15JYOv+h/su0FfBCHYJ8ziOEx9PDZFjfTN9Ju8sGzUZfSexTpW3d9f6uFHLiElX0AOiBA20U69ZuwMlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842793; c=relaxed/simple;
	bh=WO7Wk3TJ7iWuEM+gkEw6o+cg523KxLczIFJk+pJnpBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p08Eys5Yzv61MgYDuBFE9tZ/DprwkB8qajjfV+LIf7Hu5txukxCvRgf5eqjekdSuNAgww3Zyi3zG+JrUEci8DoIcTH/BShSiETrxKCd64gx8cqy81mfEwx/IcJaAwuh/gp84Wx9yjNE2ef2/8D5ZHXuWg3QJqJ+sae+96cIaW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=evBW52dh; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f15790b472so53463371fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722842789; x=1723447589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO7Wk3TJ7iWuEM+gkEw6o+cg523KxLczIFJk+pJnpBM=;
        b=evBW52dhhNSp0Yxh0DO5981X2N3BG+TdmgDW2pNoAklZblnQQ7KpAJEfmDglXka0vn
         8cCZ5k+MITJE0cyOSD26DLMZaQklHXPfr5BuZoTfqgN/OR0xZT38AA7/VYy4Xs1EJHCQ
         +4xMhYH+ykJ0Cs5jBsH5BZuUzbemQA90tiTukbHEP5psQIv4KQnhz4/aLZqI1H18kKqQ
         CHF6eMHXSlm6leMZf4Fs++geqdXcjPsQbVFJIXZ+xvI31l5enlWn7xOCZB5KaKl5nVyZ
         PETSOoy15N6qRj2xfKAm4vVu19Mngac70rSuKaF5F1klUPMxexJDtvAnfREJyhHgtTf8
         Ez8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842789; x=1723447589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WO7Wk3TJ7iWuEM+gkEw6o+cg523KxLczIFJk+pJnpBM=;
        b=eyQ0SysPIaesOSqlvE0MbNnLRqZaFwpqZfIXClTXqJpUNFcGldBNGkL8DHFsxCCGA7
         fl2cFkj9mK0xwUcNEmL6UR6e5DkFeZ/LICgXPCJk9xgFgXK9vkeWM6NMMgga6cxMgGRp
         Ady0gSRBhS4c6tjNkeYdTCH1N+m0zCZAmT+Tm6QvndTkwZDH7IV4Vy8Wc9ykCx+IzcrD
         xNCFVaUlPMqmn/Gm9iR9kNyA6o/m7FipTRIfpmUEE3DxnaU0181JsVmcuT7oFO4NtuPE
         KsVj7rimrC6U5yYktTLCaQ+pMS2/6zVDL7I3W7Tgww9HrE+Q+DTLy+ruIM+hyrVG9OKK
         6zdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZNvGuUhG/uFZfMLa1ER4djzly11GNKIyRhVmtZSK76CViEmOSx9wKhlQRU/8dHU8qr5F2eGw/hQ+VkrbnpPat2prz0o26EiVYRFcS
X-Gm-Message-State: AOJu0YxMQ0/w8PNBi525pb+wIm/2/uzDyCJtOsiRyI/BbqvbfHvCEQif
	VLN94KVnBEu/oEimihFG31oteHL78sgGcJ1PWh0RqlZgzOv0xS9z8sYKRYn8XgEL6eiJbzO1I0g
	/8OO0AcJkqA8DAc2pnqZ2GNW6kzwFTHXur8sayg==
X-Google-Smtp-Source: AGHT+IGf8NZlO/zg/jvFJewdvekiDbzVLImFMNrb8IC/njy2EYJ8sB8ApjMi473HW3YkMlMi/1SSiSzZnaLI5kFHYws=
X-Received: by 2002:a05:6512:220d:b0:52e:8141:1b2b with SMTP id
 2adb3069b0e04-530bb6c7fc0mr6727652e87.57.1722842788776; Mon, 05 Aug 2024
 00:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709162009.5166-1-rayyan.ansari@linaro.org>
In-Reply-To: <20240709162009.5166-1-rayyan.ansari@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 09:26:18 +0200
Message-ID: <CACRpkdbPPoFbytdUP1_x4Hfa7Ps23m=gHHAOKTjY-obDDhQ5yw@mail.gmail.com>
Subject: Re: [PATCH 0/4] dt-bindings: pinctrl: convert remaining qcom bindings
 to yaml
To: Rayyan Ansari <rayyan.ansari@linaro.org>
Cc: devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:20=E2=80=AFPM Rayyan Ansari <rayyan.ansari@linaro.=
org> wrote:

> Hi,
> The following patches convert all remaining old text bindings for
> Qualcomm pinctrl to yaml, so device trees can be validated against the
> schema.

Patches applied!

Yours,
Linus Walleij

