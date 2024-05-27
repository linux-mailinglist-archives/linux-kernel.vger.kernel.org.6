Return-Path: <linux-kernel+bounces-190658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C0D8D0102
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D681F23CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1685A15E5CC;
	Mon, 27 May 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KX2FzKAK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706111E868
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815614; cv=none; b=sXU+AVaoDrSAIb2Oy/YMKxfImhP06MWrPJEq3Q5tEqbyrmqvc1V/4xrYie3m+uYvAPbSHGEK3iMiCuXg2cv5r06I8Rl9UuXjnYB5318D/cOcds3G/NYgwXjddDsVLwAIbMnwb6FYoSkw4D0m7qrpWQL8QFCDrJdJ27/L9fxo3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815614; c=relaxed/simple;
	bh=3DuU6HAXXUEpFj1/CbH0w2NMI18Jg5p4m14poKJ7EVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9PTR4eAsFMFgxwT8TdI0H26E2NZIMaHKUNYCHXFzKvO54XCRbfgBipLCuG1p7IDXBbyUjgW2i/oNAJBC4NP1BwxNGJP7eQ28641SSZ+2bBh0579W5Iw99CDqqz0eFSgze16V5X0k8c+CsLE4828Bza5ScQOxQRYpbbA8MSK+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KX2FzKAK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716815610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ug/+QrBJ1fn4jt7nmsB6WVOTnZkvl361r4prquvMN4U=;
	b=KX2FzKAKCIppUMn8sHNK37jv0U6mCYBK3emN5QtgkbVv6uZygVBlu2LgV4/JLZnP8BwwCt
	x8ZHYBKw+BIow3pR0XlBfECvsdgAFH6NohyLam+ROAng5KMGqRb/aEq6ASxUTjmy+IKro4
	oRPTlSV0aWhmT4NynXDuJq1yNpa3P0E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-UT4dNCUTOGixSJohHuKbXg-1; Mon, 27 May 2024 09:13:29 -0400
X-MC-Unique: UT4dNCUTOGixSJohHuKbXg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ab9e08d5f9so51732676d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815608; x=1717420408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ug/+QrBJ1fn4jt7nmsB6WVOTnZkvl361r4prquvMN4U=;
        b=LT/qVoTYl7p7yd5xn32D60jGJ1qCXXVVdms2LuiOJA5wJN8po/5chS8NuskPa7KKcW
         wD/k1l8w+BRD8UEmXqQk1s2YGWXGWqKiReOlxVZ0STL262on/6LCSHmaevV/rhZz6Qdx
         DBmLJrqOE/OoEGEUfQbUs+8TLY7HRGN1p/5B/wqHqK9UlCRSG+QUsKPJIlTCyeExo5Qu
         mw0LYvi4MbPX0tAaUDr0YjQov39DxB0+o5GHEtw86oe0zCsWwtboLNLZk3d5pFyxSUGp
         H6LFS8mf4gimL3W9o3DzWbPx3k9LT6qhKJEXQ6AIBiMrEqfEJv032dYcsEUorGl0tRFD
         2xlg==
X-Forwarded-Encrypted: i=1; AJvYcCWCKsLXWw25+Y+QXAEPiZKzyvNXTTiS9cFFU6WIJVpKPmXPQn+YBoQmuWvQ/Lg6pK0vyhUWtfv5EREoOGCvp/T0REcD9D7yPoJAUyTT
X-Gm-Message-State: AOJu0YzPuYCU1e+dk7PZnVLtKy0vFxpEgBSWLIhmaccZZAqqWJ2VXyM4
	XS7IrttyFBOq8pXpSQcsD7Kd177WmMsbY87TOhXEKyxXvvJOA9fulmEzyv3ALBL9PHvQBLVBIaA
	uH57ooSKLqIEy7o1e6SMjXe84MhijV7AlENAPIrDZyuao+qIjC8Emxc3hgVj7iw==
X-Received: by 2002:a05:6214:76b:b0:6ab:7ab4:f309 with SMTP id 6a1803df08f44-6ab8f327f9fmr190114686d6.1.1716815608539;
        Mon, 27 May 2024 06:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFvp62B55LpZG06oDjDs9C9JeEguHSawvpfFEUQJhPnKmdJaNhFrrUX9ZGDUsNJSeBscO1kA==
X-Received: by 2002:a05:6214:76b:b0:6ab:7ab4:f309 with SMTP id 6a1803df08f44-6ab8f327f9fmr190114306d6.1.1716815608133;
        Mon, 27 May 2024 06:13:28 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:833c:88f3:25a9:d641])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad742b3663sm19273786d6.60.2024.05.27.06.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:13:27 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Petr Tesarik <petr@tesarici.cz>,
	Michael Kelley <mhklinux@outlook.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] Documentation/core-api: correct reference to SWIOTLB_DYNAMIC
Date: Mon, 27 May 2024 15:13:14 +0200
Message-ID: <20240527131314.22794-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit c93f261dfc39 ("Documentation/core-api: add swiotlb documentation")
accidentally refers to CONFIG_DYNAMIC_SWIOTLB in one place, while the
config is actually called CONFIG_SWIOTLB_DYNAMIC.

Correct the reference to the intended config option.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 Documentation/core-api/swiotlb.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
index 5ad2c9ca85bc..cf06bae44ff8 100644
--- a/Documentation/core-api/swiotlb.rst
+++ b/Documentation/core-api/swiotlb.rst
@@ -192,7 +192,7 @@ alignment larger than PAGE_SIZE.
 
 Dynamic swiotlb
 ---------------
-When CONFIG_DYNAMIC_SWIOTLB is enabled, swiotlb can do on-demand expansion of
+When CONFIG_SWIOTLB_DYNAMIC is enabled, swiotlb can do on-demand expansion of
 the amount of memory available for allocation as bounce buffers. If a bounce
 buffer request fails due to lack of available space, an asynchronous background
 task is kicked off to allocate memory from general system memory and turn it
-- 
2.45.1


