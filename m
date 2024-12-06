Return-Path: <linux-kernel+bounces-435342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073709E764F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0A81881569
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC5206294;
	Fri,  6 Dec 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yg+zQBad"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBCF819
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503372; cv=none; b=tQm56SGYsAwWbKXmybxqFlxkLmnOXpIuEFzsCaPz7e25Pz0ZA49yPSnGVrlWLL95yQ0v/3vXP9v5UC0iCA7PsuF522nRl9Ll2wCY1Yn7w8JX8lOxWcpdy9qIvJxFhK+wd9VF/70Ql/2GjmVjHXlpEoEuSMn/pEvf0Z0rLKv23tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503372; c=relaxed/simple;
	bh=xI6iU9R30iJ3Jjx4/OlpWrJL9ovNCAtVHCgXvuY6Wf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK1T7IZtb9TNKl8k3EO67pk9IdvC7eWyROUDpBOu258Onev4WTbe0JX7XYpGe7ei7IE0DPSbZKzTnj3oASPoczeaox+/y3Ivh/AI/DC/DNk6lRtTWk0ESKJTpuCAoRuk7jZTRZYo/VmlyF6T5VlU6zUEkdqc9Fxr/bX63HTkRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yg+zQBad; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xI6iU9R30iJ3Jjx4/OlpWrJL9ovNCAtVHCgXvuY6Wf4=; b=Yg+zQBadL2RReMzhNt9YfusmTS
	pONti2Y8NgqgQs/58L9fm3q+W60yR63GKCa55ONvHzTyVHse7xRa5GMi9xmraY96rzKeATKJkSANc
	eixg15ipj3gMiXVtC/NeV0vX07FQW7jaI0dKByOr9JfTZ5y2zbygk4jV98fObPBDeFoYvWlfXs4LI
	D0dJyRCJn/97mRDIt/iah2lzkHveVYs9+MLQ8Ts0cfT1MRUofD2eNEBzsLpRS5fRqORUZrFbpNPmF
	W9MOJg5URCI0WESl8DhDPTMf2IfosD4/VR2MszUUwTBXW7F13LGyEvj0H96NIcUsvLr6MfgAr7UXk
	8X47g7fA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJbPb-0000000Ek11-0LRo;
	Fri, 06 Dec 2024 16:42:39 +0000
Date: Fri, 6 Dec 2024 16:42:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vineet Gupta <vgupta@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] mm: use clear_user_(high)page() for arch with special
 user folio handling
Message-ID: <Z1Mpfofz45bFawSq@casper.infradead.org>
References: <20241206141938.2750393-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206141938.2750393-1-ziy@nvidia.com>

On Fri, Dec 06, 2024 at 09:19:38AM -0500, Zi Yan wrote:
> For architectures setting ARCH_HAS_CPU_CACHE_ALIASING, which requires
> flushing cache and arc, which sets folio->flags after clearing a user
> folio

I think arc just has some legacy code left that needs to be ripped out.
See commit d5272aaa8257 which took away ARCH_HAS_CPU_CACHE_ALIASING
from arc.

Looking at 8690bbcf3b70, I wonder if you want to use
cpu_dcache_is_aliasing() here?

