Return-Path: <linux-kernel+bounces-269689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549709435D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C821C22113
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B52D48CFC;
	Wed, 31 Jul 2024 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMLrtFQF"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2045014;
	Wed, 31 Jul 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451765; cv=none; b=JZhlz3JafkxP1wc5MP7uszJDVfXHTuKtqiHO6toN4s8TurW1W2ECHdYOd790hz4LOQqJqbfUOWWEuUj2Jr3qasflK4OIPodQE0l7KiLRx9oh+oH3iHvXLFICRHWeMcJ//etR5tFVrgGRrlNEZ9BSQgaLJCF3LNbm6Ibh8SH5hgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451765; c=relaxed/simple;
	bh=Dtx7g06KGw4ZzL67oJxaUspiLVmOUtjZe55hVdB41Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LnsA38xj2qfUbZ2UX1AUYGDS15uXOEuK1ZAmg9a0CzG1pz7H+SXCf3LtxQQENrmxed/9/36hc7Z10s+hCztq4l/5oG5zyDiNKZn2iLwg1LH60aqMnOAtU9aqP6CsT5KMoLSKlScfYx3Wstr0evqpb8U0rSKQYEJYhHATNsaJ7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMLrtFQF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc4fccdd78so43564925ad.2;
        Wed, 31 Jul 2024 11:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722451764; x=1723056564; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzqokK/MSvpqd2Z5tCS/Bbfkt721yl1/ZbEZL2SUus0=;
        b=LMLrtFQFNd9BcfR1XAxtxNAuuSbLA89M62eFTUKdMMRQyhKgBQEFkJkeS/GhLb1ew1
         nbGgC1VDUwGYs082QpHLyJ1lBaC819qnV+/fgf9gtd+hSwy26536ZUNmxGfBhlyODXcf
         PjGKEYH3pLRPF5gAJ8ZrhhzrAX3tDg1XgwnGxVLlwJuNC28FY2i59cLAk/WzA999OTfk
         xUEt58+u1TSsj2Ek9K96ai+qYIncBbwUbfkMNvCvFXtXJ8aa5Y3p9tHfOSswHQmnWRbr
         ixWlJ+QjusCnuCkd2K63swZeMHh22qOga6kN7C8ZIKXrp5HlVdIw32KItgg/RYexMP61
         ZTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722451764; x=1723056564;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzqokK/MSvpqd2Z5tCS/Bbfkt721yl1/ZbEZL2SUus0=;
        b=gqYs3TA8OR6+465SQR44QlnXhPU1XukQ2xcua0CgZ4zgnFvTbWFCcvzkbA5oePxWyi
         9Dxn6jfYNRP0MY/n99s1IydbIHl5lP++AhXhe1c/RZ/nCYi8vWYOW6ZasK7gxD+3HPMe
         9VsePQoPISpFabHE3KUvyO8yUstnryw6nOJatWOwM39MTr7Q2/kclgwaX68Vk+StV+M0
         hyPo++aj9vB4pdpL3DIy+6GWWeV7eQ6BDiQsUUYdJ5698AjO1EKGaPP7XT3+VQtqnQvz
         YmA/nhWLiTR8loJhoVpliMjPYxMIL0Xqb3kFEmsHiVKA7XlePT0BC7mOuCzE0f9WuAnh
         2rDg==
X-Forwarded-Encrypted: i=1; AJvYcCUPP/u9rmZRoYlg/kAZFaBuug3MQmFMnlGmfo7lVuOSRZ/pU+Sy4FNX4/1Eg5EdZJ9S8cofd0OpKTA7tgPF68GHdSLGE3OyCCOI482EclERmCzbqFmClWH0Z954JFRqs7WagCg/zW6G
X-Gm-Message-State: AOJu0YwsS+1u7DV1DmH0GLXSR2m/DR6fSx8SyVj9Vr442W8FXW4gYt1D
	bcxuhJgciBl/mXaJjInJKpDYHlQsZFmJE/H0j5CpjaxU/jfw3qMO
X-Google-Smtp-Source: AGHT+IG4UzO+6IWPRJxTdfG4IBjB7u/5lSwpkMB/BqHjVegBsG6sIt9GSv0noEnoqE6l7H41eRKyGQ==
X-Received: by 2002:a17:902:fb0c:b0:1ff:3b0f:d5e2 with SMTP id d9443c01a7336-1ff4cfec9ecmr2173775ad.32.1722451763771;
        Wed, 31 Jul 2024 11:49:23 -0700 (PDT)
Received: from Emma ([2401:4900:1c21:dad1:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee3f68sm123698785ad.171.2024.07.31.11.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 11:49:23 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:49:20 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Karan Sanghavi <karansanghvi98@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Karan Sanghavi <karansanghvi98@gmail.com>
Subject: [PATCH] Documentation: core-api: Fixed Typo error
Message-ID: <ZqqHMIKdcNRVgAFd@Emma>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Corrected the typographical of the word "instrumentation"
in the below mentioned sentence.

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 Documentation/core-api/entry.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index e12f22ab3..a15f9b176 100644
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -18,7 +18,7 @@ exceptions`_, `NMI and NMI-like exceptions`_.
 Non-instrumentable code - noinstr
 ---------------------------------
 
-Most instrumentation facilities depend on RCU, so intrumentation is prohibited
+Most instrumentation facilities depend on RCU, so instrumentation is prohibited
 for entry code before RCU starts watching and exit code after RCU stops
 watching. In addition, many architectures must save and restore register state,
 which means that (for example) a breakpoint in the breakpoint entry code would
-- 
2.43.0


