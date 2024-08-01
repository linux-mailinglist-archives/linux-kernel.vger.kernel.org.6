Return-Path: <linux-kernel+bounces-271428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5101944E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A073E283C56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84041A4F31;
	Thu,  1 Aug 2024 14:33:04 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F671E4AB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522784; cv=none; b=aZ7U66Qfpjeni6KxHTm+UMSCUl2efpaoU2DtyZHj/mVe6BE2K8AAhcD/xRMA/liasZf4Beg7Yd3zz3rMgSUww7uYMBZTghq9+SyuMQ1bUg4utWkWjiWHTgs1NsO2+wPI+NMCby/ktynb2oC5+NgnJnRmR3PtcDA90vGiNERGimU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522784; c=relaxed/simple;
	bh=Rd0BXWWYsLO4emq1r5gtrd7pXCh+Aat7hf2/5V1xsA8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYUZtTg4chyYXeI4xskpklo1LERopvzJJ1TvGDAe2JQVUPAbzqDC5iFkJv6XvQ9qU7O5SvzJUGEQBq1opLyWH9/qYmSWJpFaUQUe8NSIM9kKAxGJppwcF3MX9+UOM48jkhLZuy/gXvEWP+qTSOXs42x1PU6PtNb4rbDikRo1mOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WZWb307f0z687SH;
	Thu,  1 Aug 2024 22:30:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A2E931400F4;
	Thu,  1 Aug 2024 22:32:58 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 1 Aug
 2024 15:32:58 +0100
Date: Thu, 1 Aug 2024 15:32:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 3/7] acpi/ghes: Support GPIO error source.
Message-ID: <20240801153257.00006e30@Huawei.com>
In-Reply-To: <20240801145637.03c34fd3@foz.lan>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<64a31a09fe6b11bebad1c592ad20071a9d93fee5.1721630625.git.mchehab+huawei@kernel.org>
	<20240730104028.4f503d91@imammedo.users.ipa.redhat.com>
	<20240801145637.03c34fd3@foz.lan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 1 Aug 2024 14:56:37 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 30 Jul 2024 10:40:28 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > > index 674f6958e905..4f1ab1a73a06 100644
> > > --- a/include/hw/acpi/ghes.h
> > > +++ b/include/hw/acpi/ghes.h
> > > @@ -58,6 +58,7 @@ enum AcpiGhesNotifyType {
> > >  
> > >  enum {
> > >      ACPI_HEST_SRC_ID_SEA = 0,
> > > +    ACPI_HEST_SRC_ID_GPIO = 1,    
> > is it defined by some spec, or just a made up number?  
> 
> I don't know. Maybe Jonathan or Shiju knows better, as the original patch
> came from them, but I didn't find any parts of the ACPI spec defining the
> values for source ID.

> 
> Checking at build_ghes_v2() implementation, this is used on two places:
> 
> 1. as GHESv2 source ID:
>     /*
>      * Type:
>      * Generic Hardware Error Source version 2(GHESv2 - Type 10)
>      */
>     build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
>     /* Source Id */
>     build_append_int_noprefix(table_data, source_id, 2);
>     /* Related Source Id */
>     build_append_int_noprefix(table_data, 0xffff, 2);
> 
> as an address offset:
> 
>     address_offset = table_data->len;
>     /* Error Status Address */
>     build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>                      4 /* QWord access */, 0);
>     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>         address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
>         ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
> 
> So, if I had to guess, I'd say that this was made up, in a way that
> the size of the table will fit just two sources, starting from zero.
> 
> So, I'll change the code to just:
> 
> 	enum {
>             ACPI_HEST_SRC_ID_SEA = 0,
>             ACPI_HEST_SRC_ID_GPIO, 

LGTM.  The naming is perhaps not ideal but the scheme predates my
involvement so I'm not sure of the reasoning.  Could change it
to QEMU_ACPI...
to make it really really clear these aren't an ACPI spec thing, but
may not be worth it.

J

> 	    /* future ids go here */
> 	    ACPI_HEST_SRC_ID_RESERVED,
> 	};
> 
> To remove the false impression that this could be originated from the
> spec.
> 
> Thanks,
> Mauro
> 


