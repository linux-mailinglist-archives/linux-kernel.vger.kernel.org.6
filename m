Return-Path: <linux-kernel+bounces-232792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26F491AE52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528661C23032
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6922D19ADA8;
	Thu, 27 Jun 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIBGGjOv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245A1865A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509995; cv=none; b=e17VYMzGiNb+j14cbznQouq/6+VcqJ9R90swM3/YwyGu7GDcyRH2Udxkj6PXzFP9nEazm+gJlkNNkm5XAG4RjUbort+wuzGRPzJG1JlLPu1YQVn1F+LJ0jDk5UR8HKur7tYWai90DmQlOxXwF4XrIVkqnN6HXBCb16yYmuwB8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509995; c=relaxed/simple;
	bh=M1Pr/ccqxR64Qy5pX519WkVfLnUUaSq7Qjbum1LSRes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgMLMJCXEr0/5ObXLykPtjeLvfO4J9S52qKFPVDHoRFR0fJnkL+U4IxtOmYdKFDfS3kI/Ueu1gyBtmMBXxiSQ4DTu9FSyO14cOtT+N/RXV7DPGalo5gn3EkMDuNRisDq0CJtb1GPPmi7zUFYO8MacTvl1hmN9nIEpdBXgZF/EW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BIBGGjOv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719509993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=34BYMyGoC6lX3CxmLrEw2DjPDGR7811PFr+ZC7aQ/ZU=;
	b=BIBGGjOv82g28vIyG0Yi7R1mJiZcTWyw+j9AItF79U9oqtDV/bsj6g7RYbZFB2iw7SStaS
	Rae4SVqQRGWOQ7d5xBUuofZ/LCEOml/vAYvFZCCJM8Y3BG++P5SnqUWN7GHJraxzQdaGgm
	ZSGQO/B7POCAbUE4SswZ2phFMrO0U34=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-sTRvXhL3ML203UbvsHfRAA-1; Thu,
 27 Jun 2024 13:39:49 -0400
X-MC-Unique: sTRvXhL3ML203UbvsHfRAA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D9E2195608A;
	Thu, 27 Jun 2024 17:39:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5297819560AA;
	Thu, 27 Jun 2024 17:39:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 27 Jun 2024 19:38:12 +0200 (CEST)
Date: Thu, 27 Jun 2024 19:38:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Jiri Olsa <jolsa@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH] LoongArch: uprobes: make
 UPROBE_SWBP_INSN/UPROBE_XOLBP_INSN constant
Message-ID: <20240627173806.GC21813@redhat.com>
References: <20240618194306.1577022-1-jolsa@kernel.org>
 <20240627160255.GA25374@redhat.com>
 <CAEf4BzZVmKjfQD1zKMDOD-Zc4pVp+EGgb8h2veg=bXe1Pjn_Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZVmKjfQD1zKMDOD-Zc4pVp+EGgb8h2veg=bXe1Pjn_Uw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/27, Andrii Nakryiko wrote:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks!

> > --- a/arch/loongarch/kernel/uprobes.c
> > +++ b/arch/loongarch/kernel/uprobes.c
> > @@ -7,6 +7,14 @@
> >
> >  #define UPROBE_TRAP_NR UINT_MAX
> >
> > +static __init int check_emit_break(void)
> > +{
> > +       BUG_ON(UPROBE_SWBP_INSN  != larch_insn_gen_break(BRK_UPROBE_BP));
> > +       BUG_ON(UPROBE_XOLBP_INSN != larch_insn_gen_break(BRK_UPROBE_XOLBP));
> > +       return 0;
> > +}
> > +arch_initcall(check_emit_break);
> > +
>
> I wouldn't even bother with this, but whatever.

Agreed, this looks a bit ugly. I did this only because I can not test
this (hopefully trivial) patch and the maintainers didn't reply.

If LoongArch boots at least once with this change, this run-time check
can be removed.

And just in case... I didn't dare to make a more "generic" change, but
perhaps KPROBE_BP_INSN and KPROBE_SSTEPBP_INSN should be redefined the
same way for micro-optimization. In this case __emit_break() should be
probably moved into arch/loongarch/include/asm/inst.h.

Oleg.


