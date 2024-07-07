Return-Path: <linux-kernel+bounces-243492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E6F9296DE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FBE1F21727
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB1D26A;
	Sun,  7 Jul 2024 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXhVhVbd"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1DA10A03
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335135; cv=none; b=ZG+JIqWfkadmIn09zsp8au+ZyqEpTUz32uw0IxcfhFJyXS2gHDy7jpTTXvn6IzATIyqzqmABIsg+0OEzLYzDAb34qYg8yuoh9NbhwNZPQRAkysZNMdabWHqnkFQkP2JDvX/Uf8yd38Eex1hbi2+xCya5pZa/01f/vIOEHmu2HzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335135; c=relaxed/simple;
	bh=9b6d/ORXvRFcmVwVDh5Rhfn8ZbEw6zsmY6fvkfhRPs8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYZUP9d9bi0prK7m0W8rRDi6DiDgAmJX6WjtpzOMk2ia/ry6DhJfFmZ3ohj42uKh7hTqUd+Lqy0Cw83g7n4Ub0DPLcGcM8PKu3Zp5/2xxwc/HRTjS2IDcv9bhevYJdlFBw4e38pf+bJHX3HSOc4SlxDyLzI2aNuqVYbQv83GQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXhVhVbd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58cdd58c545so477439a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720335132; x=1720939932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEzXJrtXFiaodS1T5pwq0PvMCiPWbVsnVhBTM9pX9Gg=;
        b=EXhVhVbdigg9sqvcbkM+kYuLTHTtTJuFCIUTLplkilSJ9noyg07JeRXeBhbVbqq61g
         XUxkoZ5B/BU81BPkIUU0lVOvyaj+s2svPYROZkjhHr1WEJRQ4wqkz97ZDB3aMiVp8rOi
         T+4GintiJyDQsi+W0WFe3JOPZUpnnDA/nN7vI34lJGA17+lrtRcz9Uw0476laMEhx1QA
         PtHQc/8pZ1p1tLXhn9JeIr5yWKoya5297E3rJ4Yav8VeiNlmhMDFxpNrMepLdncykWQm
         UPznxAhIjK51Sq/AGGG2vnI6VETIhyPbWwzw538fD0G1DtLAK+Iy3R8/E4xMVgPI8OFQ
         1Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335132; x=1720939932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEzXJrtXFiaodS1T5pwq0PvMCiPWbVsnVhBTM9pX9Gg=;
        b=pC/g3A8in9pI80kbAgeXwh1MVBfeC7raX8oBxmerSuYu8byhWEnsVLvYlTHbpvFtM/
         16ndxstP8vyY/ZuGTpB8ihujdtduJTiRJI0xRtXlHk3rVrV17Ma57SQnKbUHiKYewcOP
         K2LRBAin9/nqTFCm14bQpPoKZnryvMXE/5yOzD2RKo8xjzsU/z+T1KXl2dvbqDDKyz27
         idSJX/XYLbfXFeJjObwetjGrWTdciDcJfNdcs3WMYPGY3Aec0B15EBibLjVKLEGXDuee
         ubBnfsXwQ15Qakg+38pBMpoBtSyji3AKbB5mvJkjH8B+G3iXit2zNZF3H6xzM6w/Vqwe
         JQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXHeOTNLevPVvyb8pE4dgukafSh5h55MwaxqeVZw5WY+e+Jofjqe4G1zreU3AXNl/+DFHS1nYHCm0vbOdpUi037vbSN3V+9ARO39lWP
X-Gm-Message-State: AOJu0Ywnpzt7gWmHcBfpvdH2s8GEe5QQU/jDbN4TMMxZrc6ydOclqrJ7
	62EFlrlkbSUprr3FoTSuBDat0L2sBytuVXyKcS5g1u65tp2ydOji
X-Google-Smtp-Source: AGHT+IF6akTA4a6F/Kt23/+THUQoWEztp+BCQC/ItFn76qbl7XsLqyGW7vMcMucAZt+DeIzy2PPQow==
X-Received: by 2002:a50:8d17:0:b0:57c:bc7f:fb48 with SMTP id 4fb4d7f45d1cf-58e565951f2mr5316395a12.0.1720335131963;
        Sat, 06 Jul 2024 23:52:11 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5907e4d79ddsm1906903a12.59.2024.07.06.23.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:52:11 -0700 (PDT)
Date: Sun, 7 Jul 2024 08:52:10 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] staging: rtl8723bs: Remove unused macros in
 hal_com_h2c.h
Message-ID: <68933c5020b21a32fdf56552db0460667f1c9113.1720245061.git.philipp.g.hortmann@gmail.com>
References: <cover.1720245061.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720245061.git.philipp.g.hortmann@gmail.com>

