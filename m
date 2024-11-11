Return-Path: <linux-kernel+bounces-403904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1D49C3C76
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D461F2100A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4A175D54;
	Mon, 11 Nov 2024 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFWlgv4y"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8B1474B9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322456; cv=none; b=aqHO9uY+4bYrkY44hR9CMyRErKN8ymk75ViuRZIdCEWOajUBmWv+R5CHkqQzwV8s+1ikAe9QPMuWc8nfVgI2tLFo90soZ2a6kgiSpsn17/OJyVOy3TlTQvvLrWF+3ghYf6NCZ87eK8mVMQ/hYWtkIe3bMxzlD/OaDqM/clBlUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322456; c=relaxed/simple;
	bh=OowcFAz5Dwz/C1seGeNFxtRG1mxbi5v5LtbKYioHDjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kHFWFVVIsJ8qpd3l96h0EKFO4R6c2Deq1bp8LHdj+QMEWiBQBJRr0bOrFCc5NraMEGSGnWheuSPgVsi6QNu6KIROZbFMACFHODB3FuuPw/e0bO0GkOoRgFDVqf6d4f/RY0rdaELKXTZz2PCI6kJ9VKwnph17EhM3Gpd37/TUA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dFWlgv4y; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so177317066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731322453; x=1731927253; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQneMUOMjSH+Cp2gVnrl7p/sshIVbnp503eWg1V6QLc=;
        b=dFWlgv4y5jEjfnjNP5Rxf29H+bSS1HT7f5qxixeRk/Pf0OL0idbXp/folesxxMZxGz
         P7BwQpdNvxTjeLg6qURBwHJ1bqb52ywYZIy4vZSaDRoWcfGllCMDiI2/35YawF9CmOSM
         sWR9yakxxUra4El48sVqaNhO4Ut7X0yev+aQK+u6ho5HlVEOti9ndAgYY/cyl+1UktvJ
         asuRT6sCFBui7ExBvOwyBeAWM0O5/+exEl/Dz5v9sb99WB+NcAIzBRNMJdxnm7OTfyKe
         HH7xbZ3EMiv6PjMz769Pg4j4EAbNe5XTNv6ESo/og7iBdYWtAELOsijGlELMfacT2QXa
         FFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322453; x=1731927253;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQneMUOMjSH+Cp2gVnrl7p/sshIVbnp503eWg1V6QLc=;
        b=Hzy1SkdOkX46WaCeV6bUSZfR6j+E81DCUEvPvhSm8UElg0W43dtzYeT2yVQ5KVQVS6
         Gjt2P2Y06iFgh2FVPgjgQX8eBSQk6NNoEIG81/2MM/SVH3Q0KyDPIHjDs+KyKXRplJXw
         z7pSK8Ht7qGVMGQKd4HQn9NXmo5l9Yhd/4Om+dFEVr7GSqGZcpIXkto0PJY1Dcb43Qil
         uub5CXtQdyb/zgg1plXIcgfCXpbf6I3PyxF9J02/T3LPYXz7C+232Um1Fj56xQ6yMpaS
         wRcuhJ6QI/HOAS2hv0UR2g54pU0yrxAa/AaPeloJKjgODpEwMD7r0OydPnIp1tKE61UF
         3GQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgywCTZi33SLPsI0AVzOElSVZS4bpedeqHtlF/vM/axoaNBnWqAcVmkhZ/YPo2xfbLsY0vglD0fzHA4rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKzkmi+yD2xjt22PDkTv1nnMOA9xrszczd5lQflj7Gv6aca5h
	XiN57EUhR/Vp8sD3mfUXsaehGdtbpdfi86T1tfF5SeKXlqGQg6SstmK7/fm2oN4=
X-Google-Smtp-Source: AGHT+IGGNGfUJKhCO6MzCsxlQnH5pxc4VNoNzngtjkm0QZ2t1Vi54hvYQhkfEkzTtVc4Yp3e4sQ5dQ==
X-Received: by 2002:a17:907:1c11:b0:a9a:26a5:d508 with SMTP id a640c23a62f3a-a9eefebd194mr1111771566b.9.1731322452841;
        Mon, 11 Nov 2024 02:54:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0abe369sm575830366b.83.2024.11.11.02.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:54:12 -0800 (PST)
Date: Mon, 11 Nov 2024 13:54:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] kunit: skb: add gfp to kernel doc for kunit_zalloc_skb()
Message-ID: <b31a16ef-382f-4b8f-b4d5-1c4d93803779@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Kuan-Wei Chiu pointed out that the kernel doc for kunit_zalloc_skb()
needs to include the @gfp information.  Add it.

Reported-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Closes: https://lore.kernel.org/all/Zy+VIXDPuU613fFd@visitorckw-System-Product-Name/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/kunit/skbuff.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/kunit/skbuff.h b/include/kunit/skbuff.h
index 345e1e8f0312..07784694357c 100644
--- a/include/kunit/skbuff.h
+++ b/include/kunit/skbuff.h
@@ -20,8 +20,9 @@ static void kunit_action_kfree_skb(void *p)
  * kunit_zalloc_skb() - Allocate and initialize a resource managed skb.
  * @test: The test case to which the skb belongs
  * @len: size to allocate
+ * @gfp: allocation flags
  *
- * Allocate a new struct sk_buff with GFP_KERNEL, zero fill the give length
+ * Allocate a new struct sk_buff with gfp flags, zero fill the given length
  * and add it as a resource to the kunit test for automatic cleanup.
  *
  * Returns: newly allocated SKB, or %NULL on error
-- 
2.45.2


