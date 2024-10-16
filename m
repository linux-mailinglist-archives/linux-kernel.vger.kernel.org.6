Return-Path: <linux-kernel+bounces-367544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A299B9A039F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EC6281D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6711D5ACF;
	Wed, 16 Oct 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IjHv7E37"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AAB1D54CD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065815; cv=none; b=j0inGpWlwqnWngEbjYgacrcHAibzpxefGN7vUNHWmv6i4aUTv3aLM5Gjza60gZF3dGHrxZwNDbJuQiRKhR/kj6lY9yJMY7HIKr8zdQoRAHrb/ZvOVBU05esJG6AwzXEhO77l/+NYussX8TnvAcSGRplhTNBgZ56Pc+eaAuZJGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065815; c=relaxed/simple;
	bh=cCY7fIIdD9vzLcDjnHfpOMFMIQtReCFg/F86NN2j8Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmeV590xp204ca56Hfun4SKDZoauhkpgNKaK1KAtENNg3afqstiiXX+9hgsuCRJE985SaA+9VcFfxqNKCl66S54pinQFXr6EhAb5yySh6q3zADydjL0WGAHj4aMjrjQy6WOXOhy9A/ZU5f44OOj+HX3yX0xZh6jRQqjowOALhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IjHv7E37; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cCY7fIIdD9vzLcDjnHfpOMFMIQtReCFg/F86NN2j8Pg=; b=IjHv7E37m/fgFFaRVelx/XvCgx
	TqBYcC6nZKkJytqtM3wjX5j35H/1sU2/1o8Gha8Pn6MPyEDOCZsl4/vaO0/jcGCS8VrAeuXiCJgWM
	oI9tV7bTH/Us0f7Hjqq7u8sTEdz4gEbr34C/tu5RflD9YlMeyXCOogKARGUTzkHWGShB0RgNZnLes
	G2uTpffmr/S8bXiY6utyF5AdRJ/vwflxp9MIPXTJNIeYlDJlik5/k4hsUTpe4TYvdEuEScynz2LUb
	+hCyZXMXQp4yn6H0Y2i1gyWGvMWIv//tHFciVLy+kYZHDUFGRcQxjzbARIwUHtMM4zJs1bB0bSL+k
	ImvMvxsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0z0H-0000000Aw9l-0FTJ;
	Wed, 16 Oct 2024 08:03:33 +0000
Date: Wed, 16 Oct 2024 01:03:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: lizhe.67@bytedance.com
Cc: hch@infradead.org, akpm@linux-foundation.org, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Message-ID: <Zw9zVQs4Jp_oUpjM@infradead.org>
References: <Zw9s86K0Dv2FZvt2@infradead.org>
 <20241016080057.43997-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016080057.43997-1-lizhe.67@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 16, 2024 at 04:00:57PM +0800, lizhe.67@bytedance.com wrote:
> OK I know what you mean. It is indeed OK to remove "extern", but all function
> declarations in the rwsem.h have the "extern" prefix. I think it would be
> better to keep it consistent.

They are pointless and should never be added.

