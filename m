Return-Path: <linux-kernel+bounces-554597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C2A59A53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E304188F02C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FFB192B82;
	Mon, 10 Mar 2025 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iyghe4HH"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEA122D4F4;
	Mon, 10 Mar 2025 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621695; cv=none; b=vCcJ33QuM78Y7Qu/NbCti647Ug4s9c+0QKS+kEqCcp98iQgCmeDjsiLwRggbawIDYItDm4wC18/0LQcsfM2+UKJKpeqIz5yCZskbb9WwZjaOL4udIU1uC6/pCu8LmX4oiaMfHHRg19WUOPhNsIcP61F29RG+oCH7qCXmKfzY7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621695; c=relaxed/simple;
	bh=VwlxioAXeqYmZW093eoXPHRf7zdX+6VaniBbohgAfb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5XwLqbijMNYw2DWf2L10WPZQDlhb6/qU4BxF2uaUQI7LRhV5tofJwAp/NbRFUvYptGdWf69/bhmcsEJdxn/JkorHKVyHbehdX7SyPy4mehkMoMcsoqSPde2m3yXHaIeNCdwyCgZICobfe8jKiM/eLrX405WSx2V7m8HS4NRAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iyghe4HH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so787a12.0;
        Mon, 10 Mar 2025 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741621692; x=1742226492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE1sTeqM+1AGfrmmwn3FDyVaoKa/iwOIi7NTDRnQcf0=;
        b=Iyghe4HHdQzeizmwIBKCTRDdE4YU+N0AWEgfb7deP01Vfz/fl5EffqNSPeakqsvalR
         oBtC4EKB1GW7U+MaI/Tu9408G/4x3BhCfNMNf29wna1jScoypCbvNlAWQnFu1LMAAVio
         y8GQUjCVJWGK9VDuT8aBdkuQCNnvRi8ZvWJAuQPxuF3uFH7Lv3oj+EOHpeXkFIb8mklk
         b+KcDGvysfegc+PnXn2VQbyecnN3hw1cuJgd9RoGu3QtOtt+VLhe+xre8IIeStdVxNT/
         bJZIakq6IsmrK3BM6TBE9lhWmyO7GiDyKazjXGmhVtX3xLVJ8WY9H7Z0nn5yjiByUi4W
         22bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741621692; x=1742226492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE1sTeqM+1AGfrmmwn3FDyVaoKa/iwOIi7NTDRnQcf0=;
        b=YcNN5DrLoYZGD15yaZ1jj9NqDgZ8LyYs9o6RI0TQpxsozr29GOX6vf+0/wSwOEL3gd
         6tj8vzMTtO54GjH0HLS5/CIcYxsvNrsJUXh6BgK7axs/r+yzpbCTIo4lImGqzaAa7BhR
         7H+viTUcOGRlnK+4uHL4l5ureJCUvTC92N1p+0Fd6gCPYqaPkcujGY1zaosWuD4IcqkZ
         wB7H4Hf6J59vjhm7xnwiVR7UYyWQYBZ3Q9flMzo2Q3Xt7929Xl7vg1dnR7UHN94Zvb10
         NdI6k9iCF44JAaonBPZ+jeNgeMYWxOaWTHTFqF2Mf9KsiJ8qrAQ9zhz8Hgk22JE+Fd5I
         xF3g==
X-Forwarded-Encrypted: i=1; AJvYcCWU7PNyxzs1GhGMSGSriBiUJnUUo/Ao/YuSMtf0kpMB75H9XV7fLsq5g6w873hfsS0EBSzqIzE6a7hu@vger.kernel.org, AJvYcCWh2yG1YR4Gy9t8plFuMS1nS4AjLqaKhLomDcXoa9be3aVUrGzrR11DYgVy0znoNT9vcrxZSgTX6iD78ytD@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQrgZIIe/WySK4u6t12cHQTBIf2QALKzyyMvYmPJX0C/tIyTh
	ne8nsSZqBCCrhrxavT/SftGMuCeUl3KBgkBFT4Dp9UKyJjveK8+lUun3ryNCBcg=
X-Gm-Gg: ASbGnctS5+45HDWVHj6QIkcqSxVYwJCQsqJo+k15SiamslVuQreqF75+NEdJnN35w6i
	H/Xpm63Im/PqcMPXV5H+SFCgiMkmgKAi3UGTqISyR0f8V1Ak2Xl7OG8+iKdY3KeoNZ7n8CPI7pJ
	KzigID+HCcTT15lsIfzNI20XO3nQ7oDpOzl501L6bKra8a1QSP7kQe0Dw/TClrzIJ1OZGmWuIaE
	HanPrvmCGXSiT1tvHcqs2zBC69YMJ78mpdKb7gVzE0SQYUnu4HGodtKsB6wAurot/K/ijykVThf
	W59iOfdEzSy5iwB2f71izV44NVcfeVDZd/K0L1FmsIpuEc7JoNDqTvXm95w=
X-Google-Smtp-Source: AGHT+IEn29ZIrELth1vqpMB17cSDSf9zSUtKS9md/Y6FhQ/FeXOR6GLoNZVchkEQaWPlzFBlIxy9Lw==
X-Received: by 2002:a05:6402:3513:b0:5db:e88c:914f with SMTP id 4fb4d7f45d1cf-5e614f1f459mr10527894a12.4.1741621691847;
        Mon, 10 Mar 2025 08:48:11 -0700 (PDT)
Received: from wslxew242.. ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766d0e0sm7252732a12.64.2025.03.10.08.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:48:11 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <gradenovic@ultratronik.de>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: arm: stm32: Document Ultratronik's Fly board DT binding
Date: Mon, 10 Mar 2025 16:48:00 +0100
Message-ID: <20250310154804.326943-4-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310154804.326943-1-goran.radni@gmail.com>
References: <20250310154804.326943-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Goran Rađenović <gradenovic@ultratronik.de>

This commit documents ultra-fly-sbc devicetree binding based on
STM32MP157 SoC.

Signed-off-by: Goran Rađenović <gradenovic@ultratronik.de>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index b6c56d4ce6b9..2cfc08430a87 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -175,6 +175,11 @@ properties:
           - const: phytec,phycore-stm32mp157c-som
           - const: st,stm32mp157
 
+      - description: Ultratronik STM32MP1 SBC based Boards
+        items:
+          - const: ux,stm32mp157c-ultra-fly-sbc
+          - const: st,stm32mp157
+
       - description: ST STM32MP257 based Boards
         items:
           - enum:
-- 
2.43.0


