Return-Path: <linux-kernel+bounces-253042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAC9931BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E05B282360
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6260013AD05;
	Mon, 15 Jul 2024 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJfiXsAZ"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1615A7EF04
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074981; cv=none; b=b3Kq6GZfTOTPaRSptS5hz0ydiSD5E2ataO+Qg0sRcG0Und5s4t4y6DjPkuMsl0sZQu4FKAQFQgLwIvoBs+vWDzrsrF1v/vkQSGIHFCUTln42HMQg+zjhRfhr1hUq5eop2mSUMSfcfWU0i4L+jG3gwtm/IgV4GeR6Felij9c7xnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074981; c=relaxed/simple;
	bh=JOZ28iCKMuwJxA0hytXjgkoNBjAf0gBGWTDlMp9gjMg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R0MNGFZ4+Dchj65EOdt9on0KJhx4Ct9wLoeAEDPbDTuoCL5I7GDQ99nZk90AKeyu4SHSSPcH+CRH4MA9RCQN4IQ1PU0RUdV3fgdRlpg3+ujF+CWAUwCFBdsaWst07FDKx39Kh9ttctXWwUfSlMEu/9GOgXmRVID1x5YhyvlTH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TJfiXsAZ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5c669a0b5d1so2640231eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721074979; x=1721679779; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PxzT0SN3KlZDqe7HSlcdVmVH8IF9jSYcZYq5mPjp6ic=;
        b=TJfiXsAZrhiV55+8XzjVwhHX8CNF6IMxjmK6crJPfuTTBubldi3tazREeJRrehGIdk
         Q+eTxvWGJlghIRerz0uuw7Nf3xxVfxF8sgRmO8cecj/AeHfAsusCvRV+DkfYkJSV+NW5
         bmzhTvrziPqcZwO+q/FVa3cmi4JfIFQj9robLD5MovCPOfvoDYQ7iWWrdU6JQMVNIR+R
         PywZl+7R24SIQMJGvwQD6HGPuIUOFeqWl3hL2zYXUV4oD3sCDyFoWyd5iLZ8EQw99+qI
         bnywq485Z4jgoQWgwnpA7wTYsJhnUegEn81E5eDdHsG47dQwAUttyEujA9LetraJrI19
         0wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074979; x=1721679779;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxzT0SN3KlZDqe7HSlcdVmVH8IF9jSYcZYq5mPjp6ic=;
        b=kzTsyh+qx7BaaYfUrGhv5f0QIb5zLFa5PbF2gO1x0HXAsBNh2kzu05Bp2fDZTBFWru
         eUFaBQStGypJZvzfIV5QYbynZdbJY9QOMUKMQtulwv5f286QSqwILB9os0Bt7PPubpjB
         QyzRIYZo1i12bkAJPpErh41imvSk2/GdX0hPS03qNmJIvhvSixdM3ekz31cWbmgDppEv
         TCc4QFyK73RahLAJOmLo3sOfiDoWWQXtYi7Hn1KiayoMlg1mrxA47rduzXxi2eORdTe1
         Ep7B2op+ygoD+QAtRZ1iSfz5ABl1EvBAJpYIsKzWykH01akR7YAeCrdOCuGqE1/ELSH/
         MVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvrTX8F2UVp0TCndjV9denW8+LOs5VZatxHlP8K9dbRviQrfdzInDFrlH+4UJLnr4uRGdpOFkwRW0ofljGkry2P2jB4xnqJeitkc9c
X-Gm-Message-State: AOJu0Yx72lgKzMSPMdL/zCqvOmBDw2sBjmw7W0SzqbG9E+LsRHLefnh+
	gevDJPVLs8+SUt3eY33c5ZCDCHlN3UyEsRDVSWhpQBRdhqwk6OQZfkfNch6A8uM=
X-Google-Smtp-Source: AGHT+IE6iz+VJy5pl+98qTdQOY8G87Tq38PgtWVMsTaW/ZgCE0q6Hk/6a96OkviHPSMLGWHtiWkiPw==
X-Received: by 2002:a05:6820:983:b0:5c4:10df:c479 with SMTP id 006d021491bc7-5d286d18e83mr217369eaf.2.1721074979149;
        Mon, 15 Jul 2024 13:22:59 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:750c:19a4:cf5:50a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ce774dbde3sm898325eaf.43.2024.07.15.13.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 13:22:58 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:22:55 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] platform/x86/intel/tpmi/plr: Fix output in
 plr_print_bits()
Message-ID: <b0084e70-4144-445a-9b89-fb19f6b8336a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that 'str' can be used without being initialized:

    drivers/platform/x86/intel/intel_plr_tpmi.c:178 plr_print_bits()
    error: uninitialized symbol 'str'.

In this loop, we iterate over all the set bits and print the name of the
bit.  The intention is that if there is a bit which is between 0-31 we
look for the name in the first array plr_coarse_reasons[] which has 10
elements.  If the bit is in the 32-63 range we look for it in the
plr_fine_reasons[] array which has 30 elements.  If the bit is in the
invalid ranges, 10-31 or 62-63, then we should print "UNKNOWN(%d)".

The problem is that 'str' needs to be initialized at the start of each
iteration, otherwise if we can't find the string then instead of printing
"UNKNOWN(%d)", we will re-print whatever the previous bit was.

Fixes: 9e9397a41b7b ("platform/x86/intel/tpmi/plr: Add support for the plr mailbox")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: initialize str at the start of each iteration

 drivers/platform/x86/intel/intel_plr_tpmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/intel_plr_tpmi.c b/drivers/platform/x86/intel/intel_plr_tpmi.c
index c1aa52c23d25..69ace6a629bc 100644
--- a/drivers/platform/x86/intel/intel_plr_tpmi.c
+++ b/drivers/platform/x86/intel/intel_plr_tpmi.c
@@ -162,10 +162,11 @@ static int plr_clear_cpu_status(struct tpmi_plr_die *plr_die, int cpu)
 static void plr_print_bits(struct seq_file *s, u64 val, int bits)
 {
 	const unsigned long mask[] = { BITMAP_FROM_U64(val) };
-	const char *str;
 	int bit, index;
 
 	for_each_set_bit(bit, mask, bits) {
+		const char *str = NULL;
+
 		if (bit < PLR_COARSE_REASON_BITS) {
 			if (bit < ARRAY_SIZE(plr_coarse_reasons))
 				str = plr_coarse_reasons[bit];
-- 
2.43.0


