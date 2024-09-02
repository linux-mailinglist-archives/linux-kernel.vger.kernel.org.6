Return-Path: <linux-kernel+bounces-311776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A589968D7F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD984282D25
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A9C1C62A1;
	Mon,  2 Sep 2024 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFriyin2"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED75680;
	Mon,  2 Sep 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301965; cv=none; b=ayXJgjjae8iewKw9UN5GHWSAGE6sFg9t6GkDAAWWMsp0g2TPqnWqJqCuRz+AVeSS2ryir+mIe6XCfyta7QPwtUusE68Lg3y9aQuURuyp1quB0l2Un4RrjHMyE9TJJiuf7nmns9DFiznUCaUSFzkSbd4VdKCZyzSQSWFSeXlPQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301965; c=relaxed/simple;
	bh=1PzOhJJY2LeQBaJd2Bcw0TdQoPlV8i5sNgTxX2h7qYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtsTBaeaDxt5raUXWJLqfr/ZYkSRdVTK3AITiZRxVRnuWQgi/kFa+MBN+RYB7KDZkEsO14KDXDnJMmrZyOWSyEZNwlpG16Q9DM+/5HuSqZzkFPlZR67lEXyAs7OzrsznuTTFT0NHCi+o62zSrS8yaadvyglzz6pDwXtGHBQrswg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFriyin2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bac9469e8so37599955e9.3;
        Mon, 02 Sep 2024 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725301962; x=1725906762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6Vltd8viCzWqgRL1P5eoxbS5xCxFYSk50A+3pCWiIk=;
        b=HFriyin2fLn9nF/y0DzHn8wdRY8Ir9sjPvXPds7MzVLXXcxsmGhUwd4CEFmsGjwvys
         82gSVK/7HFjV1GQBPzeo8NGzOKZg07xvaLO9HIAAnatpi1sbtD9+c1zahZOyjBBmA0fI
         7UoOvp2rsfq4OM9HLm4m0/8SocEqazs5/xPQAnwK26mGyQyDitqIGDyQti9QQ+E6Bon2
         YXy4hAZ1ufoIi7apU5o5e8JouoZg5uQVkahhwwYe31pLa6cUe4OxaTJ3RxDF5ad1WHi2
         v3HEIDVPhBRz5K8XSCttfEDg9M3PNvmEXN3of8QJMXXt1s0RAOcWTXOPTMt43UWrpFrr
         8SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725301962; x=1725906762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6Vltd8viCzWqgRL1P5eoxbS5xCxFYSk50A+3pCWiIk=;
        b=TfN3eO79NgTsvR0PNSLNO4h84OGzb2imhD4gd95JUOTASCQXDoHnCRsl8mMO6qQJTC
         WhWQlGPpRtBaWoBa/CnCWoSBu/jI1sYMGWA7nTXZ61OIsoOz0bdX16dZcsCY5LILttvc
         86/+cwtYYiZSWv2Jvym9IOrw1fKFvQG5ciSLOcPkcGugZo/l6Tn5DtahmJc5bwb12mUQ
         KuNHMAah0P8xOVLKFB9RzfDIlck0SQP83E42e+oy4TPtcQcO7IZgdn7RLX2UJpl6IYhk
         88e+SrvM5zGgDTWHaIcVKGZ6bcCV/qQy65I/lVbnE0ILaHUuX7byA14ALDrVFqdK02Ly
         elIg==
X-Forwarded-Encrypted: i=1; AJvYcCUKuFbKzdToMBVBb6lPsGJuyFZA4bqrMBmLe91W+ascXPto2/tUKLaCsac+qykt3dows3/MJg6qviq/v2X2@vger.kernel.org, AJvYcCWOV2h1od3CgogiIKRf6fwz8Kl48sHQD0MUnYuU00IHOzDMf/Y/ex5/nnbs7iBflFxXOZvoTKb3pZeo@vger.kernel.org, AJvYcCXE/h//+Ib1YbKFLn7raUdGlZ+/iAmDe+u3omL3DDdGAT1y39K0Ba0OnMFuaCsBRL9Ul2jkv0X7n6BqZFdSVqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyicNrWX+BCmKjn4G/byr69eXn1M/5s7wY7JSFafKbV61I1ES7o
	qNXDuuR6//lZOBq8MSPsoscMDBNk9Y9v7228tVmfAvTJ7+2oXzxj
X-Google-Smtp-Source: AGHT+IEuijIqFI6OQlhAdRImRAPPN07texv3tKxOiUMeIi1SzD5bVxGHWNZ7z/oU6Gc9t12Xhw4Zxw==
X-Received: by 2002:a05:600c:4f53:b0:426:55a3:71af with SMTP id 5b1f17b1804b1-42c82f6cf51mr28782565e9.33.1725301961742;
        Mon, 02 Sep 2024 11:32:41 -0700 (PDT)
Received: from void.void ([141.226.8.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb43esm146783615e9.7.2024.09.02.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:32:41 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] docs/mm: fix a typo
Date: Mon,  2 Sep 2024 21:32:05 +0300
Message-ID: <20240902183210.2130-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in documentation.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 Documentation/mm/hmm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index 0595098a74d9..3dcf1b69e807 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -405,7 +405,7 @@ can be used to make a memory range inaccessible from userspace.
 
 This replaces all mappings for pages in the given range with special swap
 entries. Any attempt to access the swap entry results in a fault which is
-resovled by replacing the entry with the original mapping. A driver gets
+resolved by replacing the entry with the original mapping. A driver gets
 notified that the mapping has been changed by MMU notifiers, after which point
 it will no longer have exclusive access to the page. Exclusive access is
 guaranteed to last until the driver drops the page lock and page reference, at
-- 
2.46.0


