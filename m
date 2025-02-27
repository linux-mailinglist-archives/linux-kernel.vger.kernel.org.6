Return-Path: <linux-kernel+bounces-535883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025D0A4787B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8AE188B285
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87352227B83;
	Thu, 27 Feb 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4aSWHuO"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3E15DBB3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646840; cv=none; b=WAad119nO9gH8V4CE0iBu7Feo685DXeMLQp5AnifnxJ5zYfACGc1RxOikWZ0YZxXKhlA2bHt8ZcyNDRfU9cgysfDozz0M6AWoUezQ9YS0uD2lbkyQBuSaWPuxyLJwtig1KvB9DACQGmdQr+kAI6VFGOWk/fIrMdWH+nDIzRmPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646840; c=relaxed/simple;
	bh=wLcIqSvKIjEPPXohXxqrzrzQz7/YJbG+gZ111fPnCuo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=McJiB8M3pZi9T9lRcsR1wio6wjbtAvjHtyJ/wa4iIXRzfw4aGveZzdIj/NpJWSPwJdUfq0aGiycc8uW/9Rl1YhF4kFI8qKXzNZ/RCINY1EVxF0OektJ/h9IwGd9Q2ueQjlNiBFsJxq9IC9VBJNJacpTv4Gb2n77tojf8GkYbPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4aSWHuO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so4471955e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740646837; x=1741251637; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ryfOT/9fnlUXs2jw9rNXfn6i7wfwlIdVEsz/YdDgxDU=;
        b=U4aSWHuOabKD7eT8tZd9sI7RXm6jFfDnZxHzuO3WUUWEXwITHfMOob+Q/DgwR9p1y2
         9h0mK0C/wjNlulxMePpQcTaBQ4tZTxTkGgkHhDkjEF9/LqcU7gUEeJrKkm9RoDgFWy57
         v/T6Y8oV6ZufLiRnW84Gjwgvk3xwLRzrAeFRl9ory/YabbSMbr9r1M2ZUNxt10WUhYl8
         2d3mYZLj+KwUWfuRG5Ge4iuEZfFsw/34B7FCSvRpWIfV5y093cDRasYPSE5eqUI+nW+2
         ItCocr97KKICZNmaR+MXM8IUDEaSrizPNUvIrzEHhu9zPzyG9ATMQGgoCO5Pw88bXbe1
         T8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646837; x=1741251637;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryfOT/9fnlUXs2jw9rNXfn6i7wfwlIdVEsz/YdDgxDU=;
        b=OYSniNyC7XaZcKSFxLL44nyrl9EUIGoPqY8BRnQVbP3D/akwWs3yGMH6cggXek5Hc3
         aHhHcLEc2tGjJ4QYm0nu0rWZTr8/W61KM0iH8XZUMfGovCDOqL8xePUuV/VBp6UAyCFL
         EDJucmeH+GB8wuG2223HiCC9D8fBn52cKEMjZxDmrUJxkanZcJTpjG+IWpznJqbMGSVC
         TYS4qSGhw/vaekGhQuiN7cJckmZbkkNNS/5EY7x0Mym7xDHR/tQc0sbUoSZPtlVrcmvT
         qaSVKxrs1lbooB3Nn0Oj5ywWev9ZxTK5ooUkQLhwqwQcxd3IHn6zibscsjtxq5jUTOlF
         GNMg==
X-Forwarded-Encrypted: i=1; AJvYcCUGAY1adIMJRVYWVzSUVIyUsLFYp5bL86MXXCodvcPDVKRAIFeftafNxie1/w2vrtISQRoa0JbZWBcXxqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf1N6BqqfUPRxXBjjT+OocYuj3mkH7kRHlfZVJm5SLjub04ebZ
	kT+SLbPDJreQSUVpP8osEEvPv1tNmYmPDfSaOavMuQiQ21kU39awH454HMhlrlk=
