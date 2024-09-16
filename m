Return-Path: <linux-kernel+bounces-330281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C536979C04
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C520BB212AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4D13A863;
	Mon, 16 Sep 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VGDvtlm0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964D131BDD;
	Mon, 16 Sep 2024 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471682; cv=none; b=iWRmh7W7qfOvB4ioCu9nIZAa1CNuVkT8sdJRHuo93JnybrJ+FB547n+DoAs9phFJa8Sn5VUWdRFCnllACKB82pywJnPWpZIzQHPstPLqSXER7N8eJWtuoULLt4kbk6Uspv0a7pSUMw2xQfgSpoFremnRNpI4vJTRUJxIYlxB7bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471682; c=relaxed/simple;
	bh=D0J8bq1hRTOBXFb5iovbIYDlPoQwSOXHlrwNR6EunrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDWm08/kmPUKTdrVWBLE2mfifHtZAlUhb+3o9p492ek01XPKPVQgHzzL0c32fTRvPgFq3BsUhgebT6a/9s6dy3GNi0ReM8VummnbJ8IXbNo6NrSPUho6YxNorHDR1qIZX1YI8Ck5UKOFp2Ex4HFkn4zo7B8PjIDhrhJvuOG+ieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VGDvtlm0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D0J8bq1hRTOBXFb5iovbIYDlPoQwSOXHlrwNR6EunrM=; b=VGDvtlm0oNGCXGmTyAJdP1L+ef
	P2O/G5PxBNyNUBgO1BYpCk1Htk8NNf/GSTaRn2wP2lFs7JJxCCctGmE8qj7WWxjP7tmX6krA/l9JA
	F5MAfTq5LXE293xygHzdQ7ogIizEcAG2SdWv4orlUnpXx4bqfr/U4vtyHPaxaCohLqMM2RKGm/9nx
	c2FHH0/AiIsGCVxnqHnoRBF3qQfTWeJ//RePFlTm7Uq6x42oo0QVIpYWPP1FZLe3WVI72mgU6yGHC
	wL9uEP/9dAepBPi3dXXdFFH44jCWLUoGeBKwsbXSiRIJ5KHz+VdpjIjgn4I6MkTy7krDQTp+q1luK
	//LQrMAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sq69D-00000003JTe-1CkF;
	Mon, 16 Sep 2024 07:27:47 +0000
Date: Mon, 16 Sep 2024 00:27:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Down <chris@chrisdown.name>, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: z3fold: deprecate CONFIG_Z3FOLD
Message-ID: <Zufd8wD1xBBJI3MN@infradead.org>
References: <20240904233343.933462-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904233343.933462-1-yosryahmed@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I'd still prefer to just kill it right away, but as the second best
option I'm ok with this:

Acked-by: Christoph Hellwig <hch@lst.de>


