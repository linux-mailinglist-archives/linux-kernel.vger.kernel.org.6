Return-Path: <linux-kernel+bounces-428246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA999E0BCF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FE2282806
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F101442F2;
	Mon,  2 Dec 2024 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0G2U0LX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A51B6D0A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166918; cv=none; b=QOhqB9VobyW08iAhBSyT2iXgLyX+zRY/N1nu9d6bpJA4+e6drmyp4PCA2SWxQEu6ILSGf0QZ2Vmu/Mb7zkx7G/S8wkPXJ8T9inSyCvA0Ma1dR30aP24kHrGAezvuKN3/9wPjkW1vTPvVmqqp9IPg9Yqa7U6svVg1wdozZAinhN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166918; c=relaxed/simple;
	bh=LlmE5PXoP/0Bt/erTcqsahpLLO4fx4OjZBvyBHojLT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgc3Np1ZeXFVVTGoBpJ5cdSTZlJNgeSNDGJi1jwQYck2/q4YtKV5oZ7chLOexya/luYyjjoZREvqyqMatXgwsOUXsxP4euTDO2RoYYuhDuZoAB3gpAuOnWFCREFxLX9zaqKPZGrxXgemHuaPbjUqAUoA6G6KslcNarfE4uHtysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0G2U0LX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733166915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+i5+Pq0qTjDLhCIho7XynUnhfkt+n7Xq+muRky07sE=;
	b=f0G2U0LXfuDoESSG/TZU6fH+xYtd678W/MzYJUytlKFmTGMvHUztyaSs0xmNjjBARi24zq
	tWHFP9Z7CTC65AV6X6PFBiHMIhtC/upWw/8V7Y7wOgmvzXPShaQHBS++2xVdFfEJeb9I+N
	c1Grdln44QWzv88Pw0Bh4fmFBgHmoPI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-XAx4NxeWO2K56SMfzvlH8w-1; Mon,
 02 Dec 2024 14:15:12 -0500
X-MC-Unique: XAx4NxeWO2K56SMfzvlH8w-1
X-Mimecast-MFC-AGG-ID: XAx4NxeWO2K56SMfzvlH8w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 542AC1955E8C;
	Mon,  2 Dec 2024 19:15:10 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.65.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8774530001A7;
	Mon,  2 Dec 2024 19:15:06 +0000 (UTC)
Date: Mon, 2 Dec 2024 14:15:03 -0500
From: Phil Auld <pauld@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com, youssefesmat@chromium.org,
	tglx@linutronix.de
Subject: Re: [PATCH V2] sched/fair: Dequeue sched_delayed tasks when waking
 to a busy CPU
Message-ID: <20241202191503.GB1233297@pauld.westford.csb>
References: <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
 <20241114112854.GA471026@pauld.westford.csb>
 <20241119113016.GB66918@pauld.westford.csb>
 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
 <20241121115628.GB394828@pauld.westford.csb>
 <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
 <8df808ca-186d-41f8-845c-c42fd2fd4d45@amd.com>
 <924b853c01a5466c0bebe3bd324c46e9980dba1c.camel@gmx.de>
 <a6147977d5542c1e8b6a8025f6cf35af164cb06a.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6147977d5542c1e8b6a8025f6cf35af164cb06a.camel@gmx.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 26, 2024 at 10:42:37AM +0100 Mike Galbraith wrote:
> On Tue, 2024-11-26 at 07:30 +0100, Mike Galbraith wrote:
> >
> > The intent is to blunt the instrument a bit. Paul should have
> 
> Yeah I did... ahem, I meant of course Phil.
>

Heh, you are not alone, Mike  :)


> 	-Mike
> 

-- 


