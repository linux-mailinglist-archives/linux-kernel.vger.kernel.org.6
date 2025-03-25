Return-Path: <linux-kernel+bounces-574661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7173EA6E836
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885943AEAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B779B15C140;
	Tue, 25 Mar 2025 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YoGhWnjR"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDA228E7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742868098; cv=none; b=WhsJslaIAHp1F6WLjAd98KmOemsGm9O7EfSxYtpxgRUUOBJf8l/ADuX3t2ABekBdW1WRdC0Q4epMylteVhQd6zvjFZxbpVnH8dFvlZ53joF7wkdACsaOleYVU21++KlkWSwnlWxjepQzfc195r8N3QqK2TvzfnAdbG04bIH+rgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742868098; c=relaxed/simple;
	bh=mtd23FxlAYpI89ijMINKo5d3f3VQjTs7UnE9Fannsrg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CyXtLCcNiw1s3EFGAiktGCDeSSuRTOch6XNIBllBlUL9D4KMKT9bjB4UkIRzgfMNXYNbc2vDBDLj6oSjaK6CAgGozMPDaKQ7wChgHegSN2Rst8K7kYmZmMKAnIjih93EUi4/JvCFIP7bkOugIalcETkdHpnhA5NUe4Qwcxt4hV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YoGhWnjR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe808908so28385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742868093; x=1743472893; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaQf3OajontDu2R+ilmXCbn5+wNCfx+Mo/A/m3Z+DZI=;
        b=YoGhWnjReTZDQBNyDq17Dav7OXKCcgKJal/hBmQStaqszsWO+Lj5tUV/WrMJqdUXD+
         d920FzOqZe14r/GzSpp2i1x0p0VddlShjYQvCbyQgVTdqAbBirfnk8i9qHwIBF2T2JlS
         y3u3VJ6fj8Rzadl0B0ti+XLzGfrrtA/evWHUMdQwoEFkwNDL6jhzcD3dvtcbnCJrvr7w
         PXHRiNCv3QHQ1K871kQMg8nNslcME+R98YA6k2CMtnlvBeGqlce4WHiXBMuW/eL8cDZL
         mVToLlRn53gBt7TeIR35RXDsn1b+VMPeWeG8wryANK78utRR2VjWJ7ezxnBZ9vm0LJ13
         AVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742868093; x=1743472893;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaQf3OajontDu2R+ilmXCbn5+wNCfx+Mo/A/m3Z+DZI=;
        b=MO1pGcpJCLYLc8sFpJfAV3I9XkltmHBrRbAJi1E0xcP7uvpVahFdcCV0TJSHbC/Sqt
         YrvcU9S96UROh+RqJzsLKp9sKRQ5px+gsXi45uLO1hcUxZu/fr4J1saIzfSSa2DFdPrl
         r9dhpLSX9F4XYMDIZatMl0141Ris0/TTBryo6Z1rQzNiGgnocErSmAXQv9Ep3su+vIH8
         CvRibUPYq3ovTZRy3VWNX+hiiIqG7a/na/rVcyY2/Q76CpkaZ9rKlq8PDG/umEnYFLUj
         th8E3A+y3Y8tbt89qgw/TQfOoY4FgqLyALRLn/PDpEYw8tv+EC16hZF4M24Yi9oW8Dai
         txFA==
X-Gm-Message-State: AOJu0YyfhZ2Zc7cfHNkKH1UiOP6KgqiPxn1NOysPLWZpYMj5fqb9zVf0
	v6Iv3nlT0ZutiJY2ubxL6vjc2g8yTaPIK21PThip/A/YD+tDKCDVqvHSaOVSvg==
X-Gm-Gg: ASbGnct+OP4w+M76ay9InAEL8rlHk2POAX/H3uByOvsu2hz5HcjxT/Vk0uIdg9XC48S
	QjsiSgS9adcHvik2AYgU/fNHZ4zzzoWLre649Nf8eqbp3USvBqt4rAUgwJJ3hQ2Ohp+h4IPk1yV
	zVGknhTQ/cxACazIaPg9RWED7Igj/jeScz+WGBoNjF4XbKT509s/C5yksMcaZdX2acAIN8jmARh
	uXCW38TWfS8bEuw3/XTvaOEMAWVJCx5+BQgI9MEIMFk2yuqj4roUEePSqcg5yh8R1vLrP/fErAz
	VtQHlJDldVpujceU1TKpUr+EHpcfcBfM4A==
X-Google-Smtp-Source: AGHT+IGS8mFVfXUt54fDBWDO7P7xrxSEOpBoQDsZbYtjFVUJ9rSqkBeSUVlgopX1VF740+83tsLNYg==
X-Received: by 2002:a05:600c:8a1:b0:43b:bf3f:9664 with SMTP id 5b1f17b1804b1-43d5a3c089dmr3889515e9.5.1742868092901;
        Mon, 24 Mar 2025 19:01:32 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:fbb4:5f96:b3e7:71b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdac9dsm186200405e9.30.2025.03.24.19.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 19:01:32 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Subject: [PATCH 0/2] x86 unwind fixes (1 unwinder fix, 1 missing entry ORC
 annotation)
Date: Tue, 25 Mar 2025 03:01:21 +0100
Message-Id: <20250325-2025-03-unwind-fixes-v1-0-acd774364768@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHEO4mcC/x2Lyw5AMBAAf0X2bJPaKuJXxKF0sZeSNh6J+HflN
 pPJ3BA5CEdosxsCHxJl9UmKPINxsX5mFJccSJFRmgx+gErj7k/xDie5OKLVVT2acuCGCNK6Bf5
 DOrv+eV6cN4ezZgAAAA==
X-Change-ID: 20250325-2025-03-unwind-fixes-a367c54be822
To: x86@kernel.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
 Dominik Brodowski <linux@dominikbrodowski.net>, 
 Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Vernon Lovejoy <vlovejoy@redhat.com>, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742868088; l=1258;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=mtd23FxlAYpI89ijMINKo5d3f3VQjTs7UnE9Fannsrg=;
 b=J/3DePBhxDnNKaYMFT7q81Z5B4e6C6JWHVWyXbpeIu2tWHL3zSsO7YGWDVUJEdFXugVYaH6sQ
 sE4YWw1WQuCDKvKZHHE5LFXaURC4GmKgu9KQ4K/1chKen8iaOE6QzD+
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

While doing some kernel development, I managed to cause a recursive #PF
ending in a #DF, as one does... Thanks Andy for adding guard stacks and
such nice error handling for them years ago.

Unfortunately, instead of a nice stack trace, I just got a pile of guess
unwind lines, caused by two bugs.

Here are fixes I came up with for these issues. The issues were
introduced in 2018 and 2023 - if nobody else noticed them since then,
I guess the fixes aren't particularly urgent.

To: Andy Lutomirski <luto@kernel.org>

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ingo Molnar <mingo@kernel.org>

To: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Vernon Lovejoy <vlovejoy@redhat.com>

Signed-off-by: Jann Horn <jannh@google.com>
---
Jann Horn (2):
      x86/entry: Fix ORC for PUSH_REGS with save_ret=1
      x86/dumpstack: Fix broken unwinding from exception stacks

 arch/x86/entry/calling.h    | 2 ++
 arch/x86/kernel/dumpstack.c | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: bcb044256d3f5d9f5bb61d1eac6492f77883bd60
change-id: 20250325-2025-03-unwind-fixes-a367c54be822

-- 
Jann Horn <jannh@google.com>


