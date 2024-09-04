Return-Path: <linux-kernel+bounces-315791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFF96C706
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3A41C22104
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0D813D630;
	Wed,  4 Sep 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cd2h17eD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBDF13C69B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476599; cv=none; b=UdjXIMPA6i9+vdkWrraE/YOWIRyk+at71iI1WlmXlu+Ny91P2gsq0Pn7LOcoHLJyPBaphTLHHOJzJJp/bdShQC1m/uZXEoAcqwUfJw/1RifySiL4jiYFLUDRNtDCNdY6UjiI7q8fePlBo0jv/s47kemPlWgU9uaBn0WIJZ67OtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476599; c=relaxed/simple;
	bh=LwYEJo6o09T+842OUp0RbU+NfeLRXXK5UVtu56xqzNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=edEZzY559ENp5CmcELscbS64xsteW8e22f3+3cA6QvGVuDvOIfsAkXedeLxfYxwASwto37fdAIccB8xRfKAAnYAy8NUXZfkW3Q7y8xZtLOi0/MI0xtHD1lVLJHdc/qDEDpWnfIoQdDNM9DgLwTETTJ8YdcVrEi1Vf8ypKT2stA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cd2h17eD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2053525bd90so38789315ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725476597; x=1726081397; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0D7251HzR81gHX5jZCvP/igmoNgdiJeJnsoApOKoy4=;
        b=cd2h17eDqRSDebitPAio6Rk9AF1xju2B0n3ztLI7lQFu4+IiQCf5SOlIdqKkpyIbzv
         V/NGPnJUpycpTDhdi2P/efr4UC2G0PC18DRXJ0uP/foBaQKP293SiN2ugV51/lQkVpJW
         PYVEwcIhEy8A3yAtWyzbV3Y09LbL9XUjrqeziPgXTr36PDNnhGJmbrHUS35CmO9ZsBX2
         dWo0OX2DiXz1XPdyprqdg9yxdzApeTGuU/ZZdFTqbVjUnqhU5HccuY2W+ecAnZbZ7Bks
         EHoHr5WjZgyiVal3hP7BrjxHujl623gYnv5q6kBKrztfbFYqk+mMGVV9chAc/Sj9ERWT
         QshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725476597; x=1726081397;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0D7251HzR81gHX5jZCvP/igmoNgdiJeJnsoApOKoy4=;
        b=oxh0bNhPiVNxRkQQXDjEq18zq/elgwStRDu7QLbucaZ1AVITUlfxbCBdCfMhtY+Rwc
         5wZtt6rsZg0DcV25d29ggjbbMm1Gnve34PPj/C7YdxZnh6N4gSPUZIxwwd7uqbWZjbXy
         dvnpLFVagCJH1sVimW661KAKXcumd91uqUFwnrFH4AO0MwaTgQkdRZYURx93NJCc+bHN
         TgdPvLPJWB8y0LfWeXKNotH/BI4vnce4RsjnvpN7ZbHRhX9beq+GU33L/pQ3Tu3GJVVx
         QnIhTmWzszHt7RNF3IYoA0fAnomiLuFIk7wJEl049Zk+6iLVgQujQ9DyfaGW1IPaKPMM
         2OTA==
X-Gm-Message-State: AOJu0Yw9yTEwoYoInNlKNoEmXLgXwx2ArBPzuVb0EWMZ87s1eovGY0XM
	15BWGHCoGge95STNzRfmFa3CJ1oxE4EbBBmQ5bpKsgf7T5yBKuVIawsF6f2BaCw=
X-Google-Smtp-Source: AGHT+IE7VOMf3ppAq0KbmxDhvh+WfeH0HUmFNzMm+YrUzM3vrGKSTl//0B4vrQ6LzZAUQCdmrPVI7w==
X-Received: by 2002:a17:902:f68a:b0:202:ac8:991f with SMTP id d9443c01a7336-2054bce5e85mr99689315ad.26.1725476596915;
        Wed, 04 Sep 2024 12:03:16 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9505b7sm16755135ad.89.2024.09.04.12.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:03:16 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 04 Sep 2024 12:03:07 -0700
Subject: [PATCH] fs/xattr: add *at family syscalls to common syscall.tbl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-xattr_standard_functions-v1-1-60ccfa9d41e0@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAOqu2GYC/x3MwQqEIBCA4VeJOa+gJmH7KssSpmPNxV1mLILo3
 ZOO/+H7TxBkQoF3dwLjTkK/0sK8OohrKAsqSq3Bauv0qJ06Qq08SQ0lBU5T3kqszYgyfnB5tn0
 fPULjf8ZMx7P+fK/rBpDMnKVqAAAA
To: Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=LwYEJo6o09T+842OUp0RbU+NfeLRXXK5UVtu56xqzNs=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9qNda+fxC6zWv9a2W2WVlj6OhfjwAX1az3btt1fMOn8Z
 70EB58DHaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAExEOp/hf+F2fWXGtz+dK+1i
 n8xx58iTv1R/sfdGqLx5z+Yz8jHLDRj+KUyTMlAOSm4oOHEnTPlN1bKNZYuMl+9id1N8FJrruOI
 TMwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Commit 6a7fb6ebe371 ("fs/xattr: add *at family syscalls") didn't add the
syscalls to the common scripts/syscall.tbl that was also recently
introduced in commit 4fe53bf2ba0a ("syscalls: add generic
scripts/syscall.tbl") which a handful of architectures use.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 scripts/syscall.tbl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 845e24eb372e..ebbdb3c42e9f 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -403,3 +403,7 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+463	common	setxattrat			sys_setxattrat
+464	common	getxattrat			sys_getxattrat
+465	common	listxattrat			sys_listxattrat
+466	common	removexattrat			sys_removexattrat

---
base-commit: fdadd93817f124fd0ea6ef251d4a1068b7feceba
change-id: 20240904-xattr_standard_functions-1864fb233c8e
-- 
- Charlie


