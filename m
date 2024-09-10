Return-Path: <linux-kernel+bounces-322445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D57972918
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B3E1F25294
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E27514A088;
	Tue, 10 Sep 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxLp/GEK"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2EB13E02C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947806; cv=none; b=R7OScpyJkef4DblOrnqwrylBpXinZhlSKV/qjShMGS1jC6aIBmoq3OdfSlXXcGIm7YejfNkhis6q0kwjw6Fw3LY5FoRMyJ1zr6HID8n6JpkY8qANRA2RQd0VKIpLHOUMhJrko7KkR+F5iHmW3Kc2mj6E0jjqgMCdvVA8EukZ4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947806; c=relaxed/simple;
	bh=rTcgziOzBrl44U9SH8mF8R76dsFQSPYmbjbU561m79w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipIt5CALw3wuI/7nCibjV0em2TaYPyMf8DA2Wj42I7BpSW9l8R2tuZ2o8H8TQA2ZAz31IH9nwglw7X86lAlILDBnGrkxCDyfAfyVDhLyHWQ4TsSUfOauhS7G7W/XM/GA0Np5ArS8u8JIOsQyYeq8U0KrSSsHO/l45s5ocHVge/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxLp/GEK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c3ed267a7bso449323a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725947804; x=1726552604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=orDkFr4WMNzRd7jwY0Xi5+QqYLxdevVKzsGNIMcO99E=;
        b=TxLp/GEKthMXLsEGSZHkzeil08PxTVGZ3jvhyhFRTXAcrcOx+HyIyoNh3mr90TIzQY
         DHo2Y4nqVEPtAkaq4KosKqnMTb/Ua+Rd1NRYsuC0trQ7Rsx/iK0uIZXr1M9QJ0UCB434
         kTZ2aP3r8g4Hyl5ZO1Hn+aq5wLTNSKZ3RFKZSb2zFrOKEDxYDbfqX/vL2Lkv0CoiXprL
         WBT4LcIdqnDjS70bIHisxflmYeqhdHQLiKpd23n8NgYp1wJVxa2mvMX89rOxg/vo9mEj
         kJHgXEQt9O2XPjwuRoItNdBDbcIWqdajMYN+Q4dMX5YC+HydXK86rRF1CfqaRFZCE3RJ
         oRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947804; x=1726552604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orDkFr4WMNzRd7jwY0Xi5+QqYLxdevVKzsGNIMcO99E=;
        b=GhgkVoY/ogVINXt0TZ3xJ4OVPKnWSyNTSF8vSWSmEi3rIyyf83/vNFlVzT8nFdorlG
         XkuUxcvtG6MmSkIEJGn4DPwjon48lcSCevI1gA0lzz0VFtJeAd+cLzvUx/cKpuPhrOfa
         B7yymbsZcQtJ/JtaF8YWWefIrzAMGhxX5HTOfHgjV3/Q1McqTcX9grA9OtsXCxELW24g
         tl5m84I7a3v2YrFecKsSjMJwe0js3aAzzKLEpqfILRWeqovN2iV/MXSIoBbfsMRlHa3+
         QP5SSBtnBHIczevsInIDeWGWRrqnXQOVImLieksYwuIJF5f1Ia6f0L7z8M+9FQa6zPoq
         vsEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVENk3poc4keM0ioEgVu8MLiSl/QsN8+B17ET1g5OHBlfAUSSn6Fo0VYm1niwMy7p1B6KivgaHU762KR1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YySHyp0qcklea+scgWv8W4xdX46wVkvavOmPOgdglW9sTA3yXU6
	I/9Lu8XzxKxPInQAad75azRt5KnG3lnTTJPjvy288W90L303dYbu
X-Google-Smtp-Source: AGHT+IFedHmF+KlVMrCL6hfR+S34Ahn0E6eK6bozAAYGaeDaDRxhs8LsQkf/dWeUNbH7mHkqBlMDeQ==
X-Received: by 2002:a05:6402:51cb:b0:5a1:c43:82ca with SMTP id 4fb4d7f45d1cf-5c3dc7beaa7mr7526996a12.26.1725947803364;
        Mon, 09 Sep 2024 22:56:43 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cd43sm3848216a12.93.2024.09.09.22.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:56:43 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:56:41 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] staging: rtl8723bs: Remove unused function
 RTW_DISABLE_FUNC
Message-ID: <46545805edb962ae97b15be60e0a3446aae42701.1725826273.git.philipp.g.hortmann@gmail.com>
References: <cover.1725826273.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725826273.git.philipp.g.hortmann@gmail.com>

Remove unused function RTW_DISABLE_FUNC and its comment.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 9e6ca1dec525..0b35c97843cc 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -452,14 +452,7 @@ struct adapter {
 #define DF_RX_BIT		BIT1
 #define DF_IO_BIT		BIT2
 
-/* define RTW_DISABLE_FUNC(padapter, func) (atomic_add(&adapter_to_dvobj(padapter)->disable_func, (func))) */
 /* define RTW_ENABLE_FUNC(padapter, func) (atomic_sub(&adapter_to_dvobj(padapter)->disable_func, (func))) */
-static inline void RTW_DISABLE_FUNC(struct adapter *padapter, int func_bit)
-{
-	int	df = atomic_read(&adapter_to_dvobj(padapter)->disable_func);
-	df |= func_bit;
-	atomic_set(&adapter_to_dvobj(padapter)->disable_func, df);
-}
 
 static inline void RTW_ENABLE_FUNC(struct adapter *padapter, int func_bit)
 {
-- 
2.46.0


