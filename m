Return-Path: <linux-kernel+bounces-244313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC12692A28B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDED1C215D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA081751;
	Mon,  8 Jul 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/oWj3bK"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B0480046
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441382; cv=none; b=JROeZWu8vJkbpygvpJIrNUIyDcnyca/FGpghhr0k5GxcZkCip0kjYJGWngtaOrpJ+pEVgsTcqYI6qQqn/XxhBNWQmLSPpxWESLWL1jGazIVUmOjxBbWTrkZqcW7QUzCHaxAZsDeZtmSsF6T2poSohO6jm10vq0mtXHRtveJ7EkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441382; c=relaxed/simple;
	bh=zdfsoAzyLAbSewXaL8pr+o+HVHsk0A6l8l6d96EVyr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=biL+k1KwACgJuYObGE3dGMGx7xkQ6bU7at+Y+g+tFeGOwBqOhZf61t+UTfA0y1mp2VvUH93a66M0oBdJlTkH9Bc+8yayo/9wtk0dXwtX7wo160ss/OmmlEaFHvW7frrXS5D5V8eAupJI9QpBOpeNxwCHrmKx+g5bTluiewxWXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q/oWj3bK; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so53528251fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441378; x=1721046178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbLszSI/br9z0FG/eAMCh9e/nJJvaShjV+30v8TNl/U=;
        b=Q/oWj3bKCiKPckqHELh720Jig2MQETxY8RwxmOFm10uPs82rH00A/k+YI4TeXU9kuS
         jDWeWu847YZVv6gVXnOwQI2XfGm7u4XerevceId1DQQ9CdwsNVi9astNRA91/tT96+iR
         vs3pDXENd2g60yHKugLOqz3CktjXUfcU+k7jahFg0E8FX1ASxYkywahYyXdps1wKLoK5
         ID8J/DFtZ+DCxHNrKHScKExQjpgpjzALyuf9ZJ4ZX6rX+O4bch4QxWq9mJ9kXjhlFMik
         5QTB2NOEBrl9R5dry6/NEwJb+CSBMsztJEvox+TmkyxKPIfIvcG2mRM3A7qyqwtak9QY
         OS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441378; x=1721046178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbLszSI/br9z0FG/eAMCh9e/nJJvaShjV+30v8TNl/U=;
        b=usQNzjFtYwLrPgwKnWSYJLDEJ3qtgHdbOoPyumnbj7Rw6mdu92FlbENxPbQFizjHSn
         VA9vxkRJcmaA1LADg3ifSvt0PjySxLlVYD9utPWVDRMiR2yiEdEKOVrlLOT7Bmy3lv56
         egosgFwSK7G/pXlggN8ruv6WmIxisCx+rkh0il+Vi3Cr5/+D1RqBiC1qtdv/eeog7673
         LB+bU9ZL8435sKCtDsv97lBE7S4DUQpZC2k7su5dSiaUEBpi4tF/SpPqACysNbNQwUo1
         gbb0VD4DzBeIQCKjIeVqrYDCEeqXbTP/pWUh6ddEQhKOLU2VsQi7pFnoqQdETaXPy+p4
         T8UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwDdUunj/tCggNU9R1N+CmP3KtIYyzQsf3HPOW+2KAljMa2MPO42bjiynGLaQoEtOb5LEJiGqLcYmKlFssZEWK8ZS+TwqnH63w8jDh
X-Gm-Message-State: AOJu0YxhHCM3iBKjq1Ab3A4ON1bU8dQ7PSqD4/bT+nXUY4cQG7Oemz0W
	Sy8VWhhJ2uVeQIkaTyMKhoxFMXShXZKHguNSlnv8ko+pHnhK8kbXkjRIQWLrrA8=
X-Google-Smtp-Source: AGHT+IFn77trltQqWJUC7HwUwAV9/FoLFv40dOZn7MBfPPSTS8mslfo9giZi2I2GuxPjd5Q2CxipSw==
X-Received: by 2002:a2e:891a:0:b0:2ee:4a67:3d82 with SMTP id 38308e7fff4ca-2ee8eda7b6amr103735721fa.28.1720441377480;
        Mon, 08 Jul 2024 05:22:57 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e52ccf19sm208983666b.147.2024.07.08.05.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:22:57 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jul 2024 14:22:32 +0200
Subject: [PATCH v15 01/10] MAINTAINERS: Include new Qualcomm CPR drivers in
 the file list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-topic-cpr3h-v15-1-5bc8b8936489@linaro.org>
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
In-Reply-To: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720441372; l=1035;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=zdfsoAzyLAbSewXaL8pr+o+HVHsk0A6l8l6d96EVyr8=;
 b=LpwqLXpJhzhQfa8V5wMBtIxnsqOXE/ulRmNbkCS+oEfoVwQUK1E//z2KbxitZfkiSCZH8wb+x
 8M2euuAiPRACqG/MjCHRX/sPC9Xiys3gtAm9GuPfIP3GLvj6TvPw8fd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Expand the Qualcomm Core Power Reduction section to include the files
concerning CPR3+ support.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dcb37b635f2c..f3e013a52c16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18687,14 +18687,15 @@ F:	Documentation/accel/qaic/
 F:	drivers/accel/qaic/
 F:	include/uapi/drm/qaic_accel.h
 
-QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
+QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVERS
 M:	Bjorn Andersson <andersson@kernel.org>
 M:	Konrad Dybcio <konrad.dybcio@linaro.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
-F:	drivers/pmdomain/qcom/cpr.c
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
+F:	drivers/pmdomain/qcom/cpr*.c
 
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>

-- 
2.45.2


