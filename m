Return-Path: <linux-kernel+bounces-422118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351769D94C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE36282224
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B31BD507;
	Tue, 26 Nov 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="V+N+1d3M"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618A1B86F6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732614198; cv=none; b=h40iPswnPQ/Cs354kwGYHWp2uAvEDSRrZgeI3JG7NP0U8FI2YHw9HNtvqyYY7uPLl2cnSEI6ZyIjbUwlHQgGVuZYh2bxDYU1ZXIn0VXRn4y5ZIO9iF26ezFeu3nBlWPAFi/KB+8JKTXylcU2AFRVwQXJ6H1VM8DAom/ve7binxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732614198; c=relaxed/simple;
	bh=W5zxtn6Z0BaifNFg+BAOPm9FHmBXex+xDj0PnNydyxQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tKjnfY6MmPFcPBlpsbaxFWjcye2vI7IB3csLZhfrR4OaodEe8oIxNUWcAi6eVaa8hrqUBA8Nde5jKTdxQpnntbUuYPhEeO/LGcvT9CAsrbW3xrN76ojMLezWZeOnM3z3KLQL7Rfs1We8jcDH1YHPl2uSFC6C+iwWclOsHeXieeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=V+N+1d3M; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732614158; x=1733218958; i=efault@gmx.de;
	bh=ViNZsXkFTooqZCSQtoS8v72eEj2plSw0+hJGnh1U8UY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V+N+1d3MrN2iu2cyVPc0qHCnDHX6W+VGZ+s9RmYtA3zB/GdLKRe+mRzXmlR75SM/
	 Vubl/ELybwXMfuA3eej5/5PX17HutRPVY3mJd5OcPwjW68c9p3p3fYlCzmVywVehV
	 Fbcg9cMpy6GU6NR2d70aFhHlHrUBsCgMKzgzC6x2mlQK1+sg+kf/JXG1N62gmIoPE
	 qHxSBL2sPedj9rGySYmt1iO1dvKkcQ62VFzjQ97z9b3XImPIhz9KXVGTd8gL5iZzG
	 r/KlFdu1//X4OoaNGb2hSlynN2BKNUtJa2cO6v4pgCQrHnUlE6VCYVKIQB3Z3lpOd
	 PhgEWNsAuP7qztD5eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.70]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1tgVxd2l51-00va3o; Tue, 26
 Nov 2024 10:42:38 +0100
Message-ID: <a6147977d5542c1e8b6a8025f6cf35af164cb06a.camel@gmx.de>
Subject: Re: [PATCH V2] sched/fair: Dequeue sched_delayed tasks when waking
 to a busy CPU
From: Mike Galbraith <efault@gmx.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com,  youssefesmat@chromium.org, tglx@linutronix.de
Date: Tue, 26 Nov 2024 10:42:37 +0100
In-Reply-To: <924b853c01a5466c0bebe3bd324c46e9980dba1c.camel@gmx.de>
References: <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
	 <20241112124117.GA336451@pauld.westford.csb>
	 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
	 <20241112154140.GC336451@pauld.westford.csb>
	 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
	 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
	 <20241114112854.GA471026@pauld.westford.csb>
	 <20241119113016.GB66918@pauld.westford.csb>
	 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
	 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
	 <20241121115628.GB394828@pauld.westford.csb>
	 <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
	 <8df808ca-186d-41f8-845c-c42fd2fd4d45@amd.com>
	 <924b853c01a5466c0bebe3bd324c46e9980dba1c.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sCSzhnt5RLrw8Y3EcSQNQ+B8yaaYtEEDKCH9AqCbxs/a+Mq3sEA
 o3SIn6GBEB5Gm6w+f5pFn5NbNkh32LnKCRuWW6cukSB45v59ujgaviHpevqucrd3bFsmhBf
 0JGFw9Ne8r20Fac3j73GuP55Lvfncj9q5/wuC/MN9CQS/qhkCu2ytKhFFN83UCKi79yiJUe
 PnEblkfenGHC/diXnK2AA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sXxf8XhGlYw=;dQrXcC4US6+BS7j2ALRpZHVp+T8
 3jK9jL9TcpROEY2UQABSlGLYcgVt6YGSO8vbVe69rr0sbFaNvUE310+hrD51cqXROEJiO2ofs
 0DBrO0fDJXGbXKenwPXCFScN4BJnM9CBNaPdbi9+1Vx3cTMbUDRJbg9wSNJSLa5HDMIVCGrrs
 EiEKBl5VObWJNtJXiJzGdQ1WdUI5A2KYlD4THeziHq6GgwUY+9COJUw9R/WhMIU5X87w/Aa5D
 Ti19Y7CNSwGf+BUHEvYUsBgjHZ5iyU6BfJ5TMK4//8Und3qpFgm9NVm484dw4wUW+tVookNna
 P1eyV0zTRbMCOXP570D1QTySPfQjUmnDIYxw6osYx3xlibrDsQx0n/ZYzbwWmxkEQxQjm3keS
 bZwWVHrz4YJcv3NkqLeexnEAQvEjrT2PQYODA/FQ94s65MaFAmHR6dUnPv5XsprWcAPQl3FR3
 /QK3sUIBUNYfl63imJWGLIH3O62F5WWH7jQiUbPv9GdSoFZ8TLSt4B/hh193QgUdNrZCeIVvC
 M+Wx6vRxyojfAcTd2WZDSOA+itkJDimDupn+K0vS5MP3gG9qfH0dEeqqAygLp69tXmtY4pYnA
 ZHIpJKfc9U1c5Pl7KDjnk02Usabvf1x+9VuD6zIKJxIdfCbJYrlhHTnG36/HNlrrJgjCbRLN8
 p93igoxwyXBE/Cpb0n+XZS/cwLEe39/mDHWk1JjioyRL2a0roxNc3KqSnlLDmMiEJWWEmoiTb
 7MzQJWtVmgJ7QNYEwvYSBYt9GLlBI/us/gyPhRdduzGs6yqYHqN62zIvrnjSOHk9X3fWySXXf
 VwZC837wWKc2l047X5KPjb2oKshUEl2taw4T2jDdx64gzVTnMLnXy368GU0PaQNOLXjVtqe75
 8lv89Kx78usLfyAey9yhkUqLE8fs8fmk8kAd1BtASiNFrK7GRosQ8Bkda

On Tue, 2024-11-26 at 07:30 +0100, Mike Galbraith wrote:
>
> The intent is to blunt the instrument a bit. Paul should have

Yeah I did... ahem, I meant of course Phil.

	-Mike

