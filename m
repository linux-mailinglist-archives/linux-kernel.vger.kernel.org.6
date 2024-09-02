Return-Path: <linux-kernel+bounces-311486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0043B9689BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0291C22AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C3D19F13C;
	Mon,  2 Sep 2024 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMFupZhm"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F419E984
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286716; cv=none; b=APSkDiZnVfoHPB4WfAYYoQ1Gydtj21H2D00DFq2aQ1QVuSDZM4F8c77J86Bjn20MYhiFcXcWRyDbZmwe6EXBtSVuQv3t6ZXmgThjwn2qbYat7YI1JgJShUblDKsYmo5hwXD2LNAQthmqsYCTF068LBn2uaUBG1IdCLDWTyaFRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286716; c=relaxed/simple;
	bh=Ed2NYm0sAeumzMPPfwLUWpZzgcnOmKPoqeUNG7R82KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5kbDkApL1fTPQOmLyQvUL6ZkouBNSKnqBKKPBiD/EkERNl5a6kwSmFCU+fQHR/mVeFQWaXTZMTzVSQUIE2oZWDKsXlv3oiczZnSmuUHRyN8SNaViBdG9oh/OMX0oYEITlv3SRdffmh9l3HN8mEFFoDhJgbyayWyLuWWmCYMWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YMFupZhm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5334adf7249so5550357e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725286713; x=1725891513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyYCfnng5oSzPa/c9vFB7jl/J0cPzntLj2KjUDlaSZg=;
        b=YMFupZhmdBlv4IVuXh+8baH4Y209NNxJE5SFx/v1Ygoa9d17bIAn6Ad0OMyYRUrEc8
         2EktReHuHY0baY6vJ7IS8kvCzGKSyl1iQtQ2C484Cf/jmWRGWQbfSt1as1djVYDt5/f0
         hoDAiXx+skqKIqNn0AgVfOL2r6nCmTlxJhj2bic4B582C6HTKgBuwMgv+pLrtiJdg+Iw
         TdDDj9r/9jv0E08RdsRdEBU/54nTra/sCVcD2+HTxkVCftFsi9VzsQx4wbqi+A5pd8sC
         XPcCS2D0dMmQx8rACWqbC9qxr11lo5T6/ax16Gf/dGylKEzpGPbeA7jAEVGVgdRn2lNj
         qodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286713; x=1725891513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyYCfnng5oSzPa/c9vFB7jl/J0cPzntLj2KjUDlaSZg=;
        b=VTxW7DV6Mr/WmE/Y8hGWONvGPoRWZ+tAcIaWXDJcg7AeyBaE7h57WKMFGyixdsDrQM
         mJCmGcLsOc0KJ5Uz5flwukeVo2NCSnfDVVvzHUpp0WFDLXJz24Ugq5iJulPK/Yv501lX
         RuDU20Bic65URFwcSzVA4Wra6sed/LAd+ZdTok5T/OKb1Olz2t8P6vDizcxxdGORFppy
         YzuyvVCGImibqFdUa1Izx0xhwwKrzbDrBrkrJsznhQelBOFQeF4+xaDo8No9QrInQ9e/
         LWwl4Ks+QaBRWhvv/kOoDKpvsOlVuv4gNleqDPBx3O0QV80G2qey2OL2YKdXbSjkDP9g
         O8yQ==
X-Gm-Message-State: AOJu0YyyMxoj0qdV7kHWuSqOOVy/OntFAKxXGZlVBimP839BdjLseY2W
	URRmHwsv9kREuv0bycDyZAWGa9np1E1SzjIK4u/gLybCbwoWE1hZNYGV6Vi9sr0T2j6s7Yp4iJ2
	/
X-Google-Smtp-Source: AGHT+IFyPU2TkQsvKhl/VXICK+LssV+P/G5tERJfpK/e87zpkAPJW1E8G/CVdPlnhcupwIHPOE7COA==
X-Received: by 2002:a05:6512:10d6:b0:52e:73a2:4415 with SMTP id 2adb3069b0e04-53546b91ea0mr6566072e87.46.1725286713256;
        Mon, 02 Sep 2024 07:18:33 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891966f2sm566000666b.101.2024.09.02.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:18:32 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] dt-bindings: misc: qcom,fastrpc: document new domain ID
Date: Mon,  2 Sep 2024 15:18:21 +0100
Message-Id: <20240902141821.70656-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902141821.70656-1-srinivas.kandagatla@linaro.org>
References: <20240902141821.70656-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add "cdsp1" as the new supported label for the CDSP1 fastrpc domain.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index f52931c0035a..0840a3d92513 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -26,6 +26,7 @@ properties:
       - mdsp
       - sdsp
       - cdsp
+      - cdsp1
 
   memory-region:
     maxItems: 1
-- 
2.25.1


