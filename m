Return-Path: <linux-kernel+bounces-420933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA49D8483
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5D5169913
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205F91922F0;
	Mon, 25 Nov 2024 11:31:41 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590441531E9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534300; cv=none; b=GYmBC6UhRGhT2wkUW9w0nj9UbLVe+WbtyUIK/SG5BDQhmkcWhccJXvNbvY3PncaxHJmyl8tM3pUAlRd2FR4EH0j/Xa2bc9SkQzo/p+0HGUiLIbct5mGIYqpIJwaulk6OeA/f09bRJiQZe5X5Nj1+ZNcFDP2hkyvpD8tbYCDd0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534300; c=relaxed/simple;
	bh=tSR2gqF0QhQtoXA9X1m5m0/xdlXG1HpduI1LhY8jPuk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCUc7FK1YAWjE4YnUgvF0ewGJ4dYh2S0DXcHmGxdLMVu76KsxRJiuiIvbtuzu9lDZB/Po+5k6bPbGNlgl8Y0vUHkNXntjRKo2nTicdzSLqgzX22wnlzR1MZskOoS7jE9+F8lT7IdsB3nLHQwMvgt0IaNUQTVYPRe2V24d2T+nyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xxk4H5x5Xz6K9Jr;
	Mon, 25 Nov 2024 19:29:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DE5821400CB;
	Mon, 25 Nov 2024 19:31:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 25 Nov
 2024 12:31:34 +0100
Date: Mon, 25 Nov 2024 11:31:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/6] acpi/ghes: Use HEST table offsets when preparing
 GHES records
Message-ID: <20241125113132.000069e1@huawei.com>
In-Reply-To: <20241122113714.04450f6b@foz.lan>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
	<cf60aee0059d12755c1b9deb2dddb355d8543297.1731486604.git.mchehab+huawei@kernel.org>
	<20241120145930.00003895@huawei.com>
	<20241122113714.04450f6b@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)


> >   
> > > 
> > > Yet, keep the old code, as this is needed for migration purposes.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  hw/acpi/ghes.c | 98 ++++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 88 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index c93bbaf1994a..9ee25efe8abf 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -61,6 +61,23 @@
> > >   */
> > >  #define ACPI_GHES_GESB_SIZE                 20
> > >  
> > > +/*
> > > + * Offsets with regards to the start of the HEST table stored at
> > > + * ags->hest_addr_le, according with the memory layout map at
> > > + * docs/specs/acpi_hest_ghes.rst.
> > > + */
> > > +    
> > /*
> >  * ACPI 6.2:
> > 
> > to be consistent with local style.  
> 
> Actually, the local style inside this file was preserved. See, before
> this series we have:
Ah. That's me being lazy and unclear :(
What I meant was

/*
 * ACPI 6.2:  18.3.2.8 Generic Hardware Error Source version 2

So open the comment with a blank line.
 
> 
> $ git grep "ACPI " hw/acpi/ghes.c
> hw/acpi/ghes.c: * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> hw/acpi/ghes.c: * ACPI 6.2: 18.3.2.7.1 Generic Error Data,
> hw/acpi/ghes.c: * ACPI 4.0: 17.3.2.7 Hardware Error Notification
> hw/acpi/ghes.c: * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> hw/acpi/ghes.c: * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> hw/acpi/ghes.c:    /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> hw/acpi/ghes.c:         * ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> hw/acpi/ghes.c:     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
> 
> >   

> > 
> >   
> > > +        return;
> > > +    }
> > > +
> > > +    cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
> > > +    num_sources = le32_to_cpu(num_sources);
> > > +
> > > +    err_source_struct = hest_addr + sizeof(num_sources);
> > > +
> > > +    /*
> > > +     * Currently, HEST Error source navigates only for GHESv2 tables
> > > +     */    
> > 
> > Feels like duplication of the comment below where the type check is.
> > Maybe drop this one?  
> 
> If I recall correctly [1], Igor asked to place such comment, on one of
> the past versions of this code.
> 
> IMO, placing it clearly there helps to identify what needs to change when
> support for non-GHES tables is needed.
> 
> [1] this is the 12th version of this code - my memory is starting to fail
>     to remind were exactly each change was requested.
Me too! :)


> >   
> > > +        addr += sizeof(type);
> > > +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
> > > +
> > > +        if (src_id == source_id) {
> > > +            break;
> > > +        }
> > > +
> > > +        err_source_struct += HEST_GHES_V2_TABLE_SIZE;
> > > +    }
> > > +    if (i == num_sources) {
> > > +        error_setg(errp, "HEST: Source %d not found.", source_id);
> > > +        return;
> > > +    }
> > > +
> > > +    /* Navigate though table address pointers */
> > > +    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
> > > +    hest_read_ack_addr = err_source_struct + GHES_ACK_OFFSET;    
> >   
> > > +
> > > +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> > > +                             sizeof(error_block_addr));    
> > So this points to a registers  
> > > +
> > > +    cpu_physical_memory_read(error_block_addr, cper_addr,
> > > +                             sizeof(*cper_addr));    
> > and this reads the register. I'm not sure the spec defines the
> > contents of that register to be constant.  Maybe we should avoid
> > reading the register here and do it instead at read of the record?
> > I 'think' you could in theory use different storage for the CPER
> > depending on other unhandled errors or whatever else meant you didn't
> > want a fixed location.
> > 
> > Or maybe just add a comment to say that the location of CPER storage
> > is fixed.  
> 
> Sorry, but I missed your point. The actual offset of the error block 
> address is defined when fw_cfg callback is called. When this happens,
> this function is called:
> 
> 	void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> 	                          GArray *hardware_error)
> 	{
> 	    /* Create a read-only fw_cfg file for GHES */
> 	    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>         	            hardware_error->len);
> 
> 	    /* Create a read-write fw_cfg file for Address */
> 	    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> 	        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> 
> 	    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> 	        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> 
> 	    ags->present = true;
> 	}

My question was intended to be a little different but was based on a misread on my part.
I'd failed to figure out this function is called on each addition of an error
not just once.

Code is fine as is.

Jonathan


> 
> The other calls for fw_cfg functions ensure the offset of the memory read 
> inside the hardware_error firmware and this never changes, as such offsets
> are defined when the hardware_firmware is built at build_ghes_error_table()
> function. This will only change if such function is called again, which
> would, in turn, make acpi_ghes_add_fw_cfg() be called again.
> 
> In any case, no matter if build_ghes_error_table()/acpi_ghes_add_fw_cfg()
> is called only once or multiple times [1], at the time 
> get_ghes_source_offsets() is called, such offsets are stable.
> 
> [1] On some tests I did adding printks, the GHES build logic and the callbacks
>     are called twice - both before loading OSPM.
> 
>     If migration is used, I suspect that it will be called again during
>     migration but before starting OSPM. Again, when get_ghes_source_offsets()
>     is called, the offsets are fixed.
> 
> Thanks,
> Mauro