Remove unused macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/include/hal_com_h2c.h   | 76 -------------------
 1 file changed, 76 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_com_h2c.h b/drivers/staging/rtl8723bs/include/hal_com_h2c.h
index 24cd9415fa95..a59d13090565 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_h2c.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_h2c.h
@@ -9,86 +9,10 @@
 
 #define H2C_RSVDPAGE_LOC_LEN		5
 #define H2C_MEDIA_STATUS_RPT_LEN		3
-#define H2C_KEEP_ALIVE_CTRL_LEN	2
-#define H2C_DISCON_DECISION_LEN		3
-#define H2C_AP_OFFLOAD_LEN		3
-#define H2C_AP_WOW_GPIO_CTRL_LEN	4
-#define H2C_AP_PS_LEN			2
 #define H2C_PWRMODE_LEN			7
 #define H2C_PSTUNEPARAM_LEN			4
 #define H2C_MACID_CFG_LEN		7
-#define H2C_BTMP_OPER_LEN			4
-#define H2C_WOWLAN_LEN			4
-#define H2C_REMOTE_WAKE_CTRL_LEN	3
-#define H2C_AOAC_GLOBAL_INFO_LEN	2
-#define H2C_AOAC_RSVDPAGE_LOC_LEN	7
-#define H2C_SCAN_OFFLOAD_CTRL_LEN	4
-#define H2C_BT_FW_PATCH_LEN			6
 #define H2C_RSSI_SETTING_LEN		4
