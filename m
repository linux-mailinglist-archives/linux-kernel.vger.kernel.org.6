Return-Path: <linux-kernel+bounces-251274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DFC9302E9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01393B2289C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C81DF53;
	Sat, 13 Jul 2024 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjotkBUe"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F884C6E
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720832592; cv=none; b=oG77r2KzOBs9oaEC7Rfgeq5ku/0mH6WAmnynVMyFJNohLlqLtgoVsSD1rKp0KS9nBEZZtXfx1Zz7g9DwHi6AAAbgF3cRI6NPmVXPj1N/S76d0vMOoV74oOzoHsmSa97O7bBPVr3XxuDJlIvEQqjWzCBvxSGBRcwqDb+Uv2ahxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720832592; c=relaxed/simple;
	bh=UNBl82bWy6BK4QvIg/lANifWxpGzKBqS6jSOUjWhy2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kNJaL0Dlu1Bq9Zsxn5RkhlUpeKz84mGZuyCWyZy2G72JbXkoLmjwm22bJ1IbJsE3vlE7QhmO1C8u/zCP16Bob+RhKRQPGsscGz7qGXf4LdDCl6L7lG+W5miVouzsP4D6v3qwRKdy2HDnRT7/7uDAlforvDoRmJWPauGSwKSelLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZjotkBUe; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d9dd7e5f6eso1373799b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720832589; x=1721437389; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXBzGKQHzwTCLNi/QbLQ9MxDBvRYj/mrMe6mJtSFLx4=;
        b=ZjotkBUenoi/S9I65VkyteuUmkLaZ8Lm+s/Bzt9Lt52+i/vuz71szXzpEdsx+Ln9SX
         9sInb/YjNLygYybZ7qzNeKLn7P3OmXwN/hAIDU3LRSNpggbzZ7BXzdmYqlGhj/A0sK6O
         mWJ1RP/1turoZNxlQjmsC5mwWR7KicSnqtDM0wnmyEAf+IUrGRA3kH63QLuvzoL1Mdmc
         BM65ZO3ujqCS5Ru/xdLRt2pzVeQ//Le5iIQgA+SFiAZfV7YzaJFlOKXButr8DvsotLWV
         bZvkbB34nlIYLHXH5EBLtG+DdQV/giYwWBzSvMBGWrVbXKArAlr9Pq+byan2O/WlPmjX
         bfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720832589; x=1721437389;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXBzGKQHzwTCLNi/QbLQ9MxDBvRYj/mrMe6mJtSFLx4=;
        b=NWgjx5EI2nbAu+Hb3nw+qBwRvUgBy16whjeZspdNoWuoSHO2pPEEtdiwVzT4l/CCid
         OOeb+51zyJfq241gXFxvTKqYoViqm1DttVuzxS05V6WsJ6ZJWJADIeSnKuech/0/wwsZ
         Io3o3F1Njxel7I/IMvZP3HCHAqQkGoPEqeWvYduRH+y31EVqxxmH0Icfxr97fOweYUvZ
         bbvbimQClh375sHQgdMsZlkWbjrVykiYI/RbNgwywkGKADsz0j5SM1bApfAmJvlSxaQy
         35FBDAb02FHkMVpK3Ev4cGLpwtHxzbmVeRLEf+1JtaLeTDt3GNwCOLic1+wZsaD6QmyN
         GM6w==
X-Forwarded-Encrypted: i=1; AJvYcCWNlzeuNLMayS+9I7JliR7JmD1DtpgzUfEh+NOdJbc2i9I3V9wxVJuzgkLMwxA+qNM/FcY063EnKtjlOB1mI+iqyuxpqNkD0/xpA9l0
X-Gm-Message-State: AOJu0Yyo6UQ5TmGEHfmpjpFyxhiBb0WQ3O0v16yQfBYj2g7OA/3WfAI+
	IVF734w3Prqeyn/NONPkPh4c4VSLUxR5AZilECCWjTFsCNZKD8CSv30qQCT05rc=
X-Google-Smtp-Source: AGHT+IHrcn916Hce1CRrEs0ecid1zN7rNG5C1ltGgNYwmbOmsJO2nacySkLmcuDxq0DTDMpveul2Gg==
X-Received: by 2002:a05:6870:6587:b0:25e:1061:6541 with SMTP id 586e51a60fabf-25eae75e8f4mr11263510fac.7.1720832589608;
        Fri, 12 Jul 2024 18:03:09 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1cb1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2607530524asm57773fac.53.2024.07.12.18.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 18:03:09 -0700 (PDT)
Date: Fri, 12 Jul 2024 20:03:06 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/x86/intel/tpmi/plr: Uninitialized variable in
 plr_print_bits()
Message-ID: <8ccfab0c-3c11-4168-a383-19895ae60022@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Initialize the "str" pointer to NULL.  There is a test later for if "str"
is NULL but in the original code it was either valid or uninitialized.

Fixes: 9e9397a41b7b ("platform/x86/intel/tpmi/plr: Add support for the plr mailbox")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Almost everyone automatically initializes stack variables to zero these days so
bugs like this don't show up in testing and we disabled GCC's uninitialized
variable warning so it's easy to miss.

 drivers/platform/x86/intel/intel_plr_tpmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/intel_plr_tpmi.c b/drivers/platform/x86/intel/intel_plr_tpmi.c
index c1aa52c23d25..2725a1ddba92 100644
--- a/drivers/platform/x86/intel/intel_plr_tpmi.c
+++ b/drivers/platform/x86/intel/intel_plr_tpmi.c
@@ -162,7 +162,7 @@ static int plr_clear_cpu_status(struct tpmi_plr_die *plr_die, int cpu)
 static void plr_print_bits(struct seq_file *s, u64 val, int bits)
 {
 	const unsigned long mask[] = { BITMAP_FROM_U64(val) };
-	const char *str;
+	const char *str = NULL;
 	int bit, index;
 
 	for_each_set_bit(bit, mask, bits) {
-- 
2.43.0


