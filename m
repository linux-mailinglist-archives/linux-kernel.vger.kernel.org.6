Return-Path: <linux-kernel+bounces-220644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B241090E4DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEA1282C64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A55C770F0;
	Wed, 19 Jun 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NsY9k/9m"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3DA78C73
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783388; cv=none; b=bjRucKIh3DDynQqXq7pkDDaGRawKA3ji3yRN5uWu3o+3i4tgpixWiqzTZRejpP4A6oYZZeVXJgL4mqgRYeTmWEZTIkx8Ug90PQT3nVU030h5+SNNDaJgVsBA6uRDboAS569YgW54a0zsShautg+N0vb4yV0icsFq+I7uRe7bi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783388; c=relaxed/simple;
	bh=Gj3VWcCHL1NncwRzZZwWuHjYAhlboqsFlzZMJfuQjZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XRywipWLoKHo/akz1uClw4sh9wjRFpBSDVu1KnyFQI80ZYz94Ht+d5p9EDhgaFbW5Q5XOkaH0LzoMaP/Dcg+NmYxJbWsn89zEbf4+S+GnsS/lSXE0XEckzPp2WW8Nqz87hqoJIYfDnx1Oe8iuFU3q1A8KVD7golaRH6bRNDNzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NsY9k/9m; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 37EAF3FE5E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718783385;
	bh=D4KVI/jl3oe3jUP76k/3D6oeEALm3M9GihzghA5DlTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=NsY9k/9mqrNxGeSMD6xmid26gAWv3g8AYyk/nUrVGQ6YYODnL+Ht4sWY7+qbQH1cJ
	 4me6XEiYq8H7DQEIPyE7fsonO6ZM74DJXLRWy4kQVQXo4AtnNk4lmEfPEhAoKxUtRE
	 Yj7CY00CHGYRi3l3qv4cW9jCSp4pTKq/xwQT/Adx/EVKxSB0TO4gHW0n7pqavHzxmw
	 o90ElZcU4AqTko5LDXIj7/EnT9qZ9qerNMSJuc4VbJpJqIa9oq+wc9ic8RCBYukemp
	 iYWA3dXlwUZZcNFpPe26gy+46YLFr9+gbxmK8hMGBWeYAcmMA53MaFWXXON9ywj1KK
	 BkVmjWcnvpjEA==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3d2327fcf7fso9337865b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718783383; x=1719388183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4KVI/jl3oe3jUP76k/3D6oeEALm3M9GihzghA5DlTQ=;
        b=jER8u1NQHPlqJMhUeLQYPzLBzI6itiqLpAonymbJktu5GD+XsKkEZeET7L2ZlTbqtg
         hjoP0Z3apxxDzgL16oFC6yG87Vax2MAW4k9VLFKiA2d63qJMDsEsE77QZOf5PEK+J1BD
         m+N1gHavakPlRRB4e1oUwXFm7y8ax3MfQGYzeQwdIPIF6kow9tCmUDbdUdis+RcaM8vh
         DhTlzwlhoKvugWvKvxn9u9XGhYRG9d27F/QKsbimhKzfFyhuysCKTHfLQ3x8GUkQPSLm
         uqke+ssEYGlCbm3LbCOwNZLmlJt0/QslqBU+ZRjmGaHv1+D43nHpj2TGa9X45ycJIxsq
         +F0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZTwQ0d1Hh+1q9e14Yw7fr/bG/z80CLW2hZKC5GGT+yx7EvXdKHgizYJBXrcwmifXmHFq/QXQOBC7g2maz5LwBZFe/2UW8XlKtnlwP
X-Gm-Message-State: AOJu0YxQIsdBmJXrlS0ij1QlaVnzPMWpVGxcCeYvbtz8d2tvN6CJiXhE
	H9qQtLU4zLTLIQmtZKrY0kFdtobkFWBYRFIxwTa/3NdaKTkXAZNcfT1NMPaAwP+qc+vD1OeFH0g
	sSuztZg9sDJ9aA9soCemeI8/70/SFjZbKgxL/RjKc4aQpkhIpm5+xAnipNq6RXm7H0xKjhnvv+L
	CjCg==
X-Received: by 2002:a05:6808:398c:b0:3d2:1d05:575 with SMTP id 5614622812f47-3d51ba376c1mr2670604b6e.32.1718783383140;
        Wed, 19 Jun 2024 00:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQXdFD+akom2sF8b78G8dDN0/vsyQBaG+0qnV/hhw23tRKrPD8rZ40yTOvuT8Pyw6TpzkNKg==
X-Received: by 2002:a05:6808:398c:b0:3d2:1d05:575 with SMTP id 5614622812f47-3d51ba376c1mr2670592b6e.32.1718783382929;
        Wed, 19 Jun 2024 00:49:42 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3cdc6sm10076908b3a.138.2024.06.19.00.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:49:42 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] scripts/gdb: set vabits_actual based on TCR_EL1
Date: Wed, 19 Jun 2024 15:49:09 +0800
Message-Id: <20240619074911.100434-5-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
References: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We encounter the following issue after commit 9cce9c6c2c3b ("arm64: mm: Handle
LVA support as a CPU feature").

(gdb) lx-slabinfo
Python Exception <class 'gdb.error'>: No symbol "vabits_actual" in current context.
Error occurred in Python: No symbol "vabits_actual" in current context.

We set vabits_actual based on TCR_EL1 value when
VA_BITS is bigger than 48.

Fixes: 9cce9c6c2c3b ("arm64: mm: Handle LVA support as a CPU feature")
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/mm.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
index f8b9be3f43e8..200def0e4b9a 100644
--- a/scripts/gdb/linux/mm.py
+++ b/scripts/gdb/linux/mm.py
@@ -48,7 +48,9 @@ class aarch64_page_ops():
         self.VA_BITS = constants.LX_CONFIG_ARM64_VA_BITS
         if self.VA_BITS > 48:
             self.VA_BITS_MIN = 48
-            self.vabits_actual = gdb.parse_and_eval('vabits_actual')
+            tcr_el1 = gdb.execute("info registers $TCR_EL1", to_string=True)
+            tcr_el1 = int(tcr_el1.split()[1], 16)
+            self.vabits_actual = 64 - ((tcr_el1 >> 16) & 63)
         else:
             self.VA_BITS_MIN = self.VA_BITS
             self.vabits_actual = self.VA_BITS
-- 
2.34.1


