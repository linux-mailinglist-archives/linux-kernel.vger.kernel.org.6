Return-Path: <linux-kernel+bounces-190114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE9A8CF9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8111C20D14
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACB817BA9;
	Mon, 27 May 2024 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zt5MFyhU"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E81426C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716793333; cv=none; b=ehQvf72K2oCV4irzyyXksMZqXl9YIIbgnRCALv+HjtRD9ia4F+7RzkyTUAXl1jDNPUdvvbIWI/7nK9RpXYaGO0TKCiukhc64Vj9/xvi316cHpynFS7rU1+DnVjawta6Irds4A6aH0iBWpxDZvtQjjludqTPIh3GtIPcdywRDidw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716793333; c=relaxed/simple;
	bh=1tn4S0+loovF4zyHvHYFI5Fo+i+d3bhTurXjsvL5onY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZAe8nYrW1XOLfJ7JPqGk9QCSJ68OfuQTNUpMZmkulJKmwgyiTVL1dS1Co9HQfTXN/g5e9ohOjm7CTXT5rQtwxUe9lTQOcvlq5+uU/5vs4+8R1f+yeH2ZnY/o+bQUD9L9nNv2lic3CldmvwIvrWOnWfksM6aml3+KEawmaib/HJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zt5MFyhU; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so54963211fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716793329; x=1717398129; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6H+U8glfYQ/SUJ1iWIPZmuXoEeAsgiGGGO6vnmqj2zc=;
        b=Zt5MFyhUy3XVjV+s3/83ribC4iJKkGfDP5i+Foxz9nAf+L0c0utTAYM2LGyV4OWIeK
         yKbpGZ+hifAJQ6hBHqdOULdYyq0Ul5UxDL3oTN0XTNasGOUvLqw07gU+xcKZSAJvIper
         l8ftKP4QF3G4SiBHLpFsz9yBA7iCsWR88irvRVLmmYNRLXiAGNQdF2gXL7Ljjj2UyqES
         h6opsV2hhNMZvTr/kx8ZVwb4fTR/O3/gbqM3Bu0nVp+Goj2xn+TXojXDpJ9eFXtxHbi8
         HtIFplB++S/V1ItodY0GIKEq0gAgR2sEJ8F+kvjVzYmHGxdtvtiwobLvsAbfK1iaFJfr
         uSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716793329; x=1717398129;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6H+U8glfYQ/SUJ1iWIPZmuXoEeAsgiGGGO6vnmqj2zc=;
        b=LCd5aZOd4TGRIt09fVFkSk6X/6wkSBlziQIThEYQjjTxiTmfqImnWqK/qMv3pS1cGU
         zPzTfufqc98jqsBKA6OcvluIJGgPw+goVjCBoI45Gr5Xl3zEDBomDBZZ4uf7v+QZO2Wf
         ik+4B/QsVqsIGSRQu7oIn5aF+mRKqRBwfdj783aFH7Owf3KNpYSHK7QTAl3uBGu0e35/
         UHPTWAn/UFIEQd53NuvfAC96JtAOXNHTmoPelgAfiBk2KxeimSw9MCJ6ypTTqqpdDjvh
         QsaSNVSsbmeE3sJZ45HWX/jRJBOqZoOFvgi5wrwGjhmIB4fIaJ/Dv733QIg3ANy96z66
         joEg==
X-Forwarded-Encrypted: i=1; AJvYcCWq+cm0Gp6UpVBD5exva3M7bGj+Tjn/b4hgfRB0ljiKgjIkXbyTQcCsiEe6DU8Xiye0JRYATT4tvycEXa/7MJVv/mqtNbCNXhBiTigQ
X-Gm-Message-State: AOJu0Yz+5YNGqr+egZPrL61mU2AAjn7RFKjLOFH93jNBCk2t6jjA4o7T
	e9jloSCwv6hlN1nwUsdAlDY4dUwT6fSfTgfOdz73bWK5jd0RVElGgAkxfhTnOqFUKDic31Qt7Q6
	u
