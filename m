Return-Path: <linux-kernel+bounces-515178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE81A36155
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE75D18905CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D502673AB;
	Fri, 14 Feb 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fa7LrF0I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AD267384
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546260; cv=none; b=qbS5mbulXqyP9tkaly3Wrtp3oHHoWDY7tkKl2OIkTlla1eTnDIY58rViufcO6SYGibCoSH0Uwj4Uv8+3IR2H22eWgo/uDNzurWbAXsV8v2xFOpO0M/1d5DyDM9vnk88JlM3RSB+2ZQ8FieJIx/rv1b69oAWC1VHQyvm+vwBmIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546260; c=relaxed/simple;
	bh=YS3dBzS1TIYwOXLmFwToghgmQCECpJ7fllGh6NUtinA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhrI+oWzgEhyTomT1PkzNLyf+lnI5HIJY1jI0ABKuSWdEDr+hDBP3SIHraJdsJdsiBsi37CDFTu2jyf8fdL/Vsxxbn1+JEs9paaUY6PIpwi332yyQZRKp060kUFVFdjLUVU75+d7VkqhPux/dLlbqnSTEpwTqiSTGDQ/qi03AEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fa7LrF0I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739546257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvaWRuIqMubpY/jSrhphDNgLxyWwrcegxArhQIPFoO8=;
	b=fa7LrF0IFgz1q9WDkzMz2BkVgMt1AWCB97ZCafN/b1DOpEnPVvsI17ZrMbPByuynG8YbZY
	nMrRtFL1y7tpor5NB6vQsAcZlBnASx5IOLzhPtK1+V8xeDjc6ko57aNZtmVq69cvx1r2rg
	qMKAORcPzQZp36PIQ7gAX4qmXWdQiDw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-U68mvrH2Nga_OgbkrwjI_Q-1; Fri, 14 Feb 2025 10:17:36 -0500
X-MC-Unique: U68mvrH2Nga_OgbkrwjI_Q-1
X-Mimecast-MFC-AGG-ID: U68mvrH2Nga_OgbkrwjI_Q_1739546255
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-438e180821aso11985255e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546255; x=1740151055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvaWRuIqMubpY/jSrhphDNgLxyWwrcegxArhQIPFoO8=;
        b=aVto/a7dbrUtCQyIAEat7kDRsAQSsneNJ0sjiQfYCpX6xMQyLDRsTOst51EYSDxLxa
         XTAa2hzT10OxnkTcRKSk6cwKseWS4513jh1LOrDhSPciH41JLz7A2UpvRUPjA1CeW/1m
         eqMhpPM7czngQxKmxKh8TI0MmKF45yiYr3+xpMGM3OyzH2j6iXChzrf5Odv2Q4pN2vt7
         NSkPV/m4+pXnpg1sT/cPn18ooFTIpBlTBXdXVfTbJ/KoLI5+pmjYqNGe21LRoj8mvKxd
         PL+dBioe8qe3ki7Tc5C2bEti89rC5JpfLJkt47mPW1BnPNtxExOijziH9B5n6gn8pnkn
         K58A==
X-Gm-Message-State: AOJu0YzJHqQn9+tFVI1j/qWk89BAkSGplxq139pSnIXfImdD/lMFypRu
	EcpiOzMQcaSh8J0EPyCMnYgEzVt8jUf4RX9ojHwMAVJUYlXQ4NoBmy3k8CqErg8oxZQC+pXOSuy
	Cps3lqh2Y+cPI1MCimhwh9lh7GWoxoJ/EmZLnN9ACzx681wXOK7+oHBoGxUcv11NW/jijM6IUWt
	OavFZ0W/IEvuEV0XFocwvfFpxEHeo3SR6D0ym7vmhH969D
X-Gm-Gg: ASbGncsqk8+k54Dc51SnTuyC1iGuTSRHDFuBmFE7sQikJM33c30tAWgUfAX0SESOL88
	27qc5eX1jmrGO/swuoxoC8lcb7pfqYPvNr0w0vwLFlRd9xatrfrUadnKUCeEB1K8GAIn5ukBdQD
	owiZ61HjBQuhX14AOxhXgi76vArd7gogMD5gnc+HawzvLxcZzE5C11KETNqENCDwQNJWUCrneFW
	4AL//tlkzcBANfsjUwYy/v+Q3Cj3WZDeu4C5I6lA1t3XcPvMzv0jRMqvzpL7S8/eaqmS0wf9d/o
	qmHueqEZqn8QJDFrLKQ1ekX8MiR99A==
X-Received: by 2002:a05:600c:8509:b0:439:4858:3c77 with SMTP id 5b1f17b1804b1-439601a12b0mr94439475e9.19.1739546254839;
        Fri, 14 Feb 2025 07:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZ4cE6b9JE7HQ0foGmfeHs83Ot4ztX8SMgiEIT6K5P9Xu9N3qu7/a9sqVogpzuJ8xgB1pwiQ==
X-Received: by 2002:a05:600c:8509:b0:439:4858:3c77 with SMTP id 5b1f17b1804b1-439601a12b0mr94438755e9.19.1739546254333;
        Fri, 14 Feb 2025 07:17:34 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258fc7ecsm4808546f8f.49.2025.02.14.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:17:33 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: javier@dowhile0.org,
	rjones@redhat.com,
	abologna@redhat.com,
	spacemit@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Yixun Lan <dlan@gentoo.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: riscv: spacemit: Add Milk-V Jupiter board compatible
Date: Fri, 14 Feb 2025 16:16:37 +0100
Message-ID: <20250214151700.666544-2-javierm@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214151700.666544-1-javierm@redhat.com>
References: <20250214151700.666544-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible string for Milk-V Jupiter board [1], which
is a Mini ITX computer based on the SpacemiT K1/M1 RISC-V SoC [2].

Link: https://milkv.io/jupiter [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index 52e55077af1a..077b94f10dca 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -21,6 +21,7 @@ properties:
       - items:
           - enum:
               - bananapi,bpi-f3
+              - milkv,jupiter
           - const: spacemit,k1
 
 additionalProperties: true
-- 
2.48.1


