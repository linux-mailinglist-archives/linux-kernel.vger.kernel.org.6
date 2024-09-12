Return-Path: <linux-kernel+bounces-326030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9026D976188
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2488E282361
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46945189530;
	Thu, 12 Sep 2024 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5/rRESD"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1356455
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122688; cv=none; b=HRknqfxJtRWgf/8jU3GtGNYHMvt+zj1lVNUJSj4FDjiCMvH+6DZ5lH4UpIRT3ksuY+G/lw8/24yWknG2FLONsEjzXa92h8wyHwmtIft+0WeXZIgL06Pp7MNiGAkNzPj511G46lTyCHDQuYnU5RWavbNYfpMLLXg5eo+1riupdNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122688; c=relaxed/simple;
	bh=rICUziB6M1nqe34g/DSkBETJu4TjDQ+3xTSrisT8cOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMm3cuUO94d+Qf/OLGX7I4CTM62jY4UGOdX8Ubn/2jWoNrY+8MpoaaZF3Fg/I4JhvG/hP1vPnac0RCo/0nVJjGl3MhGVa+IgyWTmmZ5Wh47qfzwYfkjIRsVknpg5D6eBj4tpwitWheRB8RteyO2kDNmBkWiMwuvy30d2iCXhu9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l5/rRESD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53569e624a9so90224e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726122684; x=1726727484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KomP7G90w5XiTxBfY5n2KIRLtbQEtmSrnwcuWwZeCTA=;
        b=l5/rRESDP9LjCFOV6e4nNL8rXBt5/TBxWtzc35Jf+APqTgSISCfeSC5hdNwAmqcNoq
         UdqVFfzqkRhlRJ7MdMwBr+Ht2Y1VtPCZoRuSW/sHDS0h/5uhjNAViMMJ66hX1xEEDbd5
         2OAKDcI+hzW3WeFopfyVGXOtbekfodjvqfkttOOczVPOdw6a5sfLUhCrH0a/LSmoVlXo
         2OSak9tt+xWPg9TOQIkAErH5IVCmECLK83VCSLeYbTaMbowPGLPaHdn5biXpXSHbvmDS
         sq1cz2W1v30CSku2YmjQ0ZLUbjvqNqM1zHLD3YTbgZljEXVo3iMk5Gr07qP7Ocut9Dzn
         j8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726122684; x=1726727484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KomP7G90w5XiTxBfY5n2KIRLtbQEtmSrnwcuWwZeCTA=;
        b=hacgr2mOzKRVg8yYKf5Jiay6haN8V4Nd9OMT21igFhyu2IAryYn3Tpg8npZOsp6nbM
         zdd1iCW9B1/BamOjgHEvrYChIlHgur/lxX3QBd9WvHu2U/kcve8JXlB2IlpoyDEfrTE/
         ZPsU/CbBwH/sFSaSU8LvpCawovNj37XyK+PG2SGr+vob85zSIpAYPRg1N2vGV6G2Dgtl
         ZXbg4zOVjWelploE4W27U/JsncJI+YVjIc9M6dLfp7WYuIlxgsLbOawCMxy5M+L4ESUj
         qyr/YFJBG7mR4GviXnMgHJlawD8Uc6c3ifcsbyeY9uBvRpkVEypDLQ9qZKTqaer4q3SK
         L2KA==
X-Forwarded-Encrypted: i=1; AJvYcCWncKh6a7vqNylrqRo/X2ei0d2ihSfa93l8npjNRhTKfyZHvudlr7GCXD14+W2AF1HAfBqSPIDBJQR2WHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdfmFwgKh0OV4dk1WKx3cgwgDuPADEFw3u6WP+7szVn7RWpW5
	OVRx9H6VvPH1BMw1S+/CMA/kQtCKDN4ir8jblMrzLmgfvXEyKOJYhWKZklLX+TY=
X-Google-Smtp-Source: AGHT+IH2hkCTeR/X91NdGpik4tEsXEvkiIUGn0c4AHSX61UnYwePZRohOaArIFwge+uJMjMRc6ltPg==
X-Received: by 2002:a05:6512:2828:b0:52f:c337:4c1f with SMTP id 2adb3069b0e04-53678f5988fmr268684e87.0.1726122683861;
        Wed, 11 Sep 2024 23:31:23 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f870c3csm1869347e87.104.2024.09.11.23.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 23:31:22 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: willemb@google.com,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: Makefile: add missing 'net/lib' to targets
Date: Thu, 12 Sep 2024 08:31:18 +0200
Message-ID: <20240912063119.1277322-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b7df5477317..fc3681270afe 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -64,6 +64,7 @@ TARGETS += net
 TARGETS += net/af_unix
 TARGETS += net/forwarding
 TARGETS += net/hsr
+TARGETS += net/lib
 TARGETS += net/mptcp
 TARGETS += net/netfilter
 TARGETS += net/openvswitch
-- 
2.45.2


