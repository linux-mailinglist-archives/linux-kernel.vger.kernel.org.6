Return-Path: <linux-kernel+bounces-290223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF149550E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F6E1C21880
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0771C37AE;
	Fri, 16 Aug 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Narn3HSk"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1F51C2316
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833171; cv=none; b=pftXhtDwuA4oU0HgphULOtkaTW9YtFNTuTVM4LzL4N1sboUBi+9QSI0UJ9eWK6DqoGx1boB8UFIa+gPjRhhyjFHwWdTs/brAf/kqbY8gdPZ6n79G16JhxvawQt2umYrn5v/mHnjaYFch5zfJcnrvH84FtgFoppn7UPVTApVAXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833171; c=relaxed/simple;
	bh=sqBlDYYe+xJpwACaKDyMfF9NxH+kMPPNUTDDVwfyb0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBfSEOdubeeGUqd/ULr2e8eL3nTTQ5FcK9sCngExJJUOYLTYLFkzb/dHvwVecMKhc75qUPxxv3l7Prw7jmk8unZ5HM430a8dwuLbwBEASkdhAjdgj2AGuOYZYDxY11dJ3cpEMn14IxWPWEWSXwnVRa8ECkkdh2Xk2vIjrtS7IXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Narn3HSk; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6bf89e59ff8so186166d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1723833167; x=1724437967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25KDEXnm6DLgip12pSEllSf24x/AMgAnP17PmbvYjCY=;
        b=Narn3HSkTEzudoNM8PEyOB0gT2i3UzxQy6JLuGKwdVDm3Kv7V6erE579MFQ4to5qfl
         EHOloPMVoatZKT2kcFu5rFhobFTx/R7wV6fmgoYOzaYcjeglaLUKMTXhEzslTIzK9Sh/
         ol83NwQ+v5KG2S6P8K8IiR5fSrSjnpJbWUUwxEouME0rxXaLf25TAbUgZSVzlv7WYqgR
         j2sYWWVyHNw0SULa2QszPdYSeQxNPMvQGGmmUsNarEwHWf99SoSK1P4R+Z4pGcJPxQNs
         fcdnraBKN/p/qbLphlvPX3NqSv/OxIiR9fDSlscZI3LWHX4w3XH0vDjbXEFAs9HzvwXb
         l/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833167; x=1724437967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25KDEXnm6DLgip12pSEllSf24x/AMgAnP17PmbvYjCY=;
        b=lN/u9PadIMdTwNDUNueUtuS5AD3ya2gn9o+ksxSNBZJIG3NXb4xipDhAcT9Zme8VmW
         URZuKJp/zvko4dOIYpgxP9QX0A9xzij2HTDi5ZMuN8eSa0TBxVYRVMeZWkXv3Pj8poxn
         rryoZXhrNxquUBYppl3srHXiLz3rEbGJyLxfF/6AWLT0+Z7H3gP+RP0We+CfHDpJUMU+
         n+txgqZH10+3e5ivkcaDZNv6wzNlEmiFnzL+Dun2BY0iKT2mPbBzsLzgSJfX+IxW1uTi
         d+Ojnl/eqMH74obAlA8FhVwBUoV9w68/OAasWDGvi7n8wcaXeRdpdSGQQiUsuLSaAgyK
         Fliw==
X-Forwarded-Encrypted: i=1; AJvYcCX0Au0zPF1PrtYbh9G1do+Cg5KV2WvZBlRa1lx6zVTfmS9IaUMRNKCsyaoUp+uHeapTMcu5KJ5LyS60hcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKtx8aZSH6oWR7F7HjoJu7zXOFjqcWa3QyDnQSFaySR9H1HbFu
	TWEVmCDvp92dYNKLmqiaIIOQ79C2NAew8aPcndGMNqSEsUxXd89cl2IZcATFsGg=
X-Google-Smtp-Source: AGHT+IFeUXfbFQq1xqErrB83JkB93nde+CNIB9jmJX5I2LdaP+61jOYfRxYWoA1tiPMJ7n7leTuOCQ==
X-Received: by 2002:a05:6214:3384:b0:6bf:6990:4e50 with SMTP id 6a1803df08f44-6bf7ce4233bmr32481546d6.41.1723833166565;
        Fri, 16 Aug 2024 11:32:46 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef0706sm20313996d6.116.2024.08.16.11.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:32:46 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:32:41 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Address translation for HDM decoding
