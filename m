Return-Path: <linux-kernel+bounces-557263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B3A5D5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4154D1897861
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566AC1E2007;
	Wed, 12 Mar 2025 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rui6Is0J"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E691922F6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741760382; cv=none; b=PR6A4yaWXfpNfCswE3KnaRFIWL9hA4h1icI8tQmOKSrF+l5xU/qIrbiz/FrhlSLFaqd23NMOtZbmfmv3bjX4p+lSaMue+TQf0ICgfrq+QtivBc5YjvUV8U/3gaZYiVJ/d5U2Rb4W2U9yRmK/fSOrfvR4EiYJV07XtDhre/fpi8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741760382; c=relaxed/simple;
	bh=Wl9slbRYFQqPhM6YJuD7h6szHEuOC24lkhlQ2FISU9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPoJm5VoUPRwaz2wkfOWvHed72STLmwlNO6yuY7ZiCVHS2wXv+5Jj6p+RHwOX/kJLwT3LrhEUc9QO/pQPm/pWGkccsxPff3InPd5DxeBeTBOtAjaYPiO5YD2WNGYFFWtjn89mSNO66YN5N4mP4AcFhcxE78P5bVpXY2TQMB7EX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rui6Is0J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GxVbFnrBATzHuuQ1+4A3hU4fcRxdMo9pKDCDk/PUtz4=; b=Rui6Is0JfL0fFuLn2mBWvJt/mw
	tQEW6NhkctDQR4lijWIfl+Bvtj76uaFu5fuU3Ny1hfifqu1eGakBFn05F5aRe5SgpxCiZZivaMluw
	RyqP2MuXEaawdjdeVgVXvdvwoyoQeoLe92ZXilMqUtCEHLk8wY2ASc/qRzc7UtQ2czmUPPJbJljTU
	hcL/pl3FT8jxtftz6L1Mwp/puAdKucz/VNUW8sF6l9IHpzzuL2j+QqwcANEe7k14x0fuUJUgTuUcB
	6XSDpXudbaQRU5sgw+wgtnq2ONLXN4mdkxvsEO7eYketwlcxvKj1PKF0Of6TjZugYrTQHs75hJwqV
	qR3KRmsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsFRK-00000007Znf-02WM;
	Wed, 12 Mar 2025 06:19:38 +0000
Date: Tue, 11 Mar 2025 23:19:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kit Chow <kchow@maxlinear.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: pci_p2pdma_add_resource of bar memory rejected by memory hotplug
 as out of range
Message-ID: <Z9EneeS3PzT_VCr3@infradead.org>
References: <SJ2PR19MB8094482894628FF87E806CC8A4CB2@SJ2PR19MB8094.namprd19.prod.outlook.com>
 <Z8jpi5nf63APb8aN@infradead.org>
 <SJ2PR19MB80942BB17ED2D5B34AF2C230A4CA2@SJ2PR19MB8094.namprd19.prod.outlook.com>
 <Z8juCusc7oA2VG9v@infradead.org>
 <MW6PR19MB81100BBC506D295C5FB2BD5BA4CA2@MW6PR19MB8110.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW6PR19MB81100BBC506D295C5FB2BD5BA4CA2@MW6PR19MB8110.namprd19.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Your company is selling solutions pulling in CDDL code (ZFS) into the
GPL licensed kernel.  Don't do that, and don't ask for help with the
legal and technical mess you created.


