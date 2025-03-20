Return-Path: <linux-kernel+bounces-570222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8B9A6ADF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3244C17A2A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49AF232378;
	Thu, 20 Mar 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE/DoM+k"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B6230BFC;
	Thu, 20 Mar 2025 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496821; cv=none; b=ls8Cg8mFCDCh5wTNSTTf9jiG5BUgGWSeuLX69mr7pLd4r9KY+n/p2NKimYCnFVFbd6AMVR3cWMpi55txOoksYZ8vi5Fy/aNBlBKFaMU/d5FJPPDPREsc5yUGc0KctGCpWJpRuNl2l/fxMpUvNz1st1eDocie0GNr5V6IroDj8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496821; c=relaxed/simple;
	bh=1rYs1TUWIiIJ62WVh7RfOBMZYkEFURY3BrMPDn+40jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRGdk6AfKdGyfa2VCK8Tpdkvnp06AFtaY6oeV4k1KytCO1nIwW8inuUC2owRswFLP8DqAwtWVlcKQb1M8uRSHkepSoiAM5lmA1G5raFULZKgPFAcFBUqsiA1NmtNXZEato99AZnxBhWeP7tWFAaCqwFWqX75+W789TL5HPF+14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE/DoM+k; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b44094782so34865439f.3;
        Thu, 20 Mar 2025 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496819; x=1743101619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYthOB5BI90Xc0sNqdHCeRWErBOeeonKxchWCKHo1mE=;
        b=hE/DoM+k/UD44/jOUvkACL6ju/qnoozNTj7CRJzzW8mtaXbT/UiXuH0tGsaDBHWpg5
         /FT8DhcUbQmNiS1dBAnRx4mYUs1knFoXEjKE8Rx37/Qpi/pDzip/kyvMTZZ3EG96Sa9b
         nWIefeRj1mCBIg4899kwSTpgjEZUlrtj5o6a0Kju1OW/Ql1bjOirmt+ajcyCSbqIxNWS
         Mr1AzS5dDp91lnW7B8ADAiBa2RdFQGtOIoHDF+w3O9WKJutCq/Fb3QpGasq7jNbyZzmm
         8yUPZSjUZhYUmMIeMDry1eMkqnGqMpI2ZO/TPAuyXgjBh0LGcMZTS1EWLeNrrvLjLq7L
         XNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496819; x=1743101619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYthOB5BI90Xc0sNqdHCeRWErBOeeonKxchWCKHo1mE=;
        b=tW4fttFpGYY6x7C9forv7MFEN/1CrTrQ4YQmwZT2rCjPfyJQpP/G6O+PEXgBHJ3l87
         qdLYoWE5Og+VlryoEN5CmB0pBaFfQLOvQUJuKSVnNl5bl0k1Kh5MpHh0Ed240P92FeUv
         UQPtUZpO5o2wvfRUQuXxY2x3KmlVb82xOSiv36FcnSruy6ttF/lIl1+0FHw0x4F8clVJ
         7VqoKpBGp12rz0zaQ4SiTWSdmg1tye9ojzAmWVKPgBi1sdGDTcB0xnJ92vq68FZbZrGo
         BvMrp8di0LevtwtCV2wcXdE+UZLqYKjqaFNbv3KH3sMgmX2pikV2a5NzuMOSp3+/Ip52
         Y7sg==
X-Forwarded-Encrypted: i=1; AJvYcCU5kL5jhznaYpB11CKndDiAZQ3ItXMzBwFG/NAgbW3Ad//Of5WDXxc3/IAYh+8ZiE8dKis5nkcyrPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFsyt2bi1wJe3M5X4snfS9ZJWTMrw1ZytfQnm54G7S9R5luPu5
	Xos6MnpAOiR6CLa3TxWBXJJIu6s0KWE0zNfuEjD1N6gxEr0fy+h4otJflN+A
X-Gm-Gg: ASbGncsYFTNOOPFDY1j5+HCZ6Tl41GmQx+Qcr/9CdDD/GRFhmZKhOj0/WdDu33JFnTe
	Nalbyybg9g9nUUJzwpQsdonkrdt8VR444qzr61Y/vh80hsvXajObnh4Rrdp2tbN5ItlXADr2L/Y
	+1TXyxER99UL6jrTYEd3P+OnWTK6DnZg3XJ8zAP4FOC1HZIcWX6G2y2ouOI4QSVBh5s5hRhjyNS
	TRc7QByH32m85Nc22Psml8lNFztZJYpMtjeVZLRiYskF2Db2+93adMIXQmYSJRXlL5S60LxHYGJ
	XD/onu1dLSkcd4xCvKxIwWziDq3Erwwat50djLtSVOh8EqDm5M7kzTC6jQhqhcHmK6wdlWqRiOq
	zug==
X-Google-Smtp-Source: AGHT+IG1ZN1PdCnSE/0Y/ZVD9TfRAzj/99OndZsm+wv+t2UNLScww8gqg4Ce5ePaZukZWiLiOE/e0A==
X-Received: by 2002:a05:6602:720f:b0:85e:1860:4757 with SMTP id ca18e2360f4ac-85e2c909634mr64857939f.0.1742496818693;
        Thu, 20 Mar 2025 11:53:38 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:38 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 31/59] docs/dyndbg: explain new delimiters: comma, percent
Date: Thu, 20 Mar 2025 12:52:09 -0600
Message-ID: <20250320185238.447458-32-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mention of comma and percent delimiters into the respective
paragraphs describing their equivalents: space and newline.

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4ac18c0a1d95..8e2083605bd7 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -78,16 +78,19 @@ Command Language Reference
 ==========================
 
 At the basic lexical level, a command is a sequence of words separated
-by spaces or tabs.  So these are all equivalent::
+by spaces, tabs, or commas.  So these are all equivalent::
 
   :#> ddcmd file svcsock.c line 1603 +p
   :#> ddcmd "file svcsock.c line 1603 +p"
   :#> ddcmd '  file   svcsock.c     line  1603 +p  '
+  :#> ddcmd file,svcsock.c,line,1603,+p
 
-Command submissions are bounded by a write() system call.
-Multiple commands can be written together, separated by ``;`` or ``\n``::
+Command submissions are bounded by a write() system call.  Multiple
+commands can be written together, separated by ``%``, ``;`` or ``\n``::
 
-  :#> ddcmd "func pnpacpi_get_resources +p; func pnp_assign_mem +p"
+  :#> ddcmd func foo +p % func bar +p
+  :#> ddcmd func foo +p \; func bar +p
+  :#> ddcmd "func foo +p ; func bar +p"
   :#> ddcmd <<"EOC"
   func pnpacpi_get_resources +p
   func pnp_assign_mem +p
@@ -109,7 +112,6 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
 A match specification is a keyword, which selects the attribute of
 the callsite to be compared, and a value to compare against.  Possible
 keywords are:::
@@ -133,7 +135,6 @@ keywords are:::
   ``line-range`` cannot contain space, e.g.
   "1-30" is valid range but "1 - 30" is not.
 
-
 The meanings of each keyword are:
 
 func
@@ -158,9 +159,11 @@ module
     The given string is compared against the module name
     of each callsite.  The module name is the string as
     seen in ``lsmod``, i.e. without the directory or the ``.ko``
-    suffix and with ``-`` changed to ``_``.  Examples::
+    suffix and with ``-`` changed to ``_``.
+
+    Examples::
 
-	module sunrpc
+	module,sunrpc	# with ',' as token separator
 	module nfsd
 	module drm*	# both drm, drm_kms_helper
 
-- 
2.49.0