X-Gm-Gg: ASbGncuLXQOpDteK7gbn/PaSMJp0cho6ugf61CwMucsAHsawpQcNaf3TZk3SHMD8Cnn
	vORNjircw2MxLxPnNOIU1lwPjczaO5WuBvbQ8TJ4KD3a18bOZl4GF3Mw3WaGrzxnH7yHvbXAyXd
	AGdDlC8KTYWrIMKnj5yg06ShN6suVElfmHBKIC8UqWuN36HW2OoCjk6vAS2LwqB5E9vzBEJ7Hcs
	T42ZFyTnTD+nIv/5j3DXtHLCtMy5yCXOHw7YK8lrjvWMOHPdsgxkbVQzxrR+iz5ZIjR/xCU5/QH
	/1uTRKp+slzipqRcqbW+VfQsjL34gD2Y6Hi88Gv07Wn0q1Q=
X-Google-Smtp-Source: AGHT+IHievm8gWz45p5sNrOYMG1P+647wrNImmrzzm1mqySSQ11WrwVeQKf/Y/R6wOELf3fJMHEVxQ==
X-Received: by 2002:a05:600c:4507:b0:439:8e95:795b with SMTP id 5b1f17b1804b1-439aebf38b2mr216472595e9.31.1740646837192;
        Thu, 27 Feb 2025 01:00:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba57145esm47170715e9.30.2025.02.27.01.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:00:36 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/2] dt-bindings: display: qcom,sm8[56]50-mdss: properly
 document the interconnect paths
Date: Thu, 27 Feb 2025 10:00:31 +0100
Message-Id: <20250227-topic-sm8x50-mdss-interconnect-bindings-fix-v5-0-bf6233c6ebe5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK8pwGcC/6WSQW7DIBBFr2Kx7kSAje1EVdV7VF0AMyRINaRAr
 FRR7l7ibBJllXb5R+L9Lz1OLFPylNmmObFEs88+hhrUS8PsToctgceameRScckHKHHvLeRpPCo
 OE+YMPhRKNoZAtoDxAX3YZnD+CIjrQTkpW+SKVeI+UT0vbR+fNe98LjH9LOWzuFz/1jML4DAqa
 QT2mqjr37980CmuYtqyS9Es/wGXFe4GIc2Irq/PH+DtDVzw5+BthavOrnu9RmkG9wDvbuHtc/C
 uwlunubGdRGzHO/j5KiTR96FaL1crzOhMYOM0+bJp5n4lOkhWXORNlLNe/sOmeV32CKHu9xz2u
 STSE2ABb23NqAtd9ZDWoxGcpHbDzY63OuT8C1UUKraGAgAA
X-Change-ID: 20250207-topic-sm8x50-mdss-interconnect-bindings-fix-dd975f223d05
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wLcIqSvKIjEPPXohXxqrzrzQz7/YJbG+gZ111fPnCuo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnwCmzM5vdV3Yc+/5FKv/Q82r7E+LZ51TBaryd+Ogz
 7A7PaFCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ8ApswAKCRB33NvayMhJ0UOQD/
 0V28hcIwwn5YKa6JxVWYN5bWzlLDwhCcBzIgBLcuxrd3g+R4zSMz5AICC8BirZ7NmXl6z1rOfq/lYF
 UpEBU2nkbMCmSRtXckAeNPScNA4qISeWJhjMkDx6/uLc0j5pFZb2gTllrdC+uMnYZhEkvssmRL504O
 Al9o81KGQyKCO8gfA+fEOEKu0zPzMq9aWNM4edC8WmwUi543s8bp155dbSutGTifAZDl3NUbD5A1Zi
 pruHThJw8U22o/a47qOJc5tvNQHq26eaNSAcL7phyLNDbMMrGg5DaYCu5AXol4mGwJ8+trnJO/8hke
 ExS+p/pwCywrY6061COSUymdzJjkMGk1rQwq/jWvHFACfCHtQjCePwxKARL2rvc4dtGWKfsT70eNsa
 CKD6l7xq+mFPAadktBMssmxQIU8v+5u/KrShbVwZuk5GFIiU9n28Y1WAyM/fjjXdCjHFi4oCQN2SS+
 5p8o9JftmZYOPEuFHwfxafMWV68RSrmTlgU9zY+GOaBBJneiZXRuaaw7ZLnb3os73YExrvOzzR7u+e
 pRW/bnyS7cFsy4LDS3HEYNYvskshT58ebmTI/27Ek+XUU9EdY9ulTyU0NivsUXeA14wRdpJe9a+gtB
 UOJG/AYmddSHWU8Nf3DfXPkme2gSGF6q6yWT4PooMuVZLVmEWpeicByywx6Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The mdp1-mem is not supported on the SM8550 & SM8650 SoCs, so properly document
