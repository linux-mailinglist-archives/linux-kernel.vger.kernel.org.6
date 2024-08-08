Return-Path: <linux-kernel+bounces-279626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD12D94BFB5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450CEB21CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C740418EFD6;
	Thu,  8 Aug 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OAEjrfh5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6K0SroPc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972418EFDB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127668; cv=none; b=DsmCBhBfUQXfirwU78OMazSp4ckBdjcyYJGuH5WhkCrjpJNXu0+eKzBZeIy5iEDRNL9FahlnS7n1FnBCN/0QnYutARYnj2D4Ul5Eh+FM3RCGxYZSBoMxFZ30sAerLzXaXhoOEbAO4cac1t5ZwWjEbytGquSL7HHnZH8pHxqFnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127668; c=relaxed/simple;
	bh=+2NQOIddLJ+p9eIa9ZugMq+/O7MnsshVW7/13nhEenM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GLXAVUFvXXIgiZqhHeBCzEIlyYBvM5OaPW5ZdJZPClOjrx0cDLMpHYzd8ffqm9R1ZGHqoypca2lwr4RAyB1zdmdkCl1Y922QgBAbPceZBvHt0YyMfIMxtc1VuDbVVmQM+d2MEM9wl12thajxZYkNu9rjuSBVLxyEO3fGPf0qsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OAEjrfh5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6K0SroPc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723127664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56JIhtAX+5tOSqzvAGOcw58QIyjuchVrNY7VzC2OwUU=;
	b=OAEjrfh5LabLUYOHhJ2S67zWlr9ttNgdeoLVLiFenlhcLvgNZyMuryw76CijFPbsmhffyv
	NHAEnSaW/P0o3JpUR+TzJTTLrLt6nUIyX03lFTtJcRkc5S0B1WN4htJo72ZS0GHbKBTJzI
	k9bE82poRhKhz19gbeJNN4aZTH8AFD8ArUz24FfxL0Krvy+WxQhYW5aclTwjssauSc/w0Y
	JPq1JgqbK/If813g5nIBIXQxjGQ4Gqbtbj6OG7YN73XC9Q9dZzWYnWCyhtuDqzbkfmvLJW
	461mUo8rXrjX3adnVI5hKaOf7Gko3vAlSurdOaNDaaYmcyQU9zhbYZqEFOvu3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723127664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56JIhtAX+5tOSqzvAGOcw58QIyjuchVrNY7VzC2OwUU=;
	b=6K0SroPcULZwFmvxD9M+p6+xaa98sN6d20R2AmtFksXTKVfmEUmwP1L4BN3vntSbLbFfch
	HtXG1bIMnM41rGAw==
To: Anup Patel <anup@brainfault.org>, Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 greentime.hu@sifive.com, vincent.chen@sifive.com, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 1/1] riscv-aplic: manually set pending for the
 pre-existing interrupts
In-Reply-To: <CAAhSdy3VKMngwHxOg5+z6pK3QgZnLv=3+hpZBeUm87L_e62aUQ@mail.gmail.com>
References: <20240808081412.24553-1-yongxuan.wang@sifive.com>
 <CAAhSdy3VKMngwHxOg5+z6pK3QgZnLv=3+hpZBeUm87L_e62aUQ@mail.gmail.com>
Date: Thu, 08 Aug 2024 16:34:24 +0200
Message-ID: <87ikwbytfz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08 2024 at 18:56, Anup Patel wrote:
> More appropriate patch subject should be:
>
> irqchip: riscv-aplic: retrigger interrupt in MSI mode upon write to
> sourcecfg register

And the correct one would be:

    irqchip/riscv-aplic: Retrigger MSI interrupt on source configuration

1) The prefix is correct

2) Sentence starts with a uppercase letter

3) It uses understandable words. sourcecfg is a implementation detail
   which is irrelevant for the high level overview of a changelog
   subject, which is visible in the short log.

> On Thu, Aug 8, 2024 at 1:44=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifi=
ve.com> wrote:
>>
>> The section 4.5.2 of the RISC-V AIA specification says that any write
>> to a sourcecfg register of an APLIC might (or might not) cause the
>> corresponding interrupt-pending bit to be set to one if the rectified
>> input value is high (=3D 1) under the new source mode.
>
> Add quotes around the text from RISC-V AIA specification.
>
>>
>> If an interrupt is asserted before the driver configs its interrupt
>> type to APLIC, it's pending bit will not be set except a relevant
>> write to a setip or setipnum register. When we write the interrupt
>> type to sourcecfg register, if the APLIC device doesn't check and
>> update the pending bit, the interrupt might never becomes pending.
>
> The second sentence above can be re-written as follows:
>
> When interrupt type is changed in sourcecfg register, the APLIC

the interrupt type ... in the source....

> device might not set the corresponding pending bit, the interrupt

bit , so the ...

> might never become pending.

>
> Define APLIC MSI mode specific irq_set_type() like below:
>
> int aplic_msi_irq_set_type(struct irq_data *d, unsigned int type)

static :)

> {
>        int rc;
>
>        rc =3D aplic_irq_set_type(d, type);

         int rc =3D aplic...

>        if (rc)
>               return rc;
>
>        /*
>         * Updating sourcecfg register for level-triggered interrupts
>         * requires interrupt retriggering when APLIC in MSI mode.

APLIC is in ....

>         */
>        aplic_msi_irq_retrigger_level(d);

Thanks,

        tglx

