Return-Path: <linux-kernel+bounces-298344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D80D095C606
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D061C21AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C8A13A86C;
	Fri, 23 Aug 2024 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RRZtDSNZ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE910953
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396669; cv=none; b=ikcOt3DBG7t12NxsyjrA8/usJIxI801l9uPNkbsw65Z41bkrby3h9EL5EOypfEJ0XYJOUtBbZKY9OhVrbtEq7QyVuFCqJ5qP5vzIssYFHvsNgQ1WzzqADndubYasjqBPW5GMYDBwXGWEIS/Q+x5jXuTYoLQCrYnE6GQZ7nY5tXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396669; c=relaxed/simple;
	bh=jRHGY5HSVFsSc0uY4ShHAU9jyUHZAPRynwLu81wTfI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C5GLzZTITSGcqk6WqUhomwHh8/KCJ0PEg7O1fV+C3XJmGT7/DlxrMwGtaqX2z97C+m+XVsXQP3vltDtByAyVQ3r4ArCvpvunpv+ngB1tcNgDYYXCoj+ojt80cwV5U3nYEcVOfmshJJxvzoTOt0JSvbPLOXPE5jjHRGTy/AJH+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RRZtDSNZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa086b077so191476866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724396666; x=1725001466; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tfbhFy6Ox66uvahUJonALEn87DK7o7CG+5xtuFswxJo=;
        b=RRZtDSNZ4EewVkustUQiX2NO5jPsmN3R6FvIWMDlWlL+3YXdGzvG3PVFNgswEjciHd
         2WYrbkDQ9MdFBJDYrC/BNL5zZ6oPo81B1rjJ+hNbuZ+kIjQ6qs66u9/Iu9CPgDRW5Ieh
         qmzo1zimuwOj658D/1G8FhnRrn+Z6qb7nda6i3luBOriSxsjQqiRUA5kBw1eXckftzZV
         3h6OrX/eAK6ywMsASPzKCmEu71NDJgSbqi9Z6D9aUMT5BA2+nTRng8DDwbtt6vcBzTex
         KjQXyD8IF5E4YqwarIqRxqHL74xcLb1LjUhtHjAKlU2F3WO2ieGs3TgN9/xAUEgHtxot
         6lBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724396666; x=1725001466;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfbhFy6Ox66uvahUJonALEn87DK7o7CG+5xtuFswxJo=;
        b=KUOH93CZi7pDE1bsspIW1m57WhAJluIuOoXRpeO7ciLAjZ058lG3+GdGS7DTZSXleM
         WRYqMDnwDrSPtGxFIDNHcV8j0WXvWPvy//gYgvmC7RJgsqhSdpX0EfX/T3wpmfJIBtLh
         BkCPtToaICM6LfC8tx7isSaFETG1iO1Bp5/D+9AYkxT2MAsNN/6aGxl8yQQgFX7CQGMO
         f+ic7y09VGtJHL3phkHm2Z5tjOoPArVOorsWKP9TmgB4cDEDvFEJD/i+DpOcrvQvvCEH
         PnezsEdwQmwMRdQ0GnT7yaysuFh492aWpHXYw4Z9FiBOqOpWAKw809b4UNY60Q6XuZMy
         jnWg==
X-Forwarded-Encrypted: i=1; AJvYcCXV54bi+VF4jeoI26jy3lJ39kitK7TAiB21k1h33CzVkqONfRou1HmrLz/7noz2Nm7yAma9XuoF+cHqlME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSiNvcCm8AMTVlIAlSBIndmkUwgNdMfKS+AJcQAPjbxNdPvzM
	VThYtWe8AJlLzrchdDsvXAd8c3gQRqzNLD4p2RIdYwb/7kqEEQ9bD3EINZERfxc=
X-Google-Smtp-Source: AGHT+IElMbJWNLHHHW/KhCmSKBNkv041eSXQbeeUNDsxk+eZV8ACwE7C1am0WTGxRumdS8jZtECbfg==
X-Received: by 2002:a17:907:d59a:b0:a86:91c3:9517 with SMTP id a640c23a62f3a-a86a52eb66bmr92555766b.35.1724396665642;
        Fri, 23 Aug 2024 00:04:25 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48ae0dsm214820766b.184.2024.08.23.00.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 00:04:25 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 0/2] phy: qcom: qmp-pcie: Add support for Gen4 4-lane
 mode for X1E80100
