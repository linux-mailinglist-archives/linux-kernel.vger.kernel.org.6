Return-Path: <linux-kernel+bounces-206259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58A390066D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF6D1F23DF2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1C194AD3;
	Fri,  7 Jun 2024 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pCp0lDIX"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E61D530
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770353; cv=none; b=aqqHqma3PM4GnE5TI75Y50oqvfH0zTYmjYYf8KJa9RwF0W0dvXacF2YhOEBLMPzJTbQnqPSYRqM0WEQM2uVVm2Chdj1z4N+g+h7GIEpzEmxTQbTdrgP2+I1JXq/zhBQkpCcDZGSA3Ie1LOjoGK7DwvnO34RlxNKZQnEgZ7f5nGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770353; c=relaxed/simple;
	bh=83TUDNVh1Dg+aZWrFbDtvgF+Peo58zA93W8Fh65S0iM=;
	h=Date:Subject:CC:From:To:Message-ID; b=JddypDmJOR0xUxQQw+eu0/9YHqaH5+g+0Smdh0xWkZtGK9rfDoKenRGMiLVYrdgtji8+tzNeMs5REDdTUYd+LpsqbLs4E/gYc6G3sEw3CPPO/665V3iI40hCDK/EVFNdpPsWOZUH6EU7uEvN3irFFGxU27TnONW4uCPs3pdLP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pCp0lDIX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6ce533b643dso1606675a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717770350; x=1718375150; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9qPH+lBWrZZasyMLxKJRPjQn+PImGEOakuO1diEZs0=;
        b=pCp0lDIXfDgUNdhHIDY76NO8bj8dE1zel4zr6U8/fIb3hUgRkknJd0NEoqew6guZGE
         sXG3gQTyzcYODNPDNX1bZ+SNXOLO+uZIZzC7Pq13P4D7/qTuTULUvFvTYK+87EYPXamN
         /j+Z2nXsypZKlZv72ZWdIVFEs+IkaqmQcxMysnTIDJLJ6U1NmMkPzMSnH8u6Fpv0EJMq
         0AZN/Lrqqsx29iNQwcB3+RbyMUh0zFd40e9mCu1W8YOCIkjxTiZ9udR8ww1NHveGsgMV
         VqhmO+sqoAOEGeSCy6kakmJXt2XMxvu4CSLT3y7IyxYbHJI9/A49ekAynFMzrgmTP3J+
         Rjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770350; x=1718375150;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9qPH+lBWrZZasyMLxKJRPjQn+PImGEOakuO1diEZs0=;
        b=JMn2rDYhLJ8hCKhvhbeMPZo32LDk0BcCU5a1or+lwwxQ/e3LmrjfEXf85IsvRaM1W2
         bgIMWweJfyzRxqifJqwyAVF+wq0ZdzWAEuoiYkHmkXcGE2hyFzQi8K6w8U5lnKIfhIco
         TO+Y4dzVuk5c9ttP7JEnqkgey2t3pWVcQcHKjnW8+KjMMYJ/keGMG2ZiGdGhMzoTYV3l
         4s7KqQB+U+5qpHpx74ai6iS81HXkOov8JFWw4M+PW4UwzV+WV7A/bB+cN7RoEot//YUG
         OZELOtv+aqmOGQubcAxm/eU3pER6jSk5wlJJolMdOXp3v3sZURDxvTf68XnCu9dl0n7+
         lMcA==
X-Forwarded-Encrypted: i=1; AJvYcCUCY56wGvfProcDbeH3o4jH3hHJgkeUjMA+/jGfSJ5jUNgU05dMAmqAojbSLO1Ttw5ZpEATaULAg5kRvZGR3u3hBeKqcoPn1hTPap2J
X-Gm-Message-State: AOJu0YwvGq1WqqlTi60w+g+crOijZmAq/9DEwgIp9uew3xw5kcqitRbA
	PA6+BXu5r6vrpW/zZP5f4wfSL51sGuftr4/92zAZKXntRzFaSqqeRekWa7a4R2NKZ9KazmhcrnY
	j
X-Google-Smtp-Source: AGHT+IHzRGhcmymdS4KHpM2RFwnsqcc+N5qSnpgO/uk9v0QN8m4yaH5C1JM/JGB/bkARn7BZRPB9/g==
X-Received: by 2002:a17:90a:8b94:b0:2bf:de54:f5b with SMTP id 98e67ed59e1d1-2c2bcad6429mr2681385a91.18.1717770349798;
        Fri, 07 Jun 2024 07:25:49 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28067b118sm5548542a91.26.2024.06.07.07.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:25:49 -0700 (PDT)
Date: Fri, 07 Jun 2024 07:25:49 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2024 07:25:38 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.10-rc3
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-1afb5c2b-25de-4eb4-a911-523495ad3939@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc3

for you to fetch changes up to e2c79b4c5c4d83520abb570ca633ded09621c0a6:

  Revert "riscv: mm: accelerate pagefault when badaccess" (2024-06-03 07:41:13 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.10-rc3

* Another fix to avoid allocating pages that overlap with ERR_PTR, which
  manifests on rv32.
* A revert for the badaccess patch I incorrectly picked up an early
  version of.

----------------------------------------------------------------
Nam Cao (1):
      riscv: fix overlap of allocated page and PTR_ERR

Palmer Dabbelt (1):
      Revert "riscv: mm: accelerate pagefault when badaccess"

 arch/riscv/mm/fault.c |  4 ++--
 arch/riscv/mm/init.c  | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 12 deletions(-)

