Return-Path: <linux-kernel+bounces-570672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC5A6B34E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C44189CC58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8D1E5B89;
	Fri, 21 Mar 2025 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aez4GEnK"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7B1E571B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527598; cv=none; b=lZz8xcs4SvQwv4ql0SaJdJHAOE5HJYqM7Ny/+EGgLJMfRkhuqDg+K2eX/TmoyyrhMqiHEts2rXiYTQt0y2H1R/WLEnulbKrdW3kCsImENw8Cu1r/+RGTpd0FT3t5nJ6c4kTMbd3mK97lecJpOX6PrNNStCMyNbdHO2N61d6mfR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527598; c=relaxed/simple;
	bh=eDQh0a02ekUcaBQfvdbuK9jfyLKr14ZSzQwradln/NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPraTwMXzXTWgGYcXPa1q5y0gIQp3D/SOESg6kk4fkwxuvroFEAS1lKT7rcjIgAJ/vxioEerGNiN+orGoykNsHTa+sBgliyz0nBcFC2bvhkYt6xsUy6wEycSXCNmGzuRgePUfpKMItNggLtcvfN0z1FpJFgz8UM9B6vI7g4NmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aez4GEnK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e835ffcf71so304273a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742527594; x=1743132394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5zHL19slUgh5eKmO5Fy/udQUm9kmXxLzG4bF5IRJCI=;
        b=aez4GEnKLLbKCLzOYF7r6c3fKtcNBNFiH1GRKupXt0ZGH/jGXFWjE60TRwASPHMTvc
         T4gwJv+AJZWiOhbCxACPrQJiw28b1aAZvlIrQaV4ylvODNpY8dUO2ooaxm+HI/4ff3Yt
         uJHg2zEp8zAQjXYIjy27coDzc6ejFqxiBJLK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742527594; x=1743132394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5zHL19slUgh5eKmO5Fy/udQUm9kmXxLzG4bF5IRJCI=;
        b=pNxcCbfR8xm7Fc81qFoKad4acfdh1poVdvci+AMmDRzlVgbalnlIJ4w1CfyffqQF3q
         BDTiiY32Xv5Gspcnbj2e6CGjzNjf0YmR6NBpODBLUZxqj5gOXLI7VqE2bCfHkjG2HUeN
         CkZp6KL8X3DlLCxQMU8klm4w6zDR+/VJpcVuUcHJDK3uN/b5r7kSxPtTjz6zs0yVSBiH
         odoLs1iFVI8p99GJBpqe88MR7+zNRgEFAfVsHtqzihttyaDo6kDB4KbkU3qgBlHl7dtt
         598JSy9Li5BH9FbMSXPrUXHYNwPbZ8lNyjic+I6LkHE2YVJeFUP8V5+GJesa69AgbjHB
         2UWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGXR7ZLRym5v2aCmak9d+JCrCknN/xN9L1K/ZIQ2g+WPmD9Mi3DL4Z0mvTZFABz6SDOZ3mv0xbYlmbdZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnIv2fgl/U56sRBOJYzucsTt6GMh4v5NKjyUQ/wyKo8k9kVVv6
	wISaXuHvp/lbTib22wzztC0Xbu2QiRi5yyx9lz8uuq4Tp8z/ApUzY6J0Sy2gfg==
X-Gm-Gg: ASbGncu3qX5y56+MN9l7/+CYdy94nGppffDx7UT1GMXwqwsOsz3nAlaWIfHXmtmGKoV
	Cz9wkQWcgwwTf4Sf2Ggl9o1pCVGvKLssWKXgoqA+C7zEQlcRHw1wAxZ5kb1XS2ToWQVGWtlXVTp
	pkzNh3dCsVrJyzYAMrvAfVHh3NtPShRcCuYPUJiZkuSaXezwuDJQQMDwZbNujNq8SDHtvOIosRL
	eNVBvxpygM1Dcpjb6pfwNIB/+aMzAKvRg6RpjLlOpwW4GXsCU5cNL1ewMZ7SiXurtPG+k/st0Dz
	NtMeoOXKLpqhQa3HstUQao5JLYi81E/uH9+qJpmrpS/x0PyizXy8021rBImiR+tFzqTsha5h5lX
	uWJMOBSsO2Do=
X-Google-Smtp-Source: AGHT+IHl+mYWvLUnotjGhidy8abObJGBDSJw+ITfNPlfAIWcj0UU6andhioYEzcvbk2yZoi1n9IkvA==
X-Received: by 2002:a17:907:7f94:b0:ac3:673a:2ab3 with SMTP id a640c23a62f3a-ac3f2297982mr54135866b.7.1742527593850;
        Thu, 20 Mar 2025 20:26:33 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3f24sm68463366b.57.2025.03.20.20.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 20:26:32 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@chromium.org
Cc: Liam.Howlett@oracle.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	borntraeger@linux.ibm.com,
	edumazet@google.com,
	geert@linux-m68k.org,
	gor@linux.ibm.com,
	guoweikang.kernel@gmail.com,
	hca@linux.ibm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	m-malladi@ti.com,
	svens@linux.ibm.com,
	thomas.weissschuh@linutronix.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v2 0/1] mseal sysmap: add arch-support txt
Date: Fri, 21 Mar 2025 03:26:26 +0000
Message-ID: <20250321032627.4147562-1-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add Documentation/features/core/mseal_sys_mappings/arch-support.txt

History:
V2:
 - add hexagon,microblaze,openrisc,sh as N/A (Geert Uytterhoeven)

V1:
  https://lore.kernel.org/all/20250313000623.3192896-1-jeffxu@google.com/


Jeff Xu (1):
  mseal sysmap: add arch-support txt

 .../core/mseal_sys_mappings/arch-support.txt  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/features/core/mseal_sys_mappings/arch-support.txt

-- 
2.49.0.395.g12beb8f557-goog


