Return-Path: <linux-kernel+bounces-226371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39661913D7D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89B91F2005B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D1918629D;
	Sun, 23 Jun 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUsnKb/x"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518941836F4
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165481; cv=none; b=guY0uhDf9SGrXZgP1lVKL/GUJdDKCZJoJST6wgTx66Z4qgjHG2mYbdV4ypheevEMlgdirSZtPMwPG3GKiqxgS/kyC4xdBWhpdR+ylf6qJkNwFImGWG9/1THSmAkoEfUXXZdLuH6OVigICRepN7E8PR8KFr/xz+dkHFiXhUvoNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165481; c=relaxed/simple;
	bh=4y99/Bx95YqKoijdJWQ6liswcalzChA+1DSzWRfTZQk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StgWICIoEwAXx5Lb763+YP9uSIwJM3QB2N0hmnMR3Nt/6NcgNQgPhSkSQIiYt+ReKCKI+YdMCZR+ajYWpTyKze6+Pm7m6QADXNYh6FrdX6sM4mHgCvzjpFZOOof7B2Tt5mlkDal9AA1VwHT6jiM3h7dtcW6w/Xt5Qo9Rm5ML8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUsnKb/x; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d0f84b379so560015a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165479; x=1719770279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTvgNDU+h3og9mxQKfg7iaFGh0/NWIwcOhQKR6cLy8I=;
        b=GUsnKb/xJVp0B+/2vRZDOzwG9WzonFd3ej4lzZ+7UqS8vpGYuLptDFNtxW/KQgmNhA
         hJVYaEAdwnN9SDd2rwdEHiuKBMMXV8SIw/tEiqYQq89sq4gOQO5E7OIzJsYaF029+j6s
         eshJ2i8EoCDpcLJX1xBVBixe2FOWxV28n5vczgqotxGqwRM1QZDnaEglYNe7HCB+wD0h
         GuwTa9Uoxwd78cHoITrKHrQN088qdqZFVNP6iO1O+JUd9U+IpQoGKowGmxXQPFixei5B
         QWZA+Tvd6yezeXUQOJ8KIkkP44zbTRY0LGggC0svlb965qPbMpVoA5lQvCM2LRmm3SsX
         lsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165479; x=1719770279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTvgNDU+h3og9mxQKfg7iaFGh0/NWIwcOhQKR6cLy8I=;
        b=kTdODz4NcUiB7n7KmV8hWikXv3i2obFSYDl5/tO3fThrxYlHACkINNtt/O42m9vhLv
         yiowVlvrgqWItAmI93IwJ2sRVHJCYAJKCi87h6qVZddq2wfiXiZWWqu6OLrcc+zXox88
         KipfdQ5rWOJH7mDUyQj4ZNVj1evaGN+j3UDZF+28364BX8Brbz+669SGOrWN4dIqVt9u
         ZpJbonqolXbC5BlW605/74DcdEpFy7kje7g3mtJHhKHDg9gvGtOfqyZb1jKgioZQZnRB
         50B0JdsT5fukvxl9yU5dpQ/Dqsi5goTu71xsxP5B8ly8+V3TtCzf87nsaLSTQxeDac72
         /m0A==
X-Forwarded-Encrypted: i=1; AJvYcCUpqUDLSfjbFXAwbW4WdJkgtTaRK50rHv5+1AWGSlfPPTe6f6OPZ8F3r/+Ryp6j8uJOkUnuE4UuOiacIYPLW2Z+CO6LHriQpMOLM04q
X-Gm-Message-State: AOJu0YwIMNPBxafEOmLV4jYMkxrS1LVK+3nsJsqJt6AzAa1L6lT17cV/
	npjsqHpRnLrHV0qwWe2S+ZAxbBA+3qzbudL+Zv8owIgnwiQZCq10
