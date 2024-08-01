Return-Path: <linux-kernel+bounces-271224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2A944B3F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D78F1C22AED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0EB17084F;
	Thu,  1 Aug 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiDNtaYG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CEB1A01D2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515218; cv=none; b=Rr4u/DYBK/Og1qG1zMHOK4IZr3b/y4CbDRpJKmlmE10LNBwY+IgGT5IbiQWMHI51MNemkZtxFgKC6WhBFw7hzzO7H1okEuR7XanIUC4tR25F3HgGPls/FAjzvoLsm6ruBMyqfoBqZli1tKHlfsuR+OEgwJKFGvhPvVMe74VxmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515218; c=relaxed/simple;
	bh=XcvLHNXX85VbbLkLPMKUf8AGF87ba8yNC/NMs+hya9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5QE+koCjLTTmDkX70UMaT9G2bIZ8LO8sklcprgDWfv9GCNZq5CbGS2LTmIE3e8rH0SRY0x79srV3/kSQX4K/dvCpp6otvXdd3fnfnE2mA0c3ZDXf4eEL7qBcFhhCFPAkUctSpSCjWZSI6exx88Cx7wcFHEHE2zcAWEcMQXnw74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hiDNtaYG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722515215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I556GNNSFTcruYrde4O22fNzoauDeX94dYOFtVAsxjM=;
	b=hiDNtaYGNmIL6+f/2sTmOmZZA7rhs/t+vvV4eyMlJ9+pSxNfnDdk1AUkIvB9wy4bERI9/F
	n7iLZG2NQvxVXvrprFBHUdaABfUgQY/0jtRbGx/fmLrHyN6BJTOxfXwuXZLFIpD3vYqYi9
	KYwGBZbJXe3riynvOre99PUFtKpBrDs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-0_IwIwDlNE20avF-0sBnng-1; Thu,
 01 Aug 2024 08:26:51 -0400
X-MC-Unique: 0_IwIwDlNE20avF-0sBnng-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ECF219541AE;
	Thu,  1 Aug 2024 12:26:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CA5BF195605A;
	Thu,  1 Aug 2024 12:26:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 14:26:49 +0200 (CEST)
Date: Thu, 1 Aug 2024 14:26:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
	mhiramat@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <20240801122644.GC4038@redhat.com>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
 <ZqtyMTyu3uneHZDJ@krava>
 <20240801120018.GB4038@redhat.com>
 <Zqt8UPBC7zAWDMHD@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqt8UPBC7zAWDMHD@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/01, Jiri Olsa wrote:
>
> > Note the additional path_put() in testmod_unregister_uprobe(). Does it need
> > a separate patch or can it come with 5/5 ?
>
> I think it'd be better to have it separately, the test is already
> released.. so people might want to backport just the fix

OK, I'll rebase and add the patch below to v4. OK?

Oleg.
---

From f6bf42015048938d826880e3bf4a318bb64a05b4 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 1 Aug 2024 14:21:47 +0200
Subject: [PATCH] selftests/bpf: fix uprobe.path leak in bpf_testmod

From: Jiri Olsa <olsajiri@gmail.com>

testmod_unregister_uprobe() forgets to path_put(&uprobe.path).

Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 86babdd6f850..55f6905de743 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -477,6 +477,7 @@ static void testmod_unregister_uprobe(void)
 	if (uprobe.offset) {
 		uprobe_unregister(d_real_inode(uprobe.path.dentry),
 				  uprobe.offset, &uprobe.consumer);
+		path_put(&uprobe.path);
 		uprobe.offset = 0;
 	}
 
-- 
2.25.1.362.g51ebf55



