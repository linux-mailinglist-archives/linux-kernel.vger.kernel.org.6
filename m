Return-Path: <linux-kernel+bounces-380716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218389AF4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6397280E84
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A65621831B;
	Thu, 24 Oct 2024 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByfetNjS"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C32178E3;
	Thu, 24 Oct 2024 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729807076; cv=none; b=pwDr6DLhvY6cVBvQY/bEdOjYc396ZAerTvL8fvW4RdjxthIZKP4SSkJJa0Bs1O4/6hnfRnPZZ2oBUOPz3Hf5uGcF/no5jG25R1dcITG+QVcxoOrk73qmutEBQlee9GpfWIPLGYkbICmORvPoKL9i9jFer5PlSP8h1vC6vA2wScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729807076; c=relaxed/simple;
	bh=uctbUevpAb5f7eNTAx113WUp/RM64VGoO7T5/Esjzbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hw9SLqpHCsifoYe6I2w2qUZMHRoOK2RM5BVzFcIP8Tbz6fyIfGV3a9QF8vHFySDHpVRIW1Ib8/zhkqRtZoXDM9eQVPrYMe4UPzX3XCUyDF0EKApbwlQy1UlV1Btw0eUmiCnyjTrOtumtBSYmLk+PwE4HdeJa8F5IUPF0rl0Ov40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByfetNjS; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so385510241.1;
        Thu, 24 Oct 2024 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729807073; x=1730411873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3GG1M8mZMf3NOK61KII0Pd2B4NFeAW3CspARjHNIbU=;
        b=ByfetNjSDsXCv6phUzjq4j5Herbf6EMvyaX++JMtAIq6204hxaIWnTeCHS2nIz1zyQ
         YHQsNhPrSERTRHly3tgwYJtCz4USnKrg+TJR/l14wkVpTOdQAcAgqHNO0v4NcFnjDD/F
         P+RP8DS0HbSMOiPyaeT7IeC0iK9UjsVQyX+hw2jt18i/2UhtVbXcU1x37IrcACPNLV91
         iUS7jNc6EkPTLB57Js0+wUUXJcr7cmkr6kLDbjDATNFOJMwfx1ERV3RFfFYNQFBK4S7z
         +fMTcG2s9IzbiKRKGQRs8NEk0MjuvlpHkJZ3OWMKon9E3Akpzq4dgTvlb+h45U7fiTqy
         haog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729807073; x=1730411873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3GG1M8mZMf3NOK61KII0Pd2B4NFeAW3CspARjHNIbU=;
        b=tLC87YfejD5DVJYOOq3Xor4QTeRCpIWvVIB8wzdJY3yFBDK4CMb/ToM/GbEI6/Il1m
         zZyF/AdJlWSjaf8lCFPxxVUmqKAVktlGYHCtiZPufz96dX2UYmiLOtWzK9ZhCSSF89zv
         sQqaly0SshLP1q9/GCioflsXuGr81lxDiImIJQVfMqeATMxUFmFqxEWqkk0tdZmwo0V3
         zKN/TAbRvrBesZCUsF+w6/jYWTnO9zkSMyq6Os4HZ+OGV2LtOVBp2IPaU0/j5RLZErz/
         D6T3vsdOEy0D2S1hNs1OFEW42kHb3u0PyLAGnuDoSaG4bJxJ1rY8drv5OspF5/rsAZxX
         bQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCSZRm0Ks/V+xTwwAd3qbRI5Ofd6MYbeaeyFbFodxKFQh/70kSbCr4qQF1pwF8IYG7f83Ne/zQDySel5w=@vger.kernel.org, AJvYcCUlPhZCJmmnBt0m0SAwme1RRHA7aozrc5tMQTvb7wMnIO6rafXSkPGApYDZ2Es6aNU5fHKI67FfqrOx7u6gfkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV0tv+2xx9IEEaOdyzkkRClLLBUNkri4XmttoD4fHlMDwfbcfs
	WOlNxZYOdPqRLriruO5GiCQaP8gOSHiuvrbyYfr9ffmxftqR9cg5
X-Google-Smtp-Source: AGHT+IGbBt//HrkW7rtbk1WIb1GNQzbBU91VQ1Gt7Y9Iejv5lmi9B7E1VEDAKKKngyTomKtgNpnG6g==
X-Received: by 2002:a05:6102:cc7:b0:4a4:6858:3365 with SMTP id ada2fe7eead31-4a751c92486mr10137173137.21.1729807072930;
        Thu, 24 Oct 2024 14:57:52 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008f5ccdsm54312146d6.32.2024.10.24.14.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 14:57:52 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id AF9181200066;
	Thu, 24 Oct 2024 17:57:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 24 Oct 2024 17:57:51 -0400
X-ME-Sender: <xms:38IaZ4Pl2OIrJXppkLVKz6CuidCn89cFl3qRnvd6P_doB8toueGSfA>
    <xme:38IaZ--GR-ut7I8R__BrfW0x4TcdtcF3i7SdYHTAghDbBijDvyakxc7wlNRhI8IzI
    wuM-rOFZJCtjguh-w>
