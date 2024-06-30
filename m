Return-Path: <linux-kernel+bounces-235098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9712591D026
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F13AB213B4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 06:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAF039AF4;
	Sun, 30 Jun 2024 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bg2FGpKP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11BD1362
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719729068; cv=none; b=UxFPGPs9ZE/9fea5LAu8HhsKUKPlO+IMV7chiuW6z0IjpVVibRQ+qS6ZFtrSpiyYM2WUDuzxK3AC7SMmqzzNOrfk2ZUMKB5cu7I1LlMGJvxWKzhSSC2tfRnnlv8w6KLQd6wEqu8b8J9JZ7zmqYsgszcHnBsHxV5d/YUjPtCiE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719729068; c=relaxed/simple;
	bh=nFsORew67a/rZmPX+lXujxGMRL3SU/JD61ZaOMlF6oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egvHkaQl2ZMbXmeJ91CAbnVVELzlpVFeUGTokl1hiULJHZJtx6SEODIZHXHJLe9wMH7NW3nkZnDwCAiJ67/F00pP2vR6qkNc35k8x2ljKm6GmgpbBE0U5cKhOLtHE8Y2H8waRf8xUEhMLQqr6ExOYgTy/5Pajp2otWk0pL7v7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bg2FGpKP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719729063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UrQLQYs/c1TN4fMfLr0qEglsctNmbRE0xMqs8gdbCqs=;
	b=bg2FGpKP5fT8vVDPnMwku5E+sIYRE/YmQwzbFoGY7pBgXT4BGRDAr+NomYotg5zTwmaC1f
	Y5YaE0QoVDVwBdVuF5J5zEmcDwKjZS4S+dBlFZqYyrKi5kC+qApzBcippEmdTCMJZF5YFU
	xY4NNLKbi1dME+UcR99Ig9/hju4e48Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-j6yIIMv6NYm2wG_F9dmPjw-1; Sun,
 30 Jun 2024 02:31:00 -0400
X-MC-Unique: j6yIIMv6NYm2wG_F9dmPjw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19AF619560A2;
	Sun, 30 Jun 2024 06:30:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.11])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C87301955E80;
	Sun, 30 Jun 2024 06:30:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 30 Jun 2024 08:29:22 +0200 (CEST)
Date: Sun, 30 Jun 2024 08:29:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, andrii.nakryiko@gmail.com,
	andrii@kernel.org, bpf@vger.kernel.org, jolsa@kernel.org,
	kernel@xen0n.name, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	mhiramat@kernel.org, nathan@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH] LoongArch: make the users of larch_insn_gen_break()
 constant
Message-ID: <20240630062916.GA11898@redhat.com>
References: <20240627173806.GC21813@redhat.com>
 <37f79351-a051-3fa9-7bfb-960fb2762e27@loongson.cn>
 <20240629133747.GA4504@redhat.com>
 <CAAhV-H4tCrTuWJa88JE96N93U2O_RUsnA6WAAUMOWR6EzM9Mzw@mail.gmail.com>
 <20240629150313.GB4504@redhat.com>
 <CAAhV-H4HtRkn1i9pxBojEmzWPysqq=mScoP6PYzZ6v29v2WYoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4HtRkn1i9pxBojEmzWPysqq=mScoP6PYzZ6v29v2WYoQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/30, Huacai Chen wrote:
>
> > +static __init int check_emit_break(void)
> > +{
> > +       BUG_ON(UPROBE_SWBP_INSN  != larch_insn_gen_break(BRK_UPROBE_BP));
> > +       BUG_ON(UPROBE_XOLBP_INSN != larch_insn_gen_break(BRK_UPROBE_XOLBP));
> > +       return 0;
> > +}
> > +arch_initcall(check_emit_break);
> Do you mind if I remove the runtime checking after Tiezhu tests the correctness?

Sure, please remove, thanks.

Oleg.


