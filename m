Return-Path: <linux-kernel+bounces-510385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671CFA31C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFB13A7C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FA21C5F39;
	Wed, 12 Feb 2025 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goQkNcd2"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6326D2AE90
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327323; cv=none; b=HDbCreFLiakxK2sVcj4T/S5U0WzXJhxa+LyKK9/cZIB4W67OeJkkkzwmsM56/Tt4eNQsuN5RwPJ6Jt6vgFNKWYlYcOV8sbcdoB9SiIh8TF/9scZh5M/HlOJXkSyNpywcG14iKJO8pMgmTT+cdlajo+14UZCJ8bmwKFueZvu+670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327323; c=relaxed/simple;
	bh=r8et8ge8AdEx0Y13ADPu19VRp6CNcG889or64+bSVlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HqCfd87q1MBPdQeXXCcHa8a5GPkrSWR5TMGPVVpZhL5LeBNFqWrxtNrQJl16AgUQ05GyaMZfIgWcV60axI2ou8OY7Es/JDxyYwV1A9N1RmZzbpuVYtU9m0hOZCRs52WVidgCy94U8OdN28jM37TMog5tm009UBYJJpwyBgM9qBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goQkNcd2; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be6fdeee35so1081833185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 18:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739327321; x=1739932121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hK3qko9u55P2rWVGBnX77n7mkbH2Dx7i84rsPS5o7p4=;
        b=goQkNcd27vXAZHnTKpWEQ1bkWPn2KsopG4QR79peqHZsnZxEDU/b/34/z0oI+4OQC1
         2jMYNBsiSDD0/qNGvl+j/1vjUQvqUHepej9tlhkvhlkPqoClpoy9aos5Fk/syslnUH+U
         HZ7ajsrXZAH0mahPEu2zS1YBTAYabZEBvbk5gBurEr+ZY3LrjlvprpW0QY1N6UT1++5S
         q6O3UG2g0V9PjRekd40AQgF7yupHuCA8UhVBX9XFKpl9baLOZ55a+LT6/Ju1RHst6WLs
         0kBrynPAvAAWcdBvpKW1DBsH/kHCBPFG6RgtTKlErXjj/WDQCadX/kIA18F5cebchYc1
         eXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739327321; x=1739932121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hK3qko9u55P2rWVGBnX77n7mkbH2Dx7i84rsPS5o7p4=;
        b=LGkf/Vr0VmHtsLNqmEPtsg61MUvQCzl+NM8W66xx3MAWYl5Wo8I0kGia+zupbJ5A2a
         qDalhnmztZQ9jNSJTKsVeFo8JndyhfjkwnozeK9nJ4ucbXz3hSL6KTt/445LX6YbomK+
         cNxaEaFClYfzPBGaJA+IW0HmHWI8cAlS2wc3+XghFdrDL4ykDSpUwlKM2r+OqaITIE4t
         aYB8uRBnEp/bpajUODhKVwiW7/F8k0DgBbZ2CyE2yS3Sv30KKYjxjdPldFoi8G23yhFY
         fM9GriCEddKAMYJrOJaSdftI71Da6E8sGtVQsnrt1Oj//KyLkVZF0ric5jEr5y6cLQOg
         iQiw==
X-Gm-Message-State: AOJu0Yxj8xxNs9vPMTmrBeLBBXA2ZCCIyQ85GYjZ5NMToW2EcY1EB7cJ
	TQmXF//8r86iosi8/VpHC9jsbyi6JHVsU22YnLuQ4lG/Zu3tN3ya
X-Gm-Gg: ASbGncsljgOz8U5hhip5geoe+weCJfO8dQtypZDwWd4uyKLyr/+SKk9b5TjBJ0DvTrX
	zxdXgAWpGNdgeeiUD1oyhD3VxFafs3xxGJudY/xzod9OQPKf19r1vR98vVzY32hzsCsUUsaFW9p
	VYbJmLp9d8j69STbkTvRmDr8MPm8Fof3wMjKCx7LbLlNNemmJ0xqzkRJyH9SwL1RUnG/S128yWY
	CAAI3jNs7L7JFNuhACjNTWazZeAr4O/zJgQpz9sn4aAbE3i4VzU8P/Uu5/dZM+wOO8=
X-Google-Smtp-Source: AGHT+IGpNcZTCyXp/wwIN2rLy73VjHg6eU+7hL0k3ixDwpCD9L4DzbFxt8rfD8lBDMSngkcnnyeSyQ==
X-Received: by 2002:a05:620a:1990:b0:7a9:b914:279c with SMTP id af79cd13be357-7c06fb95ea1mr261018485a.0.1739327321163;
        Tue, 11 Feb 2025 18:28:41 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c041e13bc5sm766237485a.59.2025.02.11.18.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:28:40 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] MAINTAINERS: update info for SOPHGO DEVICETREES and DRIVERS
Date: Wed, 12 Feb 2025 10:28:30 +0800
Message-ID: <20250212022831.244143-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mail list and wiki info for SOPHGO entry. Also change Inochi's
email as the old one can not be accessed.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..6b79681877d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22097,7 +22097,9 @@ F:	include/linux/sony-laptop.h
 
 SOPHGO DEVICETREES and DRIVERS
 M:	Chen Wang <unicorn_wang@outlook.com>
-M:	Inochi Amaoto <inochiama@outlook.com>
+M:	Inochi Amaoto <inochiama@gmail.com>
+L:	sophgo@lists.linux.dev
+W:	https://github.com/sophgo/linux/wiki
 T:	git https://github.com/sophgo/linux.git
 S:	Maintained
 N:	sophgo
-- 
2.48.1