Date: Fri, 23 Aug 2024 10:04:14 +0300
Message-Id: <20240823-x1e80100-phy-add-gen4x4-v3-0-b7765631ca01@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG40yGYC/4XNTQ6CMBCG4auQrh0z/dPqynsYF4UO0MQU0poGQ
 ri7hY1xo8v3S+aZhSWKnhK7VguLlH3yQyghDxVrehs6Au9KM4FCoZYcJk4GOSKM/QzWOegoqEl
 Ba41EqzXq+sTK9Rip9dMu3x+le59eQ5z3R5lv638zc0DQjVHcWTobjbenDzYOxyF2bEOz+EBG/
 IBEgRqpXK2EkEiXL2hd1zcueKS7CAEAAA==
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=jRHGY5HSVFsSc0uY4ShHAU9jyUHZAPRynwLu81wTfI4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmyDRv3soJLtO+to1Vi/NQ+VyaleD+TpvmEDHpG
 t40ToIBjuyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZsg0bwAKCRAbX0TJAJUV
 VjBDD/9tCC91GzYpK3PNiRzU/xHsv3KPMM7FGmo31HX7Exg7gkknLgcNLz9EEN5GaXvh/pJR3rb
 l06/UZT91L5ZwGzMg/UYkCW2I8gDdiiynW5sbYpZQ1OvGXvKqc4wC3GSRizWLGSWvqYjsYeusJa
 +2FKh9NFPUZ1pP+4vkUfsgNlTS5AWkYsDc4Y0acg63L6mRDuTYwEXRd2RmyGiy5SzNLv3XmNd7F
 rMVk3JH2mPTfRwu5opSsYZ+oJ7/GF+U5Lkf0WiXGM8G2U+Gv/+88CPL2DLZDkl4j+mN+Dy1OY15
 4N0xY0CwcECNo7uyG31YyQYSZeQLE7vq2V2mn7zOWIBvYhbhPSIv7pD71pU21I72TxcHv9bxAQl
 RVngwfEGrvqhmFeYCNqeRDxXczXgjwAoddogu2tBijffIctOon2/LMMCjE5zdPaNHp22r8ih0TD
 rURPraRAqef5JIsE8jGOrXSbaTvXafh3s+q3gP3bScGEs4/Qf8JIpSu9SvjFUey/22l1wOUAlcL
 BKA2BNQAf2jyWZ/axEuiTqjmLsABJ8KkJ7QHjDN/HACIJ7K2dMcP2I7vNMDnbidCB60z9WcuiwM
 3CGYgaB1kjFQdxqCpcyY1JgRA3NK6Atc5t1yn9kOorkae0ZuAwQZDN0bEFp/RuhT4pF+VT2p1z/
 fq6mzcK8a0hJ/8A==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On all X Elite boards currently supported upstream, the NVMe sits
on the PCIe 6. Until now that has been configured in dual lane mode
only. The schematics reveal that the NVMe is actually using 4 lanes.
So add support for the 4-lane mode and document the compatible for it.

This patchset depends on:
https://lore.kernel.org/all/20240805-phy-qcom-qmp-pcie-write-all-tbls-second-port-v3-1-6967c6bf61d1@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v3:
- Moved the x1e80100_qmp_gen4x4_pcie_serdes_4ln_tbl right after
  proper serdes table, like Johan suggested
- Picked Johan's R-b tags
- Link to v2: https://lore.kernel.org/r/20240821-x1e80100-phy-add-gen4x4-v2-0-c34db42230e9@linaro.org

Changes in v2:
- Re-worded the commit message following Johan's suggestions.
- Picked up Krzysztof's R-b tag for the bindings patch
- Link to v1: https://lore.kernel.org/r/20240531-x1e80100-phy-add-gen4x4-v1-0-5c841dae7850@linaro.org

---
Abel Vesa (2):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 QMP PCIe PHY Gen4 x4
      phy: qcom: qmp-pcie: Add Gen4 4-lanes mode for X1E80100

 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |  3 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 42 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)
---
base-commit: 81528d2de965dafd6911a0f9a975fc30b25e7080
change-id: 20240531-x1e80100-phy-add-gen4x4-fa830a5505b6

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


