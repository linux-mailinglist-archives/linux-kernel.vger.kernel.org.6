Return-Path: <linux-kernel+bounces-520988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C30AA3B247
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8577E16B8A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC471BCA19;
	Wed, 19 Feb 2025 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo0MN+L4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF411BD9D3;
	Wed, 19 Feb 2025 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949944; cv=none; b=YOA/dyoGQFUoJBlK3wrauNpte3IAc/kYa8bxYpoV2U6/m3v5QGqFJk4tDFuKYFqNFBI0ZIgIqnUEv85WHy9Wv2Q9xRugCRovu9SpU4Va640zuaODcYAcETsir7kCjgjVL8NDdt3kQcqKWNdpZxHkJVOJrJ4qhUydXZ5YOp0JeIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949944; c=relaxed/simple;
	bh=mn7g0i0MWinLv2YGo+kZxHpbfVUa4TgH6wIWEUwX83A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9Vtnuuog5HLsRwRScIWnSFA+cSWr2//q+Fjk42ny6l6gP7u3n7QCnlc7nPbwK1iHyn+UIgkJBX1O2bXwFqh28GyEboPQQnXyIj1s0oddljr5JtP4fVG8nm14pRNgj6lRa3MvfQscfe6nZspHiPRl81fgH9GsuaZc8DqHeGSSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo0MN+L4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25288C4CED1;
	Wed, 19 Feb 2025 07:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739949943;
	bh=mn7g0i0MWinLv2YGo+kZxHpbfVUa4TgH6wIWEUwX83A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jo0MN+L40nZsA1Z3XLmqtTAFU4+nInYDLglMHXNfS2AWgOzeetC9vn00TVjVV+H9+
	 rQaOBtcGPzPXGVyyTiFcCpL/nBV8pOM8Q4gmV4co22EBNknyhAhIQ5IzurwH1xZs5D
	 9ZupQiXqdfdhBvy4JD5VrKUeuKr1eVOMSSkdgtpySL+EufzrfLjrRGqbFNvu3nHa6B
	 /b5W+Y0ntMGSBuAk5O+mNwS70ivu6sfNCZi3UJ8fCaFpIZ1/CRE0Cn1aAnZq16m/Q5
	 Um3231KPD8ZPih0fAIySoNxdGrfA0cv8JPQSfDj/hyxBae0+mQMSkcmUV9eOwlWzAf
	 EzSsDgPrKpVQQ==
Date: Wed, 19 Feb 2025 09:25:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 13/14] memblock: Add KHO support for reserve_mem
Message-ID: <Z7WHY5RBJc9YxPPY@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-14-rppt@kernel.org>
 <20250217040448.56xejbvsr2a73h4c@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217040448.56xejbvsr2a73h4c@master>

On Mon, Feb 17, 2025 at 04:04:48AM +0000, Wei Yang wrote:
> On Thu, Feb 06, 2025 at 03:27:53PM +0200, Mike Rapoport wrote:
> >From: Alexander Graf <graf@amazon.com>
> >
> >Linux has recently gained support for "reserve_mem": A mechanism to
> >allocate a region of memory early enough in boot that we can cross our
> >fingers and hope it stays at the same location during most boots, so we
> >can store for example ftrace buffers into it.
> >
> >Thanks to KASLR, we can never be really sure that "reserve_mem"
> >allocations are static across kexec. Let's teach it KHO awareness so
> >that it serializes its reservations on kexec exit and deserializes them
> >again on boot, preserving the exact same mapping across kexec.
> >
> >This is an example user for KHO in the KHO patch set to ensure we have
> >at least one (not very controversial) user in the tree before extending
> >KHO's use to more subsystems.
> >
> >Signed-off-by: Alexander Graf <graf@amazon.com>
> >Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >---
> > mm/memblock.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 131 insertions(+)
> >
> >diff --git a/mm/memblock.c b/mm/memblock.c
> >index 84df96efca62..fdb08b60efc1 100644
> >--- a/mm/memblock.c
> >+++ b/mm/memblock.c
> >@@ -16,6 +16,9 @@
> > #include <linux/kmemleak.h>
> > #include <linux/seq_file.h>
> > #include <linux/memblock.h>
> >+#include <linux/kexec_handover.h>
> 
> Looks this one breaks the memblock test in tools/testing/memblock.
> 
> memblock.c:19:10: fatal error: linux/kexec_handover.h: No such file or directory
>    19 | #include <linux/kexec_handover.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~

Thanks, will fix.
 
> >+#include <linux/kexec.h>
> >+#include <linux/libfdt.h>
> > 
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

