Return-Path: <linux-kernel+bounces-282238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE5C94E13B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640591F22ECB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9AE6E613;
	Sun, 11 Aug 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwdejKFq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7FEEBA
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723379725; cv=none; b=UHnj4BB9u4KgjipevRoCEc6KIt9UBKCuggCZeGOT83/IV4jIXy44XkEF2Pm4K/KOdeaqlXnSz3G2k7Z00bTOqyF42eC/nMNOlEP+Ypi1zVNPc8aWq184KcpViyD0pC0FSkcca9cxI8okEJaMQTNcrHUxKMueS5Q70J5dye0rt0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723379725; c=relaxed/simple;
	bh=8HbDmLL+NTBeeBc0mZ30qbLS+R+pE60UQRFzXh0Qd40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh7VfQ3uD4aaMPxcoOZDHYtUOgSYNgSFtGYMFLL9wZFxxnp8PvO91pUYUGM4tt2oFmzy2KC9Bud8a+UT5HkxrHR6sKtQbqnwEwAE8NouvUCjKi2qdAMPdYARCuMps97aOLnrb9Wk1h2vR72LDCeiTY6POczX98HRCWpCOd0PyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwdejKFq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723379723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHlXnDYMSxlvXOLG5yqCHeaThdF+GjL3IUfr75SJ08A=;
	b=QwdejKFqstZJ3IQVwuxcVECdxajgN4VPQ6CvqDnatw8d5psJrV6pjb7WCQ0thr0A7bzKnd
	psMgmXkKAIfksVD5Okagrr6TNqOc9zMr/1luQRkgeJILjYlK0+F9iym7LLoe237aX1lbLK
	9n9ABL6gxgSedNVsggq3esAjoT+sSaU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-H9lsxKNuPV-qWIxBFCY7Sg-1; Sun,
 11 Aug 2024 08:35:16 -0400
X-MC-Unique: H9lsxKNuPV-qWIxBFCY7Sg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ABCF195609E;
	Sun, 11 Aug 2024 12:35:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1F5A219560AE;
	Sun, 11 Aug 2024 12:35:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 11 Aug 2024 14:35:11 +0200 (CEST)
Date: Sun, 11 Aug 2024 14:35:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, jolsa@kernel.org
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
	mhiramat@kernel.org, mingo@redhat.com, namhyung@kernel.org,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in
 __uprobe_unregister
Message-ID: <20240811123504.GB30068@redhat.com>
References: <000000000000382d39061f59f2dd@google.com>
 <20240811121444.GA30068@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811121444.GA30068@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/11, Oleg Nesterov wrote:
>
> Hmm, bpf_uprobe_multi_link_attach() looks obviously wrong.
>
> bpf_link_prime() is called after the
>
> 	for (i = 0; i < cnt; i++) {
> 		uprobe_register(...);
> 		...
> 	}
>
> loop. If bpf_link_prime() fails, bpf_uprobe_multi_link_attach() just do
> kvfree(uprobes) without _unregister(). In particular, this leaks the freed
> bpf_uprobe->consumer in the uprobe->consumers list.
>
> After that another _unregister() on the same uprobe can hit the problem.
>
> I guess we need a simple patch for -stable...

Something like below on top of perf/core. But I don't like the usage of
"i" in the +error_unregister path...

Oleg.

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3486,17 +3486,19 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 						    &uprobes[i].consumer);
 		if (IS_ERR(uprobes[i].uprobe)) {
 			err = PTR_ERR(uprobes[i].uprobe);
-			bpf_uprobe_unregister(uprobes, i);
-			goto error_free;
+			goto error_unregister;
 		}
 	}
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-		goto error_free;
+		goto error_unregister;
 
 	return bpf_link_settle(&link_primer);
 
+error_unregister:
+	bpf_uprobe_unregister(uprobes, i);
+
 error_free:
 	kvfree(uprobes);
 	kfree(link);


