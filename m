Return-Path: <linux-kernel+bounces-252165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7B7930F53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F11281C24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D0184122;
	Mon, 15 Jul 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CExgGxm6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vdDiQCh+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CB13C675;
	Mon, 15 Jul 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030817; cv=none; b=Zb1SUzkL4tF/Gcc6vwu90R1s8ca7eR0ZTeiKWPll2Q9LJcU4NYIXQkHTrxa9Yx9JUdkc3KtbhVielJlM0cozjNlXoNrN6xb1dp66S8ixlWZdty73pQWGSOSeN70jYEfEJqFQ4FSbTF3klQK8bruwFASURTk9buc+uVJJKkWVI3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030817; c=relaxed/simple;
	bh=7YujJ58JAUiEiLlpeQYYGwWLqSpq+RCy4LINlfizq0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jVJhS+h0+MEKbQ769oUK0wCHBwMx3XivT7jGZBE0mdU+/fkU0g6BEjUhJGRC+Z+WPpMuFCEcp7xmsHVxTun7T26LZlscRzVjsi3LhN6PB2imwa8rt0uKQguyBPlaDyqYFIjGpLLkymGATcxmhiUwW7lTD47RFOZlcud7RUhaV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CExgGxm6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vdDiQCh+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721030812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UrCE+tWwercwWOMRYhvPT4z8urMVCMmgX9xd1PRsIQ4=;
	b=CExgGxm6iVLe6jv/YS7j5Hym7tNSJhU9UBWIXYPFKopQM5UEgbPal0DOAqIbF8EXX3A8Ci
	9fE06ejWfXWNXM180P3a2h58hfnO56py5IS7tUzfdO1SSM9qs9QwCYmrucYPznhDQEo/Ic
	ywbELAzHVLir/LwZhKFvN6Y5D8KXARJL6z/qPDwDZsBT/1WMz0rJY3gX1b5r5RSMMcnc4B
	RO636do2vk5r1J38r2ymus+UvoaqALLITsHMAPm6FNqDVd52p39Hb5I/NALJYwHixkX1zK
	g4tNFNUDDha6k2J0zxPBcukeAhEWcj0mnwc2NbcoNyTUufWqy6kwNUNK8UzOyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721030812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UrCE+tWwercwWOMRYhvPT4z8urMVCMmgX9xd1PRsIQ4=;
	b=vdDiQCh+OMsDNu3RCK6FaO8oBWqQASmMjuf5aP9AYwMmWFkRCgUTBtHLi116hpSbvkjmno
	6u4altadHcvNDoDA==
To: Rodolfo Giometti <giometti@enneenne.com>, "D, Lakshmi Sowjanya"
 <lakshmi.sowjanya.d@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "Dong, Eddie" <eddie.dong@intel.com>, "Hall, Christopher S"
 <christopher.s.hall@intel.com>, "N, Pandith" <pandith.n@intel.com>,
 "Mohan, Subramanian" <subramanian.mohan@intel.com>, "T R, Thejesh Reddy"
 <thejesh.reddy.t.r@intel.com>
Subject: Re: [PATCH v10 0/3] Add support for Intel PPS Generator
In-Reply-To: <d463bd28-9890-47a5-97cc-14f96db2db22@enneenne.com>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <CY8PR11MB736490B761DBA045513AF078C4DD2@CY8PR11MB7364.namprd11.prod.outlook.com>
 <d463bd28-9890-47a5-97cc-14f96db2db22@enneenne.com>
Date: Mon, 15 Jul 2024 10:06:52 +0200
Message-ID: <87r0bvqdsz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 04 2024 at 13:50, Rodolfo Giometti wrote:
> On 03/07/24 16:47, D, Lakshmi Sowjanya wrote:
>> 
>> A gentle reminder for the review of the pps patchset.
>
> I already acked these patchset, didn't I? =8-o
>
> Please let me know if I missed something.

Sorry, I missed that V10 posting. It's too late now.

Rodolfo, can you pick it up after rc1 for the next merge window. All
prerequisites should be in Linus tree then.

Thanks,

        tglx