Message-ID: <Zr-bSY9UVncTdY_Y@PC2K9PVX.TheFacebook.com>
References: <20240701174754.967954-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701174754.967954-1-rrichter@amd.com>

On Mon, Jul 01, 2024 at 07:47:48PM +0200, Robert Richter wrote:
> Default expectation of Linux is that HPA == SPA, which means that
> hardware addresses in the decoders are the same as the kernel sees
> them. However, there are platforms where this is not the case and an
> address translation between decoder's (HPA) and the system's physical
> addresses (SPA) is needed.
> 
> This series implements address translation for HDM decoding. The
> implementation follows the rule that the representation of hardware
> address ranges in the kernel are all SPA. If decoder registers (HDM
> decoder cap or register range) are not SPA, a base offset must be
> applied. Translation happens when accessing the registers back and
> forth. After a read access an address will be converted to SPA and
> before a write access the programmed address is translated from an
> SPA. The decoder register access can be easily encapsulated by address
> translation and thus there are only a few places where translation is
> needed and the code must be changed. This is implemented in patch #2,
> patch #1 is a prerequisite.
> 
> Address translation is restricted to platforms that need it. As such a
> platform check is needed and a flag is introduced for this (patch #3).
> 
> For address translation the base offset must be determined for the
> memory domain. Depending on the platform there are various options for
> this. The address range in the CEDT's CFWMS entry of the CXL host
> bridge can be used to determine the decoder's base address (patch
> #4). This is enabled for AMD Zen4 platforms (patch #5).
> 

Just testing this out, and I'm seeing an inability to actually map the
memory, though the reason escapes me.

Do you have the expected workflow of this down?

For example this fails:

echo ram > /sys/bus/cxl/devices/decoder2.0/mode
echo 0x40000000 > /sys/bus/cxl/devices/decoder2.0/dpa_size
echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
echo 4096 > /sys/bus/cxl/devices/region0/interleave_granularity
echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
echo 0x40000000 > /sys/bus/cxl/devices/region0/size
echo decoder2.0 > /sys/bus/cxl/devices/region0/target0
^^^^ at this point: -bash: echo: write error: Invalid argument

echo 1 > /sys/bus/cxl/devices/region0/commit

and while the cxl driver sees the correct topology, the current version
of cxl-cli reports the memdevs as "anonymous" and reports a failure to
lookup the targets for a region

without adding too much bulk to the email

[~/ndctl]# ./build/cxl/cxl list -vvvvv
libcxl: cxl_mappings_init: region0 target0:  lookup failure
[
  {
    "anon memdevs":[
      {
        "memdev":"mem0",
        "ram_size":137438953472,
...
      {
        "memdev":"mem1",
        "ram_size":137438953472,
...
  {
    "buses":[
      {
...
        "decoders:root0":[
          {
            "decoder":"decoder0.0",
            "resource":825975898112,
            "size":260382392320,
            "interleave_ways":1,
            "max_available_extent":260382392320,
            "volatile_capable":true,
            "qos_class":1,
            "nr_targets":1,
            "targets":[
              {
                "target":"pci0000:00",
                "alias":"ACPI0016:01",
                "position":0,
                "id":0
              }
            ],
            "regions:decoder0.0":[
              {
                "region":"region0",
                "resource":825975898112,
                "size":260382392320,
                "type":"ram",
                "interleave_ways":1,
                "interleave_granularity":256,
                "decode_state":"reset",
                "state":"disabled",
                "mappings":[
                ]
              }
...

Do you have a sense of what might generate this behavior?

~Gregory

> Changelog:
> 
> v2:
>  * Fixed build error for other archs [kbot]
> 
> 
> Robert Richter (5):
>   cxl/hdm: Moving HDM specific code to core/hdm.c.
>   cxl/hdm: Implement address translation for HDM decoding
>   cxl/acpi: Add platform flag for HPA address translation
>   cxl/hdm: Setup HPA base for address translation using the HPA window
>     in CFMWS
>   cxl/acpi: Enable address translation for Zen4 platforms
> 
>  drivers/cxl/acpi.c      |  16 +++
>  drivers/cxl/core/core.h |   2 +
>  drivers/cxl/core/hdm.c  | 245 ++++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/pci.c  | 119 +------------------
>  drivers/cxl/cxl.h       |   2 +
>  drivers/cxl/cxlmem.h    |   4 +
>  drivers/cxl/cxlpci.h    |   3 -
>  7 files changed, 262 insertions(+), 129 deletions(-)
> 
> 
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> -- 
> 2.39.2
> 

