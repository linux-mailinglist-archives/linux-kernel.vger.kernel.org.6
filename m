Return-Path: <linux-kernel+bounces-282245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1910A94E149
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E3C1F21322
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8E136321;
	Sun, 11 Aug 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQ+OqwyH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2213210A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723381115; cv=none; b=eVOlelng90IV+TEeZqqBVJzH4M1cRCj1k5o5o3p808TZ3ntQKa+eKDSPkavdL32WlZsqGXRTZZp2idc3bgKN+bwVpi9x3YUT/BuWd7vty3cX+e53q0Qjum+UqHehE03ZtCe0GgsanjVrGqlFXwPAX1ukQaAMeSNZhTx0eiaUMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723381115; c=relaxed/simple;
	bh=SmUBeweGlG9h1e+KLfkVevn7xSXjum33hgn8pIpdjmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEs1BU9Tsb8peLl2eU/E2RN8NpJ6uynFpvOnqXeOfqu7Z/cTrgEU7Ie20/RJKKlAm/k0sfsddC2Nok/rE33DxBwJEu0ontd188EvnfyWNbEIyQTknhHfv1RTJY4y4ETMuTbQGnrAPhLXZ0gsSWi2uS29LIHw3bsBDHSbwFnP+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YQ+OqwyH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723381112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2HguoHPzRVuxUUDp+trnORIi63m6XbTZ+IAUIpDVOo=;
	b=YQ+OqwyHbzuYGtxnEePWPjlqnzcYTZmWcuZYlCcQOiQuB4M+ANnnRcThEtoX80YEvYNJOU
	qgxMG/MN2VWSWsmyoV9cgMCUBDjOkRbmgsyKNdM+mgiZLsARDjU6oy2dScUdKrYC2VRFFf
	6r2a2cLbrdW+qtooMKlool3UJioCVYs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-jNUMuJw3OOmvrNzKhFvErg-1; Sun,
 11 Aug 2024 08:58:29 -0400
X-MC-Unique: jNUMuJw3OOmvrNzKhFvErg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD68E19560A6;
	Sun, 11 Aug 2024 12:58:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8400D1955F3A;
	Sun, 11 Aug 2024 12:58:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 11 Aug 2024 14:58:24 +0200 (CEST)
Date: Sun, 11 Aug 2024 14:58:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
	mhiramat@kernel.org, mingo@redhat.com, namhyung@kernel.org,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com,
	andrii@kernel.org
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in
 __uprobe_unregister
Message-ID: <20240811125816.GC30068@redhat.com>
References: <000000000000382d39061f59f2dd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000382d39061f59f2dd@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/10, syzbot wrote:
>
> syzbot found the following issue on:
>
> HEAD commit:    6a0e38264012 Merge tag 'for-6.11-rc2-tag' of git://git.ker..
> git tree:       upstream

#syz test: upstream 6a0e38264012

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..5d9c96c69733 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3485,17 +3485,19 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 					     uprobes[i].ref_ctr_offset,
 					     &uprobes[i].consumer);
 		if (err) {
-			bpf_uprobe_unregister(&path, uprobes, i);
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
+	bpf_uprobe_unregister(&path, uprobes, i);
+
 error_free:
 	kvfree(uprobes);
 	kfree(link);


