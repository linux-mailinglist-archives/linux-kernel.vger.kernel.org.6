Return-Path: <linux-kernel+bounces-518058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A12CA38937
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA7316989A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDC0225A5B;
	Mon, 17 Feb 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7h8Rr4K"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7C224AFF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810013; cv=none; b=pDl+zplHEVMRcsmLQsB1hrRyqjrCjt++BBCcl2hnNs5ca9XomnGi29poRxghdSDlN7ZI/EmVLIgYc4UwPRgkJhaOKamwx8Q75hToH2AMR3B6clLLmK3Yh0h2li5JQvw6auJQzdrhihBuHeuxrNJCKe1dWnc2tGASQ6Bv2IMELrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810013; c=relaxed/simple;
	bh=0XD7+/ryaoEOL2/PLVXesBusDcDdPYKow+QRoKKCGik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hvansqkr1gV1feiV0VRBjNKZlX1auRZwMjAF/4YYhRv3bn9wJ4RE+1S9SvpbwomMUP51rA7uMpCCH7TRl/jb0WC7IDZyqFnNBiMcnHD7lt000vFKKtIgxje9BltSeMwpcVn2oEn/tdATgKi2oHmQSZcwhSoUO/+K587v2kKcNps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S7h8Rr4K; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30227c56b11so47755391fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810010; x=1740414810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAy9TG0v6l4FLNJwlf0af/AH1u4t70IBVqQ4T8QxeEI=;
        b=S7h8Rr4KCShoDJYlJDhR3F1nXRzNINa5QLHEs0d7wbYbCif+iML9ORFigBc2n3TNNK
         6JPZAyzenv5G0EVW8Z30yrMwcPFAdaazNU/UqDOkJ9O5dEeQ+m9gq10FyLNEXEIvDkx3
         4NgtFECyIDUrAXdo6Aa8aw4wwms8VjZ9pl040N6TZum5fnZ8Q8cdE0O11BU9dGZjH1PD
         gIbhtRkjJTvxHqHtP0AGrIRRaABMeTSf+XnrWumhfeM4BFZ94gHpI5nFdkppn6yLPAw4
         H23RIMJhmmnwVFXlwqt2XrF6HSGKmdjNaarsVqPDT+CtUZoF+UEC0wQrYxH/KugtDCYj
         HJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810010; x=1740414810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAy9TG0v6l4FLNJwlf0af/AH1u4t70IBVqQ4T8QxeEI=;
        b=hlx6nNb6duBRqUN2/W4HCGxV6q56iXSCg07BAjjzY/kP+vcdNiC4rk/1tiLIY1NOiq
         3clq3ZTwtIB2yFFrs0FlrKMVZ9xkUmMHlDvu71DpcwJEoxOjG4czVjwKh+AIc5COymyE
         yidBSmrkBqOcxLS1+srkllukak1+46P51s2LbsVdtYiy0NGdaiPTlcXWpi8kFAGPdqc2
         2vRbdG/pD00N7MoGc2hx8SDOP8P2GR+N3Wx1g4OriBNd/242R7oG3GslYQlNBVxxT4Q6
         TjGnd5qaRlhCI/ZqF/MOw8K28uTuzx+/iakN75tWvNP+DyKV1Sgmwj/E36UFhDc6qOxI
         fdsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBXvzXGX95V+KP3kedXJ2XZ2NnMDcQtpwX66c8gHE6+eWuhoKL9/boNUe40EaZAHI5VhPQuIRdSw0GqdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBuv3GNKQ+xJvFKpnX1PevQf1YGZsxbxoTLQrzXnHRD+LySYQJ
	Da1OqQBthLzjaGyH4LZ/o2ZK7vQxnNhICtBcYYtBQ045zoGLsVyvYRESbcq8WJg=
