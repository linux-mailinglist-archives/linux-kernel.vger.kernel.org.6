Return-Path: <linux-kernel+bounces-233811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02C491BDB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD1A1C22A48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B0215884F;
	Fri, 28 Jun 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDOdMVrc"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B501581FF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575181; cv=none; b=lZeGwLVeIG8936gozByLSIDFtRJqHUXlngGs9Rx2rhe6CywK/TNSq34G4VNklcz9BXsQotkN8+ZIHW1MSc3lqgQ9c7x5GImfyMaGOK/p6IgDh1xIYLxR+P9EUuLgL26wfbWALdkHfhgFeuRmKWaA+7zn7jeDdlwEFNoslymu80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575181; c=relaxed/simple;
	bh=8T2HsxEc3rlQEVkxbqa8/uR13uANxuY8M03QJt4E5W8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PY9QAQPUEk0BEiov35tcebvSrm/yITQ9lTHn6RAXPLrkkHc2rtMY51A0bM59yTQeEld9uCXwTu2Rjp6il0viTuAbCuqWO3NAuKVlzRr5CXpb2om2I/kzrGtaa4DiNJBfaZH2+IeyoaKCL59akiLHTQCvkBzkp9W8E8h2WV6pSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UDOdMVrc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso4405125e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719575178; x=1720179978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQHysEdsy93bM62CH5I1Dfy0jGOUqiM4lFaeQ8Tg4Hw=;
        b=UDOdMVrcp10KRzX0VJ1hj+5GFKZ/C9R+9uoH32FXtK7sHk95VxbVPrRd3krQVpZSYq
         EWnq0JHz/trC7HZHbwiAQLzPBdBrUWbFgQ5zL3KhrlG1SZxjjzh/lsODPccUFS+TltXv
         +SihqVGtKFsQtvyzhNbR9szAUNtaN5pok4aLI+Cw5+YOHrPmuUEKVf/Eigusr57u+cXh
         S+Wk/5YezNXk6xChlkmpAnipYodzVLHIQ9ybAzPJlib4P7ces5OlM4hQsWcmNFoh4J8m
         C2jc6Cy6Vq9I7o44OGOioOxxM6kMnBoLUB/TQFdDn59BGvuitY3DYNrGBYuRoeqR0Jqe
         saUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575178; x=1720179978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQHysEdsy93bM62CH5I1Dfy0jGOUqiM4lFaeQ8Tg4Hw=;
        b=Wa2Azx+U/+Uf8CGkP2OBXds+iUF3HXS3txjyxOTSK/YvTgA1unt4ciBH0qjA+Si1Dd
         NiBdODpxi9RwsvHaLrileI+f7D8vwcpTjd2yrx7DTwCfe6tIza/5OS9D/Ns4NEHi9UGn
         bOA2JUyWAu4UVaE2sJbpFE3dfs8heMIqlGBnPiZARag3D86Xm3BDnoLHjbxjPsqL18G1
         MXB0N6R7fh5IYPBsyxckj9mHXxRiw6P4B8OnP4zpquaD1y8WT/4yMEtcevo1Ytcu81oO
         BaZaVztw7uEMxtdazoRCmr1hQbRvRuLgD3xSi9hbaQLO2Keoa/7DCK4kyDDUMLZWayM9
         s6+A==
X-Gm-Message-State: AOJu0YyAaiC7XTCzrj+uZZi7H7P4OW2mPuCEjDbzuwxcko6nXA0hrTId
	03obXPOUzX9B3VFAeyoGAfcqnM+lA8/fKLGOxTTgoLq4OPzfwth4g7jJ23DZUWA=
X-Google-Smtp-Source: AGHT+IHwe/jQPkC8fWoEHmIctqYoLrTMAxpOK7lES0uUc0DLRll+BGVIUjfkLhokhIREvpH+P6XBMw==
X-Received: by 2002:a05:600c:12c5:b0:425:5fe5:f273 with SMTP id 5b1f17b1804b1-4255fe5f3d0mr50153915e9.26.1719575178736;
        Fri, 28 Jun 2024 04:46:18 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af389b3sm32721345e9.1.2024.06.28.04.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:46:17 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/6] misc: fastrpc: Copy the complete capability structure to user
Date: Fri, 28 Jun 2024 12:44:57 +0100
Message-Id: <20240628114501.14310-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=2dRGG+LCOSOerYGULNCCFlsN5B7XVPw8Os2Q9OTMxG0=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfqI9zkTQrg7h4q2xkPQJ1k/3FBer8WBikUxCL +Mq3pE3/TiJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6iPQAKCRB6of1ZxzRV N6e7B/0Vx1fSTePraR3H3TvBZ8oom5sysGNgZDl4LYT5CW2b+X/QWjvY4XIRDvGyNxvud4415Kz r79kpiKQJ8UdNqjUGiEqZikE7Qe0ueStkf0m3hJA9YyBxwAi3PpmR10zqMWakUct+muhDKvEbyo WDf416sYEn6FZbo/Z5QTOEoIBZhJ2jUUtR2Nq6+kVnHrQ9XIZWJSzbwH5HKUr7fKSJ0LtpOda2l 3WekMefHCShfRRqk6UobTixU9zT4NXayRY5KDv+fKIHjnUi0NozPiiB23mowddWTyBTt6ffjwYS s4iDjwZmwleVuxG6jKvya1MWsUCgpM+CHY/CZsqMmIWA5aXa
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

User is passing capability ioctl structure(argp) to get DSP
capabilities. This argp is copied to a local structure to get domain
and attribute_id information. After getting the capability, only
capability value is getting copied to user argp which will not be
useful if the use is trying to get the capability by checking the
capability member of fastrpc_ioctl_capability structure. Copy the
complete capability structure so that user can get the capability
value from the expected member of the structure.

Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 82ce4f58d70f..30b93012877f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1788,7 +1788,7 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 	if (err)
 		return err;
 
-	if (copy_to_user(argp, &cap.capability, sizeof(cap.capability)))
+	if (copy_to_user(argp, &cap, sizeof(cap)))
 		return -EFAULT;
 
 	return 0;
-- 
2.25.1


