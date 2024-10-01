Return-Path: <linux-kernel+bounces-346003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0698BE37
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD5EFB24F97
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2941C460C;
	Tue,  1 Oct 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="I4E2get9"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B01C231D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790242; cv=none; b=YYIxhkpPqv9jHB1HqwvAgKHFL5ks5a1WHJ4T3YkhViK2vZlMXdSgv71KKwxwNzAjSBnQ36ZMyFhx+85wijgg8TBuMUeH2qCd1Jz24457tk/W152UnAF2Egw/viMim6iLwUqReT7hcPzpikjw3dmK0cIuF6Rpp4PT/cEAF9fE9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790242; c=relaxed/simple;
	bh=xGx6noygeMgO8AaQLqGM7+q8fh5vc5kUtmlJwZCD2eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIXJOCjmPwAjdqmqaXKtCBrBiEa5HDwhSU3MJwz2/PC46TNr0KhVbq8J+3J6YYSyeeoLgq9Ge5JQWoEku8VdZHJIDLYTe3AdM14SerFQc/stv3KLDgFnI62+aozbzGZE+wilkgR+55/G3vi6QxnHXJtiPiRXmxTU7MwGJHjbN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=I4E2get9; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb2824ddc2so43932956d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727790240; x=1728395040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYTJ0CUqrH1SHJfivVlEjJG53DkWzerfR4yWluFNYZE=;
        b=I4E2get90BZHel+50j7iOBLPgnrEt9wwdFzOeHPAtlCjZJuZJQqOvcOpdYwIPRXfh4
         wnzZmyzy550VYrVv71I/V1OKm26KFIdZAcIibNJY/zf357OHPTLa9LGd1joN+bHYxwT4
         wxCqfD/8pI4oeJU4tnSJ2IT3UcanVMArfHOLCzXo8E22K5/GjMWu230n8OT7Umr17V+S
         ZS+PQqD5aoJ5Umx51BIqzS/5pbEsfrNebNqXHgsfm8p1iwQGmFevzyE1oVjP6kcAMLuB
         vNebyOM2X4vQp97N4CHd9uv4AoQc82XxZ27nMFr00sCcpDU/Hf7QFLIpbX7mbsn0ZcFL
         Hwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790240; x=1728395040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYTJ0CUqrH1SHJfivVlEjJG53DkWzerfR4yWluFNYZE=;
        b=izU/dl7LPKHMRjoBWNxPmNUwmk5qJ6Xm9/1Bf+I88HomFlfexn7TR0RnRd9xP3Truk
         WvFkPgYHWE9zw07/SsCJ3XQfAUWHOnWA4riAbgjyoeS/XbqZ/2tLbmD/hPDv5Fqs9l+2
         O9nAlSmy8CFKYqZ4/0GZO9xlVW581ze5drvodENCE2FrL+NmjLElJcvGl6Ph/Y/nbsvG
         WOjy8vuTUJL8Q7hd3iY9GSab5PMzbdGUVYPInXRsEum3a1X6plqGrpkoM7TP6a/8mY6v
         DaRhzkggUIyZxTkpBU0yigarW/cHaYoOa+jZVT1Dw8aqQ3ZgONrytYUfqqCsNmPeWULc
         ErPw==
X-Forwarded-Encrypted: i=1; AJvYcCXLtxaI0mz35p3L8PJ+LH+nz/wslcE4axRiEHjBhg/sPokmMgxm3D+RW7dZIok8OVwJ/XtVRJMtYZU0+/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2tJ364xwY6AnCkwPTdK+D6q6eR+TujzFAu00IZkaSEVggmv6Y
	P8pMkd0yNHbZ0/i1xJVaT62SY53RavSKcqixfiyTiF/gFX5veneIjxTwSMEN/OY=
X-Google-Smtp-Source: AGHT+IF5VUNcvnmPtnD8VPaddLA8g45OQ216uprpipGG1nA4txFOuXegaZTFCcl2msleBSBHLXCt6Q==
X-Received: by 2002:a05:6214:5342:b0:6cb:3340:ac36 with SMTP id 6a1803df08f44-6cb3b65feacmr169019196d6.52.1727790239921;
        Tue, 01 Oct 2024 06:43:59 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b6800a9sm49778366d6.116.2024.10.01.06.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:43:59 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:43:30 -0400
From: Gregory Price <gourry@gourry.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC 1/5] cxl: Rename ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3
Message-ID: <Zvv8gtAy4hel9yY3@PC2K9PVX.TheFacebook.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-2-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925024647.46735-2-ying.huang@intel.com>

On Wed, Sep 25, 2024 at 10:46:43AM +0800, Huang Ying wrote:
> According to the description of the "Window Restrictions" field of
> "CFMWS Structure" in the CXL spec v3.1 section 9.18.1.3: CXL Fixed
> Memory Window Structure (CFMWS), the bit 0 of "Window Restrictions" is
> formerly known as "CXL Type 2 Memory" and renamed to "Device
> Coherent", while the bit 1 is formerly known as "CXL Type 3 Memory"
> and renamed to "Host-only Coherent".  Because type 3 memory can only
> be host-only coherent before, while it can be host-only coherent or
> device coherent with "Back-Invalidate" now.
> 
> To avoid confusing about type 3 memory and host-only coherent in Linux
> kernel, we rename corresponding bit definition from
> ACPI_CEDT_CFMWS_RESTRICT_TYPE2/TYPE3 to
> ACPI_CEDT_CFMWS_RESTRICT_DEVCOH/HOSTONLYCOH.  This makes the kernel
> code consistent with the spec too.
> 
> Also rename the corresponding cxl_decoder flags
> CXL_DECODER_F_TYPE2/TYPE3 to CXL_DECODER_F_DEVCOH/HOSTONLYCOH.
> 
> No functionality change is expected, because we just rename the flags
> constant definition.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/acpi.c           |  8 ++++----
>  drivers/cxl/core/port.c      |  8 ++++----
>  drivers/cxl/cxl.h            | 14 +++++++-------
>  include/acpi/actbl1.h        | 10 +++++-----
>  tools/testing/cxl/test/cxl.c | 18 +++++++++---------
>  5 files changed, 29 insertions(+), 29 deletions(-)
> 

Reviewed-by: Gregory Price <gourry@gourry.net>

