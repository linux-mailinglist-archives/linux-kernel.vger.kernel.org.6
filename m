Return-Path: <linux-kernel+bounces-548497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BA1A545A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDF21895D80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49352080FB;
	Thu,  6 Mar 2025 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTn1l9Jy"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B62080CD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251538; cv=none; b=uaKMgVPANM98n1Zm69DtNVx5OooJVqLxFiCOKx0cPPVv6C3Bs2PEo80ev9K7Wqeb/nC7d5iEbZ5MxS7bvdNJWwO62cGJWhmQhUthIyDZxRGijB6g5KtjWlU0muAb/1f13XH0Usyo/BH8bT7l6B1cLP0E85FhL+KRjnzT7RFTRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251538; c=relaxed/simple;
	bh=NWlL1nGttJYahk2Cib0CQslDOn2EQ4g8BSNR5s0Vy4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OI0JcJYbGqZKHLdrxEzcN8/v9PCrPre9CSIZbM7H6xdWqILRJgQDSWUKPtuSzEZR9Y2vn46unmjba9wx0IpqA760ZYu9VDM3sd4JNY5uSyOiyoikKwv2A2GU+uLjocFsm78KR18qO8weYQTcLTGj3dV5qs1VGIzbLQFOmjtL2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iTn1l9Jy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bbf159247so481145e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741251533; x=1741856333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OzaWip0h4cgnJEaNxzWkXQf8pOprxx1UV0JvZpTPUv4=;
        b=iTn1l9JywyFToOEZDB03xM+KZymFhEm1e3EKN2AN33XI7czuW8ZNPfc4sMThRptgyw
         fGQIoVb4aYH0EGIEz0Xw5nPfNFDEbbyoc5VzVl7MZ45voopn9GwOUNssn1atzQ0XU9qn
         0jjCNU441n275PY3Lf6A9YMIldYYp1XOiqZkWkXmiirzU32h8Irulwl1VWyQW/skMfKB
         PShn7+Nq7DGJM5y2roAjl5KlMwdM3SiNgfY+05+ZAPDrUK4Enc1IK2xQKn2cdxru+FlL
         jM6Pp6pVqTsqH0v9AHSxtIEEbeFqvr70aDMCPLSSO9JrlCvK4ZSviEEvIkzD8ayhYN9P
         93kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251533; x=1741856333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzaWip0h4cgnJEaNxzWkXQf8pOprxx1UV0JvZpTPUv4=;
        b=siAVqwUBdEw/F1It5jcSOCFJOXUyLiNzkNCoVOvIIJpJtbmvgseaujke/VDn1HZD8p
         yFkk3J3J5W85XIGuI+w6aSm8jmXG36evCfFII1vBow3DAAL7NP/VdTAqWTxRCgxSYdS0
         qtoysxetEe5SaLlpmV91zyEknCfrytfoE4QIUDoND1KsFaY5hwuGD/LBzmjb3YmnGf37
         KVdwU6brrtYrSedkHhez7oWw8CgeV2CU8Ofm4gA3Niw7OYKhv76tAHI4qMRk8E1h6J1t
         xPez7spZ7781jcIqoOHIOxtoD/DXnscyF1zPso7KmSO1LofJ69p/zHL0j0KnKG87+S+6
         6Fjw==
X-Forwarded-Encrypted: i=1; AJvYcCULX86AoARA5CXhgr3Rhw8GVsNbYXhTMFJCZS2Sna/euzEUJ8bzom0Dwwt5fuZv3ygKv6CcyhIkeS0K0jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJd7mYMbgxfj26CYa6//q6QLuXgfAoDyeVd8fLwQbKkKPA7m8/
	1+0PFvUQDSYticcVowSBQ6vj6IvyLzE5cR27h4SATX6n+VQhyrgpAEUaIMRWHpo=
X-Gm-Gg: ASbGncsW0aKoN6J7dylSKXA7Rcl9tMbiBJH2uajz9wPRCI1LvDUTkNZ4jWd9XHQl2WQ
	QGBfghlWNe5/OcgeFbnAlJ1sxKCzcpVsMVlzNMIa1O4LT22+jiO3E2KvWUDuxRe8P7XaKCL3JWL
	hDb81EJbpxpgfNhBUWpAD6TBAROJ5Fv1PvixlRNAt6YYVq2/u1E9cdRVnp8h+TTMxAhDqQqfuri
	p6rwlIwFZbKc/DtqVrdvEwroM3v2/ZuJCUgW4GQLJKliZWdA4F0rAPND7SGxdBml6PhClX6x1s0
	PUzQzLsAoNR2cAzckNCPi6Xt6ATAw9OFL5Z3FsZN+KQOOJmHbivb0+IUZiM=
X-Google-Smtp-Source: AGHT+IHVNtHxGr+nftjAhnUun25Kgv6DcFTFjM/EL36b0UMvE/mwNcZOxoyBOBbcisiK5cck01E7sQ==
X-Received: by 2002:a05:600c:1d90:b0:439:9a40:aa1a with SMTP id 5b1f17b1804b1-43bd2ad9d91mr19260025e9.6.1741251533219;
        Thu, 06 Mar 2025 00:58:53 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b046dsm13184405e9.5.2025.03.06.00.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:58:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: memory-controllers: samsung,exynos4210-srom: Enforce child props
Date: Thu,  6 Mar 2025 09:58:48 +0100
Message-ID: <20250306085849.32852-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Samsung Exynos SROM peripheral properties were moved from the device
schema to separate "peripheral-props" schema for child node, but the
device schema does not reference the new one.

Reference the peripheral-props schema so the child nodes will be
properly validated from the device schema.

Fixes: 67bf606fcf18 ("dt-bindings: memory-controllers: samsung,exynos4210-srom: Split out child node properties")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Fix for Rob's tree.
---
 .../devicetree/bindings/memory-controllers/exynos-srom.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
index 2267c5107d60..1578514ec58d 100644
--- a/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/exynos-srom.yaml
@@ -38,6 +38,7 @@ properties:
 patternProperties:
   "^.*@[0-3],[a-f0-9]+$":
     type: object
+    $ref: mc-peripheral-props.yaml#
     additionalProperties: true
 
     properties:
-- 
2.43.0


