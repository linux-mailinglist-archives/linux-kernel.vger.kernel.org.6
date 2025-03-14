Return-Path: <linux-kernel+bounces-561509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83104A612DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEF61B635AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF41FFC4A;
	Fri, 14 Mar 2025 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="p6nGZVBm"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E211FF603
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959509; cv=none; b=W204f7mr25Dp0H3ClsBKglayAWBbpykTSgwht5j0v2s+1OwNnCIqsjc+LbtEdwXv234Xgotkk/RinT075fIdPoKzEs50rmQOM4SrnwXFlv/HzFJA83M6mdmTUxtrztUO7PPStA0RQ+yYE90I2KM8AZpiFcJYuvd/hXsi6byi3B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959509; c=relaxed/simple;
	bh=dTUfZaUXUhKnc6MxStAvrcDIpBExFEEzoAT/Dkc+VrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB7ISauy0m42hY+C5AklJQNcgjFU1Q4UIGA8FmglHfNeS3u+rYS5LobjfTyxx+Eod3+wIlgpGinawzpT5TjDazOpaoUFOSfOPTWJUWbpfc4VFL1we9rJlWvkvoEsfbzE3+rIOrZhFVStoDgFpS7jORNW+qcza0woNwJhAlL5aZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=p6nGZVBm; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd420f82e2so29097836d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741959507; x=1742564307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eoF44ugI6vP8IjcPcTkZmDI6ldOJ1uZycxinDR8ZEfE=;
        b=p6nGZVBmO0bijMurW7dBY9nfCMRPL1ayrrJ6qXySYAajiquWdM0P+oyYQCsXCR7jKj
         A7Od7FpV+Ql9MH9vpEF1V59M+7FmZF7gWY0cgBRTT0Z3lkgmNalaQGa5PLVhnBltilDl
         YQPPY+aLw12p5VxVfp0UtRWrc46Rf3tX/0SuzaHwwESYFpFrfGut37bR1WbV6nFnPIf8
         xVKWJK8BFL9eqLzTVq2N8+qTspB8hh7hIV59kcli9W/st9MLnRfQgXB3pp1TJvlW4qCB
         UMGSpSi2pfK5McPCzbg/APXYaycmxrr97AbTEAc5MXLCcCiLbFtVJPUleydn97Mt6EuP
         hOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959507; x=1742564307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoF44ugI6vP8IjcPcTkZmDI6ldOJ1uZycxinDR8ZEfE=;
        b=Ei5pzBKp23YR6sfYk58MeKDPVlC/Xi3DRzJ2SzjutqgicHkU6KlRitWwVG23EomxNG
         +OAFZFrPbnq3B90hyq2DjoQUYA9YGpKngFHFHVdHzv/wgJ15ljxtm6p9UIGhP2axtfaa
         sxqPoHzbYR0CRO4S0leXwwH6jrmdGd76UFB1yzzQsQAOzLi5ubcOb4yre7h5pZKpMdQD
         INdCrV1gGAaKPu/lewEq6D2sViquh9v0b1un/Fs9fclotz3Q+cJbkaN9f5Lm5vjzj2nb
         IfmJWebJjlOVr/C0zuU0FaFIzDUGp+ke29y9sMxe1KI36trmNlIbnYRoz7wRohSMb79z
         QbWg==
X-Forwarded-Encrypted: i=1; AJvYcCVMEi0zr/oEbI/NSXmruEYd6esaWaNVDH3IcvsES9PBnotVI7QH/LfAJV+almk3vijWpctbUxo+YXHF7Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXRTI638aeQm9zhN5r4ALbbHadsa9MWgD+WuywjiCzyI+HvMi
	43vw2X+5uI6LIRfPxGkGEr6AC8sRD+bY1Rorw6Eju1qws3lWSl2OSSOcfrpJK2c=
X-Gm-Gg: ASbGnctb9+FNs8Df/1fLeoOVbll0Gq3geiTlyLLpZMxy4tNZW/CclbC0uz6LDnaIjVm
	uizPuVFe29BBCXGxgwl6IpX/E/OELS8FDU9UOP7c7eQzvVGa+lmo6fwwNE+IqtHe6i1DmUG/rjQ
	bWP1g9kYtUkgKarDiMx0E8ShWFK/2al0p7LZTiXdJ/ypSv5k3Q8lN71CxHujPdfcvHOahGP6r/J
	qp7gEH692cbeZI9FVSu1yKqxDsrwWn5PPKYFyG2n3vBENjf5+NHe7CnqLRCgXpMFoa2L8s0u2T3
	+bxK5yb2C/4NnfsUC2p8IJTg5+KCfjJ3UQQ9FsWdm1tGw8BPPddL8ZOeSWIHJav+XprgGcoLrbU
	HPkzc07ZM51uec68pikcAiGjOYfU=
X-Google-Smtp-Source: AGHT+IEgUXDqQalq0QLNm6R9nYlOpQxNyi5UlXIxkWp5LsR9Xb92fZqa2be466apd51bhbUPRrp8/A==
X-Received: by 2002:a05:6214:b64:b0:6ea:d69c:a247 with SMTP id 6a1803df08f44-6eaea9e88a0mr39382126d6.4.1741959506662;
        Fri, 14 Mar 2025 06:38:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade349801sm23632916d6.94.2025.03.14.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:38:26 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:38:24 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rafael@kernel.org,
	lenb@kernel.org, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, rrichter@amd.com,
	bfaccini@nvidia.com, rppt@kernel.org, haibo1.xu@intel.com,
	chenbaozi@phytium.com.cn, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <Z9QxUNP2aqTGpnMJ@gourry-fedora-PF4VCD3F>
References: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>
 <Z9LzjQCKFfsdE2yJ@gourry-fedora-PF4VCD3F>
 <20250314101226.00003830@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314101226.00003830@huawei.com>

On Fri, Mar 14, 2025 at 10:12:26AM +0000, Jonathan Cameron wrote:
> On Thu, 13 Mar 2025 11:02:37 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Mar 13, 2025 at 02:09:07PM +0800, Yuquan Wang wrote:
> > > @@ -441,6 +441,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > >  	start = cfmws->base_hpa;
> > >  	end = cfmws->base_hpa + cfmws->window_size;
> > >  
> > > +	if (srat_disabled()) {
> > > +		pr_err("SRAT is missing or bad while processing CFMWS.\n");
> > > +		return -EINVAL;
> > > +	}
> > > +  
> > 
> > I thought the srat was optional regardless of the presence of a CFMWS.
> > Is this not the case?
> 
> True in theory, but do we want to support it?
> 
> I'd vote no unless someone is shipping such a system and can't fix it up.
> 
> Jonathan
> 

Well, this is really the patch trying to deal with that I suppose. The
code here already states its creating 1 node per CFMWS in the absense of
srat - but this patch just changes that and says "no nodes 4 u".  I
don't think that's what we want either.

~Gregory

