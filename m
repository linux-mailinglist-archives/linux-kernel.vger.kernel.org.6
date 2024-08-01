Return-Path: <linux-kernel+bounces-271196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDAC944AB4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740231F23461
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B734189B8E;
	Thu,  1 Aug 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuFES66M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCFB187FF8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722513631; cv=none; b=YsR1AwGv+fiXME+MUHVXuh6cPuda7JFzZc1+cQw1sK+sDX3lhy0upG7S5naHrQVGKxMQI6kJJXMRh95fiLdCGqAeug1Y3H6NGstVmotrrD75lodJ2hrZzTQmnFABNskNClKofBgfXlPi8Gk+nvZqT4Lo1lX/4UnMJmhtdt1f2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722513631; c=relaxed/simple;
	bh=HZp0LPfhGhp6ZGeeQrHMrd0xhkPMxyhHrAmQ3qR+En0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtD/0LWc34KwihG5CkihV32lmNC/gxkYuhy5xkf+HEnvgZ7qrGBkhFEMw/YHrDK+nr1zuY5+1dBqW39E8I7vxF6qnZ1kn1oiW/KREy9NRkj50xew7dB3eABuqMC0m3QaSTxC2byagrz9fF6eRAdRzPJFVSMNot5OaMYLYdVZCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuFES66M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722513628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lWAhUKXXckXhcLX44xCXJ5w9jF0jjFi9RLxblI/y9CU=;
	b=AuFES66MQmJRjcrU8SAd7XtgCh2uHjsgjeAuRo/a9/ebDVuss8wn9cHckWK1UD99yU2pcf
	jN8hUjfuiCv6WWDhEv28s+8ZoYzB5SDVQiMCzCygQxxNonAHRFus40YBrSmeYEL34XuwQ5
	81w7aWGFo9OQgJ13oQ/+4Oomve+3qqI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-5H97hCAaPbStNuHVz5BwhA-1; Thu,
 01 Aug 2024 08:00:26 -0400
X-MC-Unique: 5H97hCAaPbStNuHVz5BwhA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6D5E1955BF6;
	Thu,  1 Aug 2024 12:00:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 52B603000199;
	Thu,  1 Aug 2024 12:00:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 14:00:23 +0200 (CEST)
Date: Thu, 1 Aug 2024 14:00:18 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
	mhiramat@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <20240801120018.GB4038@redhat.com>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
 <ZqtyMTyu3uneHZDJ@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqtyMTyu3uneHZDJ@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/01, Jiri Olsa wrote:
>
> > @@ -474,10 +477,10 @@ static void testmod_unregister_uprobe(void)
> >  {
> >         mutex_lock(&testmod_uprobe_mutex);
> >
> > -       if (uprobe.offset) {
> > -               uprobe_unregister(d_real_inode(uprobe.path.dentry),
> > -                                 uprobe.offset, &uprobe.consumer);
> > +       if (uprobe.uprobe) {
> > +               uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
> >                 uprobe.offset = 0;
> > +               uprobe.uprobe = NULL;
>
> ugh, I think we leak &uprobe.path.. I can send follow up fix if needed

Yeah, with or without this change. And with this change we do not need uprobe.offset.

Please see the patch below, this is what I've added to 5/5.

Do you see any problems?

Note the additional path_put() in testmod_unregister_uprobe(). Does it need
a separate patch or can it come with 5/5 ?

Oleg.

--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -432,7 +432,7 @@ uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
 
 struct testmod_uprobe {
 	struct path path;
-	loff_t offset;
+	struct uprobe *uprobe;
 	struct uprobe_consumer consumer;
 };
 
@@ -446,25 +446,25 @@ static int testmod_register_uprobe(loff_t offset)
 {
 	int err = -EBUSY;
 
-	if (uprobe.offset)
+	if (uprobe.uprobe)
 		return -EBUSY;
 
 	mutex_lock(&testmod_uprobe_mutex);
 
-	if (uprobe.offset)
+	if (uprobe.uprobe)
 		goto out;
 
 	err = kern_path("/proc/self/exe", LOOKUP_FOLLOW, &uprobe.path);
 	if (err)
 		goto out;
 
-	err = uprobe_register(d_real_inode(uprobe.path.dentry),
-			      offset, 0, &uprobe.consumer);
-	if (err)
+	uprobe.uprobe = uprobe_register(d_real_inode(uprobe.path.dentry),
+					offset, 0, &uprobe.consumer);
+	if (IS_ERR(uprobe.uprobe)) {
+		err = PTR_ERR(uprobe.uprobe);
 		path_put(&uprobe.path);
-	else
-		uprobe.offset = offset;
-
+		uprobe.uprobe = NULL;
+	}
 out:
 	mutex_unlock(&testmod_uprobe_mutex);
 	return err;
@@ -474,10 +474,10 @@ static void testmod_unregister_uprobe(void)
 {
 	mutex_lock(&testmod_uprobe_mutex);
 
-	if (uprobe.offset) {
-		uprobe_unregister(d_real_inode(uprobe.path.dentry),
-				  uprobe.offset, &uprobe.consumer);
-		uprobe.offset = 0;
+	if (uprobe.uprobe) {
+		uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
+		path_put(&uprobe.path);
+		uprobe.uprobe = NULL;
 	}
 
 	mutex_unlock(&testmod_uprobe_mutex);


