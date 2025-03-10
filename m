Return-Path: <linux-kernel+bounces-554332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFB6A59649
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCBC3AFC62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0862C22A4E3;
	Mon, 10 Mar 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b="LitRbtOU"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DEA1581F9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613331; cv=none; b=XxRRRPKwj8vAOt60X7huGhcranH8iCRnG09t5inY3JR4HdNTqzjMaxHqU9mammgr2TlDKRkfIYksBCO//V4710gB0xvAeuwq+oRN69MxIkvsGq0k7mf2KebrfETb7KRI9dwIqPyB8UG1svuPc/7m72ZrG9vfUKO+YKXHEDPTSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613331; c=relaxed/simple;
	bh=yRMCaDQnvsF6vQ/w9rLRB/etZre1sSzpWUDTNGX0zAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VvVAxfG5mMDBESWpEn2JG5262Y3R+r02CMJT4VSLeJvFOHS0vaJCFoN/Ti91+d6X/jmknEwfd1wzu+Ns1QoSdP7Ydy9WdTOY0nlxvQk8tJGXGAhf4Cxe/jj2RUyi0DfVzFpIDktUUGmR31CLG159VqCRoOsRtl5sV5yWm/rHgH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com; spf=pass smtp.mailfrom=8devices.com; dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b=LitRbtOU; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8devices.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5499c5d9691so1866540e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1741613326; x=1742218126; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6+w3029kfHch5SeD/z0zur2K64cd98za9hhmN/ji0MY=;
        b=LitRbtOUxDhUPycKFo/pzuJu9Y11QmpYSvOmkgM9TcNEOsBvLk8z0EJ7+xy24ijRGJ
         Xz16V9Z1kJGkXBK90klI6s3RjVBQf+dxf37t2kdQWdrgOE2VhXjnnV5zP7odCkMmOViw
         2UmKSvagsxc6KojE2OYyd+vR3hmL+4fCtegorXMaRrf0Brje8XJmViAUgbc+IAtfL0Ao
         pnig300fAb4WbnmIJIRiOUKoTESjbJRkUehGJkhe1ztiPE1F86AVMXw5IrDBR/WtMin1
         9nYYDqfSGvI7fOvfStfZ9hS0ShIhBNd5naccyQ7c0xSTvXJ51vUvNvdZuufm9OKsbQ99
         nh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741613326; x=1742218126;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+w3029kfHch5SeD/z0zur2K64cd98za9hhmN/ji0MY=;
        b=THclcF8jxEzef2xAnD0O0pMK17XPIpqwLf16c618ZdzSKDXO59kvjB7J0OyDVFQY1C
         ATCF+Te/tkqm7uRfmqNeSt9uXz00DQNp/BXwY9Auw8pQ0ropl0fNfDMxBhPqJICIuQMG
         X2kcN1YfvNGnkB2f8YUy/1BF+DoQJWJ6/tJej591almSEyuT+Ppg+UTcAnz9lPmmd7zs
         V//Tw3+hiMQyu/J/WFlXx3E8kX7dvK30o1eSTev8cnQw+xsKfl8tiHzwoN3N2PpT83Au
         galYl5QxTrx82ZTlMBtkCjveGVD12YyCqj5MMYGeXyoV8Fd5C+KrdL92f73NREQiFRqY
         SiOw==
X-Forwarded-Encrypted: i=1; AJvYcCUBoTDG5Coohte0U4c7UjZggXbaSlh2QtoOc3TQKk+smFCkzqdz8bSI/D69o4R0lSflCj7MrpiIwB/qRsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysZL+8uV78hBrNhFllseJbdCDY4lcpmY3zlnSGegUnBfDltTRn
	OyVVFxHSITnBqEHU3nGxIsBjlCcxsny+1wwIJ2hkDhx6zVHnraKOqWRkEr5X618=
X-Gm-Gg: ASbGncswbw9S5RH4mUcXuQba3TXE50gI5pBc488vzy0WZBhXRkbx1tX1nwO8OyES58z
	4B884DpxSB7+ixDYCBUpdfIDgGwuoN22krg/GMHoPELMffzT5yUpbfbW5bXoaBijMW/3D57/uvM
	p/C2QDQd2zMGoKk1R9poI7vpaWYc2HvXGNffdtSNd5HtoSSKSGnJ930v5cFJgY0dRjdJc1UIlBS
	XbvPOuQKjuqm5yUI8zmIl81LaKzinyTN5dAihz3HUr9zpcEHPdqNxdfjY1uCmqjXJXrUj6QD8Ob
	TEDa/IRbNY7CAj13A8AiG0E52UNOwYxhvq67gvdivjWRx1JQjVSWPw==
