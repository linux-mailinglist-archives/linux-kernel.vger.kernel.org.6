Return-Path: <linux-kernel+bounces-253341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB37931FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ECB7B21516
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A8514A84;
	Tue, 16 Jul 2024 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WCZzkfh9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QXAe5qb1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20BC8F3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721105144; cv=none; b=M71TuKHeWOsrdg/mrb8SP3ehld2RNdYZgwXcu0aQYePYfHt4MNvGtcJ3IWturrIZkN0UtMBZbPKEPWOp8f813OoaRYyAwv3aKNGZVc4qa1KFtZRArBXVo74A4bK5Ay8Cf9L9GHWjm/kAE7z0mDDsiUqRY4jmEbXoetkDGJBy/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721105144; c=relaxed/simple;
	bh=wb2ty0EaBeO/Bnh0eKhdoywCOrRT+pgNno+dQqXC3Ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=izqIBsV7pUdR6Aty6TocN9b3VAInXFuz77G/Q5tLSxJzg7wMPKcMemcddoIDc/t1y57VHLSmcKSJvHWn2PvnlN7/Nedg3G2USlPgKUOiu9B2NyCWI8ikyY5N+Fzn6Vf02X8QPwwh2+V8Ucb4nFQlSIfsuGAhKMBL+LcHW+Gc8yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WCZzkfh9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QXAe5qb1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721105141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uaQ8jE17m/nQQRyJzJd8jfJE2FTT2pexA8E8DWD791Y=;
	b=WCZzkfh93LrdpInJPiEOOT/uwKkRv3eqXQi8qd3aVAWsrVwhh5FyGrQ9y2UzSzbEJTSfCr
	JNTRtrcAjHZqA2qYJkIKixq12HbmUiZVB1HAiiGJuY7QEC0a+/uPBbYYELlDXJ7Niy3UFs
	gU59ajqWM3uuCFWlxoeVAXTJp8pPgDtOpw7HAVzlJar2RjiBWwd9Bnd9eZR3d8BF65jSzO
	Q/QXkDbHlge6V3iGo7OYA/HtKVVSjUGRUMHexapeGNlZWp5rh6Oz9uiDdfv8Y9p7y1FMqi
	2LQF5oakh6k8lEJao6YfIRwXHXTTFmaazxlgQS0/qnarc32IqeVmzP+hs+jkJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721105141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uaQ8jE17m/nQQRyJzJd8jfJE2FTT2pexA8E8DWD791Y=;
	b=QXAe5qb1TJyQJf6Q8KXn5F060vXdpeKvM2pdfziZx9F9aH+FjrgmNv/zFMl0rvuxxBD7UT
	MeaXXaxPv4WGNNCw==
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Zijlstra
 <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v2 1/3] cpu/hotplug: Make HOTPLUG_PARALLEL independent
 of HOTPLUG_SMT
In-Reply-To: <20240715-loongarch-hotplug-v2-1-7d18b3d46b11@flygoat.com>
References: <20240715-loongarch-hotplug-v2-0-7d18b3d46b11@flygoat.com>
 <20240715-loongarch-hotplug-v2-1-7d18b3d46b11@flygoat.com>
Date: Tue, 16 Jul 2024 06:45:40 +0200
Message-ID: <87frsaq70r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 15 2024 at 21:35, Jiaxun Yang wrote:
> Provide stub function for smt related parallel bring up functions
> so that HOTPLUG_PARALLEL can work without HOTPLUG_PARALLEL.

That sentence does not make any sense. Also please use SMT instead of smt

Thanks,

        tglx

