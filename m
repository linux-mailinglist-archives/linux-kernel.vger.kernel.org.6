Return-Path: <linux-kernel+bounces-272562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC43945DFF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF34282C5A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AB51E3CA8;
	Fri,  2 Aug 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qT9vfXZe"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37897A31
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602571; cv=none; b=DYSCgelzGH0V9Mp/MqeEThoXyKHoI/NT/SDyTqppjtumog2scMlb6ABTBaIizKARRZVRyrn144sGTeviDdxhyynEOl23exGu63WgNIFOiMMqOfx44SzYHAMhMduGFz5lEW5aK9VELiQuI4Hf2XaaqhnO47U7kTz0duX51IKkwao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602571; c=relaxed/simple;
	bh=JQbHb3wb9GmZbLb2lP1xsq9he0gRLzjMXI3ALAcuAVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sA7h7CBXbggHEBGNQQt6fVDj3hdqPQiuTa5DxvADaHyLUODEgF8zEMR1055GHX+gMG8c0vj5PxkbMvVdyoVCMszn5kRlz9rhOaWlvnTbLu6ijfkl0Ry4HRrsOgnIIL12b2x4tUUaIjJd195UuIkB4XUnyK9T8p79nEarDbUOX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qT9vfXZe; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so100834131fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 05:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722602566; x=1723207366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrcFEM9bWKbHe8BdVEa2eoVCT4l9ZPX9mDywu3rn/YQ=;
        b=qT9vfXZe+gRDZbXS+i9Eg0fV0n/SguvHQbm6LBUZRkMCLCu2Uh4/mUuh8QGjl75tN6
         RIorNPNdNB9nWRvmhUJ9HIWJT7SXyyHwGDkziSu5FlWB7kClz+LnxVZo461bT1/d2sCr
         mCf15e6pJQNsG1l8ZTXVeYaJZTbO9BXlD+Cw0HIfTRKRhe40xiKLXT4cARPfYrrRjUN8
         Z9CeWzYTe07yQ2OZaUcFvZnpI+OrQN85CqT/DpowoZw++909B7cZ/0G8JbWhcmPBY3tR
         Y6uwxTdWH2tVjpbh/a1JvsarmpsNsKETXLiLn4LGDasU4MuZSe9ik05woQbJM7jkEgzv
         XfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722602566; x=1723207366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrcFEM9bWKbHe8BdVEa2eoVCT4l9ZPX9mDywu3rn/YQ=;
        b=ERabF8EtX7RmwFMvJj2fJw/EBMhLRWRKkSYcXQob3zd1F0wWNZOz1vUb+eVLoFNzkH
         +uL9wHmB+u5pwUidXF0CDXGLdsypvo+sJNkH3M762RKxg2vSGfT7N+dPnRq5WhQpX8Kj
         tC4+M0dOD3EeVcx4RJSQ+4XMUn7wxRupGEOwHFlyaTcv1nGJ5ohXr/kCEZ/qbF+BIM6u
         zqB++Wd4KjfmPJe+xN9oxH2jBpCIFbECkbCwfZ4Z4nOT5pRYlTWPwuvhVA9F4goOTplV
         AiuyP0/X1z5xLO5ytZ3ziCMEgXc5HaY2f4NkzumgIB4AUPIj4H4bsTdN26btkZAkpgh5
         VeTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZkAKOIU/jRetrDXaUWFDmLCufGffpXcbXLNK1cBEr4w64YF4DD81nU2a6HKb09BLj/RxRZYw4Gvl8R1eTanRnvxHXTtbRlDppSKvQ
X-Gm-Message-State: AOJu0YyXkqiENFUk1N1qg5LTNdhBo7KLBHvjq/+1UoV+UJisZyMYzWOA
	br9NavZ/Lx+BdY62rLFlowvkjvMWqu4oDtxXZRZhft7xkUgHF8Z4PHQz6ntonsVEJeFB8SuG6KE
	6
X-Google-Smtp-Source: AGHT+IFFlN2cMSr0vXkJIVvYd6FpLrCrmugN2ZmipRM2wW30hpHdftDoxaWrrrkBjnMizoNqG6qvKA==
X-Received: by 2002:a2e:2e03:0:b0:2ef:2543:457c with SMTP id 38308e7fff4ca-2f15aab06f2mr22014211fa.24.1722602565947;
        Fri, 02 Aug 2024 05:42:45 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1864ebsm1512601fa.26.2024.08.02.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 05:42:45 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: masahiroy@kernel.org
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] scripts: kconfig: merge_config: config files: add a trailing newline
Date: Fri,  2 Aug 2024 14:42:36 +0200
Message-ID: <20240802124236.2895857-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When merging files without trailing newlines a the end of the file, two
config fragments end up at the same row if file1.config doens't have a
trailing newline at the end of the file.

file1.config "CONFIG_1=y"
file2.config "CONFIG_2=y"
./scripts/kconfig/merge_config.sh -m .config file1.config file2.config

this will generate a .config lookingn like this.
cat .config
...
CONFIG_1=yCONFIG_2=y"

Making sure so we add a newline at the end of every config file that is
passed into the script.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 scripts/kconfig/merge_config.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 902eb429b9db..ce1b77ee043b 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -136,7 +136,7 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
 		echo "The merge file '$ORIG_MERGE_FILE' does not exist.  Exit." >&2
 		exit 1
 	fi
-	cat $ORIG_MERGE_FILE > $MERGE_FILE
+	cat $ORIG_MERGE_FILE | sed -e '$a\' > $MERGE_FILE
 	CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $MERGE_FILE)
 
 	for CFG in $CFG_LIST ; do
-- 
2.43.0