-#define H2C_AP_REQ_TXRPT_LEN		2
-#define H2C_FORCE_BT_TXPWR_LEN		3
-#define H2C_BCN_RSVDPAGE_LEN		5
-#define H2C_PROBERSP_RSVDPAGE_LEN	5
-
-/* _RSVDPAGE_LOC_CMD_0x00 */
-#define SET_H2CCMD_RSVDPAGE_LOC_PROBE_RSP(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE_8BIT(__pH2CCmd, 0, 8, __Value)
-#define SET_H2CCMD_RSVDPAGE_LOC_PSPOLL(__pH2CCmd, __Value)			SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd)+1, 0, 8, __Value)
-#define SET_H2CCMD_RSVDPAGE_LOC_NULL_DATA(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd)+2, 0, 8, __Value)
-#define SET_H2CCMD_RSVDPAGE_LOC_QOS_NULL_DATA(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd)+3, 0, 8, __Value)
-#define SET_H2CCMD_RSVDPAGE_LOC_BT_QOS_NULL_DATA(__pH2CCmd, __Value)SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd)+4, 0, 8, __Value)
-
-/* _MEDIA_STATUS_RPT_PARM_CMD_0x01 */
-#define SET_H2CCMD_MSRRPT_PARM_OPMODE(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE(__pH2CCmd, 0, 1, __Value)
-#define SET_H2CCMD_MSRRPT_PARM_MACID_IND(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE(__pH2CCmd, 1, 1, __Value)
-#define SET_H2CCMD_MSRRPT_PARM_MACID(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE_8BIT(__pH2CCmd+1, 0, 8, __Value)
-#define SET_H2CCMD_MSRRPT_PARM_MACID_END(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE_8BIT(__pH2CCmd+2, 0, 8, __Value)
-
-/* _KEEP_ALIVE_CMD_0x03 */
-#define SET_H2CCMD_KEEPALIVE_PARM_ENABLE(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE(__pH2CCmd, 0, 1, __Value)
-#define SET_H2CCMD_KEEPALIVE_PARM_ADOPT(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE(__pH2CCmd, 1, 1, __Value)
-#define SET_H2CCMD_KEEPALIVE_PARM_PKT_TYPE(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE(__pH2CCmd, 2, 1, __Value)
-#define SET_H2CCMD_KEEPALIVE_PARM_CHECK_PERIOD(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE_8BIT(__pH2CCmd+1, 0, 8, __Value)
-
-/* _DISCONNECT_DECISION_CMD_0x04 */
-#define SET_H2CCMD_DISCONDECISION_PARM_ENABLE(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE(__pH2CCmd, 0, 1, __Value)
-#define SET_H2CCMD_DISCONDECISION_PARM_ADOPT(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE(__pH2CCmd, 1, 1, __Value)
-#define SET_H2CCMD_DISCONDECISION_PARM_CHECK_PERIOD(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE_8BIT(__pH2CCmd+1, 0, 8, __Value)
-#define SET_H2CCMD_DISCONDECISION_PARM_TRY_PKT_NUM(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE_8BIT(__pH2CCmd+2, 0, 8, __Value)
-
-/*  _WoWLAN PARAM_CMD_0x80 */
-#define SET_H2CCMD_WOWLAN_FUNC_ENABLE(__pH2CCmd, __Value)			SET_BITS_TO_LE_1BYTE(__pH2CCmd, 0, 1, __Value)
-#define SET_H2CCMD_WOWLAN_PATTERN_MATCH_ENABLE(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE(__pH2CCmd, 1, 1, __Value)
-#define SET_H2CCMD_WOWLAN_MAGIC_PKT_ENABLE(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE(__pH2CCmd, 2, 1, __Value)
-#define SET_H2CCMD_WOWLAN_UNICAST_PKT_ENABLE(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE(__pH2CCmd, 3, 1, __Value)
-#define SET_H2CCMD_WOWLAN_ALL_PKT_DROP(__pH2CCmd, __Value)			SET_BITS_TO_LE_1BYTE(__pH2CCmd, 4, 1, __Value)
-#define SET_H2CCMD_WOWLAN_GPIO_ACTIVE(__pH2CCmd, __Value)			SET_BITS_TO_LE_1BYTE(__pH2CCmd, 5, 1, __Value)
-#define SET_H2CCMD_WOWLAN_REKEY_WAKE_UP(__pH2CCmd, __Value)			SET_BITS_TO_LE_1BYTE(__pH2CCmd, 6, 1, __Value)
-#define SET_H2CCMD_WOWLAN_DISCONNECT_WAKE_UP(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE(__pH2CCmd, 7, 1, __Value)
-#define SET_H2CCMD_WOWLAN_GPIONUM(__pH2CCmd, __Value)				SET_BITS_TO_LE_1BYTE((__pH2CCmd)+1, 0, 7, __Value)
-#define SET_H2CCMD_WOWLAN_DATAPIN_WAKE_UP(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE((__pH2CCmd)+1, 7, 1, __Value)
-#define SET_H2CCMD_WOWLAN_GPIO_DURATION(__pH2CCmd, __Value)			SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd)+2, 0, 8, __Value)
-/* define SET_H2CCMD_WOWLAN_GPIO_PULSE_EN(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE((__pH2CCmd)+3, 0, 1, __Value) */
-#define SET_H2CCMD_WOWLAN_GPIO_PULSE_COUNT(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd)+3, 0, 8, __Value)
-
-/*  _REMOTE_WAKEUP_CMD_0x81 */
-#define SET_H2CCMD_REMOTE_WAKECTRL_ENABLE(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE(__pH2CCmd, 0, 1, __Value)
-#define SET_H2CCMD_REMOTE_WAKE_CTRL_ARP_OFFLOAD_EN(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE(__pH2CCmd, 1, 1, __Value)
-#define SET_H2CCMD_REMOTE_WAKE_CTRL_NDP_OFFLOAD_EN(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE(__pH2CCmd, 2, 1, __Value)
-#define SET_H2CCMD_REMOTE_WAKE_CTRL_GTK_OFFLOAD_EN(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE(__pH2CCmd, 3, 1, __Value)
-#define SET_H2CCMD_REMOTE_WAKE_CTRL_NLO_OFFLOAD_EN(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE(__pH2CCmd, 4, 1, __Value)
-#define SET_H2CCMD_REMOTE_WAKE_CTRL_FW_UNICAST_EN(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE(__pH2CCmd, 7, 1, __Value)
-#define SET_H2CCMD_REMOTE_WAKE_CTRL_ARP_ACTION(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE((__pH2CCmd)+2, 0, 1, __Value)
-
-/*  AOAC_GLOBAL_INFO_0x82 */
-#define SET_H2CCMD_AOAC_GLOBAL_INFO_PAIRWISE_ENC_ALG(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE_8BIT(__pH2CCmd, 0, 8, __Value)
-#define SET_H2CCMD_AOAC_GLOBAL_INFO_GROUP_ENC_ALG(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd)+1, 0, 8, __Value)
-
-/*  AOAC_RSVDPAGE_LOC_0x83 */
-#define SET_H2CCMD_AOAC_RSVDPAGE_LOC_REMOTE_WAKE_CTRL_INFO(__pH2CCmd, __Value)	SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd), 0, 8, __Value)
-#define SET_H2CCMD_AOAC_RSVDPAGE_LOC_ARP_RSP(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd)+1, 0, 8, __Value)
-#define SET_H2CCMD_AOAC_RSVDPAGE_LOC_NEIGHBOR_ADV(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd)+2, 0, 8, __Value)
-#define SET_H2CCMD_AOAC_RSVDPAGE_LOC_GTK_RSP(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd)+3, 0, 8, __Value)
-#define SET_H2CCMD_AOAC_RSVDPAGE_LOC_GTK_INFO(__pH2CCmd, __Value)		SET_BITS_TO_LE_1BYTE_8BIT((__pH2CCmd)+4, 0, 8, __Value)
 
 /*  */
 /*     Structure    -------------------------------------------------- */
-- 
2.45.2


