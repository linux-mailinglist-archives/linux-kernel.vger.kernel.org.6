Return-Path: <linux-kernel+bounces-353462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1085992E2F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55441C22ADD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C28B1D47D4;
	Mon,  7 Oct 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6GUEqu5"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D51D417B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309824; cv=none; b=saQkSyUHkDQyRtuk/dbOyJNG1rvN5c0rqyUP3NXtlStTbd0mip2UNNWBl62Bh8GZ+4y/A4crFfMLd77mKCOhvJD3Fzbx616VRtd8DjHWe+HPyh25PgfJCaN5UiXSQjJm+WtNO0EQytXrwjq+0bJLJoHaIXkEGssFA6l7fYA4MtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309824; c=relaxed/simple;
	bh=I8UIXlkyqy4Mwtxfe+Lk97YCZk/oHsm/QktDgn6rVqI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VRK8moNwsnbeC28BJ4Ry5bGzA/0OnY7CNMNs9oe0BbI7Jnc6KpRC2AJjkgn4imppdtC/eKsqR/z3mdTSu75U4IdMfFEA7gOYBOUnRr/+xFhs29mx3NdEPdWbwsX6jH3fi/tKpjcI40AkmvPsqp8JfTXv9TZnLcukUVhvBmekxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C6GUEqu5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ccc600466so2265260f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728309821; x=1728914621; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSLxNDuYdWpagdzEer92KL4yq/BpaLG5xeJAnFgYcHM=;
        b=C6GUEqu5XDbfKfTGvf4bhUYawrjSlqdFWR451loDAUOF6m33y9XZ5gmbH8CvOpTCoJ
         i33iaFK5l/CK/3us+4AXArHw4zx3MVQaFtglnSDfrpklAH1pNE0292U17AdY3NgZR95v
         t8KuTSGlnMIrIiJ8Waof3F9iUgTt283KBUNYNVohHsujvsP/3HdkCqQahtQ1D5svHSiE
         zb50qfPAivgak7hXoveIYZuIxQ2ItTGrMVcFtBxA2Ukb3ZNgMvwtTjIQhlpOQjIKV0ON
         hD82qJE/uUvCr4tkfGn8KE03IX/iBmnrwawFm85lZ8KXbh0L1/r9ZmUD9Kdbg8mrJsWs
         /prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309821; x=1728914621;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSLxNDuYdWpagdzEer92KL4yq/BpaLG5xeJAnFgYcHM=;
        b=A+J+LpUccGiLSbBKb+CHGW4jXg1aU3yvCSnqRZYW+pRAzmkJxY/5xI7JUqY8kvN5pl
         SAtiUal+ZwZmQPpYAGUbua/JpwPDZ6Uo3BfwFG7tGciaQmCWrhLg2jUF4hjhkSts9os8
         bAo2VMsNwpK8C1jCbFTmOWYfUugZ88irGCRb/DOHw5d9Pu9N15Mp3WJ7Es9qOXr3I2Y1
         8fQsIdLCAY7H7BC4ICkAq0YkZ9KNW1+RVSWGomr68XlW76KgNETsT4Re7YMGuWskRWql
         oBIJfy8GtobzscAWS7GEQuLvZc/b3FbcAuAT7Yhtz1BtSEg5XWTyTwMTWhQwbwCz07TQ
         wEVA==
X-Forwarded-Encrypted: i=1; AJvYcCV9osWY5ohp5cwdUZqSxoth08yxsFbeRx3IhO385dnSPpBkiM34LUndPSuZQD8BrKaqlGsSBHFSpEHipNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziE6uzFvMZxG+u6kftqpemelmG8oAWVs9KRn+LACwXNWF5huFJ
	ZpFyVBYlb76ukbVkof/dcHFrLIPdaZJm6lqAagNFR+IY1uLd9AiumiYNZfOC6X8=
X-Google-Smtp-Source: AGHT+IEvaY76Nbh6y2EgunS5NO4YnfqBAs/pRm2aYkZb2LWol2ctokQ924n5nzY5hSHUuWzsXLPd9w==
X-Received: by 2002:a5d:63d2:0:b0:37c:cd38:c51f with SMTP id ffacd0b85a97d-37d0e6bcc41mr6226690f8f.10.1728309820972;
        Mon, 07 Oct 2024 07:03:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1688a486sm5857022f8f.0.2024.10.07.07.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:03:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] dt-bindings: mmc: document mmc-slot and convert
 amlogic,meson-mx-sdio.txt to dtschema
