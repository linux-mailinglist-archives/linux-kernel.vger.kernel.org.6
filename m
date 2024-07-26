Return-Path: <linux-kernel+bounces-263155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96ED93D1BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85FC1C21D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668F9179675;
	Fri, 26 Jul 2024 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BFhI7FwV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0GjSsafQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A478178CCF;
	Fri, 26 Jul 2024 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992157; cv=none; b=DwCsK8o/IFjRLFrZ7poCq5X66MSwHrLl3hENoL/032yaxO+S8HnbyWqHw29/XH6xbBl8pZTIB+MnRUIikJURUkNXa7puZbGSpRwGoEITW4Ol099+yBs+X2yvbqGqIcWR4jAlNu1XXAXdhx5K+N4tBFr/dECdDVQZUbBuSHCpNdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992157; c=relaxed/simple;
	bh=R+7nBrJzXad+bnyleW95iwSkt+Z1Wq4HvaOxT3soPe0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ya3L1BezwAeCnHYoqH5z8IEsPLoiaBO58yu3Km/QFuXezITxyF8B+U/woIQltHoxXB+Igz0LhbrI7b94hGPa2YWIxaUO9OtxpB0wolqtmXyYnKS+ldDXmAAKJScqSosd7Vol2mrf1FJqMp90GKnhfqBQ6uERLY/9BNuT92whzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BFhI7FwV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0GjSsafQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721992154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaKS8CsV1s9CpPE7Rqhu6jDo9b4qQ/7+J9GKBzzCvOg=;
	b=BFhI7FwVf54brzdkwUohs8v0/THBbeRNiwOEXgugCE8Pn6PQJ85foXBXjbBY16C83WJjcU
	HCfMZwn9uXKf3zMLHxkAWaJEHR98PbnQSs15Vn8xvV7zAYu06gHUvBWs+1KR4UM7Ki8Oax
	45aXJ4Npw8uMt1XZUBym+M3ROdsxYkodzmCJIYVAX3fuYJwW/QDVoqmzm65vPC1jadIP0c
	8VIj+47H2WyTURDO/NUYOSH+ooPERDskrkcIOEfOmQDhzIYw3ix+fc7gq04Qp3xDTfvmK+
	SBae4LPovMkCAHBDyHQczKEaVCAvZsrxx6DoPAs5uUKYOb8EtSrCIlAOXVWFQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721992154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gaKS8CsV1s9CpPE7Rqhu6jDo9b4qQ/7+J9GKBzzCvOg=;
	b=0GjSsafQJqvQ6zG5Fbon7gY2YS4TtMM94vHShZo5Rnvxj4f48ELIoZgmp3cLrfvrPAJ/zM
	KvBsikAmUgkhNQAw==
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Rodolfo
 Giometti <giometti@enneenne.com>
Cc: "Hall, Christopher S" <christopher.s.hall@intel.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "Dong, Eddie" <eddie.dong@intel.com>, "N, Pandith" <pandith.n@intel.com>,
 "Mohan, Subramanian" <subramanian.mohan@intel.com>, "T R, Thejesh Reddy"
 <thejesh.reddy.t.r@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>, "corbet@lwn.net"
 <corbet@lwn.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "Zage, David" <david.zage@intel.com>
Subject: Re: [PATCH v10 0/3] Add support for Intel PPS Generator
In-Reply-To: <2024072500-matrix-antivirus-dc61@gregkh>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <CY8PR11MB736490B761DBA045513AF078C4DD2@CY8PR11MB7364.namprd11.prod.outlook.com>
 <d463bd28-9890-47a5-97cc-14f96db2db22@enneenne.com> <87r0bvqdsz.ffs@tglx>
 <5198a2c2-49b2-4a8c-8d94-d6c9811b645b@enneenne.com>
 <PH7PR11MB6978F12032F4F3EBA83BFE10C2AA2@PH7PR11MB6978.namprd11.prod.outlook.com>
 <c785136d-40bc-4fa3-b982-e9e4417c0b73@enneenne.com>
 <2024072500-matrix-antivirus-dc61@gregkh>
Date: Fri, 26 Jul 2024 13:09:13 +0200
Message-ID: <877cd8wgti.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 25 2024 at 09:09, gregkh@linuxfoundation.org wrote:
> Are the patches in linux-next?  If so, what tree did they go through?
> If not, they can't be merged into 6.11-rc1.

Sorry, I missed that last submission.

It has dependencies on the timers/core branch which got merged into
mainline in the current merge window. So if someone could have picked it
up that would have been me.

It's unfortunately too late now, so this can be picked up for 6.12 by
anyone without dependencies.

Thanks,

        tglx

