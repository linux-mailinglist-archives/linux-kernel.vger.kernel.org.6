Return-Path: <linux-kernel+bounces-178250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8398C4B13
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0740F28449B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A484A94C;
	Tue, 14 May 2024 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPY+CuV+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F574A24
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715652193; cv=none; b=Dz+Bj9eJoIzCP8IZvGkQaYJ3UH11jiuvacYjOc+k4NT7SQdaEO8/sae4e8+dDMuTcwNkWmDarqFU/ODPRDiBJ2ZF1EN7umkUA7NB8zoWhHuzr+oQ++XKgO0R4HL4RabbZzMnWJmq6mq5kErky6dVdil8IuPNCgEAZTG5C6PWVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715652193; c=relaxed/simple;
	bh=6KOrme8o9PGJN5Tbk8Ru6CkgrB3HbHtOupbevpkmW6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Esivswo8K94dZ2niG+RuQOm8/mjteCkgFNhUIgBRu29DxZBSVG12G/sHydF6r35agmzokVt8TyfK5phTaD5jbnek8j21WU3GxIKNA6yMRkzMCPcKiRahIypwcWWgfmbHqFnHqhTO/HuMRRD4GNv9lrhNBWvp7hB4PTzpTvJRiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPY+CuV+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61c9675ae5aso85174937b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715652191; x=1716256991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6LZX8B3NAwKdOpyzwg2nERNshi+/Z+TgchSBTbrUTg=;
        b=CPY+CuV+9G92uQGe4MCrujxa5zGi6z27HhdViitmGmTk6bN5HgGn5HdIBkwgoC9Ar+
         ugOQ143U72qZxELlHbRAaTab6vTLdP29ysUlhu6QeXhE0MCsoWvu3jni5kjgZVRX2Ku9
         CaNGfUoBBm7DBNdNtjz2P+s/Gkf9xHMGrKWosjDK6n1sszeJneHgq4SjLr9RmKesj2Vz
         C1dOYrSIP50xForHr/UQDqfHh46VkcT8dyGxTwYZ79UwSkqy9spdehN3zrDFZLyG2uAf
         pvq06VbvnU/IPOXt8x4vomcjSAVE6NzZ5ys6Vjxyy4CD4QdQVMafqAamiLR0imSMr3Yu
         Owmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715652191; x=1716256991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6LZX8B3NAwKdOpyzwg2nERNshi+/Z+TgchSBTbrUTg=;
        b=Rv/HKJyDMi7UqQR0QYLX9a1c2kRmQIBoID7UofPH4tBMftzMv+ba4Jz8VDmGF+Xh6q
         YbfPLLofgidEBg0zXYDUYvbciRbCftICOekgq5XfIHR7KrC96/O/C9PG00G6LukzoGIC
         2wTtd4UJxuLcTLRiaexMwoTS3NskPbsrt78CU2DOp2vmTaoCu5w27L92+/vadfy3vunH
         1/etdDrXtLVer6y04/Yxi5Umm0cn8Ia+/gt9yVim50LvSHfjYC+Ch11La0YvECnUVmqC
         hTgj1JRrkaoYHKRqdWjn/K5L0pjaKHHKarG3Ep2xNAJrDvKdsJ0dam7z+mNb0HsEmnEH
         WnLw==
X-Forwarded-Encrypted: i=1; AJvYcCUvRoe7JgIXsd5Ma+Ixvq8/KzWZj+4bv1wxnAkhzXwFYqPnAqTF1xXv64VVPKVAtcKI1Rac2QIgnkKxiVa/5PPl4KcltD4bxqO9q/Wo
X-Gm-Message-State: AOJu0YylY4EXy9YjKkWNARNkLoyAIj4P3ONbqarrIBfOGgVOe8qO71FV
	IXjUYPiVBmW3KdJaYP4TipeT9pTW1kmdebEyqKNL0G1f0eTNnqpjMQJHaRetDoxdlJivdFCZ34z
	bwXuyqA==
X-Google-Smtp-Source: AGHT+IFnKyUwV1sRfhj14Ul5g8vZ0XrMokIFRTN8GZG8T8GmdeJC1X9cXXIfOTYT+lTmG0FuwmA11eBeJunc
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:c98c:5a45:8674:49c2])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:c09:b0:de5:5304:3206 with SMTP id
 3f1490d57ef6-dee4f52d715mr1019538276.11.1715652191073; Mon, 13 May 2024
 19:03:11 -0700 (PDT)
Date: Mon, 13 May 2024 19:03:01 -0700
In-Reply-To: <20240514020301.1835794-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240514020301.1835794-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240514020301.1835794-2-yuanchu@google.com>
Subject: [RFC PATCH v1 2/2] virt: memctl: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dan Williams <dan.j.williams@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The memctl driver lives under drivers/virt/memctl. We specify
maintainers for the driver.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61117c3afa80..5793df2b2f5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14057,6 +14057,13 @@ F:	mm/memblock.c
 F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
+MEMCTL GUEST DRIVER
+M:	Yuanchu Xie <yuanchu@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/virt/memctl/
+
 MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


