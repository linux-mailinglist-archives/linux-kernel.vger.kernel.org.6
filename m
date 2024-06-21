Return-Path: <linux-kernel+bounces-224608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E7B9124B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885851C24C91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC99174EE5;
	Fri, 21 Jun 2024 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqIgWOmx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BC0174EE1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971415; cv=none; b=nze6aYu4Y8A0u8VCY+qwbFk4TxbKUQENEG8yMgG1V3nVJkJ2gHjTIWNjZlYUZrNXVnscUMPmdB1+b6ogz9GqvKsQFufKX4assfoeZXCsEd7w7eCVaouB3RzB3/drcF4E81WC5S0dsyTQU4aH83bn7hyhwUcQscxd68iigbUfUz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971415; c=relaxed/simple;
	bh=UZQ7ofngdkPglX7uUAUMRfKyQGTHYQz14H/4NkfLPRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNWHC7OqbUI8pvQsAYFJxxwH9oxH6r2RrFaFqBWHRNsl75zo/vMOeshr1ILZ7eQq6ZmNVuvRIv4d8xTSIN4iQH+q5QFRFIy92GGkDNB07KBAZqL48/fso+K190Wi1RjJD5PidB6oPIPCfqurd4O/sl7vRpCt1SXyKl2BG5XCXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZqIgWOmx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718971412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsSGOB1HODYWe+7tXlzHZdd/rZJ23wX0Crrt14uZIPg=;
	b=ZqIgWOmxfqWBWWLvQZF7J9q70DPhRnwvgvUQqM3qnwoQPHEA8NHSUYaH/Ks6JXgl9m0wi1
	ifAUnb7U2wtuXNFbxOTunri4cU0Y2FfO1Op1+3hYA1RrH4lVkh1snI9j13EqB2vmjrQ/HO
	T/7WHKqz6wToBO1VWczIIZXqpWegpcw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-pGFMVH7WPjudccqAGfG9Ag-1; Fri,
 21 Jun 2024 08:03:28 -0400
X-MC-Unique: pGFMVH7WPjudccqAGfG9Ag-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF22E19560AD;
	Fri, 21 Jun 2024 12:03:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 146E01956053;
	Fri, 21 Jun 2024 12:03:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 21 Jun 2024 14:01:55 +0200 (CEST)
Date: Fri, 21 Jun 2024 14:01:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] uprobe: Do not use UPROBE_SWBP_INSN as static initializer
Message-ID: <20240621120149.GB12521@redhat.com>
References: <20240618194306.1577022-1-jolsa@kernel.org>
 <CAEf4BzbN4Li2iesQm28ZYEV2nXsLre8_qknmvkSy510EV7h=SA@mail.gmail.com>
 <20240620193846.GA7165@redhat.com>
 <CAEf4BzaqgbjPfxKmzF-M7nzGroOwKikA0BM7Tnw7dKzKS+x9ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaqgbjPfxKmzF-M7nzGroOwKikA0BM7Tnw7dKzKS+x9ZQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 06/20, Andrii Nakryiko wrote:
>
> On Thu, Jun 20, 2024 at 12:40 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > But I can't understand what does it do, it calls emit_break() and
> > git grep -w emit_break finds nothing.
> >
>
> It's DEF_EMIT_REG0I15_FORMAT(break, break_op) in
> arch/loongarch/include/asm/inst.h
>
> A bunch of macro magic, but in the end it produces some constant
> value, of course.

I see, thanks!

Then perhaps something like below?

Oleg.


--- x/arch/loongarch/include/asm/uprobes.h
+++ x/arch/loongarch/include/asm/uprobes.h
@@ -9,7 +9,7 @@ typedef u32 uprobe_opcode_t;
 #define MAX_UINSN_BYTES		8
 #define UPROBE_XOL_SLOT_BYTES	MAX_UINSN_BYTES
 
-#define UPROBE_SWBP_INSN	larch_insn_gen_break(BRK_UPROBE_BP)
+#define UPROBE_SWBP_INSN	(uprobe_opcode_t)(BRK_UPROBE_BP | (break_op << 15))
 #define UPROBE_SWBP_INSN_SIZE	LOONGARCH_INSN_SIZE
 
 #define UPROBE_XOLBP_INSN	larch_insn_gen_break(BRK_UPROBE_XOLBP)
--- x/arch/loongarch/kernel/uprobes.c
+++ x/arch/loongarch/kernel/uprobes.c
@@ -7,6 +7,13 @@
 
 #define UPROBE_TRAP_NR	UINT_MAX
 
+static __init int __ck_insn(void)
+{
+	BUG_ON(UPROBE_SWBP_INSN != larch_insn_gen_break(BRK_UPROBE_BP));
+	return 0;
+}
+late_initcall(__ck_insn);
+
 int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
 			     struct mm_struct *mm, unsigned long addr)
 {