the mdp0-mem and cpu-cfg interconnect entries.

This fixes the following errors:
display-subsystem@ae00000: interconnects: [[200, 3, 7, 32, 1, 7]] is too short
        from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-mdss.yaml#
display-subsystem@ae00000: interconnect-names: ['mdp0-mem'] is too short
        from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8650-mdss.yaml#

Depends on:
- https://lore.kernel.org/all/20250115-topic-sm8x50-upstream-dt-icc-update-v1-0-eaa8b10e2af7@linaro.org/#t

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v5:
- Drop applied bindings patches
- Updated commit msg with Dmitry's suggestion
- Link to v4: https://lore.kernel.org/r/20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-0-3fa0bc42dd38@linaro.org

Changes in v4:
- Add review tags
- Rebased on top of https://lore.kernel.org/all/20250115-topic-sm8x50-upstream-dt-icc-update-v1-0-eaa8b10e2af7@linaro.org/#t
- Use ICC tags
- Link to v3: https://lore.kernel.org/r/20250210-topic-sm8x50-mdss-interconnect-bindings-fix-v3-0-54c96a9d2b7f@linaro.org

Changes in v3:
- make sure we use cpu-cfg instead
- Link to v2: https://lore.kernel.org/r/20250207-topic-sm8x50-mdss-interconnect-bindings-fix-v2-0-f712b8df6020@linaro.org

Changes in v2:
- fixed example in qcom,sm8550-mdss.yaml
- Link to v1: https://lore.kernel.org/r/20250207-topic-sm8x50-mdss-interconnect-bindings-fix-v1-0-852b1d6aee46@linaro.org

---
Neil Armstrong (2):
      arm64: dts: qcom: sm8550: add missing cpu-cfg interconnect path in the mdss node
      arm64: dts: qcom: sm8650: add missing cpu-cfg interconnect path in the mdss node

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++--
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)
---
base-commit: 379487e17ca406b47392e7ab6cf35d1c3bacb371
change-id: 20250207-topic-sm8x50-mdss-interconnect-bindings-fix-dd975f223d05
prerequisite-message-id: <20250115-topic-sm8x50-upstream-dt-icc-update-v1-0-eaa8b10e2af7@linaro.org>
prerequisite-patch-id: b2052194cecb6796ba6f1e58e0aaa9a7267f3d0b
prerequisite-patch-id: a3def6c1e27e43153ae1f63343a092021926af8f
prerequisite-patch-id: 7daf103007dc6f7ed97ce26c67799766197e0cfd
prerequisite-patch-id: 68b4f5c2bce33ce6034716cfe4f7b9e2cd2d0f98
prerequisite-patch-id: 8b4cfaa99eb145b533a6ca63f4813e38649d6c8f
prerequisite-patch-id: a0d5112490c42e1c7752371d6b3818fda5c06bbf
prerequisite-patch-id: 7b72193dd00f7a2e8fef3f36e6e53fab4691a65b
prerequisite-patch-id: 8e3be7c0aae177f77e42570c28a1ad22aef25768
prerequisite-patch-id: 8a641540de8fd86787102b3e682fa8baca295d66
prerequisite-patch-id: 8b31e6775ccb7811557ece74172dda96f368f0c5

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


