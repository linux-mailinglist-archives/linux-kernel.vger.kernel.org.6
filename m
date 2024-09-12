Return-Path: <linux-kernel+bounces-325931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF3975FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34792855FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23427188A18;
	Thu, 12 Sep 2024 04:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbcooVQJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303EA188925
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113868; cv=none; b=SVclxvMHDi+WnEjzf/3ipP+zG+FzMebK4bSOsebA4BaLsCt3BfLhAvcxxk5649SYZMigNWysbxKn5TBpN34zqVmlFIyaogBEaGypclvUvzrgos9jaI68E9CqJN5wEnifPULVWbs1F7cbMMsAOgt5kex4TtJYMjMq6ShAN25Yzr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113868; c=relaxed/simple;
	bh=M/w6m9DICbb9fXeBmwD3TpLOWGHWyG5+dW06Vu7C2OA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqNSu7/JQ1MmXvmC/JD1xrmmydZG5FAHqUk8n3xELxKmgc87Bm7dYBHqDnrhgU8VOWS0Fue4SKB4JeYujKS1C+7i4VcSDLNHINxfPVCoTadcN3BhqRYDU+g9VMEeiuaShovEyvSffhZ8CN3rn2VqWjd7vXnfh8z9ohWzc+a/EGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbcooVQJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2068a7c9286so6230185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726113866; x=1726718666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXAZo/WXx7kQtnIHCo6QHKKFh7guoGvOfoFWj/T8o7Q=;
        b=jbcooVQJCwbaqrAX/dN4wsIz4lcLRDLeGAZZfz1II0okvG3TQQFzS4v/U+6ZZIlCTZ
         uyt397iC687JRa4DoFQQVgNvbXtAzft97xZzukJT3Z/Jplfy5domwmPs4dW9B/FMbeR9
         17dNNAAd8AwD2+1NagbZihA2rb7pfSGo5AvDTBANlT3wq2unKFVXPkpL42U/lR9Djuqa
         nVeLM4kPNpq422eDQHyzexni6f3NzQcbcqIORWWZynzDORcwk41vdMDfBCnn8OtSPKtc
         hcAnZ0049ij9MY2YUFZJp167zg2gSDIcCV+A0G3r6Wtm14+cXojAt5kxcXt8SAkhn7J9
         ENqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726113866; x=1726718666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXAZo/WXx7kQtnIHCo6QHKKFh7guoGvOfoFWj/T8o7Q=;
        b=VCc0d6xMYjWbekKlyYyqWyMDpRkYZl6G3gEYqAMZPe/8J/T+55Im9yQROGw8m7dHfc
         ZdRYgmdpmpVk0DkUBhK+wCRn5q282B+XT8M46rUS3qtEX+90U3K48pZfjRsZ0gfW17oE
         B6G/MP28V2MkVM/LabrPGMDzcpi/QT3UKEu0pA2Dzv7WCLK/affAZRSf0qG/vNcV+DdC
         r7c9NP47TFviG2d07T32WuV/EocrFNXW2kbEpkjg/PejY7Q1x4Zd86bFLj1/PxO7yWZf
         vhXu8tjUDGLnrRJysame5869Xas0T2m51LnE998XRS60zD/oJBEW9K7GUpoJGGbSbaHk
         oYHA==
X-Forwarded-Encrypted: i=1; AJvYcCWAll7+nGNbnBiFCjKivLHOndxi84akjNmaVB4A0pVUXqM7MXvUbih5eeUt1WtUq1C9ckSV9wbY2aWDLQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU15KFSobLohakFflgzGT54A99+qRqOePqIiWwtdW9lXIux8J9
	vs93gvd+lpepgQKxbx3DI+cNPQFB6MYvkHQyAewEWsR7nnjayPtP6hZVo9vodow=
X-Google-Smtp-Source: AGHT+IEwOwRcbvDGeBmGe2+PqEHYraSrG3E+xfqMBWjwAWDIkNbu50hVm1cxU45xYhJ5lvlVG/oiHA==
X-Received: by 2002:a17:902:f684:b0:207:5ca3:8d23 with SMTP id d9443c01a7336-2076e4767c5mr18339695ad.59.1726113866410;
        Wed, 11 Sep 2024 21:04:26 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([2409:40c2:12a7:616d:eca9:534f:4e49:7c41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba469fsm768359a12.11.2024.09.11.21.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 21:04:26 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	guilherme@puida.xyz,
	philipp.g.hortmann@gmail.com,
	linux-kernel@vger.kernel.org,
	Sayyad Abid <sayyad.abid16@gmail.com>
Subject: [PATCH v2 2/8] staging: rtl8723bs: include: Fix indent for switch case in rtw_security.h
Date: Thu, 12 Sep 2024 09:34:03 +0530
Message-Id: <20240912040409.3315067-3-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
References: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change ensures proper formatting for better readability and
maintainability.

Reported by `checkpatch.pl`:
WARNING: switch and case statements should be indented with tabs.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 .../staging/rtl8723bs/include/rtw_security.h  | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 953076667b4d..74613ad9a371 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -191,27 +191,27 @@ do {\
 #define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)\
 do {\
 	switch (encrypt) {\
-		case _WEP40_:\
-		case _WEP104_:\
-			iv_len = 4;\
-			icv_len = 4;\
-			break;\
-		case _TKIP_:\
-			iv_len = 8;\
-			icv_len = 4;\
-			break;\
-		case _AES_:\
-			iv_len = 8;\
-			icv_len = 8;\
-			break;\
-		case _SMS4_:\
-			iv_len = 18;\
-			icv_len = 16;\
-			break;\
-		default:\
-			iv_len = 0;\
-			icv_len = 0;\
-			break;\
+	case _WEP40_:\
+	case _WEP104_:\
+		iv_len = 4;\
+		icv_len = 4;\
+		break;\
+	case _TKIP_:\
+		iv_len = 8;\
+		icv_len = 4;\
+		break;\
+	case _AES_:\
+		iv_len = 8;\
+		icv_len = 8;\
+		break;\
+	case _SMS4_:\
+		iv_len = 18;\
+		icv_len = 16;\
+		break;\
+	default:\
+		iv_len = 0;\
+		icv_len = 0;\
+		break;\
 	} \
 } while (0)

--
2.39.2


