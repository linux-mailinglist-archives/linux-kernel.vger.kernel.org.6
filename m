Return-Path: <linux-kernel+bounces-370654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0979A3027
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740DCB2374C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B021EE028;
	Thu, 17 Oct 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QScC8JXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A81D7E57
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202131; cv=none; b=Tc/SC15Xw6p9Pg7fx8P+5TSWch31m8vw4t9vbf0Uhautc5Syq1tBZc83K+VSOdWWcSbtW4nveeQeK9nu0ER4RCtXhA17Jc5PcuZcIypP0ncTHH/zWjKZHUhOV21UtsIVpDcGsZZq6WvydBdxIcspWXdzklwf3sEnNmW2cyrqPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202131; c=relaxed/simple;
	bh=3+6cqjky5SJ8pbbT1W6aRTHDrkhRTtSUbUYAfyoehbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBiNpIfvgIY4qE/myg5BtmvLJUf8LUPtWG0rkl23VxTiNZ8QvjPasXoAyhFIoF8HCxiC/AS1xNRAMR8mDwNQUU5UYfCEV9EddV3KZfsK1XICiiiMwmL8N68PAx1zQosCa14jsWvUnVHl8WugJTPh7IzKqpqUHpCJQTr0pJd0MfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QScC8JXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15429C4CED0;
	Thu, 17 Oct 2024 21:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202130;
	bh=3+6cqjky5SJ8pbbT1W6aRTHDrkhRTtSUbUYAfyoehbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QScC8JXg1nhIsJfvLMXZp0T/67JQHRKuGALw/DEQDyZqG5bhTI5VunzUliAmaDCTy
	 c/IGDphRQwyP6so/z6M/bZGusu6oMxqktvU2B/PxIyBH09VpBrFCizxBN/yNOraMcH
	 LPv7C82XvgQjd7Cw0C7dkk81Qv4RG68Udm1ukCLHRDJEctcSNXt1xTWyxp9Smy6ggB
	 irDMBk+hdz68zwzRFKTky05dws961rQB+l/+CuG5u5sysjQN0L6VF+X+Xe6jAzw8Zr
	 96AOyOlz/q0+wljnFl74MsTItpZfzA1wWN+6rVInJrwOm+isaX+aJ/EEDqOw+Ww0XL
	 9jOJGvTtKjZ3Q==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 5/6] x86/uaccess: Add user pointer masking to copy_to_user()
Date: Thu, 17 Oct 2024 14:55:24 -0700
Message-ID: <6500dcd8e7700b4dfe5de4f82ed2da19edc23c58.1729201904.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729201904.git.jpoimboe@kernel.org>
References: <cover.1729201904.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add user pointer masking to copy_to_user() to mitigate Spectre v1.

A write in a mispredicted access_ok() branch to a user-controlled kernel
address can populate the rest of the affected cache line with kernel
data.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/uaccess_64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 61693028ea2b..0587830a47e1 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -140,6 +140,7 @@ raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
 static __always_inline __must_check unsigned long
 raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
 {
+	dst = mask_user_address(dst);
 	return copy_user_generic((__force void *)dst, src, size);
 }
 
-- 
2.47.0


