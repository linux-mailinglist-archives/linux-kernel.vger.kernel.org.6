Return-Path: <linux-kernel+bounces-325934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11195975FED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39D0B22CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C5E189B8F;
	Thu, 12 Sep 2024 04:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIrw9SYf"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AC189B88
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113878; cv=none; b=Tv6XlpP+D7kTe8Pr/y3lltev/9pv3mSsizLOq21x+LZsnuZM1GTOeORr4KRhnNMU8Rqt1L4Pv7n4K1aWUaDzJ3weMW7VN+L+Nug4byOGnf4MFiO+Sq9bOj8Q4gRbEGGco/LS3FXsyAji0zDYqzvXqFK9hWqHrlMWmtJaiC2fe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113878; c=relaxed/simple;
	bh=bdIGBU+mN34bLbOLajFGFB6iyFx+5wKylOR3Xogz2ZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUEaqd7EOOgHYBc/FyENeuz1ehyKvItl3Q973dTef2CiDQ2+nDK7PGD/UQMvYcPA6UhIMKfvmB/w4uQTD5ZS9gzXJLq2fIi6zKciw0Skz34EbKJloWrvwLUSZt/AHUa77Y4vJycTPK2ZOm+Id0bTJdaEwCop5zO2vjpziZeGYkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIrw9SYf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7191f58054aso408949b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726113876; x=1726718676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jyB7App+A0wL+Wf0fFusO+M//VVEnQeF5FHyKNWVAA=;
        b=gIrw9SYfDiXsN7WT4/P8bK3DPZzUsK+YESP55zL9HrkUhK+uezc1WbxDuaQq3BWlFH
         dweJ2XDJ6yWYWoVtizjTJJlCOOCEW9Ca4IIw+WvYpL1f7VA2VfMfp9JHePDrcygYWC1f
         Y8XmAEVLUgY32dymfXc5oyexfwSEup04EwmberzE7MiDs1ljPZvGZnyZAGHDBWnrtK9t
         6XqX2eYA8Kr6oDqYMWrJ84mURX5+nDH4O8r41BsvPNXG5h+CsB81zmou5BzSQlm50ZLk
         unyGlnAYVk7r9bHCG+2nK/iMv7y/T+vwCTbEitgtTrAvpRbW8KEus4KFHlROEprI93Xw
         zoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726113876; x=1726718676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jyB7App+A0wL+Wf0fFusO+M//VVEnQeF5FHyKNWVAA=;
        b=rx6/Pwh0TK2prp0jHqiu3p9/a90/802c19s8kgdRPbNrJaxadG0xTuS8fJSOm5omQq
         J1kAUKdk3HAF0kNP4A94PCj2O6jA6tfiqvNvVe08CspDRHsDOgIwOpBpwxDII9Cg5vLW
         abQaF5kJQtbNUuqkqW0ntUpbIBRwc/B1pRH2DloTS71R0PgFV2NFaUb3JpmYV+UT+Rqt
         5uEmGHX0xcxNKN2KjEYpdCUJKD9TbbTL6cZvcZ3p85ch8Kh737yjXhNiC/PKgCNk8eTT
         rDBk9MsK26prHCFEWdGQeDjXzXWTX53frbSw5hHZPn6KmGYz6YhvRHD8H3GeUJTi3qVm
         DJMw==
X-Forwarded-Encrypted: i=1; AJvYcCWEBRinm6E3LiOWkleGkXi7x/eNHexl7+Cy2Y+oDs6P8YXtOJxX4TvSa3IolgbH7snskiQknY0EkXakrGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGasOVpoAusKUpcl/0SdbSX8OfRyfyCxTP0eQkYRKfnq5wybdy
	3lrBfm92nNMz5mOaxviZMLA7DfwSEaGBagivsyOUSw2YCVsmX5er
X-Google-Smtp-Source: AGHT+IHoAJwpGouIkghtKvkT+FudpoXg3/xOSYGChcm5MDvyNE4oN7rlrza/YeB4qkv+l0DSFMJJ2w==
X-Received: by 2002:a05:6a00:228a:b0:717:87af:fca0 with SMTP id d2e1a72fcca58-71925f9de4emr2599012b3a.0.1726113876396;
        Wed, 11 Sep 2024 21:04:36 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([2409:40c2:12a7:616d:eca9:534f:4e49:7c41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba469fsm768359a12.11.2024.09.11.21.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 21:04:36 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	guilherme@puida.xyz,
	philipp.g.hortmann@gmail.com,
	linux-kernel@vger.kernel.org,
	Sayyad Abid <sayyad.abid16@gmail.com>
Subject: [PATCH v2 5/8] staging: rtl8723bs: include: Fix indent for struct _byte_ in rtw_security.h
Date: Thu, 12 Sep 2024 09:34:06 +0530
Message-Id: <20240912040409.3315067-6-sayyad.abid16@gmail.com>
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

This change ensures consistent formatting of the struct declaration.
Improves code readability.

Reported by `checkpatch.pl`:
WARNING: please, no spaces at the start of a line

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_security.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 0c3271fb7e9d..7901cce76443 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -50,14 +50,14 @@ union pn48	{
 #ifdef __LITTLE_ENDIAN

 struct {
-  u8 TSC0;
-  u8 TSC1;
-  u8 TSC2;
-  u8 TSC3;
-  u8 TSC4;
-  u8 TSC5;
-  u8 TSC6;
-  u8 TSC7;
+	u8 TSC0;
+	u8 TSC1;
+	u8 TSC2;
+	u8 TSC3;
+	u8 TSC4;
+	u8 TSC5;
+	u8 TSC6;
+	u8 TSC7;
 } _byte_;
 #else
 struct {
--
2.39.2


