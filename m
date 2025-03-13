Return-Path: <linux-kernel+bounces-560583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6273A606CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252723B7F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1DCA4E;
	Fri, 14 Mar 2025 01:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="TBuOX2eJ"
Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B3A2E3374
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741914543; cv=pass; b=SUW0dXtn+DgFagJkB68PbTzE2+lTaSuEEUhvDhOV4113EfXPWkKfbsY+fRhfeB390Zp2/UEENf2V9BD8Ibdhsq0WOoROiDi6r0iDSwRT5Nd1jOVQPSVv2AoSF0HKljMxLUG6Qt0tLbwNfxGj2v3pNWjEX6iWTnYKxwrkNuFyKdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741914543; c=relaxed/simple;
	bh=Fao4R1jwJFbqu3WPzplKpd7x/xDJM4gRsi2TTGRUsOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THw0byf5Vm6AkbExtZj8Y6wxHQaWBACcLm41CcK23IvfZmsptEOgVkL06yu4mhdmU+jReHWAAIZnGBHbNwL2eJtxX+C8xmdBDGF910PeKuQtrL2pfFKYlUmSfGsTAwjpWsET8jzwkEQ9vaVekZR50/cSppxrCFvU1qcofuj0SkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=TBuOX2eJ; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 17D8E1A3938;
	Thu, 13 Mar 2025 20:36:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (100-115-211-97.trex-nlb.outbound.svc.cluster.local [100.115.211.97])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 38A3B1A3941;
	Thu, 13 Mar 2025 20:36:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1741898174; a=rsa-sha256;
	cv=none;
	b=3MnzZjQ15bP//389f5y0HBsyU3jrG4JQzK6un2fw4Y45dmBeNhVeDXRzbh42qxj/j07amX
	uPjdG3bYF7pZvYn8VlfyKAEMA77oyYFG8QXZI11sVLenYyxLt+WfQZ0If6Ib1P+3K6Adc0
	wVNmjViqS8Ouv71f7lTAusIcusz0jpQsxQlCLxL2MQ/J6FozKHgNbK9F9euxGVW0uRqIKQ
	U6cFjxnG/4stEc5LjhL6xT8WLoi9PiDSDBe5lMchZNLhyu6RrKilQqiqzsCweOBINIG/l2
	hrlCwXw1jk4pdIWG+n0GcbwaZqqE9YYcAtFHfc3p7u74sXl7ri6s7eTrn74ZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1741898174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lSOcGU+o4GtrQ8wkO5JAJHvBA0325lVIyh7OVoVlQvQ=;
	b=EOfqE8a988Pkq0Mt2PN9dOUUq0U8A0Bn8uG9VwSn4s6Xfr0FTnvPrqLq2KrGvfPSHQl+Uh
	obSwDFkTCbtid3h3YnI9rcWasNgppEXqOt4XGQXGr5JNXKBul2mB9kqnM+mqbs/CknKqCa
	1oY5cKqWrbNaL34hoOvS7uBzwqbi2bU5hQWYMwjfIsdGLApds9OcJ0xdfZaDus1uiKVqXD
	85jXQW3/6SErbPIIoWURkTVEPV+BxGkzNh7J7TtE1i8h1G2viYsab/LnDx8p2Duok6gw+z
	L2R3hM2SqQX42WutSA8VbI5KzbVCYSjvJ2QNAHR7X3FZFnqLimuY/yLpIOBLrA==
ARC-Authentication-Results: i=1;
	rspamd-7788c767f-xtt84;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Hook: 5ededd4b729628e5_1741898174875_1399200824
X-MC-Loop-Signature: 1741898174875:2230088077
X-MC-Ingress-Time: 1741898174875
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.211.97 (trex/7.0.2);
	Thu, 13 Mar 2025 20:36:14 +0000
Received: from offworld (unknown [104.36.25.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4ZDK5l5W5Zz5x;
	Thu, 13 Mar 2025 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1741898174;
	bh=lSOcGU+o4GtrQ8wkO5JAJHvBA0325lVIyh7OVoVlQvQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=TBuOX2eJ/OwpGeqsZV/j8r91pfBhN8MdDpu/Z83RQT4aww0IcMZOXem8Dauxaft/9
	 Z3ETKU4UXZ9eYF+9K6FpLD2ck5Md8pOPGyEMpoVcdx2fseY+PG3xAfnLBSdbhoto3+
	 i2SQyE1jHTSiOv3tpSW16x3Z/EXqPTJQR4OlymWEfI87CDE5hTwClgxfQ1b1NOgugC
	 g7ZKaDgY8h/R5W7FAp5wAzL87o1Rd0UnpRSGxumX5GAIzfRwoDAwQrDT2vAq55a8Nt
	 IMODOx5AD72je4tJKfj0c3blJ61w3IPzkuw7oZunIRq3uOvQTBJLg9eqHOXSk60zAn
	 vFMJWb00QeTPQ==
Date: Thu, 13 Mar 2025 13:36:07 -0700
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
Message-ID: <20250313203607.zod6lssjef37ynbf@offworld>
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

>+/*
>+ * Go thro' page hotness information and migrate pages if required.
>+ *
>+ * Promoted pages are not longer tracked in the hot list.
>+ * Cold pages are pruned from the list as well.
>+ *
>+ * TODO: Batching could be done
>+ */
>+static void kpromoted_migrate(pg_data_t *pgdat)
>+{
>+	int nid = pgdat->node_id;
>+	struct page_hotness_info *phi;
>+	struct hlist_node *tmp;
>+	int nr_bkts = HASH_SIZE(page_hotness_hash);
>+	int bkt;
>+
>+	for (bkt = 0; bkt < nr_bkts; bkt++) {
>+		mutex_lock(&page_hotness_lock[bkt]);
>+		hlist_for_each_entry_safe(phi, tmp, &page_hotness_hash[bkt], hnode) {
>+			if (phi->hot_node != nid)
>+				continue;
>+
>+			if (page_should_be_promoted(phi)) {
>+				count_vm_event(KPROMOTED_MIG_CANDIDATE);
>+				if (!kpromote_page(phi)) {
>+					count_vm_event(KPROMOTED_MIG_PROMOTED);
>+					hlist_del_init(&phi->hnode);
>+					kfree(phi);
>+				}
>+			} else {
>+				/*
>+				 * Not a suitable page or cold page, stop tracking it.
>+				 * TODO: Identify cold pages and drive demotion?
>+				 */

I don't think kpromoted should drive demotion at all. No one is complaining about migrate
in lieu of discard, and there is also proactive reclaim which users can trigger. All the
in-kernel problems are wrt promotion. The simpler any of these kthreads are the better.

>+				count_vm_event(KPROMOTED_MIG_DROPPED);
>+				hlist_del_init(&phi->hnode);
>+				kfree(phi);
>+			}
>+		}
>+		mutex_unlock(&page_hotness_lock[bkt]);
>+	}
>+}

