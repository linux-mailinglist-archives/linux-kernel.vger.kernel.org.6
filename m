Return-Path: <linux-kernel+bounces-393180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524169B9D54
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 06:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24931F253E5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 05:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B78149E16;
	Sat,  2 Nov 2024 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="lgp50Ey0"
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF072595
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 05:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730526111; cv=none; b=ktAO6EccyS8akvbq0KnI7b7qWC5hFrWAaZtd1tDg2iKDx4ferXW08XbAH0Er/dWQumHPsaqyu0jAUXl3ARdU72jjlGYR9sTWgNwInzw/eZVhWYXWeZFdUXOKRQq2pVcxVCmu8niq24bdrzPi/0h9UgFJ+HWfhvKqpz/A71CRKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730526111; c=relaxed/simple;
	bh=yOUQSBsILkKt77B9oalo0ExmSVmo29tUfsF6B6jI7Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GapHctKd0XJGmKDZax2U4BAydUYiUEQnNsv9IdAL+yV92vBwT/i4qqvP5UuzL60BQjl/6uhIPoX0VBvs6P3uq1rXjEXHpqNK/F+dQmb6Ckw8rfdtQiQ/9tcrvgedkZzMWxKQMxk2XEtPYxdg/Mi9hpV8+tgWLZpxK2SPJglgesU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=lgp50Ey0; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1730526092;
	bh=BIyYvigQq7UKFOdCDQCsps6q948TUJUQ8Syfr7kRYLc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lgp50Ey09tdTgFVLkWFehw/M79cvCoAluz0J4ZmsZ73cRobsw3i8Vn3pdJk2zp9eA
	 AWUa+msR/Lx3V9XibidghcOoS+3TtulUUYyToa+dymRizp9dmMdciuiqV6W6NfK0Po
	 CvpKSpUi2sVX6rejqfxC19NbOxg5l2HaAnuj8SwY=
X-QQ-mid: bizesmtpip3t1730526061t8abo2y
X-QQ-Originating-IP: lGcQ/SKHCJLsGWmdKi8OnvoZ3URBdJcfKRGdsM5umzs=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 02 Nov 2024 13:40:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2957908697263137939
From: WangYuli <wangyuli@uniontech.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	tglx@linutronix.de,
	max.kellermann@ionos.com,
	arnd@arndb.de,
	wangyuli@uniontech.com
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	jiaxun.yang@flygoat.com,
	zhanjun@uniontech.com,
	anshuman.khandual@arm.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	geert@linux-m68k.org
Subject: [PATCH] LoongArch: mm/vma: define a default value for VM_DATA_DEFAULT_FLAGS
Date: Sat,  2 Nov 2024 13:40:41 +0800
Message-ID: <1BC681DB785E0181+20241102054042.74847-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NOIkHYnr7Vzd9Ys9MjSHks47cd4f9/dIsFgaTDaTP71h4QfRSOi/6lkX
	QkkhmY+P1/b1gnmcyDR4ViSZsePxE3ZdASpecFQ/70A9NcosY2Yk/VMl/89w/e7TIGstClF
	fz8KMipk4bNwp4j7s95HLp71jAhRXkly5KeXR9XSGwy44HkweyNOicq4fIapXitT3WUFLVp
	PTCzYmg6xYpp4MHRU6lKrIbXkV5A6ppy3+a1c9u1NlbeL+3sm2627M/RjVAHM0Lv+F0WW36
	QKXQC8zLwT19mfuz0hlZvC+2ag7dRLnEYhYPdsvhMUtTinAblAXNPgSiV9d5AyNCHOCzLgi
	G/myw245l7UGAzZtoukdqUIapkiYrEQV4ehQDxeqLyAr8Oj9HJUCerU+erx+T55aLfQOyff
	M9cICW9lENko+uJivFpLLp80a1Fug7kchBEyEzOwtijewtndXay7hGOfbKy+Qi/8psyb/Zi
	STHRwSnDoRk936jIVucRc1mxgUmgRvU7lFgXfGr6KVcPRLnsi75Fet/bm7Z+DJXe051vzJX
	GIezIfcZH7gaq5Aa61fw1kFTN+LO5xHIEQ1tR14agYrb+4zNtNm9CkiOJBbfcuztQUcnb0w
	hyusiIFd6VZzn/sAtoybDA2BIswwoW7GY1/xnm8MtDhRHcdOaGCbDINuNmgMJuOuKqZk38Z
	tHssf6J4OzEjOuheQDPUc62jrW4dWemqYS9Mi1+1AJoeX+weYUgaZMVm87TKplO6w5JIOzJ
	C+mQudZX3VnxT+Tg8iY+qbw54E2ajM7Yi1d2lakyi8Q8tVKnqlyqimVpvovtYlltiF6P4bl
	MBG/GnedIXrslzaO/CzclySZjJtr8SsfAZrBAzdjZkWo4R32voaXobZvxm6Ku30ufA1Tn6F
	aINgnC8CmLh22yzjevxLjO36cUk3DerRNDhSRuXxzjxl99MA7AxjIwfIEpXrhhfplVThQEC
	VhHBb87kJJR9JGxdUVmxTPKmZ4OTQkXNGvyzxDziUeMVi/3xG3Mw5y9rGkE5UpquNEXMzMc
	eLjjyShAHVk6eg9jDt/oHfiGvq3G8yUK6jX7e4j5Wa6qbBv86u
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Commit c62da0c35d58 ("mm/vma: define a default value for
VM_DATA_DEFAULT_FLAGS") has unified default values of
VM_DATA_DEFAULT_FLAGS across different platforms.

Apply the same consistency to LoongArch.

Suggested-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/loongarch/include/asm/page.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index e85df33f11c7..8f21567a3188 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -113,10 +113,7 @@ struct page *tlb_virt_to_page(unsigned long kaddr);
 extern int __virt_addr_valid(volatile void *kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((volatile void *)(kaddr))
 
-#define VM_DATA_DEFAULT_FLAGS \
-	(VM_READ | VM_WRITE | \
-	 ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
-	 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
-- 
2.45.2


