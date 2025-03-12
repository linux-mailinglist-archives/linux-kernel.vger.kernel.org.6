Return-Path: <linux-kernel+bounces-557781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF3A5DDB7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2565189F7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BE1244EA1;
	Wed, 12 Mar 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFbP5NzN"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C124338F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785261; cv=none; b=qKzca+HA9xiWvyQ2O7udWNpxtULu7ZrCNkEdnn1UFXv/CaSgmkT7sjGQcCAJ/5Xtwy49xruXN57FfUhJdQM6fXtQVX9PMzFiEu8clBhxnkoPo3n3/nQEFQwjkWIwfMneNARIq+mgieXsQ6jDuD8uaZTdvQcUriPW2/xo0hZPSGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785261; c=relaxed/simple;
	bh=vBJoYS6kgea9KnuipejUiu6W/UyWi3+gXOVaAXDBGu8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r5p3Qi3bHeSj441hIkgilWAUb2QBotEPOEJmdiZyJ+NajDJI7gWVBJS0tcRbvGctToQKOTGNeXcwW9v56WvYT3L+ByBgzAvZYm1srh7q7c7GLmIVrtdZ8hWBlcarIeCArSXYbuL+CRdBHl0IVzIkN3dYvz/V+J84MdtZkKbo2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uFbP5NzN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394944f161so7336835e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741785258; x=1742390058; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGzPkd7r2+zM91oQhOH/mQvzjdgz6ag3mHHJbjsWzpk=;
        b=uFbP5NzNxDmAc+6S5//WxTBMbW+0oz/9oT1+a7tBviBZlEdhfIi3VMrQeFPwuRHiN0
         2uKzJVTUEJigbegOTYu+8cf+Oo5rLGDpkNnXHd59hAdp0Y+i1UBPy4+iio35YV57IfTk
         DeSX1+Pj8ZwJq44HaUtRskUewuLm/9if7SvHEKl5GJJ2C8EyE+iAiGYZiFvArt8XN+Oe
         32uRNj8kHDU9TwiMgE3lpJiQ/N617MvvxiwhJa155HB9GfGhQFnPbmJLkt8UCkxzX3Z9
         0/iwUdBRuZJiuISSsQvJ8kWowD7tZt2C4lPcT2Go5608UoWS1seNvkjjeZHOYtZD2s27
         bTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785258; x=1742390058;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGzPkd7r2+zM91oQhOH/mQvzjdgz6ag3mHHJbjsWzpk=;
        b=Xt7b+J8voI66DVPpA8axchnGjt286WAQJvJMaiNSn+RmuRlNWMoBlF9uOeP8+VlLk0
         Go3mLvMgOZRIwQ1ZOPRTMAln50jRQd591zQAbjor5ScLHGiemmizA1iU43X7DHluCkD5
         nCch7AQBjh8LYuyth9RvmTVuyE/MFqA34wIEPrpKxJBA8T2HEbgkIDOfekTnoGdyQSDF
         qLb2JAs7E+al658WHz7SxkvS+NC3EpL3ADaXBdP0FZr8ypb7Gb0S9BdoVsEyoXAqiLFU
         OvuPqr2Kfk4YbMFr9mshaD6j1ubduGR9deCxykcOKkL53Y/YDuWM5ZdZeQGBfjZYPXIf
         uroA==
X-Forwarded-Encrypted: i=1; AJvYcCV8duvv+7H4K9ooeZuz3fpX1fWLBZWBKTxBnKZkiq38VP1HDOehXN6ptXW8TfHNIfzgvW6k9JAgYSrGnfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5cFzQ1UcoPRiriHoF+JcQBVX3HwMq1IyfNOG+DdV0gRokuzqQ
	h+iFW+jhHPyYsbXy5Z/x9k7Bx7qQsRBtcbxc1OSc8UlnokvQwrvSD9AY+aTEjmJ2qe6OOiSmIvY
	Y
X-Gm-Gg: ASbGncsNfhPEj8X2MXvpfvGAryV54N1NtzxgKOXFYm80z/2ZrK8KIpRZ+jA/B9eE052
	UY7KTfPREcSkZ/Q2etK6lNMPNXiFzOLgWtbfrdpDmA/jO8ZlXS6m8Om5c1BUvvMSw0el8Rd7qnm
	OInfGEYt1wY4xrva6eptpN2RBdU7CSjMZCJ6pEwu4tNzr/PlWWMmhk38xl1akvapiSlt9nV9CWS
	Tu3B+OHRyssJSjQ/DlP/HbBicwjU6tCbVxsbbIDfK+DyGr7CycB9MRn5TN/+F5b+p9wK/eeK8DL
	jNXcI0tDRNCUESfebixv4VTsaQLc6NSEIndhorL/VUr/y+uKqtNkr8SiUzoV+Qe49WayNg==
X-Google-Smtp-Source: AGHT+IH+qpDNzN/QfZBrZqjgfeka3w0jEA+aQ5oaMH8e3V/VqjGWoPeo22IKDneXVdzf4OlJgAu3yw==
X-Received: by 2002:a05:600c:b91:b0:439:9c0e:36e6 with SMTP id 5b1f17b1804b1-43d01c1fa4dmr32998775e9.3.1741785257752;
        Wed, 12 Mar 2025 06:14:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8c5cb4sm20966745e9.25.2025.03.12.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:14:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 0/3] arm64: dts: qcom: sm8750: CDSP
