Return-Path: <linux-kernel+bounces-263169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7593D205
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375381F2304F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06117A93C;
	Fri, 26 Jul 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcNbaqxE"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA817A582
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992725; cv=none; b=OsAlqeJ5X2oFF9IUErv2dP4+IHwz3otr55tDvKtSOdw18rbFlTsDtrlFGxXpMuSlrtwxQChMagpHI2uF3J7p+yYaq3s0QjHr2+QTSv7TIC3gZWVKkS1J1xtOM4P2tkccw18F+yX+PLs2XbtObin/IDZie89uhNvdR6Kqw3Ptmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992725; c=relaxed/simple;
	bh=ckCyUrhBgaUj/zbznCBeQ3fcpP9VdQ8U2iRFPANaIoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TWmIgNLsram4Ca+1todP35XNDpcD4A2wJ/Ho0725EbhtLiuFIUiFmWUD+NOd92YpJQQ7eUEoe6kv7bcmImUjv9a8BEMpNMNCtuPWJWQ5i7QKX+lK+Is7DR2aYk0EXVB+btefkHk5OmWUWARW84e8UeIaM5nkVcAJR7DCQOjblh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RcNbaqxE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a81bd549eso141659466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 04:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721992721; x=1722597521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RSSre3AYsx9Ck3+Gf7pgOKZ6yzR7bvdD8OyLOsFucA=;
        b=RcNbaqxE96dT6dUfpN/AmHwMUvGYabTuZapJPSaoDjuT1HF4TTeVQMhBkHKiUcSU+Q
         Kq68ZCSghMcj+pbzBNRB1RF3GcH9pr8jflXKsDHuo/ZEdAKkGi+0Nhl54QU5OecPQHca
         s2345mkGVXGpvnKIw+vNDPUHOqPgvRjfmQN8K6U3PTljXDt9SlC7D4TJiJKuvO5foc3p
         WhvAKL4Y06YqOdm+Ozloq5bscxFLl6hE005hMp0PdEreqIWyVPF/WZZNrn5/Sd1Wc99g
         oSDS3APN6Xt6STm8fxYomNqobWnPRoq4YBf5n6Ohl7axHJBL0p9B5RehON8MFJvq3yRX
         ec2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721992721; x=1722597521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RSSre3AYsx9Ck3+Gf7pgOKZ6yzR7bvdD8OyLOsFucA=;
        b=cLectQ76yG8jichOZ4+Km18C0any2ShjldlJQI36dCDeZyeMCOIThTGobG39+FO6sh
         lzTifQLk8Dbt54akvCGw25kVSWGk6KM9NTDZBdrtUyzC/9NuL+JoqZF1BmxUcWjmUBi4
         oILho7AxdEb5foDMaUJmmAmi9B0i1NjRoU3MddK1dfzTy0tddBW3bIGycd8gptuVpB1y
         iV2XuO2L39WufKGLs908njUvbrQX2DG3iupk0+LTaaUN+UzvC+j+H0QbWbCHumS8JTiH
         kO8QFpGOu8VDbpT8erE4yJctvN5V9O3+9dp9gGMh3gZnJhLS/3q4PkUctMjjjWiZpvhs
         flkg==
X-Forwarded-Encrypted: i=1; AJvYcCVycd5ht96QqRsaWDxuXgU7U+l9/Ra6A3mx70ucqLJicIlvpOaMG4Jv+dECukbkUCJG8Vr5T7kEGPQjc1yoqNL++jmsW3NmBQW4FOTC
X-Gm-Message-State: AOJu0Yx+HwehRZfSs0UshXplph0mICGZ/T26g1EbL8QaLaO9DoG5hTUc
	gBvvmVnSa0ot1ieZL17Bnn7pGydh5Adl9l3qcGTVihp6j2l/G8fIsYBUw+EVv78=
X-Google-Smtp-Source: AGHT+IGedxxg/izaM1e+VztqZWQWxkaWXqj8R3F912/FfkJgI46WkcgQ7+j+9WvvDIum0fdm0GHjIw==
X-Received: by 2002:a17:907:6d01:b0:a7a:a0c9:124e with SMTP id a640c23a62f3a-a7ac4daffe8mr483108366b.4.1721992720735;
        Fri, 26 Jul 2024 04:18:40 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab233aasm164703166b.8.2024.07.26.04.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:18:40 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Google-Original-From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 26 Jul 2024 13:18:23 +0200
Subject: [PATCH 1/3] mailmap: Add an entry for Konrad Dybcio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-topic-konrad_email-v1-1-f94665da2919@kernel.org>
References: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
In-Reply-To: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721992717; l=857;
 i=konradybcio@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ckCyUrhBgaUj/zbznCBeQ3fcpP9VdQ8U2iRFPANaIoI=;
 b=CNtGakN4VUWxmqa0J8qCXm3ryhK2xBygjVnd3sLEs1hjjigxFk6KXgVO8RguVUgvC2vrvozQN
 0TFoswoCFN/Bf5JR+kUjCYQ/6OyAUzfDbdzncCFa0m34zezBQ43DbYf
X-Developer-Key: i=konradybcio@kernel.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Map my old addresses.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index e51d76df75c2..d189c6424697 100644
--- a/.mailmap
+++ b/.mailmap
@@ -353,6 +353,8 @@ Kenneth Westfield <quic_kwestfie@quicinc.com> <kwestfie@codeaurora.org>
 Kiran Gunda <quic_kgunda@quicinc.com> <kgunda@codeaurora.org>
 Kirill Tkhai <tkhai@ya.ru> <ktkhai@virtuozzo.com>
 Kishon Vijay Abraham I <kishon@kernel.org> <kishon@ti.com>
+Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@linaro.org>
+Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@somainline.org>
 Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
 Koushik <raghavendra.koushik@neterion.com>

-- 
2.45.2


