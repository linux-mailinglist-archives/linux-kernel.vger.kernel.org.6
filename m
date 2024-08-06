Return-Path: <linux-kernel+bounces-276253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5D594913C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 666B1B2A238
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469861CB333;
	Tue,  6 Aug 2024 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="avXygRAK"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132C1BE867
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950648; cv=none; b=S/YnNU1qJz34Q0smg4omUOu599UrP+GiZocBMy6MhGTaaEFQe/JQw3M3sNg3iyD8hxgUSyXZMq0vw3hAmQNBNGVH9RE7//riVHIbQYCVR80bXcEARfqCoXocqFyOuFfZ6arfr0JB52PjgVnVq52pFbrywH2C6JPRAa0seUDzabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950648; c=relaxed/simple;
	bh=TRjMEvLEnFe1E5sklwq17+xppAsDrciBQUvevYXNJOA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nG/vYRNm4tN8NKXKkpGt0igH1AppD35BHB9oyg25OJmS2VIT8GYFUwNqzxdLuI5lq6Z5WRWEaECu4kQgSbGYL6Au0XUtsErptS3xURAc0UMQEjsCOKDFawCtgty0GvStUTfn1+E7CZKMeuh6/vrTc/0Jl5t5RLn/F6Fj88RbVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=avXygRAK; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722950337; bh=opqRBcbjrIrcbZDdV6CwULV4zB8y4ZvHvNQf3NlUNyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=avXygRAKCiunx9/+5PSry2vQQm+7AxWq2qC+/4bswAaYcH3h//GAfneaWJb+OCmlf
	 LA9+4QeDtjCkTwxVkto3OMmsesmxDHBHoJC/j2BRZ8aqZJPgKWYFo3PluL/AobM9UQ
	 lvjLDHew59mNh+5RyxxzJ0VfFnK4NW7M3DB0IxC8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 32D23039; Tue, 06 Aug 2024 21:12:45 +0800
X-QQ-mid: xmsmtpt1722949965tk0cgkx9g
Message-ID: <tencent_D1FC92D5864A49986EC02EE50C8967EF4606@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J28UJmJ5Eq3oeBkd16dHgUntjshDrCRrYBha4z9OfmcRyHb06gue
	 BuY0hgkI2+RUghmkJmlR3zMCxmpfRGd66zxq5eMpS8mbm33aQiptpLvOwTbpTqm+j+ilolU8r72/
	 K+PWsfRu7HN/dTbxzox7FN35DEGDhzehJC7ycUKts2Ogn5UN7MYGgp5xZbrxmsBTObP7nPlUIlYD
	 B1Ev/iYgfkqEVdXLV2XhrCdlpcpwbUtsmXiE0S6ilfLpbVlu4I7XbmEg6prMsEPLn3tXoIW890i2
	 Nh/Daop230YkeFYyKIH4SMararH8f9Ju29kuU4PNPgB9tB3QjQWlYEMIFIiUxhCwLx8KG+Asj7xS
	 PN3XRUGcVC0If1Gkx1wEOBZsjPqZIo/XrLxKWmQvByt8qPPWANvlva0+78oiX5bgWCGW3J2W8fMy
	 Pk0w0ThE/ZMmsANtArM/lRRS/wl0q96dYRN4MHO6va3cwob8GG0WLYtixi9OikcxwgbXfofFDTU4
	 ZgjqJtOlbnjbWgxs5NeUj9NOKGf/NAiNUYUfHjC+lyOHKcntYWJPliyIIN+4QWbd7iEWC5fgcgXZ
	 gKhzYOqdjgORLh1OphnRgaLs7u0Gz3cEkDxVKoxadDpxyQPWbscQrl3vAEsje3GmbXTMi3VY/KIq
	 EQYwp3yPOiXwXQ/UOfPE0WEaT2gx9cSttbw0Ysh8q2IK6QU28+GAP4h2MiGFZSuKhmereRKPXVgf
	 lNBaq5gl1fmcBXWJNuBkagXTK8PyrNI3oVnOFCwgGBP/SYzvJnO4MMFj5GU5bbOEPsnIzgPFQxgw
	 0L+ZBBKan1y0cLcQrCS+BlIy5TgZDrOdpa0bhcgi3+Ta+CwR+jnmUUoLsxShiAty+burqo4gNmwc
	 93DudmyZfp+aalXUjxqpXZZTYJWE1aV2FpZZcssyIxVIaoVG8E74ghh8QhUpYstQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Tue,  6 Aug 2024 21:12:45 +0800
X-OQ-MSGID: <20240806131245.3826068-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000af9991061ef63774@google.com>
References: <000000000000af9991061ef63774@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get ref to skb

#syz test: net-next 743ff02152bc

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 7e8a20f2fc42..31ccbe9a276d 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -51,6 +51,7 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 	if (!skb)
 		return;
 
+	skb_get(skb);
 	j1939_priv_get(priv);
 	can_skb_set_owner(skb, iskb->sk);
 


