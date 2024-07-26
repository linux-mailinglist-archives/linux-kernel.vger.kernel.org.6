Return-Path: <linux-kernel+bounces-263232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5982C93D300
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9D01C21A95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0017B410;
	Fri, 26 Jul 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gEdhEb8l"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29017A5A1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997088; cv=none; b=DUYHH2NwOVQ4NP+YAzPzoOe9EExSAiKoexT7avZl5F2v/rx7yWPAlW0qd1Lq99bVHkrdmP9pkH2p82nvXh7lxt2Sc6aWM5qVEpPAzBW9jvVjsVuRTJtmLhGNE5VkubFopGNhg4eF5smFXixtsalOjy0KnM0yW9Tuqaev5hds/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997088; c=relaxed/simple;
	bh=pH+p7nZzFZZAMPEqXPgp2y0XkHPZTAS0cE3ZFAAlCqE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VDQ1gT+KUnfsHIMZTA8VYHIEIh/mMIPeygGA+kNfPsc0ydLbNH68lomJdzgPWRrly/foQt7uezfAawARSZNOYseMkjfqjivQmXsq+Yzhu5A4aOMli7GtgzJQWw9Gls9wv/2ROjn0U3I4i18++vCppub4OKVaWfBhUlqVaLCtYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gEdhEb8l; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721996776; bh=DmPYv1xm+7MvJdaLPZAvi0bqhJyet/7UQ5lTkBew6IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gEdhEb8lHlXfwozGC0vVthbA1+X2362HIgwEYCrZfXaAB85j+9w76RbgVz/OnD15A
	 /3vaOdw6NGewLKm9mJtgFhfF8uhx4l5m2PcwND+ePxHNoiezUJSst0kE0RXr4XU7oD
	 ZAgvENjhd/t5Q0+9V3CmiJyI1cfWmTCBSOC9eSXI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 68F1904C; Fri, 26 Jul 2024 20:26:15 +0800
X-QQ-mid: xmsmtpt1721996775talzizcdf
Message-ID: <tencent_ADCCB667DF06D952FB064A89952ED1AEFA06@qq.com>
X-QQ-XMAILINFO: M5WvXNp9ZPrQI9k0Ye5DrSyX87ZGWJxg7Rp9bjHw+SD+WwOGGdy913XPPxzaZD
	 CHSktNvzE+ElTDpp4kANQfYjo/q2nsUSkkX9advw+m9wGbibTnV9y24+NsMB/30r/76jWAXAkmzp
	 G98uX6URdXu0Wbs3SG4zgCz5oYFMQtCCaIPwIy4DAcrcLeZjJF1pWZICKwVtyNufvquk7gKPBq+x
	 MRyq7j0JVJW1mTKcBdFrXS7OxQwTgVCIkEkKF+oArt8qWE1f02US+DeG2B/An2pnDhFxk6zkNsmY
	 ANkTpdg4Ui9XcVNcYwoEuvbeHdIEjkTSaVCNTfu3tTqvWHlMGWWY0/LHxco0UZVZqG+K9mnpA2At
	 dpeDLJalJwjQSE3tyhfJ40EKWeXdXMtCg3e8YBRCekJz1VLtjor5z6u1css+zI9f3YMpY9Mg0bsP
	 0/qaX3++2ViLFuDu4kmoDp5MtOGTbKJNR32FHSjCUWulHWYy5d1ztR48/1A33yrL5+aiVJFEePRy
	 NSegMSN7L01HAxXzp6KaCacjUK6FExeoBZ+C52lnDTHl5sxNIlaWHUOJfHCK9HGf3/ghObwh4S9p
	 QYRvD8dE0HbZy+mMzLnqNKulbhUEW3OiLJ1C1vGGl0lAfGAcFWcg4PHNtzkDJL3g8F7UBSyTBFCx
	 L+MLWNKvVWaHHl5Eaz/zpWXWhqAFUJ90kY6b2uSscJovuTayoze17jrsp0p6vgssBcRipicjfmgO
	 cOA0ZdibJr16SIBxrPrpx7rMqoDFGBRRSaIpI8vPxI65E3RZJFLNMDAaLTNGe0qboe2uubP1g8Tk
	 TO7N/QIjwzO1+DJ+PwPrKX6oZCT1/WsM3CspL3m/2w5F8r8XICrh3Khusi4jZISDzY9uhUkDfyuo
	 hr/2TXMCYYLeEp5zwdUoSTKU5My7ELQb+zzGBPgxImi9UTv7SsKw0=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] [usb?] KASAN: use-after-free Read in rtw_load_firmware_cb
Date: Fri, 26 Jul 2024 20:26:05 +0800
X-OQ-MSGID: <20240726122604.2173126-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000391c1d061e1656a0@google.com>
References: <000000000000391c1d061e1656a0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

need wait for wow firmward complete

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 933069701c1b

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7ab7a988b123..ba2066aa46d9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1316,8 +1316,7 @@ static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
 
 	fw = &rtwdev->fw;
 	wait_for_completion(&fw->completion);
-	if (!fw->firmware)
-		return -EINVAL;
+	printk("rtwdev: %p, fw name: %s, wow fw name: %s, fw: %p, %s\n", rtwdev, chip->fw_name, chip->wow_fw_name, fw->firmware, __func__);
 
 	if (chip->wow_fw_name) {
 		fw = &rtwdev->wow_fw;
@@ -2174,6 +2173,7 @@ void rtw_core_deinit(struct rtw_dev *rtwdev)
 	struct rtw_rsvd_page *rsvd_pkt, *tmp;
 	unsigned long flags;
 
+	printk("rtwdev: %p, %s\n", rtwdev, __func__);
 	rtw_wait_firmware_completion(rtwdev);
 
 	if (fw->firmware)
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index a0188511099a..2bbf285c021a 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -913,6 +913,7 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	rtw_usb_free_rx_bufs(rtwusb);
 
 err_release_hw:
+	printk("rtwdev: %p, %s\n", rtwdev, __func__);
 	ieee80211_free_hw(hw);
 
 	return ret;
@@ -944,6 +945,7 @@ void rtw_usb_disconnect(struct usb_interface *intf)
 
 	rtw_usb_intf_deinit(rtwdev, intf);
 	rtw_core_deinit(rtwdev);
+	printk("rtwdev: %p, %s\n", rtwdev, __func__);
 	ieee80211_free_hw(hw);
 }
 EXPORT_SYMBOL(rtw_usb_disconnect);


