Return-Path: <linux-kernel+bounces-538350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0919A49772
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F483BAE18
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8874A25EFB2;
	Fri, 28 Feb 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMpBDuQv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B60257430
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738818; cv=none; b=bzww/D+xJieXJYkGu1GRVaB+K6PWE5pR6A7u7KwTo6hrXlZsXnopkiP67i308asMXEYKyQopdAEizs9eWb482BSR2vEgUEjYOWoXkphuiGneGTAc51U0ZKS+b2JdbmEziYG55HNkk5GO36VJa0oQ4sxfnJqcwLk7ru39i1x5n4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738818; c=relaxed/simple;
	bh=ovZoSm+otbQAllcxqid10BL8xtQRl/XN+WfKwxphflU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD25l78O3KI/WsR6zbn9YWJeonaAK967MB7xnZxaoH2bLp2cghgaE1MWLLPKYwQ3E1+jdKUoKNQ1tx0Snh6EnVx/vmm8I/IkyKlk0EdgpomGdrydgSKlI41gNLZKrpFC0Uo0/8RuLenev8AAJ9DH0MRQ2oF3ZjRUyjg1smZfNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMpBDuQv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740738816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovZoSm+otbQAllcxqid10BL8xtQRl/XN+WfKwxphflU=;
	b=RMpBDuQvRcnOd9+IsMw977OrQdogK884/IDJalj1Mt385OPtFcXcSQDziv0zbnBvKrglGs
	b6zh8ACtsh762ts7DjuFXNj8iGX6lEj77VdcP6f0xCY3fSAqRs5qZv4c4DAjKUZkAOnWLY
	VxysnXYOJlRPiqsawJDQAyKk5j4ROqQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-ytL_e8psM9igFNE-V-i5vw-1; Fri,
 28 Feb 2025 05:33:32 -0500
X-MC-Unique: ytL_e8psM9igFNE-V-i5vw-1
X-Mimecast-MFC-AGG-ID: ytL_e8psM9igFNE-V-i5vw_1740738810
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78B26196E078;
	Fri, 28 Feb 2025 10:33:29 +0000 (UTC)
Received: from redding.lan (unknown [10.45.224.147])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8242E19560AE;
	Fri, 28 Feb 2025 10:33:10 +0000 (UTC)
From: Attila Fazekas <afazekas@redhat.com>
To: qyousef@layalina.io
Cc: dietmar.eggemann@arm.com,
	frederic@kernel.org,
	jstultz@google.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	saravanak@google.com,
	tglx@linutronix.de,
	vincent.guittot@linaro.org
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000 
Date: Fri, 28 Feb 2025 11:33:04 +0100
Message-ID: <20250228103304.302289-1-afazekas@redhat.com>
In-Reply-To: <20250210001915.123424-1-qyousef@layalina.io>
References: <20250210001915.123424-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The 250Hz was set as a middle ground.

There are still workloads which sensitive to cache misses
and to the time spent in ticks.

You still can loose ~1% performance with higher Hz,
It might not sound much, but if you are running thousands
of servers 1% loss can be a high cost.

There are many workloads out there where 100Hz is the better choice.


