Return-Path: <linux-kernel+bounces-447323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024699F3084
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC571884E31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C5204C02;
	Mon, 16 Dec 2024 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dNT7f16U"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674E202F7E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352148; cv=none; b=SrcHq2sMVdoZ52TdLXA433Vlad8YI4DWi5S+lhJYP0HHhkc6nbEZUid15i/7j4haICtATnCebyAg4J0jfIT86GElLEBohUiqzl2Nes7fC8K+BvjQ2XLUZSiG1Dkw/6HjWLZdxxq2CrT71712l4FAZRYXrUNrpEFif3SY6oBCW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352148; c=relaxed/simple;
	bh=Agq+/2IqJcI3I/fEHbDHdKrFGHxW7N1xS8daFz1TCWw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CBYfHNKf9NO5iSqKJB61FdF0Iqpj5X4zTeuKoof/crgW2hrNT3Ru3JLtZh1siPjJy5AkW2MGSBlEFa3jJhE3GavS8pPTnNpU0zRgesc9dfWA/QlIN7zgGXmWh7Q62Brer4Z9ScKmUix2OLdGUPVPOUNO0b4Orh/c52D89mpd4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dNT7f16U; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734352139; bh=6C72HlXrEp0n4LrnlXnF0EXzjqB9BepMO3MkkjuCsGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dNT7f16UmhOxmHTOeT4ztJBcKWn5o/xOBnj0X4SNs5AVEQBcGyD2Puze3l8ykCIig
	 iAiYlKuivGJYOyuv6jwoJxcNDTz3LM3329TztB5ai7R2aNfKMQG/3PDTFqOQHz7VPP
	 jJfmnhj4CLq6oUjh5Br6KUVPeo5X90ekDdVHi6GM=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 7399D6B2; Mon, 16 Dec 2024 20:28:57 +0800
X-QQ-mid: xmsmtpt1734352137tgxqj163y
Message-ID: <tencent_ADCFBC7BBA6D582D356CE49658E91EED2A0A@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1j149Rza7Rs2hqrf5TyWcA+Uwh/FJW+iXEhKkyXCtzf7DTBm8nAq
	 Y++YaL39SOn6TzyKfH2DpYgXaLOESOWYloDMZ98ZOIYEoaG6VR+wghRQJk/efw3rYv/pjjY4kjyU
	 Yp0mcln+GMEY2sn2FjsWcHZjSFftidTEmj8Zzl84L/lE/S1WmuO3yPDQw8z/EvCSiR4BbkvkBiSp
	 9SAJwahI/YfcSywak8AL+pbqpQa7v/V2T0JQLCSwjwNseZL3xT/I6Z91Mtzi1Vv8JI1L4SXWkPdh
	 oX03Xf4DFLX2tdlS2zUpRQy02kPsjBLWbuz3EePmOfmB8dLWjoUTqmVXHLG/orIc91J/E2ZZeH+g
	 DbPQYzc0aDQDIwx2K08aN8KEt7BOTX9pZeN74n/rQkfdrJEQjgJ+E+yOMwoBK+1sfXeAY91ddUuR
	 ZbRSvmdPiNF+i+PGa0X/TnwcwU9PdGpnxVInFCo+c4LQ6Bg7Mk83kKkBcY3lcBrjVblG0VyTdE4O
	 gnLHBzNX4hAHSTumIrwEk0QhnWgp0ow7EOeFzhLhGJzz7NA8iTB5Pz9JBzQ5lKOzPs9p74CHHH4z
	 oBG7ZikOFZ7SekBuAw7wV4CCI8DcGx/tFm/P9SLOoY7KklLwmOSYriiAcJAyaJFIlAUmb9JgPoxA
	 kdQXGddul34GIcD1MP9HB0SP3Obms+xV2NqL/Q0u0ddIF+qW7t7dDd28blrHWZa8Myeg9GsPAwCl
	 Pn9eY2O1BrJBNAq1nezJCEa1V4zJ7/d4VxektbNjbcUlaviGO1TikDppFaS2k9lUaYBL/7UcE09E
	 awG33Bgpjy8ckPaatzo82RVo7x3iaY8mlFOX2n5nvmg1CHJ8lzEGVcxtc4rx4vwhOAByPm7Dm314
	 o9bhd4Y/Oh1wU1JD5QVyI=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] WARNING in bitmap_parse_user
Date: Mon, 16 Dec 2024 20:28:58 +0800
X-OQ-MSGID: <20241216122857.2303211-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <675f60b1.050a0220.37aaf.0107.GAE@google.com>
References: <675f60b1.050a0220.37aaf.0107.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/mm/util.c b/mm/util.c
index c1c3b06ab4f9..1845d649b171 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -302,7 +302,7 @@ void *memdup_user_nul(const void __user *src, size_t len)
 	 * cause pagefault, which makes it pointless to use GFP_NOFS
 	 * or GFP_ATOMIC.
 	 */
-	p = kmalloc_track_caller(len + 1, GFP_KERNEL);
+	p = kmalloc_track_caller(len + 1, GFP_KERNEL | __GFP_NOWARN);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 


