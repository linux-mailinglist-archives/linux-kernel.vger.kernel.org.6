Return-Path: <linux-kernel+bounces-188634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B23A8CE4AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EFAB21615
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970E86264;
	Fri, 24 May 2024 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="hwhVQv+7"
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200284FB1;
	Fri, 24 May 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548889; cv=none; b=r5Xdk+Ei3wKf10U2KGjiEod+xoDo2H6wf/7OuvYzx34W2WbTYWbrGEANNynbM6yibqYJz9lUBNiXAEvd7KP3D09DbOxEZVk2E7mCp6PXvSBvwKrnRNetse2+YqcBN24O5jM7Om6qPynYRN7EkEITaQiuPUpKRS4RtRPS2r/Qrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548889; c=relaxed/simple;
	bh=qB3OKxZ5laoTVneS+37D40GLOdr5STSrcxqOLlzRRE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeDYZm8lSTKGcqgYAbKWDl8eVQ0RASiVxrPUIdDNQfNLd/ZEdmQInAsokIA7ERon6fQ/yYP3Z/ew/0YIyGkJUMVli2DTrB3MHeJDiXXWYA9x8ApmVkTXEPdxDmtwo7+IdGTpgb61Y05csGSzvzQSNbeVlIuxdsAkq6iQZ10QATg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=hwhVQv+7; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 5D9E76000874;
	Fri, 24 May 2024 11:59:56 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id 4fIc8mtnwJVR; Fri, 24 May 2024 11:59:54 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 1CA25601A407;
	Fri, 24 May 2024 11:59:54 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1716548394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4+Qy74atNQeDJLgVAQhzpB6gxZrWJ7lUmqdta9ZE+E=;
	b=hwhVQv+7M/YajF5giZU4Y6P8uPDFsWLpB77BlEeUmWZYuebbfd9lE5+9FaFkGjoHANp4Hf
	gHDU+bDLJHWUNE08Wr8XVZ/pN+U+8NuAGbM9c7q/6juKOMduHUXtKlGQh6xu3pS4ujkM+f
	Iitu+13rMzq0OMPWYukKXytkOvPSuvg=
Received: from diogo-gram.. (unknown [136.226.215.14])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id B86783600CC;
	Fri, 24 May 2024 11:59:52 +0100 (WEST)
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	dmitry.baryshkov@linaro.org,
	jthies@google.com,
	bleung@chromium.org,
	abhishekpandit@chromium.org,
	saranya.gopal@intel.com,
	lk@c--e.de,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmalani@chromium.org
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Subject: [PATCH 1/2] usb: typec: ucsi: Add new capability bits
Date: Fri, 24 May 2024 11:58:20 +0100
Message-ID: <20240524105837.15342-2-diogo.ivo@tecnico.ulisboa.pt>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524105837.15342-1-diogo.ivo@tecnico.ulisboa.pt>
References: <20240524105837.15342-1-diogo.ivo@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer UCSI versions defined additional optional capability bits. Add
their definitions.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
---
 drivers/usb/typec/ucsi/ucsi.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index e70cf5b15562..ca4a879d9606 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -225,7 +225,13 @@ struct ucsi_capability {
 #define UCSI_CAP_CABLE_DETAILS			BIT(5)
 #define UCSI_CAP_EXT_SUPPLY_NOTIFICATIONS	BIT(6)
 #define UCSI_CAP_PD_RESET			BIT(7)
-#define UCSI_CAP_GET_PD_MESSAGE		BIT(8)
+#define UCSI_CAP_GET_PD_MESSAGE			BIT(8)
+#define UCSI_CAP_GET_ATTENTION_VDO		BIT(9)
+#define UCSI_CAP_FW_UPDATE_REQUEST		BIT(10)
+#define UCSI_CAP_NEGOTIATED_PWR_LEVEL_CHANGE	BIT(11)
+#define UCSI_CAP_SECURITY_REQUEST		BIT(12)
+#define UCSI_CAP_SET_RETIMER_MODE		BIT(13)
+#define UCSI_CAP_CHUNKING_SUPPORT		BIT(14)
 	u8 reserved_1;
 	u8 num_alt_modes;
 	u8 reserved_2;
-- 
2.45.1


