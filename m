Return-Path: <linux-kernel+bounces-242033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293709282F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3CE1F246C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A9E145FE1;
	Fri,  5 Jul 2024 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7Rhy8rL"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6339145A0E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165280; cv=none; b=lk78B0cm6JtjDmtSq4ZRDcSU/RlRYBXUULlvgo2hOUWwSo44m3pFldU42CdRzA4LBsxeBZD6+hc+Bk9GEAScoV3XFUo2ZMvXcl8w+L+1XigQyT19CFrPAJwNZ8ltDNg81PElflODRqRouUlBChzJ8aJP1p3tHGQEIl4YDKYClQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165280; c=relaxed/simple;
	bh=3gDLIAYz181HJf9x7NRIIfS45OFCw170AEfBrtmppso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G0HpNBx3qmInX/qSrInvqtUPhsdnej13djDMsW6sPdHwDaws9ba4XcC27r6J5Mes8ox4iCnnlUU/wXW0pwtms769doJktOTv68VH555jr8pugHWnpkfWknoP2tcsvJ+o4PysRYE+X7djhVTNgoK2ZZpnfeEOLWvkd0ezuEMoVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b7Rhy8rL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42562e4b5d1so9222385e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165277; x=1720770077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkPsMuaXUEzhAdmrj0v8DKrJWfFPcAx0F2jdkDpzpDU=;
        b=b7Rhy8rLnZpqflpfmObGi78/Vgz6eocVAgf9uC57skliRbmE/Jtts0k1Lf6qoeLZTw
         tl/dQMf3yUa7osfQ7xQnoN01Y6eRYUha632YbitXxr6phVbwwm3cqqmqFK/1IZEpX9PY
         KI6TzIEDkeKcBI+edOzVWAC6zN5kILHy2rbAmmw7VbAXCJyd5vMuSWYwceVi6UpAe3rO
         Uk0++tWeCLmpPtPxwFnCio62dqHnQ1FeTq9H84l+ljROc0RPTqtvZb86YIj/n7BFQDuC
         +ZCV6nhRuR6+o4SKQwf33Yi8kzz8Pcu9BDpMkcpgmriEIWUlEwvPDmTmnNbGS4exeM8I
         UZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165277; x=1720770077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkPsMuaXUEzhAdmrj0v8DKrJWfFPcAx0F2jdkDpzpDU=;
        b=Ie3HrVXVuEZ6cGQOqRI0kb+eoEqqUqiF1RlnSAh6RGwk8vQMd/l96tyY9HiBoqoGnp
         o7MG/3lRw2bmOM68zhMIsadH2cUPbGIMac3Mi4rD9yhYk69WiZi2vMR+FsLKguHfA3t7
         PLiJsSvEQh22co0FnYFijC2SGevvqeSZQ8WvGcf0H9mYGo/p5f6MSLA+rpDmrMMfCe5N
         RJJjQv0XnHxejid02Qdxz82zZjQwgftawl+cy2bEEWhrGbFTm55SiNVK1y3dPd/gNKBQ
         IWTvXm7bSqIbTfddSlKb/QUcWwv5KVj16LZ8wV3g9gl4g7puWvmgnUtqJGbMUR4+Uzj0
         KyJg==
X-Gm-Message-State: AOJu0YywzzUMkVKx7p41GvJ9R0LTGjhPcNqU53+ufuyYR16dR61lRHv+
	8NseZv7Y8ZaMR7SIvw13rqTrKEfjNJB5DwZCWyL7MvUD/r8Ht3Y/AzpqhMrx5iI=
X-Google-Smtp-Source: AGHT+IGOT4TYEhuKfDLo8AejaVVrYDXH5v8uuyURwHZ7qvZHIs36NFuEmwyrNoYYOvzb0zdAr9e0rA==
X-Received: by 2002:a05:600c:2e49:b0:426:549b:dd7a with SMTP id 5b1f17b1804b1-426549bdda8mr4738915e9.36.1720165277206;
        Fri, 05 Jul 2024 00:41:17 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm50837455e9.10.2024.07.05.00.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:41:15 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/6] misc: fastrpc: add missing MODULE_DESCRIPTION() macro
Date: Fri,  5 Jul 2024 08:40:42 +0100
Message-Id: <20240705074045.418836-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
References: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=O15qZdCPqj+aTpIHCNU5gY+gTtmu5dT/gYOiOPVz+lQ=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6N9an0+3BEHGWpfX/0vThaLh/4ay2/y02f/R /6Qh80jFOSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoejfQAKCRB6of1ZxzRV NzNKB/47cPjdWNCYn7TUw0cwLJ09l6ZJOXLSMs0a615sQlWVZ9b/QI1J7Gf/3/peIud6zMGbqfX BIiIRM63CfxtJxJtbZA/fuwBxdS1MyrHV9MV8x9xmtxpPsr6x4L+RvbDjtDWmS/Mitre99FetQS unVrIbV3p1vu3Qf33qbg102+tROrxmNSJ8g5w5DToSZG0PD8HleupBWFMfasnjCufeRWL9zEHiT nqHeSFFk+n08b1+IEqpSUjKknkGHzYBDCXnKEFSEveRGNwOU3MsaRHS4g65DajpgTVWJJjV6WON R9RBuLVLTTnH0Xd2NnQci9XBBbWIztgA4C8K1OM1s5LihJP9
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


