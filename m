Return-Path: <linux-kernel+bounces-183210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87788C95EC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB1128182B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEEF757EA;
	Sun, 19 May 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4yB9VVd"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29992745C0
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716144169; cv=none; b=nT90bNh12t/IepsldlcLvd38EhvBc063KkZzTvB9qFVxkuDGcytdnWFXVIlcuRbIHQcxNsD99fQMl+I+/P9AlhaCvf7OjpLP0XuIOsJ4vu+OIwfohrEqikeeZE91LevvecYFifbc7WH5d2y/5rR0HfHanGXQZUvaqD/v1pUw4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716144169; c=relaxed/simple;
	bh=RLGfUnNrbupCrUxJFM3mfX15wDi98tY0Qn5zbwzBgEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRDdzr5naZdzCIkzDP+UANMriny+VN5+Ltso4bMIGcnyXcKlXlw5Iv7EKoDs8hzr3piQFur/EL2qFR+OhyOoWEJPzHzMsUd8vtrvrI23hiyTUXjWhuPiwlE3SfPkbrgRMLnMIhJ7Tj9lyRhF4IVhVzgC2XxvS7WOXPkHLB07oeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e4yB9VVd; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e7144055c7so19676161fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 11:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716144166; x=1716748966; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJzQsvsL1/6Fsadk/3uxZSUhJhH3mZxPfX2NIOU9xQg=;
        b=e4yB9VVdUukR6po2RPyxSZ4fes5J1J/JNZx44BP8rn4IfjE8biCEi5NjJRyJb16Hxi
         DPrl3XB7y6kumh6vQdOVPXJGW0UMnX8TEZomPF5h/PEPmEDGtSogAWSjIFRvClof6eKv
         bI0YKtiik/KVRg9KYTmUPLfwYmixykguGEYGhrnuu4+PgzBty0vZXxGcHnOVWI3TVVSp
         3hRSi5z7fRc0nSiG4rlJMsZy8sYIALWejA+67YY18KhLpkXxzdiCIFjoS9tjX2iH2JY4
         eoRH2knWwD963srGU2AwPdSIZ5GW2hy86Tzo+urP2KxMrsYNhYHD856RUmCNom7LD8XL
         37RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716144166; x=1716748966;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJzQsvsL1/6Fsadk/3uxZSUhJhH3mZxPfX2NIOU9xQg=;
        b=ThOz4kFUlQcQ8KhGdl5JK5JRTmvFkgoqC5n/FwP4ymQRUzmnDN3hIwET3l6Pl8k1uR
         ejACsA8gqWrvCAQIVZyEheAZZXRA26Os0ACRV/geV17KghyGFfUQzw6y5luydkOovseS
         wWfhZ8rf4FZaUTqGZkYXIlM5z446Lc9DiUv+OEPny1P++On4tvkUXoBFFmLZAcgkouaD
         j3JPjWzyNbbCeTpU220vc/TYvHJrrzlS+j36Gq12Lv+7H/0C0YWaP6mN6fYMmlTGw1E8
         dlrHCtGA2oAgpwjFtL38w4HcGU/04JP1Fp+2PtkoNHuhE/mIrUdGCCfQfOUmS3jF2IM1
         Tpag==
X-Forwarded-Encrypted: i=1; AJvYcCXV0EbZKtDiRVnmjPB04y0LR5qRQ+KNK94S1OXOwM/cwt6aD7xGmp5cDN7/vGBxMpAMBmxMonkzrE1XHufuCxmow+lC79IRMQLvPrlp
X-Gm-Message-State: AOJu0YxAuBn/sPHtdWq4Citef23yLVWrsJQLcxZ4ij40mimGWM0ViFML
	3Ge/T9AB/YEAcdUYrgy12RVMVCOjWGOBl+9l/qTChJCJdXmXo+ml4jKXUfpCX34=
X-Google-Smtp-Source: AGHT+IEEBBwXOSZRHdGqRYoeDSt52xBh98K8OHuPaxav3A3RFKfuIQIZyvr9n42gPgHOBTx6hSh0jA==
X-Received: by 2002:a2e:8785:0:b0:2e2:802:7d5f with SMTP id 38308e7fff4ca-2e51fe532c5mr192904301fa.15.1716144166470;
        Sun, 19 May 2024 11:42:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-575313d97desm1789397a12.41.2024.05.19.11.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 11:42:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 19 May 2024 20:42:22 +0200
Subject: [PATCH 7/8] dt-bindings: mfd: syscon: Add APM poweroff mailbox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-dt-bindings-mfd-syscon-split-v1-7-aaf996e2313a@linaro.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=841;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RLGfUnNrbupCrUxJFM3mfX15wDi98tY0Qn5zbwzBgEs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmSkgWwKd/7X2YXGa1fvg1B2yhpgR0URstwon0T
 ibqvsQo7sCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZkpIFgAKCRDBN2bmhouD
 1z+kEACKLaKdIgKLsEKmFBEJRKVlh3JHvjVLvRZ2e61dp865A987D1vfDvoId5UXWlE7fJrPqJI
 eN8SfHvUQ/kao824zFlfom9NTiPUoYyrUx1du0nf03s8sUKmRPlkMXhbG1+oJMBpIQysM2yKPhx
 82FSbafBwE74L33EHqWzI9yoelaCXjXRtyTD3yvtMRd/wCJL9Hxfl+R+oU3dZSbvxvh8zGGX+f+
 iN43ofFQOJuJ7uJqjxhCDJEjD4yUhU9PEaZZiMAPTZg1m91xysOKwE/2ShP2UtMhz1ASfmSDMNW
 w1yvqduPLvMqGUOvkvHbcu1UqL8jLIC8YeL4tn/+VTtdiDNDjP8NPS2xNMptsUzOmnn5+t2IyYT
 0BRn3YRg1H9zoPhoONugiqcaLxPIJuSyBMsf7ESRw/gKqVnK8X+gpVW0uYtijhGxoUI/e0bILzS
 Cl7+bcCOGJtndxePL5lhgBEkiU2Y2Xw8yKV/kkqXGJ+wNPS90gOjuoMPp7S1mKikgADLwV/gKnX
 TjJY//Qs16YNiN4cwbskpHHsM4DqSik7307MN8wmmGwxRUkVRDyXVzb1Ux/9DTxcOYpzC7EZH5n
 l4vcO9rLmy5mthJal9sjEqco/S5DDYFEHqBrhqtDveZYjQCTlbNw7SC0s4QIJCpzB8xk02FdQU3
 3fQw3ANM83b5BSg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add compatible for an already used syscon poweroff/mailbox block in APM.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 70e3961bc96f..dd35e613d633 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -37,6 +37,8 @@ properties:
           - amlogic,meson8b-analog-top
           - amlogic,meson8-pmu
           - amlogic,meson8b-pmu
+          - apm,merlin-poweroff-mailbox
+          - apm,mustang-poweroff-mailbox
           - apm,xgene-csw
           - apm,xgene-efuse
           - apm,xgene-mcb

-- 
2.43.0


