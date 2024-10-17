Return-Path: <linux-kernel+bounces-370649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEDC9A301B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8FF282724
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310891D63F2;
	Thu, 17 Oct 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfsR/Xnj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5C41D040B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202128; cv=none; b=VBPamMl0lZSwXqkqtXDWjoRZ9PZXyWAr6lSRJKHu3C+SePOZzobOxatn+uAeYxzNNq53AAb3K86klpMG+fba+PW1vrKNcoBKjOOCbVUlgjyRekhvh/DYLQWwSRKluVf+FMx/fJOFjtZv0hQAhEEJti+FoEJ3vLph2SxaWdtc2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202128; c=relaxed/simple;
	bh=8F0Ljgplti2+uRIqCwdVcXpYWSHleghZp/ebylrCnso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WG3yXvmWZ8EgvQGsY8jxt5XmedzbYk1AE6XEve4VGHaMUqGcaZGvFuFSh/9eynTxf5QBgxU+D7fh1oLrzFosp02fmjEjamPrWi2LtlLmWizi6Kcv4s9fJD1Vwmf2eto0bHhq4cBTp1dDhns12XBTCSwDsytEF2u+dfvTqZsiI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfsR/Xnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D9EC4CEC3;
	Thu, 17 Oct 2024 21:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202127;
	bh=8F0Ljgplti2+uRIqCwdVcXpYWSHleghZp/ebylrCnso=;
	h=From:To:Cc:Subject:Date:From;
	b=lfsR/XnjX6ZX0cmyfo8vm1CWXUqXqAJejirvPxQnFSkZ2RbVumeYEntkzeyabaVLi
	 hushdvp+1LaVtafe/vp1JOMJpgy0wazXxJKyjtnizi2+jtV4bsUd8j3e9CQQfI8zF7
	 Qgl2Rxb91K/kcL0az/7/PUMpIWJmrmdao5bglHkDC2kZATxkxrtJJYSLe/88Js4JIp
	 CFoEAOi6I0NXpgqISG6mza+K89f1MSvF6l3da8x7hG11MhzY0Yo6wOAxTXmQHKjk1y
	 FifiaJ/INYkdok80ovt+H2IHlIcg3iDipkpOQ3Usc5LVr76lkGlRszR8yhUsBJJcB+
	 B8e01r501BKwg==
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
Subject: [PATCH v2 0/6] x86/uaccess: Avoid barrier_nospec()
Date: Thu, 17 Oct 2024 14:55:19 -0700
Message-ID: <cover.1729201904.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At least for now, continue to assume mask_user_address() is safe on AMD
when combined with STAC/CLAC -- as get_user(), put_user() and
masked_user_access_begin() already do today.

v2:
- Separate copy_to_user() and clear_user() changes out into separate patches
- Add masking to __get_user() and __put_user()

v1:
https://lore.kernel.org/b626840e55d4aa86b4b9b377a4cc2cda7038d33d.1728706156.git.jpoimboe@kernel.org

Josh Poimboeuf (6):
  x86/uaccess: Avoid barrier_nospec() in copy_from_user()
  x86/uaccess: Avoid barrier_nospec() in __get_user()
  x86/uaccess: Rearrange putuser.S
  x86/uaccess: Add user pointer masking to __put_user()
  x86/uaccess: Add user pointer masking to copy_to_user()
  x86/uaccess: Add user pointer masking to clear_user()

 arch/powerpc/include/asm/uaccess.h |  2 +
 arch/x86/include/asm/uaccess_64.h  | 10 ++--
 arch/x86/lib/getuser.S             | 27 +++++++--
 arch/x86/lib/putuser.S             | 92 ++++++++++++++++++------------
 include/linux/uaccess.h            |  6 --
 5 files changed, 86 insertions(+), 51 deletions(-)

-- 
2.47.0


