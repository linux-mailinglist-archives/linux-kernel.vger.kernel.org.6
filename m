Return-Path: <linux-kernel+bounces-551335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEFDA56B39
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5F87A53E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC8C21C9E3;
	Fri,  7 Mar 2025 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uiEhg4Vh"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAE8218AB4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360084; cv=none; b=MoB9ArxQ9XKD8hdicsSTNHaVTlEctwerCuij+L+vCRlPegD7yQm5sUJf9IT7b6Zl5jK0yZ7BGe9vUDQXpGkP3sPqFmfkBSSdXx4uqgqeRa2I13rm8XE9JLAThKUL+8aHJ8BdGhohE0Pk0rhD7kfpHbjkS0APQl45fvac2/47SDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360084; c=relaxed/simple;
	bh=1J/ql49X6Ezkg4wdoqe/stSQpbv40JqkSw4Ir5aIPhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT3sV9gdqcpqExsZotM0/JdZ3qaVfPj46DsLbkqg/MdPlI2q/kj2YO7ZqA5VRdiCflXIFCZDwJZU1X3sdbeW/iuL6rHRHmDv4r7MGp7oZXQzmZI6IBn1BYZowTIU91cCXsBqYJBKNDDF74v8LrOpF/P8o6mJjVK1q1Fj5qYrrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uiEhg4Vh; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8fb8ad525so14632906d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741360081; x=1741964881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwqxWi0iWrXCwX2xmbnqF8uYYDlpSjPvCpbbjIDyPjI=;
        b=uiEhg4Vh+cuKuMTS1wVogHyUCw1yYJaYICFxWueOIA75qwwYhbZSzYIlc974eQADes
         ah/pUzaewDasoYOu2yOe2/qiBK7Ey2cG2SE0E53nPB1Fi4sZfWXmilm9WrLHN1NrG2vK
         gW/OKtUfiW61Ws6UX1EHX6fES3yQ4qRFX4vAjlBqZH4r3H0z+N7/SuS90xgdgESu2lEx
         /5kdniPycdZYURDiWMI1jRCAFvt5Pos82/qUUJlYP6/YanDsbJxymf6dt2cbX/eZoI8j
         SmEkkf5et7RglReZQb3omNT76peaE61ro+dhiLJhBs531kHs2uefQV5GA2DCVnEEX3c5
         1Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360081; x=1741964881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwqxWi0iWrXCwX2xmbnqF8uYYDlpSjPvCpbbjIDyPjI=;
        b=RBUtbChrvOfVkr1xYWRYXVwHrksPPUslDp+c3VtiuntT5wBiJbokOKhtQhG4V7s0Q2
         1bA3Q8IuOOHFuB7P6SbFhz0FoLafhBFfg1CodVgb3Q7z6Q9wG0vk6ETniH/jVUqEDz3y
         PC/xyuaRkySNHZXSL+HzqZAxzxG8djAypST9DJS8vIyULsa4I9nky/a73pQUnZXvGM4j
         d8xYtSuF2eFuawzijlvCVVC+0e5lkAT7dqU2JoWFKsWsGbNkv1oSsA5OEtCXq7nI6j6c
         ogV34/jxf+GvoerZsn4vjgzjSIZv1+h4+mIlcCQ6tPRK90+ZUWFla7HERzSJrbyNtG1V
         g11w==
X-Forwarded-Encrypted: i=1; AJvYcCWakN/1WysUDt7X2JAM9e13JD0pWiJ+9ZFoIOAStz16ugStwHJxIZCl9qfAXSwpoDQW/kwnkdeZbrPumV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bZbh1fpfIFXcLjuUfnGQGFWULhIrzmCJfhURfpUBi5m8dzby
	d3d42wz5z3gEccBGyYVIGv4A99uFGVWgwFe9EB+MUrHfKwR1Uo3Ai/oWG7LFGu8=
