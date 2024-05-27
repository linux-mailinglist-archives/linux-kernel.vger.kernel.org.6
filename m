Return-Path: <linux-kernel+bounces-191078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0106C8D063B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A5D2A4CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C42261FE5;
	Mon, 27 May 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZiJN41TC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1xUPwt9w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92D61FDC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823911; cv=none; b=P4vLYj5Jo7pR5exWJAkFYoXp7TYRAwnEcPxi1PP/Zeh2ONVFQkhdaTLeBqpGleBGR090N65yAUj3WHubHtJ/aaK8e7JExpmnIDNTIQP/j8ZENq+vtNwedqq84L2ZDC/N3m82kQP9NxacmS6dMJiJwJE0Tvil9RStFCwBr35etP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823911; c=relaxed/simple;
	bh=0UbHvLHtTQuhKckaQ9SAAS+7849UT2yadToeZlnhyt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DDMG/loqxrlkyvZL8ugf/M/fRFefnUEv30uYu+E7hlPnpLfzHSsS8x2qZmCskXXQrUvDqpc/HB6HXobqjV3mISljosuzI3xsJ6UkZA0fWwAOF4IyC9vdckcU+yapuyTgFfOBfjiJYWnmm2UKLzqW+vb5qEhWRAomo6vnbZ1zT2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZiJN41TC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1xUPwt9w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716823908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+olr0nltDlCcsHE6Yc31uQ4kYQd2Nj/pyUhaCEE4iY=;
	b=ZiJN41TCKpfn2+s4mon/TFlUPJ2ZYkmKy0QnxQMMpMgR0qgrLaW19hmPX0QRhbeukMiUs9
	64CCeyTBBuQbqfl7OJ88fhq8bsyGlQUEllRONBzaHv59l7BbKsi02AjOvVaKsg/8tYGL1s
	sAaTo6FVN15Q0t1dvpvKkWxT/0VXskKSoEf24o+tAu8Ry+uv3hNdx3cj+MKqEMkkbE1SQF
	+2sfl7uarxLwurJ2irPbEufp+uqn3eMI/d9Kv6HvfQyjjHElYi1p7XDoGKAgMtnextklhb
	LyvxkfBUVy2LVflhbZktosV5TQHbdor9CONWeazr5SJFIfN2kXtz1ZxhsFKAbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716823908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+olr0nltDlCcsHE6Yc31uQ4kYQd2Nj/pyUhaCEE4iY=;
	b=1xUPwt9wDG1VJwg7tJVRvEBKjorfN6oL3Hfme+LW7aJa7Mmy1CWCJq7qauiyrl/1YRZ8By
	/YRrXKuAvgD6A3Cg==
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: longman@redhat.com, pauld@redhat.com, linux-kernel@vger.kernel.org, Ming
 Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1 4/7] sched/isolation: Adjust affinity of managed irqs
 according to change of housekeeping cpumask
In-Reply-To: <CADDUTFx4XPtAYNUPK03BSFH0p8Z17OCftEb7aq+f6VqpnEWkoA@mail.gmail.com>
References: <20240516190437.3545310-1-costa.shul@redhat.com>
 <20240516190437.3545310-5-costa.shul@redhat.com> <87wmnrj4uz.ffs@tglx>
 <87seyfj4h7.ffs@tglx>
 <CADDUTFx4XPtAYNUPK03BSFH0p8Z17OCftEb7aq+f6VqpnEWkoA@mail.gmail.com>
Date: Mon, 27 May 2024 17:31:48 +0200
Message-ID: <87zfsbb7a3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 27 2024 at 15:21, Costa Shulyupin wrote:
> Thank you so much for very valuable feedback!
> I've tested your proposal to use the hotplug for the isolation.
> It works well for both timers, but managed irqs are not ready for this scenario.
>
> How do you suggest to proceed?

That's non-trivial because it's not only the interrupt affinity.

Drivers also have their queues associated accordingly and if you just
change the interrupt affinity under the hood then all the other
associations don't get updated and don't work.

That needs to be solved at some other level IMO.

Thanks,

        tglx



