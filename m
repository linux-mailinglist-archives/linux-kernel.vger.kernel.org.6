Return-Path: <linux-kernel+bounces-250141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA4192F4A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19941F230C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC58312E5D;
	Fri, 12 Jul 2024 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VyyhwMng"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D6EADA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720758339; cv=none; b=u1VhVk5IDF8AmrDbyeOD/F5UtN24HClYySSGW7SssXSH/sXOYHUCY8lSYBngM7NcXPx8IyU/RItxzM2yAuu9yGoF51gfj9uujsCkOufznuu0X6/REICsc2OSC11oS8xCJmSDpRcgJhCtQsUsr5mfgojg5ZRr6mDIdtOMTntV16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720758339; c=relaxed/simple;
	bh=cU8FX9JFfpwb3uXgpJhQ1HRtIQHierZo0zv2K3mLcSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTgXs6W0kN2sMf38CNFkal7DogKVZB3ilniy7Brrzsr+KcPHW9SI3PeCg9Xs3xrw+rtZa/snIy6hoDy0mPklETp2KA9uWYyGG/MuGrNd/fkHVMOc3U7dOQOxur02+Dw8KdIOEBDaaUUHkxz4jpVAyV+avLkhpwZJsQPF1gcBbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VyyhwMng; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cU8FX9JFfpwb3uXgpJhQ1HRtIQHierZo0zv2K3mLcSc=; b=VyyhwMngn6NwbAkpDnh1Bv9wU9
	SVAztML7BtOKCv6s+e1yyZ4ISPdiUGkE+Y5EPdnGyYWhDl2eSfDNMua7bpMheyNvwKRQvobXUm2ud
	whHvroDhsE4uDl8RzNfcMxLkqUVaJitaEjQaYbC748T0V5wC9cacBV8nKzcexfDr8WGNRbgmZHGHf
	SsPp9K2y364ACpeJPqAwIm14Hc+vNQ4uaQMlRAVSYkXgUU5mF9JQb2LdaI94Df+NYCH7Z4A44ZXGS
	V4Vmg5yWI4XMVF/MIQZHJ27VwyuVZJ7AhbcnmwZeepHrCtJ3vfFETlndrhxgdyr8svx0z+CkvF0Rs
	R13M/3iQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS7qe-0000000GNXU-2ORI;
	Fri, 12 Jul 2024 04:25:32 +0000
Date: Thu, 11 Jul 2024 21:25:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz,
	pasha.tatashin@soleen.com, souravpanda@google.com,
	keescook@chromium.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] alloc_tag: Export memory allocation profiling
 symbols used by modules
Message-ID: <ZpCwPCAsN17ADt-R@infradead.org>
References: <20240711204626.1669138-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711204626.1669138-1-surenb@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 11, 2024 at 01:46:26PM -0700, Suren Baghdasaryan wrote:
> +EXPORT_SYMBOL(page_ext_get);

> +EXPORT_SYMBOL(page_ext_put);

These really have no business being exported, especially non-GPL.
Please rework whatever interfaces need them to be be moved out of line.


