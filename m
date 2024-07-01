Return-Path: <linux-kernel+bounces-235632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E15491D7BA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0EF284012
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE53FB01;
	Mon,  1 Jul 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rYZ8xH+K"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785455C0A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813350; cv=none; b=msBG3kLnt8fv5pKE06VPqMbjPKz+k47Fhi3nMOnwEMsb03XtiypwrsPPrsk0zEkugeNxpmY1hKaY3KkPxlBl5ahbLHDUHYuC0wI11QE3KKpxfpKzdqoEnh4el/Vyyrrg2uQ8llGLiNJ6nXS28sEEg+4had7UwKoBBuvnU4OGvuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813350; c=relaxed/simple;
	bh=HnbUgnqC2Tm3wz/0+VxJtv5MDvTXFV2tkoB2XD82dVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFsAYnbfAX6jdcbueDOa1KHZ4m7BIBpr6xi8neq5hVFMir7DwuFS77O4zWZp32Zv6TJmczTgMAcke+4+qmipOxtsAZQITsVyQ28Q9CW+pekxb4CvaRwI5c+K0nndk1nY6ZbPOk0TnF6/aLZSaRONde+A4ayxnxf6s4CeRkMH+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rYZ8xH+K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wbNl1mwH84TBusIkc0TTSLLhtgp8oAglBk3w20pHOik=; b=rYZ8xH+KTYDMDPNyMyCIS0ts54
	mjeMacjTKlfA9yS8oHfta66yGsZggzC3VjuqKnV2Il4/vy+g5NXPRux2jhZjY1cjgFhuwk2byEQPd
	+OW0V5TnHDHze1Wq5Aa8eDVse9Hu5tYwYQwhvvKUCIRSGRYOBaQNzNm22iMEfdY/7LK9LokiiPFke
	MNcGhLZletdUtQb8aR/mzexy6wEAseMsC+bvAtd9I4IJ158cvnVjb7Y/LgJgDu8iH27pbTkQU8TsC
	EhLRbP9yjdoNusNvs+9sO8/Sn/4wPjCyyR+pY7YavZZAOtYniSQ/+YKzUy35iywSAEZJYdLCinXnL
	W7x1oPVw==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOA0u-00000001nbQ-2JhY;
	Mon, 01 Jul 2024 05:55:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: remove unused ioremap-related code and export (resend)
Date: Mon,  1 Jul 2024 07:55:37 +0200
Message-ID: <20240701055542.1315167-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Russell,

this series removes one unused function and one unused export
from the ARM ioremap code.

Unchanged resend of the series from the previous merge window.

Subject:
 include/asm/mach/map.h |    7 -------
 mm/ioremap.c           |    8 --------
 mm/mmu.c               |    1 -
 3 files changed, 16 deletions(-)

