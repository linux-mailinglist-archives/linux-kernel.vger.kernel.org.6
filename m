Return-Path: <linux-kernel+bounces-560426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB1A603F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DB0172C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6321F6699;
	Thu, 13 Mar 2025 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zLYkXpMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0FB1C07D9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903695; cv=none; b=tpJ1b1y8MJ08M+TIF7EOUQCRvUmZ4CqTYE7rnQEvaZH7Cz8vLVa6ALbDWBKXSsLakJmmWQjHzGcYdX0uExkwf6OPxhhANDJce4CBODLwcd68xxicPfWl0wBU/leJxHih9TL0hfiZcvk05/n9sGNz3WZuvwfh0dSauiWV5+LDup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903695; c=relaxed/simple;
	bh=IRAhxhtjAxwlDedobD/rjMlDvajD+gS5Er4WmKzxIyY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pqm3FcMMkVysEPICFv4n/tn532LHzvYNxD/oO9fIuOFCiIJDSQVPh9kMGRWIGWmdkiV28xdDLb7QO4eE6C9ev3gWz63fccGP/LCgdPydy6TfHPyxcD2PKTPV5t5rO2GWTG/h8ycBPKmnDP1hVOEUw4SUbxutd6+Zs1a/DOYxTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zLYkXpMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99306C4CEDD;
	Thu, 13 Mar 2025 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741903695;
	bh=IRAhxhtjAxwlDedobD/rjMlDvajD+gS5Er4WmKzxIyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zLYkXpMFOIhsH962rYF+opwrkkdhe+6kfeiby9XVU0T8+3ncLboKFq+oonTGkhsyf
	 XrGwqB1PQSouvsvC49AgpspjqpipqKXkKuu8wEJKGpxspTMHxn48pjE7JY96uUbLOU
	 GXRFqh3kodKoRV3NzdZmn+zRPPdwVbnEI984A90Y=
Date: Thu, 13 Mar 2025 15:08:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Andr=E9?= Almeida
 <andrealmeid@igalia.com>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>,
 Waiman Long <longman@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH v10 19/21] mm: Add vmalloc_huge_node()
Message-Id: <20250313150814.075d1cd993a84005d4cd22c2@linux-foundation.org>
In-Reply-To: <20250313075924.qulV64zL@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
	<20250312151634.2183278-20-bigeasy@linutronix.de>
	<20250312150206.54afabcf993bbc55f0066886@linux-foundation.org>
	<20250313075924.qulV64zL@linutronix.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 08:59:24 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > 
> > I suppose we can now simplify vmalloc_huge_noprof() to use this:
> > 
> > static inline void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
> > {
> > 	return vmalloc_huge_node_noprof(size, gfp_mask, NUMA_NO_NODE);
> > }
> 
> Do you want me to stash this into this one or as a follow up?

That would be nice, if you think it makes sense.  There is some
duplication here.

