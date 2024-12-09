Return-Path: <linux-kernel+bounces-437168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74D19E8FE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF03D1883AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E97216E28;
	Mon,  9 Dec 2024 10:15:16 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5741B14F12D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739316; cv=none; b=aA5yfKBDxxW28HDQSFEzPOrjWQCGxKbEVI+trpcqLj2Awc3TcqiAbiE0tPj0dYMex/6mcEgfqM1OI/EW/PHDPIf/7sdKZWBx4fk4XpFrRwiKvAgAr5UtN98GVansRn2cK0F9F3K2m5X2VBQLzvKgXLyBZmwNEYinwxbXj030Shs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739316; c=relaxed/simple;
	bh=e2BIJ6svlRpJT4zzT6x2Si6sF7SK2oPCINx6ChrmOQQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pelYYi6fodSMnB1unUHoe0TpEK38lBhZ8I4GD+S0IC4HtloPdtZ72j3z5jLUV/iW08jTH1UEtCGuYl3Ycn4jiD/1f051iT0ctx35j0z8ElUMcxyOQVph/Gppoxpk3fYeNp/LA7QNP9XG+nnKvrvtud82am3+TucBK1PaPX0tiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y6HlV2Zj2z6LDHp;
	Mon,  9 Dec 2024 18:14:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BE9A1402DB;
	Mon,  9 Dec 2024 18:15:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Dec
 2024 11:15:04 +0100
Date: Mon, 9 Dec 2024 10:15:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
	<shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
	<anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
	<linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 08/16] acpi/ghes: don't check if physical_address is
 not zero
Message-ID: <20241209101503.000010b9@huawei.com>
In-Reply-To: <20241204141246.37a7cb9d@imammedo.users.ipa.redhat.com>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
	<95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733297707.git.mchehab+huawei@kernel.org>
	<20241204141246.37a7cb9d@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 4 Dec 2024 14:12:46 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed,  4 Dec 2024 08:41:16 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The 'physical_address' value is a faulty page. As such, 0 is
> > as valid as any other value.
I'm not sure what a 'faulty page' is. but code looks fine.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> > ---
> >  hw/acpi/ghes.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index edc74c38bf8a..a3dffd78b012 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -400,10 +400,6 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> >  
> >      start_addr = le64_to_cpu(ags->ghes_addr_le);
> >  
> > -    if (!physical_address) {
> > -        return -1;
> > -    }
> > -
> >      start_addr += source_id * sizeof(uint64_t);
> >  
> >      cpu_physical_memory_read(start_addr, &error_block_addr,  
> 
> 


