Return-Path: <linux-kernel+bounces-263226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9AC93D2F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5AF284538
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417C717B43F;
	Fri, 26 Jul 2024 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khNp11hq"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E617E57E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996906; cv=none; b=I1wQNm5+gMXZxSHobVzhAyixVW5VouMgERjyEio3Mtnd+RbKZPve7smXOabzpC5Qb5FnpXqPs37W11Ww1nwv7AA7KUkiCpBPnhc796d78o8tVBrxtt2XZPLAgHS1YtS/lfR+XJMgTnIimmC5QNvIFHmd/M9Y02T7PIjArmJn1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996906; c=relaxed/simple;
	bh=TjL4FuKgEzcXR/oQoRa1LoU+uuqSqazO4fyDUPzGJx8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qtbL6+b+gnzauTmu0EK68pdEU2zmfftfOLGk/MOS02kwswRED5PDpuxmarWNLnbDQgfZu/BmPftIGu7dw5VO2XqKzaC4SesfPAaArr/1qOdLu002GPOSLzN4W3qPbnsVRnjFmfU6w0czJTmyTyj1nvXNah3u/euEnu6pUipeIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khNp11hq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664ccf0659cso48547807b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721996903; x=1722601703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e5hfWIomveSKSbFLIYbxIdGK2baB0bvKEFr0kJ2FhDs=;
        b=khNp11hqgTvxQJhvu6oB5b1B3cmY3SBiVdzBOVChrZAwgwf+qwdSy3RXXpOF35p1th
         5EkNR+RasgUYYV7g7eP1/5dAlPrZfVZCS4m3EmnKnkEhbi2WuOiEccMd6GnrX4QfS+Bj
         l5Xt0PRrxV0Wg4ndGZnyEN+aVWVJhOk2ozB+EF9TNe+9VE/wkesMur1FrxUZddETTucC
         IFrvw9VCHZVIAFGTPQMZ+fun0k7HkXhqVc+6v/0IdLgs94G3T0FlGB89wqVI8ZRdoSvP
         dL6x9xaXE4Bwgly6kd4OsYhD3OG/4FnedIde2xMeVds8lTqhCCbcKOVsBRf/rh2t3Tk+
         RI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721996903; x=1722601703;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5hfWIomveSKSbFLIYbxIdGK2baB0bvKEFr0kJ2FhDs=;
        b=lKKzpOlzr2/KFGA41V+bU/N2wLMGitEfpPVFJWotW5j22Gb5BYtStYb629EqZw3xVg
         0R+kYT/DTb2RDZAJJWZ44J1uFvwJDQZAy9il1wai9+kpZY7XB6qrkqiqg2tIQS1UTCS8
         f/IujtoGSjUiej+swBy2cCTkQrGOhxEa6krxxv32rmQdJXeP0Fxbuxw1veoU46D0pqs+
         y/JPHyI1qMbUwy88xhVt8VyXJ9pyV6rC2n+jWoRTGRiZVrc80ls8nXMB9TnPOeQntWYu
         n/B7p67mc3TNB3uHCGgUoxwF6z5EmCs2J6WGqUfASEipdOxyRGudEl9lydsvrp40d1nH
         0s9w==
X-Forwarded-Encrypted: i=1; AJvYcCVcOcSalSaU0ign1XUEfkJ75ntPF90WDrf/kmBzvG63hAV7n+W+I0aoNovIn7XO6j9E3uXsJ1zvMg4M7S4UQzchp4E4gmBsD4hrVdvw
X-Gm-Message-State: AOJu0YyCl+gkEcUIGGzcJgDHom7ucyJC1zVUBE5ZMaSNpgLfUZ17iug2
	4hWj3husytKsMqz2iMFWb711TrKD0+Tbc0ScvUZ8x6Rnk2mYeH9GjK39Sw27AjM0MoDrXk/VwEU
	KX7HWsg==
