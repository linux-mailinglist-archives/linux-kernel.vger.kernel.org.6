Return-Path: <linux-kernel+bounces-305301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9EE962C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA871F25A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195D1A2560;
	Wed, 28 Aug 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qX7K1SWq"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0214831D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859650; cv=none; b=cwDc5DZ+83Zv6tc0xZZc2k59D6Yf6gLGhlkXfMSodU12DoVWkWcAFqldQJYEdLD+A3+lO9lqcxxYdw3KoDVIvvkugHoe8e+rEECo11VZgOhtJZjMspNKmFB+x/EhH4IQYGFK2GP/fW3qON5LOJjEDYBBCbwInP6t8JO7gzha71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859650; c=relaxed/simple;
	bh=5dLxinIqv5BUUD0nIFjgfg+nWPXfGhVa0Ds4mcHJctE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oq5dQ5UYF/JuJbZMAoYkFt1FWAtHorz+XVCo6WD3aSucVeCsI6C5ZpnceHFRxZQLi4F2VAuVbX9qMg4JB1N6UtSVL8Yd1HRKfknCq/wNLdsJu47GDvB5A4Q+n8sY/nBZ+CQ0zBKkDAf4QYclQ1v42pwrXAeecMhRjZhX4VG75Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qX7K1SWq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42816096cb8so75150175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724859647; x=1725464447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BYbMmcZdZDiXZyPGIkiuYHwNwB5E9AVMUbG4e5BXAE=;
        b=qX7K1SWqSO74m6waiiSUkU+lvmepW1d0sqJhwIAI4ObiV/Ocw7UtBMscz1sbXGYk4Q
         pyVP0fw1vEZ5lvd46anodyQgVBWbX2TpRLRmecVllZnl4N/j9TuZJdk+oTHSK+3TpkSU
         00/aUVoG2L4FZL8wTEXR/4HE8M93mH312AzElBSviwa003fTn46ya2GcbQcxseCBPtHq
         WwGQ8JyBSg90pKt1hIp5n6Tl6z6f9wDVbypHVBFEuq7NGfPqL59HeSeUWcn22ogcUXUU
         E3RC5m0zaUolPQJBdyGrcqkfLQ1Bqx0zwjJqQQPvZDTB2auuoqXkeIDcxV6dKtkxDfv0
         DkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859647; x=1725464447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BYbMmcZdZDiXZyPGIkiuYHwNwB5E9AVMUbG4e5BXAE=;
        b=l9YOeUoeSkmSD+HJLU4ksV8TxaMuti94iEUU+qxch6a+s2TrGSpwNEuKp18DZqk2Rp
         fkmpV4hBt8Y+DzhxCHI4DxaS7qfbDUlMh+fXTafvMImcWmZH3cf5Vh9v7535ourz/KZp
         iV47Bvd2saDhiMqdRsDI8ylm5GEBc4GewiWtrh/HR/XSJmyy3ThgaUSjOUuKCqG4ThJ/
         0e2SIl9pkSxRr4JnjCJTxxSIj7B9THtexXPhFYtECO9e9yEax1ViDL+EJn3AAVMrTXT2
         6EIkYOf5kJivIflVXrwsQoXLOQ9H0sjk48W/2G/Taj6ur3DcHoIyWRFLVGQ7v5kD3PwH
         fLsw==
X-Forwarded-Encrypted: i=1; AJvYcCVUkMdwER9fKJa7HQ3Zjab9k0W4GP5ht6ZX4m6Hwh78oXJtb48TmsKWbG3s1RYoCi+Dsp6XbZ9zu5QT1nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZV9OiSQX1kStMptOUPano9pOTTjX/h2IBxJ0D3uYWZQxLMFHu
	heLDNpdbEDWSA62m/g9MJ6+8BWoM5PXebSmkJjCiZX4dCvzIo5L4l9qCZjpUH5g6npHAa08Ex35
	bNgg/SRu+Qx2LkjTJ1A==
X-Google-Smtp-Source: AGHT+IFRPYDoFbKtx4Ad99iy5AACRvJYyMcFI2npnGMUjtKSOCiNatbNXQVj21rZkTauqFcAdqQq4aGPJOu9pg+q
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a7b:cd17:0:b0:426:5ff0:1b4d with SMTP
 id 5b1f17b1804b1-42bb02bf44dmr1435e9.3.1724859647112; Wed, 28 Aug 2024
 08:40:47 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:40:39 +0100
In-Reply-To: <20240821115636.3546f684@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240821115636.3546f684@gandalf.local.home>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828154040.2803428-1-vdonnefort@google.com>
Subject: [PATCH 1/2] ring-buffer/selftest: Verify the entire meta-page padding
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	kernel-team@android.com, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Improve the ring-buffer meta-page test coverage by checking for the
entire padding region to be 0 instead of just looking at the first 4
bytes.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

--

Hi,

I saw you have sent "Align meta-page to sub-buffers for improved TLB usage" to
linux-next, so here's a follow-up patch addressing your comments, not sure if
you want to squash it or to put it on top.

diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index 4bb0192e43f3..ba12fd31de87 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -231,15 +231,15 @@ TEST_F(map, data_mmap)
 
 	/* Verify meta-page padding */
 	if (desc->meta->meta_page_size > getpagesize()) {
-		void *addr;
-
 		data_len = desc->meta->meta_page_size;
 		data = mmap(NULL, data_len,
 			    PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
 		ASSERT_NE(data, MAP_FAILED);
 
-		addr = (void *)((unsigned long)data + getpagesize());
-		ASSERT_EQ(*((int *)addr), 0);
+		for (int i = desc->meta->meta_struct_len;
+		     i < desc->meta->meta_page_size; i += sizeof(int))
+			ASSERT_EQ(*(int *)(data + i), 0);
+
 		munmap(data, data_len);
 	}
 }

base-commit: 2a07e30c19f391af26517c409fd66e401c6f4ee7
prerequisite-patch-id: 16b79d676c5faf3b57443b576976c7522fcd5a4b
-- 
2.46.0.295.g3b9ea8a38a-goog


