Return-Path: <linux-kernel+bounces-282027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57594DEA0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 22:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A7F1C21530
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 20:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F57013DDA2;
	Sat, 10 Aug 2024 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HfdLvVdn"
Received: from msa.smtpout.orange.fr (msa-211.smtpout.orange.fr [193.252.23.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983483CA1;
	Sat, 10 Aug 2024 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723323223; cv=none; b=pK6g4Y+b2UmGX6EC4LQnvjFkq1Th8rZXSyFzMtWRT7B2ghBmEv9d33zxCs0hgVXDSQ05RDB4Rn59/xCWYyOIirQlBY0YEO+fSfqNb/MNR7CdWlvPTMTsZQVleWddekK2HA0tVXAk7S9WD5La73tQfv/2e8rjz8WRiWZxO+OCnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723323223; c=relaxed/simple;
	bh=57Gb5iOBwKagGAbuQ5OIFQ1d9VwsdVWPo1WBsonn8EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWCAdl7VB1aEoUf94Ku+XaDlq1EEYBXfC7cGnc+qaSPjMBycfllXV36XH5E0DOV/vxxCOVEGCD60e09oMcON1N60qdBGSjWZbgkkD2Mb6YLnuupgRMGI6VeZ/DEjA+QZPSr4DRxExspPoLh81VhTmPH6VOol00dB5FjHpuxIFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HfdLvVdn; arc=none smtp.client-ip=193.252.23.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ct4YsQhfG3VI6ct4YspXs9; Sat, 10 Aug 2024 22:52:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723323143;
	bh=43d3uOIcW8QezMC9CUty94x+xF7qIsJvgPKmflbkadU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HfdLvVdnu1vAyuQvgZk6NT2f+arBfQ10rr/bBp4JOUz/cGo+w2AX/kQGNHruvDMnE
	 BEdr4t2KD+cs7OewygUcxECv0rvEngLzQASvLZJlUmNWn/1I1cpK3NXrlD0wshpKG4
	 O/TOEEDZvv721qzdKi08ss3wqYy0aZTQg5dMxA5Jq4sHDc48iSQfCNEisH15HwoPQX
	 Uu1Dk3Z6fgWg6JAqtotiF+9RhhEmIhUHj0nae/CV91wVd9AoT7kKH6mCleTtFP9iw3
	 kxk23XTov2U2hJr1Hzmizt8qsd8Iy9R5fb9qDDGkhmTPrvDyn0+btO9ouo+H63P3aQ
	 fcOmlSrhSOILA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Aug 2024 22:52:23 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: gadget: configfs: Make check_user_usb_string() static
Date: Sat, 10 Aug 2024 22:52:17 +0200
Message-ID: <958cb49dca1bff4254a3492c018efbf3b01918b4.1723323107.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"linux/usb/gadget_configfs.h" is only included in
"drivers/usb/gadget/configfs.c", so there is no need to declare a function
in the header file. it is only used in this .c file.

It's better to have it static.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I've not checked, but I suspect gcc to both inline check_user_usb_string()
in its only caller and keep it as-is for any potential other callers.

Before:
======
$ size drivers/usb/gadget/configfs.o
   text	   data	    bss	    dec	    hex	filename
  41197	   5120	     64	  46381	   b52d	drivers/usb/gadget/configfs.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  40834	   5112	     64	  46010	   b3ba	drivers/usb/gadget/configfs.o
---
 drivers/usb/gadget/configfs.c       | 2 +-
 include/linux/usb/gadget_configfs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 0e7c1e947c0a..e0bf2b2bfc01 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -12,7 +12,7 @@
 #include "u_f.h"
 #include "u_os_desc.h"
 
-int check_user_usb_string(const char *name,
+static int check_user_usb_string(const char *name,
 		struct usb_gadget_strings *stringtab_dev)
 {
 	u16 num;
diff --git a/include/linux/usb/gadget_configfs.h b/include/linux/usb/gadget_configfs.h
index d61aebd68128..6a552dd4dec9 100644
--- a/include/linux/usb/gadget_configfs.h
+++ b/include/linux/usb/gadget_configfs.h
@@ -4,9 +4,6 @@
 
 #include <linux/configfs.h>
 
-int check_user_usb_string(const char *name,
-		struct usb_gadget_strings *stringtab_dev);
-
 #define GS_STRINGS_W(__struct, __name)	\
 static ssize_t __struct##_##__name##_store(struct config_item *item, \
 		const char *page, size_t len)		\
-- 
2.46.0


