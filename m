Return-Path: <linux-kernel+bounces-441829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D7A9ED4A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50693188B147
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDC6202F95;
	Wed, 11 Dec 2024 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="E1D1YZaj";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b="Qjf7X1Qd"
Received: from mail180-34.suw31.mandrillapp.com (mail180-34.suw31.mandrillapp.com [198.2.180.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE524632E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941245; cv=none; b=dJ4T4SerbDotWG7TyRGDL0py6O1vyGJAdhsXfjdVPOVt5/NAXCYQ/4h9yEIOk6JeAi8lBFUOz1DwBBtCQnvFuWSJa7+bUuYVUbxpY7XeWKkhUpOrJRlvlGlKkI+t+rmZLe4izvXuNbk8XoKfNLT2kN4WuLw5LtVHQbxqWBkYZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941245; c=relaxed/simple;
	bh=n5VVl5QaPLjUZ02X3+mGtYnCQ0jrvsHufFqhztiDDJA=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=K7+qW/50W8yYU4wXl1h7kz+TzP3hwikgu1h54SwX5DRz2PhWBvS0VdJT5wi9iRAaMmw2qA67ZJyyW/3I4sSLdLj+6k1fiIePU0dN7Bjtq8glF/OiENccwMktlKNRgNMfIzjeeS440Bpxf/SQuhIXu8at1OwIrCY1A6fKB/cych0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=E1D1YZaj; dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b=Qjf7X1Qd; arc=none smtp.client-ip=198.2.180.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1733941242; x=1734201742;
	bh=MXx6097v6tjQI3SQM06xqM84N8iVt7qg7svrUgiSIKg=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=E1D1YZajnoMjzN+ieyaoHkZqoS1RZhpYRmIVPuufDJccAU71ndZSYSXKZCet8qIF8
	 HyVber+GAoubTVzxZdAQvPrd6W8wQTdzd9+COmK41ihwv/ciGUG0Sye8CNwQZfLP0i
	 DpSzgVU+quhOCkFwFPsV6AhTEZeKj4C8Drjx+7RyYeqz/NoagfaeYJKFuPZ2FD6wRM
	 kEQp7u6+eUn8lwwDhN5fjJnS+OWKnvAy7uoF73SNcb38tENat8Wqqhaly6nO5BXY7k
	 xMdCJOsB7MiPpH+jjV20iZFDPyHQn7Bcl+H+fuK5ixdOFakJt19CetT6X36kpVful1
	 tvg4Yntkk/JHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1733941242; x=1734201742; i=thierry.escande@vates.tech;
	bh=MXx6097v6tjQI3SQM06xqM84N8iVt7qg7svrUgiSIKg=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=Qjf7X1Qd25xAllQqBLbftaSrr9xuC4D6WKG4sL6pdWKCvkKBUvdJSNjii4an4yOL1
	 ZNm+I1ZOU/5xwktb0XYbQ76LhmYl1WUvs+JoBSuufG+QeQ/8DkPXta23lMCiZgUH7B
	 o/ZHRVcNH7frb2UQto098Z7d1lBb84AaBvSjD0qsuWfbhtHvCmvvpJfVRs+iTEySpS
	 gj8v0JDp65yDFRPfKe4fcrApJKfyV72BxXJGYPtda/091+q/CzfOvIi7UvDoZZ1R3Y
	 /WRu43er2Fi5QOnG7h8F/JjnOChQLBceMpM5pMOua84XO5CsqA8sEADBLiFjZDRKps
	 OHrTs6t68izZg==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-34.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4Y7kRt15nLzS62Nlx
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:20:42 +0000 (GMT)
From: "Thierry Escande" <thierry.escande@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH]=20x86/xen/mmu:=20Increase=20MAX=5FCONTIG=5FORDER?=
Received: from [37.26.189.201] by mandrillapp.com id de39c58dc4204eb3bb537dcbf87dab09; Wed, 11 Dec 2024 18:20:42 +0000
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1733941240628
Message-Id: <cc61bdce-47af-45ea-8ace-173adef9ae41@vates.tech>
To: "Jan Beulich" <jbeulich@suse.com>
Cc: sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, xen-devel@lists.xenproject.org, "Juergen Gross" <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20241204171346.458105-1-thierry.escande@vates.tech> <ccb28ccc-531c-4ead-9a27-76cc430f8c35@suse.com>
In-Reply-To: <ccb28ccc-531c-4ead-9a27-76cc430f8c35@suse.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.de39c58dc4204eb3bb537dcbf87dab09?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20241211:md
Date: Wed, 11 Dec 2024 18:20:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Jan,

On 09/12/2024 11:04, Jan Beulich wrote:
> On 04.12.2024 18:14, Thierry Escande wrote:
>> With change 9f40ec84a797 (xen/swiotlb: add alignment check for dma
>> buffers), the driver mpt3sas fails to load because it cannot allocate
>> its DMA pool for an allocation size of ~2,3 MBytes. This is because the
>> alignement check added by 9f40ec84a797 fails and
>> xen_swiotlb_alloc_coherent() ends up calling
>> xen_create_contiguous_region() with a size order of 10 which is too high
>> for the current max value.
>>
>> This patch increases the MAX_CONTIG_ORDER from 9 to 10 (4MB) to allow
>> such allocations.
>>
>> Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
>> ---
>>  arch/x86/xen/mmu_pv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
>> index 55a4996d0c04..7f110740e1a2 100644
>> --- a/arch/x86/xen/mmu_pv.c
>> +++ b/arch/x86/xen/mmu_pv.c
>> @@ -2200,7 +2200,7 @@ void __init xen_init_mmu_ops(void)
>>  }
>>  
>>  /* Protected by xen_reservation_lock. */
>> -#define MAX_CONTIG_ORDER 9 /* 2MB */
>> +#define MAX_CONTIG_ORDER 10 /* 4MB */
>>  static unsigned long discontig_frames[1<<MAX_CONTIG_ORDER];
> 
> While lacking respective commentary, bumping this value imo also needs to
> take into account Xen itself, at least commit-message-wise. The bumping is
> fine for Dom0 in any event. It is also fine for DomU-s with the defaults
> built into the hypervisor (orders 12 and 10 respectively for x86 and Arm),
> yet especially for Arm (and in the future PPC and RISC-V) any further
> bumping would be less straightforward.

Thanks for pointing this out. On the Xen side, CONFIG_CTLDOM_MAX_ORDER
and CONFIG_HWDOM_MAX_ORDER seem big enough on all architectures. But I
see CONFIG_DOMU_MAX_ORDER set to 9 (also all archs). Won't that be a
problem for drivers trying to allocate more than that from a domU ?

> However - does the driver really need this big a contiguous chunk? It
> would seem far more desirable to me to break that up some, if possible.

Since this works on bare metal I'm afraid the driver maintainer (mpt
fusion driver) will just tell me to fix Xen.

Regards,
Thierry

> 
> Jan

