Return-Path: <linux-kernel+bounces-352810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216BA99245B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E29C1F22BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E8D13C807;
	Mon,  7 Oct 2024 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VbF5A3Jz"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47696101E2
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728282134; cv=none; b=P3YoxQAed0DLMeUsMAElqTZDPJoRoKVNHg+taE01VS8Ku9yLNkasHVUazOklVSX8ooH3b3z5pAkkY6TrW0gOkA2WiognHjlYMbghdEfhRfIrQufPtwxu3Caew73dUeeBd+ec82OXnjfXFUqaDyXBWaRz7AF3BGU34nY4BBogQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728282134; c=relaxed/simple;
	bh=S0b8AA8OoUWAO/Rkvpb6OQmPRANfSg3Vc/f6nm+NaQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIv3uT7L5ER+v98JoNWCTDPujRGEvJfZ2/Gi6M2oXQv8Qzht4TUzakJM7aNmeHnyIN/aHdCTUu3W2fXAeSYFJ0H3cxgMuXUKE6rFGHRBEWLa4DNJXxPbG7499uUgTVZ20kzaj6HAR3luFSf/SjMBfJ8whCl4SYwchQ1AVUq5Oq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VbF5A3Jz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bgk+pgWE2jzGVBKPUQmz0/Xlcerm+872WRQL7Nno+5U=; b=VbF5A3JzfMrRqDDmRp30kH5cZ+
	hAGQzy+E4iiiGyKEN6kxXd09RLoZYAU6vc4eHiiwoFAavwlDSFX7pSy78KPw/7qke5/lZ0v42BUnQ
	hd3A735hh2kRpvOE0KsDvIpvXscnByqvCrw9e3wtL3D/3Qw9GAWYGmsCufOFsMavX9kSEstKarQsG
	26GN96ODVvEztQRW6S4MUI8U3xgoJVdC1OhIdmCSW4BiOqq1VMHgU0qGnkl7EWycQtDOAWNaSHSCX
	8F304ptq5eWi/bHDj7NHC5KJT/Dam4pzJp1MmKrFdg3bxQ914ce+2RWhnUUmXmBI/kyQjdNf2i76Z
	RMlCxsxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxh8F-00000001PHa-12lh;
	Mon, 07 Oct 2024 06:22:11 +0000
Date: Sun, 6 Oct 2024 23:22:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v1] riscv: make ZONE_DMA32 optional
Message-ID: <ZwN-E279o4bUQG26@infradead.org>
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
 <e8f6ed93-d47c-4c07-963c-8f16f498abed@ghiti.fr>
 <VI1PR09MB2333FEC324AA0B3E5F1D7F98947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
 <VI1PR09MB233370D7BD8553E7891EF46F947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
 <ZwN0l0Y_oUfDX8jl@infradead.org>
 <VI1PR09MB23335FF3B1274ED13F24AF06947D2@VI1PR09MB2333.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR09MB23335FF3B1274ED13F24AF06947D2@VI1PR09MB2333.eurprd09.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 07, 2024 at 06:17:14AM +0000, Vladimir Kondratiev wrote:
> >Well, this doesn't get any more true by just irgnoring the previous
> >discussion and just reposting :(
> 
> Sorry, this wasn't the intention. Perhaps I messed with the message-id, I see my "patch v1" in one mail thread together with the previous discussion, but not in the other thread.
> 
> Anyway, I think making ZONE_DMA32 selection depend on NONPORTABLE answers the concern
> that was raised

It doesn't at all.

For one not having ZONE_DMA32 is going to break a lot of things.
Drivers do expect 32-bit addressable memory.  And because SOC designers
know this there usually is a way to provide it, e.g. by doing window
translations between cpu physical and bus physical address.  Please go
back to your data sheet or talk to the designers.

And if there really is not way to provide this, the right way is just
to stop the runtime allocation that triggered you to do this if
ZONE_DMA32 is empty, not to add a non-portable option.

