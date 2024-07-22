Return-Path: <linux-kernel+bounces-258925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F3A938E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D28A281CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92F16D33F;
	Mon, 22 Jul 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceANIEf6"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726216CD3F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649459; cv=none; b=Jln4txqOkzHdkgsBzo4O/aHVTpTNiMutaZ11aKyvvazTWYMmHjRK+/30D0gdWht5wfwZQi2O0yQRBprspTEoX8q0OyOoDrWi09A9fVOQL9O+WwznygYT7xiCl+2GCBoGXAD08eEMsSaNjaWKK1ShXe+jBQGjP6kPDoYwVggwbBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649459; c=relaxed/simple;
	bh=akkb7a5EQYAQ4bCuRlJj0BqqslOgHcC3RvdHqTSqTeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WDaHVEnWfbVlQy3v8h8Ur6k6jqPk4nv74SQcnCy/3fgpUkCe/ABbpkMjb+iuQTouX0vo6/NJbIIdhuPE0awsY9+mfDgJDd+gYI66lLzs1qSiqNbzkAU3BpKYqMYWlukq4ndgXudTtGVQI4hPKGEJuS3aQ01nF70gMU1qMl50I+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ceANIEf6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2c109eabso13318311fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721649456; x=1722254256; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zVuck6OjLpMtI1gLk6mPG/3uL0xFVND3A9Sbq6fvUNI=;
        b=ceANIEf6XfDjzhP+aoLGDxV1k7Nb9EBZlq+UC+4tZ01ABQ5HtTQ7aZtL/0b/QWbgHo
         vjFgOpOQoqba6zm+qDBg8KpYbp41gmmgWNGBbSetGVhxnN6nwEkepbEGWYuL+Y5H3Yfd
         THFHdK+zJvSZJ9y3zeZ+KaihKxdnvdyXgRdXCofp5/I/1Ga4r9nvfqKF/mS5hDC8m2to
         faQ/k3YxV375M94i8JOuKYK7Dl+ms+jJ+ZS2hwzARdiJU4hd/hhokeyIPYVm2yfV9/06
         yzRbCWWv80RdrBKFPsqm7RDNuJPjIm+aDTu/OsALHsPeKZ3+rcjyD7Tf/YaXd16t/uqo
         8pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721649456; x=1722254256;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVuck6OjLpMtI1gLk6mPG/3uL0xFVND3A9Sbq6fvUNI=;
        b=Wc7qN5NaYE4QWEJ/n44YiR58n/9EC8eBTtS0JVPbWwq24MDi3Ry9refD5EvXNhrFFm
         fxlBRH/X8/n2ZXLbykabY0Fu5nrTuPTmGVRTyv+2kfw9hkOMETtLByw4vBJyNPkSwjpX
         yGRs/t20QKQLE73ODowxVZS156WppakboPW0rfuZpiBQDbUCeRlvxXhBycNxOEKwUhk4
         D3c5H/osq++en/CN2iYV4GDUQDglwVyckrVvnNJ7nRnW1D99SliW+xbZ+n7ZdfkLFl+h
         FgmiDX0f7a1gMbIFQU6GiszEcV2qrU/F1j36e4Pqox70N/IO7Hqv4dGrlMH3Vvvj8r9v
         Hk/g==
X-Forwarded-Encrypted: i=1; AJvYcCVRAcqzp39zwo4cZshvFklYq/yvzgLrwCcO0zURQOQ3JwJ8SqIfF/tZdT3HTf0pvXz09CHXW6lLzHMNJxsQ/Up/TrI71TQwv9B1fnuu
X-Gm-Message-State: AOJu0YwUf9KtuU+yW41xe7hLvXpezao8zyO51yTXnDnlnaAShUu4WQcJ
	+1fufdjDM0qiXPnbpFHvqfIXGbcOJ8BiD60u2Q4kreFV9mbEFWbKpqiU+kuMJ1s=
X-Google-Smtp-Source: AGHT+IF4x3CmnR4Skew1w9Vwy0qR6lMlBoC/IqFp0aRX8Zx01rI+j839whvupjsklJYJD7swQ7p6+g==
X-Received: by 2002:a2e:350e:0:b0:2ef:24e0:633b with SMTP id 38308e7fff4ca-2ef24e064ccmr36455861fa.19.1721649456311;
        Mon, 22 Jul 2024 04:57:36 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef0fd10bffsm12449611fa.134.2024.07.22.04.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 04:57:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/4] arm64: dts: qcom: improve Lenovo Miix 630 support
Date: Mon, 22 Jul 2024 14:57:17 +0300
Message-Id: <20240722-miix630-support-v1-0-a6483cfe8674@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1JnmYC/x3MQQ5AMBBA0avIrDWpGSFcRSyqBrNA0yJNGnfXW
 L7F/wkCe+EAfZHA8yNBziOjKguwmzlWVjJnA2qsdYuodpHYkFbhdu70lyKayFhLhroGcuU8LxL
 /4zC+7wePvRi8YQAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=842;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=akkb7a5EQYAQ4bCuRlJj0BqqslOgHcC3RvdHqTSqTeg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmnkkupsZ0QNqAxBrDYEjuolhwn6zMvZ4yU2OLc
 zmPYB4id+aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZp5JLgAKCRCLPIo+Aiko
 1ToYB/9dtdmUhWnC4aajNQEpF2NGyTgYSkjWxyGoFhe8rKc32+L1gVnnNAxZP6bDyKKwoCtHSdv
 5b2Dr0fRxYrpaJ9Jffy3mmXSbmAaXaSV5lum6A/yIWwFuuu52+ucgnMR/916cxImUwoOAx0rX4E
 GXTNlvoC/Dk0jWbn+ss2od2atNh4draRUkWMS0L85YQ0EwnCvGhaTPGlQY8pbb6o3K4Z7z6m3r2
 AChMeE6DTI2SqcT71cVEL9h7qHayaLpOjK42fFNGOveHAaOv/DUxqtj4JC85xWjvWIrqIc0pVZq
 b7tXXX0wokN+91xaU0gBccowcoH0wA+ZEeLtcn79C8A3MWDp
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable some low-hanging fruits growing on the Lenovo Miix 630 laptop,
but not being enabled for some reason.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (4):
      arm64: dts: qcom: msm8998-lenovo-miix-630: enable touchscreen
      arm64: dts: qcom: msm8998-lenovo-miix-630: enable aDSP and SLPI
      arm64: dts: qcom: msm8998-lenovo-miix-630: enable VolumeUp button
      arm64: dts: qcom: msm8998-clamshell: enable resin/VolDown

 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi    |  5 ++
 .../boot/dts/qcom/msm8998-lenovo-miix-630.dts      | 63 ++++++++++++++++++++++
 2 files changed, 68 insertions(+)
---
base-commit: 797012914d2d031430268fe512af0ccd7d8e46ef
change-id: 20240722-miix630-support-33b3acc3a396

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


