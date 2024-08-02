Return-Path: <linux-kernel+bounces-271955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7CA945566
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64EE2864E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A18B64E;
	Fri,  2 Aug 2024 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhANCRhi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE324C62
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558618; cv=none; b=A0wSN/TghNl1sgIPQM1Nb0sWC9jQimFY7Upfw8AC+/EsaGzKQiunKOo6A5a3z43HqFitlgKeNAw4f3Ga43YtpaalQIVTpm8CBZluLhJ/m8/G+r/FZeIzDzITWYcBKhjMuK8/HW+Z5fNBhVUQBmt4KeRfUXHniESSKmpxihPZRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558618; c=relaxed/simple;
	bh=PnyM09rVgRTI/M8RcaVA6e+CFCDz3VoX/Msl0FIBdbk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QKZ+CZSKV61l0VZtRvCS+35pHSumh66SywTGVcwcdPWcc1EiqLu1swzE8btygg9lQYlazC4MDyzJEW7vH8B7jnxKqKHwa3ILCvNb6iOHhK5xOBRnoodpW0l25MZPg/v2hyJfKKCTDccx6bJTSparGnHAHGONqlozYVxxINtqJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhANCRhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321CFC32786;
	Fri,  2 Aug 2024 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558618;
	bh=PnyM09rVgRTI/M8RcaVA6e+CFCDz3VoX/Msl0FIBdbk=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=fhANCRhiygN6lYqngQmVTMrd4jcNVMcOLnMS+NBj2l3ppG9GrC8XUoDTkMBY5oNa2
	 +mxMOQ4Kwbg82ckaXPkUQgHGpG7/HffE/KBF+WzcEPlQ+sWAo7l5c1mzsY15tJBsod
	 n3xGzjXhWYOkd5SAY8rlHVvD8uwnapB4QTYBggvgBBYfppv9cT1Oe3EPKPMqjHmeZv
	 fyjiQ0aQghg8ubROth64eHIhzOVs7JY5cRPazh7yQ5mK21Iy3aMBzjiBG8ogc884fc
	 OnhoA71dSIct4BPtOs5k3vWo/sB/J/BE2BMMp9lU2xww8QzVLs22uEY7pfA47Porke
	 WyR0VM3iVdS7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C509FCE09F8; Thu,  1 Aug 2024 17:30:17 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:30:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Breno Leitao <leitao@debian.org>, Rik van Riel <riel@surriel.com>,
	Anhad Jai Singh <ffledgling@meta.com>,
	Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>
Subject: [PATCH 0/2] Miscellaneous updates for v6.12'
Message-ID: <d70d1654-fed2-477f-8f4f-f81322784f17@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series contains a couple of miscellaneous updates:

/home/paulmck/bin/extractsubject.sh: 5: cannot open /tmp/rcu/*: No such file
						Thanx, Paul

------------------------------------------------------------------------

1.	Add check for clocks going backwards to wq_worker_tick().

2.	Sleep at TASK_IDLE when waiting for application core dump.

						Thanx, Paul

------------------------------------------------------------------------

 exit.c      |    2 +-
 workqueue.c |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

