Return-Path: <linux-kernel+bounces-278511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2394B11C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC951F223A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AB214262C;
	Wed,  7 Aug 2024 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsUpgqrm"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60422A1D1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061863; cv=none; b=HVjMqvaARa4gWwIBNAER7pKf/5zVtXwsWhHlhwk/3oItO5ygWQFHGqavNvkhmyNqlIEv0XXf00IR46YHtLPD8ln/htOcQS9NYIJSwz2+JGNbN93APHzBmDvblX0vu4Hgl1n1GKaSwTimidmiAvJRvEnnTyp/HneHmTV7AYB3Fcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061863; c=relaxed/simple;
	bh=cSb+FUcQicIiySHJpDDVRukywdeX42oCYfKaaf/c9B0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ku7ZuPEwB2Jjl7ZR+4Q8Ip2bz7RCb23xwRVQTCImUyZRRwadrwXorHCxC2rWKHswEqBG2zo16J1DiryZGCut5CkFGDsTDXb1k09aukQPpM76BWrmdx66VeLIcR4MlLcA2ah5MPxUVIzJ3819zvNYFmMRb/6Plv2VkQ7acaNHGMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsUpgqrm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fd90c2fc68so3053395ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723061861; x=1723666661; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1MZT3yew4MwIli3H2zmVW+Q7xdPnnG8KCmzZPSX5NqY=;
        b=ZsUpgqrmtmZw9QBG7jhiIEdp2g+rK8g5wcf7W0++mB1fXz6RaRhJppl4FX2/D2rUvq
         rgYeb5RhOLuOb4Tb/Hd2JH5N66oluz/7xQFMeKxNS5gHY3NKu0VtEou9QVYCx8/xhd4B
         kqQ0F6fW2jwT4YPI09U3tjX8SaNNXrzFb3qJe2srYcQVJkq514ZURwMG9GHJUMAGRPBJ
         t3bV9XsQTuUQsCkKCVwcgOW8Zxt4lZWU+IOEPV/miP8Fyxll5r5Bt+3nlFSu+S54PGHm
         /TCko1J0fGLZHcL5UNNsRtvFBKUhZvXAOXNFixJbRYs5RF5hhx8VE0rxhID3wiwbZKmj
         x/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723061861; x=1723666661;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MZT3yew4MwIli3H2zmVW+Q7xdPnnG8KCmzZPSX5NqY=;
        b=Nj3XeEt0wbCGKCujWpOsYJU2IMZAvu8oUrEI+zmK1A5wBNSq5D1g8CxXThuI99PIMJ
         L0/eYHn29+hC9dH2wn/MjHNA4eL0n8qYyLEdR2a2uXQ+fMuRknaQWZABlHkcsXDk6+fF
         zP/Sduxcz2baskxKlSeh4OuTUy+w/lghsH/3OzjU500X0AVxDnivcnm/ED/uOEawRF4D
         AHfig7u9mIBT3AwXOevaS/7R+/nCzxIQxrXBbTlwWCQ55FxcN/xzlEifabc/DfD2wS0r
         lkmenUIUqy9Ues+giO9VjBSjTid9W9968IC6bYTu6FJNmWDukAcCPtW8WvEn+jIlrCf3
         USjg==
X-Gm-Message-State: AOJu0YxLcw7H64XtCF8T49Ll9jB1qk7MYNsKAd1PXGVRo8fDT/WowtTS
	HyFM2uP1+hrBmRPLCR2jyMnBX+AnFobyzyv76WWDyrBE3Dq+RBGg
X-Google-Smtp-Source: AGHT+IHpSVwY/iwUhTBtmyBVV6+OUBst3piTk3bJepJfgFfVBHVqew7ZyXj0LhUF26fi6TmpEEzbGw==
X-Received: by 2002:a17:903:32c2:b0:1fd:aac9:a712 with SMTP id d9443c01a7336-1ff573510b0mr209603995ad.37.1723061860795;
        Wed, 07 Aug 2024 13:17:40 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53832sm110389425ad.73.2024.08.07.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 13:17:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Aug 2024 10:17:38 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.12] sched_ext: Fix unsafe list iteration in
 process_ddsp_deferred_locals()
Message-ID: <ZrPWYqSbif3eTME4@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

process_ddsp_deferred_locals() executes deferred direct dispatches to the
local DSQs of remote CPUs. It iterates the tasks on
rq->scx.ddsp_deferred_locals list, removing and calling
dispatch_to_local_dsq() on each. However, the list is protected by the rq
lock that can be dropped by dispatch_to_local_dsq() temporarily, so the list
can be modified during the iteration, which can lead to oopses and other
failures.

Fix it by popping from the head of the list instead of iterating the list.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 5b26f7b920f7 ("sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispatches")
---
 kernel/sched/ext.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2726,17 +2726,19 @@ static void set_next_task_scx(struct rq
 
 static void process_ddsp_deferred_locals(struct rq *rq)
 {
-	struct task_struct *p, *tmp;
+	struct task_struct *p;
 
 	lockdep_assert_rq_held(rq);
 
 	/*
 	 * Now that @rq can be unlocked, execute the deferred enqueueing of
 	 * tasks directly dispatched to the local DSQs of other CPUs. See
-	 * direct_dispatch().
+	 * direct_dispatch(). Keep popping from the head instead of using
+	 * list_for_each_entry_safe() as dispatch_local_dsq() may unlock @rq
+	 * temporarily.
 	 */
-	list_for_each_entry_safe(p, tmp, &rq->scx.ddsp_deferred_locals,
-				 scx.dsq_list.node) {
+	while ((p = list_first_entry_or_null(&rq->scx.ddsp_deferred_locals,
+				struct task_struct, scx.dsq_list.node))) {
 		s32 ret;
 
 		list_del_init(&p->scx.dsq_list.node);


