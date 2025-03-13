Return-Path: <linux-kernel+bounces-559996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B4BA5FC62
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F0F3A40BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7D4268FEB;
	Thu, 13 Mar 2025 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="YvvdCLc1"
Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4E1FBEA8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.223.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884285; cv=fail; b=aFtSB8JN2RERoGVzsXBsYS900YslIQ2VjdAFMDTtup3xSUNIiylazkod0U2Yb+UUXPfzbI+x/DhazifmzEugPxbA8OQ/l8j55849Fv/N/vxTlVihOLG0xyymMaXIub6+Su1KfkIEF2s0L5spSgMx7jvo8c6+NY8j7MpCgSeW+8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884285; c=relaxed/simple;
	bh=o/N6AizsKfiqEHu9P6Nin2fTGpnVkHJDz27/hTDKKCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ/lUuntpLacJUS6865otdfL70ivr6vW23c2pbYhPsWi9EvthyaBhIPYCicqW9lrVp87pzSyI8niQEOn/6og7gqmGPPck/mXVXa9njhj7AwSiGV+46UdgWWOc0UlDr0k1TYQs/qdi2RjjWv7NoIi2ZeCOirrljps4abCHwVMfbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=YvvdCLc1; arc=fail smtp.client-ip=23.83.223.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 204AA8433A1;
	Thu, 13 Mar 2025 16:44:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a241.dreamhost.com (trex-7.trex.outbound.svc.cluster.local [100.118.31.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5FF688441F3;
	Thu, 13 Mar 2025 16:44:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1741884276; a=rsa-sha256;
	cv=none;
	b=NFNwA8IysWNTBAWbs4AnydZW/HDE/aECf9A+3YdbaYBpSP/4QJ7HhnIkq39/P1CvakGLRp
	0Fq+4Zadkmo3OqsrnNmscr3VB8lDlnFopKhM0t5E95e0k0yCVfZgNNk+CW8Ov63FCeMU92
	x/c94abK4mdz1GWH/PRv+ziVt0WpRZN7WYMSDsww8eetJ1+xE/cm6/Qpf+WRZF6voZlR6d
	V2yTj6+hWnc84dso5g8UjuW5cX7E/ZGx+SRPYLyChAG27q/RduccTKd0z9vVPBWLxyI/op
	cpvjuUGr9F+f2pSsgxPLhJx87x2G+HfYm3Er+sUvBobnxYgnRd7yyPMyONSxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1741884276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3xRmJGFN7nrPOW2BDqB1Q2ynnG49HTel0YdgzfldMH0=;
	b=1cnzCh9xxyW+R3Jf7B+iBxvIuoyUtA5qXLCDk0NWf0y3efgCvdsOXa25H1gZAGzeAdfx3p
	uo057OVICdfqXK6sWwFkjfpggnGxbGWAvY7q+BO6GlGvnj00m1zS2L2wyAfIwz7LMSfhRq
	dRPWHgWR+G30gLiv8xegh/ArPc8kRt87ktDAZ0Og5aygi5URtsmZb3YEExDWhMEoFJYP25
	y9bhvEYdXHI099QTFUng8q0Y2T5oellIaqpnLQLUFa57ASixy6Vzo4LhA2OBBDDt5XZ7I7
	bQt8nmWR+/ng6X8AS72MeySsZT2yxh8rwWtj71wPgCj+Ckcb9r4MW2hhn2pvpQ==
ARC-Authentication-Results: i=1;
	rspamd-7788c767f-sjpjk;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Bubble: 7187a1e518e2522e_1741884276939_2886769575
X-MC-Loop-Signature: 1741884276938:356853382
X-MC-Ingress-Time: 1741884276938
Received: from pdx1-sub0-mail-a241.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.118.31.6 (trex/7.0.2);
	Thu, 13 Mar 2025 16:44:36 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a241.dreamhost.com (Postfix) with ESMTPSA id 4ZDCyV0NvbzGN;
	Thu, 13 Mar 2025 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1741884276;
	bh=uET1fL+vCM9Q2BqQovUvW0LaxkIi96OCoOTgYKD4kNs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=YvvdCLc1kVsaBV6jfPuOqoT1z0NXccBok/ZWrKs2pZoBMyobB7YXqhMQGUUgdgCmP
	 jddpF+H+hCHV9hlsySR7Y1gB8UjCy7mqCZEArYUDqcm72k+4YhRy4oVEG6K1j631UI
	 5KnOU7pEqZTTqbtWIEPoYoDe6SyEINiME18debvKgWpVUZ+I8CS3NmRCOMYiLyAZqF
	 aBYaECdLnxafRckV04c35NZnfM+BwQ6/2722+XOLfq2mjtpchJWR6MLSJd7ZPOcVjl
	 mSu9ko0HC/YvVbNshqiyVg1QXghLkNfxVcups9r0eIvc5ATiy0AJsOf/os4T0GZQc2
	 av840qcTFr8TA==
Date: Thu, 13 Mar 2025 09:44:30 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Bharata B Rao <bharata@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Jonathan.Cameron@huawei.com, Michael.Day@amd.com,
	akpm@linux-foundation.org, dave.hansen@intel.com, david@redhat.com,
	feng.tang@intel.com, gourry@gourry.net, hannes@cmpxchg.org,
	honggyu.kim@sk.com, hughd@google.com, jhubbard@nvidia.com,
	k.shutemov@gmail.com, kbusch@meta.com, kmanaouil.dev@gmail.com,
	leesuyeon0506@gmail.com, leillc@google.com, liam.howlett@oracle.com,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, raghavendra.kt@amd.com,
	riel@surriel.com, rientjes@google.com, rppt@kernel.org,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, yuanchu@google.com,
	hyeonggon.yoo@sk.com
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
Message-ID: <20250313164430.bzkfyqmx6a5dj7d2@offworld>
Mail-Followup-To: Bharata B Rao <bharata@amd.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Jonathan.Cameron@huawei.com, Michael.Day@amd.com,
	akpm@linux-foundation.org, dave.hansen@intel.com, david@redhat.com,
	feng.tang@intel.com, gourry@gourry.net, hannes@cmpxchg.org,
	honggyu.kim@sk.com, hughd@google.com, jhubbard@nvidia.com,
	k.shutemov@gmail.com, kbusch@meta.com, kmanaouil.dev@gmail.com,
	leesuyeon0506@gmail.com, leillc@google.com, liam.howlett@oracle.com,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, raghavendra.kt@amd.com,
	riel@surriel.com, rientjes@google.com, rppt@kernel.org,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, yuanchu@google.com,
	hyeonggon.yoo@sk.com
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250306054532.221138-3-bharata@amd.com>
User-Agent: NeoMutt/20220429

On Thu, 06 Mar 2025, Bharata B Rao wrote:

>+static int page_should_be_promoted(struct page_hotness_info *phi)
>+{
>+	struct page *page = pfn_to_online_page(phi->pfn);
>+	unsigned long now = jiffies;
>+	struct folio *folio;
>+
>+	if (!page || is_zone_device_page(page))
>+		return false;
>+
>+	folio = page_folio(page);
>+	if (!folio_test_lru(folio)) {
>+		count_vm_event(KPROMOTED_MIG_NON_LRU);
>+		return false;
>+	}
>+	if (folio_nid(folio) == phi->hot_node) {
>+		count_vm_event(KPROMOTED_MIG_RIGHT_NODE);
>+		return false;
>+	}

How about using the LRU age itself:

if (folio_test_active())
    return true;

>+
>+	/* If the page was hot a while ago, don't promote */
>+	if ((now - phi->last_update) > 2 * msecs_to_jiffies(KPROMOTED_FREQ_WINDOW)) {
>+		count_vm_event(KPROMOTED_MIG_COLD_OLD);
>+		return false;
>+	}
>+
>+	/* If the page hasn't been accessed enough number of times, don't promote */
>+	if (phi->frequency < KPRMOTED_FREQ_THRESHOLD) {
>+		count_vm_event(KPROMOTED_MIG_COLD_NOT_ACCESSED);
>+		return false;
>+	}
>+	return true;
>+}

...

>+static int kpromoted(void *p)
>+{
>+	pg_data_t *pgdat = (pg_data_t *)p;
>+	struct task_struct *tsk = current;
>+	long timeout = msecs_to_jiffies(KPROMOTE_DELAY);
>+
>+	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
>+
>+	if (!cpumask_empty(cpumask))
>+		set_cpus_allowed_ptr(tsk, cpumask);

Explicit cpumasks are not needed if you use kthread_create_on_node().

See https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c6a566f6c1b4d5dff659acd221f95a72923f4085

>+
>+	while (!kthread_should_stop()) {
>+		wait_event_timeout(pgdat->kpromoted_wait,
>+				   kpromoted_work_requested(pgdat), timeout);
>+		kpromoted_do_work(pgdat);
>+	}
>+	return 0;
>+}
>+
>+static void kpromoted_run(int nid)
>+{
>+	pg_data_t *pgdat = NODE_DATA(nid);
>+
>+	if (pgdat->kpromoted)
>+		return;
>+
>+	pgdat->kpromoted = kthread_run(kpromoted, pgdat, "kpromoted%d", nid);
>+	if (IS_ERR(pgdat->kpromoted)) {
>+		pr_err("Failed to start kpromoted on node %d\n", nid);
>+		pgdat->kpromoted = NULL;
>+	}
>+}
>+

