Return-Path: <linux-kernel+bounces-564045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E20A64C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6D817233A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E702023717D;
	Mon, 17 Mar 2025 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAf8FKBh"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE5236A72
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210996; cv=none; b=fyVwWZNga1p758pVJwmTl+Txg33Nu6TMvspm1IGlyHQ1uFezRJKVnfxsjqnvEmMYG+yzNOpS8dkZ8VBw57hgfQ8xGKmKq4GdhPh66IPACQMqL/3z6fTfg2veQpptyLxiEHM7rK0XNMkgvM/h4AQSI+Ny+CSAo5jfJl5rZtlWTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210996; c=relaxed/simple;
	bh=yDI2zgyohoL5dWeqF2dFktnEe7P14OSIHv8Y7QW7WiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVuL8iScd7hxDyjUoX5ML0gRdIjU4BoBmrEQb4lN/05KueY/6z63X5Q6PfQ33aG504fw7yngUqs37B3uF6hm5KHmbzLVi97FFh1MrCJoAaDSsWek9NagBwDyRKSgvypy6pjHJCmIzyNTAgpogl39UqfKMYSTYUWjWfJYrlmbizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAf8FKBh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso765216666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742210993; x=1742815793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvAN/7tOVuJuUA/NQQnQYwNpVL/lQvQw/Vywf7L3EpI=;
        b=BAf8FKBhw0jRuFaDH9tLelIQsU0KuSoxM+iub+pneGwGBQUlBcg8AjlgT91wnbT7yh
         +bb1exBUYkGEbjt5ZOc+fiyuag2GcyMxOow44kzJS3r9GO05puq6U1W1ZLt3W07BxIbl
         6UwwnVcYjVwsnBoQe306nxrjCDBnDeClmeO4wPJ6ySbdpEhr1qsJr14DTCSBu6z2HjUn
         aYmGYQ5MJE+iyfvI0da3WqdDDrtofOJnTSc+VbdNOBYB4+DfReOtx/jiQliLQIyYyGuK
         bsxtDLmbH1JWZgP4pnXMzoEzEwqWyk76pHWtNMElkK915mwscPivnSZEpiTXZ/C5p9iA
         fHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210993; x=1742815793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvAN/7tOVuJuUA/NQQnQYwNpVL/lQvQw/Vywf7L3EpI=;
        b=ATI27teRGVeg98KM816xP4LWYHoV+FMwnFkzk0+UsTB4RnCDnXh56ilWQ3p3T/q1X9
         HJ1VNrbyu4Z5eIMaW7/85rJYN26rHvpQlM8GUjj0vlMcZt8mvI9Shcu4EtiddbB1AZGC
         /FG6yOD4woYt52eGNo4/dE58uMdyl10G+OsdoU3tOOBxpSpwd49VnMwKU1bNSkesv/Wi
         AiPnz71jCAV1QWC0RV7qMYFSpX/B/9MD+9lrrIlBHsth6AFz/P4kQd9JoNvnQV0rNyck
         QxLn3RdqkEYQdpnh9heJkdFE+bq+VIWBIneT4UgWwjOSdpOEI2vaDB6gi0bnjgCwmdzQ
         lqzg==
X-Forwarded-Encrypted: i=1; AJvYcCWI6EbXlfZwPIrgB41QgwgKIGn23WL6/AKlxR6FS4k9qZeH2InJOECAbOCI9+rkfIFPQ1PYlTL/WvF0DO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3EEwsTMvJKye6aFOK0jM8LAN/WyhWmKIlC8mgOEe+kCNkZWd
	llMLLZC3NmvJeFAxDmxUVf/6S7lNX2bpxulr2VR0YFv/j63PxxRr
