Return-Path: <linux-kernel+bounces-260536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072F893AAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A12283CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172EFB67E;
	Wed, 24 Jul 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="boIcptl7"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70996AB8;
	Wed, 24 Jul 2024 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785008; cv=none; b=HIIqGenPBb4vdXFS+buO5Co4KkCoScaIHKoIjTtJzobZDbDvTVkDH7io1I2NyYrYW4Pu+UKBb/v5oq+qypLeN4wbAtCp/VYvktTn5i0KkMPwY1Dznk/hT05faJfFka8ecssvChv3tKu2AFRLkN0Y3mlt96AZ8A8sIL7jMmMJUPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785008; c=relaxed/simple;
	bh=DSoHkrticSUz3ExlaqEpt/d/4CHtbkEtdwE/BGTS6J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY87Ed8OJLiO8EtCZIdxIfEQwcHY6HpOAbAF2d50V9Z5RoqCLcGJClSNTdUMwZcMrcf6COj+If6Za3l0FiBlkt/Upvthr5rdzzujOfDfIXagz+RU8XCXHyHmLo7TfpoF/jGPngPwqtjnqQ9Q0AZ/y5PgBonn0N9cv7tywCHrO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=boIcptl7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DSoHkrticSUz3ExlaqEpt/d/4CHtbkEtdwE/BGTS6J0=; b=boIcptl7aenWh5FcQpx98Kn4H9
	ezYw2FaUz+kLWIOdii+AkfQVUCjtcXkmGcVOnl8trncEV1+jZ99OsoJAVjjBYDmwzExbnRYl4uNRe
	s5zHiPs7OyDYDSGPcZW6xMN9J9Qu8O2RgliHN8NJxap470usxy/ePBuRcsBUf2aLSnxuaT6r7eFmE
	rh5o1bkWtDQN9S8imx2TNAc8q5eTJ5xFjCtq3ATUyuSwaP3FmZqF1yCvMJjM9cwOomtF9CGuxtKhL
	YFmRNxm6Jzi7A3E7knLTsf2/GVH6zTsQE3dv5Pbp0RJsVNy4nBOjvvWndj4Eze2J+G1QJo/M/vHud
	wCwxOZYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWQvq-0000000E1iF-2eD9;
	Wed, 24 Jul 2024 01:36:42 +0000
Date: Tue, 23 Jul 2024 18:36:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mary Strodl <mstrodl@freedom.csh.rit.edu>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Mary Strodl <mstrodl@csh.rit.edu>, linux-kernel@vger.kernel.org,
	urezki@gmail.com, linux-mm@kvack.org, lee@kernel.org,
	andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
	s.hauer@pengutronix.de
Subject: Re: [PATCH 1/3] mm: vmalloc: export __vmalloc_node_range
Message-ID: <ZqBaqlXi7zTjntP4@infradead.org>
References: <ZpkQQ5GzJ4atvR6a@casper.infradead.org>
 <ZpkWj-iFiA-JHbbf@freedom.csh.rit.edu>
 <20240718143103.82e33c556b2d1b6145ae43e0@linux-foundation.org>
 <ZpmKho9_t0_MeOP7@casper.infradead.org>
 <20240718143924.43e22f68cf639b064a83f118@linux-foundation.org>
 <CAH9NwWf_S-PyY5X_cJGSW-8YDk4-C0VvnPCX8iVuo0FhTqsy2Q@mail.gmail.com>
 <ZppU8FhsFd9cB-Fi@freedom.csh.rit.edu>
 <ZppfQFdwYq-bf9Wv@casper.infradead.org>
 <20240723170043.4f17a3d0b6280e57561ba1f5@linux-foundation.org>
 <ZqBHwnPW_R4lFXVK@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqBHwnPW_R4lFXVK@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 24, 2024 at 01:16:02AM +0100, Matthew Wilcox wrote:
> That we're running arbitrary x86 code (provided by the manufacturer)
> inside the kernel where it can undermine every security guarantee we
> provide?

.. and by exporting the interface allow arbitrary other code including
exploit code to allocate writable and executable memory?

