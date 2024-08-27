Return-Path: <linux-kernel+bounces-303560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CF7960E17
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A386C286D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638451C6F52;
	Tue, 27 Aug 2024 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/Zl13l3"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73201C6F45
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769871; cv=none; b=mwCenIxesjj6MyUC9P8OJS9cLdIETj8pxaTCKZ85mP1pUhpxfS6jLdifGc+csRWeypU6v/X2xFQa/pXXoP7GlXqMiGl8RQqXdjuwlve9dyLBxIqH5pyCiwDiu+JCy99VGigWYgs4M4vjAAMHDVYtgixtfT25pZDhGGu4mfIWw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769871; c=relaxed/simple;
	bh=ue6WPVo2ptKZgCeNkE1VgO0ePkeq3s2Ko4LKgOeSSVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSK2HTPSrZpKq9B9QbxnbAnnKsMfpzKrxqso0wAe7MBO0Npp+vurPx71nw7AcE81vXPc7p+t2vEHrLQrOO1mGlQyrnXCs83xX13EnVQ/fxXeXWTHXW971SWAudSf+pHF0Jfxc5DxYemPSPTrm8m6xNLtqxmcZ09qMU4o2ShtArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G/Zl13l3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37353ba8eddso54614f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724769868; x=1725374668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMtvRXV/U3e/l+PzLA8fY7oKc3KTxA0nshrMdnXdyGM=;
        b=G/Zl13l3ErRnoprxZG84X8WzLEws3gCdOnf+BVBRU474/1OaMs8vz97Zr/jxMlcDfG
         lgo3vC6SQCThpTmRUPB4IeF+TqUh8aG5fcNrItCOk7WRka1bOPolvwClh2UX1v4TOT7+
         boLw4V9AHxe1Xqei7Cm2FtC+ij6Ow1fxfMaGB9kBbLeyXMPc1u0Cb+GsEc3ENfC5zA/6
         RmYwIahRHCsS2ZuGcBHelYFnwrNNdOLfW78T9g2r/RXLKiGmry2/d94wp6nttkmePjfi
         z4VghtfcGy68gQN81JL6I7KZoh5rGYQ1Vl0hC2mkUtLUwaqDZ9TxxHKh1638siHrle+u
         DY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769868; x=1725374668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMtvRXV/U3e/l+PzLA8fY7oKc3KTxA0nshrMdnXdyGM=;
        b=pd+sbdtb+weHEsdD/xBSPmQp1Hv8fen+Ya1NoCUJZZe/FJyYSkeSRXj29f3vd6yy26
         69MHfYOs2nfWqZ67YdhN7QDKoDCwTbtSgHhAKbQqVzw59wb9+/z2dLDlRIMaC9gP/9E8
         LuoUpoz8L1dKOs47xZKhfy/OYpNGmF1A5ZnoYc5MlXBP8z0EdAeLoP1Ubd6JdBSm3SUg
         lgrS4sSWVWLwiR6GDWsqBySDgXQwZM4jQMJdXlMi/kGWtt49b3zyzaHs9ovcL4z+7KBM
         NBUWtnwuDrKLM4hLeo3ckYC9WJF3FuFfAvfCkBzu2P7797ATKrrG26MvkypBIawjMsuZ
         nJCg==
X-Forwarded-Encrypted: i=1; AJvYcCVzZRjKukWHHhpd1vKJq302qHsPX/kZ87o/gUYkufIlOcHxjn22N8SMyDSfTDEHjuh6RwGEtg7hkMC+URI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq378yJfEbCmEUlasiCchjsdVpjNahJtwh0cnBCAaJfbD/ax6X
	tKaV2p+IoMfFcs5YEKDOaXmQlDY4kvGfGiGnBduHcx0slcvcwePF/V5WOuwDqPQ=
X-Google-Smtp-Source: AGHT+IHDXLfSvZsnyIQUPh/YuEtya/oGVL1iC+4RsBP4IZ1dC1c92Nqcl6zanmBibwQIO5ohbR+o6w==
X-Received: by 2002:a5d:6d8d:0:b0:368:4c5:af5 with SMTP id ffacd0b85a97d-373118fdc9bmr4803105f8f.10.1724769868278;
        Tue, 27 Aug 2024 07:44:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff654sm13270457f8f.75.2024.08.27.07.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:44:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next RESEND 2/3] net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
Date: Tue, 27 Aug 2024 16:44:20 +0200
Message-ID: <20240827144421.52852-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
References: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in hns_mac_get_info().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index f75668c47935..616a2768e504 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -933,6 +933,7 @@ static int hns_mac_get_info(struct hns_mac_cb *mac_cb)
 			mac_cb->cpld_ctrl = NULL;
 		} else {
 			syscon = syscon_node_to_regmap(cpld_args.np);
+			of_node_put(cpld_args.np);
 			if (IS_ERR_OR_NULL(syscon)) {
 				dev_dbg(mac_cb->dev, "no cpld-syscon found!\n");
 				mac_cb->cpld_ctrl = NULL;
-- 
2.43.0