X-Google-Smtp-Source: AGHT+IH5Ulm8vRlJh5iJ5QC2ZfhQWC6E4sLBU65jLwjlYWjC3ZeJW3trdzoHRikG50LjNLinHJTGLFxj/eZv
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:a7:c:ee6b:f81a:350c:ce96])
 (user=kyletso job=sendgmr) by 2002:a05:690c:6612:b0:64b:3997:8bb4 with SMTP
 id 00721157ae682-675baec1314mr2730757b3.4.1721996903139; Fri, 26 Jul 2024
 05:28:23 -0700 (PDT)
Date: Fri, 26 Jul 2024 20:28:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240726122814.729082-1-kyletso@google.com>
Subject: [PATCH v2] usb: dwc3: Runtime get and put usb power_supply handle
From: Kyle Tso <kyletso@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, raychi@google.com
Cc: badhri@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	royluo@google.com, bvanassche@acm.org, Kyle Tso <kyletso@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It is possible that the usb power_supply is registered after the probe
of dwc3. In this case, trying to get the usb power_supply during the
probe will fail and there is no chance to try again. Also the usb
power_supply might be unregistered at anytime so that the handle of it
in dwc3 would become invalid. To fix this, get the handle right before
calling to power_supply functions and put it afterward.

Fixes: 6f0764b5adea ("usb: dwc3: add a power supply for current control")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
---
v1 -> v2:
- move power_supply_put out of interrupt context

 drivers/usb/dwc3/core.c   | 62 ++++++++++++++++++++++++++-------------
 drivers/usb/dwc3/core.h   | 10 +++++--
 drivers/usb/dwc3/gadget.c | 10 +------
 3 files changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 734de2a8bd21..9978067b7734 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -283,6 +283,38 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 	queue_work(system_freezable_wq, &dwc->drd_work);
 }
 
