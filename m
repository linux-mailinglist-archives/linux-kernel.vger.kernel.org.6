Return-Path: <linux-kernel+bounces-437433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8769E9321
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5EB28308E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D419922258B;
	Mon,  9 Dec 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="kR1gr7EF"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CF221DA3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745672; cv=none; b=Tpa3zVCula7H7AzDla8SXvQmDUnhHNLBkMl0uN7gorkyhNie81Ac2T8CmzXEfJKUkP0HCC9JNFpX6bGZ2AAVVPPrx+n1G4rV8qhwO1fLwRabJYHNVo8/OfeS0xp/twFS7LeOLjYCTUzNII3Y6wCS7rgat5w87IH2zFnEZ4T2mU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745672; c=relaxed/simple;
	bh=U6FIxo9NOFz5aJHwz/CGu0rXqmTcBFULicoq/xd9RaY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LMvLXq7aS/L/OvjICYa4s/KgPCXILTwtp+Ds8/MxMWD57DmK4nheNK7cEZO/iSpRSpt1rLJqTXu3Rbr6+eEpWdl10fLJl5TxjLxrhRByuejca1w6C59KKq9YiWPP1t5SdESxK988ftY3r2U+MjTy5j7HHWrcULfpuvZTwYw8H6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=kR1gr7EF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa642e45241so544227866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1733745668; x=1734350468; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIbPh213uMn4RKe5AQAX5FOeJn89qdDTeC1KU8kliyE=;
        b=kR1gr7EFLhCP2DJof4vpZ5Rgy/H5KHnEe7uuce65uxmg4RJeI2WAE+C0HOB5XWn/gP
         7EHQe8nq50AP4yJXGnSmZSGZWifePJdjrzxN4Ky/KGo8jLN7fmMJeWuWRHKkZsRWaORx
         clq/QtxBnAGnaLYO4Jj8FRO1Ovwbjzc9UDhSeiE4c1+8sUhQZKTczksh2/qCxtly+NSp
         8+6UqbRu31wDh+FBbmanO0g05i38ZCFPSSyQUjlZyd/0r7gvnErHfg5o5TQsXLyloXIh
         lMEQYfneEUp6FsGS8px4Y34KVs222KxFaXgnaAvwI2XgitguK3SrP6xobvxnFl7zCd4m
         YexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745668; x=1734350468;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIbPh213uMn4RKe5AQAX5FOeJn89qdDTeC1KU8kliyE=;
        b=FWShCvbkyWvXYux2E3hWuz/r5Gno3wk/CiXqRPY9chFvt+tMGxADzcYLZLtUnCiF3/
         gfGFY6AR7FKgzpMaDmmPqSD4aNwJeC8YxJsLexmoaTeRqBoDZT8fN4Ob5VRVHDHvcCim
         1/Zr8ZAnbHh1TGKzRrtWnBExDPleHnodvyp/ioKMBGTaaRm++sMzCN3mBefH18/+K6Cc
         8AC1znVdfEnG5a5jySVU4M6PH9E07QkJ5uSYHAXZqsDhF6MdIhlvAAB4C0hDBegMXINq
         SpmYAq+iPgLCE4AVBT13d4+jRdawoPlo5y+4bUbgFB4p3vUA9UyZkPkYa6UClc98xXca
         KhWw==
X-Forwarded-Encrypted: i=1; AJvYcCUEjfrUudySHFq+0CHsO0RXOWZ/+44k95OAtH7rGamKqgqyjco2unK8IrprRnC2m+Dlo+g6ZMjeelriVWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJSPOgFpyKSoesQTlsyEGnpr+HX63wQw99nuDeNs7JrppPRXB
	RgMxw0iGwAiiQRxMZac71qTFLpmCZF6JIXdPyldQY5v+WjOtuFQoTp0bCwNwR48=
X-Gm-Gg: ASbGnctrrQbdYD5plws7Hk7Q4RBw48y/aJUXvy5PLTIi0a/knpR0VgjgtBIF8QBwGcn
	ZSgW8g8RGs9NR5X2ucSwtII1pWtTg8mzQrI/ZCQZHeGg1saQzFTFJJhhbXfHOuemzfWxK6RCFWE
	+AZXcWGMJ1fw7W3HincFFa4ihMSH+AsACSjIu3ItykPKA9PNIxrg0k+w7i9S4/sV94P060oh4YG
	wZnojgbbL8Vd9umS8oIFZyPv73dFOjhpImcQoYkr/aUCbl91HrTvAv0C+vy96aVfAUK6GNM2L4Q
	il7VuVoRmHqPevMF8YdoyhmiasBgi5nkfZH6vzPDx+xOhzV4tv/mIKAmX8m2ekwmzA==
X-Google-Smtp-Source: AGHT+IHIzUpxWEtu6qwCt8niQVJmNjY0QttQwYVmWWK8DQ6e2I9mse4mlgRgChp2cySuPRm+pt0vIQ==
X-Received: by 2002:a17:906:3087:b0:aa6:9198:75ab with SMTP id a640c23a62f3a-aa69cd5193cmr7199166b.26.1733745668002;
        Mon, 09 Dec 2024 04:01:08 -0800 (PST)
Received: from [100.64.0.4] (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa69afa395csm22555066b.71.2024.12.09.04.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:01:07 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Some small preparations around CAMSS D-PHY / C-PHY
 support
Date: Mon, 09 Dec 2024 13:01:04 +0100
Message-Id: <20241209-camss-dphy-v1-0-5f1b6f25ed92@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAADcVmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwNL3eTE3OJi3ZSCjEpdi6Q0E7NUI1NDI0tDJaCGgqLUtMwKsGHRsbW
 1AK9/BBVcAAAA
X-Change-ID: 20241209-camss-dphy-8bf46e251291
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Barnabas Czeman <barnabas.czeman@mainlining.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 David Heidelberg <david@ixit.cz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

Since the hardware blocks on the SoCs generally support both D-PHY and
C-PHY standards for camera, but the camss driver currently is only
supporting D-PHY, do some preparations in order to add C-PHY support at
some point.

Make the dt bindings explicit that the hardware supports both (except
for MSM8916) but also add a check to the driver that errors out in case
a dt tries to use C-PHY since that's not supported yet.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      media: dt-bindings: media: camss: Restrict bus-type property
      media: qcom: camss: Restrict endpoint bus-type to D-PHY

 .../bindings/media/qcom,msm8916-camss.yaml         |  8 ++++++
 .../bindings/media/qcom,msm8953-camss.yaml         | 15 +++++++++++
 .../bindings/media/qcom,msm8996-camss.yaml         | 20 +++++++++++++++
 .../bindings/media/qcom,sc8280xp-camss.yaml        | 20 +++++++++++++++
 .../bindings/media/qcom,sdm660-camss.yaml          | 20 +++++++++++++++
 .../bindings/media/qcom,sdm845-camss.yaml          | 20 +++++++++++++++
 .../bindings/media/qcom,sm8250-camss.yaml          | 30 ++++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss.c          |  9 +++++++
 8 files changed, 142 insertions(+)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241209-camss-dphy-8bf46e251291

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


