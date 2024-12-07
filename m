Return-Path: <linux-kernel+bounces-436131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7809D9E8197
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C8E165555
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D657155333;
	Sat,  7 Dec 2024 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CDwwac4X"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067157F460
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733596293; cv=none; b=J5B2eKP9Af+/TaU3Q4DpnPPYtLp7ghG51Ll2M2Oa09IWB3afOA71Q87ZTLPPOMuIbnDFaca1Z1pe0kosxtqAK7u+5FZsPMi3GvSFjzyn36EDP5XVjMwsKRDkXsDR0y9c5IJK19d57XS/4ujZrlWFJVb80p8C7UcOLpt94ylsx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733596293; c=relaxed/simple;
	bh=E4/GnEGOiwFWyL9KAJfQrncQUSKogIxZCl8d60Y8qRI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Pzh/I0pWfWRvr9juCVfUl1LSAvHg2h/+40wtc5NfrLms8fy8yoM6dWiu3680AYFMo5PSWtvi0ru9AINBMBV9kKZsQs7AXrNzL0wmnBw6FbRYdq7n74DXWq9Ri4oY62HRtDDnIU9FiuJRUxsfJ3wnEnAUF62qk8ogxoD+4vqBrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CDwwac4X; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733595986; bh=9qhSSZGytDtmqRydm2WL1+ju+J8htuPsQkE5rbonJRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CDwwac4XN1KQmS6jVXtkEfcC3X1K9qYMtiqZU/LCKNgC0DGKFK1JJeSbCyDCXp3jG
	 rJSpm7tEul18SaTt+IL9NAZX7P7Tk0ZKxdMY+wQIuUU4ygDVCO0JoS7fSnLEVj01oq
	 8+W5kViBWKa1diMDymAxwTlnKj1acuBPwzEFpC9s=
Received: from localhost.localdomain ([2409:875e:a030:1001:14::e66])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 698BD20F; Sun, 08 Dec 2024 02:26:24 +0800
X-QQ-mid: xmsmtpt1733595984tgl3f3asw
Message-ID: <tencent_035C5CCF018A15F3131E0F2375370B163008@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yneV8CiMgyLbibTvBjO92aLjUG0bWyC32Jy/IHV9Grfb8CpXvrTeN
	 Wm0mxZY9ZfrVFv/z9vOJrHZMOMxwk7vpVpCt9OBL9MR8VEefOVciYZI+KjdiNtqVKgShFC04/QRT
	 x4byjK4O4EtNFbGZ8QLSgLYA8zJnsP1gvWGr0PGr/eqxUB3S0PoSNUyFm5ZWAnWM96Jc9tybL+BV
	 2uSqhsMJI2xK1URdhIKEdOlS0DXqG4JBx175IZFVPjnuHdjThooSZDyQPI4WAvP/xuQoGHT+m/Il
	 4Fq2dXn0L8IAvIYYlOftqgD1PSLwiF6L/NkgfIBgMecdcMg2tqFzVl0ZQWhvaDa+0VlPayXSgIhG
	 YZxFYxkU1WaogKMFeObL8+PRnk69QdO44pMkYbGtwhOibnfGMa+NZ0THFz7CYCg+/Q7B5Fkq5EFM
	 PMd54VA/SYGeaWIohP6R9GTGjkrr1CjdGhLWtkDzP44g2C5Svqmqrn2vW9aNP9p34cjEJ9uo1Lut
	 Cdslh3Pu9wi7MldcmWvpUD/2rZwTUk7gAOxrfgw3bCeNVE+OSsvN8TB5q6Tq9KScmbX1IMqGEsNp
	 homKDLmh588qZs4JTl2lDs1i/ut9O5Gteq+hpKTftwT1CK84Rgkek2JHRe5bGBQWy8hR3ccOwdtn
	 t8hcj3izgQIGFaFm7mIktTSb+SbNj3TkSLAS+jqQFVtRause2oXV43DqO2TdGsUmlJ/jHBExg1Wv
	 pbsvgDHfDubZnGzE8E5OXipEJWWxfPslaw0OoXDG6kbP3dTB/kg80U7SLfwURrxSRNzeGXJ+ER4D
	 DXwSNKZJ/HJDgohsiq+WbigGt/GBNeu4cppJr0T0hBYVg3sy8AdHx89GV/CRM1h3GN/KG5jToANV
	 gJqP9J1P8WVnzAoetL1HFEML9vQ6YmWVlVDr3qjqk5MMDqqPSdyRIT1sGGoVwXXdPW5qhYWAy15P
	 gjSQ8/VErQzMVC1HT3cw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Junjie Fu <fujunjie1@qq.com>
To: willy@infradead.org
Cc: akpm@linux-foundation.org,
	fujunjie1@qq.com,
	gourry@gourry.net,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com
Subject: [PATCH] mm/mempolicy.c: include pagemap.h directly in right place
Date: Sun,  8 Dec 2024 02:22:50 +0800
X-OQ-MSGID: <20241207182250.2140678-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z1SCZlMcjBCzHOxf@casper.infradead.org>
References: <Z1SCZlMcjBCzHOxf@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your reminder. I have changed the place where the header
file was imported again.

Signed-off-by: Junjie Fu <fujunjie1@qq.com>
---
 mm/mempolicy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 88eef9776bb0..9ee22263591d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -109,6 +109,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
+#include <linux/pagemap.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
-- 
2.34.1