+static void __dwc3_set_gadget_vbus_draw(struct work_struct *work)
+{
+	struct dwc3 *dwc = vbus_work_to_dwc(work);
+	struct power_supply *usb_psy;
+	union power_supply_propval val = {};
+	int ret;
+
+	usb_psy = power_supply_get_by_name(dwc->usb_psy_name);
+	if (!usb_psy) {
+		dev_err(dwc->dev, "couldn't get usb power supply\n");
+		return;
+	}
+
+	val.intval = 1000 * READ_ONCE(dwc->vbus_draw_ma);
+	ret = power_supply_set_property(usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
+	if (ret < 0)
+		dev_err(dwc->dev, "failed to set power supply property\n");
+
+	power_supply_put(usb_psy);
+}
+
+int dwc3_set_gadget_vbus_draw(struct dwc3 *dwc, unsigned int mA)
+{
+	if (!dwc->usb_psy_name)
+		return -EOPNOTSUPP;
+
+	WRITE_ONCE(dwc->vbus_draw_ma, mA);
+	queue_work(system_highpri_wq, &dwc->vbus_draw_work);
+
+	return 0;
+}
+
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
 {
 	struct dwc3		*dwc = dep->dwc;
@@ -1631,8 +1663,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			tx_thr_num_pkt_prd = 0;
 	u8			tx_max_burst_prd = 0;
 	u8			tx_fifo_resize_max_num;
-	const char		*usb_psy_name;
-	int			ret;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xf;
@@ -1667,12 +1697,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
 
-	ret = device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
-	if (ret >= 0) {
-		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
-		if (!dwc->usb_psy)
-			dev_err(dev, "couldn't get usb power supply\n");
-	}
+	device_property_read_string(dev, "usb-psy-name", &dwc->usb_psy_name);
 
 	dwc->has_lpm_erratum = device_property_read_bool(dev,
 				"snps,has-lpm-erratum");
@@ -2130,21 +2155,22 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	if (dwc->usb_psy_name)
+		INIT_WORK(&dwc->vbus_draw_work, __dwc3_set_gadget_vbus_draw);
+
 	dwc3_get_software_properties(dwc);
 
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
-	if (IS_ERR(dwc->reset)) {
-		ret = PTR_ERR(dwc->reset);
-		goto err_put_psy;
-	}
+	if (IS_ERR(dwc->reset))
+		return PTR_ERR(dwc->reset);
 
 	ret = dwc3_get_clocks(dwc);
 	if (ret)
-		goto err_put_psy;
+		return ret;
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
-		goto err_put_psy;
+		return ret;
 
 	ret = dwc3_clk_enable(dwc);
 	if (ret)
@@ -2245,9 +2271,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_clk_disable(dwc);
 err_assert_reset:
 	reset_control_assert(dwc->reset);
-err_put_psy:
-	if (dwc->usb_psy)
-		power_supply_put(dwc->usb_psy);
 
 	return ret;
 }
@@ -2258,6 +2281,8 @@ static void dwc3_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 
+	if (dwc->usb_psy_name)
+		cancel_work_sync(&dwc->vbus_draw_work);
 	dwc3_core_exit_mode(dwc);
 	dwc3_debugfs_exit(dwc);
 
@@ -2276,9 +2301,6 @@ static void dwc3_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 
 	dwc3_free_event_buffers(dwc);
-
-	if (dwc->usb_psy)
-		power_supply_put(dwc->usb_psy);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1e561fd8b86e..b82eed4ad2b2 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -993,6 +993,8 @@ struct dwc3_scratchpad_array {
 /**
  * struct dwc3 - representation of our controller
  * @drd_work: workqueue used for role swapping
+ * @vbus_draw_work: work used for setting Vbus current through power_supply
+ * @vbus_draw_ma: Vbus current draw to be set
  * @ep0_trb: trb which is used for the ctrl_req
  * @bounce: address of bounce buffer
  * @setup_buf: used while precessing STD USB requests
@@ -1045,7 +1047,7 @@ struct dwc3_scratchpad_array {
  * @role_sw: usb_role_switch handle
  * @role_switch_default_mode: default operation mode of controller while
  *			usb role is USB_ROLE_NONE.
- * @usb_psy: pointer to power supply interface.
+ * @usb_psy_name: name of the usb power supply interface.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to array of USB2 PHYs
@@ -1163,6 +1165,8 @@ struct dwc3_scratchpad_array {
  */
 struct dwc3 {
 	struct work_struct	drd_work;
+	struct work_struct	vbus_draw_work;
+	unsigned int		vbus_draw_ma;
 	struct dwc3_trb		*ep0_trb;
 	void			*bounce;
 	u8			*setup_buf;
@@ -1223,7 +1227,7 @@ struct dwc3 {
 	struct usb_role_switch	*role_sw;
 	enum usb_dr_mode	role_switch_default_mode;
 
-	struct power_supply	*usb_psy;
+	const char		*usb_psy_name;
 
 	u32			fladj;
 	u32			ref_clk_per;
@@ -1394,6 +1398,7 @@ struct dwc3 {
 #define INCRX_UNDEF_LENGTH_BURST_MODE 1
 
 #define work_to_dwc(w)		(container_of((w), struct dwc3, drd_work))
+#define vbus_work_to_dwc(w)	container_of((w), struct dwc3, vbus_draw_work)
 
 /* -------------------------------------------------------------------------- */
 
@@ -1554,6 +1559,7 @@ struct dwc3_gadget_ep_cmd_params {
 /* prototypes */
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
+int dwc3_set_gadget_vbus_draw(struct dwc3 *dwc, unsigned int mA);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
 #define DWC3_IP_IS(_ip)							\
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..93bf348c24eb 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3050,19 +3050,11 @@ static void dwc3_gadget_set_ssp_rate(struct usb_gadget *g,
 static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	union power_supply_propval	val = {0};
-	int				ret;
 
 	if (dwc->usb2_phy)
 		return usb_phy_set_power(dwc->usb2_phy, mA);
 
-	if (!dwc->usb_psy)
-		return -EOPNOTSUPP;
-
-	val.intval = 1000 * mA;
-	ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
-
-	return ret;
+	return dwc3_set_gadget_vbus_draw(dwc, mA);
 }
 
 /**
-- 
2.46.0.rc1.232.g9752f9e123-goog


