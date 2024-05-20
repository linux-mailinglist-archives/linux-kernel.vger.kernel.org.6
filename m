Return-Path: <linux-kernel+bounces-184089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333008CA26A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA51D282299
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCB71386D5;
	Mon, 20 May 2024 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwwEU0bS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6011386C0
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231505; cv=none; b=TDDo994CRfXEk9uf5dprw9h+2T7LVJVM/GKrShkDapvbNrjJQnmYMf6tJIlm3/djr9Ev43YZ53L1VHuph6p6HaXtbqjQxQ5qzbO5MbBsdXtS89IRblvPpE850Wkeaes1yi9WKkvcgQAiNHct8F/uaVYSO8UUfSra93jz49ys9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231505; c=relaxed/simple;
	bh=a+eA01vjVkP3G5nFgnuhnP1gKtaM1FSkoDTcoDq1BTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRaX34S3/EfcQbnsEu8C/I3Fm05Egn8M/qGQMbYLjLJngQ0VCpPCFoLwPmwOTZfUTLIHfz+P9T6qWKkFusQpl5pfNGDyLThwzSaZXezDm4MJ36BSGdRgwRSV/3LtPmYMUt5RASgf8P8LoCbSEpgkK05osGDvFUfgQPH6nmwJhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwwEU0bS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716231502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dl4+SLBeFPnriuBwYnryUMkurFVrv5hxlqLG9E31XsI=;
	b=RwwEU0bSJXYp1EC+3hHFi7mgUhXR6wrvbRADnZyvXv6jzmagPROI+2dSbqIPY+RtOJaahz
	FWeh0KRNZV/VComDi23cFoJPw8EErJnGLsvtl3Sq/OqbWHydWO4DGkdIRFOspg3nVRVfTr
	3UuRInXhsifx84lkcEZqAAROOro7KZE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-tnOtF_v7M-ide5nKun1KlQ-1; Mon, 20 May 2024 14:58:19 -0400
X-MC-Unique: tnOtF_v7M-ide5nKun1KlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51AFA101A525;
	Mon, 20 May 2024 18:58:18 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw.eng.bos2.dc.redhat.com [10.26.1.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2BDBA200A78F;
	Mon, 20 May 2024 18:58:18 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: linux-pm@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/power turbostat: make the '-n' command line argument work in all cases
Date: Mon, 20 May 2024 14:57:49 -0400
Message-ID: <20240520185749.1404283-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

In some cases specifying the '-n' command line argument will cause
turbostat to fail.  For instance 'turbostat -n 1' works fine; however,
'turbostat -n 1 -d' will fail.  This is the result of the first call
to getopt_long_only() where "MP" is specified as the optstring.  This can
be easily fixed by changing the optstring from "MP" to "MPn:" to remove
ambiguity between the arguments.

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 98256468e248..8071a3ef2a2e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -7851,7 +7851,7 @@ void cmdline(int argc, char **argv)
 	 * Parse some options early, because they may make other options invalid,
 	 * like adding the MSR counter with --add and at the same time using --no-msr.
 	 */
-	while ((opt = getopt_long_only(argc, argv, "MP", long_options, &option_index)) != -1) {
+	while ((opt = getopt_long_only(argc, argv, "MPn:", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'M':
 			no_msr = 1;
-- 
2.44.0


