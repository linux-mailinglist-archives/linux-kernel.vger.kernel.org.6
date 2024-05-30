Return-Path: <linux-kernel+bounces-196048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FD08D567B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F97287551
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977C6183994;
	Thu, 30 May 2024 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="L5SYkMTM"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9855896;
	Thu, 30 May 2024 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112969; cv=none; b=KnhxYqEW7eTSO4pZ+I4vVySVlbBPj0FVRwj5p0Jeyt07OJMxWP1wm0aqtOzbvYXdRPLAgPVD6tJpiFeIHtevq72tprUSJoPh3Uq2qG054nwnOO4rxGF8wSl5VTJIvnL1ZY5GIlEyA7u+5rpSTodjtmrsvKzqic/FKthudPNpiqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112969; c=relaxed/simple;
	bh=K8dIsQu0nmeLV6mddz6oQkURdu5MyBjPLp4x3zFl6TI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpM0H684LCaaP8COaVhUWzMIR0nQSO+gwXW+wK/i36hjbWoo7OdLYGogV5V5bHpDabNjr1IpUioeRXudkmg8Q8B6vnZcuKVESJqVA8R5Mqt1wm3BscAcRcuVDHUutohcRHdf6hNzICjnVEjMKybYW2JFJkotlqIgb4IilvdNHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=L5SYkMTM; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Dk+304yr5ttSnAvIijtyTDdIPMk8uvEZjWNdQCZIpSw=; b=L5SYkMTMoFRR58zy
	TsuuQav0UnUiyqyYF1kipCaAnKApdar/8/GHu9E1cOnXvOFCTudOfqW/P7e/KhEcRJ+bhAJ461zSb
	AlpJ0B9wzXRbBz3O4kpLhWah7XwJzHVAgGReTItHfhobdQbqBZojncJs5OHB60ERzMrnKqEYv1wV1
	vqc5VmUmYZZw0Re/upZ97DGaIzZuQMO1th6NEvku3WyokAikTIXm29BtQkVL9JrsLaWX6lgkayIu7
	pZ7r5bTnncsJgTS1QhhCWCRyM6eJA5gJuF7tjNWrEgGFUZ6EZL8mwcqf9HlFBpmnPlpKUb4R0m85Q
	Bb6JlFB3aAvujcY2Rw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sCpWI-003Sye-2x;
	Thu, 30 May 2024 23:49:19 +0000
From: linux@treblig.org
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] fs: dlm: remove unused struct 'dlm_processed_nodes'
Date: Fri, 31 May 2024 00:49:18 +0100
Message-ID: <20240530234918.274511-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of 'dlm_processed_nodes' was removed in
commit 1696c75f1864 ("fs: dlm: add send ack threshold and append acks to
msgs").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/dlm/lowcomms.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 6b8078085e56..21bf23abed1a 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -858,12 +858,6 @@ static void free_processqueue_entry(struct processqueue_entry *pentry)
 	kfree(pentry);
 }
 
-struct dlm_processed_nodes {
-	int nodeid;
-
-	struct list_head list;
-};
-
 static void process_dlm_messages(struct work_struct *work)
 {
 	struct processqueue_entry *pentry;
-- 
2.45.1


