Return-Path: <linux-kernel+bounces-268734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC0942871
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90AE1F2417D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C808D1A76C3;
	Wed, 31 Jul 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPBDXhfD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC4318C91D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412624; cv=none; b=biyK1iONJQBA+WcfJFKneHbTwYZ0okeXUayJEIzG+t4iHrA22L5158zR5kWePucki+l7ryLyf+2mCvUNq5Ta4KPBh7pWvS/m44nmVH62LDj7gAbiuagnAaa7jep5fPNZvwJIpNh6/gH72zP7xHHloe6XrkIQin1ZSojtinszR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412624; c=relaxed/simple;
	bh=ozgdOpWtF81Hf/gEOh3bpv8GZZcV0210ozHrG8wclUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYUGJfSOvNDgDU5r9AIH4yutPLTpAkW/5NxzCeaYBSsYK3xv/csvO6qHwm3sbrO7uZ7sD8JUN4/f8SLmkcnwq9+j2t/THcHigOcX+iXOsgtBoIhhw6nS5qvmmJq34Ssaq9oG/aYtPIikiSedf7CAUpYj3Nn2Gz2Ew4Zfgo4I16g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPBDXhfD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722412621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9AaEcQYPcilFXNuPPHJ/dNKFao/QXRMpFdXw24PBoM=;
	b=ZPBDXhfDtzdU7cB3zdCLbk+zCO0Fl7bRYR+g7beY0RmvbOTrGGYkjDsx6DpJ5PTMRILq3u
	SaBncFX+YRMEwbdETHuNvjsuof8kAFenfMq4t/+nIueGpm1vyx+jHCO5ft9fnF3hZIsZbU
	Goz2j2h/OpWOuAPXONWit7f6JlrLVNw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-C2IrSy3XMNKsyP_OYuMCBQ-1; Wed,
 31 Jul 2024 03:56:58 -0400
X-MC-Unique: C2IrSy3XMNKsyP_OYuMCBQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20CE61955D4C;
	Wed, 31 Jul 2024 07:56:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.143])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0611B1955F3B;
	Wed, 31 Jul 2024 07:56:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 31 Jul 2024 09:56:56 +0200 (CEST)
Date: Wed, 31 Jul 2024 09:56:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: andrii@kernel.org, peterz@infradead.org, jolsa@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] uprobes: kill uprobe_register_refctr()
Message-ID: <20240731075651.GB12813@redhat.com>
References: <20240729134444.GA12293@redhat.com>
 <20240729134530.GA12318@redhat.com>
 <20240731143748.55bb97c1d68aea1f1946729d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143748.55bb97c1d68aea1f1946729d@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/31, Masami Hiramatsu wrote:
>
> OK, but it seems
>
> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>
> is still using uprobe_register_refctr().
>
> That should be updated too.

OOPS, thanks a lot :/

I'll send v3 with the additional change below in reply to 4/5 in a minute.

Masami, Peter, please let me know if you want me to resend the whole series.

Oleg.

--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -458,8 +458,8 @@ static int testmod_register_uprobe(loff_t offset)
 	if (err)
 		goto out;
 
-	err = uprobe_register_refctr(d_real_inode(uprobe.path.dentry),
-				     offset, 0, &uprobe.consumer);
+	err = uprobe_register(d_real_inode(uprobe.path.dentry),
+			      offset, 0, &uprobe.consumer);
 	if (err)
 		path_put(&uprobe.path);
 	else


