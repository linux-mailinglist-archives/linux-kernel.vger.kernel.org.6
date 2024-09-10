Return-Path: <linux-kernel+bounces-323425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A313973D27
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153CEB243D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9DF1A2540;
	Tue, 10 Sep 2024 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmHDTV1L"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9419924D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985425; cv=none; b=M676CSBnVEwvzbJC9MXWa1Cs8Z/RBubzg0pZAB6S9WjIhaysJsDW0jRjrrNSczzSkwK2LZceSrmdzz6GFiqU4//A2Wvk1jFDRnEtktpMCwVX6TpIo/mUwGaOvPmHPDRoL91v/6BpwXaMyuRx9XOEKVH7SbR6Gsa1IHOaZrOCYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985425; c=relaxed/simple;
	bh=GlHp+sDP2l3iuMBGJMRzuH4oTR65BYOzxJ6K7GQv29A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b5Blv3p/W45UOAD5nrU6QhiEA0RKwRDuN3ORWBPYRSfxMw8TZTy+8W7DMA6yJZEZV0KglqoieAwGOt0xT0E9Mr2wTDZZD9it+KXlRhEpILd4VoTMv+kVrNnVqyC0aESgo1nQvcORqolt2K9l87SBADbGhwtRpI01quRuT3gUs8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmHDTV1L; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb33e6299so19219205e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725985421; x=1726590221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebNtXOw1zw+Y/P3jFG4DVeMhgHXmSDzSdOEI97BWEhQ=;
        b=pmHDTV1LBzxEn57OPtZ959cM9yCo6FtV14bdmSYOr0i8OOMznK96DIlafADdJD6h1w
         EvJ+sYMKEw+A2pXMXPwJ09hYcsNOv5YRYXEWFUHFuY/DLt1aw2465I52yWkklKzrCpq/
         OVYh23XTnKW3gfyX2aIjagpvWG4GWghMjqp9oYPJ7xragDC1p5z8zmgnzjlKZ5+C+4f6
         yq2bByUNbO9N/WbNpWrq1hoR752A8DS4WVPfJUqrijsrsq2VrHuesDze5GMRcX3GBPP4
         Validza4xhvrA8IrwCJV1sUJZIgoGNH7XN2wG2F3s2V2ynDecMPZ0tmN4lCvxTM4lb6M
         3u4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985421; x=1726590221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebNtXOw1zw+Y/P3jFG4DVeMhgHXmSDzSdOEI97BWEhQ=;
        b=wgAe1N/uMh8e7XdMfN1BzXMptibwRsUYPEqWfwrD3psPPKSnK61CLyWchI8r84vR8m
         9l7iTMb/9FeQtbO07dJfqpEQ1txCpZWHkkQMUuyXteSOkmj05HH1clZcoVV6f/T+oMNU
         j4HJzcyT30D51ROAcjQpVixkDAY4wq2ElLi1CWWLidZzQY7Wd1BkMEAImTY2o49FZtL7
         KcojH3eHcDkx2Lq9jfVXvTjjy0qImFaEKF4gsDIUFrS7ZS1vg2770uOR+RsDH5eO/tX8
         cicpWfsDgR6kuLIhja1lU59BVFaK2lyEea4Ia/BWhm0XtJhtN8oZlaEwX+r2wFgtuqb7
         vPbw==
X-Forwarded-Encrypted: i=1; AJvYcCUTK+Sl+nF/OWLS/cXE7SKhxC7GR0W88Q2twRT+bhoIcurUjE4eXxzwluRa2uCiP61y5sM+P4zWyuC7A5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvypDoqxfUkTA07Y/sGtem4kTnAIC/F8Du8Osbgp0iknUSTD6z
	6DaLqaWqRjhvQp5YKG4iJt4fldJu3EcclU0ic2OZLguR517loYCS3MfY6xGfDzfhmZT9scrBmae
	IhDgVVYs0U7Vx07BYsQ==
X-Google-Smtp-Source: AGHT+IH1o/yd45zaUsI2O3gDVbqqWAfhLEcKZtzUdUtDk58M1Kz36FWtvb8nlXBaGxXyqHyWojvmUOgrKh/T56M4
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:880e:b0:42c:b0ef:c70d with
 SMTP id 5b1f17b1804b1-42cb0efc875mr383485e9.1.1725985421494; Tue, 10 Sep 2024
 09:23:41 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:23:34 +0100
In-Reply-To: <20240910162335.2993310-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910162335.2993310-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910162335.2993310-2-vdonnefort@google.com>
Subject: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire meta-page padding
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Improve the ring-buffer meta-page test coverage by checking for the
entire padding region to be 0 instead of just looking at the first 4
bytes.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

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
-- 
2.46.0.598.g6f2099f65c-goog


