Return-Path: <linux-kernel+bounces-366912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5197499FC31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB21C24443
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6BB1DACA6;
	Tue, 15 Oct 2024 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="At/WHyQB"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92C21E3DB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034223; cv=none; b=Z50LxxFdtmDwzDqNDv+kMshY36FI/RV8ocQknaJnDn7XUHnQn7pSjs8vDycHz4/uXps904kVWvNqj8IopGWVPdaMwpDLnE3spkPVVPSjzCtMcWDtlQ+svkv2kfLR5+qh4iAIgrnT6r8nCW+bCzNz57+f4jxwxfNIXu9MrGr3rJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034223; c=relaxed/simple;
	bh=QHhoXvpDEQPD/TLcchSrrWPbQthnrEyocMzfS0P9NlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qEWFd4M7VCj7bJIXo3qIPKALGR7jutgQJnWH/tiS7iXQNEi0X7a602ilxLtREsVHr837I3t23YY2D4RhzTy4R1DTeSxjqA4mkY0BP0nWQbZGunHSSR9hrB9fj9T8qcWD3AZlc4lt0Ue7nop95H4wfNWf1px7+DE3mEs1X5jB7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=At/WHyQB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d6713619so10568447b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034221; x=1729639021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RbEG7McUi9uEsl34Zx+GKrR9c4aF7zdcdcYg+Y9woE=;
        b=At/WHyQB2iNFrmHLOvaUVcnNycV2VXevkFrNgr0tmzO8PngCWPd9pRFcJPNc1Q1nvQ
         DgK84P0q9RB1IAk+PSLfeTCiuiZvE6iQuqsbj4t/C8bqEFzgvqYHJszicV7VH4okcTcy
         S29ReuJ6ffcAuCL/y7qmwYjJIV/Ys4oKpBYOm4zdd444THXc6V4dqoXEzLGZOvpe7a7o
         J8goC0c4AYBmOf0nZILXSTInL+bAzXvvQowkteJNxGC6He1AJIJqLIo1ZXJLeK2zKhI2
         EUw5+vuyM//OQ8Yu2KMFkSsydbyeu16INNfxOiyJTvIPkUQaa5cK1Bp5b5sAs63BTLqF
         lRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034221; x=1729639021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RbEG7McUi9uEsl34Zx+GKrR9c4aF7zdcdcYg+Y9woE=;
        b=ME5LV8Wj6I4jmaS/tLy+S4dV1kZ//fVZJ/+VwIQyyWndJkoht7coh2ZeKLM+5iyLGE
         mqJUTZ0Yg4QA/dSEwidl+XN+OFBQ3YmWleyNuloYCCUPSIJoxgt0ewV3oyIoQx/6fr7O
         BT7d2vDWoSB2mxrDm396KCC1u/nrCYeTkQ5b5Wn6MJmiDqgsGKWE5XsWIqgaovwIU3PO
         PejA+Ih15A2JoLJsDn7VXWP4zhIaunZqEU5Xz+GBRs+EflZ1nsT8hBgg0IFfxMHR9S89
         Df/Zux8RKw//1d5tavF0wIWC/fB8b3z7+AJszgSH2ui2CZ1AxrU+aWOq1/koXVW8Y8Y5
         NznA==
X-Gm-Message-State: AOJu0YxALJGLSASTOFQxXOD+FzWGKcobrKdTVpjlb/kzO74vt8Lo+r8p
	CiCjG0SqPumljk7GE7NxTmrrhlqRFjOTQBEqmWLleW0K6nu0jroaTUjPotmp1XWNWaoYJ6ZaNjr
	LdmISFw==
X-Google-Smtp-Source: AGHT+IFPXzBe3tq4UEclYkB5CjDIeF4FAjlDz1DojdfYJQwU20ut08n6Uq7PA2tBHvy9wJlNUFsUH1mxlBeM
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:ad60:0:b0:e16:6771:a299 with SMTP id
 3f1490d57ef6-e29786b577amr950276.11.1729034220838; Tue, 15 Oct 2024 16:17:00
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:35 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-2-mmaurer@google.com>
Subject: [PATCH 01/12] module: Take const arg in validate_section_offset
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

`validate_section_offset` doesn't modify the info passed in. Make this
clear by adjusting the type signature.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index ef54733bd7d2..1ed1d1bf1416 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1678,7 +1678,7 @@ bool __weak module_exit_section(const char *name)
 	return strstarts(name, ".exit");
 }
 
-static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
+static int validate_section_offset(const struct load_info *info, Elf_Shdr *shdr)
 {
 #if defined(CONFIG_64BIT)
 	unsigned long long secend;
-- 
2.47.0.rc1.288.g06298d1525-goog


