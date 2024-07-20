Return-Path: <linux-kernel+bounces-257790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B202937EF6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AC41C213A1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 04:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85819D2E6;
	Sat, 20 Jul 2024 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HL3SCy5T"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F51B86DD
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 04:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721450882; cv=none; b=F46L7hZcTpCK5wrrAbDOQhSOo/my7UchPLJnWyB1B98czmuz+kcuXHuqsR6i2xKgbI0uSGUcQumSj8EW5a2AMrT38QkSctl/JMfYupPfDdyDoe1y8My9mQThTJRR13KDUlRur5M3damtenp9xRd6pZQhl5epAfApezdSghKE+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721450882; c=relaxed/simple;
	bh=xFc5G5DHWJcvFdLGvqqOnO0ga0WJdxDdPFWPCT5At7c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZmYJb/4S9swL7lktEm8Nzp4yeDgIomTgu2PuUGjB53oupqFnCrvAyB6tBaXKxF4ebMqVR0J7V5PkAAZbk5q/ntd9lRhCiH9BNU/jpORU3snEVcNWZnSUvkKiZ7ZaMw2+Tc1cMQmo9mvh3PuzkCgj5BjOni/Q/KIqGH8Sei8mNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HL3SCy5T; arc=none smtp.client-ip=43.163.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721450866; bh=bZBzCxeMtS+pZvaPzfBXP4KuQKXINxyV8YiIk/GczWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HL3SCy5Tofniq3TNdAUP6x26almUMMB6ZLIA9M+D9+mnZmNXJtb+NGQkf+vsRds4Z
	 TEPz/ellaLIBrEN9lEIOa0H8fK2sUGZL5GlAPg1xoobMK+GK8+swv0PZfRuBLmPVu0
	 xolcaWmV0NR91N9Q+J4XHa1r0s2kASDYgRx1SnHk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id A6AB96F1; Sat, 20 Jul 2024 12:41:42 +0800
X-QQ-mid: xmsmtpt1721450502t916exui7
Message-ID: <tencent_F6255BBAE6BB63335F9E6F1B6F4BDC1B1408@qq.com>
X-QQ-XMAILINFO: M8F5Ju5R+mONjPJw26bM2Djc58XkdNyvOcbLafjemgnxcaPj4WPof/FWc4rsuA
	 u28kSifS4Vyeqhdbn81rsi0jCZOcx8Qo6+Ag36prPDH8JPDfALrVD75Z4sWxU9HGbzzW/8oV6cF8
	 ZJXMiR/RpofBM9I0/Dpi5CXjN40DQ5/t5FREJivK0O6Ainv69Ar9Vn1JavwtArPVzK5NlP8/+qmd
	 3XsBZooKuycZZgOz9yU/EwzSHadu1qhvaDajS3Oz42vJnBWxmEIRHLb2ArougQ93TCLEhV2Y45ZJ
	 /8p1YwA1veYbqfTNkdry9QrmUiLrRGnKqZn9jdJ0DZ6uOo6eh8MKQhaz3MAAp35tUh2tVS6SPbBh
	 p3j6dEOnJ0Oq6i6SdbQt93wGfcrQdWYNjTJsVWJeTGc1WYZGvI2LWIoiejHCF79CE9iNZK1JKTOc
	 S4uBPOgyIoN64UMknq07ew+xgXT77D3hb9IXYxNReHBVkeEWXqADOhlQoR98yQL4kej53Z6ND/jl
	 YsH93kH5hlOCfdmEC95wUAw5/VQ66rszN4CeHA5T+jYP+aGm7XzHT1LQ9EavjGUmjO7BaUirN4zB
	 YRGrIIAUPqQ0ssJcJowqgO9ibGET6oj6lLjgath/iFCzJKvEJH+2hL7fOoMKn3gBpVSy71y+4ysp
	 TAoGXxxyPBOTyUG+dvExQRRf+A7jaGKEimeAmYeUX1XLo97tQe/KlanX8ON8ty1adAjhWnpxekEw
	 4kieBBsm0/w0PVDlFRTyO6Ec+VMY0Lgg+C1ePnAk0ZLlNGyZspRLC1jUz6zM89YwYe69xhPHrbzU
	 kQPJqeK9nFq8Zh8mcxYyC0tkB4zPrHjTkr/SmLlaFnVgP6JVJpejF6IGlKjofIu6lTUk7pula5z9
	 h6sTomhQNIdl/fHolFB//kcMWbDUyvW1BGbjDSBV++TKWjjHE4Wks=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0ad4cda8077288e1b15d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in lapb_t1timer_expiry (2)
Date: Sat, 20 Jul 2024 12:41:43 +0800
X-OQ-MSGID: <20240720044142.988929-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000005f49c2061da633f4@google.com>
References: <0000000000005f49c2061da633f4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msg storm for EPROTO

#syz test: upstream 5e0497553643

diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index e8c8bdb9c40b..d3355345c1a3 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -95,6 +95,7 @@ static void int_irq(struct urb *urb)
 	case -ECONNRESET:
 	case -ENODEV:
 	case -ESHUTDOWN:
+	case -EPROTO:
 		/* Stop is requested either by software or hardware is gone,
 		 * keep the ret value non-zero and don't resubmit later.
 		 */


