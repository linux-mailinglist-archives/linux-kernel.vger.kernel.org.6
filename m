Return-Path: <linux-kernel+bounces-242051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4397B92831B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD1CB24FE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456EA146018;
	Fri,  5 Jul 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiOvX4CG"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017EC145B0B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165752; cv=none; b=P8U3tvZlcfFcGp6YGSj8eay1SuVMXKBwmUxm9brTJGATqCRQsAPPqpeDDrPE4aUZbZg1aBFzqDJSMwStKpoJXnQheFCfKYCsr3AxuJrmuG1sAEipOAhuf7jzWiJSqHBSAViJCraB6TDGoEdBoziBSC/0Y4pSuRiE4u9PBWR3ZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165752; c=relaxed/simple;
	bh=FyAYBlbrcTGqO5GM+LebuNnreF/NKOqfmmP7NPvHGxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HYP64A5MPusA6H44z1AS48cJz5L4LTTZnhYoqoTut62kGUNIqtUCmzLEexngRlREVxXBQDqYAcTyjSdQaCewQALo96O986hYIYh0lCVnZEfwXt+vmo5rAwbxQLHEKBD34rOPaZ7jV4HzNuZZAM+F0PIKfneecX/7MAVpKdHkZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RiOvX4CG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367818349a0so760880f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165749; x=1720770549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w76U7o697ndJNJeHAa6J4xQAFtjPJ8pMc99Og5Tk1f8=;
        b=RiOvX4CG7X/RjeXco1t6nr/dsqOVKXH+VnDtkTLJFDGgdsojcE7nn1J87QHJeRHflA
         Mq+R1pgJkehdQ5tCIyRUbb0cIKnafDz4qACeVhJ8sReIOCXMlTmqAAZShiYrZXH6ZFo4
         hUUAQwQ6U7D0z3mFJ5amKCFUCOLeeRFEsQOx8OzMLNXwex8yV7F/vcScp+uiqU2t3I5a
         SfDnoOHRSDwFOWzHMjXXi3lXAO59zGyqCYcutnJ/ny6PBNnZP+Go6Lt6F92ejcb54AJg
         bpallbTkiOOlMmHiv7+qOjAHDl4Rnm5vuWE4WNeeaKD0ULxxrqQS4v60Inlax+zHC5my
         nwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165749; x=1720770549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w76U7o697ndJNJeHAa6J4xQAFtjPJ8pMc99Og5Tk1f8=;
        b=DPX2l0mMtCGyc5PzABpMw1ApTxhrLrEEJ5/jka8zku5cjbBhM6bVgTcsH+hhl+KAM2
         cfXIzwLknNrl23M7xje5B1pyq/4XJM3CKW5SYhrTh36Hcazr0tBb2Y0bgRa4M1XdXJoa
         zvK+OvY+QsDwnExClpR3LHhn7Wd45Ck5tZW8fmV8YGFB20tr70YJQgU8dm3XQDiyCHCG
         03nBNk6S9vqiB1JMW/xOqzPurKYuza4pgxJYst56PKiWJ3qkehxXsdI2uVbF+rTAIilE
         lOjVPQSCEwkeTVwxACbTX4WhnyRD7DFZbPb3109iUBYd0qDgrCK1PNWcWouKvBdrMKD5
         Ay5g==
X-Gm-Message-State: AOJu0YzoSdcFmAKhcvgKftLOe74yJgS9M8BSheL9xaZROLfB6dpU1a4l
	Z6fEskD/9FH+Z3HxrnXRhUpkEOlLJL6F7PQmcadO/J+KNe7mkKj4gdWKB05qGIo=
X-Google-Smtp-Source: AGHT+IHFpDmsCaGV7oTrK00hOq09gb97uEwnhLljbf1OpeYYvzSbSUUwWbUzn3sobxqCk+h6AfxtcQ==
X-Received: by 2002:a5d:5906:0:b0:367:96a1:3c97 with SMTP id ffacd0b85a97d-3679dd66e4cmr2331254f8f.48.1720165749410;
        Fri, 05 Jul 2024 00:49:09 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:08 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/15] nvmem: rockchip-otp: set add_legacy_fixed_of_cells config option
Date: Fri,  5 Jul 2024 08:48:41 +0100
Message-Id: <20240705074852.423202-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
References: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The Rockchip OTP describes its layout via devicetree subnodes,
so set the appropriate property.

Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax fixed OF cells")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rockchip-otp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index cb9aa5428350..7107d68a2f8c 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -255,6 +255,7 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 static struct nvmem_config otp_config = {
 	.name = "rockchip-otp",
 	.owner = THIS_MODULE,
+	.add_legacy_fixed_of_cells = true,
 	.read_only = true,
 	.stride = 1,
 	.word_size = 1,
-- 
2.25.1


