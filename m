Return-Path: <linux-kernel+bounces-207172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 335EF90133E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 20:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6CA1F21F7C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA191CAB9;
	Sat,  8 Jun 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loif6Zv0"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2B1BF47
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717872154; cv=none; b=Spnt/W5+4/yt5DScREHW+edUwsc992U6QPBBbc38zzKq0pp+jGU76avUM9zr65VhgguhJqClhZ9wU5jLnoiaCsVw7P/iuTEt400IslZJumE/7lJV9JUlx6VZNaGgTyO4i2V9BTidnNKsAuhaDvpWNdbUzfFqNRUdRSHbkzXagBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717872154; c=relaxed/simple;
	bh=60R9bElBX9vuDPwrJY9GGMz9/9prp1ljHtjQ8ovslRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZfPhO3FMQwsfjGuT54UpYVttHE0O66B4pO1g5lGZYI9KYnxfOA6MQeqKLplNqFykXHv6eV53H7klTpYwTfKIMTmBOM2speXLzasNWBLFBMpbPh04+2LFGQAJfvzIdgXchHd336YlrUR6NNUAvVdcCtZdd1ZylCC3egjlGUQRBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loif6Zv0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70417a6c328so1248028b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717872152; x=1718476952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnJ7/aQ/WWEpgURJ0oL3mgCg6+vYhnKqhoFl7B/S6zI=;
        b=loif6Zv0tJImjDbsJXAvoxSplkN6V9u40SkMP2ry5YQD0okqJRXyfGmCcmHya9JFpX
         adzCLFcPmqWmk8VevQp2sp/xHT9PIqCvFSVq4CIEYKZ3DTFnff/jcMA34D+nMESkZuH4
         KmbHE5d+r1i7DZ95loGhCzksCvUp7l8BNQDA3705d9c04VQVIuugJNbRXvP6BeM0aOdq
         2Y1jXf9JARlRcWweTcjmndbG0kuSMaAZITnZL/mGACoySDh86Op19lZruWXkcV3dzpp1
         p+f53EjS+Eikt+fzNZmymEYn8WAcnYngFY0yT2CUx4qYKNPFYCUbI0XrRTlMEQ4hKZvA
         qSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717872152; x=1718476952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnJ7/aQ/WWEpgURJ0oL3mgCg6+vYhnKqhoFl7B/S6zI=;
        b=m8Bwap26l51X4wPF4IvNWHKSr3hbQoIlmam52ox60IOlwugguC1ZsOnQcZsfw/WkAr
         GiMBRGF/nZ9OAHJ6Id6lp+U5ZfOvLMZdFXtpdzE3YZ7G8bVVov6r6d6Mu0WWgHvl22tO
         2JLN6WpHqNfq67RToOll6QEpK0cWpob4cHA7W1qn66yDkIMKg2cAU+H3BkU0dBQVE81Q
         fOEbuDQ7FmFc2bz/POdX9vHc3H6j0vcKy4/QuBwlUj+95ts9cF3rNbRKspPx/rxKCi63
         zmGwY3AtpWTd/Yk5LNwR3VZ1rOGNw1tnv+3NhcY4UeHs4+fK+q/kXVe/h6vilmkKtSiR
         MX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKj0G1lrHFbY6DnBfJiFB7ppFUieMfp5I7kS26pYmDwcsfvMlHCUQZqnX35VTsS3jHW6AdwF4Am+Z95LYNxK1yuuoBe7KMJ6AGMzi+
X-Gm-Message-State: AOJu0YzOmI83O+YdAQ+XBPjeGcftEnLtY2VB5bUYR3y4EvT0bkzwDQrc
	6IrVYeeIImhiT8VI1LMMUYR7QV0myDzkeRY1m15wLJc8fOBC18/K
