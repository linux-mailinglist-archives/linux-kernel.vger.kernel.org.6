Return-Path: <linux-kernel+bounces-225190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC2D912D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9361C237E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A226417A934;
	Fri, 21 Jun 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0b2f9cf"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC38820
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995180; cv=none; b=YS3YW7caKrk2F4YrYX6Vg38fyYyLlflZQnh1+7SGzHXJaxIFBEQf/DYDtdXQORv+aIwR+a7vlDeTNB8yCsrrq693jETU1mKoCutYpV6azoLqBEfj62POGWxgV28GPVffuTuhsYF/hhxscYyhdPrZJHB+jsDBsFbxMTPRBVOt/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995180; c=relaxed/simple;
	bh=vk/96ebJdlrFYsAS4ze4k3Afxi/LqFG7BOkjBpAeEIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQ78tm2gmuAj+6Xa1p8jA2qYjwXIkshq1AdGPHAhuaOo5DgkROJdPi/b26zZba7jV3QIX/cjzRpfu/XqD5wlmmIfgH40+8eSjixM3nOOqaqZRL6NX64Plyxupz0065hg0bVsBii6uNwgeEZbEV3fLw8lk7gURUxtp6VECLru/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0b2f9cf; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso24833551fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718995176; x=1719599976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofwRrZgwZaii+MzrCdAU3E+RPpHqrKQd5gwF5AP5IBM=;
        b=e0b2f9cfIvPWCGf5ezi6ldOVZOwcvZtrvCRdV1SCYZ6ROWfYR4gZETsuZTKxZiqY/G
         lmL1cI6Xc0XJv0xKU0PP32sA8ijWY3FoO7YGYYLA3gMqsmNC+kZVIlEyOaPD8v4Gszwy
         PcV/xO76bU8Efmp/OyGJqLAtFlmytwZfq4bykP/Or6BDXpzVyZIfuJ6ekXz0obiZnZkM
         6D+E+VFQGipcgi/fzIMGJYyBA2lJKlwqQovstwTZ56Qa6srExRJUDlScOckpx7B8zagb
         JbzI39OaHuyXzo5H/8c0iXEhgk0PzyWJ59UI1fbah3rlA30mMdxAY/iM/kImmDt7rINn
         k7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718995176; x=1719599976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofwRrZgwZaii+MzrCdAU3E+RPpHqrKQd5gwF5AP5IBM=;
        b=aT/NhPz0IKgJxzmBuDsgUXESPZ3djIttbtxZmPvwgueZR/DHse5RyVdxzLgJyIgvUL
         IOOM7Y5dICTvokMM/UdSV2zEPmc7wu0im0yT6EAGYCgaxaeP549GxbMAO8+uVOhKCCBp
         8+z1EJPKUipmnTaNy+C0vcb5rqrEeIg+J+Al43ZZ9YAurfWWyejApLLOx3TLYhh1PvEn
         gZ3hh8ZTry/6zTpuxlz62vYodFG1NmERNhOhvV6wI/iR216LfgVceQzA48or2Y9Jmz+w
         qZeFzeZQxfMF7n8Kv+xE4iNhqUNNzYo1dipNlk641hWmaY5VvgLTqz/2yyU1+d4W1yWQ
         faZw==
X-Gm-Message-State: AOJu0YwREn0OlIUMQvVX8tVaOzM1O2p9OR5UPHmeGGnJuWVc293efy5c
	Z/EDxq3MRTgYZOkjjG7vNc/YU0RYQydkIW8uiTOCaaV9UdAJIpNjI9DR
X-Google-Smtp-Source: AGHT+IFst6jGed7IuNe8/zIF6HN4oXgeWh43JaLVtvkJ9zBZZLcLs96R8jDsu9y/SudXgTpx23Qq8g==
X-Received: by 2002:a2e:978e:0:b0:2ec:5430:7f6b with SMTP id 38308e7fff4ca-2ec5430dbc1mr2325451fa.49.1718995176102;
        Fri, 21 Jun 2024 11:39:36 -0700 (PDT)
Received: from p183 ([46.53.254.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d305353f1sm1256384a12.76.2024.06.21.11.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:39:35 -0700 (PDT)
Date: Fri, 21 Jun 2024 21:39:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2] build-id: require program headers to be right after ELF
 header
Message-ID: <d58bc281-6ca7-467a-9a64-40fa214bd63e@p183>
References: <0e13fa2e-2d1c-4dac-968e-b1a0c7a05229@p183>
 <20240621100752.ea87e0868591dd3f49bbd271@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621100752.ea87e0868591dd3f49bbd271@linux-foundation.org>

Neither ELF spec not ELF loader require program header to be placed
right after ELF header, but build-id code very much assumes such placement:

See

	find_get_page(vma->vm_file->f_mapping, 0);

line and checks against PAGE_SIZE. 

Returns errors for now until someone rewrites build-id parser
to be more inline with load_elf_binary().

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/buildid.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -73,6 +73,13 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 	Elf32_Phdr *phdr;
 	int i;
 
+	/*
+	 * FIXME
+	 * Neither ELF spec nor ELF loader require that program headers
+	 * start immediately after ELF header.
+	 */
+	if (ehdr->e_phoff != sizeof(Elf32_Ehdr))
+		return -EINVAL;
 	/* only supports phdr that fits in one page */
 	if (ehdr->e_phnum >
 	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
@@ -98,6 +105,13 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 	Elf64_Phdr *phdr;
 	int i;
 
+	/*
+	 * FIXME
+	 * Neither ELF spec nor ELF loader require that program headers
+	 * start immediately after ELF header.
+	 */
+	if (ehdr->e_phoff != sizeof(Elf64_Ehdr))
+		return -EINVAL;
 	/* only supports phdr that fits in one page */
 	if (ehdr->e_phnum >
 	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))

