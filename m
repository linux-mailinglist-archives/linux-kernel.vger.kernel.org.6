Return-Path: <linux-kernel+bounces-208226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7849390229C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA2F2839A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCE284DE0;
	Mon, 10 Jun 2024 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXYPwALG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A323E82889
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025806; cv=none; b=CXSTXccoCD+gRsZ2szu+FZyIhfS0L+ZMYNPQrNQ187ucSIFD9Q1y19N+0cFZjepe6sFcd1QzNAKP4vfkOkrBz+wuz4u/W77fCyng+OUMGCipQkRYk8PIx7B+x3Zaq5zTd734gBp++IraBd/YvFbuaNA/anB93aVoJeMhkq0+/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025806; c=relaxed/simple;
	bh=YhHZtXtYOeqPDpUQzggSLYgS7dOxECQ9WBN80nvz9pU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HUF1DFNJepv5FMlUEjFgoq6PeG262/Q+Kzwd/4AqlnwD6ie0JtIOfpdnG+CjK9HwTRsNecRjj3p7J14aaj7KAwUMNPLK9BLZXKVascxah8Aq4n4MeAMv2eCl0CxxalWs7JHsFCorEl0sp2l0wqiDVrV6Y/1xLEQzxGFZvn64jnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXYPwALG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718025803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=HZ01OIp6KO6+A3DggujUXEq6vyWDZMFmW9tQ8SBohTE=;
	b=QXYPwALGXYn9M4BU1PJUwlh6GPVKcndciLR/hmMyhjnmB1cV0nvkM+VMB9MhYKsvlOAx+J
	v17953b4iVvSvDG0MNZ7hiNU0BsbivHVsDuFiaURC/oIgdbEO9aJRTvJUlt6ftCgvnBQZj
	IkhFLohe+i0M4GX4NC6BWd9OCh40cpQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-9f1Rr8QsMCW28P4hg_Jl7w-1; Mon,
 10 Jun 2024 09:23:18 -0400
X-MC-Unique: 9f1Rr8QsMCW28P4hg_Jl7w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE0B81955D74;
	Mon, 10 Jun 2024 13:23:16 +0000 (UTC)
Received: from localhost (unknown [10.22.8.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5F1B19560AB;
	Mon, 10 Jun 2024 13:23:15 +0000 (UTC)
Date: Mon, 10 Jun 2024 10:23:14 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] rtla/osnoise: set the default threshold to 1us
Message-ID: <Zmb-QhiiiI6jM9To@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Change the default threshold for osnoise to 1us, so that any noise
equal or above this value is recorded. Let the user set a higher
threshold if necessary.

Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Reviewed-by: Clark Williams <williams@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 Documentation/trace/osnoise-tracer.rst | 2 +-
 kernel/trace/trace_osnoise.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 140ef2533d26a..a520adbd34765 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -108,7 +108,7 @@ The tracer has a set of options inside the osnoise directory, they are:
    option.
  - tracing_threshold: the minimum delta between two time() reads to be
    considered as noise, in us. When set to 0, the default value will
-   be used, which is currently 5 us.
+   be used, which is currently 1 us.
  - osnoise/options: a set of on/off options that can be enabled by
    writing the option name to the file or disabled by writing the option
    name preceded with the 'NO\_' prefix. For example, writing
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a8e28f9b9271c..66a871553d4a1 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1444,9 +1444,9 @@ static int run_osnoise(void)
 	save_osn_sample_stats(osn_var, &s);
 
 	/*
-	 * if threshold is 0, use the default value of 5 us.
+	 * if threshold is 0, use the default value of 1 us.
 	 */
-	threshold = tracing_thresh ? : 5000;
+	threshold = tracing_thresh ? : 1000;
 
 	/*
 	 * Apply PREEMPT and IRQ disabled options.
-- 
2.45.2