X-Gm-Gg: ASbGncuTf7mCkr+cNJzYfS9YCHuYcueZlAb3crvVY1X0eP+KiJ1ctyIx505AJcTZ8jq
	ZADtyx6qI9ALAJNYrLEfHpu1sHBlvJTkGFN+StARJvIjPEO/6jtMensG2ag9fatnPlLd5O+ehXV
	W2p1m9qHHO0U+XTBIflqxhj3cMmKh/fTY+36plhoIFXIaPi399pGrAAD2gdog6a7a4h36NN2SZh
	fQzOYKAMsxtBQr4ueJcs0FOK1mskzRyJ59khMniDFyKPmLDsTADve8q9V0ltv7Hzy42QQhSoMgy
	yQMJH8PyzJOyqwkxGu7zvgma+PoQ8cet6bWf0j/X4ulF6hI=
X-Google-Smtp-Source: AGHT+IG+gI+aMDu5vQUfqySqI96FERHxH3L7FPefQA0AUTNHXYJAOIbk3xJ9TR09F66g/KtvtTNbwA==
X-Received: by 2002:a17:906:6a0a:b0:ac1:e18d:a738 with SMTP id a640c23a62f3a-ac3311b11d1mr1308948066b.3.1742210992323;
        Mon, 17 Mar 2025 04:29:52 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cdec8sm651059766b.112.2025.03.17.04.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:29:51 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86/asm: Use asm_inline() instead of asm() in __untagged_addr()
Date: Mon, 17 Mar 2025 12:29:48 +0100
Message-ID: <20250317113013.182359-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use asm_inline() to instruct the compiler that the size of asm()
is the minimum size of one instruction, ignoring how many instructions
the compiler thinks it is. ALTERNATIVE macro that expands to several
pseudo directives causes instruction length estimate to count
more than 20 instructions.

bloat-o-meter reports minimal code size increase
(x86_64 defconfig with CONFIG_ADDRESS_MASKING, gcc-14.2.1):

  add/remove: 2/2 grow/shrink: 5/1 up/down: 2365/-1995 (370)

	Function                          old     new   delta
	-----------------------------------------------------
	do_get_mempolicy                    -    1449   +1449
	copy_nodes_to_user                  -     226    +226
	__x64_sys_get_mempolicy            35     213    +178
	syscall_user_dispatch_set_config  157     332    +175
	__ia32_sys_get_mempolicy           31     206    +175
	set_syscall_user_dispatch          29     181    +152
	__do_sys_mremap                  2073    2083     +10
	sp_insert                         133     117     -16
	task_set_syscall_user_dispatch    172       -    -172
	kernel_get_mempolicy             1807       -   -1807

  Total: Before=21423151, After=21423521, chg +0.00%

The code size increase is due to the compiler inlining
more functions that inline untagged_addr(), e.g:

task_set_syscall_user_dispatch() is now fully inlined in
set_syscall_user_dispatch():

	000000000010b7e0 <set_syscall_user_dispatch>:
	  10b7e0:	f3 0f 1e fa          	endbr64
	  10b7e4:	49 89 c8             	mov    %rcx,%r8
	  10b7e7:	48 89 d1             	mov    %rdx,%rcx
	  10b7ea:	48 89 f2             	mov    %rsi,%rdx
	  10b7ed:	48 89 fe             	mov    %rdi,%rsi
	  10b7f0:	65 48 8b 3d 00 00 00 	mov    %gs:0x0(%rip),%rdi
	  10b7f7:	00
	  10b7f8:	e9 03 fe ff ff       	jmp    10b600 <task_set_syscall_user_dispatch>