Date: Mon, 07 Oct 2024 16:03:36 +0200
Message-Id: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjqA2cC/63OwW7CMAyA4VdBOc9TEqB0O+09Jg5O6xRLJK6cL
 gKhvvtSTtudk/Vblj4/TCFlKuZz9zBKlQtLbrF/25nhgnki4LG18dYf7IdzsMjMA2C6yrRNTXs
 PP3NZlDBB4DxyngpEvlGBQXIlXSBRkQzpBmVkgS7iyR4PHYXQm+bMSs/zxnyfW1+4LKL350vVb
 dtX6tWBg3AKEanvO+/c15UzqryLTmbjq/9DevsK0oOFI2IfxkjWYfxHruv6CwT7ycuGAQAA
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=I8UIXlkyqy4Mwtxfe+Lk97YCZk/oHsm/QktDgn6rVqI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnA+o6HBbW7RjCo+cyD/An3Cd3RF6bmB9Gj7SZUyyW
 rYH6HbuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwPqOgAKCRB33NvayMhJ0ToDD/
 4tn0/fx8ukJ5zSvvWZSIZcyUsUnVIywgPK3SNYCw8Jov6H9n6Engg/jfkH2UR9NZ/kE5xrKc37jsid
 7VMNKqU749yPjO/YQQWkU+/a/UxvCzJAM/sR/ljYF7LgggpvRtySMB/dRg1IIUjZwMK9YGjpG0hlpS
 7QvlpaDjAg1grVn0dfBEpNIYfx3NtgCww/r1Hc3XcekUDMRovo9IdMfAK5E+kR2T80uC7uQMsy3LS0
 uL0hNhJJfgc9ZYd3UQAkeN2ZefcXvLNTOVuF/XYx1DRBdrMLKQj8KWwre0Y1zAtga1gUZjwJaDEG+I
 X499SgBjmWBsReJc4l9OvD59JoEFn6xJSVD4QeCC5ZZpG6vA+K/eSIBluzi+WbYf9I3qgz8TSOelwn
 sQ265Ln3+S2P2EVIS9HSDOYS/ps13a5S5ApyN93N7FQ9wFC2ZXKQ9EsuPzWK1Lh2nHJt6FaD3D940H
 tyJS2leQ+WRofTTTHd/o5cL8+3T1T54ewroxegNkNuanOZUPwzS8QPKK1kC+nKyOubtPI4Pa2l43W9
 y67MtW7uQOQ8bOqrwOWd6A4mtNQpDlFQoCJ6a6BxUE9/rr6vRMSFzXbr/bs6dvpAp4Vc5EtiM6gBjC
 4/vAURZ9Qhynb/hLSBpEc2Y4swml6jFwEMRlQrF7Qw1lN0hiMbck/k2cvVJQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document mmc-slot because used by amlogic,meson-mx-sdio.txt and
cavium-mmc.txt, so make it common.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Revert and insteads move common properties between slot and controller into mmc-controller-common.yaml
- Fix other comments on patch 2 & 3
- Link to v2: https://lore.kernel.org/r/20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org

Changes in v2:
- Fixed description, limited to 3 slots
- Moved out mmc-slot in a separate common schema
- Link to v1: https://lore.kernel.org/r/20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org

---
Neil Armstrong (3):
      dt-bindings: mmc: controller: move properties common with slot out to mmc-controller-common
      dt-bindings: mmc: document mmc-slot
      dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt to dtschema

 .../bindings/mmc/amlogic,meson-mx-sdio.txt         |  54 ----
 .../bindings/mmc/amlogic,meson-mx-sdio.yaml        |  94 ++++++
 .../bindings/mmc/mmc-controller-common.yaml        | 357 +++++++++++++++++++++
 .../devicetree/bindings/mmc/mmc-controller.yaml    | 344 +-------------------
 .../devicetree/bindings/mmc/mmc-slot.yaml          |  49 +++
 5 files changed, 503 insertions(+), 395 deletions(-)
---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-6fa70546ebb8

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


