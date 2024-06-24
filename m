Return-Path: <linux-kernel+bounces-227963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD0C9158D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72381F25728
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9351A1A0B04;
	Mon, 24 Jun 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tz+gFrvu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HbupGoOK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264421A0AE4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264255; cv=none; b=arWi78VkjrWuBhIr1QtOuPSkOylIDpGsYBmeYNiGiwhntS7JQoCxgTZt68LAAef1udm8emWC54cuwXsMqdYxnt7Yd+GFtbBd8VB1ckavEGU3uW5ZMB+Xq32E+fOaM68sswEm+s2meniz316lP+FY2mxOxxNflz3NLM191YKZjF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264255; c=relaxed/simple;
	bh=eA0l/+fsdLlzJj8Zk8hFYUQlaohMOtVyOubF+tbXBvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pNih76n98HdKLsB7jofiBI5qlDg9llR6HKd9sNLMRzoqJA43/e2uYsRtXiuEvehsMyhLIJKLyVLoR2+OafIOcQCeTj61T9Phb0zfWgag5DCmHwktGh8yMbdM2YmuM/tQ+plKHfXXcpuDUjCKJnCCH9p+t4nzKqoAw40wIiRk4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tz+gFrvu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HbupGoOK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719264251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr9WmSDhp5Pq84URL18JMexmAFXY3Csonubc3aMd8lQ=;
	b=tz+gFrvuToWeWpYe3wCQRoEcGse3at8VZEQyWQ+k+EUUb9IDzCHDvlh5yB1X+rj0YIhB8a
	HDBowP0IhCwJvGaicP02fjiXkRhuE6XhdUVdKiijkXqiy1DevLf+2+Lut0qCizemB7iAS9
	j0eOQ3WSDJwJeowJT+ZOPAn39opOo04EwGlEpRv+KaOjhSlbryRHGOPcy3gIp54gIDI7LL
	P+wLu0ktQQ1w/Ej20YAQrqFAWnWmm+hE5kI+JCIqzlylbi1JTVwHX6EIe6MuvoR8rryOPT
	xlzHEcAJrMQe3wKjJ7Pp9dyDvgnoJNpfp9IbsAs10w5EEf4rtC6o8GvZfqQyJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719264251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr9WmSDhp5Pq84URL18JMexmAFXY3Csonubc3aMd8lQ=;
	b=HbupGoOKwbs9B4LuupdDTvFxud2EW+UdhYv4hV27FKPOE5Ux6NByLKP9JG1pXAzXqms4gu
	XgyAEEpj2K63AyAw==
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, Michal Suchanek
 <msuchanek@suse.de>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>,
 Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 "Nysal Jan K.A." <nysal@linux.ibm.com>
Subject: Re: [PATCH 0/2] Skip offline cores when enabling SMT on PowerPC
In-Reply-To: <11f9cc04-91eb-4a70-9ff0-5c6f24483cd3@linux.ibm.com>
References: <20240612185046.1826891-1-nysal@linux.ibm.com>
 <875xudoz4d.fsf@mail.lhotse> <87ikxza01w.ffs@tglx>
 <11f9cc04-91eb-4a70-9ff0-5c6f24483cd3@linux.ibm.com>
Date: Mon, 24 Jun 2024 23:24:11 +0200
Message-ID: <87sex26nlw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 25 2024 at 00:41, Shrikanth Hegde wrote:
> On 6/24/24 1:44 AM, Thomas Gleixner wrote:
>> Right. So changing it not to online a thread when the full core is
>> offline should not really break stuff.
>> 
>> OTH, the mechanism to figure that out on x86 is definitely different and
>> more complicated than on power because the sibling threads are not
>> having consecutive CPU numbers.
>
> wouldn't topology_sibling_cpumask have this info? 
> If the mask is empty does it mean the core is offline? 

The mask is not yet available for the to be brought up CPU. That's
established when the CPU boots. It might work because all threads are
brought up during early boot for !~*&^!@% reasons, but then it won't
work under all circumstances, e.g. 'maxcpus=$N'.

We could fix that now with the new topology enumeration code, but that's
a larger scale project.

Thanks,

        tglx

