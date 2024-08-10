Return-Path: <linux-kernel+bounces-281816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3AC94DBA8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B91F22028
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD4514C5B5;
	Sat, 10 Aug 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gbhv6SRq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+AtkMm0Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66B14A4F3
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723280003; cv=none; b=foIyWhLYp1YeETgZkAXyhJq3wiHI1y39t+F6VOuOy3Kv0zenpgif0yOW5vUWhSZQ14Ei7o4dR9RbQJUe3Kvx10CEUTdXLhPTcC+auQJNjXhbSXAz4o0JvS7db5sNodw6MvrMnqHYuVuZjp67o9rPBWSUqeaUXobKgJIjVlhP8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723280003; c=relaxed/simple;
	bh=UhYjpudx3SxjPpHyVTGfDMJRGx/55uf1a3/q9qZ+3bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dpUmcrUEO8PUPCwxhYcqcFLm0i8SyL8trD6y+NXhpOZhNPU2hOfBTTcPoD23IrWawRGs/s5T7N/KCkN9WEcahO9Or4XcejZyQA1i53rk3r7HHwDrlhHTTxuKcrSUP5Pine+te8PvNGCMizLLbR+RKPAe74KAjE5vcB3q3XQb93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gbhv6SRq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+AtkMm0Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723280000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YO2I0ViuhiWdNtClNRT0OKS9Uzyp4fzuS/BNI0uow8=;
	b=gbhv6SRq33YXNMxmcILsrRARY6t9CYskXmyiUEAR6jE/P9JP0zM8iso4sfSW5I3Li/zcJj
	vDL1wcHBW8TsJR5MLKTIZ3BbqSNbi7FXPfnVvzRNVrP9s2uFjED1esFGhzepX+oMRrCqqF
	Q5XWaSnj6AgLsYsN5WhFpbf3tMMpbVX8oWxf4E/lY6/61FsBBqpnsw/o3Bu7iF1ip0WwgS
	GXBSK4ltZmgE9/kh/RLdeELiZH/w+Dn3Zdkx5xTEU7VzGmGkxKEVCV1PqlwqSGWSEBMWku
	iUwWAzB0deIeq4vQscp27h3UORzWFPeVzh9XQNiYdZoDy0PXdri1lMHYTZyzXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723280000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YO2I0ViuhiWdNtClNRT0OKS9Uzyp4fzuS/BNI0uow8=;
	b=+AtkMm0Z2VefRW7KoHtk0zWPL/MQyXD0G2EA3XEg9ehHuyUJPMcuZ6uZ0eKFnEkRP2cJxZ
	+Z8eZkfNz/Ym9LBA==
To: Xavier <xavier_qy@163.com>, anna-maria@linutronix.de,
 frederic@kernel.org, j.granados@samsung.com, linux@weissschuh.net,
 mcgrof@kernel.org, kees@kernel.org
Cc: linux-kernel@vger.kernel.org, Xavier <xavier_qy@163.com>
Subject: Re: [PATCH v1] Namespace: Optimize the namespace code
In-Reply-To: <20240809121732.545807-1-xavier_qy@163.com>
References: <20240809121732.545807-1-xavier_qy@163.com>
Date: Sat, 10 Aug 2024 10:53:19 +0200
Message-ID: <8734ncu5c0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 09 2024 at 20:17, Xavier wrote:
> Modify variable names in the function clone_time_ns to enhance
> readability, and optimize the memory release operation by placing
> it outside of the spin lock in alloc_ucounts.

Renaming variables is not an optimization. Don't do two things at once.

Also the rename is not adding any value. This code is about time
namespace so 'ns' is perfectly understandable.

Thanks,

        tglx

