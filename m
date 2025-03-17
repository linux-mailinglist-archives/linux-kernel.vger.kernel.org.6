Return-Path: <linux-kernel+bounces-564937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8288A65D50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 217EC7A921B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A41F585E;
	Mon, 17 Mar 2025 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mevP3wZx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1641F1934;
	Mon, 17 Mar 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237656; cv=none; b=pyF37fwbsOPJKax+bgnRlNv3HEREqte3jbOQM5Mybqjzp28X4RFPXdEC6+YMXRTw2QkEAUkUc2XNsEjb660/ojfpcCkzsAZC/KesUuNvlpMeCfGhzWHs3/7dcY8cQv/ah8dC1hfpy37FAJ8aRwPy2EfNrbi8UYYPzNOg8hxg00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237656; c=relaxed/simple;
	bh=EPWDPC+fJnBBU4GpffSxWKMg3/m13OBptFGQuoDiMs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqGrr7AasHOpET4NymMHP8cWXiD1F+eCgk/uZYVjuM/YkZLgYMDLIYAmZRzIYE0tpRR/woGAQXwaG8fszz4XOAAyv1mm+YChgI9dsf+Qf6xoknaXkPaCD327eyfKAI3Tt2J5+gHvN/LpsKDfiUZ3/W8DiYw6Vs3njGcKfXGJ2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mevP3wZx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5495078cd59so5278822e87.1;
        Mon, 17 Mar 2025 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237652; x=1742842452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZvup61483wzLulSQOsIqtlJndDefRKXhVwq8k7pdZg=;
        b=mevP3wZx1HBlaCS8GSORXGmgBKT37nCltbgqEDPoIR59jo+zOXdsYLeglvFl23mFXE
         Js5o/0pZ77BuUuCdXIvXAjm/Fv3l5kc3t+zzeOgspwvPeAr4ZpwqB6nXmaHgH9fGF+r5
         yMGXb8WUrQsiviIpRcHHWaQLYkJY0JYAvVkhAlgOEIY8h3ltMp9xEiAQWdCqoFw0KXd0
         8F/eMCIiw6MFtUuyJMkHXPMbpRT3leJE1IGSKbqPvJVjlg7Ky93KXYBaaEjwCQ1lL3uK
         EyQOBA1HVHbIYpULMUHvKG6xr9Scd4vJ7nsBSLr6qbrbWQfyT4iYEdEUAimiVT06SFYy
         JYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237652; x=1742842452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZvup61483wzLulSQOsIqtlJndDefRKXhVwq8k7pdZg=;
        b=C7/ALmfzF98Ml5B92TiQn2oyXqqqQYlpO2kxNdaIU9VGRd+gvwCBlFYxBdYPhLhssF
         hy9O1YlwwcIbajzKbrYLTuacY7ZzzknGGGBS08RSIJO0NnYPPSMSIC60Wt4hhfYMg1m+
         9LIqu9Aq/TdeXPDWnNISlTSH8M/8dZbv9dQ1uVYu2qzDZ1vRCVyLP1Drx6Uy85dlgD+s
         AOXt3fdr/TRmx3ns+uDWIKWvNkACQnxDTV2fwkTVQSHtGfrTVyPQ7HPWVz+A5od7wbk1
         Nj5WWBrlP2cBUvcN/dLr0pLEQrixY+p8SvFq05cYuJAsEeI1SDTwa6mlohzuF4i2FQK9
         S9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUad9EsncP/MIyiuIZKI5aSweDIAI4a9TJlapV3wRwftm0E9qNNV7Yugzy+zyN1DQZMN96afHcPqFy6II0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ubcC3DQszsSP5tiw9rAjHRLrfn1gknW99h9ZERsyYuv8RPN3
	mVlGPzdaidqlOvqGzXHmZ5QcGLeYRvc6LJy5UCE0f+aQ0JM47J6lRr5XBA==
X-Gm-Gg: ASbGncuUdEgKLIYwCLIDBxIkg39/gUJId2mof/kntDD3HROA17W1qorBOB9onpdqrpe
	f17aHkemrT5bu/5lIZHxiRDZQIMHp2uEkY/O0V9OOhWotwNi8whTmhQrUo+Y5KokLDS3R95CGuQ
	GEUs36a8Wb8KY4QxfUnBTsDXA0NHfEiWtQ6ISLWX8ZmBGgmVi3jOhunDReGvpsfNjLk31F/z8os
	YkjWJw4xMZ0wE4d345jyAQXA41Nc1OLJu/qsefIDXp5V3cPmkSwDezityXykK/YUFOxSp49lZZZ
	WmGrOZO7IvbSuffymeGAHqZr+jTaLlvz7hS46xG1eFQLaaXcWhfF/kcEYWzlRlwpdoVx+tw9xJM
	68VZe2LgsDwkbYG3ya+5myw==
X-Google-Smtp-Source: AGHT+IGtX9zm2Uw55vGFTyqp9oaT5S5iJxffQf8eYYzjp5zzW3dESN7bQoHL9dB0Rop//PqH96BF/w==
X-Received: by 2002:a05:6512:3a8c:b0:545:576:cbca with SMTP id 2adb3069b0e04-54a03b7818cmr792338e87.8.1742237652127;
        Mon, 17 Mar 2025 11:54:12 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:11 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v15 04/11] MAINTAINERS: add entry for Rust dma mapping helpers device driver API
Date: Mon, 17 Mar 2025 20:52:11 +0200
Message-ID: <20250317185345.2608976-5-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the Rust dma mapping helpers abstractions.

Nacked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72b88f1638a2..4c0786336826 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6902,6 +6902,19 @@ F:	include/linux/dma-mapping.h
 F:	include/linux/swiotlb.h
 F:	kernel/dma/
 
+DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
+M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
+M:	Danilo Krummrich <dakr@kernel.org>
+R:	Daniel Almeida <daniel.almeida@collabora.com>
+R:	Robin Murphy <robin.murphy@arm.com>
+R:	Andreas Hindborg <a.hindborg@kernel.org>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
+F:	rust/kernel/dma.rs
+F:	samples/rust/rust_dma.rs
+
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
-- 
2.43.0


