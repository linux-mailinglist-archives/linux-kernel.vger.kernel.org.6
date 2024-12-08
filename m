Return-Path: <linux-kernel+bounces-436312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED59E8437
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 09:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574E11884451
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA7112D758;
	Sun,  8 Dec 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCNPAKcn"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA961EEB2;
	Sun,  8 Dec 2024 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733646832; cv=none; b=s0eSVd+4BWCVK46nQcQD2F5K9E1Z+j46rHvWPP4oB3/lvff3dGs93btrFnWzVyIU/XkSqiCVjVbFzf6VUV/P3zos2gDGV34gF6aiBfmllvrlAg6wCxdlTla81J/RD7G7M7Hu3nAuNsdFUU4o9UOltnm5791H3vDXyOeTSrop64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733646832; c=relaxed/simple;
	bh=LsixBaNQBztp8+7IVMfzPngbtALIlUbTwASBXYGGbtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1WEKhYX4VKdZBPmPNjUVQIANAjMVbsFMV9+5oW9tlq/srLaoIKolbeCm46B4RZ1q1cKulszHCpLcDGC4gTBse+gGKQythG4xcyfyc5JWczlZyU8k98yx1YxZ+viqvZ+kf2V7kjgLLJLzrFtMeH1tD9sE6f8Ml3ZicUNARvv7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCNPAKcn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21636268e43so6196305ad.2;
        Sun, 08 Dec 2024 00:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733646830; x=1734251630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw3/MnPygfVwqBQ+Lnx4ztMSGybvWCwzMsFDEjO+5IA=;
        b=CCNPAKcn42405TQteucywjKFJR0hFt/aJtfcpaaag/nIQPS69UTr35O2i/Uyvdz+RP
         5XvmpJhJwXNwrnJj5/1MRGqyyNspW/siQDBsqPLzX8Vde2dAZAvbJg82fGVjrK0HA+dv
         i0Xiqz24fkZmTXiaFCZEUbqYSJDXiMZI4DjFx3M902ZWU++T+A3OYyF3H6l8ISzbEOS1
         +EtqS3iT5SHCPi1CWMZOsrP5HTWcPR+3vwfLHu8SeBmvTp9lUHvx/XI0yYHQVnuEPdrp
         1fewaUhXAsjREbqW6vjH6eyW29DTUy222eK9+847YeQLCom1yKVy8KAkyL4x5ipqwPSR
         TXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733646830; x=1734251630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw3/MnPygfVwqBQ+Lnx4ztMSGybvWCwzMsFDEjO+5IA=;
        b=VbowdKCP8oq4zKhbkcMkY1kCCEiG/EGf2W/0VjvOIZVQ1gypzYrVuNQqPomTiX4Vus
         t8X5uEla8WQx05bVRSxs3Od1ykXtRhjQqGfHF2SrV/9kHK9myv40tfQB6gQrja6bU7kd
         7hm2Fhj7XgDPjPsZW7HMbtabcnoU3/47GMv4QdC+7Wq8Fwk1lamd6ZMWb0cAI3ywc1gM
         tICM+dvidmRVVBFNxk+Ph/BehSvcCQ/qNEdgvbx05Zyix1IsRru3MihJ6+KciyGGs99M
         2j/axTEqVMy96A5eJLLWxHOGVqeU5ofeNYpknRdNOpHRvWMBZ3L21B0J0PYaDv94+hOg
         3Z/A==
X-Forwarded-Encrypted: i=1; AJvYcCWY10q7IDqChRXkv+dOGlHcdHMjI+IUiHmEhba4E0npAz6tZIMZdZ92NBosrw/wwKej7GNiaoF5UXeQnuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3P4sKFzbqKVUc4et1DzIghKbXAwLauAd4D1SMpVWhi5TeUtjt
	QHxa8DK1jgDqM9NoXZp+mYte7Hz3yvQxoW/3TlRZaTYKoMxk5ske
X-Gm-Gg: ASbGncs8qDmKUOBYiiw2/ge2u/dfQw+bSJPa0IWtwCuTcWt5/+PPSU4k55hq9gcmlSZ
	k2wDKj8JYf70KwRVC2p25skEpbrUY58egntZjOUHsMZMN+MyYUvh0jAhB7WdDLXoTWGP0WpEdCx
	QLZjYqKKGqvSZugfvLB6ZlbhZq5nAoXXAAF0ivAQDkWJP2yu2aeBni8WEucPZeUD3kNAKPa+XCY
	GKEenwwk3pJlcsV4npNVAq3YR2jvejBoV5FfGdLc4mcUV7rdm9bkew1sNxvQfxPoQ==
X-Google-Smtp-Source: AGHT+IFURXnikmIuPy808nl59u0diMFBQpfZ/DgZlI44giGlkMlKRrocXhrb2cbHC0UfL7/XIu5qkA==
X-Received: by 2002:a17:902:cf4b:b0:215:773a:c168 with SMTP id d9443c01a7336-21614d1aeddmr158483645ad.1.1733646829744;
        Sun, 08 Dec 2024 00:33:49 -0800 (PST)
Received: from localhost.localdomain ([49.206.118.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e7cdsm53400155ad.10.2024.12.08.00.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 00:33:49 -0800 (PST)
From: Saru2003 <sarvesh20123@gmail.com>
To: bsingharora@gmail.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saru2003 <sarvesh20123@gmail.com>
Subject: [PATCH] Documentation/accounting: Fix typo in taskstats-struct.rst
Date: Sun,  8 Dec 2024 14:03:20 +0530
Message-Id: <20241208083320.16190-1-sarvesh20123@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <878qssu5d3.fsf@trenco.lwn.net>
References: <878qssu5d3.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected a typo in the 'taskstats-struct.rst' documentation. The macro
name 'TAKSTATS_VERSION' was mistakenly mentioned instead of the correct
'TASKSTATS_VERSION'. The corrected line now references the proper macro
'TASKSTATS_VERSION', defined in '<linux/taskstats.h>'.

Signed-off-by: Sarveshwaar SS <sarvesh20123@gmail.com>
---
 Documentation/accounting/taskstats-struct.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/accounting/taskstats-struct.rst b/Documentation/accounting/taskstats-struct.rst
index ca90fd489c9a..acca51c34157 100644
--- a/Documentation/accounting/taskstats-struct.rst
+++ b/Documentation/accounting/taskstats-struct.rst
@@ -47,7 +47,7 @@ should not change the relative position of each field within the struct.
 1) Common and basic accounting fields::
 
 	/* The version number of this struct. This field is always set to
-	 * TAKSTATS_VERSION, which is defined in <linux/taskstats.h>.
+	 * TASKSTATS_VERSION, which is defined in <linux/taskstats.h>.
 	 * Each time the struct is changed, the value should be incremented.
 	 */
 	__u16	version;
-- 
2.34.1


