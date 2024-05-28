Return-Path: <linux-kernel+bounces-192136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB18D18F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE26B24E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC7416C693;
	Tue, 28 May 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QdkqbSBY"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440116415;
	Tue, 28 May 2024 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893606; cv=none; b=cef0yGz067ekSevXYHGmpkCARNO0LSWNbHVW9vShXUsmIzdiQywQc4JgyQARHwB3V+POS9Ozwte8S8eJqFh9cK5YuEL0T2lym+xoV4ubfe0RoW/RRZvi/V2U0dI0YeqRGkP5+c/IHW+pbodgLIBzpKtA7H5JV2YUHgcO68+IukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893606; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsyuLBo4qrZ9H/aHXYAV2PoV3SWWQCDe36duUskuIa0JVORFI4luM3PfxsJLJbqfjOjYs21eEmVV6g9+btq5O4zrMKlQjwj1YeYHpJfMStnzn6J8JH8yLSroabfhaledol/WT+MT6ZO25/V+o2WbqXBSeAal60ftZ5zLAgOtjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QdkqbSBY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=QdkqbSBY0uEvqnBt+ymcmpOA4N
	zBSdHyYLwsQ4Yi6zWeRC2f/S1YkS1/Cn7nHpAdXUDrdQiy7iXLh8NWxMy5v8THqNojQpOsYm18c3w
	ABUCs+n7ztyj8uI0JtUf3jAOx432QyBFoqN4TlceSGTPeCXbAGG7pSpEYk8RdSosuyQqNp5gYrK1U
	WwRAcq2yTiisVoYjlZeEf9lSXBa7Mioi1lcBQ+IkIKkaXkdAstAU2yxKq1aOYn3OQdKzwj3MRdkBN
	IuWL1CMfviDSB6IRDC1iLh9WR7eiehLPkzTOvLQRhV72KoeeFJIsHPoGDu4xESmSt0LCBHNCrgGbz
	fh8FBI3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBuSD-00000000H2R-1Nbq;
	Tue, 28 May 2024 10:53:17 +0000
Date: Tue, 28 May 2024 03:53:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guanbing Huang <albanhuang@outlook.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	Christoph Hellwig <hch@infradead.org>,
	Woody Suwalski <terraluna977@gmail.com>
Subject: Re: [PATCH v2 1/2] PNP: Make dev_is_pnp() to be a function and
 export it for modules
Message-ID: <ZlW3nTPv6YqQBs3i@infradead.org>
References: <20240528102708.1451343-1-andy.shevchenko@gmail.com>
 <20240528102708.1451343-2-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528102708.1451343-2-andy.shevchenko@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