that after inlining becomes:

	000000000010b730 <set_syscall_user_dispatch>:
	  10b730:	f3 0f 1e fa          	endbr64
	  10b734:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax
	  10b73b:	00
	  10b73c:	48 85 ff             	test   %rdi,%rdi
	  10b73f:	74 54                	je     10b795 <set_syscall_user_dispatch+0x65>
	  10b741:	48 83 ff 01          	cmp    $0x1,%rdi
	  10b745:	74 06                	je     10b74d <set_syscall_user_dispatch+0x1d>
	  10b747:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
	  10b74c:	c3                   	ret
	  10b74d:	48 85 f6             	test   %rsi,%rsi
	  10b750:	75 7b                	jne    10b7cd <set_syscall_user_dispatch+0x9d>
	  10b752:	48 85 c9             	test   %rcx,%rcx
	  10b755:	74 1a                	je     10b771 <set_syscall_user_dispatch+0x41>
	  10b757:	48 89 cf             	mov    %rcx,%rdi
	  10b75a:	49 b8 ef cd ab 89 67 	movabs $0x123456789abcdef,%r8
	  10b761:	45 23 01
	  10b764:	90                   	nop
	  10b765:	90                   	nop
	  10b766:	90                   	nop
	  10b767:	90                   	nop
	  10b768:	90                   	nop
	  10b769:	90                   	nop
	  10b76a:	90                   	nop
	  10b76b:	90                   	nop
	  10b76c:	49 39 f8             	cmp    %rdi,%r8
	  10b76f:	72 6e                	jb     10b7df <set_syscall_user_dispatch+0xaf>
	  10b771:	48 89 88 48 08 00 00 	mov    %rcx,0x848(%rax)
	  10b778:	48 89 b0 50 08 00 00 	mov    %rsi,0x850(%rax)
	  10b77f:	48 89 90 58 08 00 00 	mov    %rdx,0x858(%rax)
	  10b786:	c6 80 60 08 00 00 00 	movb   $0x0,0x860(%rax)
	  10b78d:	f0 80 48 08 20       	lock orb $0x20,0x8(%rax)
	  10b792:	31 c0                	xor    %eax,%eax
	  10b794:	c3                   	ret
	  10b795:	48 09 d1             	or     %rdx,%rcx
	  10b798:	48 09 f1             	or     %rsi,%rcx
	  10b79b:	75 aa                	jne    10b747 <set_syscall_user_dispatch+0x17>
	  10b79d:	48 c7 80 48 08 00 00 	movq   $0x0,0x848(%rax)
	  10b7a4:	00 00 00 00
	  10b7a8:	48 c7 80 50 08 00 00 	movq   $0x0,0x850(%rax)
	  10b7af:	00 00 00 00
	  10b7b3:	48 c7 80 58 08 00 00 	movq   $0x0,0x858(%rax)
	  10b7ba:	00 00 00 00
	  10b7be:	c6 80 60 08 00 00 00 	movb   $0x0,0x860(%rax)
	  10b7c5:	f0 80 60 08 df       	lock andb $0xdf,0x8(%rax)
	  10b7ca:	31 c0                	xor    %eax,%eax
	  10b7cc:	c3                   	ret
	  10b7cd:	48 8d 3c 16          	lea    (%rsi,%rdx,1),%rdi
	  10b7d1:	48 39 fe             	cmp    %rdi,%rsi
	  10b7d4:	0f 82 78 ff ff ff    	jb     10b752 <set_syscall_user_dispatch+0x22>
	  10b7da:	e9 68 ff ff ff       	jmp    10b747 <set_syscall_user_dispatch+0x17>
	  10b7df:	b8 f2 ff ff ff       	mov    $0xfffffff2,%eax
	  10b7e4:	c3                   	ret

Please note a series of NOPs that get replaced with an alternative:

	    11f0:	65 48 23 05 00 00 00 	and    %gs:0x0(%rip),%rax
	    11f7:	00

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
v2: Include asm dumps of inlining in the commit message.
---
 arch/x86/include/asm/uaccess_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c52f0133425b..3c1bec3a0405 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -26,8 +26,8 @@ extern unsigned long USER_PTR_MAX;
  */
 static inline unsigned long __untagged_addr(unsigned long addr)
 {
-	asm (ALTERNATIVE("",
-			 "and " __percpu_arg([mask]) ", %[addr]", X86_FEATURE_LAM)
+	asm_inline (ALTERNATIVE("", "and " __percpu_arg([mask]) ", %[addr]",
+				X86_FEATURE_LAM)
 	     : [addr] "+r" (addr)
 	     : [mask] "m" (__my_cpu_var(tlbstate_untag_mask)));
 
-- 
2.48.1


