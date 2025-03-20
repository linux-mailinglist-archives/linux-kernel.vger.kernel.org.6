Return-Path: <linux-kernel+bounces-570551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F51EA6B1E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24834A0C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10321D018;
	Thu, 20 Mar 2025 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgCxEuVX"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A77822AE49
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742515157; cv=none; b=cE7rS+DdwWGSkyLFS+Ele45GYCBQPDTyLHTWPuGMK6CpSJKnL1+ksh8eWNzWlRHUSdZ69PDoP4HTmujX/ZEZn6VcTGCD/8DmOhI3jKaP/Ubd0r6xg2A3Nsw21gMUV2PDg5d6gIxMe4zLxaAp77rqSCztMClEZU+VM0Zy2wR9J/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742515157; c=relaxed/simple;
	bh=KWXgKeeRyxAABGX1lfsepKxCW80NDLlNH+a5wGO3ias=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pN/q5VXyyaLK5JKZGLHvyyemYHC0WGLFz5yBb2z583yh22DZ93xKM3Hnp50P01ClakEz5wJH2jCxVjzLqADOo71Le/xy7q5I3AKX6wN/pAQNIeg4eMH7PDYbM9+bTmSZEbp3bLQBvqj7o9omz3r12qPf0d3JSsDVxwWZcyCpCSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgCxEuVX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--changyuanl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22650077995so32638765ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742515155; x=1743119955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=loL07EFpzn9RFKU+1xqTjFTK8szpohqpYkvK4IMMJvM=;
        b=wgCxEuVXhmDVDzrSqhk2f+scb80/w14odECcL895xvoBFqjxZ9yRkVqSDRTaqdbq6r
         1WoE/B5LcdHtwq2TDOM3LFITV7YqbAlL+1l26ofqBTx0hV4WMWwy1jTEKpQyftc6arND
         WfZhqkPcOTCy+bJ3Ii3ILMF7UOzYqai7tlpr0OVX3Rjz0vl6Xl+BxhOe2t1OkDs/7h/R
         BMskBKnjja2YqA8LD8E74Nfhsl0pV+WypXp6cmutdvPlS1fQn+89DESY+AC0TFOAUX3n
         HpswEeGnvK/g6Wjx6RCWL8sXPcVzBX2Pzv+L7zzzTF4qZ9x+T+KiPSt6/NFyeQIEjQ6H
         62iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742515155; x=1743119955;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loL07EFpzn9RFKU+1xqTjFTK8szpohqpYkvK4IMMJvM=;
        b=BxbeHei4UwBZZv4mv1F7h1WM4Aqjg3AUrZqGf2rXgeGMRGWy4qrPpUhTWg2RaN9ilo
         VfKOrbcjk9ZYqIBgysjFQlB9iKURgxtnWIgXmwVMOOzCBCQgsHryY7EBDmpHA4oatCDF
         GS7DktNHRCBqq26UtL86D2egzXppgABI7a3EHdxfee/ulTCWE8Xmsx0KaBhwpb+lCy0V
         YjlKf/mY1W6fqDO/jzMIN40ltXdsFE6t719xI4/Jddniuza/40biCQiWlMkyKPPcFeTp
         m7kmJ1Zs66R4rUMDd7Th/zpXtlQ0ZLEyHLrB0iX2Dy1I6xyfdZe28V42pAxvXD46Nkuh
         BBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOB2dABUCYO8KXDtY/f44cPU+dXZ8zsF+cn32bkyAx6JL67wzvZt8bEbhOf7nOg3XXdDYHBtJG42RpJpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbPa1SfhTcLznsd45/prMSwEBgnXMYNNpmFup5MNBX45ObzWv
	2wMbRAsQZversMFdWdz/Ui3RNOK+9l4u0STEzphQf32Iu7nYoYftSH1oF246C2IzhDXXVko7+gI
	iFjg/jdTtt7YnRxdOlQ==
X-Google-Smtp-Source: AGHT+IE1j4tW7U4miv/y5fn9y5TOdg/R4Dy4plBXh7gVZbeDYE6afhmC9AZBc/+Ph53Y4uJfcVzswUVKCNNLOFbd
X-Received: from plgu5.prod.google.com ([2002:a17:902:e805:b0:223:58e2:570d])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d50e:b0:224:7a4:b2a with SMTP id d9443c01a7336-22780c50a89mr16920945ad.11.1742515155584;
 Thu, 20 Mar 2025 16:59:15 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:59:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320235910.334620-1-changyuanl@google.com>
Subject: [PATCH] clang-format: add for_each macros from libfdt
From: Changyuan Lyu <changyuanl@google.com>
To: ojeda@kernel.org
Cc: nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"

Add two for_each macros from scripts/dtc/libfdt/libfdt.h.

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 .clang-format | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.clang-format b/.clang-format
index fe1aa1a30d40..4decda7474e1 100644
--- a/.clang-format
+++ b/.clang-format
@@ -210,6 +210,8 @@ ForEachMacros:
   - 'evlist__for_each_entry_from'
   - 'evlist__for_each_entry_reverse'
   - 'evlist__for_each_entry_safe'
+  - 'fdt_for_each_property_offset'
+  - 'fdt_for_each_subnode'
   - 'flow_action_for_each'
   - 'for_each_acpi_consumer_dev'
   - 'for_each_acpi_dev_match'
-- 
2.49.0.395.g12beb8f557-goog


