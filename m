Return-Path: <linux-kernel+bounces-323426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D0B973D29
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544601C24512
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363C519B595;
	Tue, 10 Sep 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xF04tJ0U"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F11A945
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985426; cv=none; b=GNZzGg8LqEqYIpTJJxZhJnCCwW9xWx9j3etFbyFoADU/86YRwCFJJAio7EYw4yJtSLSYwqSQxG6VUhzVzOzKwx87u2jcItYvJqloTgTBsVFQZnTX9IB5Ec88buS1Az86NbYn1E68b2/UhLURicbLi+X+rBLCG1AFlJzkebbjTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985426; c=relaxed/simple;
	bh=IDxzP8NIFFLJrT3njglStxjT1iS4xr2kKaPxUTaw2eI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GxY6YdK7JmlrXWRGPbDwzAzCRtQA5BXvVaAA5vVWLN6lrzdUEDPV3uKyIaPJOsklGEGDEFUS95yaMbQXTpLa00VX7CHfZst8pAN7O1nk1DAq9d56Uti28X264I4MrvCYCp02Q4fk48ZFINAia+7ajweSVdWxZVakJXOSGteWnuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xF04tJ0U; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d7124938d1so191992407b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725985424; x=1726590224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3gEWXD/IZ+HnaT6C3cDeHppcfA/fBRmYbhkS6oYyo8=;
        b=xF04tJ0U4KKfInAsQ2RTTKV19JHTtz/h/Ad93cLe89MZ3K6qUDQWFN2V4xAKPgblGp
         V5mv+JXD0dvp5CINnv+l9SZwq18cbj3CUY+rO6ob+x2M592R4hnj4TLFf4KUltqkuSmk
         1tlXmhF6JRgHV7VjrLqpHQ2SvA2EjGDSwFY2VQmT2jRVc8HbJcQs2vWa2+oLkivX7+Et
         zKRzSVW7q6QqNpXLooUOW+9NPpWwYAspk5NXN50gzF9FE7+UoNVEKq7wYn4ZW0ol1Ryr
         JnhM3Ya9MxSqsIHnGqPcr7qN3HlTjZsmX+5gk2+UAiozgjClNCqJyaPfviMyXO/VLhdZ
         Vypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985424; x=1726590224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3gEWXD/IZ+HnaT6C3cDeHppcfA/fBRmYbhkS6oYyo8=;
        b=LQTCPmPIKpW6hLUMIrKtykn7ss5CN8f0bgsuqbKJXoYPGzS8vsY/u6wW52rmYEh+Wq
         aUAtsfzBC/3tlKPbS/BLS6LaOMMP1Qihe3yrLi/p2s1vmO/cM9KAeOrAED4AUunDNf53
         9512X5/m80GCMA+zzynhHKbTbQVex09ipSgL7VuPo0T0490MMzl+qc30Zt7AJhKffuJc
         pn+JeBCwD9Q/LtH/hel9NNtWRdEEF+Qx8bWISHPY0Nic2s3LDqHpP0MsxW5ahyot+xr4
         d/ao60T29vkHiuT1xsQBy4a71vXLjd0zFZFAcI2Dz5hDRY9GwjORpQ5fG7AlPXckf5R8
         Zzxg==
X-Forwarded-Encrypted: i=1; AJvYcCUwW8g/+iTZKuWMnQCo4tpu9EXUh2aFsBpCHhgdERukY6RnLTcbjZ7N5jqwtaEajlHVFcX3Gt8YzUA3ZmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+NCmpu584XWiN+0SyWSSnUob3lkcWUeygSLEXcR33PimRDJow
	AAdBKD0W/oskDC9KY2JOzw8gM3XEGIcMwhzjWN3LJKCzgU9LHQ+2sWJuX9BaSCKfH88NHCctdX9
	cTU/O9oWQ2pn/mflnrw==
X-Google-Smtp-Source: AGHT+IFIKA+XvPoOxw+v8DGyTZTQiSOBgMRqezK95cE9yrJOsqwf2B357BaQ0JA4EDgrcvgiuQT7VwrhPTbXI7AW
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:448a:b0:6db:34db:bc80 with
 SMTP id 00721157ae682-6db45163fc5mr3107447b3.5.1725985424256; Tue, 10 Sep
 2024 09:23:44 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:23:35 +0100
In-Reply-To: <20240910162335.2993310-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910162335.2993310-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910162335.2993310-3-vdonnefort@google.com>
Subject: [PATCH RESEND 2/2] ring-buffer/selftest: Handle meta-page bigger than
 the system
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Handle the case where the meta-page content is bigger than the system
page-size. This prepares the ground for extending features covered by
the meta-page.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index ba12fd31de87..d10a847130fb 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -92,12 +92,22 @@ int tracefs_cpu_map(struct tracefs_cpu_map_desc *desc, int cpu)
 	if (desc->cpu_fd < 0)
 		return -ENODEV;
 
+again:
 	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
 	if (map == MAP_FAILED)
 		return -errno;
 
 	desc->meta = (struct trace_buffer_meta *)map;
 
+	/* the meta-page is bigger than the original mapping */
+	if (page_size < desc->meta->meta_struct_len) {
+		int meta_page_size = desc->meta->meta_page_size;
+
+		munmap(desc->meta, page_size);
+		page_size = meta_page_size;
+		goto again;
+	}
+
 	return 0;
 }
 
-- 
2.46.0.598.g6f2099f65c-goog