X-Google-Smtp-Source: AGHT+IHMPaQGprf4rtmy3Gu/mjzQPRZSiz6TtuTyq3VY53ubxDRFgFMzVhhddc0O/8P6jBruBA5Uxw==
X-Received: by 2002:a17:906:2a14:b0:a6f:bbfd:39d1 with SMTP id a640c23a62f3a-a6fe087be90mr271230566b.2.1719165478521;
        Sun, 23 Jun 2024 10:57:58 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724cac7c48sm78050566b.220.2024.06.23.10.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:57:58 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:57:56 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] staging: rtl8723bs: Remove unused macros in
 rtw_pwrctrl.h
Message-ID: <41f7ed26b5a6de187a71bdc7f062f3817993ba5f.1719155208.git.philipp.g.hortmann@gmail.com>
References: <cover.1719155208.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719155208.git.philipp.g.hortmann@gmail.com>

Remove unused macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/include/rtw_pwrctrl.h   | 38 -------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 0767dbb84199..c27d07861b8c 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -9,25 +9,8 @@
 
 #include <linux/mutex.h>
 
-#define FW_PWR0	0
-#define FW_PWR1		1
-#define FW_PWR2		2
-#define FW_PWR3		3
-
-
-#define HW_PWR0	7
-#define HW_PWR1		6
-#define HW_PWR2		2
-#define HW_PWR3	0
-#define HW_PWR4	8
-
-#define FW_PWRMSK	0x7
-
-
 #define XMIT_ALIVE	BIT(0)
-#define RECV_ALIVE	BIT(1)
 #define CMD_ALIVE	BIT(2)
-#define EVT_ALIVE	BIT(3)
 #define BTCOEX_ALIVE	BIT(4)
 
 
@@ -58,31 +41,17 @@ enum {
 #define PS_ALL_ON			BIT(2)
 #define PS_ST_ACTIVE		BIT(3)
 
-#define PS_ISR_ENABLE		BIT(4)
-#define PS_IMR_ENABLE		BIT(5)
 #define PS_ACK				BIT(6)
 #define PS_TOGGLE			BIT(7)
 
 #define PS_STATE_MASK		(0x0F)
-#define PS_STATE_HW_MASK	(0x07)
-#define PS_SEQ_MASK			(0xc0)
 
 #define PS_STATE(x)		(PS_STATE_MASK & (x))
-#define PS_STATE_HW(x)	(PS_STATE_HW_MASK & (x))
-#define PS_SEQ(x)		(PS_SEQ_MASK & (x))
 
 #define PS_STATE_S0		(PS_DPS)
-#define PS_STATE_S1		(PS_LCLK)
 #define PS_STATE_S2		(PS_RF_OFF)
-#define PS_STATE_S3		(PS_ALL_ON)
 #define PS_STATE_S4		((PS_ST_ACTIVE) | (PS_ALL_ON))
 
-
-#define PS_IS_RF_ON(x)	((x) & (PS_ALL_ON))
-#define PS_IS_ACTIVE(x)	((x) & (PS_ST_ACTIVE))
-#define CLR_PS_STATE(x)	((x) = ((x) & (0xF0)))
-
-
 struct reportpwrstate_parm {
 	unsigned char mode;
 	unsigned char state; /* the CPWM value */
@@ -91,10 +60,6 @@ struct reportpwrstate_parm {
 
 #define LPS_DELAY_TIME	(1 * HZ) /*  1 sec */
 
-#define EXE_PWR_NONE	0x01
-#define EXE_PWR_IPS		0x02
-#define EXE_PWR_LPS		0x04
-
 /*  RF state. */
 enum rt_rf_power_state {
 	rf_on,		/*  RF is on after RFSleep or RFOff */
@@ -247,9 +212,6 @@ struct pwrctrl_priv {
 		_set_timer(&(pwrctl)->pwr_state_check_timer, (ms)); \
 	} while (0)
 
-#define rtw_set_pwr_state_check_timer(pwrctl) \
-	_rtw_set_pwr_state_check_timer((pwrctl), (pwrctl)->pwr_state_check_interval)
-
 extern void rtw_init_pwrctrl_priv(struct adapter *adapter);
 extern void rtw_free_pwrctrl_priv(struct adapter *adapter);
 
-- 
2.45.2


