Return-Path: <linux-kernel+bounces-242431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8183E9287FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35AC1C22662
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A97D149DE2;
	Fri,  5 Jul 2024 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+xCSguV"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB91448C7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179080; cv=none; b=nkV1x8oV0seuKdF2F8Jh6c4bXTcZyf3GrrYegI66UOgtCPcl3fr1CU/1T7d/+QO7VZDks+JavETsQPpjkcy0vhdAJ4woJFZJP70ByK+uTERGd0ypJv5ccH00n/dgTJVlOWXnUNQXDySu4t/v24a2K1HFa3+eTSm8tIyoOkcQcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179080; c=relaxed/simple;
	bh=FuBrajrqQG9XnSm84KCc44rCbv9kqxWntaHnPCAb3kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZuY0OkIxACrCR0WTSirmcNLLJFu1ZPyCh/u3qKnr9z/nkSp3xntPK1mbx593eVjAaUvQrVr0UxjaO2PQC1GeZYb7Ae73reJEcty6C3r+1OKgI5+2AwxEarBvm8ncjCYRSZiD5B9+ZaRA1N1G6+jpQu1BzCudxvj9aKHSnTDXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r+xCSguV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e9a920e73so1743314e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720179077; x=1720783877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4KHOTg83zzFfVGaUl4+JK0iTPEEAglfxmKaKcO2W6Q4=;
        b=r+xCSguVCV9dCT51vF37tpB8ekHlxtxdDfutNgl5qA3jl5awWr/F0WtF8X61BWRK5d
         pT84FPJxm9P8N184EtaFf//X87vwUQnr2LKsc2UZ5dUAjOuNsUgS2uDv78FFOzDa0sVq
         MayojkLmM41ptVoBOm/0prmuK2st5Oh74BhxvsS8z3UaTdVwrn6oE7fncbd5UV8fyzak
         z2igfyo1zA/Qc3WyfIfAQSl+E4TDamo1NxPmZQlKeSOFbVA5wr1c5p9XMqloN4f90J3D
         NnuRRz0019rrXuz5bsExzVkS4UVv5RbZ1K6H2DmU1B1o2h1nAFVOlG8b0QfU3u3CkT3X
         QcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179077; x=1720783877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KHOTg83zzFfVGaUl4+JK0iTPEEAglfxmKaKcO2W6Q4=;
        b=A41Pv0spnYKzp1HRxH8EF8fCLH9rFd/uUugo8I5FFJhCl3eg36rEUC5/b0NjBFdZta
         CsDF81FiLLxaulZs+qLfR+xFU3WYT2S4yZOviGae2WzVq6IbD5LjL1lOX9eDoMHphjWE
         OITTN0hZbqDSMMPvsrcJ/Z/3mEq+vPJHlusG5vXHmQMLrn6v9SGQb3xJt+GQlEJwiGmt
         PXX/0u6ZSGNhWg0TEE27dfas15ppZGvABIe9VJ2OBf3FEN4LFXlLSkOdcYNXykn7uGoh
         WgRTuYuTmD6dKLVE0ge8FzHDz999eTVErmbKME57ehT6cOy9lpQwJj8uv/TtgiRNE2H2
         mQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRppuhmParlmlKmHNbr1R4jjvh/J9r7kpfPET3wvrsxO42pM1knI5ZwprsnpUF9OceUeEYpkI99zTuQ+dPDnJazG8xWa5MyMjbygsc
X-Gm-Message-State: AOJu0YwBnDmz3YWIQINDaNIEW2DIvuyfpHhF6Ytpsr+3HSPobKZq2j8+
	qgsMtYQBFjYRnqucOxXKAQpnN9x8wkob+lBj9sC3ZMDlRX0tyXaSR3z734L05Rc=
X-Google-Smtp-Source: AGHT+IHu8JpvSRGOprQzL81TsvGKBnMmQCKqCq82+aGtEZ11VImpyhljjvm/eD9bz0xqu6/70v7QyQ==
X-Received: by 2002:a19:ac45:0:b0:52d:b1c9:34e with SMTP id 2adb3069b0e04-52ea062e361mr2952258e87.21.1720179077159;
        Fri, 05 Jul 2024 04:31:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc942sm58090725e9.42.2024.07.05.04.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:31:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sebastian Reichel <sre@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] power: supply: core: simplify with cleanup.h
Date: Fri,  5 Jul 2024 13:31:12 +0200
Message-ID: <20240705113113.42851-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/power_supply_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 8f6025acd10a..2b845ac51157 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -9,6 +9,7 @@
  *  Modified: 2004, Oct     Szabolcs Gyurko
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -756,10 +757,10 @@ int power_supply_get_battery_info(struct power_supply *psy,
 
 	for (index = 0; index < len; index++) {
 		struct power_supply_battery_ocv_table *table;
-		char *propname;
 		int i, tab_len, size;
 
-		propname = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
+		char *propname __free(kfree) = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d",
+							 index);
 		if (!propname) {
 			power_supply_put_battery_info(psy, info);
 			err = -ENOMEM;
@@ -768,13 +769,11 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		list = of_get_property(battery_np, propname, &size);
 		if (!list || !size) {
 			dev_err(&psy->dev, "failed to get %s\n", propname);
-			kfree(propname);
 			power_supply_put_battery_info(psy, info);
 			err = -EINVAL;
 			goto out_put_node;
 		}
 
-		kfree(propname);
 		tab_len = size / (2 * sizeof(__be32));
 		info->ocv_table_size[index] = tab_len;
 
-- 
2.43.0


