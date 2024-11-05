Return-Path: <linux-kernel+bounces-395711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4592E9BC1EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0866A2829FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75F78F6B;
	Tue,  5 Nov 2024 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="LurS4Y/E"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1F1C68F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766092; cv=none; b=D6vUa1E+GizbeXX6/kMOPfshvc5qVjTcAiL5F52u/pGi7DOlRYeLnNXpFWQnlHB/D6z4Pa8SHxw4KiqcePknigGwtcUrfsQnuxe5Qg5uLJdndGFJZ7KH8dZ2kHwni1j74BdXOPiw70kuz18i2xn/j5VXOtX9MCL54OQ1vfv5Cio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766092; c=relaxed/simple;
	bh=duXZD9QtW+mKBSWDee8DW9mWFUvLKMU1YDAzy2Lu5oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BACbBqOAheWfhlkKozj3xWGGFCoNV1UnVn4gJACFRYWRaSLekboAHAslh4Xykht5bwQOmCIV32Hu7cm5D1Myko1EmGFCTOY4lChfwgVayZlBZia5XAjb8v9DLYfjekQCgJcWxHa0jbcfDSQS2oJwZe69DmW6cIxUKNWU00I3bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=LurS4Y/E; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730766090;
	bh=5YXpd3WJ7ylu+cUkGGm1jfujKBmc+KiS9L0FsIucX40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=LurS4Y/EQix7CJk+AiGmeMuxrBQ4byGGjhRHfhKRH4k/wKwUIrTEFumYGEDyPG/xR
	 IwkyiuNZSXy2LQWPw6XWP0cqyGN+CagjhlkcmwLnu+4OIDLynoQbh1bGA6970oztzt
	 ZZJFU7d2pCkRZasOfI9OpAM/mZRxqD7CDdUWaL4jsXXMsrttFOMUwM4dUcre9eoR9C
	 t4dEWvN/lLp+q5gRh9UNXCWjPmPwkGr8xHnBUovo2hsLAmFgjwALtxUOeCpQ03oVc2
	 YAlT2f4dtxA9zAtDdXd7mZzzm/va8378VE42LTag1oKzwV0fzS7YBWNj1pdxX0uqw/
	 Y0JNMGNIRYGZw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id A4A35D00255;
	Tue,  5 Nov 2024 00:21:27 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 05 Nov 2024 08:20:23 +0800
Subject: [PATCH 2/3] driver core: class: Correct WARN() message in APIs
 class_(for_each|find)_device()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-class_fix-v1-2-80866f9994a5@quicinc.com>
References: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
In-Reply-To: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For both API class_for_each_device(const struct class *class, ...) and
class_find_device(const struct class *class, ...), their WARN() messages
prompt @class was not initialized when suffer class_to_subsys(@class)
error, but the error actually means @class was not registered, so these
warning messages are not accurate.

Fix by replacing term initialized with registered within these messages.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/class.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index b331dda002e3..e81da280af74 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -411,7 +411,7 @@ int class_for_each_device(const struct class *class, const struct device *start,
 	if (!class)
 		return -EINVAL;
 	if (!sp) {
-		WARN(1, "%s called for class '%s' before it was initialized",
+		WARN(1, "%s called for class '%s' before it was registered",
 		     __func__, class->name);
 		return -EINVAL;
 	}
@@ -459,7 +459,7 @@ struct device *class_find_device(const struct class *class, const struct device
 	if (!class)
 		return NULL;
 	if (!sp) {
-		WARN(1, "%s called for class '%s' before it was initialized",
+		WARN(1, "%s called for class '%s' before it was registered",
 		     __func__, class->name);
 		return NULL;
 	}

-- 
2.34.1


