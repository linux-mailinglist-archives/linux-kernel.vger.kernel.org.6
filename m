Return-Path: <linux-kernel+bounces-362498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5856C99B5A5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB911C214A8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9399197A6E;
	Sat, 12 Oct 2024 14:42:41 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488019340F;
	Sat, 12 Oct 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728744161; cv=none; b=WAgCeWOa6470bs/Ow22L5R5DSi+Ut40UDeIV7teZICnC3Lzx7dQ2c4lI8qwdMGVuFAXkqilKdT68S3N/wbfxk2O2h5myeDawBPkuj3xLdmjN7YfSJVR1pfFTZGQa48FplqPTfS6BD8ENI7Zic8tAoHuv4io2z0Kfu4yv9caqiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728744161; c=relaxed/simple;
	bh=R6dK78ZCjOi9iaHyyZ3ftAFy+k9OcNPURj/ivYn8XaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+SzX+k1XZi+2MEbmhGsxhGusQzBX3Mmlan3hrrvx+rzsTEYqNhRRhlUd9bbuPOtmDnfLtHm7x4L8FymwYFwa5MjQjOEWCNErBCq/Zsp+J8WHwrsfl16puu1+95u/NFQC7Vu/QsZiDQMvgNLsG7tpkEFhp/tuT62LfM6i0bMpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49CEOUjr008596;
	Sat, 12 Oct 2024 14:42:20 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 427g38gd1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 12 Oct 2024 14:42:20 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 12 Oct 2024 07:42:18 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sat, 12 Oct 2024 07:42:17 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com>
CC: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        <tglx@linutronix.de>
Subject: [PATCH] wifi: rtlwifi: rtl delayed work must be canceled before putting usb dev
Date: Sat, 12 Oct 2024 22:42:16 +0800
Message-ID: <20241012144216.433013-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6709113b.050a0220.4cbc0.0003.GAE@google.com>
References: <6709113b.050a0220.4cbc0.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ejPMqggigKlA0XrrXcv_07Tv11oTrKuR
X-Proofpoint-ORIG-GUID: ejPMqggigKlA0XrrXcv_07Tv11oTrKuR
X-Authority-Analysis: v=2.4 cv=DukE+3/+ c=1 sm=1 tr=0 ts=670a8acc cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=DAUX931o1VcA:10 a=hSkVLCK3AAAA:8 a=edf1wS77AAAA:8 a=t7CeM3EgAAAA:8 a=rmtfC1Nsb-6FJSrqWnsA:9 a=cQPPKAXgyycSBL8etih5:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-12_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2410120107

rtl delayed work not be canceled before put usb device, it trigger following issue:
ODEBUG: free active (active state 0) object: ffff88811dc037c8 object type: timer_list hint: rtl_ips_nic_off_wq_callback+0x0/0x680
[  135.350453][    C1] RIP: 0010:debug_print_object+0x1a3/0x2b0
[  135.350498][    C1] Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd c0 fc 46 87 41 56 4c 89 e6 48 c7 c7 20 f0 46 87 e8 2e d5 c3 fe 90 <0f> 0b 90 90 58 83 05 ad 76 ff 07 01 48 83 c4 18 5b 5d 41 5c 41 5d
[  135.350532][    C1] RSP: 0018:ffffc90001adf418 EFLAGS: 00010282
[  135.350562][    C1] RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff811ab159
[  135.350585][    C1] RDX: ffff88811c061d40 RSI: ffffffff811ab166 RDI: 0000000000000001
[  135.350609][    C1] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[  135.350631][    C1] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8746f6c0
[  135.350654][    C1] R13: ffffffff872a8e00 R14: ffffffff840306a0 R15: ffffc90001adf528
[  135.351009][    C1]  debug_check_no_obj_freed+0x4b8/0x600
[  135.351194][    C1]  __free_pages_ok+0x244/0xa20
[  135.351262][    C1]  __folio_put+0x1cd/0x250
[  135.351527][    C1]  device_release+0xa1/0x240
[  135.351576][    C1]  kobject_put+0x1e4/0x5a0
[  135.351624][    C1]  put_device+0x1f/0x30
[  135.351669][    C1]  rtl_usb_disconnect+0x41c/0x5a0
[  135.351720][    C1]  usb_unbind_interface+0x1e8/0x970
[  135.351859][    C1]  device_remove+0x122/0x170
[  135.351895][    C1]  device_release_driver_internal+0x44a/0x610
[  135.351944][    C1]  bus_remove_device+0x22f/0x420
[  135.352003][    C1]  device_del+0x396/0x9f0
[  135.352138][    C1]  usb_disable_device+0x36c/0x7f0
[  135.352202][    C1]  usb_disconnect+0x2e1/0x920
[  135.352264][    C1]  hub_event+0x1bed/0x4f40
[  135.352778][    C1]  process_one_work+0x9c5/0x1ba0
[  135.353023][    C1]  worker_thread+0x6c8/0xf00
[  135.353193][    C1]  kthread+0x2c1/0x3a0
[  135.353313][    C1]  ret_from_fork+0x45/0x80
[  135.353406][    C1]  ret_from_fork_asm+0x1a/0x30
[  135.353474][    C1]  </TASK>

By moving the position of rtl_deinit_deferred_work() in rtl_usb_disconnect(),
ensure that rtl_deinit_deferred_work() is executed before releasing the USB
device. In addition, add a bit in "enum ttl_status" to indicate whether
rtl_deinit_deferred_work() needs to be executed. It needs to be executed when
set, otherwise it will not be executed.

Reported-and-tested-by: syzbot+90f31ac02b7ae5e8b578@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=90f31ac02b7ae5e8b578
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 drivers/net/wireless/realtek/rtlwifi/base.c | 5 +++++
 drivers/net/wireless/realtek/rtlwifi/usb.c  | 2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

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
-- 
2.43.0


