Return-Path: <linux-kernel+bounces-232343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F196791A71B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9121C241B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E4D17A93F;
	Thu, 27 Jun 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D5Ow2pba"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1261179943
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493070; cv=none; b=SI2zigQDBAIR5CNeNNt990H/p5d0/u/MHhacNFWcMMqPero9ufcaI647yYdMEzLN6hr5X01+jIazYexWtNNdxsFTuG2TvzCrdJYL9MT50OeNuV3Sv8r0zuZwO2y9GPKurruMmdi7y8GGkrsaMkiv/7Y1Q7/jeGdCPgy4ZZbM+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493070; c=relaxed/simple;
	bh=fvR4A9pNXpEIRIY1bBkJd18Tq+Rd3KBrPaSIVfvQWzQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=r9mlv8zkKJhUWd471naH5ez1tEI8JpC9EF/k+ugHC4RSQMX50uURrvZseTduGZ9CZ39sUb+wShQgruDYPZUKBNqPZGoi++ejIoC9RID7yfY+zEMHkKl4wuO1wec5Mot4ncAVPTWpqDmM3PWr8D2pqV6FmBPeMN9zoVGOfub5T1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=D5Ow2pba; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719492757; bh=WSI88o6L/LDt7bMEHCv1PQvxM0hL4VvO3tmEvcA7Of0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D5Ow2pbadKEijBWjVkelcM8NhQWQPQqN64cDMGWYcQ3zG1TjC3FClm6/Ivoln25hO
	 /okDnhA1WWihtZ2TZUBTGSNdXA7OxVGPlauvIW5iSs7iJlInnIHpeMxsCTzRppjDwF
	 rKe0VaAe41sbNHTOrdvabZU0brcJA8aFE3EJY1ic=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id D23AD02D; Thu, 27 Jun 2024 20:52:35 +0800
X-QQ-mid: xmsmtpt1719492755tb5sccimd
Message-ID: <tencent_B71CE90EEE3ECDAC78E66E9C2FC96C1C950A@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXyDGItSESgsV56kq+BspcqhHXVPmEepa/vsF0IHcBEJPvDQ9++G+
	 pOQsGqspxFtn56nAc/a978QM7m6VMSJiOEIwVy2IMLBu7uiRXwTUwMzsLUkW0KTegbg7CXO1ptOy
	 uuqXD2EYkqCxO2ICRllgv7PKkzWykp5+Yc+FIsg6+I32Vtf8/wMgAzm9cjcFc4DNfWNJpk5hxDMB
	 bMl5sHsJ0HwM3ItI3Rc+C0DTlws2Dd3gfgc+h7Mh4S6n9XPVlZYkt+oz795unVIeFr1T+gxlq8nq
	 ddHjw/xVpAbxAgEYMOmUYBLfuscc/EppiVHe8OljKzrWOEbAdz5syt2L3zgmg4lIhB+UGYVJGYHt
	 rGMNgO6y10vP7W0GxhkxXblrB9iBPQ30/+L3VzMYr+yvD74TmNEBr09ds5iBZLdKnAJW9IXp90ld
	 bq2OQWu6zsexR/cGfCoMR2VXMSthCIKPh+5COEeFCSyedzItNy6OiotpNbDbQM2oHmtbRxjXoW9f
	 xi05zp0TuOOTzA/wx/j5gM2VgvsDJZXweVvC119WXvdwPcqQugAMtyafjlI8JmPdOTR1+VYmczRL
	 oMOUScsEVEgtKqah1MUKjGsohPrdFBt5bUtlqddp6LUX8Jmuxbs+GMfClxX81e8ovXvx9ktOnmcQ
	 Z6yfW4UDg1Nfsz9Pb/PjlklPDeOmkmUKiDbuwZzmCzR6SA2XktUKp+xT6F6DVseG3YB+b65thrpl
	 67iBWALIcrF6hqDKOOPExVjIb+his8KsAjTksmo9nz6WmQ7bFK929b4qTeSer4i4AOV7yV0NCOB7
	 01PiHEPDgzosl5CEyeS93YTp/GJi9rbD3R8EpEeu1qMcG1htBYrL2s7SCJ+xuz5Y8vWqnk/jB8jz
	 px8Q4ew4ie3jZIxVa4OIShwnSHk5/NZMDTexwN6pt0aBUw+VooTr/5PFF+ajgRGkpOPaP7Wy2ApN
	 0KmXQHA3H0BqDGmYXwOY8UyT8Kdzk6B/UR+v24GSc=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
Date: Thu, 27 Jun 2024 20:52:31 +0800
X-OQ-MSGID: <20240627125230.731478-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008405e0061bb6d4d5@google.com>
References: <0000000000008405e0061bb6d4d5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

delete tunnl session list

#syz test: linux-next 185d72112b95

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 3596290047b2..1fd27c902d80 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -446,6 +446,7 @@ static int pppol2tp_release(struct socket *sock)
 	if (session) {
 		struct pppol2tp_session *ps;
 
+		list_del_init(&session->list);
 		l2tp_session_delete(session);
 
 		ps = l2tp_session_priv(session);


