Return-Path: <linux-kernel+bounces-262339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B693C445
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E913D1C2188B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061F719B5BE;
	Thu, 25 Jul 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y5diUdXP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBD13DDB8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918115; cv=none; b=ofGwgg2rqrebOdXJ+r8pWpy9jva43ZBSNG9FRQfNje8jQRo7JH4P+YL7E+rQBRTHufxOjUO3HhzS+zkUDGa83DOewBy0IkPhdlLVowVyIC+4dYtc4as62C4p0HDLtNj4hnUTi3Vy9D0BK/hLjqBu32Qp5k/AqkFMqS+otcFz/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918115; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFS2C1uozeBMNWkkACQPDduDKGHW1ofE5JkB/MANFOaEgIpw5R/D5r1HoJIj6hFuyayM177M3O/wWlakses9KE/hgarTXheu5oznat9xxQOlDZqON6KFqkm/OyCkX4h5s1zztyUuWG7ND3XH5qCk1He4IeeUNc/9MzH85jE2VWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y5diUdXP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=y5diUdXPPuvhwE9FGLv4sNTFzi
	SvabJLtXcEIcRYIFRfD+h//JKZf1nJB8APaHOCtxDPhkqdPNooaapumxANE0Qy1lw9/sfoGthT5jP
	sFjnS9CGNmoKeLUF6jA/qQZpz/xWKijNOTY2y4yINlsvvCTe3EcMJBeA2XjGdDAkciBOdk4bRQX5w
	ZdmBxypCcbPjahhMYzs6QJIWlk03UeUQyQp75CcKETOP0IczVfNi72P/J6tn6VOI/C2yq7Pc7TSAW
	sly87arB3C/C9LryVcuWjXarD7hMRPJ3hjZ1uEFry/YumRXZKYTeBlqMyFq1L9rRgNsWb/O562oTC
	XxoVQzAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWzYk-00000001I9v-3kHe;
	Thu, 25 Jul 2024 14:35:10 +0000
Date: Thu, 25 Jul 2024 07:35:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: remove tracing_is_on export
Message-ID: <ZqJinqnSvkbxSGPn@infradead.org>
References: <2024072508-freefall-headstand-7d47@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024072508-freefall-headstand-7d47@gregkh>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


