Return-Path: <linux-kernel+bounces-195234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD9B8D4958
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D98285315
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B417C7D0;
	Thu, 30 May 2024 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DR0iGjrP"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8E176AAE
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063916; cv=none; b=YFENUm1cwtkXbKpZRmVRh94c+ckprvPLiZAHxRPy/HuT4qrNF/cXDWDt01rBSLd0B+oFWATj9SGj1WEzY0gC8cUMGmP6Ldxp8dlC6lrXTHI5kHOJt3magdnYckjr+lMw/9BHXlA//kEupFOi11dAsMsJXUgz2ihK82EsijTx4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063916; c=relaxed/simple;
	bh=wEWzUb64Vc7F2Q3LuJkl752STUy+7RzVyEj0EIa99AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTCc9RByEoz1TQkyNZC+BFqSMAJrHS1fCCKYTGS4anuz01MV+fkrtXokr5ju2fBesV8zC96U1TY1SROoag3fLuCSEr7knOj5SmFCrT6exp+paz0nX6ba3beLx/ZMik6PCu6oW1jB02cBfA6j555cDI047Mhs207yib3Ni5Nw3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DR0iGjrP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ae38957e8so811049e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717063913; x=1717668713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4ruLk9Ftm9+QjaAcWOvP48LMnKLjWaDjJj5/jKtjp0=;
        b=DR0iGjrPS4QuMbaSjqmYLQZncSxGa/Bci/lJQ6iLLPWgCGgY0FNGNyzbSh7KPPu653
         RhU+Py9BaZoXN3/zFui+17x/v/3jRhde8np9wFQ36uQMt7CkKgdubkB15gRNZK+uymza
         E0zmx8dS4TxVyz50mChK5xNaNfdD+8atC9Wef8q97H9lHAA31N4Z5V5Ftfoumj/laVZL
         P3UpmJMmoWG1PHxCCavUT61JDftfUqknUrmMxj3WQwWXXPLYmZz4WMqfJHU2UWa7TaTh
         E9hj83bQBPYxwLh7huOSiut2ewgOyLuiwAJP4yFMKz4vOqb6qvrJA5tYmMyZyWswXYDl
         O/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717063913; x=1717668713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4ruLk9Ftm9+QjaAcWOvP48LMnKLjWaDjJj5/jKtjp0=;
        b=uxY+u/NwYNgVk3nTxaJOrNLH9zGwt/6wCwKGGjYJ48wm/VnZg68NAIpSOjyeubv0j2
         Y5Bt/v/PKyR8TheFY4hcotkSVxBr0L5AcllUAfme9Lqs8z8onjrlebg8luU0T35ofrOV
         nw9fKYe9Gat/mlq40Wjkq8qIgJ3xfG5hMD3F8CPG40BNkSV7DwOb1M4OUdP3Eudxb8vQ
         MGuAlAUwNrft+yJa6KtqvfJiuGm51KxIqqfemz/FTqw2lL8U101a8gn6GIKEoAj45DMk
         bBUi25Pcgja9fYhA26awHgsq/3xmRbiuqeJ5v6N+RWxukBzx5G33TmB+QeoaV1o9jjBH
         nLaA==
X-Forwarded-Encrypted: i=1; AJvYcCURs2sid4rY4B8X2aXCoBBfvqjfLNpqZWYYRIW78ScNE1mOK88AWpNNx6a5V6CZM66CQuLMSKUmnL0v9KAhfzLO+1hxZXeiw8/aCFVQ
X-Gm-Message-State: AOJu0Yy2eDiNAmwAFCyO1GHLnz8LFT8elqDfV6JpJvTxNASBtipTftYo
	rPS8DBkIUofv5Yoe9CQrsw7QmhImo1On/+7o/qCzxTZTGzT2z+beDJY9fIyce6c=
X-Google-Smtp-Source: AGHT+IHKELWEC1v/nerdFhSEuhPemYySFWzIWZQFDT3Ps3RHOrqqWa9HWxlgaztorNoQN9pOQkFXRQ==
X-Received: by 2002:ac2:5496:0:b0:529:1dd4:3e76 with SMTP id 2adb3069b0e04-52b7d480865mr883981e87.59.1717063912908;
        Thu, 30 May 2024 03:11:52 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a22aa3f8bsm530025a12.22.2024.05.30.03.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 03:11:52 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/4] dt-bindings: mmc: Add support for BCM2712 SD host controller
Date: Thu, 30 May 2024 12:11:59 +0200
Message-ID: <f6e0d1fbc6c5e620897b5c65c95147ceaeed1485.1717061147.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717061147.git.andrea.porta@suse.com>
References: <cover.1717061147.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2712 has an SDHCI capable host interface similar to the one found
in other STB chipsets. Add the relevant compatible string.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index cbd3d6c6c77f..eee6be7a7867 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -20,6 +20,7 @@ properties:
           - const: brcm,sdhci-brcmstb
       - items:
           - enum:
+              - brcm,bcm2712-sdhci
               - brcm,bcm74165b0-sdhci
               - brcm,bcm7445-sdhci
               - brcm,bcm7425-sdhci
-- 
2.35.3


