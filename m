Return-Path: <linux-kernel+bounces-312687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6969699D3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4EE2863BE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A2E1AD24C;
	Tue,  3 Sep 2024 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O6TEbiJI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xP+J/uex"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0F31A3A9F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358468; cv=none; b=mUswTkd4tN1s6UOl5TBDaccC/DAAykBinrXC0mYB0qqAWAnImDUg69mbFFSYnHYZa05cy4ROVGIhvwT4SGXYFFBrwIo9mw/dVsWK0fZXMb3MPZtPA+lwoa2mjfEfepjolL9qgL3gYENdzXZIglD/l6RLlt/ni+U4R07jWBcNQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358468; c=relaxed/simple;
	bh=ifjbVcJRARSxzaG2Zrn8J1bEfYoatXAJXXx3Mh6XYvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RUmf5Kn2p7QG6EQ2Hv3nTVTmRR2Ha1Te91anU+VvMuk+ratdY1xaQ7D4T07YrwhUhIkD3U+i0zDJc5rA4j53n7H+lhT6ieYAHWCcgD9nwLDzUPm0OKmGRfugIad/i9klAm0OEEbtGBHvGDhEdM/6O1aumYgUJe7I2Apo+dSNMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O6TEbiJI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xP+J/uex; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725358465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S2y0RSJKBFb933VFQnPvL0SMKmAhiVAaZBeGvJN/ZnA=;
	b=O6TEbiJInQjmN3aB7xaGeD/QqLNnjwei3XKdI1kt8hL5S8kvlKxc21XfOSVLw0yZu42cxU
	U2WeXvyuory58IoP2AtpJ0txJ4UyDvCIVhFDc4AbRXIsDpHwTNdgeZE3jujIkh9eE42icW
	U5l1efnZ7lNuzXcvPAHG8DOe99+nZX+FFvji3NwqHDrOfGmwenYyS1xgnN/6oY+bpxGbof
	taty4iFDGPFlfhempTEqosS+7eNZpMoBMq6k4WDxg/xO9Z7tn1r6LdBu2sf+F88hy6CoLz
	4KAopwNTl2tmXBUjV6riswx+4kQsLYixeBhmBxI77L4JEXE6uISS5gGQEOHh3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725358465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S2y0RSJKBFb933VFQnPvL0SMKmAhiVAaZBeGvJN/ZnA=;
	b=xP+J/uexd05V32pqBdukCU3HWvDvDDS7LSVXaHXkM6r7CvulZ6A1W4EdSjSQK7+A9mr8tc
	fCZVMH4LAxTo3rDQ==
To: Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 5/5] debugobjects: Delete a piece of redundant code
In-Reply-To: <20240902140532.2028-6-thunder.leizhen@huawei.com>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
 <20240902140532.2028-6-thunder.leizhen@huawei.com>
Date: Tue, 03 Sep 2024 12:14:24 +0200
Message-ID: <87ikvd82nz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 02 2024 at 22:05, Zhen Lei wrote:
> The statically allocated objects are all located in obj_static_pool[],
> no one will use them anymore, the whole memory of obj_static_pool[] will

No one used them ever: nothing will use them

> be reclaimed later. Therefore, there is no need to split the remaining
> statically nodes in list obj_pool into isolated ones. Just write
> INIT_HLIST_HEAD(&obj_pool) is enough. Since hlist_move_list() directly
> discards the old list, even this can be omitted.

Nice!

Thanks,

        tglx

