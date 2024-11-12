Return-Path: <linux-kernel+bounces-406167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A69C5BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF172282A24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01D20101B;
	Tue, 12 Nov 2024 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uScq4ibQ"
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D6D2003D5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424536; cv=none; b=bucekHavP2AFIVs2paK4zK8wryMf1+qAWgNGFw2mfhFr/4ZyC6KxGnozc8l14FHAjJPsMhg/RiazeQSPpWmg+nWTLaW1eMaBVPPCPd4yIEqZCutUPif8fxjxQRtucqwb7BHhYm2ZIPz4U7onelHiVrF+JD9pEEyq1gNWNFUjg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424536; c=relaxed/simple;
	bh=e3IA8H7lezHsPVuqwqUtw6/rJabNzE2sh+HqfJRsb94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E6QA6fxGDBOys4O/jyTeQvjHHM39OSdGVSDOcLTE4bPWv21R3tloIOCSjT4bgvqp6iDIwpQrZeeNR7bntz3uAromXyNs6cWTIP+gLrTGzy0gYbSdYMhNmPQTAlW+wjHXD6QiIRHZ3ywK005gHy2WKBAobjOuAhIh/nINTxspRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=uScq4ibQ; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1731424535;
	bh=zR9m6GDu7qvzPvdeFqcQNZ4YY9dC6fUZuVQ+7waYsn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=uScq4ibQrcaH2b5kgFNyjoDPumYhmTgjeSgGoPyFeGTWyLREYb3pQgcF/1yXTOmao
	 n6FG1LXdKqJE4qvLGpNHI7ERLHA1ELpWistUBFoNhSXGXkeg67BKfR/6YInPl+LfIi
	 Ldq7oCXgqrypH3VX3hLagF03pDCddB3DDmUxegdzd5Aw5qJGgqmZeAJZ53D+PH5ql0
	 S+3QYBNBINCdKy6V9wcm8a6Jsl0WZv6ROwXf+Hf16wxz6W7wA4gtmjh067vB1GyYoL
	 r5dTsCHDI6SDAI9KOUG3ZpvxUfN0MLBelRyWU1Clgr+d15UWpYYl28PXXQt5eI5BRy
	 a03jDbnSlmmPg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id E14123A0374;
	Tue, 12 Nov 2024 15:15:30 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 12 Nov 2024 23:15:12 +0800
Subject: [PATCH v2 1/2] driver core: class: Fix wild pointer dereference in
 API class_dev_iter_next()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-class_fix-v2-1-73d198d0a0d5@quicinc.com>
References: <20241112-class_fix-v2-0-73d198d0a0d5@quicinc.com>
In-Reply-To: <20241112-class_fix-v2-0-73d198d0a0d5@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: vo4AXpOS8HHJZV4wT_vdWJMTdkw4puFs
X-Proofpoint-GUID: vo4AXpOS8HHJZV4wT_vdWJMTdkw4puFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411120122
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

class_dev_iter_init(struct class_dev_iter *iter, struct class *class, ...)
has return type void, but it does not initialize its output parameter @iter
when suffers class_to_subsys(@class) error, so caller can not detect the
error and call API class_dev_iter_next(@iter) which will dereference wild
pointers of @iter's members as shown by below typical usage:

// @iter's members are wild pointers
struct class_dev_iter iter;

// No change in @iter when the error happens.
class_dev_iter_init(&iter, ...);

// dereference these wild member pointers here.
while (dev = class_dev_iter_next(&iter)) { ... }.

Actually, all callers of the API have such usage pattern in kernel tree.
Fix by memset() @iter in API *_init() and error checking @iter in *_next().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

---
Alternative fix solutions ever thought about:

1) Use BUG_ON(!sp) instead of error return in class_dev_iter_init().
2) Change class_dev_iter_init()'s type to int, lots of jobs to do.
---
 drivers/base/class.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index cb5359235c70..b331dda002e3 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -323,8 +323,11 @@ void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
 	struct subsys_private *sp = class_to_subsys(class);
 	struct klist_node *start_knode = NULL;
 
-	if (!sp)
+	memset(iter, 0, sizeof(*iter));
+	if (!sp) {
+		pr_crit("%s: the class was not registered yet\n", __func__);
 		return;
+	}
 
 	if (start)
 		start_knode = &start->p->knode_class;
@@ -351,6 +354,9 @@ struct device *class_dev_iter_next(struct class_dev_iter *iter)
 	struct klist_node *knode;
 	struct device *dev;
 
+	if (!iter->sp)
+		return NULL;
+
 	while (1) {
 		knode = klist_next(&iter->ki);
 		if (!knode)

-- 
2.34.1


