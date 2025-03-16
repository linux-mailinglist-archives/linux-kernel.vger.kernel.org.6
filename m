Return-Path: <linux-kernel+bounces-562981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28361A6354E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9FF7A3F4A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931431A76BC;
	Sun, 16 Mar 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCJqS5GH"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA510F2;
	Sun, 16 Mar 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742123854; cv=none; b=BnIQC0dehz/yT+nEUTlsS5S/TC7pB40u8fA2T15a4AZgTbuz8Jh9XOcekkGLhcZkHig5rThB2QcFz7owyVSZla7qBnexPxgx6cKfnGyX2XnrKBSVcn6c6Huzk5CICR/JvQyqSegtKIEAUMRmgiG4VwQYldeQ4dmN0vEBsaFSDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742123854; c=relaxed/simple;
	bh=GlntjgU3Lxdii6DqpKNjs6+MaX1eRLZ0d3LBMTa28eY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCMpu6TJWpoMeecHqbpIQVOQaBmHHbsULt6fOgufpgMEJMnrEUstnvs4U34r5gnxhitj6WH5Ld/eXZA7tnnVljGvP/BzR8ZroaL1H9sZ24LuJEzmOaG+iy33DkCyKmiA6Mrbip4/9ZX84SgtYRUIn7BJxdWHkhUI26vKzrY/Ngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCJqS5GH; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-601c12ac8d0so1597469eaf.2;
        Sun, 16 Mar 2025 04:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742123851; x=1742728651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MibvrQXj2P5QnlDxX5YbYon7Ne8dH6XMjJsYnk+RzkY=;
        b=cCJqS5GH2H7fEPT8ZKCkHTXxqpfAqyn0gqJc50Rjzdaw1MoVB5pST//rxQ/dQyFpvy
         OSQwq7JNxIC3tdZ8zXK9eozem5HJjd6KJ7hyFRVmh7hOmTKcQ2F5mCr2fJN3oor+M2MF
         YtB3zlIg6vL3lMDjJ4gUdC5G5KfCxotAek8BIt+5ygu00PYtVWmnPZ1ksJJfq/mLZECZ
         sC56IxXRBPsm1mQLmZLcxa9uUeP/MjrKthDssmoARqaVJt8cE8To2DmVIH4P7hs4wL2v
         +/+WkNR4naCtsGd1DGJHBhG2ZFwZLO/J0Dg+dAPRI7vtReR3PwXfrYKaMiJwliaFBKV1
         NR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742123851; x=1742728651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MibvrQXj2P5QnlDxX5YbYon7Ne8dH6XMjJsYnk+RzkY=;
        b=dC7KUT3qdm2k7zzbaab7dVDDVY8qI77UfEj7OfQY5zlpd7YWazsTHKwPe7cKa0PIGT
         CeX1kGH0v+pbQkeRpG8uVvYfZyBL7jBblEAWbt4nqBrwJzUHP/DSO8dY6Y7WqCpiayZ1
         tMpEI9mjJMRTqsAGj8Z2eo+QymQRmQpmo44qaWUf2PApLVT/83g1d+OLoDsg8MaUF3dX
         EMcK9CCl82e+WXxsT8DBHSKXFmkNPU6qoUilUSzbkyVFFTHE8yKkl0fHnj5sz85NEJvZ
         wYY+Kb+EH+Oj9cAUvYlA+8MOg92lOVmJnPLeTHvKoG7YaazOj9k5ytKENTWg08l3INul
         o1sg==
X-Forwarded-Encrypted: i=1; AJvYcCU1pV+p5ZoehDFeF17iQ6EKuij+JxUzM6o0nh0H9c9Mcwc33D4Zk/R2l7HxbPety39+awtjnp/soxM=@vger.kernel.org, AJvYcCULXWNC2aITgXKPR5l2iTLOjECPD4I1lLL53cnOzTQGwV5yQeJyYyIG1SMLXB4n5EjLgX18on8+bT7JUYs/oIo=@vger.kernel.org, AJvYcCVaLYMHI36yrIg4TEVeNaJqg2qDQVsyoWYpTGJw9I5Xdt4BorKsU82mJiBtEEHgBwJHtY8aJ2qRuL7wZBPP@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhu//g+BtYwBeZm3+6WgrE21xRZVCeyIOYWHgT/DXET4cwz3G
	8mDgo5Omj5mTLCz8q1+GUj6au/FEmILEk9wc8a5vBvZ3HgMf0E/t
X-Gm-Gg: ASbGncsZ6W3yE6nT5/Zv0fXmiMgMc7uQfi3X1jvmwLqjphK2yiqMyEf6qk7iv0Oo/Zd
	cd6qevkn9gG7vF+toMD9eWgPHvCCmOl9QwCSHctb6ip2wLpmFAsRXWlRlzKlODxJjX+HzLhYBGN
	4RdYhY1XGrr1jzAzTPrAhH07++U4CqiPnpObbfo57ZRjK5comytnrh3H/AbG0+lpzpj1TKkVeMI
	5c+vPY+sNiZ32/9aFctMBPL9VXRq35TAzg2dOt+ekZxT2GVK0kD+odfxHzF3eHyOK9IpMvrpAMz
	HUJXfW9Q4pHB17FxzgpidqA3uRyBcWETFb8Jdl29XZ3WJWGHW01kt1oUwJaIwnd0a9eBOKRwT4X
	clmyuB6LJale0gmTN
X-Google-Smtp-Source: AGHT+IG0u7JDaDNYIHwPQlqHBQlgmBC+Fo0wrepsC3YNTau6TIWAGIJlcCHjX1uHxt1F9G2iknrsEg==
X-Received: by 2002:a05:6808:f12:b0:3f4:af3:74a5 with SMTP id 5614622812f47-3fdeed0d78emr5189018b6e.21.1742123851687;
        Sun, 16 Mar 2025 04:17:31 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3fe832ce015sm715978b6e.7.2025.03.16.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 04:17:30 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	andrewjballance@gmail.com,
	acourbot@nvidia.com,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 3/3] gpu: nova-core: remove completed Vec extentions from task list
Date: Sun, 16 Mar 2025 06:16:44 -0500
Message-ID: <20250316111644.154602-4-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316111644.154602-1-andrewjballance@gmail.com>
References: <20250316111644.154602-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The requested Vec methods have been implemented thus, removes
the completed item from the nova task list

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 Documentation/gpu/nova/core/todo.rst | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index ca08377d3b73..234d753d3eac 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -190,16 +190,6 @@ Rust abstraction for debugfs APIs.
 | Reference: Export GSP log buffers
 | Complexity: Intermediate
 
-Vec extensions
---------------
-
-Implement ``Vec::truncate`` and ``Vec::resize``.
-
-Currently this is used for some experimental code to parse the vBIOS.
-
-| Reference vBIOS support
-| Complexity: Beginner
-
 GPU (general)
 =============
 
-- 
2.48.1


