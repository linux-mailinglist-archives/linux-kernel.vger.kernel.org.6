Return-Path: <linux-kernel+bounces-358761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1246D99834A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB1B283D14
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB981BE841;
	Thu, 10 Oct 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hlE0sDg+"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2F18C03D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555150; cv=none; b=s02icvMTrZuQDDybz45WJ67u3+cn8yL6z9NQgQJMHjMM2yY9oJBk0dR1sbEdOEArPdzGNonk7DNR+y6ysOSglwOwv28veNsoE0y9FiWPyQl7GwuOL2sriIxAsYLFAb5W4DJDQgWoH2JP9lLsl3FM523EO+xwn1hfZlG+vvLwWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555150; c=relaxed/simple;
	bh=a99iXRhhwQCX97C4WjZOt4k6H+K32hGXT2WTg/adijE=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=GhTzt9cJpsvcJccBaGyAObsO1NgxR0xeywS8a1lr8OpjKm/41XG+o1zqTugAnb/zLRIZhfZ578UMl++BFAq5lBArwu8QUuiG9gE+lZZMRq0NUWndxhAwGmcFvBgCf6PBwaV+XEpgur1prN6eJKG/aHLHzod4BxtnSzNaGrJaJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hlE0sDg+; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241010101224epoutp04fb4b4de5a3b3687eda270d3583a857b1~9D77VliwN0615606156epoutp04D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:12:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241010101224epoutp04fb4b4de5a3b3687eda270d3583a857b1~9D77VliwN0615606156epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728555144;
	bh=vkYFXGKNiColrpXd6ixUZhFEvJUwMzr2VH4kPcgNJCI=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=hlE0sDg++B0Fa25kwdl8Y7payai/VfYifWg8hOSXUwUW3IjHtwVo824vyJLbSgRQI
	 U+dSHqK5OUk25lpQq8fIoMJ1jJtGa/uXTu1VSRjFuB1EAwOlK2XqidmwgAmhqE/VR4
	 nwxf0qWLyk2KGXnhcKv0WJkMzjFg221zauBlyiIM=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241010101223epcas5p3f9cd0f9adec72e68e63b5e9131413e1f~9D76MiE_p0428304283epcas5p3x;
	Thu, 10 Oct 2024 10:12:23 +0000 (GMT)
X-AuditID: b6c32a49-33dfa700000024cc-8b-6707a8863100
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.00.09420.688A7076; Thu, 10 Oct 2024 19:12:22 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] sched.h: silent false ATOMIC_SLEEP warning from
 cond_resched
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From: Maninder Singh <maninder1.s@samsung.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Hariom Panthi <hariom1.p@samsung.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rohit Thapliyal <r.thapliyal@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20241010092249.GD17263@noisy.programming.kicks-ass.net>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241010100940epcms5p2f7463014f1e1cb1b27a8da300b804e08@epcms5p2>
Date: Thu, 10 Oct 2024 15:39:40 +0530
X-CMS-MailID: 20241010100940epcms5p2f7463014f1e1cb1b27a8da300b804e08
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxSURjGO/de4MKirmh1sjJztZRNkq2PW7PP5bqt1aq1WjorzBs6EQ2i
	MluzTUndsKycjqFRmiaalYo6dEQUarnKclJqiiupTC3pi+w7vFL99+w5v73P+7w7OCqoZ/nj
	8fJDtEIukQWxeVjd7ZCQUPUVjjTsSc9yMn/wJEY6zxhRckBtxcje03kY2WHSsclzb18C8rFF
	j5AtGgtC3uhLIM2Z/QiZeeczShptbs6ayVRlUSWg0s3dHEpfraJqrgipZ/YmNvXO3MmmcmoN
	gKppS6U+VAds5UbywmNpWfxhWrFo1T5eXFbaTyS5k3PUrmtjpYFcdjbg4pBYDF+53ahHC4hG
	AId7g7MBjvMJH/ijwddj+xK74KU6DcYg82B7QSXwIL5EGPxqDPbYbEIEDaamccSPCIHlasef
	6TwcJfIwaCl1IEwUHxaccmKMngXry4zAo7lEBNR/LGMx/jTYVTHC8ep3zRcAo/1gRt99lNE+
	sH+sccKfDStqNBMzU6Fz6MF4MCTSATQ3eqFl8FqJgcP02gyrumQeGyMWwI5S3QSyHg7etY7v
	gBJzYf2IDvXg6J8y10yLGGQOzLtXhTDIFKj5NvC3VkORVy+A6V3XWd6KH1yuidUoaCuzYJ7V
	BMRNAC2dGs4ZEKj9d2ntf8naf8l6gBrATDpZmSillUuSxXL6iEgpSVSq5FLR/qTEajD+t4Qb
	G0Bv/6jIChAcWAHE0SA/fuhFllTAj5WkHKMVSXsVKhmttIJZOBY0gz+UURgrIKSSQ3QCTSfT
	Cu8rgnP90xDRmmDDjlGHduD8/Pgt4anuWNUQ+6YiRUB93h7xgi18TxR8hxv6qoYrOr6ua6v5
	UvYr6Wnwyt2P7ItvHLwdHaAutJ23lWaLA0ukgQuX5laiWufauTszWmRy1TET9ThkbGV04EFB
	c3RUgk/dWPHZRyV0mHWOv068zGRWxyR9mqS6q74ud/1sReY15bBiBq+Wru7JzRpYzo2oQtX5
	Ca1RAWaRfngJ4YqwznQ12oRTeZzelr6MlEL6zR5hVvl0u/ZHgzttV0x3sSzxu+PA8UnNKzIf
	bjOuax99bUkxnx7ZV+7knl3rYG0tsW+6HN9cG/7kebbwVn7kiYLanPxvqLj41vEgTBknEQtR
	hVLyG5mgOubKAwAA
X-CMS-RootMailID: 20241010032751epcas5p1154533995a184be3fea39325c4d33740
References: <20241010092249.GD17263@noisy.programming.kicks-ass.net>
	<20241010032653.1922214-1-hariom1.p@samsung.com>
	<CGME20241010032751epcas5p1154533995a184be3fea39325c4d33740@epcms5p2>

Hi,

> On Thu, Oct 10, 2024 at 08:56:53AM +0530, Hariom Panthi wrote:
> > In case of (CONFIG_PREEMPTION && !CONFIG_PREEMPT_DYNAMIC),
> > cond_reched() is not sleeping.
> > 
> > Thus remove __might_resched in that cases.
> 
> *why* ? It's still a valid site to do the atomic_sleep testing, no?

In our case there was a call to vunmap_pmd_range from __do_softirq,
and vunmap_pmd_range is not actually sleeping call, but because of
cond_resched it was giving warning with DEBUG_ATOMIC_SLEEP.

and cond_resched in case of CONFIG_PREEMPTION is empty function with below change:

commit 35a773a07926a22bf19d77ee00024522279c4e68
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Sep 19 12:57:53 2016 +0200

    sched/core: Avoid _cond_resched() for PREEMPT=y

    On fully preemptible kernels _cond_resched() is pointless, so avoid
    emitting any code for it.


So we thought it should not give warning also in this case.


Thanks,
Maninder Singh

