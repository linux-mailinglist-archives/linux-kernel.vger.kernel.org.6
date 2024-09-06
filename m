Return-Path: <linux-kernel+bounces-319420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD0F96FC62
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A941C2469F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C41D5885;
	Fri,  6 Sep 2024 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhbLdm17"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C011E86F;
	Fri,  6 Sep 2024 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652461; cv=none; b=RshsJocdW2QUcF6HrR5Vp9Vs8+nvZr4DDANePM7KNGyAofYhoy0EydYJRz0L2O84oWhn2VFJRkViKtcnHiwYdz77JbLNrEQO0UKqVHZGhiwPdJM9H3Ea7RFbTxbYlWmsVofkPopMTBQCvOk5qUDsZ+jNFoyQnujLzxEJ8+PAgi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652461; c=relaxed/simple;
	bh=sjAM3VQD4+zuRHxIxfJhwni0vZTgCqAmO9Nq2E34HQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWmqm8Go4b3ctiNeA4GewGc1cKMbHl5OhGx4rbiX3Xern2Orrg03nyJDU6el5bsx9/my1fhB2yTDZgwVcKcaKOMiFMVsB0kcwaUFXrfBBvdZYdv8sXhEgKeFsFnby4RtlkyU/ctDRO24Dr14p5qR4pX9j0woB4rzHU8JrLqIpbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhbLdm17; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c34fb4f65eso12109916d6.0;
        Fri, 06 Sep 2024 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725652459; x=1726257259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CsdSrVyqeemyTzfAitC4EmwS3QBR+rYGCwhOM7Zz1U=;
        b=UhbLdm17ZJa16HCM8zLLmURGzavErwBOoSy9cwwa4ghl5AVbRl55gMhc5sNOci5Odz
         vhLoANZaK3B/pllPjy3PH7Q9Ma7AWCOB8av+8H9uzBtWhWNpCEpFj05bQFl+BZtJJs58
         XDfo9vnKOZIrIFKTg6BVdFzNukV8Ljfy9xIWU08gTcN1h28zdmMtwfqYwAvmzc71uGFe
         WhcW1vBJWbbV8o+mCMJedBlG0SPkgtjsMvVmVL4j04wi86dES1OxTFDptVU4CAxsAejY
         HOr5Rs5zcM4mjsHk3od6GKVRyULfeH5O9tDctzip8PqRTPn2Cc63Lp5KPEi6KHpBVlc2
         PA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652459; x=1726257259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CsdSrVyqeemyTzfAitC4EmwS3QBR+rYGCwhOM7Zz1U=;
        b=uV0nVylIw0EEWZE3XplcoG2Nsb3t7lMwbpbWykwG8WTCvbPwX81+TU4Nj7jGG1Y2fr
         5AhLvTlYGZ9HZaT1779v7e+Dle+tcWvmVGnlgLj0A7tJeMKtWHaGsVgwsxNZ8nUgNixU
         ogMxHpJjm7hag8N4vIjJ8skzh+c9CzGxgn2T28c21uU7Ixioupk4Ur2a4vCjIn4NVK4n
         p+ssA+lh0M6PUPYm28UrVj4nAJIsSOtf6tiFPhcgbIsYrmGNhQWo6FCBgsqQrTXrczHb
         h/9l5t1f7DmhPvIxBBuG/ewTceUUlRP8hAQrZt0hOJwNJ09WnMELlRwVrnEL4PRUdFr9
         /yog==
X-Forwarded-Encrypted: i=1; AJvYcCXCyK+kSpRrIUdWj309kpgrpv1FyCqhyP7IPVllZrJ6bsfVmyI2MVXEx93Jq/vrLPWqkhtcYKYxlXue09t7@vger.kernel.org, AJvYcCXSBGWI66Ecl2GP78HbNZDHvXd4B8Q6VUG5s+WS518bDTn1cH8oQEK0NezEFWlQUDFQUPQbp4PcL7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzXUO+N4alaKlZ6d1IdyaGCyWL7VrShS6mjczXP92cDHdwRVRb
	IkqNBtId0i4EW/6pSbDSaOt52JpNGetqapwf5gco6jaSHrLWHq+vrsssxfXR
X-Google-Smtp-Source: AGHT+IGIzOjTcS/g80AXf73nfAVdiLoqlxceO81bFWcEfo1pPQqWtGD9rHGL6jwVZQHsUvKNz/jweg==
X-Received: by 2002:a05:6214:3d9e:b0:6c5:1711:81d7 with SMTP id 6a1803df08f44-6c528527d88mr61932976d6.33.1725652458554;
        Fri, 06 Sep 2024 12:54:18 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6c5201e051asm19505096d6.10.2024.09.06.12.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:54:18 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: corbet@lwn.net
Cc: Dennis Lam <dennis.lamerice@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs:filesystems: fix spelling and grammar mistakes
Date: Fri,  6 Sep 2024 15:53:52 -0400
Message-ID: <20240906195400.39949-1-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 Documentation/filesystems/journalling.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
index e18f90ffc6fd..0254f7d57429 100644
--- a/Documentation/filesystems/journalling.rst
+++ b/Documentation/filesystems/journalling.rst
@@ -137,7 +137,7 @@ Fast commits
 
 JBD2 to also allows you to perform file-system specific delta commits known as
 fast commits. In order to use fast commits, you will need to set following
-callbacks that perform correspodning work:
+callbacks that perform corresponding work:
 
 `journal->j_fc_cleanup_cb`: Cleanup function called after every full commit and
 fast commit.
@@ -149,7 +149,7 @@ File system is free to perform fast commits as and when it wants as long as it
 gets permission from JBD2 to do so by calling the function
 :c:func:`jbd2_fc_begin_commit()`. Once a fast commit is done, the client
 file  system should tell JBD2 about it by calling
-:c:func:`jbd2_fc_end_commit()`. If file system wants JBD2 to perform a full
+:c:func:`jbd2_fc_end_commit()`. If the file system wants JBD2 to perform a full
 commit immediately after stopping the fast commit it can do so by calling
 :c:func:`jbd2_fc_end_commit_fallback()`. This is useful if fast commit operation
 fails for some reason and the only way to guarantee consistency is for JBD2 to
@@ -199,7 +199,7 @@ Journal Level
 .. kernel-doc:: fs/jbd2/recovery.c
    :internal:
 
-Transasction Level
+Transaction Level
 ~~~~~~~~~~~~~~~~~~
 
 .. kernel-doc:: fs/jbd2/transaction.c
-- 
2.46.0


