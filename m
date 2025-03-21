Return-Path: <linux-kernel+bounces-571764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD23A6C1E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306897A34B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CB722E410;
	Fri, 21 Mar 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b="rWmuvsVa"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63522DF86
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579571; cv=none; b=mLI8xfwt5jNMneLcpgLs5cR9t/rLnqZWtERruouG7r/XHZ2F1CDOWvDOJlLCoaRRhzyYashBbjyE4cLAXqZXltp3amspWwp80IQuKolYsSARqbMnJlEQu5Hf7mFo8He7InHE5ob4ZeB/byot6OhTfyPkZT0Ts3qKFrsum/NJ2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579571; c=relaxed/simple;
	bh=3KbwbiIdZD9SwPO5/Ys1Ipv2htc083kqYRR4qOWVVyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0p78FJ6vaT8wzxEfcX2WIu7Gjlhl7wE+tsQyxTpPyQMSJw4oPqJeWDtZjMDYurlcxU8jTn8bwyng8msDDSiXaoxMj09N6Hh95qOxWvRrte0shq8Y6IHlPvBL6SLdUyrtyPiAfpB02Q9djvOiyPdWcjuyBKWyyZyv7e4+zlH0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io; spf=pass smtp.mailfrom=patcody.io; dkim=pass (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b=rWmuvsVa; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=patcody.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=patcody.io;
	s=protonmail; t=1742579553; x=1742838753;
	bh=ZFYA/cCQuoMCq2M/VnoisL8CaGvvio8pJRHM3dKEtuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=rWmuvsVaxRl8KnWGiWrSB96AwDf9LpIrCYLbb/o7HkRJ2JzPDWPf+kwQt50rNNMXR
	 19zu4gTUqJKU21r63k5C6oxaiKB+kISPaud5/4J0nuH41X/OIi2166areV3zxgYojW
	 qHp0AbMOoqazmxPb1EJCx9s9h4xVxXms7DtNLcGeWURFnS+8gnrw2Z94uPYTmp//6R
	 wHORoctjh4diZDuxsEZXTbsPW/TKhpp0NE3ZIqoYap1zoMdzzUJjk61fkkSOP+tdCF
	 L7jxVcbjaosjPorH4xClsvuVBf+VHfYHOdiWA6ETNKWYzuk/7tKbBnAKgzRTp4A3l7
	 388A3bUKXwHQw==
X-Pm-Submission-Id: 4ZK95B2lg8zNx
Date: Fri, 21 Mar 2025 10:52:29 -0700
From: Pat Cody <pat@patcody.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org, riel@surriel.com,
	patcody@meta.com, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <Z92nQ8fQRGoEh4+k@devvm1948.rva0.facebook.com>
References: <20250320205310.779888-1-pat@patcody.io>
 <72cb8df7-42e7-4266-b014-7d43796b14d8@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72cb8df7-42e7-4266-b014-7d43796b14d8@arm.com>

On Thu, Mar 20, 2025 at 10:42:44PM +0000, Christian Loehle wrote:
> Did this happen on mainline? Any chance it's reproducible?

We have the following back-ported on top of 6.13:

sched/fair: Adhere to place_entity() constraints (not upstreamed, see https://lore.kernel.org/all/20250207111141.GD7145@noisy.programming.kicks-ass.net/)
a430d99e3490 sched/fair: Fix value reported by hot tasks pulled in /proc/schedstat
2a77e4be12cb sched/fair: Untangle NEXT_BUDDY and pick_next_task()

We don't have a repro, but the crash in pick_task_fair happens more
often than MCE crashes with our limited deployment of 6.13. 

