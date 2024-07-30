Return-Path: <linux-kernel+bounces-266709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E40A09405AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224111C20F87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC31482F3;
	Tue, 30 Jul 2024 03:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oVyA8tt6"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6701465B1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309087; cv=none; b=H34HRLjh81oWQjnxdApZ236lfbBgrqkzUcW3PjbVgU/3lk6e2WpmHlXnBmk9bXwfetszLqYwoty7V1JWxQehFy3vDSpgSQlyca0fgJabN1zVmQ1AzCu+5ZwNknbhyxIHFWyH0z5veY4/V2aLbPTJBi/kEa2HzE0bE7CmVFzLbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309087; c=relaxed/simple;
	bh=+wxcmadN9NVif5OBF5L6ceDegH8NCLkbNCXozC+OsCE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HeoLDTwM/+tHILyvh/FhfQ0GL8cRJNue0znnAquULlywHfi8JCD7s2Jf7+UakGvGFfDNtjiLBmRDIZMgAkxpz32r1F1qIMXcLP5TZazUU5lppDZOShL/whcXDW4pJPCjCPqro6BIIXULqvw7d0sxXTshKckP5tZ2D45OjPkKjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oVyA8tt6; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722308774; bh=CgOD8orFsRTD1zH+T0pOZzjW1uV2wy1jomLL5w5N30A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oVyA8tt6H3mz5KUy0M9qU7ZF191C9GVW8VF5KpI8HQG1P9SxdXeHZuQPEKgWM0P99
	 nE0tNhxkkCyY/oilH/zt1Z8EcazaQT/uVKmOouPbtlPZCyi3qy58dCogdq4F7oqtqW
	 r+2M3kUjjN600y5DDF1sbsTLacGskFIRc5k2tno0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 18C1AE0C; Tue, 30 Jul 2024 11:06:12 +0800
X-QQ-mid: xmsmtpt1722308772t41szhzu5
Message-ID: <tencent_72A97943A1E444F76C577266D59361437C05@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3SIrcCIdANgosjxkWqcqB+uAFcPENi/nWVI7lrkA/CmPtFwILcN
	 Lpsb2nR9esOHJfTFnL0J8LeieM7uW/2a10gw8zeIrz0HHzllYo9qV6k3cNkj4LgsSyI/1n55s03q
	 oZp8EB6C68l+ZZOtFEXAD8gPD/VGW7BihzG5XVBkf3AdDshCwM+3ms75W1WAlUaRDfgA1PRX7b4l
	 Omokj05m+lSTWRnpqIy1cN+XAzRMTRNN+C+JlNgZAnQhJdlolyc8GdZNyIUReshpePxzSMEah29M
	 EJl4K3x5Bb04DjZwm5YlYOtL7OmxioDRfMQ3V1T0CB8BKDZWUej9fGiRhG9pW5yiHm37jegE46lJ
	 kNga8afRgvTKFba32NnjZWHCO/dUrEBSRLZQ0MceTC11gO/OU3WTRJmVwhKY8PWCZ3mZWNX/wTm5
	 i+wQOpXtQ8RBcBOPbr1CrZvHZOtRycz+boVQ4kpx/9fIePBXi0bZS/Wcvipddpcn5uSbTygKo1/a
	 lc9LW9O2qtlHqYbDg/e9u5ZQEFe8z+3acbuVM1mzKr8RYNEWAmGkXQ18ISJUB5xMqC+n4KfoQcV0
	 adRPBVWcz0yoMQ3RCX7PaFq/3cvonTKizTiGulvC/+PsLY4N56rhri32Opvyd87r5WNSF3T6pp7U
	 Kvug528RouyuFFansYWHRNOq7f2W3hDucaEwiFz6sXzje3zdfyFhBerLYVC4/jXeOMKVkpQxYbc2
	 vvZXXsvu1XT6oR1Hkf7PYcPhp57bThpdY84NoY3G7ECSi8lw2Y8zijGKcghE7isi6qSLjSgk/Xn4
	 mhYU5nzfolJc4Uz4pgD3ieUMYqqvEuVme+HMWADlliANtvinMxMnPMDj7hfCdTmRM18ySB3PhvaD
	 gWOZBxjj/vmW5OeXj7YSwTc57r5vF5qcjyqw2XQlymE8NFiNSVlJbr9ISsVLr/PIHRdbLrcpHC+B
	 MdXgIAlgU=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] WARNING in plfxlc_mac_release
Date: Tue, 30 Jul 2024 11:06:13 +0800
X-OQ-MSGID: <20240730030612.25921-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000ac553b061e675573@google.com>
References: <000000000000ac553b061e675573@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

not need assert for mac->lock in plfxlc_mac_release

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 933069701c1b

diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 641f847d47ab..f603fddead90 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -102,7 +102,6 @@ int plfxlc_mac_init_hw(struct ieee80211_hw *hw)
 void plfxlc_mac_release(struct plfxlc_mac *mac)
 {
 	plfxlc_chip_release(&mac->chip);
-	lockdep_assert_held(&mac->lock);
 }
 
 int plfxlc_op_start(struct ieee80211_hw *hw)


