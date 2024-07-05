Return-Path: <linux-kernel+bounces-242083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82674928352
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2D31F24CA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9D145B2B;
	Fri,  5 Jul 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfAkBtbr"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA626145A02
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166349; cv=none; b=XlApfKGaTmAvCjDkvbiLclGFH9jVpy8wegCIYKjdu23PJXFQYPCnN7NmDics7tgPWgeNsOWe4ShuvtIhxKTvwKsm82qTN2mMjrkX+GQLAxkjZ1miY/9W85h8FiOPGFEjhuyT6tzZEORHNuJo/2CcB2dTbiVAyzxGaC9GRaCgqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166349; c=relaxed/simple;
	bh=3gDLIAYz181HJf9x7NRIIfS45OFCw170AEfBrtmppso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dws18tC78NTaRlsxjXIoFGuLVHpB85Wsc084E5PE8x5JvLcm6I5RfgzvJVtuumhEFZiZZgnKSBQlxZQkkOkcetxSUNDsRZEWEFUSlR/kEwn7V/e6HcTdbCpHePXDqiRxuwzPfekcdS+SBBtrQWaf9dw9J+3D7g8f/oNh9vKUiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yfAkBtbr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424acf3226fso9846105e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720166346; x=1720771146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkPsMuaXUEzhAdmrj0v8DKrJWfFPcAx0F2jdkDpzpDU=;
        b=yfAkBtbrkHVeX9OnV6C5KemHyUfzSIjl/Nlg50NuAlLPO20UOQHVVdXfUNCa2dxMDN
         iJ90tqLMwJxTwc9ICBFUGNBNatOpwOs4ZFcPTmy0jcUy5a5LwvIa95i6VhvJ6u7b2OaT
         zFOw83NOckCycPJGT4S++JkjEPk6ibHNTgSed9OSFXW9396CAbiPlhwC47Dg0h6uXLd5
         CPoAgeQRIXvJZG8YUkwJltdnbwE/23Vn09+1urJTrPijKHiRmfpe1RB+dujTGF49LCGw
         8OVF3jMQ+ckz1wMz0QB8jI3UOVYHpWNfljhNhboN4Y4C/b/0KSAAc44EvB0ZZAbvI4qw
         s0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166346; x=1720771146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkPsMuaXUEzhAdmrj0v8DKrJWfFPcAx0F2jdkDpzpDU=;
        b=mdX8a9B2syVq4Ncyb7O55Gr+jmi+tzknePfBFnrJYf3Vh2KpoIjkpz0qZPdqbK6geb
         y2eG37FqnWFuMnWtkAeEcUQIx5g797N38myqd/6b9Giy+AIUc8n4hi20me22WB7P1vfQ
         98/i2lpZbuxk7XG/TS2mq86TSwQBG3DX2w7rJowbGHlBSO04drcdsJsJe7Sv2WQf25gx
         BCnJP1YoLlJXyOayOsyczuLR8D6Gsy8MD7ko+tQYD1+GXwi7nqB4b3gXzXCfPPU+sora
         aHYKXuaC7gCXtSrxJxw48nFzvYZmoH81bugxzThi/vpu1d0UKBR8oYLLLpoQGwWZ45a2
         b2lQ==
X-Gm-Message-State: AOJu0Yxpao0VIQ3kp0pPvpoe2ONUdZ9BwO2mv5q9iA364+jBLrZRgQHv
	dEzLTiptzyxv9Zg0HAjDKsTqYX8QIrAZHaSxF0pSh+jlNFeBYO/KzTyelp8UkRY=
X-Google-Smtp-Source: AGHT+IHdmMNOpFSelfLc9kICdBxoLWK+HxCmentqwGdoFKjRq9tO6LN6/yXiOdT2rXq2NqIlPLBoGQ==
X-Received: by 2002:a05:600c:4692:b0:426:5196:c8dc with SMTP id 5b1f17b1804b1-4265196c973mr6450895e9.39.1720166346234;
        Fri, 05 Jul 2024 00:59:06 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42651531f1fsm15315485e9.0.2024.07.05.00.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:59:05 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/6] misc: fastrpc: add missing MODULE_DESCRIPTION() macro
Date: Fri,  5 Jul 2024 08:58:57 +0100
Message-Id: <20240705075900.424100-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
References: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=O15qZdCPqj+aTpIHCNU5gY+gTtmu5dT/gYOiOPVz+lQ=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6fDan0+3BEHGWpfX/0vThaLh/4ay2/y02f/R /6Qh80jFOSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoenwwAKCRB6of1ZxzRV N/aiCACMYX9fgiGrigvGoeejAOBh+E4VTTipEQBYDBLUi+VwMU5yF5Y8+NgUpGTMLQ5XQCSVNai qMhepaZqv6Fvz0B5uAe4HwFV0LcleRemvCvNIDUS0fjl6EZeV2ohKhQDP4pKwnXy8WtLJnA5s1Q Hefo+sUBot8mPKSKg/h2V7TdylzCWjZBAgfSzHBVtjyoln7HEEu/+FxdfN3o6exxyWOmddrpvl1 ziOtXeOtEJpeysEVZD7INJvaVFt4cHPjpGNYkVHwT2RxgpRYr361ZRu9em8kJ6OOy8weIWF5pW5 E1GQaimFxi2cdmK1HL4HytpRM9VQbttEWz/7KdcKqdUCHxGh
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/misc/fastrpc.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 2653a193ff2f..5fb302b8ae5d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2473,5 +2473,6 @@ static void fastrpc_exit(void)
 }
 module_exit(fastrpc_exit);
 
+MODULE_DESCRIPTION("Qualcomm FastRPC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(DMA_BUF);
-- 
2.25.1


