Return-Path: <linux-kernel+bounces-551718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5CDA56FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88811891C1A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F070A243969;
	Fri,  7 Mar 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhgUvbWs"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE7242912
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370278; cv=none; b=pHHmdXL8r+jk+dMRd2K/Kj2T0m2cNioLmbqDhtaU1wrc7Mo9Z3AY3Z9EVaGnQ2LoAK0gxyptzwyUFvpnr6BjQkzs/G/TKsfyGt8yEfGlTyfK6YEE/S+rjIOGuoqYeRNYSfP5UDFmjY3Y9dPWLweXOupSktibaSwRytgzQIn6x+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370278; c=relaxed/simple;
	bh=7MXpC1UsPTFkEH6w3Dr3IjWHrLN92YVeJc/OuOPJTDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jp3DgFsowMlEda207WL1G4gk1U1YBVxLulqywMkpEeYFf1omJJNfM/vppXNTXVX0qAP35vPYleYaBU0zp18E+IJx1jQfUxA/dlDd2kCljB4N2pXrxuQwc198LcuhBmlLeJW0q+EHxd+VOTj0+Cva2AV63Pj9qNV5CTpgxqQQEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uhgUvbWs; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso3410708a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370275; x=1741975075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0Dr+cnFlbJ+1l2BNrPM33eKwGXGKx+rxyRsMaRmDtw=;
        b=uhgUvbWstCvkWtJdq5n1XpBLGaS8RnlpnUwcdf5UrbFZ2ljZwnon5m/Bw8jSIU+GLS
         VJJvMlnD7BTH0bLmy9w7UpRsr/CwpBgYXrVey49argJzBcrNgQuRqg9IEp089c8KfAEq
         tz3kUjW+9oe10kdsAvOsbvPKk/6k7L1DGuoaBiAMTw6NY28Kum2Ye1PO3Sss+cMEt+EH
         5c0slJJBo/gWopvXrEZIULL3D/GsMpAGFjuSmMNn1k2Gf4W2yQYW1UwOOQcieEIleIV2
         AjoOy9+gWitT2XHL4f2VtR6r5MTfmnW4lRdQoKswzp6pccowso8rPoKGEp1xtWdxvg3W
         6FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370275; x=1741975075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0Dr+cnFlbJ+1l2BNrPM33eKwGXGKx+rxyRsMaRmDtw=;
        b=fddElG9xDUkVDxO+h7jc1XR/pQIZae8ZykhsA85lm1e6rR4xkOqv+GrZCP3ETdvNJE
         vsoGoEhV3Eoxv5oPKSFOscjNKVRP/9jp1EU2+4gl4NnRbe73VY9uW4uRKzfwisJsXLYK
         GEGSW7QYfdMKXHKsadCmXH+ilx74o6r8GUXQciL+95irJKa74/dqxX1PBuKQov/FfG7y
         v1lkV0BJr3RqYDxLDjjAxkGYDeJbF3fpM+pDHeE3nHbjC9x+cdGDcNSZccslfypFtpVS
         pfytvhNQ/7x6CKQ/baoAatdCY/7jWx4S+zzdJAHj0fOR5ZCud71P8xOIOQpGcysRmZgw
         OEUA==
X-Gm-Message-State: AOJu0Yz+WcQ6Fjq0qfypZe/1Did4KHbzSZBxrmYvd4qH/l2MX5kKPMqR
	0FAXBucH8Ac8V1qswqLKHq54Nk9qpkdijnZO3kQYO5bDRLu01OCKQN4qRzwUNq8=
X-Gm-Gg: ASbGncsPqupJfWmttnZiim7Z5jDZHDn1Kisydi9EQJzAKM0IKXE9agvwAJkNxYl4/8I
	Yubehs7wwwpD0kooUFv+j1IdqOVkTbx0Lf31OC8C1WC0kQPpifR5HOIUvOrLBGNBw0ojLXbsIHl
	Ow0JJUI2+K0pm+YP0Iwk0DdreX0Hl9AVOio+02jid3aDO4zgxYgEYURyoB7YcdPyvglW3DCRAFu
	P4AwSLrjVVTsoCA8EKzl8JILmaH5IjafAeDcClc6RwBkpdgIW/CMXqEWOdVCbrqnoZeuze+o7UP
	QrRA+5LoLMac6Qhez8yxoC5ReupYz2YK2MceOM3Ar0JC7sOXFSlJwiEyoaBNWKLimOEbZA==
X-Google-Smtp-Source: AGHT+IHFp4nbwmJRO9CLZioj8tyZNhupbZ5qZBegmXKSPPnC3mYxgAuy3X08t2bB1+aCUJ/dEGz+mg==
X-Received: by 2002:a05:6402:13d3:b0:5e5:dea5:3eb0 with SMTP id 4fb4d7f45d1cf-5e5e22bf61bmr5310824a12.7.1741370274801;
        Fri, 07 Mar 2025 09:57:54 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:57:53 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/14] dt-bindings: nvmem: qfprom: Add X1E80100 compatible
Date: Fri,  7 Mar 2025 17:57:15 +0000
Message-Id: <20250307175724.15068-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=zQ+XDU22w1KeN1u2R0sBn32K6zj/nRUuBnAFl5n+VVw=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN9h90iMu8k4UWTZMM/77qH5t4+r/N3S94Id NPORNO+EZKJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfQAKCRB6of1ZxzRV N6pkCACxVQxClUHQfD7e9tvH83k6Eotby31WPKyZSjdS3bdBmtIybPlT52De7kArAPUYP7PmpYv KB9lA/lLABI2G0uruL7OUmBiwacvPaIjI3cPQ/GwONCeBvl7ENMMxEXp8sPupyNoCyW4Nx5oQiG f0FLwThnWebjCukqlnEn+pPMgpGvSowH/akKubiINVFhfVBscxnkwpVkqkjhjrNpn5J/MqF3rBt JezmGn+dk2L76oPjZs8pTxc6fc9X3DeJD3THI4OQs2j2tX2+n5whmurVoJYDvQaYumVxPhQdCry 2G9ihzWCmCX1Sf4psit2CQvveHLPrcRVTZhVMusRtIznpogg
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Akhil P Oommen <quic_akhilpo@quicinc.com>

Document compatible string for the QFPROM on X1E80100 platform.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index d37f544ab8aa..a85f817b015d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -50,6 +50,7 @@ properties:
           - qcom,sm8450-qfprom
           - qcom,sm8550-qfprom
           - qcom,sm8650-qfprom
+          - qcom,x1e80100-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.25.1


