Return-Path: <linux-kernel+bounces-282030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35694DEA8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF0B282B47
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975F513E3EF;
	Sat, 10 Aug 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HEJArlBi"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9713D891;
	Sat, 10 Aug 2024 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723323960; cv=none; b=OdcyhWni+dnKBs6vFGEEIYJgPkh/tuY9Ww94ZaEla5oO+Z96g+bD9UPimgdP+rSvqUH2wELn53VV5V3alTFPvfwABoMajSp2jEzddhRh9QEbV4QW+udtSwZ6w89qopvmtHpHeXN3pzgIOEL/FmmTOJhMR6IpPMjXXFDXh2m966s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723323960; c=relaxed/simple;
	bh=5M13dbH/UYWFj44/578/XxBgNEQqWz7lUjwe5nsr2Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHBJc5qSycEHqcNWx9HyQj/f7/jd0XzFLETP3Irx1VxBbByYMvU5PvO0w1GakMeVawAOHSDw+wThMYsS7EwVHJLeNPXSNBZATl2sXQh7lNdev42AnT3cFIOCBJcbP4BEhl0Bf9BXQuxxQdlrU84LVp5DlpKBm1XyHCNHUNVho3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HEJArlBi; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ctHZsYtNsEQ85ctHZsHrRi; Sat, 10 Aug 2024 23:05:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723323949;
	bh=4Unag6t+OnGOkHwkl8jKDKFC/e/z0rvh/rUlyVIVPOQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HEJArlBi6wQ+0HZykQD0bWCspc8rdl83PYspshd5YtDo27v4dMqsE8mnz5yYVdL60
	 R8cyWrpwtwuzPZ1K0LbwXnfaHXDoIWRJnNTFr6ywVRuHdr9qlxGMgqyM7fIEJZ6HJr
	 YhMwRe2zstIAmVhGi8i7N31ixEHxoYRL9UVsZhg9VFx+OitCIfbqAP8SvcJaDGnYE/
	 cW6VN858wPvc1fTZDhLyfmmV9za8/ms4+iFikvoVt1N/Mn1aJmihsV7FFc941A1vki
	 mG/RH/FfCOBHK6pWqdvQMiYmbT1m3+y+3KgZOuuhS+jrLkuiRWtA7jU4oIu9JTGkE/
	 CiDG+9j46WeGg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Aug 2024 23:05:49 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: gadget: configfs: Constify struct config_item_type
Date: Sat, 10 Aug 2024 23:05:46 +0200
Message-ID: <513223e97082e1bb758e36d55c175ec9ea34a71c.1723323896.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct config_item_type' is not modified in this file.

Apparently, these structures are only used with
config_group_init_type_name() which takes a const struct config_item_type*
as a 3rd argument.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  40834	   5112	     64	  46010	   b3ba	drivers/usb/gadget/configfs.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  41218	   4728	     64	  46010	   b3ba	drivers/usb/gadget/configfs.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/usb/gadget/configfs.c       | 8 ++++----
 include/linux/usb/gadget_configfs.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index e0bf2b2bfc01..5cba3e8d626c 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -902,7 +902,7 @@ static struct configfs_group_operations gadget_language_langid_group_ops = {
 	.drop_item		= gadget_language_string_drop,
 };
 
-static struct config_item_type gadget_language_type = {
+static const struct config_item_type gadget_language_type = {
 	.ct_item_ops	= &gadget_language_langid_item_ops,
 	.ct_group_ops	= &gadget_language_langid_group_ops,
 	.ct_attrs	= gadget_language_langid_attrs,
@@ -961,7 +961,7 @@ static struct configfs_group_operations gadget_language_group_ops = {
 	.drop_item      = &gadget_language_drop,
 };
 
-static struct config_item_type gadget_language_strings_type = {
+static const struct config_item_type gadget_language_strings_type = {
 	.ct_group_ops   = &gadget_language_group_ops,
 	.ct_owner       = THIS_MODULE,
 };
@@ -1106,7 +1106,7 @@ static struct configfs_attribute *webusb_attrs[] = {
 	NULL,
 };
 
-static struct config_item_type webusb_type = {
+static const struct config_item_type webusb_type = {
 	.ct_attrs	= webusb_attrs,
 	.ct_owner	= THIS_MODULE,
 };
@@ -1263,7 +1263,7 @@ static struct configfs_item_operations os_desc_ops = {
 	.drop_link		= os_desc_unlink,
 };
 
-static struct config_item_type os_desc_type = {
+static const struct config_item_type os_desc_type = {
 	.ct_item_ops	= &os_desc_ops,
 	.ct_attrs	= os_desc_attrs,
 	.ct_owner	= THIS_MODULE,
diff --git a/include/linux/usb/gadget_configfs.h b/include/linux/usb/gadget_configfs.h
index 6a552dd4dec9..6b5d6838f865 100644
--- a/include/linux/usb/gadget_configfs.h
+++ b/include/linux/usb/gadget_configfs.h
@@ -34,7 +34,7 @@ static struct configfs_item_operations struct_in##_langid_item_ops = {	\
 	.release                = struct_in##_attr_release,		\
 };									\
 									\
-static struct config_item_type struct_in##_langid_type = {		\
+static const struct config_item_type struct_in##_langid_type = {	\
 	.ct_item_ops	= &struct_in##_langid_item_ops,			\
 	.ct_attrs	= struct_in##_langid_attrs,			\
 	.ct_owner	= THIS_MODULE,					\
@@ -91,7 +91,7 @@ static struct configfs_group_operations struct_in##_strings_ops = {	\
 	.drop_item      = &struct_in##_strings_drop,			\
 };									\
 									\
-static struct config_item_type struct_in##_strings_type = {		\
+static const struct config_item_type struct_in##_strings_type = {	\
 	.ct_group_ops   = &struct_in##_strings_ops,			\
 	.ct_owner       = THIS_MODULE,					\
 }
-- 
2.46.0