X-Google-Smtp-Source: AGHT+IEpYgczhYiz3yWqQP7ltRSMM8yA5cKl8KSs2ZlWbMEFNN47xHjR7QGPRJYGQE/7o/yl0Y/rhw==
X-Received: by 2002:a2e:b385:0:b0:2e6:be3c:9d4d with SMTP id 38308e7fff4ca-2e95b096b68mr68862021fa.12.1716793329320;
        Mon, 27 May 2024 00:02:09 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c81773bsm458766166b.30.2024.05.27.00.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:02:08 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 27 May 2024 10:02:03 +0300
Subject: [PATCH] dt-bindings: mfd: qcom-spmi-pmic: Document SMB2360 PMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-smb2360-bindings-mfd-qcom-spmi-pmic-v1-1-31a2c051529c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOovVGYC/x2NMQ6DMAwAv4I811LiBlr6FdSBJAY8JEAsISTE3
 xt1uOGWuwuUi7DCp7mg8CEqa65iHw2EZcwzo8TqQIacaYlQk6dnZ9BLjpJnxTRF3MOaULckWAn
 46tg6249v5zzU0lZ4kvN/Gb73/QMTZNfNdQAAAA==
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=1tn4S0+loovF4zyHvHYFI5Fo+i+d3bhTurXjsvL5onY=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmVC/s3WW2aTtyZ9RyAvCg8nArYgSbFCWc58g9Q
 1fCZ2/eGpCJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZlQv7AAKCRAbX0TJAJUV
 VkvWD/99yYgaZcXcxcolIcNOKw7WyyglxbhIBo3jU+BqvLIhgOBsvCRaQ24N3yBWZXYjNYwdJg2
 stcyrwQc/rihq/8VpXNsMA8EGBc+Qh/pWzstKRJqzyFqz6K5XIa79PDqvH7AARHgnbQs64iAc9b
 +4VG7lqDg9LVEp/qySuZQ1XAGK3ODCzvwfcs//8znypQdOBpOhdPXsQyMPdNvG9UjwTye5LQc6V
 7uhJWCjSxV7fLB3uNp9S/RGoObsD5wIB9Lw2ibDBjwgg7R+SGG4pn4p36GW+f1zwn4zIbb2dlk7
 CJv6gpLii8j9xyNkuIxn81ePAJaGyos5PlSyATF51c5TBR89qFj993/OE1pp2iqEgLjkhxUtQWo
 P6knCfBTopyqv3mErmr8VojdVXPnSl7pwNSryKrMpbiLFMVxrxgLish7ps53BHPXD3RN97wTVBJ
 fYqYbG5i8ZSI25nTnf6KtDuEhEk2AzODGOSEENzVgoldoQ+gx0aXzzUMTgmCz2D/vq+Ojezkudq
 X1bX/5zOtbryWfyUMo6fy1SPz3AK6uqyvwQp21W7bnyCRu16ZC3qahuM9jB1P+Mj+LdNYdJ6KtG
 yHZmBVTCPKHAe0haM8fChyYy6yZQ3OuzjTYbYeOeC+MaUDGx8k9ZbqD5ENolzCM+KqEQbd6IqTq
 LJ0EPncbYJ4TsPA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add bindings for SMB2360 PMIC. This PMIC is found in boards like
X1 Elite CRD and QCP.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index b7f01cbb8fff..72e4462473ea 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -95,6 +95,7 @@ properties:
           - qcom,pmx65
           - qcom,pmx75
           - qcom,smb2351
+          - qcom,smb2360
       - const: qcom,spmi-pmic
 
   reg:

---
base-commit: 3689b0ef08b70e4e03b82ebd37730a03a672853a
change-id: 20240522-smb2360-bindings-mfd-qcom-spmi-pmic-76e1419a844b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


