Return-Path: <linux-kernel+bounces-271350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E84944D25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8549E1C225D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2606E1A488A;
	Thu,  1 Aug 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wkvt4iL+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BAA1A4869
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518853; cv=none; b=pUb4KrAilpXtT+QzCH0+i89PISp3Cenz6LjhQA1mVf/C8JOZLNEcxWZ5kJWWbzIDAnOanJcsNXhDzzOCjDUBPgy0jCqMZNPUtvlMdE2J4hwiGlK4nWyzv/bUnAdzhH7pbXtQHSdjVBRx9HBabUEwCqJgnoApju8FqmUZTSff8rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518853; c=relaxed/simple;
	bh=cJHxUGN9/LWI0k9HPa7MWjvT/03JscJ4GhmSQM42L48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iOzn5LpqfHkMdMyT12GXfqRD/bejCztbNrLj74Xv9qFyXB35aTMaR8pYMlAf4Smy2D59cho74iGOsGHVe6m0ns6KaFrHZA9Adt+9IgrjzU5vbWsvnnkD43EMfyd0pLjk7/NoFGZsEk6R8jI9/YOxk0+VeEOHk3vias2hM/CSEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wkvt4iL+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=raWFWXmAUk4l+U5Lup2bkwyOzvSkCVvQRNTfdXYX4I8=;
	b=Wkvt4iL+DfmVMYNx3Ieb+fXjzfiYSvbUDK4DmTW15em7SY9Zb7efgBAwx4ltTS2tD/ZTlD
	4Wa7JP3IjuHo027/A4lJoGy0o0Edm3/OlKQruInJIQPbPokGGd8n+K0HMzUX6HzTQ+SVMg
	+XIW2NiNH9BNHRW+vDlQnC3NIkHA/7E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-Tsbu-b6SPnaEItxp2Y7PzA-1; Thu,
 01 Aug 2024 09:27:29 -0400
X-MC-Unique: Tsbu-b6SPnaEItxp2Y7PzA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 683541955D4F;
	Thu,  1 Aug 2024 13:27:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9A28819560AA;
	Thu,  1 Aug 2024 13:27:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:27:28 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:27:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] selftests/bpf: fix uprobe.path leak in bpf_testmod
Message-ID: <20240801132724.GA8791@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801132638.GA8759@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Jiri Olsa <olsajiri@gmail.com>

testmod_unregister_uprobe() forgets to path_put(&uprobe.path).

Signed-off-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index fd28c1157bd3..72f565af4f82 100644
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