X-ME-Received: <xmr:38IaZ_SFYw7cd63vcGVMqeJ9OTXd19QqdV89ywE45HdXPwbK93BMGrvMbdbvww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejuddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    peguihhrkhdrsggvhhhmvgesghhmrghilhdrtghomhdprhgtphhtthhopehlhihuuggvse
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheprghirhhlihgvugesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    mhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:38IaZwutjOSeiraSDnUkukhnlKmczTwd0mZPAKajhe9axIz4CFwqzw>
    <xmx:38IaZwdUxf9W4oNPpoTVMe2ojKu5s4H5h8Odyf9vVSdTkYrS9jrFsw>
    <xmx:38IaZ02t3TkFHboXU14ysLlttPKgwnnhBs6fauV0-iJZSu76Xzb59A>
    <xmx:38IaZ0-Jr8jML4AfMvZ8EjrUwPYS8IjhglfcTv68zm8kDDxRxZ9TcA>
    <xmx:38IaZ389n0fwRSMup83tmpO31MBhmegknLTkVloNVNL_KWHxSkreH8MK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 17:57:51 -0400 (EDT)
Date: Thu, 24 Oct 2024 14:57:02 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dirk Behme <dirk.behme@gmail.com>, Lyude Paul <lyude@redhat.com>,
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, will@kernel.org,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>, aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <ZxrCrlg1XvaTtJ1I@boqun-archlinux>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
 <87a5eu7gvw.ffs@tglx>
 <20241023195152.GE11151@noisy.programming.kicks-ass.net>
 <877c9y7dwx.ffs@tglx>
 <20241024100538.GE9767@noisy.programming.kicks-ass.net>
 <87bjz95sc4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjz95sc4.ffs@tglx>

On Thu, Oct 24, 2024 at 07:22:19PM +0200, Thomas Gleixner wrote:
> On Thu, Oct 24 2024 at 12:05, Peter Zijlstra wrote:
> > On Wed, Oct 23, 2024 at 10:38:38PM +0200, Thomas Gleixner wrote:
> >> But if we want to support insanity then we make preempt count 64 bit and
> >> be done with it. But no, I don't think that encouraging insanity is a
> >> good thing.
> >
> > The problem is that in most release builds the overflow will be silent
> > and cause spurious weirdness that is a pain in the arse to debug :/
> >
> > That is my only concern -- making insane code crash hard is good, making
> > it silently mostly work but cause random weirdness is not.
> 
> I wish we could come up with a lightweight check for that.
> 

Since the preempt part takes exactly one byte in the preempt counter,
maybe we could use a "incb + jo"?

For example as below, note that since I used OF here, so it will try the
byte as s8 therefore overflow at 128, so 127 is the max level of
nesting.

Would this be a relatively lightweight check?

Regards,
Boqun

--------------------------->8
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index bf5953883ec3..c233b7703194 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -16,7 +16,10 @@ struct pcpu_hot {
 	union {
 		struct {
 			struct task_struct	*current_task;
-			int			preempt_count;
+			union {
+				int		preempt_count;
+				u8		preempt_bytes[4];
+			};
 			int			cpu_number;
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 			u64			call_depth;
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..8d3725f8f2c7 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -251,6 +251,17 @@ do {									\
 		percpu_binary_op(size, qual, "add", var, val);		\
 } while (0)
 
+#define percpu_check_inc(size, qual, _var)				\
+({									\
+	bool overflow;							\
+									\
+	asm qual (__pcpu_op1_##size("inc", __percpu_arg([var]))		\
+		  CC_SET(o)						\
+	    : CC_OUT(o) (overflow), [var] "+m" (__my_cpu_var(_var)));	\
+									\
+	overflow;							\
+})
+
 /*
  * Add return operation
  */
@@ -488,6 +499,7 @@ do {									\
 #define this_cpu_read_stable_4(pcp)			__raw_cpu_read_stable(4, pcp)
 
 #define raw_cpu_add_1(pcp, val)				percpu_add_op(1, , (pcp), val)
+#define raw_cpu_check_inc_1(pcp)			percpu_check_inc(1, , (pcp))
 #define raw_cpu_add_2(pcp, val)				percpu_add_op(2, , (pcp), val)
 #define raw_cpu_add_4(pcp, val)				percpu_add_op(4, , (pcp), val)
 #define raw_cpu_and_1(pcp, val)				percpu_binary_op(1, , "and", (pcp), val)
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 919909d8cb77..a39cf8c0fc8b 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_PREEMPT_H
 #define __ASM_PREEMPT_H
 
+#include <asm/bug.h>
 #include <asm/rmwcc.h>
 #include <asm/percpu.h>
 #include <asm/current.h>
@@ -76,7 +77,12 @@ static __always_inline bool test_preempt_need_resched(void)
 
 static __always_inline void __preempt_count_add(int val)
 {
-	raw_cpu_add_4(pcpu_hot.preempt_count, val);
+	if (__builtin_constant_p(val) && val == 1) {
+		/* Panic if overflow */
+		BUG_ON(raw_cpu_check_inc_1(pcpu_hot.preempt_bytes[0]));
+	} else {
+		raw_cpu_add_4(pcpu_hot.preempt_count, val);
+	}
 }
 
 static __always_inline void __preempt_count_sub(int val)

