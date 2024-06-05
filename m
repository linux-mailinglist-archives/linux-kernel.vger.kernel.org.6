Return-Path: <linux-kernel+bounces-202207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 099688FC930
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFA9281950
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30AA1922EC;
	Wed,  5 Jun 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKLvI9rM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A0191496
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583786; cv=none; b=OKxOHU8qQee9mCMWyaOlBTKGp4s4YTF+g0AnmWSzMRWjrMdZet5J68wl6/tkspHhip/Mub03ysUKgw8C2p+/Cz6r371iavqFR45mjvuIqEM9u5Kva/4zwE/afb7jMCgQRByGh+e8/27wNWX6Ilzi1jma6RLeCwkb/gdJUqmzoks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583786; c=relaxed/simple;
	bh=M/7mE8s2/w1kNQr5K+bEsNkgkzo1HaC4j+bCLXz3T1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jhGOCnoFVlvN59Rfznhjod3W6W7BMToKR+fRG6JNnyBnBSlOOJohK6W3vXunL2ZrM+WSjGi6j4FECF+zDUn0ilrZPDbodtCj+M18ec6pvQyRv2gtna6HvbUqJKhXeU523XNIacgcSl7xrOleEt5yhxcaExhIw9k0G8xZA8sk08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FKLvI9rM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-629638f1cb0so86001897b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717583784; x=1718188584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SaQVPc8Js1wP4O8HHMzP5AA9E820c7Zwn1k4LiFnsGA=;
        b=FKLvI9rMGdqvNpsoUBOAPGf1OIXPLcIMYv8TX0cmBUdzaHExMglfdFd7ITNzbXMcq+
         ySDAbUGi+tRV4cheJYRTFtErA8CQiLS2zRTpaIFMHG7jQ0jWxpbS1Tn3ePOHGWVpiIXb
         RTpH8ZlV1K+FH9+xCPEomnXg9qbXzmqBUXeYwtmll/oGBz0dy8BsfONY8hujbrfydGQD
         C6HNQJC1U6K7Rx+rL587oUw7ucPoZvFKOnbaQneFY1aQ/0VW03N91/o3tys9mTbyfq9E
         +14lM9dytLeCi8LDjhYP5fJCSEVoUGTvg5bVSBXo7NkkjKyRsCLNk46mnqqGSCf8rMOk
         6Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583784; x=1718188584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaQVPc8Js1wP4O8HHMzP5AA9E820c7Zwn1k4LiFnsGA=;
        b=vv8F50fbKOGpbKqlOJrG6tr4SsS29S1SSS/c+OFmBlaCNkWZidHJgciq5JalyYpZfl
         DBJ1OWkIH93ce2Mu0cGx7LPDyAiqAcnm0rchS8J8ph6XIyJxmtAd/i+C5VV5z4jc7Bf3
         pMC6Zf2uP2loN+5rzY71uVdINZ9p8HfWVhd9VtZAETZWOJi3AjZs4Y5Li28y4kkKuRq9
         nB7m3xae668qOnwhiUXJ0Mqy6GHVz+RG1N8Xrt5eylNQzhsezTqLnA5xXOb45v904UnI
         qhcucANR6xJoBSkgzbLpthW1S8q2S4gpdiCcbN0SFfm/AC/bqsSBkG/VXgEzNPbAoOQE
         1CcA==
X-Gm-Message-State: AOJu0YxEEm57nt/hJGHmgNPmhHVH53eP7XIorjse4R4YtiQvT12rGYP8
	Blkxtidzh/zqCKbTbznDbN64zIEH6VLJee1ciqcEA4eRkQgj8o8Ss/BoT8MCh4ayAy2EPcGjDXm
	nzOuh7TLXXrEKfQmcam6Gfmaqe3MJ1IvJxFRPR82mZkpVtF6UK0I0p37jwn+y/9rn8Nk8G0Y1Z4
	7KKs6Qhbrndx0OQWX8q6M7/lXjaVLu5A==
X-Google-Smtp-Source: AGHT+IFCDZEru6zJbm6lPum96DeT37MLOOa338SS/zNVG8yCH2Yj9cSgJAN5dAYZDkxpGjGLMuuHLOrQ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:4c06:b0:61b:e689:7347 with SMTP id
 00721157ae682-62cbb4a6b86mr4009457b3.2.1717583784569; Wed, 05 Jun 2024
 03:36:24 -0700 (PDT)
Date: Wed,  5 Jun 2024 12:16:13 +0200
In-Reply-To: <20240605101610.2824747-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605101610.2824747-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=ardb@kernel.org;
 h=from:subject; bh=1WOxhSKXdPYsCJ6Ne8n2/N04btpqDMdNzicWbyeAr/c=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS3B6u2e5kUrJjT+LT7Ls8XoLnNBTN4tvS1arx5tC30Rr
 s2vl8rZUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYisIiR4ZfRxvCuR7eKVyt0
 biyY5ypRYZynVSIzQ8Hfb7bhh7J+cUaGS792zpyi/e7V73VzA235VW80ie0rYvkWuPJA4NbgPcL GXAA=
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240605101610.2824747-8-ardb+git@google.com>
Subject: [PATCH v3 2/4] x86/xen/pvh: Move startup code into .ref.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The Xen PVH startup code does not need to live in .head.text, given that
its entry point is not at a fixed offset, and is communicated to the
host/VMM via an ELF note.

So move it out of .head.text into another code section. To avoid
spurious warnings about references to .init code, move it into .ref.text
rather than .text. (Note that the ELF note itself is not .init and so
moving this code into .init.text would result in warnings as well)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index f7235ef87bc3..0cf6008e834b 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -20,7 +20,7 @@
 #include <asm/nospec-branch.h>
 #include <xen/interface/elfnote.h>
 
-	__HEAD
+	__REF
 
 /*
  * Entry point for PVH guests.
-- 
2.45.1.288.g0e0cd299f1-goog


