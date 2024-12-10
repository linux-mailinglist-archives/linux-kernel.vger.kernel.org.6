Return-Path: <linux-kernel+bounces-438845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFF79EA72E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9F6188840F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EE814037F;
	Tue, 10 Dec 2024 04:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H5YUKu2r"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01560DF58
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733804985; cv=none; b=gtgXfzAAQVBdqpxHUS+TbA1F5X74Vo/a3MaLpu3q1lNp9MHSJFxqo2uq+hvg80XIu4ep1d90azCivgiYiyjRP7Tw+q6sOrxkE3Xi6ZC+KIQzJCGDmk2Cg2MNgC5KJSZt44YKE8YJAjpKj5D67oc6I59NMAFJoZkAJM0Ey8OmcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733804985; c=relaxed/simple;
	bh=NmyoN29d8RdomLKXISK8uOQeYdX97YvxL1tC7L1Wg6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjmc7B8fG7mKWxcjOh6fx1fHYKX6s2AliO7kJaCkhc+U8+O0eYhjSl/xxLR9Mg9abm8RgMx/VaLzGIWXhZKxJk7dfDuOtyQgV5zw92WPMvi2R6iypebq/YnKMmEhQueegJ7e9uvy9g5Xs0CgsAeTkyB1n2rPwb3lq7Ioglz1JeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H5YUKu2r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W0mVNYleG7rejvTbSAYKoOpittcDfBCnrACXJYLLcN8=; b=H5YUKu2rtpLnxLyMrn/owXTZbk
	kNqdORedQBdRJ8ZkGg+HarmxiLCFk2iiE3LjamNeV1gO1ny4BO6FgXjalTLugUhyO4OxUTdYnrZuD
	TXHJ97dOAhOd1t8jWDvJe/q9kZ0WygEhF5gSTRwc2SPmvSKjN7VXDbA4dFWW6McylpsOvUQWV0Nd4
	/zSpGRD0Iam2J3jjHiKs0DMEtPRegsJ11gAXyO0Wchbk7NgYSgmLLNEZ2bfbOo3qW7Yidn3RS5+wo
	uAU0roywBuS+bz3rodBqZFAVKRl/y/UMGgl8RK/IkKlWrinWUL37xMTMDQ86/QNf4s6ODbzEmSyzv
	hap6q4zA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKrsQ-0000000AC9F-1WCJ;
	Tue, 10 Dec 2024 04:29:38 +0000
Date: Mon, 9 Dec 2024 20:29:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	christian.koenig@amd.com, Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Andi Shyti <andi.shyti@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Maciej Patelczyk <maciej.patelczyk@linux.intel.com>,
	Dominik Grzegorzek <dominik.grzegorzek@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH 01/26] ptrace: export ptrace_may_access
Message-ID: <Z1fDsvIKB4j_-Tv_@infradead.org>
References: <20241209133318.1806472-1-mika.kuoppala@linux.intel.com>
 <20241209133318.1806472-2-mika.kuoppala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209133318.1806472-2-mika.kuoppala@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 09, 2024 at 03:32:52PM +0200, Mika Kuoppala wrote:
> xe driver would like to allow fine grained access control
> for GDB debugger using ptrace. Without this export, the only
> option would be to check for CAP_SYS_ADMIN.
> 
> The check intended for an ioctl to attach a GPU debugger
> is similar to the ptrace use case: allow a calling process
> to manipulate a target process if it has the necessary
> capabilities or the same permissions, as described in
> Documentation/process/adding-syscalls.rst.
> 
> Export ptrace_may_access function to allow GPU debugger to
> have identical access control for debugger(s)
> as a CPU debugger.

This seems to mis an actual user or you forgot to Cc linux-kernel on it.


