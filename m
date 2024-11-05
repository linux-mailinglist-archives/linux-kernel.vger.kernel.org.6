Return-Path: <linux-kernel+bounces-396564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102519BCEE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DF71C22C09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F11D8E05;
	Tue,  5 Nov 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2QnkjUhu"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964F91D9667
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816165; cv=none; b=NOyoo0TRZ4rY69IPVwAQrBYNPLjNpx8RBQteejoUI39sqk4JPsX9Jsf/mfCrRBzHmRA8sVlrU15/3SvOW1Kp5dvvcT34/wxJ3kybYO0M/snbfo9haj3bZVgbgBtyuxaqQigKSKi0aTfuenrQ2VjIBJwb7KDdavZkkWyEpFAxQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816165; c=relaxed/simple;
	bh=+dyqpfFMy4leGo5BAemyyMG5p4U6mS3MZnToKSINqzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFbeVaaBVE55caaMPQOJgdPxUrm1cmh1TKkYMQnehzToh9NVB1/Gse63goby5fO6l8CDSoFGzesB/dSC9gbtIlfyk/UtKseaDiep5aqU+pQBBc7MRsRgWz3hR6q+qQFxKD38Tmt9bAr1JQoLh/IvSeJnj1ckUVJYg2grLJr2SxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2QnkjUhu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aWJGYnIxqcxTHPvjBIj+4E5cmSvWZZuMHFJD6CvJfRQ=; b=2QnkjUhuC40emm/MdVtf+Vnrnx
	zlYpJRO0bwwvTiPvAjXiekdwQNMXwQI2p5eGRG9fNceFyOH5xv3BgSGcwBlJzFUmmSjOdp5qCjA6F
	kCITfwg/rAgSKX1gzlqHv2yjFNqAcF+asB/1zenY19yKd8bXjR6FtCF4Bb+HLxpGfckO2Pdenn+fu
	8WljUZdYlAaEGoH1qFlUsVJ5areQl9+Jq8t4GtXRbkLahwFudXffdXcU/y5fTFYOGF5/GUkzQ48Rt
	+RAb5eUjqAzaUDpLnR7KzONDiW4UX0uJSDuD6y/5yy43QQPCMuChCkgFxfcUmAFBUnCh2MbeT+cvP
	uKCMifjg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8KLh-0000000HEQQ-0V0O;
	Tue, 05 Nov 2024 14:16:01 +0000
Date: Tue, 5 Nov 2024 06:16:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	alexei.starovoitov@gmail.com, ebiggers@kernel.org,
	samitolvanen@google.com, kees@kernel.org
Subject: Re: [PATCH 1/8] x86,kcfi: Fix EXPORT_SYMBOL vs kCFI
Message-ID: <Zyoood0ooSbpultV@infradead.org>
References: <20241105113901.348320374@infradead.org>
 <20241105114521.852053765@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105114521.852053765@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 05, 2024 at 12:39:02PM +0100, Peter Zijlstra wrote:
> The expectation is that all EXPORT'ed symbols are free to have their
> address taken and called indirectly.

I don't think that is the case at all.  The is a relatively small number
of exported symbols that are called indirectly.  I'd much rather mark
those explicitly.