Date: Wed, 12 Mar 2025 14:13:56 +0100
Message-Id: <20250312-b4-sm8750-cdsp-v4-0-4925d607cea6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWI0WcC/3WQy27DIBBFf8ViXSpmsHl41f+ougAzTpBqk4Jjt
 Yry7yWOorayumBxkc6ZuXNhhXKkwvrmwjKtscQ019A+NWw4uvlAPIaaGQpsARC5b3mZjO4EH0I
 5cWmcGlC10snAKnTKNMbPTfj6VvMxliXlr82/wu33X9UKXHDrlHXG2ABev7zH2eX0nPKB3VwrP
 vhOIIodj5V3WoSAQbQt2B0vf/Ow42XlR0JjwRPR+Hf+9V4u08e5Hmm5N/y5Ud9star34XTnEBM
 PkvTolVYaVF8XqBbvCvEhTVNc+obIYdcZKzUYVIbAedPh6OvTYlAgAwjrra0LXL8B0UmOka0BA
 AA=
X-Change-ID: 20241122-b4-sm8750-cdsp-38a6c2643a3d
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vBJoYS6kgea9KnuipejUiu6W/UyWi3+gXOVaAXDBGu8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0YigT+3azmRAzoiP5kKesAhS+LovXxiaqTUSH
 XVtYyCkInOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9GIoAAKCRDBN2bmhouD
 11+0D/9UdkSkavwrurxGEPRe15zNeHtxOzWfEDEm0oYIm10dmRExyP0pe8nngv87n+LkuufxzxI
 vG1UocuOzfbuTSX30a1MW7E/Y4rfedXz0thQzC3TByH0CaR2On5LA09OR0Gky+Kz8XfpAPfXnKw
 wPnQMcEufV8wSeqZ3j5V6gkrQ9uHmuL58xzc3VryLn+D2K8M0BAyGRKGYzM86goJWTO2b9B38Ur
 ipF9asdV8Es2lyhnEKLtMHO8Rb7K8UpMawLgeOCKi8Ijio2LGvndS622ucd4SDeSR+FHULg7P5i
 EAYtQRPjXE8PecfUsMzC2O/4KCC9lV5L102oz5n5m5WiD0sTAEbUp+1t1UtT9anvZRKLJd1kkue
 Mk1cKdH0/XsXTSrWzUQV/Yk1/hP1R70h4sOhOG3Gsh3e2SSunYuikkFJES1dbKvu2BfOqCyUuEh
 NDFHgij7cLZGZoksVg8e7aIfo4az05M+XX78n79Ey/rR0PlPP5y7SCp4EdkK3PQpaUVExbyiidb
 i5ONm99gHRksHNB286+7SELcZaVwolMcSFezjg5/da2wZKD9kUBKGYGbOSefBQ67lizon8VFCfU
 NdqXWzoxqIDFdU+5IZRxMZmkxCJs+GW1qDcCgquHm+pq5YwwPt2GrsxQYrqGiCfJKtniqSxUaCg
 XIgrKQlLkfXp2SQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Remoteproc bindings were merged to remoteproc tree.

Changes in v4:
- None, only rebase (context changes).
- Link to v3: https://lore.kernel.org/r/20250221-b4-sm8750-cdsp-v3-0-fe2891beeef7@linaro.org

Changes in v3:
- Based on Dmitry's feedback, move modem pieces to separate patchset, so
  this can be easily merged.
- Keep previous tags.
- Link to v2: https://lore.kernel.org/r/20250220-b4-sm8750-cdsp-v2-0-a70dd2d04419@linaro.org

Changes in v2:
- Fix CDSP and MPSS PAS address space range.
- Re-order nodes for correct placement.
- Rb tags.
- Link to v1: https://lore.kernel.org/r/20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org

Context of this depends on my audio patches:
https://lore.kernel.org/r/20250220-sm8750-audio-v2-0-fbe243c4afc3@linaro.org

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      arm64: dts: qcom: sm8750: Add CDSP
      arm64: dts: qcom: sm8750-mtp: Enable CDSP
      arm64: dts: qcom: sm8750-qrd: Enable CDSP

 arch/arm64/boot/dts/qcom/sm8750-mtp.dts |   7 ++
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts |   7 ++
 arch/arm64/boot/dts/qcom/sm8750.dtsi    | 194 ++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)
---
base-commit: eea255893718268e1ab852fb52f70c613d109b99
change-id: 20241122-b4-sm8750-cdsp-38a6c2643a3d
prerequisite-change-id: 20241022-sm8750-audio-d3e7fb676716:v3
prerequisite-patch-id: b55e186eee8900b7a4f58684018cb3babd1f6fab
prerequisite-patch-id: f43e8633f9f6e2f50fda536727f8de5908d3e21a
prerequisite-patch-id: 64e093ece66679a7a4b9290374176811e1938337
prerequisite-patch-id: d2fd6b3e1a17a96b805b4eae6971168ed2bb11cf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


