Return-Path: <linux-kernel+bounces-382876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1E79B1455
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 05:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602511C21166
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 03:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1AE13A268;
	Sat, 26 Oct 2024 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK+wq1F2"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD3335BA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729914424; cv=none; b=qdvyeKvoN7yaDWN6C3l/i4UC4INytXjTIPquS3pKmZFtEmw2JjLIaZiKkNkCKbriUlXhXHsvjWin1CZlWtMtYGyrh0FA2L1UEs1EFwOjuMUhhx4OZBekI8+GwoOo2bN4T56rkkWljS15VKEvMF6K1f8NP8jdazWjTdeiFK/HnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729914424; c=relaxed/simple;
	bh=hfGei/JPKrPwA4ZjxsgmiCF2HWq1KxADsMnofdZvtTI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IxkdH6cU4SVoXq+WcrbjE4+T5MSHhWoPZghFVCXyG/VfOu+Gk+9zbecv9WXRjgeUaL6JjCIma74vV/PXX+p5RqLKGbsZqjCFnh8LyO7stJC0qUSGgAtx7PozyPNRyBpG2/2Qvy2Yr6eqh/pLEkOa2y0nF3jqiqApI6kDY0KNMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK+wq1F2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20e6981ca77so28725145ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729914422; x=1730519222; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2sEsK68CwMXxf8toSl3kI0xQbvN8/oETGeq4Wqiy/0=;
        b=YK+wq1F2Zm+LqE2eHF5UM0McRExFi1p/DPY1K4wiryhwD1kkfKCdp/TQQAV708b/mU
         U1Sk3wMeS76JWq4dC8KFJfAfiOTQn8BIRTBa4IK7KQDM6Xf/oPc/gucgDr6QfuCQwM07
         wYdnqylZa1WnmdsCWDFHo43qwVZSwlz2yFiPTOwklQCxa3oND33F0BxWWOtVtXom0EOV
         PveMC/2/ftFody/cGwH7iZLpUEbpSxb/bcB8E0UNKk5vdTDqK8R3Q0VG76VwbwkJFK5h
         2ktwxZ6ByUKtQPRT+0B0nGd4xkOl37JTXXf6Ai3NTA/5I1nlXqHOAg5DUpPki+HDTj7n
         t42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729914422; x=1730519222;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2sEsK68CwMXxf8toSl3kI0xQbvN8/oETGeq4Wqiy/0=;
        b=mj/bQBE+CpZgougTG+hXlxF23Iopd74J9Odrj0NnV12so3rSzCpKI/WlSavImzbvLw
         S3tHKN9Gs2ZC6ZGHYVcJx1uMIqD6fXJ5faojcQisvNfPKVbvWUCgCdzbhc+u/bflJDKf
         6OoGCcF4pVplCQVbuObHWWsss4/rGIbifyhQJi7Y9nbWe3kyLKyFPYMUVtCaQzRefXqR
         RgSjL/+vNhZwVW9eteCOdojhxHtKOmMf+3D5hFFlMWghlrEHphmORJ9gcvlZFD/MjDAU
         LRTqp1nNh7maWhL/dB2KnyLuxaFGFeOSpkABT+bp557uL0zH/nRpjTcO+OgeITCdCMxK
         1ZlA==
X-Forwarded-Encrypted: i=1; AJvYcCXW9koxsgdHqbnJ2S6rDzNBvyIztbZPGHO15gblAbOcEFErrZ+RpUGSKbpIzjZIknaHFWJHwWhctqcadto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbvAvf+tQAJ3kBlpdrX9fPxvBvDysT8ztsepy2CUMMA3IG6MiX
	iY0BidKlBS5PvyN3Il8ZnwICaIg6v/ouvRUbZ0+tqggTGBAdJ5oU
X-Google-Smtp-Source: AGHT+IE6vFRIGposdfIGkKNHgDwb4FYyCPbH3HhoBg041NpIXzhhDVZxW88o+VKXZVUXEUFPDPjUlA==
X-Received: by 2002:a17:902:d54c:b0:205:3e6d:9949 with SMTP id d9443c01a7336-210c6ca8b6cmr16558935ad.52.1729914421977;
        Fri, 25 Oct 2024 20:47:01 -0700 (PDT)
Received: from mail.google.com (125-239-144-11-fibre.sparkbb.co.nz. [125.239.144.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf46ceesm16939235ad.44.2024.10.25.20.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 20:47:01 -0700 (PDT)
Date: Sat, 26 Oct 2024 16:46:54 +1300
From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To: richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, kees@kernel.org, tiwei.btw@antgroup.com,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH][next] um: Malloc just enough space for fitting pid file
Message-ID: <ZxxmLngMg3iNjOfK@mail.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

umid is already generated during make_umid_init __initcall so there is
no need to allocate UMID_LEN bytes to accommodate the max possible name
for the umid segment of the filepath

This patch replaces UMID_LEN occurences in which it's redundant

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 arch/um/os-Linux/umid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index eb523ab1e218..513a2cce38db 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -212,7 +212,7 @@ static void __init create_pid_file(void)
 	char pid[sizeof("nnnnnnnnn")], *file;
 	int fd, n;
 
-	n = strlen(uml_dir) + UMID_LEN + sizeof("/pid");
+	n = strlen(uml_dir) + strlen(umid) + sizeof("/pid");
 	file = malloc(n);
 	if (!file)
 		return;
@@ -394,7 +394,7 @@ static void remove_umid_dir(void)
 {
 	char *dir, err;
 
-	dir = malloc(strlen(uml_dir) + UMID_LEN + 1);
+	dir = malloc(strlen(uml_dir) + strlen(umid) + 1);
 	if (!dir)
 		return;
 
-- 
2.47.0


