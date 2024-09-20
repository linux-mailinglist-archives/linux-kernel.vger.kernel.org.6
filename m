Return-Path: <linux-kernel+bounces-334646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9397D9E5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 21:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCEB2281DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6F2183CBC;
	Fri, 20 Sep 2024 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b="Sz1sSA+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aVhnpkfV"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D62C182
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726861347; cv=none; b=Ez14TNmw57IEzWBZiS10aeq6UgtLEDbpS+WdWYlnCwE3Tr1YyBS0dVedD3FMyrWAshkoYvLFALzeTGgq+dXB0qA5H7fE9Xz1SRtKWCsS0mLjY+WaOlZwJxR/waNXQ1QMiNvbdWfk02I+5bg5bgOfh54crCE6dl4Y9vH/eFJe+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726861347; c=relaxed/simple;
	bh=0d+ngeOV3PPIEBpxgmYidnXdTN+vwdYqtbOfBcvymr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/3nn3SgPw9pB7AYwyFNbqi8ShWxmNsfa7I3mZPYQ6gE3gjzvIy6SbA4vGectQhLGR6fwqKfqoekJP7XxmGpotB8JhLbBwfvw7UHbgS/QGQTSoRhJypZIxkIcmCo9D0w7uDMndgWruNOVC63VRJyJgMQ4wjZ5AwR/ExnaMXaPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=likewhatevs.io; spf=pass smtp.mailfrom=likewhatevs.io; dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b=Sz1sSA+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aVhnpkfV; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=likewhatevs.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=likewhatevs.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15C6A1140130;
	Fri, 20 Sep 2024 15:42:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 20 Sep 2024 15:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=likewhatevs.io;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1726861344; x=1726947744; bh=bgq26nbpKb
	bM06E+fkGy095KLGjrXL51DF74gzlT3cg=; b=Sz1sSA+KmtwKhrN6eDkRUO17f2
	9x/BivLpLO4U0OL+p/6wN7PRutthrz9ndrwM1mB1W1ykoibprV1fktZV6rULMp0e
	3Ug0XOrC6YRyVWs/vYc6Pk7c9WcShSg+eIaaNXwbbfIelbwRA+RpeZIJR0Ya/nQA
	cXRKAJ3ryw5VTKbpF3/65GREP8dNAp6hGKi7zBSxmMdpZNeDDZquynfKavAVykgr
	PmUCP++i0BC1xwN3qS9KzwzAp5dssznFfQKy4R4sdW0NfCxprqy/md4ddriMyqWK
	dDJ4TfHQ6nkiLP/5JSYg/rr88CD71XndFMczihk9jXD83lYKfFmh/FhM3L0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1726861344; x=1726947744; bh=bgq26nbpKbbM06E+fkGy095KLGjr
	XL51DF74gzlT3cg=; b=aVhnpkfVNtjbM8FDgmYo9Entxl6Q01/FEhVysL3rUMp9
	Va/DZYZd09RXQ8bAiphdHtLrZbEPWpjJYFBgxg5ncPwccUj7qF5Ear2ARgjMHZbl
	ydw3cpQRqF97wlzodjldLooWfFwI6KnMPGh/hoFhOud6ug6N5WjYg49c5m7dPQCf
	m52r/8izjqQ14rWhPRkGoorCPyaRDNGwn+8fCt3gXBm4RQsSJM+6zGFEPJ+S/1yI
	uzmA3CreioOuMKXpo/0bX1BDVX9gplZsr3KSdskBygxpIGJr8RIunmSbGOxFbZF/
	g09TTpHTYertzWvBebVKQvpgAhKFsjA/EbRUC34//Q==
X-ME-Sender: <xms:H9DtZuIBmgyP1tfyN0tl3tkf2c1LC5KleOKVkJQBt-btwPzwDSWDOw>
    <xme:H9DtZmL1kbsMrRWCY8X-sYcNoh3wKNatDtJDZCLQOscVZZBTY7sBOVCKR1TpBTkwW
    e85t94x4DUlP-OglH8>
X-ME-Received: <xmr:H9DtZuveUykToSN0k6JGjKJKpTjrXXRCeU-IxqIQOJEqIMdrKOU79oPvxv14NuKn8hYPG_RR-dkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelfedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomheprfgrthcuufhomhgrrhhuuceophgr
    thhsoheslhhikhgvfihhrghtvghvshdrihhoqeenucggtffrrghtthgvrhhnpeefveeive
    eijefgueettdejleelieefvddtkeekudduveetveeutdehffeiueehudenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtshhosehlihhkvg
    ifhhgrthgvvhhsrdhiohdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepthhjsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvohhiugesmh
    grnhhifhgruhhlthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvg
    htrgdrtghomhdprhgtphhtthhopehstghhvgguqdgvgihtsehmvghtrgdrtghomhdprhgt
    phhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehprg
    htshhosehlihhkvgifhhgrthgvvhhsrdhioh
X-ME-Proxy: <xmx:H9DtZjZ4hIIUxo3_586c5KBG1E4HbPhVVxHuqEeB_yxX8JgKPQBCig>
    <xmx:H9DtZlZ3c3jyV6wxrnEQyEVn09vXEv7ihWlRc7ClnaJO8LBetXnCEg>
    <xmx:H9DtZvCvjx60lgegIvt56trTxP0gYOxD25uRcbBDPPF18ZGy0mYPYQ>
    <xmx:H9DtZrYaHd-XhkXI03awCSexODoCGNYoHfyV0riuYSBr_ih696QzpA>
    <xmx:INDtZh6cy6ZNf8bysXksK3MxWUcTf3KAKTIWiqCpISjqynaz1p5_8yQu>
Feedback-ID: i7f194913:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Sep 2024 15:42:23 -0400 (EDT)
From: Pat Somaru <patso@likewhatevs.io>
To: tj@kernel.org,
	void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	sched-ext@meta.com,
	peterz@infradead.org,
	Pat Somaru <patso@likewhatevs.io>
Subject: [PATCH sched_ext/for-6.12-fixes] Disable SM_IDLE/rq empty path when scx_enabled
Date: Fri, 20 Sep 2024 15:41:59 -0400
Message-ID: <20240920194159.158152-1-patso@likewhatevs.io>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable the rq empty path when scx is enabled. SCX must consult the
BPF scheduler (via the dispatch path in balance) to determine if rq
is empty.

This fixes stalls when scx is enabled.

Signed-off-by: Pat Somaru <patso@likewhatevs.io>
Fixes: 3dcac251b066 ("sched/core: Introduce SM_IDLE and an idle re-entry fast-path in __schedule()")
---
 kernel/sched/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c415d61a646b5..6a1f662a5e118 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6591,7 +6591,11 @@ static void __sched notrace __schedule(int sched_mode)
 	 */
 	prev_state = READ_ONCE(prev->__state);
 	if (sched_mode == SM_IDLE) {
-		if (!rq->nr_running) {
+		/*
+		 * scx needs to check the bpf scheduler to determine
+		 * if rq is empty, so disable this path for it.
+		 */
+		if (!rq->nr_running && !scx_enabled()) {
 			next = prev;
 			goto picked;
 		}
-- 
2.44.2


