Return-Path: <linux-kernel+bounces-352769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BD99923EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8136AB222FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C04F136672;
	Mon,  7 Oct 2024 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3OAFCiyk"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE923AB
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 05:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728279713; cv=none; b=fLw+Rc3cNxhzLnhqaN3AYSDodCuWL9+63BVsyQ/7oraeJAmwvo0HYbG00XBA+k7g7l5Ec7pvNjt7xkoip2rSYbhd2bR6MI9qyT8g6sgAwqOMHq+uumQVrsYVwNrjCdygqxCJUFNBciD1lGMWOWyLI3rfOLszeOfarwIXCnzqvEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728279713; c=relaxed/simple;
	bh=9nmx/iFyRZMUC5VGupQxMufehse6TbfVu4vhQKy87Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va9uWK0X+Hyq1h2lrvLHdIFJF+pHiOGtDKFFElVfeMxfsZAEOlHuCdQ4K4DvZNm9qTrk28AT3rBfRYs6L9TiOMmGgKVhDkhfnKjt+cGoDosV0fLbtYEd51Ed6MnVaps9AyeEoRfQHq7Onymah5fewPP8rwGsQG1wvUc6tysF3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3OAFCiyk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9nmx/iFyRZMUC5VGupQxMufehse6TbfVu4vhQKy87Io=; b=3OAFCiykpp7nOYl+dB6bg3qa2D
	rAgzBQies5yIhomIwywv6y5EgdTVG4c8iXFr0I5IE6LAfByuoXiFUHxLpMs2qFkq8hm4LitvIiL4/
	1Io5dbBht02Mej5+4M5Dahd2LPkvJ6RSNsW68JY5l7PgnlkHPq0IREJZOCt9Ej7GqKNY/e5ZfDSnw
	86K3qWadPoIy5O4FYOYdrSJz1Q2eGlwLfNA+9bz6/nKVLF2D9zLi4kItAthMqzXEVJziLql4GXuId
	7VO23DLWl8WjyWJf9yig0r6ezENlTnl2k4TUF52IxKiowDtKgcm7CrUeNu/XURlsnOwOWuDSip4Es
	Nvp3n6zw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxgV5-00000001KBz-43dM;
	Mon, 07 Oct 2024 05:41:43 +0000
Date: Sun, 6 Oct 2024 22:41:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v1] riscv: make ZONE_DMA32 optional
Message-ID: <ZwN0l0Y_oUfDX8jl@infradead.org>
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
 <e8f6ed93-d47c-4c07-963c-8f16f498abed@ghiti.fr>
 <VI1PR09MB2333FEC324AA0B3E5F1D7F98947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
 <VI1PR09MB233370D7BD8553E7891EF46F947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR09MB233370D7BD8553E7891EF46F947C2@VI1PR09MB2333.eurprd09.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Oct 06, 2024 at 10:55:39AM +0000, Vladimir Kondratiev wrote:
> It is not necessary any RISCV platform has ZONE_DMA32.
> Platforms that not support ZONE_DMA32 should set
> CONFIG_NONPORTABLE because lack of ZONE_DMA32
> makes such platform non-portable indeed

Well, this doesn't get any more true by just irgnoring the previous
discussion and just reposting :(