X-Google-Smtp-Source: AGHT+IGD9n2JL9aeYm1jQ2mS2lR6xMdQ9+XHhumhVOXyQy8832xUQ+hZhVLeSibUpUkcK8InftoY2Q==
X-Received: by 2002:a05:6a00:3d10:b0:704:1c78:4f8a with SMTP id d2e1a72fcca58-7041c785413mr3636546b3a.21.1717872151948;
        Sat, 08 Jun 2024 11:42:31 -0700 (PDT)
Received: from mari.. ([2804:431:cfd3:42f5:56d2:4948:9090:477d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd3780absm4324264b3a.21.2024.06.08.11.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 11:42:31 -0700 (PDT)
From: Marilene A Garcia <marilene.agarcia@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marilene A Garcia <marilene.agarcia@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dca: Change the format of kerneldoc parameters to fix warnings
Date: Sat,  8 Jun 2024 15:42:10 -0300
Message-Id: <20240608184210.1393921-1-marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the kernel documentation, the format of the parameter
descriptions should be "@arg: description".

It also added some missing parameter descriptions and the module
description.

Signed-off-by: Marilene A Garcia <marilene.agarcia@gmail.com>
---
Hello,
This subsystem seems unmaintained, and because of that, I was wondering 
if you could review the patch, Andrew.

These changes fix the following compiler warnings.
These warnings happen using GCC compiler the command 'make W=1'.
Thank you.

drivers/dca/dca-core.c:171: warning: Function parameter or struct member 'dev' not described in 'dca_add_requester'
drivers/dca/dca-core.c:226: warning: Function parameter or struct member 'dev' not described in 'dca_remove_requester'
drivers/dca/dca-core.c:258: warning: Function parameter or struct member 'dev' not described in 'dca_common_get_tag'
drivers/dca/dca-core.c:258: warning: Function parameter or struct member 'cpu' not described in 'dca_common_get_tag'
drivers/dca/dca-core.c:283: warning: Function parameter or struct member 'dev' not described in 'dca3_get_tag'
drivers/dca/dca-core.c:283: warning: Function parameter or struct member 'cpu' not described in 'dca3_get_tag'
drivers/dca/dca-core.c:296: warning: Function parameter or struct member 'cpu' not described in 'dca_get_tag'
drivers/dca/dca-core.c:308: warning: Function parameter or struct member 'ops' not described in 'alloc_dca_provider'
drivers/dca/dca-core.c:308: warning: Function parameter or struct member 'priv_size' not described in 'alloc_dca_provider'
drivers/dca/dca-core.c:328: warning: Function parameter or struct member 'dca' not described in 'free_dca_provider'
drivers/dca/dca-core.c:339: warning: Function parameter or struct member 'dca' not described in 'register_dca_provider'
drivers/dca/dca-core.c:339: warning: Function parameter or struct member 'dev' not described in 'register_dca_provider'
drivers/dca/dca-core.c:396: warning: Function parameter or struct member 'dca' not described in 'unregister_dca_provider'
drivers/dca/dca-core.c:396: warning: Function parameter or struct member 'dev' not described in 'unregister_dca_provider'
drivers/dca/dca-core.c:428: warning: Function parameter or struct member 'nb' not described in 'dca_register_notify'
drivers/dca/dca-core.c:437: warning: Function parameter or struct member 'nb' not described in 'dca_unregister_notify'
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dca/dca.o

 drivers/dca/dca-core.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/dca/dca-core.c b/drivers/dca/dca-core.c
index ed3dac546dd6..f849386f8424 100644
--- a/drivers/dca/dca-core.c
+++ b/drivers/dca/dca-core.c
@@ -17,6 +17,7 @@
 #define DCA_VERSION "1.12.1"
 
 MODULE_VERSION(DCA_VERSION);
+MODULE_DESCRIPTION("Intel Direct Cache Access Driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Intel Corporation");
 
@@ -165,7 +166,7 @@ static struct dca_provider *dca_find_provider_by_dev(struct device *dev)
 
 /**
  * dca_add_requester - add a dca client to the list
- * @dev - the device that wants dca service
+ * @dev: the device that wants dca service
  */
 int dca_add_requester(struct device *dev)
 {
@@ -220,7 +221,7 @@ EXPORT_SYMBOL_GPL(dca_add_requester);
 
 /**
  * dca_remove_requester - remove a dca client from the list
- * @dev - the device that wants dca service
+ * @dev: the device that wants dca service
  */
 int dca_remove_requester(struct device *dev)
 {
@@ -251,8 +252,8 @@ EXPORT_SYMBOL_GPL(dca_remove_requester);
 
 /**
  * dca_common_get_tag - return the dca tag (serves both new and old api)
- * @dev - the device that wants dca service
- * @cpu - the cpuid as returned by get_cpu()
+ * @dev: the device that wants dca service
+ * @cpu: the cpuid as returned by get_cpu()
  */
 static u8 dca_common_get_tag(struct device *dev, int cpu)
 {
@@ -276,8 +277,8 @@ static u8 dca_common_get_tag(struct device *dev, int cpu)
 /**
  * dca3_get_tag - return the dca tag to the requester device
  *                for the given cpu (new api)
- * @dev - the device that wants dca service
- * @cpu - the cpuid as returned by get_cpu()
+ * @dev: the device that wants dca service
+ * @cpu: the cpuid as returned by get_cpu()
  */
 u8 dca3_get_tag(struct device *dev, int cpu)
 {
@@ -290,7 +291,7 @@ EXPORT_SYMBOL_GPL(dca3_get_tag);
 
 /**
  * dca_get_tag - return the dca tag for the given cpu (old api)
- * @cpu - the cpuid as returned by get_cpu()
+ * @cpu: the cpuid as returned by get_cpu()
  */
 u8 dca_get_tag(int cpu)
 {
@@ -300,8 +301,8 @@ EXPORT_SYMBOL_GPL(dca_get_tag);
 
 /**
  * alloc_dca_provider - get data struct for describing a dca provider
- * @ops - pointer to struct of dca operation function pointers
- * @priv_size - size of extra mem to be added for provider's needs
+ * @ops: pointer to struct of dca operation function pointers
+ * @priv_size: size of extra mem to be added for provider's needs
  */
 struct dca_provider *alloc_dca_provider(const struct dca_ops *ops,
 					int priv_size)
@@ -321,8 +322,7 @@ EXPORT_SYMBOL_GPL(alloc_dca_provider);
 
 /**
  * free_dca_provider - release the dca provider data struct
- * @ops - pointer to struct of dca operation function pointers
- * @priv_size - size of extra mem to be added for provider's needs
+ * @dca: struct created by alloc_dca_provider()
  */
 void free_dca_provider(struct dca_provider *dca)
 {
@@ -332,8 +332,8 @@ EXPORT_SYMBOL_GPL(free_dca_provider);
 
 /**
  * register_dca_provider - register a dca provider
- * @dca - struct created by alloc_dca_provider()
- * @dev - device providing dca services
+ * @dca: struct created by alloc_dca_provider()
+ * @dev: device providing dca services
  */
 int register_dca_provider(struct dca_provider *dca, struct device *dev)
 {
@@ -390,7 +390,8 @@ EXPORT_SYMBOL_GPL(register_dca_provider);
 
 /**
  * unregister_dca_provider - remove a dca provider
- * @dca - struct created by alloc_dca_provider()
+ * @dca: struct created by alloc_dca_provider()
+ * @dev: device providing dca services
  */
 void unregister_dca_provider(struct dca_provider *dca, struct device *dev)
 {
@@ -423,6 +424,7 @@ EXPORT_SYMBOL_GPL(unregister_dca_provider);
 
 /**
  * dca_register_notify - register a client's notifier callback
+ * @nb: notifier block to register
  */
 void dca_register_notify(struct notifier_block *nb)
 {
@@ -432,6 +434,7 @@ EXPORT_SYMBOL_GPL(dca_register_notify);
 
 /**
  * dca_unregister_notify - remove a client's notifier callback
+ * @nb: notifier block to unregister
  */
 void dca_unregister_notify(struct notifier_block *nb)
 {
-- 
2.34.1


