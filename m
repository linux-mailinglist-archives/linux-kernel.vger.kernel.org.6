Return-Path: <linux-kernel+bounces-380898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC639AF769
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8475E1F22007
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BDC18991A;
	Fri, 25 Oct 2024 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qwZfTYwt"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0B22B64B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729823525; cv=none; b=ZQs3BV7SAb8nCUp1+GfiaP4cNjVzov+YBMJshSsg2l4z7ynraBQeScF+eTb3m3U+Rgy4bYAI5PpOn6Xt4V5JY9818CbX13Dl4ZAfKlzqwQqVdgR1VH9b9VgsZ2x1Q/Z4kWQELao7WZHdBOQc2+WYsf8ohqgrlFITgTEGUF9Yz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729823525; c=relaxed/simple;
	bh=AgNcZRpl0kYhebHLjHd//nbmonMeQw3355INuwWAfwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LsMrZTfgb6hu3a5xzpIOjHvjU3BL95F3YdjrERBKgpGiypsD+x/mJPfIAUoUMNnqYZ3aejaKdhWdWoeoBErkp9C6R63qjIVw7/6neoeOfDcpXsGSQxOoAguEc4uGxnCuxvKoXKPDohZcxW959RrMR8T0Us/UKptk0X4N94T0Q+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=qwZfTYwt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1729823519;
	bh=DLqU6vLdekjlRZZCwD9gnIJ2B6/IvBjWioyusl6prfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qwZfTYwt5+TDD7JV1w1VeSXVFG4at6tB2CJKZfLFDHiuL+8Tj/HdLd3uvgNl2lUjb
	 qNdvLa+SjqmKhoN/dZwYs5ioQ2nbPg7CAm07MX6k/f8e+tfKYJJnZ2+72P9HvFpw3Z
	 l1vY6FuN0zooFJdb24eKQ1OpGUI1DspLYEnqMrGjTFR1JrHtV0gAsOIveR6maiCxQh
	 DssoSvCHTOdb/SkSscMzA2YlyfnX8HFR5jU69Q2GV98bQVQuYhUAedqrA+yGtWfy7I
	 rdZaNIuG95vmcEHAjVKbB+QYR2xqpFZdifpMZuSloLYs4i2GFegjHmUrsVy3e5yZHj
	 uRV4nKHCoMZ2A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XZRcv1wQGz4wb1;
	Fri, 25 Oct 2024 13:31:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, peterx@redhat.com, groug@kaod.org,
 sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/xmon: symbol lookup length fixed
In-Reply-To: <zkm6fcxaef4gnvvsvykv7po7joytakyhqnmt2j72ej3r4wffn2@j5p6h6h2bwnw>
References: <20241023212225.1306609-2-mchauras@linux.ibm.com>
 <878que2u2i.fsf@mail.lhotse>
 <nxdkjwqtd7s3fcxebwod6lrfu7rngrj7fa4kk433hgypha66w5@6ahbuz7o2qmu>
 <zkm6fcxaef4gnvvsvykv7po7joytakyhqnmt2j72ej3r4wffn2@j5p6h6h2bwnw>
Date: Fri, 25 Oct 2024 13:32:00 +1100
Message-ID: <87a5eskj4v.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com> writes:
> On Thu, Oct 24, 2024 at 10:42:12AM +0530, Mukesh Kumar Chaurasiya wrote:
>> On Thu, Oct 24, 2024 at 12:00:53PM +1100, Michael Ellerman wrote:
>> > Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com> writes:
>> > > Currently xmon cannot lookup symbol beyond 64 characters in some cases.
>> > 
>> > Can you mention which commands? It looks like it's "ls" and "lp".
>> Sure.
>> > 
>> > > Fix this by using KSYM_NAME_LEN instead of fixed 64 characters.
>> > >
>> > > Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
>> > > ---
>> > >  arch/powerpc/xmon/xmon.c | 6 +++---
>> > >  1 file changed, 3 insertions(+), 3 deletions(-)
>> > >
>> > > diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> > > index e6cddbb2305f..22b8b5cc4df0 100644
>> > > --- a/arch/powerpc/xmon/xmon.c
>> > > +++ b/arch/powerpc/xmon/xmon.c
>> > > @@ -3662,7 +3662,7 @@ symbol_lookup(void)
>> > >  	int type = inchar();
>> > >  	unsigned long addr, cpu;
>> > >  	void __percpu *ptr = NULL;
>> > > -	static char tmp[64];
>> > > +	static char tmp[KSYM_NAME_LEN];
>> >   
>> > I think you could use the existing tmpstr buffer.
>> > 
>> > It is global so it's a little hard to track down all the users, but I
>> > think it's only used briefly in get_function_bounds(),
>> > xmon_print_symbol() and scanhex(). ie. none of the uses persist across
>> > function calls.
>> > 
>> > We don't want to have two 512 byte static arrays lying around if we can
>> > get by with one.
>> > 
>> > cheers
>> Sure.

> For now i don't think so we can get by with only one. There is a lookup being
> done when the scanhex is using the tmpstr for another lookup.

Yeah I see it, when handling `lp <symbol> <cpu>`.

That's a bit annoying because for that command the CPU number is only
meant to be a number, it never makes sense to do a $symbol lookup there.

But I agree with the way the code is structured it's best not to reuse
tmpstr there.

cheers

