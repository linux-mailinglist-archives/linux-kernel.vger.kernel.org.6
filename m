Return-Path: <linux-kernel+bounces-568217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6452FA69227
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD03717379C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0DE1D86ED;
	Wed, 19 Mar 2025 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bK3QZkiu"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A81C726D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396072; cv=none; b=sQ+g43M0LUIJlDYUYQ4foF3IcHOjjWfgQc8Kq9VkirvBJs938WBICrAdpDmURrZmnZopyEfqYH8rxOdQPlAxD/kF1GmAjnqPVQ9DYRTjMT/k643Sb29ZaFPf2tNweuneptzFe0e6rXOWe3bAkLyP2xQfj7574+Q+7xgqZLfRpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396072; c=relaxed/simple;
	bh=Z2Il8gtAT9okAlyaIoDCRjMTEEEzJsGP1Iy4uHIEtyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjqecnhHDo5NRP1n5ZrYN072H33wCj+s+GPFggtvWyGM1e4VUYAkWriqxq/G/6IdxKNjd07t2BciV3UJPVr+KYU0eKecI6/c5q3Paii8HCASQyix1QRva3vAByvE4XI1iqHBQuC8hR5/mMK2taSxejPvQdCmnVgl32NDIcjU0VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bK3QZkiu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476ab588f32so54350981cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742396069; x=1743000869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEG116Bshu/6/Dv1OBb0IEbzcPj4PMnrUj3mfg+RXU8=;
        b=bK3QZkiuPKDM8DJAJxn9YYnn9UefoGVXV3rbkn7k4qMcPB0r2+qPwn9HWyb/srTmbt
         E7oWGiBXq5N9YioPa6pkGrijabH2k5t0E6MnnTQdUvE6Xfn8/JkIJSEJ9/bktulrhFSo
         jLXFbx8NrKY4us30HWgt+Pf9x55Ol4zABU/rHjNBx3tmaUc2JQuXbGSRROqRz3/IuHNY
         n+jvtZubbTyvdf2qy16a8UP7CQzrOUVIUVw86WfK1X6nCHHdKGDs3oT924KmDVYN/EPP
         PMITLSLMHB+3qDijksRlmZZc9EU7u4Oud5VLNTyV4k2MfgF+SY9QhSgxZG2M7XXWUx5P
         LG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396069; x=1743000869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEG116Bshu/6/Dv1OBb0IEbzcPj4PMnrUj3mfg+RXU8=;
        b=tihwdywKwoOiyrnLaLkpdBxZ1arJKka2j9bIGtoC4fmnMRwD9gPElLkoe+GB86b9CR
         PkzZOYZ0QLmUmTrZj9rbaWW/C+8WZ1yvpnBzWJ+Buk56OySlmjWrh4BWzEWUtZHq2UCA
         zlpgD4dNuOGrnQ2egwDH4tQ7d/oSDIzDp1n+uyFQ5NUkcVbDMiXu9d+zFUJqNYiFZ0AB
         P5dOy0F4IkdgGRDFMwUQ0X/zUgNJaUfPGHLI+4tibLAeJ7hR9WhakajIGeslO+MWfnua
         gk2x/iJwbqmXLn/fCaD8iQreFS41dFnuywNeuh6ZCWeg2LUNVaP15JGmu4l5NVlGx6rV
         AKgg==
X-Forwarded-Encrypted: i=1; AJvYcCX/RPfTNu+Sz5DHfDdtIPJo6qEWMWbjXNB0O/mi5ehoPhB7dD+jOSIJEIdmCtu0j/Dkh0UgIPeglLWtJMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUrIPGkA1ImIz2v9tYN0+WS/glXDDL8YB22V9C6NS/hhJcCrXw
	pR/WLN4fC3JU8oJz6LTS+7j1SqlnLxsAAZASnh10MqbFiDTc9Mps95lZ6UcnEGg=
X-Gm-Gg: ASbGncvtw4K1HGiPA/Z6At6A64aYS+SDkYzOU15rj0dLTb+M0aUSf8R6y2LWEnytlWr
	waiQG2nEU3Wy1wtR+4UwzkyzzQ4A7vYBpBW7TcU3zD8+hcJZMdiFcHaER2nH2MYOuY7vNVyge04
	KHlGRzYCejOj7AVl3nqDviIfCPtMULGmZmeUQpKB70L0tp7DhJj+N5+P4ic4/DtqEmy/eX+tf28
	kzc6z8jedTlC4JcqNoFEqPcHhA0ac17U1SDWd+dIuPO/8UIibONuuyEWVtTwHDqRO4zFDamsSSr
	0v3Zzzd5TaHwqWHDWU5Ob+FhJFy0LRQQgoynsVn7wyRuES8Kg/rE8OHXjzwmNK8EX/+9WbhpMJ0
	Mem/F/UvDsF4SeG88MbJtFIgRjVHBgBW6vbLK6A==
X-Google-Smtp-Source: AGHT+IF+c5EdZFKNAizBy55G6o/Xg1TdvHi/rmDa9Zp63ey0OKoIbypTD3IB4bL6twCtlkAEbu0fNA==
X-Received: by 2002:a05:6214:c6a:b0:6d8:850a:4d6a with SMTP id 6a1803df08f44-6eb29284aadmr38850666d6.1.1742396069211;
        Wed, 19 Mar 2025 07:54:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade35a8d9sm81204646d6.119.2025.03.19.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:54:28 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:54:26 -0400
From: Gregory Price <gourry@gourry.net>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z9raotkELnHnK19a@gourry-fedora-PF4VCD3F>
References: <Z9mNiWm1pNIxiu0t@gourry-fedora-PF4VCD3F>
 <20250319095630.1075-1-yunjeong.mun@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319095630.1075-1-yunjeong.mun@sk.com>

On Wed, Mar 19, 2025 at 06:56:21PM +0900, Yunjeong Mun wrote:
> > These are the root decoders that should map up directly with each CEDT
> > CFMWS entry.
> > 
> > 2 of them should have interleave settings.
> > 
> > If you were to then program the endpoint and hostbridge decoders with
> > the matching non-interleave address values from the other CEDT entries,
> > you could bring each individual device online in its own NUMA node.
> > 
> 
> I think this means that I can program the endpoint(=cxl_decoder_endpoint)
> to map to the 8 CFMWS, and the hostbridge decoder (=cxl_decoder switch) to map
> to another 2 CFMWS(cross-host bridge).
> 

you can program any given endpoint decoders to map to either per-device
CFMWS, or to the interleave CFMWS - decoders are flexible in this way.
The existince of both sets gives you the option of how to program the
topology - it's up to you.

~Gregory

