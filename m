Return-Path: <linux-kernel+bounces-416476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885029D45A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC1B23596
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1127123099B;
	Thu, 21 Nov 2024 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OdR3j38l"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519502309BA;
	Thu, 21 Nov 2024 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732154474; cv=none; b=QJ7kJbMT9W8nuHNs6wup4zmAB6qMWXqBjEcUFkyWviOmj/UAG+vjn5YBc4UZdXv477LKcmbRzjKJyfPJ9QECpUucWnFYOnquaWIY87f6wp+Q0WIMnHx0wFM9Zws/4jZRQ9eVAIvYB4dQPr1O2h90am5TrqTP/i1ghPVES/AZBX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732154474; c=relaxed/simple;
	bh=bxamo9rYmX+GVPA2lopJxh4MsaXA2RWPPtWjqDZaDI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4ViZyZGV+B5U5wM1fnk2WBCN3SEZt41LH6xpFIij3zYuNZT8GUBEhaVBvOnNMj+VV1lUSTbel88L1HKb9UzKbVR2LdnK5VathJcKuqNw0dCGl8IgTiZQ8j3sZmXM4/TCwndaMvpxf//rycMXAasbtVlJkrtluQUrs/jOV1AKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OdR3j38l; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bxamo9rYmX+GVPA2lopJxh4MsaXA2RWPPtWjqDZaDI8=; b=OdR3j38lGwZkou1FB3obQlS4MS
	eEoAMeVrw/5QMUla6nQVPRCXq+E+6Ndfx+2bqIfcuzjRpAWSFCloyPSOZbRzkfaboMCOrt7kQShy3
	gfgyKMhtMnBWOZMuYyLmprVUM/LJq3+g1kdXZQQE+O+t+U2Qg/2vyrRsiYYDva/g9Khf2NhhVEdHG
	KTFutIw+54d8Ust3b1tjP8rdGo8Him2r1Q9X+iX2OxTfQGUBX6CAt5fqtB1gjc3E0BwDS5fEtK+NW
	PiYfEYiiuCtWLYmy2Bd0cs4k/oKPkKXhwqmpmP3n0UV0RS0YgTfgvv003ny0mioPpBijcu/6iqmc5
	r/zifiiA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDwUw-00000005rF4-1u0R;
	Thu, 21 Nov 2024 02:00:46 +0000
Date: Thu, 21 Nov 2024 02:00:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, minchan@google.com, jannh@google.com,
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 0/5] move per-vma lock into vm_area_struct
Message-ID: <Zz6UTvERgg9ubRu4@casper.infradead.org>
References: <20241120000826.335387-1-surenb@google.com>
 <hdvig2tptf3hi6nmszafarzqb6j56abfbebppqmruvpihlf435@46b57hyw2pfc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hdvig2tptf3hi6nmszafarzqb6j56abfbebppqmruvpihlf435@46b57hyw2pfc>

On Wed, Nov 20, 2024 at 02:10:44PM -0800, Shakeel Butt wrote:
> If 'struct vm_area_struct' is prone to performance issues due to
> cacheline misalignments then we should do something about the
> __randomize_layout tag for it. I imagine we can identify the fields
> which might be performance critical to be on same cacheline or different
> cacheline due to false sharing then we can divide the fields into
> different cacheline groups and fields can be __randomize_layout within
> the group. WDYT?

Pretty sure the people who think security is more important than
performance are the only ones who randomize structs.

