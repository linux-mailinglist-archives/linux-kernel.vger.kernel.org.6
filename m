Return-Path: <linux-kernel+bounces-190488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D2F8CFF18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882491F22F04
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C9115D5DB;
	Mon, 27 May 2024 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bK655h36"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156915D5D1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809670; cv=none; b=b+71e/hRm6GNCYj9YiChx3vyggbyPN3wL/AYYHMCRanksQZjn29+1TYmILAFoLHhP8CWu0ERyFrumuk8H/OcE/Th+DK7xpR3xJw19H9tTUMShwMgoO+FNNufsmvIiO1/mm3AeI8hwX7dHv+9wmCkoCzBdwwqDwefcgyBsrUNpWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809670; c=relaxed/simple;
	bh=OC1Rb60Ba8be4bnOiEGYyhY6UkqotkiIdasGqOZQU5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cnty+bL5pedK8TJ7sRCGCWOVtWhddgusunKbJK0trVsYCURMw8HJFxnXkSK5xFEYuaEXNhMcrTVwgyinPALEmKJeKeWrKRzwJXGuf7OBcSTc0twj2M/eG2h3mlF2S+j/NI5BNg+WzFjr+Fkm/Yxr+7Tj57Yx2kscsQ85qtLyq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bK655h36; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e72b8931caso93144611fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716809665; x=1717414465; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbzLL2VPIDYK8tN1C3V377NJW7L8M+DWKxx9vVoK+64=;
        b=bK655h36kgZUy+h3iW5pq+qGAYhWPlIBrwfZmQ1d48+bZ+Xc2ymq0wXXnlYHNpOZcB
         36nxzhgdcOw8wMekLRraoMtthhXjA9kC/QdKGBl3SPMbjXWHkMSvb72eXtMHhKuxzrbY
         SHrP4lr97YS8/QDHoexxAzBmUHRjhoVmZOpNvAxBtNs9mi2Mw/LMbh3qIPBnZRPMBOkp
         JmYtwC2HCujce0l859mjVdUQI544dGQWFFERhBuXDADQrcgRYicmu5Mywv7A1lJfmzkt
         B+0KrF6ySKpDzluMpDusykrCl4zv2G9cZbUqAp9bC5Emu7JliUAlvqHgkiySjObxkeOI
         m/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716809665; x=1717414465;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbzLL2VPIDYK8tN1C3V377NJW7L8M+DWKxx9vVoK+64=;
        b=FP4NorkMParGyvfXU1PuKlSBW9wFzkGpgHoZhEtVHHtfOPvJXIMcmTliBnQ0K+L5tJ
         Tao8A87UBEzhHIcjZ0lQN3pA/Yoruhshk68h1/ZHuV8enSAz+VyW2v/jxp0fB2CV21cD
         S21ILo1sQnme1r1mlzrR1xjgv/owJp5pS6BZHrAHX/20Xzz5eucU0W7S9flpsHKTOgHV
         nudLJIKgdyvN2boUTF6Z7wdKHfhe+rqheazMmgo4TXtNQIuyC9RCvNsXDLWzJMnP+YpO
         QUZqz2HZmxpwrUMBwRXVdWtSgmVHlqlsqoLCe9NFCcRt/V8n+cft6ReNiAYqDk8Dnwuz
         Bb3w==
X-Forwarded-Encrypted: i=1; AJvYcCWA0paQbaOFDM4o0NFJMFro49eGeHO2GyiaUEgHcXIA9m3RpdNRMHuUzacl1zuDjeCThbnWdWJjRnI3qBBEPQqh7nb8diATEUrXBpUY
X-Gm-Message-State: AOJu0Yyj+NydEwqCuB7zox5LpOuTF4rVCsu0svfh06qvXOoWNlBiJOqp
	CeGp29xZTR1uShWoczLhwQ4iqKMyRfdsr2OGyYWd9bVJkUOOQ3vHAoSEx+sIazNTm8zmjc/dIDB
	x
X-Google-Smtp-Source: AGHT+IFl4YHkdXAbKN66OtXSrxBgVM40Vwb/8rTssE8Y0aQJ3uhdSfmlhlJrjFCknibOqb+s9UdBOA==
X-Received: by 2002:a2e:b385:0:b0:2e3:93c2:4239 with SMTP id 38308e7fff4ca-2e95b094455mr53060481fa.21.1716809665556;
        Mon, 27 May 2024 04:34:25 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bdd34fcsm19074691fa.93.2024.05.27.04.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 04:34:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 27 May 2024 14:34:24 +0300
Subject: [PATCH] kbuild: verify dtoverlay files against schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-dtbo-check-schema-v1-1-ee1094f88f74@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL9vVGYC/x2MSQqAMAwAvyI5G9DSun1FPNQ2ahAXGhFB+neLp
 2EOMy8IBSaBLnsh0M3Cx56kzDNwi91nQvbJQRVKF0bV6K/xQLeQW1ESNot6qlrjxrbxZCB1Z6C
 Jn//ZDzF+O8wTfGMAAAA=
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=OC1Rb60Ba8be4bnOiEGYyhY6UkqotkiIdasGqOZQU5s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVG/A60GyIkk2vaLbu3ajqx6tKSHcr3PfniHwo
 fy6qgCMOKOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlRvwAAKCRCLPIo+Aiko
 1SRNB/9A33+w18LGzSBgOy6BeVyfVoBE2rJJu7vYjEi5q78BnT4HSc2Uj9QGgcNIfRMSilfKvdD
 Wof8ST1tE/Omq5DGSHO23ETp93YKlot5FIfcwyED/lrA77usXKDpmaomU0nDhTx2erK8JwoNfgI
 4FyOiWDKt9N7mIcHi47B6fjYcJItAIbZQ+enCVoMsou034RE6Pc2wyssJ7TGB+BFKPD+xL4jo5W
 TRTbv2BITkzO/SEdU1mrUAm/liLPgvztJffA64JesDrazxKHDKNdf9Vu1TniyzCl3pC82IYEXt4
 yM0XcVBP3Fj8WccQ4irUPv0tX2l39aza/TFcn1NIW1Its4k3
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Currently only the single part device trees are validated against DT
schema. For the multipart schema files only the first file is validated.
Extend the fdtoverlay commands to validate the resulting DTB file
against schema.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 scripts/Makefile.lib | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 9f06f6aaf7fc..29da0dc9776d 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -407,8 +407,15 @@ cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ;
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
+DT_CHECK_CMD = $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA)
+
+ifneq ($(CHECK_DTBS),)
+quiet_cmd_fdtoverlay = DTOVLCH $@
+      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs) ; $(DT_CHECK_CMD) $@ || true
+else
 quiet_cmd_fdtoverlay = DTOVL   $@
       cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)
+endif
 
 $(multi-dtb-y): FORCE
 	$(call if_changed,fdtoverlay)
@@ -421,7 +428,7 @@ DT_BINDING_DIR := Documentation/devicetree/bindings
 DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
 
 quiet_cmd_dtb =	DTC_CHK $@
-      cmd_dtb =	$(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
+      cmd_dtb =	$(cmd_dtc) ; $(DT_CHECK_CMD) $@ || true
 else
 quiet_cmd_dtb = $(quiet_cmd_dtc)
       cmd_dtb = $(cmd_dtc)

---
base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
change-id: 20240527-dtbo-check-schema-4f695cb98de5

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


