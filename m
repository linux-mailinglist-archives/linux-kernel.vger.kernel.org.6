Return-Path: <linux-kernel+bounces-405182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F969C4E01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875B7283161
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8405420896E;
	Tue, 12 Nov 2024 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KX+s4G5G"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A282204946
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731387612; cv=none; b=eoDHiNjHACMg9sDl+6TFhFR/RL3sKE3W3SZqRlLDRmv4p+HpuenYr0KFZKq9MYWKJjsY/r8UrQwWlDloIt87i25SVhlWUDRjeNjRX4BqLfYJMfg9BxfuKbPvjaQMvUvfn9p27f6xQEb0P+67WvINVN8eXDqnbsj60WvbiXabZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731387612; c=relaxed/simple;
	bh=d4R9S5lvPZb7yQlmXCJyWFfgX8b17dg2PPN4puY+IOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTHQ8U90qZBPVvt9AuNDV9O0XoRklfzEf10mef9Dlsyb7oUkQGCaxyx+v/Ll9Zg6BuX5/nJPmw1hAcGGYr0tLJBHncPCwLHtdVYJfM5ER9J22U0RgOXDI2ZtKf3IcmfvwA7aFjwcUoCmm30Y5k1byQctco+wupkE3hszM3msvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KX+s4G5G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jI/9qg4B24LYqZ/9yqixmz/TKAgMK+2egUMdD+Ao43s=; b=KX+s4G5GYu8Z7KDTEv1qlUMYo3
	udbw7k8JuYkbegAT8OWc1Atmh/a3SKhab2JZoE4NX1lkOgyRzKLz+pXNTYJ6bgiSOj6RLK64Qmtuy
	bVJAsMzv7b4B6/gXkh7b/s1YrqL1cQV1iN8Qvz/QrqYS519lMEioYxv1CjtndNkala0JPOIvxnqIn
	6JJ+6e/NWzCf52Lo+aFfJM/Oq0nYPKZlOFUATOFJdURon8IueN7bnAEegGKRg2PTF/fUT/mPvxhlK
	gX+D9fHKDucfSRY8N6d1IO0T9dKsvb2rnwvLg7JSeoptIzbwH33rsWrIL+1pIkGqixO8pf7R8aKPB
	NQuRRWlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAj0b-00000002CxK-1i7G;
	Tue, 12 Nov 2024 05:00:09 +0000
Date: Mon, 11 Nov 2024 21:00:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christoffer Sandberg <cs@tuxedo.de>
Subject: Re: EXPORT_SYMBOL_GPL with GPLv3
Message-ID: <ZzLg2etoX94Nb0yk@infradead.org>
References: <17276996-dcca-4ab5-a64f-0e76514c5dc7@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17276996-dcca-4ab5-a64f-0e76514c5dc7@tuxedocomputers.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 11, 2024 at 07:40:25PM +0100, Werner Sembach wrote:
> Hi,
> 
> asking at the source: Can EXPORT_SYMBOL_GPL-exports be used with out of tree
> GPLv3 licensed modules?

No.  The kernel as whole is licencsed as GPLv2, not GPLv2+.


