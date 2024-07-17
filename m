Return-Path: <linux-kernel+bounces-254670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C393361D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCEFB20FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E63AD5A;
	Wed, 17 Jul 2024 04:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ezIxcRFj"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE6923D2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721191652; cv=none; b=ANoj+fUU0qOvnRcmDSPuRjoob/SUBXIsln9UNMgBpS6M7xsAcUiKGTa9Ki4EisgY5YMQ2IqaRpymETC4wRbeZ/s7iCO8h7tfSMLvzQODVQKydto12KPIY/l49+3W6+PhGwdc1JF7NVWsN4zD6xhtjwnrJKLScWHdPFkcjpEQnrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721191652; c=relaxed/simple;
	bh=2c+lvaDRERgLwzBnu1deq8RyaVIX+YKybOEDUjAgLcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnI6+YBwxG9Zni1I/h8MCXe2bwOvuGSwEZltzzjA/Hv+xTgHWXqc40UY8SG80m9hwf6c2V4pGeb4aFawSSnkdhVJRho3UIF3pOaPxmb2OeDYlPZN6Lx78Jzmp+aOlNNNr9dS/FaCrx5JZ9Z714bTw5hWNo/Qn3AGQyFhGpGhyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ezIxcRFj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2c+lvaDRERgLwzBnu1deq8RyaVIX+YKybOEDUjAgLcU=; b=ezIxcRFjs+XNtzg5+JtePYwH9f
	2N9kQWEypaxnqzKd6Sb97NQIyLFq6iwCcgicBGKAfJtoD5Ni7MNerjSOkHiMwbSl3VosV8ZlxFNID
	QRP6I3ybrpzdShbrNIAIGs1TOYxWSvprAfAEZqOPfmMbxJ/cg2uyQLG1oER7vIT9xNLOcxl5y7bLO
	+Iux3wc9DwvlmYCjwxpvel5f9oHPao7oW0GT97KjDean6yZSYSVPYSkz5QyYcx1l/f9lHj00ME+IE
	djfIbNQq0B9mLyiRDZ7cUsmPNFgwOyNKWJ1vLiA9jN3FCiSY9DeBiNvKAYcBTUHwOL0WIPOZTLlvD
	7a2SVpWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTwZb-0000000CdWL-0XMy;
	Wed, 17 Jul 2024 04:47:27 +0000
Date: Tue, 16 Jul 2024 21:47:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, hch@infradead.org,
	vbabka@suse.cz, pasha.tatashin@soleen.com, souravpanda@google.com,
	keescook@chromium.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] alloc_tag: outline and export
 {get|put}_page_tag_ref() used by modules
Message-ID: <ZpdM3ze-tViccS6X@infradead.org>
References: <20240717011631.2150066-1-surenb@google.com>
 <20240717011631.2150066-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717011631.2150066-2-surenb@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks, this looks much better:

Reviewed-by: Christoph Hellwig <hch@lst.de>


