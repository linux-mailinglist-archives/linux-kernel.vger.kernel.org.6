Return-Path: <linux-kernel+bounces-423796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3779DACD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919A8164359
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7841F2010E0;
	Wed, 27 Nov 2024 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvFO5LTJ"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22313BC35
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732730853; cv=none; b=dO4V9UU4201an4mMJSTlJdRQotULvVQR99VTBzvWYDpPz9zj465OkNFV+NbihZYiHS4obbHdQOl2mw2b2bo8TUK0Kzau7hUeX95hCMwZk4BwWg0zerAsQYStuK+10V+PjfdSKKs8mcM4T4aHGd5z5YKWLhxF1x56/UzD++j992Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732730853; c=relaxed/simple;
	bh=ZZWe+lujI7ps+VqdwJ/CTFy83PNrDorIopGskoYYJ+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jh5zgGtnxYQRQW7dwG4c7T2qQEgZvCIvRaaHOt8X8gVspllVGvSv0FLz/14wYLZghFOc1uUBYQc0yUKJQqAvbLYBQzoow6pzewtLoSHfqBnRd+V/bSLNgZxUl5LyvwinStumbpx4xmIeglTb7RGRymKsb09D4DyX8MJXQy8gkq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvFO5LTJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fbce800ee5so5127286a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732730851; x=1733335651; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JO30qC1eSltn42wpK7uNVVN0jMketuZWZbHs4oqRlAQ=;
        b=mvFO5LTJMNS8vLKC4e3OwfUofgMKvjWNLztQyyDXa4Y8TOcrsbC0qlQLCFbUiZauvq
         7Tw79GKOy/SkAr+xyfFjTgEYVaQjHpbYp5NH/+XpBDOVoSrsoLynwIBdg3IltKskcid1
         izzWgp++sWa/n/PA1tV4ftmx7bb3EzNYXF78fb7/6f9N6ptHjJO/DzTaM4BEFwKN/Xnj
         xRFcm1i8iTozJToPyaVUkakY25+fGB484Y64HUgJmINE4uEk/xG9+54ENYObe2nQ3yRB
         PSbg6HoXdDK8rrFUGyRwvNPrF5BZkaxKc3FxoDkdGpiiy9TQAeT3QWpklzjIDoWX3Ol9
         0ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732730851; x=1733335651;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JO30qC1eSltn42wpK7uNVVN0jMketuZWZbHs4oqRlAQ=;
        b=Wda3cCfN58atWfFghs0f8pEKAmpt7pckBFtBps9jJqCBGNACEF2//hzI2nK1tAvGs7
         buiyGGJ09cRHzaTJMNS6V2cffl0XQIiBVa9Y2GvcEzpAE+tzziSCnfWTd3UEJy4KYNp2
         sHRzvgjYKjTVhN+J8G+h/5HyrQgH4fe/CDaRnqxnHB0BXSVTlLE1huuY1hs53SW5GUGx
         C0BnaAO5NgqdPuVx2v4x85oQpXuvitxKoeWVuZ1fRPCiuGjOwOQpVXgPmcKQJgXLwEBS
         0jI2lVJFoSm4O63/nR7dPb0vRctH2urRu0gK5EVXZYA5cyQGGviKfmJqfntE3/iQnwVq
         RleQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYgiSpxccIfYxZu+qx5+7mbBclwPwFMDAx8+Q9dcDm6lwCQBL3U9kMaNkPNt+Y81DW7YYgrRbtq3k3lvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZckceZD1IXrkI0Nhz+h/wl+wsHxmr+3pRduCNRWFE57THql8C
	D94F7yr01aznBTuTfDhz0e0iQeydCuWfSrLcrBwtx43Yem1G3u8MvpP2DlNkzwU=
X-Gm-Gg: ASbGncsAMncN4RC6LIRNVSwQAXYsMO1PS8uMLZU/4rwCScrFAaqHd67jR3cdv5mdJCa
	HTk+oVpgyZr8rmVxKgPBF1d4ZnCUrAZYsJDG5xELsx936AaXE4lpHW+AKQlEHXySpetiSWRixXS
	GpIoYnriArx//zF4yOnLFcj66tLh0Esrn60M9hUhMEsRJqMYOZVyvaxe/W2Qz9iK6tOUgmrLuaO
	czw5Zm+6jsh3dHTz8mUvV9MPOehSUFkSoot3e4XrTd4zwpx
X-Google-Smtp-Source: AGHT+IEQWEnf6QRiWgGsqOun2h8lAiZr/UDSJLZHM6NPDAPayRvgiSyLW+yiRwUBfx4n/fjfjJMhDA==
X-Received: by 2002:a17:90b:2245:b0:2ea:546f:7e7b with SMTP id 98e67ed59e1d1-2ee08ed43f5mr5366189a91.20.1732730850828;
        Wed, 27 Nov 2024 10:07:30 -0800 (PST)
Received: from Emma ([2401:4900:1c94:da7e:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa41f69sm1880374a91.2.2024.11.27.10.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 10:07:30 -0800 (PST)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Wed, 27 Nov 2024 18:07:25 +0000
Subject: [PATCH v2] mm: shmem: Fix variable type to int to evaluate
 negative conditions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-unsignedcompare1601569-v2-1-e85098fb02b2@gmail.com>
X-B4-Tracking: v=1; b=H4sIANxfR2cC/4WNTQ6CMBCFr0JmbU2nUExdcQ/DopahTCKFtNpoC
 He3cgHf7nt5PxskikwJrtUGkTInXkIBdarATTZ4EjwUBiVVg0XiFRL7QINb5tVGwlaibo2Q+q5
 NrbDRNEIpr5FGfh/Dt77wxOm5xM/xk/Hn/p3MKFC4xhpXu4u2WnV+tvw4lxj0+75/ATA0VJm8A
 AAA
To: Hugh Dickins <hughd@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Gabriel Krisman Bertazi <gabriel@krisman.be>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732730847; l=1454;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=ZZWe+lujI7ps+VqdwJ/CTFy83PNrDorIopGskoYYJ+M=;
 b=bUY7isYj/AMuTElo/5ozkbncFrqqSVGrZ2PhWQzDroDdDUTH5eRaLbxnSHrC+g8I9dfxcS6ZZ
 kWUz+7qVpqlAznEzM51Q7PI8Ph5XCmSZbYGuO6X+EI5qW7GVwg2l76C
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Use signed data type for version handling
in shmem_parse_opt_casefold()

Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
Reviewed-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Coverity Message:
CID 1601569: (#1 of 1): Unsigned compared against 0 (NO_EFFECT)
unsigned_compare: This less-than-zero comparison of an unsigned 
value is never true. version < 0U

Coverity Link:
https://scan7.scan.coverity.com/#/project-view/10043/11354?selectedIssue=1601569
---
Changes in v2:
- Updated the log summary.
- Link to v1: https://lore.kernel.org/r/20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7987deb2be9b..17a1d4fa8870 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4367,7 +4367,7 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
 				    bool latest_version)
 {
 	struct shmem_options *ctx = fc->fs_private;
-	unsigned int version = UTF8_LATEST;
+	int version = UTF8_LATEST;
 	struct unicode_map *encoding;
 	char *version_str = param->string + 5;
 

---
base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
change-id: 20241111-unsignedcompare1601569-05b5932145ef

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


