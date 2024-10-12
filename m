Return-Path: <linux-kernel+bounces-362449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972CC99B516
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89631C21FB5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985E1186E46;
	Sat, 12 Oct 2024 13:32:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E11E4BE
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728739947; cv=none; b=pF+HiKtE9aXJdcW7q5biOSQHigQZyczC34bfXBoWDBHIloO8JGldzBm4WBTbcNllyKxVGrB+Q+ZLlenPX+U/69r43oziBfLqr+SJtmvPfJBrNGXPD7WQyy+ltBnbo2hQysNzIpf6IRCQVOFydcNraEOysMx/cCtIhC7CVZEhDmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728739947; c=relaxed/simple;
	bh=MUcqyLFof9Tk9H2Y/6Rm3RBC56dstuWt91Bf7ZcXIRY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fWwVgJMgAp+BRLRyuw5YzUbiY27XRlOfkjmq23PHaD+al4JB9noa9pVI2rUkPWzvu7C+M5GHZUU0zJw4yoffbOxkysu07U6BRZunEYmKNWcMMG6mQxo0UbZLm/x+rJXjaoZiZRb+CsTlOxEHUVaxKiiErDb6dakjWAur83kpJV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83542e22fd7so225612139f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 06:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728739945; x=1729344745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFJckPcFfohxAQv6h095k5mcoUaLnlZPEW2NZsMWTjs=;
        b=Ob9cxRPKjpnUfmDNrFBN8ttyHOG2AzC2N/wewNzYr7T+AjBrmuasUIzs9nU97dU+az
         hxfjawIBQy14V11K6FhZ32KdLVtSym8EwG4XbekefrIqHQkaMlumI4Sa/U3Fc8Y3fc2b
         gkQDJdmobhN2rlUm0Oj9qfrQdtbHEjfwqiz8XZ0bAo7mqp6EKkcr2PVihjkklmeTWEwS
         4km8YEPgxb6mRFMyvTODSWNgCpRKZPIBEHqVcku8s6HcXUjz09mP6U57rbLddGoskKJT
         03FLMFzpcZ2a/KxRu90WZwQbsuECyT+/K1JZTGJI7DW3fE3XXbnJKxfG+FpK2dQfNesX
         lrCQ==
X-Gm-Message-State: AOJu0YzLqtluGKOXINvj74pDJX6jWQ7njoP2JGlHVJzRXC6etSmj/s8n
	h06iqPeQVypmCg6u6t77eCwWTqxrW2yyIofL4gQxJcijghprIpqgiwQmiMNmB9hWh4IVPjS9JEm
	IHoN7eyvQp5K0KPBn2Ga5jGBNcgSkEqiqMOLlFohwNZincT0fUk4619I=
X-Google-Smtp-Source: AGHT+IHRMh2FSVgTirupOwh9xUPLWzy17fGm5Map9XCes7UU0A/Ea60RMG21PvuOoOHp5uXtIKxrUju8Jo7gsWCJ85RBLogb+FmF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b70d:0:b0:3a3:968b:4e3f with SMTP id
 e9e14a558f8ab-3a3bcdeeff5mr15102245ab.18.1728739944784; Sat, 12 Oct 2024
 06:32:24 -0700 (PDT)
Date: Sat, 12 Oct 2024 06:32:24 -0700
In-Reply-To: <6709113b.050a0220.4cbc0.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670a7a68.050a0220.4cbc0.0022.GAE@google.com>
Subject: Re: [syzbot] Re: [usb?] WARNING: ODEBUG bug in corrupted (3)
From: syzbot <syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [usb?] WARNING: ODEBUG bug in corrupted (3)
Author: lizhi.xu@windriver.com

rtl delayed work not be canceled before put usb device, it trigger following issue:
ODEBUG: free active (active state 0) object: ffff88811dc037c8 object type: timer_list hint: rtl_ips_nic_off_wq_callback+0x0/0x680

#syz test

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index aab4605de9c4..605875d21573 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -449,6 +449,7 @@ static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 	if (!wq)
 		return -ENOMEM;
 
+	set_bit(RTL_STATUS_WORK_SETUP, &rtlpriv->status);
 	/* <1> timer */
 	timer_setup(&rtlpriv->works.watchdog_timer,
 		    rtl_watch_dog_timer_callback, 0);
@@ -473,6 +474,9 @@ void rtl_deinit_deferred_work(struct ieee80211_hw *hw, bool ips_wq)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
+	if (!test_bit(RTL_STATUS_WORK_SETUP, &rtlpriv->status))
+		return;
+
 	del_timer_sync(&rtlpriv->works.watchdog_timer);
 
 	cancel_delayed_work_sync(&rtlpriv->works.watchdog_wq);
@@ -484,6 +488,7 @@ void rtl_deinit_deferred_work(struct ieee80211_hw *hw, bool ips_wq)
 	cancel_delayed_work_sync(&rtlpriv->works.ps_rfon_wq);
 	cancel_delayed_work_sync(&rtlpriv->works.fwevt_wq);
 	cancel_delayed_work_sync(&rtlpriv->works.c2hcmd_wq);
+	clear_bit(RTL_STATUS_WORK_SETUP, &rtlpriv->status);
 }
 EXPORT_SYMBOL_GPL(rtl_deinit_deferred_work);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index d37a017b2b81..aaa16bc23e91 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1064,9 +1064,9 @@ void rtl_usb_disconnect(struct usb_interface *intf)
 		ieee80211_unregister_hw(hw);
 		rtlmac->mac80211_registered = 0;
 	} else {
-		rtl_deinit_deferred_work(hw, false);
 		rtlpriv->intf_ops->adapter_stop(hw);
 	}
+	rtl_deinit_deferred_work(hw, false);
 	/*deinit rfkill */
 	/* rtl_deinit_rfkill(hw); */
 	rtl_usb_deinit(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index ae6e351bc83c..24d3dcbdf81c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -322,6 +322,7 @@ enum rt_eeprom_type {
 
 enum ttl_status {
 	RTL_STATUS_INTERFACE_START = 0,
+	RTL_STATUS_WORK_SETUP = 1,
 };
 
 enum hardware_type {