X-Google-Smtp-Source: AGHT+IGIixTut4yqDWp69RPz6EjMMq4lD94Ez1yhsRnow6NgvTk6WmKPLFavYgOJC+xGczTQmaocLw==
X-Received: by 2002:a05:6512:1112:b0:549:5850:f275 with SMTP id 2adb3069b0e04-54990ec8e60mr4354451e87.50.1741613326121;
        Mon, 10 Mar 2025 06:28:46 -0700 (PDT)
Received: from [127.0.1.1] ([78.62.132.154])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bcaecsm1460408e87.200.2025.03.10.06.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:28:45 -0700 (PDT)
From: Mantas Pucka <mantas@8devices.com>
Date: Mon, 10 Mar 2025 15:28:18 +0200
Subject: [PATCH ath-next] wifi: ath12k: limit WMI_SCAN_CHAN_LIST_CMDID
 argument size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-limit-wmi-chanlist-v1-1-8f0fb45459a7@8devices.com>
X-B4-Tracking: v=1; b=H4sIAPHozmcC/x2MSwqEMBAFryK9tiGJ+MGriIuMtvpAM0MSHEG8u
 9FNQVG8d1IQDwnUZid52RHwdUl0ntGwWDcLY0xORplSFVrxig2R/xv46StCZF0Pn2Y0ibaiNPx
 5mXC8px3ZuLCTI1J/XTfUqQSebgAAAA==
X-Change-ID: 20250310-limit-wmi-chanlist-17cb8d27cba6
To: ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mantas Pucka <mantas@8devices.com>
X-Mailer: b4 0.14.2

When using BDF with both 5GHz and 6GHz bands enabled on QCN9274, interface
fails to start. It happens because FW fails to process
WMI_SCAN_CHAN_LIST_CMDID with argument size >2048, resulting in a command
timeout. The current code allows splitting channel list across multiple WMI
commands but uses WMI max_msg_len (4096) as chunk size, which is still too
large.

Fix this by limiting the number of channels sent at once, using the value
specified in WMI interface description [1].

[1] https://git.codelinaro.org/clo/qsdk/platform/vendor/qcom-opensource/wlan/fw-api/-/blob/NHSS.QSDK.13.0.0.6/fw/wmi_unified.h#L6459

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Mantas Pucka <mantas@8devices.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 3 +++
 drivers/net/wireless/ath/ath12k/wmi.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 6d1ea5f3a791b09044191ce86f4897b7f06f35eb..88ac800d44401a139de75e90568c8d68f3ed4f3f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2780,6 +2780,9 @@ int ath12k_wmi_send_scan_chan_list_cmd(struct ath12k *ar,
 		max_chan_limit = (wmi->wmi_ab->max_msg_len[ar->pdev_idx] - len) /
 			sizeof(*chan_info);
 
+		if (max_chan_limit > WMI_MAX_NUM_CHAN_PER_WMI_CMD)
+			max_chan_limit = WMI_MAX_NUM_CHAN_PER_WMI_CMD;
+
 		num_send_chans = min(arg->nallchans, max_chan_limit);
 
 		arg->nallchans -= num_send_chans;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 1ba33e30ddd279e21a57a1db6150e1d08f4a2890..2831f7e3033c7f4a9886577f542c5026f1bada28 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3909,6 +3909,8 @@ struct wmi_stop_scan_cmd {
 	__le32 pdev_id;
 } __packed;
 
+#define WMI_MAX_NUM_CHAN_PER_WMI_CMD	58
+
 struct ath12k_wmi_scan_chan_list_arg {
 	u32 pdev_id;
 	u16 nallchans;

---
base-commit: 42aa76e608ca845c98e79f9e23af0bdb07b2eb1d
change-id: 20250310-limit-wmi-chanlist-17cb8d27cba6

Best regards,
-- 
Mantas Pucka <mantas@8devices.com>


