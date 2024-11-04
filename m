Return-Path: <linux-kernel+bounces-395680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D69BC194
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F381C21DDF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB9D1C760A;
	Mon,  4 Nov 2024 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G33Nm19n"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E2018BBA0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763944; cv=none; b=Lsjne01Epf3AxnTOeIlLave9Qzg0nHLYudPt1L0DxXmVSAR2Iy6NqqD5Z6KrkZe4/KlEHKNW5JlldTPsUUiSP+1wHjuoAutmk6k28xDqkqTkVYyyU+efToY/xX4AGqPtVMo7nJehoYaZdv0yhL4gTa1/5O+L0Im2MZJp6fvNKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763944; c=relaxed/simple;
	bh=y25cMTUUyF0/99NqsbtcP8jgiSIGKszQIxKzLAtVRw4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Xs7UB12sbNU4CbDPNgNqmia1JR9bsI+Mq8Eu9qXux56JbapOUu3lbTfoa/Ohu2pkkMOjnQmNBoD7FBm4nDiL/JzudYfYfTNZXaSsvAtGoAgfVeIBJH1WMg6igoZmVpP2i1aF+jmeM8YmfstOCR0p+HHhT2RnBW4F4JecmaLTM9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G33Nm19n; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730763941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIaWWipbF4qkR4a9YyY0itn1/4GTLYbehO8LrldGbCM=;
	b=G33Nm19nK2jEjj++crEGNt5NkSKYIYxj6iXTp2AE8oOuzAcRO55cYfRYHTiTiiK4Ry6tZG
	V/7tbxyuM2t1qAC8ypNPxXyw3gFERim7uUTnm1dNYfaL3BaQz8+ZSIRZghi/UhEY59j83O
	SUS7zLKLnBa6GyGVDX/xSIoQGGNnhuE=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] MIPS: kernel: proc: Use str_yes_no() helper function
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <alpine.DEB.2.21.2411031921020.9262@angie.orcam.me.uk>
Date: Tue, 5 Nov 2024 00:45:28 +0100
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F2FC5695-440E-4A29-B683-4335452F6FAB@linux.dev>
References: <20241102220437.22480-2-thorsten.blum@linux.dev>
 <alpine.DEB.2.21.2411031921020.9262@angie.orcam.me.uk>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
X-Migadu-Flow: FLOW_OUT

On 3. Nov 2024, at 20:29, Maciej W. Rozycki wrote:
> On Sat, 2 Nov 2024, Thorsten Blum wrote:
> 
>> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
>> index 8eba5a1ed664..3e4be48bab02 100644
>> --- a/arch/mips/kernel/proc.c
>> +++ b/arch/mips/kernel/proc.c
>> @@ -66,12 +66,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>> 	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
>> 		      cpu_data[n].udelay_val / (500000/HZ),
>> 		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
>> -	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
>> +	seq_printf(m, "wait instruction\t: %s\n", str_yes_no(cpu_wait));
>> 	seq_printf(m, "microsecond timers\t: %s\n",
>> -		      cpu_has_counter ? "yes" : "no");
>> +		      str_yes_no(cpu_has_counter));
>> 	seq_printf(m, "tlb_entries\t\t: %d\n", cpu_data[n].tlbsize);
>> 	seq_printf(m, "extra interrupt vector\t: %s\n",
>> -		      cpu_has_divec ? "yes" : "no");
>> +		      str_yes_no(cpu_has_divec));
>> 	seq_printf(m, "hardware watchpoint\t: %s",
>> 		      cpu_has_watch ? "yes, " : "no\n");
>> 	if (cpu_has_watch) {
> 
> I like this cleanup, but now that it matters I suggest restructuring code 
> such that the latter `seq_printf' is converted as well.

What about the comma and newline? Using str_yes_no() would remove them.

Thanks,
Thorsten

