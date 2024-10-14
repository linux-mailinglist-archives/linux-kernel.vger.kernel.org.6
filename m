Return-Path: <linux-kernel+bounces-363247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B299BF9A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9009D1C2213E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 05:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290913D2BB;
	Mon, 14 Oct 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fegLa6jn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA313BC18;
	Mon, 14 Oct 2024 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885408; cv=none; b=VF7Wifp4gqa0nTWWJWYze4kNVcyNHhVo4njv80dkPavcRyOh1b6vBD+kAb75JB+jpg9BaIJVyDpE3oEuzkYJM59MwaeminlSy5GP2RSCWmOxGGQgSFxGWd4aTiIXI/UFiWUGmNvOwLzjqxUpAYpt6Wx+4jeo/gRCJ82dFPDYL3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885408; c=relaxed/simple;
	bh=yB1MZG1Qa1qE1idZEm0cZSis/LeY/QkS+vD8naHCaNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGLTogieLN+ERozdnLzKL0lH+lR3MISFW5frdiRj/Rg9qvxr9CZnynFJsK7GUS8x03MnDZ70XrpG8aEpW1qQvOfQhIZ5OILd7byiorVZ7kJbK6THBL6GBn861GbVqCvBE5OjxiUD123058nb4g6bgcb/5bzviRpLn/3ET1/h1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fegLa6jn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aESkWpHra8Ha0Uwrq2Nm01+2Q6btlz5Wqf9DpnTb8+E=; b=fegLa6jnV44NsoSjvx5VMzMt43
	N1njSqp3198V+wBiS5SlaeiKYaEd/+jkKzC3n3rYCkNKBhRw0z9+IoLdlx4fzZcUuMI8mrbX1/V3q
	2pgZd/D7vSrgkcelIyjctDKLGStVqbTAWnfaxtb7JElIubIJhioL+fuoYiA1REmOeokicqu5/D1HE
	QUiGs4uUYw/ZKudl8SjlarC4B1PIHFIMtL3M+TXGajS+X50ePVxrwiQweiKAE4MjhN/NpvpBfTKSq
	3ovlA3vcJMY1M2tAOT2TIYdAGlJAUlWPA8Oi7r/lPF/Au3dITr+MbzR+H9LYkehSaKQfrcEqvsl1Z
	ktcFhoKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0E4R-00000003oPm-2ZKZ;
	Mon, 14 Oct 2024 05:56:43 +0000
Date: Sun, 13 Oct 2024 22:56:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: hch@infradead.org, Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	kernel-team@meta.com,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] elevator: Remove argument from elevator_find_get
Message-ID: <Zwyym8cvSYg2Qh-R@infradead.org>
References: <20241011155615.3361143-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011155615.3361143-1-leitao@debian.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 11, 2024 at 08:56:15AM -0700, Breno Leitao wrote:
> Commit e4eb37cc0f3ed ("block: Remove elevator required features")
> removed the usage of `struct request_queue` from elevator_find_get(),
> but didn't removed the argument.
> 
> Remove the "struct request_queue *q" argument from elevator_find_get()
> given it is useless.
> 
> Fixes: e4eb37cc0f3e ("block: Remove elevator required features")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