X-Gm-Gg: ASbGnctsj2PWRtguPDxEEV5Iyss2brZP/VapC1HcC3TAvHBTONKRzvygyS0B9jYBjYD
	UE8BbBtC9jKvnN3xvQtwHccymDzqgwcCbchfaZce9iLe8XY0DGkGciwgpJ0yEGRtDj4x0VLVj35
	rmMqc/Cj1DPQF0hKpJcFBB847N615Uyg3jnoIRft2BN8HhRoiyJ0NFjF51AYpAHooOI1a7XLDNq
	zmWWNWKTnrkBHLWW4gLzag+y7U3R5TKO28l0FXkVbEIcgz5UOU5O1VqrqsAbQEOt7nh+JRxU2Ta
	rUQlVG2lNHYUgGzoklDNHZb96eLbthAhYktPsbGyM93kCBWemDA+imOfHDM=
X-Google-Smtp-Source: AGHT+IHiq9PuuJ+NOS7eZn9UJDLiKjkTzwyRcaP3eSMUdPRvN1Clv7YRbUIctRiOnPscrcaGuXmWww==
X-Received: by 2002:a2e:b60e:0:b0:308:efa4:d27f with SMTP id 38308e7fff4ca-30927a3a080mr25850881fa.2.1739810010064;
        Mon, 17 Feb 2025 08:33:30 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2cef18d1sm5695991fa.76.2025.02.17.08.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:33:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 17 Feb 2025 18:33:20 +0200
Subject: [PATCH v5 3/5] nvmem: core: verify cell's raw_len
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sar2130p-nvmem-v5-3-2f01049d1eea@linaro.org>
References: <20250217-sar2130p-nvmem-v5-0-2f01049d1eea@linaro.org>
In-Reply-To: <20250217-sar2130p-nvmem-v5-0-2f01049d1eea@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=930;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0XD7+/ryaoEOL2/PLVXesBusDcDdPYKow+QRoKKCGik=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBns2TROqWI2Cy8bx4H2e4ziVOKG+oW/OdquTDiZ
 PW4OdMlSKuJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7Nk0QAKCRAU23LtvoBl
 uDpeEAC2iiHzZ7+R1fTC8f7h/AOTDlSKIYeW4mWCYZePBY2i7nJreBcYXKXgxs3EKwNd1lVsVvS
 wx70lZJEwfNPHunMDgNMBIls1y8CAuPWr1KIvMK3xO7BGl0G054va9THDA+G3FoomIuOL3PRclE
 fltAE/MMV4+JRQ9JK/NAcaPlb/ccuFVaogdzyGImA7qTKeNnaxdmj0rEr2Q6J1kz+ffxoL489m3
 K+4Xj4e8pFBkFsC1C7WXFygIvRn8Hkr3EatMOMVRZjdUDDwjvshw8dGJRJQUR5ypMROK76hTV6T
 66jMV6caQKTpt9maegcnarhMAHxtyZnT8HrspjL0k8JVHV6E50csxeNH9WFEdz5iXsOE8WiRYZP
 4dOWl7hOrgdhwgjCo/Lfs439nCBSol1TAO4BWB34K+Z+9Y0BntEAoDcbzdWIwd7nvvqFVKX9kmM
 lhFZ9WjmyuheiMHXyACqw6WURDUCMh+ETUGEUO7swuq4eW5HFqMaCE/Uxeqygzm4p///fTN03oL
 2wCNFPGYBP/keIHyvrZHsH83fUaPQrQSiiQ2QPNv4jdQT3EJz46Ld+xm3addQPl94+UGbrDlX63
 eE6GjbSb0gfBA/S9LEBFCEeNTZJjle3raCd+YavOTf1Rmkg3+y6QvuuMBGS/QQbkEVgUb59YMxM
 CfuJDc8N1FHGqMw==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Check that the NVMEM cell's raw_len is a aligned to word_size. Otherwise
Otherwise drivers might face incomplete read while accessing the last
part of the NVMEM cell.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/nvmem/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7872903c08a112f11618a5aa6a42ba505106ef6d..ad9b716e8123537fb5fcef724a684e6db3c1de8e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -605,6 +605,14 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 		return -EINVAL;
 	}
 
+	if (!IS_ALIGNED(cell->raw_len, nvmem->word_size)) {
+		dev_err(&nvmem->dev,
+			"cell %s raw len %zd unaligned to nvmem word size %d\n",
+			cell->name ?: "<unknown>", cell->raw_len,
+			nvmem->word_size);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 

-- 
2.39.5


