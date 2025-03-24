Return-Path: <linux-kernel+bounces-573919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C8A6DE11
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CC816B23D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E412A1BA;
	Mon, 24 Mar 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X5j/pmX9"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA33FBA7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829345; cv=none; b=B0MWGV/bM926s9i/9vwQPWkZTuP4QeE+ev1W+fyq1f19gClLVG5tFsFh10Mynhzj36UDVDRjh69DJzm3tbc+3O7r8k6hLDchAECmvDbwg7gCIy3GjG8buZ4CGlfywc6XqiE3i5jGyaMbucCL8OKcX/KVNfANDdXfXvq06UdwqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829345; c=relaxed/simple;
	bh=7krJqYCz8WIH35/L2XLHi9sBJcyD56V5/AFLAep0E18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3BDdps241Fh6lQ6yYQ6qB/fy6Srzce3PxOdWWwQwBvDa2sh4ZeI5aowbljLwxKv3RW8GH80Ska5s+S0bYdUo/MAXokgrFmQjrgm+oeYd5slJ28fdKL2rhcMLgy85v0/qnUP0cZh/lhEp1NveS63iFzh82ZbUsmGxDZXX+ixrP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X5j/pmX9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac3123c0ef9so45232466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742829342; x=1743434142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAq9D67rCaNY4Dbk7a/YAfJWGHwZAcO9A1V0CY/OFqM=;
        b=X5j/pmX9qpKfuz7B3np18TzfkHX9Qn5jEJ1Iff6tT4y4S8o4B3McWiyY61ZQYAGHOJ
         Oxq2yXd4A2p4/EQTOZT75Jb8N7I9wHC60tOpPTOr7cOv+/x7mwBmNXBGuD5l2kn2zst/
         zP6lWT0Vb+lecoHhYHvDWoZ5pbJ9h1eNbitMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829342; x=1743434142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAq9D67rCaNY4Dbk7a/YAfJWGHwZAcO9A1V0CY/OFqM=;
        b=iloTOsk0zXOsWL0o2q96q2FZb7GQ2LMLidRiVOClCQkJf5Kv/ZZiMtlHl+Ds7FdWyS
         J0lTyvX+OqFVxVkMjxEQeWcnzUzO448d0nMqnPOMJ72Zj8/uXRnNu0lvYUVGVWjQ2aDs
         lPhQcznIS4wbC08L9u8OeFSffIG3lSzIOCa4lucAEmoGYc27ywVG9AigPyzGkIdRmIVO
         zguic3wLXgcxsM5mxEGWDS+ZGVABoobNRksbcjyvxf279xYreIXz3KeqUd/AKJSGUkzy
         t95pHGFNpJTqo8/8YkTm1xEmnRBP4G417iZYiy/duSSojW/Rswx0j8jxT4x9mBjHSJTl
         GBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6m25Z9Gh6bSfLi7lxTIU/X996saxPkrt3PZQwMPf8lI0LmOmAAsze+l38M3hp5ksuNlXQcSs2IOWZzeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwIb4Kixyh1chrcr5Ypku3sHxp7Dz7iffWLBR3/T6vg0oMJRq
	7Pv7iFEvxWF1Q3sD4YAecb5olotrIMo4NqMQOQYjXnRMQRYmYsLaAyEiSPs2qg==
X-Gm-Gg: ASbGncvBV9lDNbuST+mBUTuSqeUiWnjD7STnWg3KAOleNzI8ilr++WceZkylSFJEzPi
	eSXcwNm/zMmrCUxv8pjqasIE2aZDWBLXflwjI5uPklz7+XwL0ksd2qqtGiBWJn/PYW9X9TbgBmz
	w0bv59VblbNeRM8AYs8f96ZwkWgEHW+bopry7XHkg0azAbyVJ+7fgqPAcq+x8w1/nByTkFdqeX4
	VcYjLM/QnEoz4C39RNxsNdcvykgKRqpkxOP3iFWc9WIfs7ARa4crMv/L25i1RIMX7/0qFi0k/r1
	qSoZM7LuhvInpwZOynmEQc8okHlZhW8BYxfCvkQTQqrLUHS15EC6QMeJJp5FheeUgz9pqnQAIGp
	CTflcpFenywA=
X-Google-Smtp-Source: AGHT+IE0tQ4KGObc7tnv+GKNK9/sAqlB4q6I80xl+wAZ7VZUM0C6XX5TU58LRjAEfezFe381AVPaTw==
X-Received: by 2002:a17:907:9688:b0:ab7:bb4b:aa49 with SMTP id a640c23a62f3a-ac3f2429d9bmr497517866b.5.1742829341884;
        Mon, 24 Mar 2025 08:15:41 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d39basm689698466b.44.2025.03.24.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:15:41 -0700 (PDT)
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
Subject: [PATCH v3 0/1] mseal sysmap: add arch-support txt
Date: Mon, 24 Mar 2025 15:15:36 +0000
Message-ID: <20250324151537.1106542-1-jeffxu@google.com>
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

V3:
 - add arc/csky/m68k/nios2/xtensa (Geert Uytterhoeven)

V2:
   https://lore.kernel.org/all/20250321032627.4147562-1-jeffxu@google.com/
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


