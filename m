Return-Path: <linux-kernel+bounces-561046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55224A60CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2412C3A03CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A441EA7E6;
	Fri, 14 Mar 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="cRlSUo3E"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1F19F42D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943836; cv=none; b=CpiNMajlVnomECZMG7sG+y9PV1U1yS1YiWKLD8iQA9UMo2oNp7UwfnNKNR0i/xLS8K+JLvoFN5k3aTDPec5Vmb7dPgYl9vs7J1BGZ8IfOv6h32RU0ScP5jyU8QKQ9YEVYAU0mZXM+p6Of3avTd3pD3qrEW3vVeLnjzFLLsAd3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943836; c=relaxed/simple;
	bh=5dhZAV9EyRZ2bVUtZeNoK2QiBwoclF/FSawk68+cTSY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s9Ta7vjsEpMQketAxqBNZBQfSsEQbUJSXtTJJJDHcuioMMRTWwk/KIv6BkA5/+hZUV+yI+cRGlUInRfdYlvdKMHIBhAwzK3+OTKqh3ntWv4UYpjK/+P6enlSdnFGQeFUr8h/oGZeUjTS2omCsK77wN6kq3LphP3mx/jM8/pWbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=cRlSUo3E; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so351648666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1741943833; x=1742548633; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1MO2zgb067YUwCn/NT4o8yXeBw8prnigLMVVoVIjxU=;
        b=cRlSUo3ExtvHvtfhqUJgS+uohe+8ubq9d39fIlVNIqE20RFGd6ncG1O+zqAyqNSdqV
         iXlHA91spkcDPUsWvzicqKI7FwZDyuoeUg0E/9WrGkeD3dPtvrRsfKGR2BHlpE2P6hoK
         nFKiO2jkGI5h+34I0sfJuPbtWyJDBIEfrE26MHVcv2ElNWy8X45BrCm4hEQxzepw1kWT
         B9oeEnht8xlBwpjCHHvnYCiryXUaScIEnsDS05bypFFqaXhZ3mGaOu/2fq3UsZfRc5PN
         8YdzOMfxD5kTIUITmecBIEOtu3DvmfSbIEUTK4ccH+3USDm/mNPguQtAweLsS3O1QxUa
         zkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741943833; x=1742548633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1MO2zgb067YUwCn/NT4o8yXeBw8prnigLMVVoVIjxU=;
        b=WjrvpHlmQfiMslznsxIZLSKjLcntgMmJgGS0KoFv5ZbYYcYegbvon+H4K0tf9MBscQ
         Vwlin8vM4A3ezAs/0ynrYdGSz313auIrAHa2xJbP60rOm/eVBUoYJU24nzZUj5Ap2dzU
         /kjHJwxogkmzHZqU9m5gzu9psF4gD+TSfh8cUNWYTUEyxPEr8H0aJVt3MfYeRm6VMN6W
         9DXS3rrnqz1KhyAARjCLOzkAXJJsJLib4Hyvql8AkdddwU6lOs35CW2HZcMUwQzLOcNL
         jteVLo4aYkBV84jk58yWLazWHId+XKjtaOu8hwQXf51sI+QBDZTl7zTnbvWNO72YAeU7
         BiGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCE/cbUDtKUZnzd8sYyYw7B9vf0138OSl65rDrW0z//5TQB96L/Xq6L5VGZgJRnc511Fu72TUxpQpyaSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrACFS+GiWlT+Bh+U3mgjtqo1OQLKEX2VvzPLlM6TcmhXiIgt6
	xucPYUsScrONWlHWDp/ycN+O+xX2DPsyMf1pMQVTIPC1TZRhzCHf3BZcVf6UUZE=
X-Gm-Gg: ASbGncuMECRASZ/ZNd2qMw+yy/sVG71ri8lEys/vYlY3Z+dbw2Ls/wo3zy56hBUDZsR
	9+RnVN++C2fxWwyGcPnnOrB64bkUggtR3jVKeTx87K7qMDIaIaFXFWw16EG0tXJNU3oB6SiEoaX
	SnypgAwtsRSqHAiCdmI8rA2woXQ3leM4d6iS9Ln4gXE2HUKmt3SkrJR07CgIUnHDjThUMZ2Ga9q
	5o5oWD8ic+Y232saLw0J+yo/46W+qH0W1bf2jUkEYK02oq7pta5gkvKVTcz6Sq4aapeAwmJ4TdO
	6dr+TH1umOOoqymYYl2Jy4tt+O69TpDWXFGcaVy20GnYTRbFfDzgK+tN3TpC4e3NDyqwPMtSQCM
	8zMkjUGL5hYIh8LZpVg==
X-Google-Smtp-Source: AGHT+IEsuY5B/NS2S21Sb19Nfa4GPRSr39x8zR8AnIVtNQ6bdJMlUrRQM/Etqzact+Gzgp81scA8Fw==
X-Received: by 2002:a17:907:2cc5:b0:ac1:e1d8:997c with SMTP id a640c23a62f3a-ac3302755d0mr184197166b.31.1741943833036;
        Fri, 14 Mar 2025 02:17:13 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeadbsm195582166b.29.2025.03.14.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:17:12 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] Fixes/improvements for SM6350 UFS
Date: Fri, 14 Mar 2025 10:17:01 +0100
Message-Id: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3002cC/x3MMQqAMAxA0atIZgPVGkGvIg5SU81glUZFkN7d4
 viG/19QjsIKffFC5FtU9pBRlQW4dQoLo8zZUJuajK0a1K21ZPDyiucqYVEk62jmzrMjhtwdkb0
 8/3MYU/oAv4GiMWMAAAA=
X-Change-ID: 20250314-sm6350-ufs-things-53c5de9fec5e
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Fix the order of the freq-table-hz property, then convert to OPP tables
and add interconnect support for UFS for the SM6350 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (3):
      arm64: dts: qcom: sm6350: Fix wrong order of freq-table-hz for UFS
      arm64: dts: qcom: sm6350: Add OPP table support to UFSHC
      arm64: dts: qcom: sm6350: Add interconnect support to UFS

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 49 ++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)
---
base-commit: eea255893718268e1ab852fb52f70c613d109b99
change-id: 20250314-sm6350-ufs-things-53c5de9fec5e

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


