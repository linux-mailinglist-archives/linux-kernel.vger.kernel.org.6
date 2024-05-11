Return-Path: <linux-kernel+bounces-176462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6A08C3048
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 10:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C06CB2127B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3247535AF;
	Sat, 11 May 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjdI6ynY"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3718F6E
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715417681; cv=none; b=nomTkkaidJkreyb680wa5p0UAJdF6BvUoWRrTQMS6ir0J1UB3iGfmvkQA6YiYGXqSz7PRxSj6yYYfprdiLXUABDH9VC+X5BHRQFOu6+S75rTOfMbaePadN/6pm7fC1Sz1YcYXnaUtTckLoqoEjGovP/XrXBC+j/20wLfre7AwA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715417681; c=relaxed/simple;
	bh=qc1uu2w0hZF9sL0QGWbvDzG6Bu3Z4a6AXG0E9PYlt3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XluUM/hlXd7wlJRGf7yV/mAlfJUlDWs8ptnM8s0uHvHr6K4Vd4Ma9TZPMImHwm3Ujo89zzQ7rSuuYgGeOkZAu+l+I+slidMbzBc5r3udg0BI3wgKqzWEYIG/pWtT+J/LVCj8Cy6PiyGi50ehfBmm4HXsd3hEAOYs5idkXqUD+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IjdI6ynY; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e09138a2b1so34593431fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715417677; x=1716022477; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUvWAtUTM4Sm4FoN3R4b0S2PPHKLWOTANM8Xp+Goivg=;
        b=IjdI6ynYLRwzQASENnbniZ9QONjcCE2Dai7kpjuqbJ+tVci3p/wkGP0RjBjvAXLJL8
         jv0FS5JXEY9ZfvTimTTRgK6YN1qMpdf0vo7tN3Ds8K+72muxGdprSw1wozifO4TY2m7D
         xL1oGSVKCKyPgAKdFkzuBfOKu1/EJ0pELyfgnPNq5ln/7bMaiubXbpDMqBstmCAXu3tk
         n7kB+P3Uy9xYitEUoGkVewpEV2uKeLV8BE5cIu1tGHPwUAaiXSzCJkIs0Nj9RDN2dW4D
         eFFbCuC9JIlIEwGHc0Ymw2dQzPI55+9twAsYoxOaEQWFQsfL+aq8YO3ra/IK65Gn8YJR
         NwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715417677; x=1716022477;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUvWAtUTM4Sm4FoN3R4b0S2PPHKLWOTANM8Xp+Goivg=;
        b=lmG3MdtEtvmggCBajW1ZOHgjf+7W6aeCf5LMBt7klGshDKa2nlZxlxhbGziw36K41s
         yb3FWGUXp+SW1IsXFSDgSPaYNHL4X8w5yYb+RJryByX01Mcmx72aGskbdEpQVLQxh/4m
         R1sp+JF03Pdd+8bYvuX5b+Ksbhii40zWCPq6lJxyOXbYPY8c99ScbpL8sEaLN0E1n1RU
         m3G0Cn40JijtDyVmNd+jVQZSzPbSrWPwJi5Zl259O2Ro0nHOoBQx3spmKiCYUwW7iTYR
         osMDUxrvDZyqHSaLxqOuGSAwgU4etCv5AbO/vcaQE+zrhGC/Uw+SoA7xma9M9sV/XvrF
         K6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVs0yn06HhnFQwRaAgsYprlx7Syu5rKsMfA2N9xTrhL7jc9bUapAhQK5H58TlUfRcwktM+/EKWSi0syn1N7sWraAysaa3PJyUa2cEe5
X-Gm-Message-State: AOJu0YwhlYL6MW7afXt1Z5aU62kv31skJ5ZIPweYaFNSE/l4MPY3xC6C
	J+lsHVxats5fgvyY26QVa4VmTmH2V1tw69YxuxpXy96OsWvfrXOMT/+tArRqrPk=
X-Google-Smtp-Source: AGHT+IFxmb3JASctmdQgt9BFaS012sf6ELNlLw2ZYBIT1wHgxOLuixLYpW87XXBjRRhFOdfcx5zcLQ==
X-Received: by 2002:a05:6512:23a0:b0:51b:e46c:19fd with SMTP id 2adb3069b0e04-5220fc7acdcmr3641943e87.18.1715417676689;
        Sat, 11 May 2024 01:54:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3237sm961631e87.142.2024.05.11.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 01:54:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 11 May 2024 11:54:30 +0300
Subject: [PATCH] drm/bridge: aux-hpd-bridge: correct
 devm_drm_dp_hpd_bridge_add() stub
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240511-fix-aux-hpd-stubs-v1-1-98dae71dfaec@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEUyP2YC/x2MQQqAMAzAviI9W1hFGfgV8TBn53pRWZ0Iw787P
 AaSFFBOwgpjUyDxLSrHXoHaBnx0+8Yoa2XoTNebgQiDPOjyg/FcUa+8KBJZbyyFEKyF2p2Jq/Q
 /p/l9P/RDEjxjAAAA
To: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=qc1uu2w0hZF9sL0QGWbvDzG6Bu3Z4a6AXG0E9PYlt3w=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5q9kYe6aNXtI9uPP/h+lZGvKur40WVdWf3e5YKzuEKq/
 Jakm0/qZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBETp1n/1+vXpY1L5jfRIil
 RMm/kSc3m0lj9nPrRKW4yijTH8YnQzQ3nt9YrlkbIWnducviIKfLlTM+exoz/OYmRPedeq1nUrh
 BUM1CnN3vXqnGurcH1qyvP30s3GsBw6TWnNnG7Vvj30VUr92rJOKxYsqyRKNm4YeuqlKX2GeWJ1
 hN0fvbcHr9V6M8ldlfvk6Jf6Uk/sj7MntQr+tVXdfNTP65a3WLpor+lmnawtskknm4++Kf2fc1N
 d7mt325tW3hTzteE654XS+2WYWpD0N6Htl9CJmQNDlXQ7vnxJ7kZzEud+QOWOiqH9rsfPiVbNmy
 icrPlCYW/jv2+P9RRqWXiRsDhH22rvrzw63/iKdxQ7sRAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If CONFIG_DRM_AUX_HPD_BRIDGE is not enabled, the aux-bridge.h header
provides a stub for the bridge's functions. Correct the arguments list
of one of those stubs to match the argument list of the non-stubbed
function.

Fixes: e5ca263508f7 ("drm/bridge: aux-hpd: separate allocation and registration")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405110428.TMCfb1Ut-lkp@intel.com/
Cc: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 include/drm/bridge/aux-bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/bridge/aux-bridge.h b/include/drm/bridge/aux-bridge.h
index 4453906105ca..c2f5a855512f 100644
--- a/include/drm/bridge/aux-bridge.h
+++ b/include/drm/bridge/aux-bridge.h
@@ -33,7 +33,7 @@ static inline struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(struct devic
 	return NULL;
 }
 
-static inline int devm_drm_dp_hpd_bridge_add(struct auxiliary_device *adev)
+static inline int devm_drm_dp_hpd_bridge_add(struct device *dev, struct auxiliary_device *adev)
 {
 	return 0;
 }

---
base-commit: 713a75079f37b92835db48b27699e540657e3c5a
change-id: 20240511-fix-aux-hpd-stubs-117c071fff77

Best regards,
-- 
With best wishes
Dmitry


