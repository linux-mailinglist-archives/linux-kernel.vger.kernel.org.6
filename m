Return-Path: <linux-kernel+bounces-554914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1854A5A352
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB16188F02C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85451233D89;
	Mon, 10 Mar 2025 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbaQKioD"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D0234989;
	Mon, 10 Mar 2025 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632092; cv=none; b=SwJMQNwPFRi52GTvU22xf6gKWFQf1iYUJmLUAunSCozW9udzeiFLDuQuPmyLIIrPItrfxi9vN+LuNq3TzroZF+x9NgE7FtLtFXePqrbv3IMw56ml0+4UdZEB2XQzKLi6vAOzD2XeIU6k6rRWqd4iDzjdyu34e6mYOB+V50f1giI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632092; c=relaxed/simple;
	bh=IQ8l5g6sMagIDU+kR0KS3nMtoySw4DwumRcGbI8TyAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=khgA2a95mcuFhW70QDUrNeao9V6jxqyqh+OJuYHGwNxzeyj4iJEc85fYc3TIxsk1enDwE9oGNuyOn+5dxGSgikHuuP9usW+1sJccSdq+OmeK0M9oesoQuedsJeE1X+jbJA2r7QJL+6joSd8myDeaSRoU1dj2I5eElBgtDXAOM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbaQKioD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22401f4d35aso82113005ad.2;
        Mon, 10 Mar 2025 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741632090; x=1742236890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B61KUVTuggZHqIjZJXZHkqKcS+C8QJT6SN4kadhnsBk=;
        b=KbaQKioDbsYkYXZr3SpfsjcONRZtXB1PcGE56rjwVq8L+NVke626EDWXfx27fvou1z
         2ae0kmIcrTvJneccbnOm5NTh1478gEXRK4QtHkOhu9bwztLZ8jkOnXT5KBdUIwiIAGRY
         ePZ6xmIsAfZoON68qI5sxMdYbCM0xrRyBAGRft0SJO4SxsLsUiIoIWibGSSLAU9quzGI
         BtsL6zqx3qovOoBExM2r39yTqHAkxOKMD/Oa4JqrIVykL/9upCA4UMT2Eoqh6anHLbut
         YjVWQA4aoFwRE2hpFnNMtsfuxtVBskcKGvh04+//FmJEpdrNvAx2EGJNhxzRAVIVBjTa
         sgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741632090; x=1742236890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B61KUVTuggZHqIjZJXZHkqKcS+C8QJT6SN4kadhnsBk=;
        b=Leu6gEES2yAEcZWNDDGJL5bzKPTrAB4tJM4TV+njAV/BFkL9Mqf4YwPeiZfZR5ElPa
         EUQv7chwcTkCJ7ViLT+GXTAoZS1FXg2IeE+oiuT7b94KwLL3RMZxHVsJCgnJagfd4q1Y
         OGKv7FrW2pbOgydlkXAysoAqPOWCQj5YK0Y2RxGWOde/fubnG8PNxstuAV3kbdpPCZAM
         epIQAN04LiiTEtdO69rxbFA7nvZ+poHxko/HUDZd/1eddyz2whe7Q8pw7qEoqZxQNBHE
         Q52guILVAr6kBXkLCfjTj6f1s6ZVv9QRxI5bMtNPO4pLWRTTVyr6ZAfBCcFO2pl0QwVP
         muyA==
X-Forwarded-Encrypted: i=1; AJvYcCUPnSBm110K2A4lGBkn5fl3+QlE47G0ucHGm1rOZCwkG+5NgSFTGfmGEyQHads/OgtPUch+0BeB7Jddct5F@vger.kernel.org, AJvYcCV4KML0PnXI8ExioHUc57sWhCBPz15cuV+joHWbh7peOUMTtQR9bsxC6YcejJwO0bIpebQndYWO9Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwNTUkaTqZmRMNJu2to+wVfDQGmWFiXVMmNVo1PkgKldIHsNbT
	FEckm2rCbbbdGAyQ9I69qCx7YlNbu/WNtc2YAwQTJK0qxFzjTfOz
X-Gm-Gg: ASbGncszex3qKgY3Y6gAMfKo6PeIKQYeKiRFrXTQnf5ZnxOP9lfYfJb7D8LB96bCaMT
	1zk6MW3f09G3KaJJpP885yYTJOlAPMn5KQTfUfFo/ibmFhoX1Z04CQsVy6bmQ5d8gvGdHiiB8+p
	KAe52ThOuVVJlpEns2yMxzA4TdnWf/gcLyYeyMh1Cwgw+uKicJlqHYLDhOBs+l6hgd7yMCKgmwj
	ZQePA+cf75zJiMBAcoiGBMSCu4+2jse4ACLzm6X6qa/80YLrC2dIhIamB12xd1LkQjrz/Ug4+G6
	0dmwhm6nm+m+1dGCeB/MmZ52LGx9cT8JMAcFeFBSO9Xh
X-Google-Smtp-Source: AGHT+IHkfNs77dRpHRw7m7Dy6Y50/e2amOEC9HUe81C+pfsC1RfTlvvZDqE9qifdEI1jqZPUU5u+tg==
X-Received: by 2002:a05:6a21:1fc3:b0:1f5:64a4:aeac with SMTP id adf61e73a8af0-1f58cbb6055mr1152580637.33.1741632090480;
        Mon, 10 Mar 2025 11:41:30 -0700 (PDT)
Received: from arch.lan ([103.6.150.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cbe3fb3fsm3648696b3a.83.2025.03.10.11.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:41:30 -0700 (PDT)
From: kth <kangtaeho2456@gmail.com>
To: corbet@lwn.net
Cc: kangtaeho2456@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Fix typo from smpfs to smbfs in filesystem documentation
Date: Tue, 11 Mar 2025 02:41:29 +0800
Message-ID: <20250310184129.328482-1-kangtaeho2456@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation incorrectly referred to 'smbfs' as 'smpfs'. This change corrects that typo to ensure the documentation is accurate and not misleading.

Signed-off-by: Kang Taeho <kangtaeho2456@gmail.com>
---
 Documentation/admin-guide/highuid.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/highuid.rst b/Documentation/admin-guide/highuid.rst
index 6ee70465c0ea..9239067563a1 100644
--- a/Documentation/admin-guide/highuid.rst
+++ b/Documentation/admin-guide/highuid.rst
@@ -64,7 +64,7 @@ What's left to be done for 32-bit UIDs on all Linux architectures:
 
   Other filesystems have not been checked yet.
 
-- The ncpfs and smpfs filesystems cannot presently use 32-bit UIDs in
+- The ncpfs and smbfs filesystems cannot presently use 32-bit UIDs in
   all ioctl()s. Some new ioctl()s have been added with 32-bit UIDs, but
   more are needed. (as well as new user<->kernel data structures)
 
-- 
2.48.1


