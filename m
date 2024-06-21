Return-Path: <linux-kernel+bounces-224940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E519128E8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD282896E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADAC6BFD5;
	Fri, 21 Jun 2024 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAWi4UWA"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6E46542
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982356; cv=none; b=rKC13rSKL92r/Zyfj230KzNdc1lnfkrIalP4CKeV2KKIXsbg5P2eyZuOnd/j+DJYHmXbFt5O0TJvffK89kbjTrVUmtU+OOKAqHhh4TWh2givG0Ea5WQ9djqH7ZO9UhAelnxybg8mF5JeXR5+Va5f1Bn9tW/fc1U76uaBnlMJ/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982356; c=relaxed/simple;
	bh=hKlmi4fFTPRGO10vsF7qWw2HrJ4Vezl1dk0jCpdusZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l++H9ERWyN7Dqg+i2R3ylMjg0jtZzNh9ylfJeI+5DhuNBsikyEQNsaGZCTpoX8bsx97eFg4Q9XPyamZF6FD7metLaRsQyZkuAes5cwQ1wsw80OEr2S9l8ChCa5haEYkBmJFv5LDDKLeiphEccw4uVv5udkT/Hzq7w6exyIpMs4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAWi4UWA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d07f07a27so2360387a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718982353; x=1719587153; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntDdia3lKWo//qtzdE08p3c3U1eFAFQAfNQTnQZ4y2Y=;
        b=OAWi4UWAgbtdeyuJk96Avkx9RQLsrHmkaUl4NRdzsJv+nHfhrkmV0DIchfJVMcEB53
         9ErmuxAUGJrCD12TQvZ7C3nYcPDnzBF48bOjY3GujuW2G90baGS8i6xB75hFDEHV/UzV
         zbDX1jhiVIZOsa0ZHWKy80lt0Fv9r+4hPVhnqFsEEwqycneydrzq0aUYt1X+RUA9ulRO
         eMu/TcS+kbr5MuOwBz40gF7ADebrDyLFNrdaPnEgbH3V6MgBABN1FmaDQQjGqeNwMZmS
         mFQhYJryh3LlNnlk+xlRWmMCkOpKj+hbqSHKBKsH6neG/7AEkFHbctj2ILgKAxOl19Tg
         qeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982353; x=1719587153;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntDdia3lKWo//qtzdE08p3c3U1eFAFQAfNQTnQZ4y2Y=;
        b=dppAoqG/e31Pr4whwhqLRs6/UTShdDBrd1fCII61q14ROtBYo8T9TYcDVTYthjH4EO
         5aSDGoYwhrT2/sf5V54Q1btG2k/gDsKmB8plWZDdp4gYhqn3ZO/mVbF59V2LG1kKgPyp
         mPejO/6tKQXjiaQz1L5Wt9EXofErO9qpTU6iXrwz1FxCiWZq74CRCTo8OF8UQVXS5c8O
         yS7VBXxPgRCKYv9NJS6Z0w/uwi2L4qqlm2y2ynlnlWpWU1zO7wlrSD1Ee+xZsIj1iYpf
         hnXzkBDzynTICFTpsHYb4Jj73nR7Sx8qSAPMyGGyh6/grOB+4UuTCH5kxjZ7szc9VA4v
         ecow==
X-Gm-Message-State: AOJu0YyzmKagVHu5lg8vg+QUreGKSWcW+KkYnkdhwcYs2oGkvWrOZ6Ly
	84AllIXCmXoNnNS5aqi9BynBxDOSYUn3wP6OF/1vU/VxqCSowmO9Jt2i
X-Google-Smtp-Source: AGHT+IE27dqeJLs/Cp3P08P5M9G6h2+jsAWPfzXSgBZZcEiObAm28R4chObwG7zllMkPTMrTrMoJ2Q==
X-Received: by 2002:a50:9982:0:b0:57a:2ccb:b3e5 with SMTP id 4fb4d7f45d1cf-57d07ec1e50mr5096867a12.42.1718982352875;
        Fri, 21 Jun 2024 08:05:52 -0700 (PDT)
Received: from p183 ([46.53.254.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3048b7f3sm1079934a12.52.2024.06.21.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:05:52 -0700 (PDT)
Date: Fri, 21 Jun 2024 18:05:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH] build-id: require program headers to be right after ELF
 header
Message-ID: <0e13fa2e-2d1c-4dac-968e-b1a0c7a05229@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

ELF spec doesn't require program header to be placed right after
ELF header, but build-id code very much assumes such placement:

	find_get_page(vma->vm_file->f_mapping, 0);

and later check against PAGE_SIZE.

Returns errors for now until someone rewrites build-id parser
to be more correct.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/buildid.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -73,6 +73,9 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 	Elf32_Phdr *phdr;
 	int i;
 
+	if (ehdr->e_phoff != sizeof(Elf32_Ehdr)) {
+		return -EINVAL;
+	}
 	/* only supports phdr that fits in one page */
 	if (ehdr->e_phnum >
 	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
@@ -98,6 +101,9 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 	Elf64_Phdr *phdr;
 	int i;
 
+	if (ehdr->e_phoff != sizeof(Elf64_Ehdr)) {
+		return -EINVAL;
+	}
 	/* only supports phdr that fits in one page */
 	if (ehdr->e_phnum >
 	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))

