Return-Path: <linux-kernel+bounces-390911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1409B7FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328192813D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3111719D89E;
	Thu, 31 Oct 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="A4qPUJdB"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1319D082
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391800; cv=none; b=c7F+dw2ObMTTZdtaaLfWsw/xOhPQaRpeancRb52cFIFSj0hYIbFyy96BdMEPe+qSGl/mCDgSjWtMMvUR0gsEpX0aofIKl8TEwjEoXey0QIpYZmBj0XiDJ/MIXUBqrtR8pM6JwS45gukROXeFPnoY3qA/CQKTIllQu43DVYxWUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391800; c=relaxed/simple;
	bh=pHyLyRq9icEl7h1hajof/4uWohbq3D4kb9tZ1Q3TxCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVq5/dmih9LIEPNIoG590N1TpoahZkhpeLPI0e4Du2piHIkGaN/hI6YhDfybFJLNcA4aV8xqHG04xXOJ7XhB66YAK9q3OnyLg/sYWxBITFVHBTlFtr10Ca9aygrEAd0tZdiQkhMRHZj+bbZS5i/ujs9ewvUV5WtK03qJczNbqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=A4qPUJdB; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b155da5b0cso79698685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730391797; x=1730996597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrPPGPtF1r4JJPagnUAwxTz8GU4YzNxLE+E5DMVXteY=;
        b=A4qPUJdBc0zjzPz59IM7rTHfXyvkBIURVIMdaOLECvzsczBDu9kG7T4zUuKhn4Oa1j
         59SqusMgAemTsGgSuAjquTbuOCdOMz+N1ebOiZMAXUxCV5BAlikhw/FQgBmdJKSNc8Mk
         /btFMqhC2rI8z5M/gWqfczSjg/aC9pNnfz/D0MpFQ0IX7r9Givev7q2sETHKXKI9ek0G
         nGWY/OXevb+VnSE+r542TUqy2vwnJOcbTty9uTdWumpaBP4zoYBcY8i6bFjYA8gKCcwK
         ffBlWEs6WeAM0Vcwwo4XmwRbSNaCDc/RQplQ5v0fY2E+TO+8yR/EdETbZviBJYg+004d
         yZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391797; x=1730996597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrPPGPtF1r4JJPagnUAwxTz8GU4YzNxLE+E5DMVXteY=;
        b=uaVUKQMyzU/qcIVjoigcLsWu3p5AdSRtACpR5tOudcpe5x9SlXnzInLOX56lz5gehv
         q0xiEKnvw2dEoXYJyhvy5JdvCsAAWMUNuz0m9MaVxUWuwARkdCSB0uk49qZ1WJ+xuDhw
         zRgKeXI3GTyjgCqqfDqC0PLZu4BBbplCImDbI9NzIL74y5kFK3YPaq+ufwMAUBL14liJ
         4+S6jt3G1KxAnULyMOeydCYgdUmSCIRD6qtz8Nr9ncfFaQuS5QpAMgSWtatYz+1WNj85
         XYkdCESLTFjc0ghOvt06YxcACoTX+FHDXN8pP5CmGdekeQmUi47IZAxQG1Rrg0VUYLVK
         cagQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnsuorXafUGKHJJXkR7haMRllE0xTB7rxqWT75U7H+hX07bYEeDKWB79hoCGuNM19/KoyNsewPoYe2ZEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTbhIJiwldCdrMj3Tp4ZfibLk8wW2ASwFB+BBnV9Qzb8CVeDa
	fC2pgUZiHSk7zqjsxYgyY2jRv18YdeJrmY0b/dq9Hcgp/FD/UFBiTbxM0GJMb1k=
X-Google-Smtp-Source: AGHT+IG0mJPHTCww3DZQuqv9nxseKwFokKX1MWnv7+XcE4NElcJk7zAVUMyfqkFKAZ8kX5Mw9dP5qg==
X-Received: by 2002:a05:620a:318b:b0:7a4:d685:caa9 with SMTP id af79cd13be357-7b1aee2c038mr1047669385a.48.1730391797615;
        Thu, 31 Oct 2024 09:23:17 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39ebab8sm83428485a.8.2024.10.31.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:23:17 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:23:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, david@redhat.com, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH v4 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <ZyOu-7MeTYGa7tf9@PC2K9PVX.TheFacebook.com>
References: <20241029202041.25334-1-gourry@gourry.net>
 <20241029202041.25334-2-gourry@gourry.net>
 <ZyOUp5Juz5x3Ivrn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyOUp5Juz5x3Ivrn@kernel.org>

On Thu, Oct 31, 2024 at 04:31:03PM +0200, Mike Rapoport wrote:
> On Tue, Oct 29, 2024 at 04:20:39PM -0400, Gregory Price wrote:
> > + * Return: 0 on success
> > + *	   -EINVAL if size is 0 or not pow2 aligned
> > + *	   -EBUSY if value has already been probed
> > + */
> > +static size_t memory_block_advised_sz;
> > +static bool memory_block_advised_size_queried;
> 
> kernel-doc will be unhappy about variable declarations between the doc
> block and the function it describes
> 

Yup, that was the warning I was waiting to clear KLP.

Learning new things n.n;; - new version shortly

~Gregory