X-Gm-Gg: ASbGncvA7oAn/AfqW04ykRdlULXnGI39MEAGF+6VWYkGmYqSllUDuvaaB8TZqmnzkjc
	tjXKcXCI4CVZ2KVrRCQBIcLxx8fch8JyN4hdQHu3xplhUT9z8wJl8NIQGExzEckirB3X4jAIL6h
	FDM+Gt+tT8PHLN4EwKyccY/Mn4Bu20QQSWOw5FZ7f674uNrkX6VkFUMgUshZ1/uHcuC0Kg06Fwe
	ZP64cc5xNCdIcovKsX/kgex1iMUj4/kbTMEQ9BqiKF2zdvai9BjBAwPEXSshmin8rIsImJ7r5iO
	UWyUPQOdF5TmDrPScLI43LHOu1EHuBZCUy3au3kNBJtwA9SXSi4y0X+O+XWhkaxHDjaQXrPYrhA
	toc8QS9iIgvl8RDO0NT+8TOlnivE=
X-Google-Smtp-Source: AGHT+IHFXN/P02s1v98zyEbqxwhlOPUAeqTTE2dEMUqC5SvXHpnKWulc9lagDpP21FJm9Hmt5sZqBQ==
X-Received: by 2002:a05:6214:daa:b0:6e6:646e:a0f8 with SMTP id 6a1803df08f44-6e9005f899emr45138866d6.16.1741360081484;
        Fri, 07 Mar 2025 07:08:01 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a447asm20414876d6.54.2025.03.07.07.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:08:01 -0800 (PST)
Date: Fri, 7 Mar 2025 10:07:58 -0500
From: Gregory Price <gourry@gourry.net>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Message-ID: <Z8sLznxBkJHWeTvQ@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
 <Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F>
 <570b18f4-3790-4e57-8d80-a5301e5d8af2@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <570b18f4-3790-4e57-8d80-a5301e5d8af2@fujitsu.com>

On Fri, Mar 07, 2025 at 12:57:18AM +0000, Zhijian Li (Fujitsu) wrote:
> > In section 2, I referenced a simple device-to-decoder mapping:
> > 
> >      root    ---  decoder0.0   -- Root Port Decoder
> >       |               |
> >     port1    ---  decoder1.0   -- Host Bridge Decoder
> >       |               |
> >    endpoint0 ---  decoder2.0   -- Endpoint Decoder
> 
> Here, I noticed something that differs slightly from my understanding:
> "root --- decoder0.0 -- Root Port Decoder."
> 
>  From the perspective of the Linux Driver, decoder0.0 usually refers to
> associated a CFMWs. Moreover, according to Spec r3.1 Table 8-22 CXL HDM Decoder Capability,
> the CXL Root Port (also known as R in the table) is not permitted to implement
> the HDM decoder.
> 
> If I have misunderstood something, please let me know.

You're indeed right that in the spec it says root ports do not have
decoder capability.  What we have here may be some jumbling of CXL
spec languange and Linux CXL driver language.

The decoder0.0 is a `root decoder`.

The `root_port` is a logical construct belonging to the CXL root

struct cxl_root {
        struct cxl_port port;  <--- root_port
}


A root_decoder is added to the CXL drivers `root_port` when
we parse the cfmws:

static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
                             struct cxl_cfmws_context *ctx)
{
...
        struct cxl_root_decoder *cxlrd __free(put_cxlrd) =
                cxl_root_decoder_alloc(root_port, ways);
...
}


And the `root_port` is a port with downstream ports - which are
presumably the host bridges


static int cxl_acpi_probe(struct platform_device *pdev)
{
        cxl_root = devm_cxl_add_root(host, &acpi_root_ops);
        ^^^^^^^^ - Create "The CXL Root"

        root_port = &cxl_root->port;
        ^^^^^^^^^ - The Root's "Port"

        rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
                              add_host_bridge_dport);
        ^^^^^^^^^ - Add host bridges "downstream" of The Root's "Port"
        ...
        ctx = (struct cxl_cfmws_context) {
                .dev = host,
                .root_port = root_port,
                .cxl_res = cxl_res,
        };
        rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
        ^^^^^^^^^ - Add "root decoders" to The Root's "Port"
}


If we look at what a root decoder is defined as in cxl/cxl.h:

 * struct cxl_root_decoder - Static platform CXL address decoder


So this is just some semantic confusion - and the reality is the driver
simply refers to the first device in the fabric as "The Root", and every
device has "A Port", and so the "Root Port" just means it's the Root's
"Port" not a "CXL Specification Root Port".

Whatever the case, from the snippets above, you can see the CFMWS adds 1
"root decoder" per CFMWS - which makes sense, as a CFMWS can describe
multi-host-bridge interleave - i.e. whatever the actual root device is
must be upstream of the host bridges themselves.

~Gregory

