Return-Path: <linux-kernel+bounces-260501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C53E93AA4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AE51F239B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C0E5234;
	Wed, 24 Jul 2024 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eugFQG7L"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC22595
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783159; cv=none; b=J2Io7Y5J4b1dwcfVhWPaQe9KqAXWbUrMmA3VtzAVRiAOaO7Gc2Gu9V/Z/nH7R9oQfzEcb2wlIXJjpq7CNwp2dAdLHT0LYh5FG7yahLmTSkyGrNh/HyW8Lxdk1ALzmQEKE0HalN+9xbfMzKL8/Vtx1J1Hncik+uOjT6zrmm6vsFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783159; c=relaxed/simple;
	bh=J70/HkRji3yGcHx7ghC7+y+MYl8EFpwQ78kn7emX8II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1iM4PX91XSsglN2jhmL2JLgIDCRXYlfVJbNrmR2osVv69wqdaWk4ZUus3S+nEwNngRsfiHY1khIFhKHYpaY2fffq7Q/auexwERS/eGEkjPcNA4H71Yro9aU/v9kBLwx+gJtQGqKPX/xzQMIYXBcRewQ0UAW0UPiTMuW8nl6/QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eugFQG7L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=IBLTOOPWU+Ezw8uH49FNmzBnNf6k35LBezmdKgh91LI=; b=eugFQG7L+H1Kw4ceMNUpn69zOR
	r8ggdjzpr2FoNsKcS7tESKphR1mzbd5OPdTQTivBsXu+0G586crJyD05fjwbk/UVuYW/JP7D5ExZl
	pw5sMgzVY+in0ai4KbotlYa3jrxaeCypgbZaozQuoUjoSGE7McI6ZSqjbk4wzEA1yS74FzA2gQdb0
	IZssKFllUI6Tm+hR6+VpqzoJXgEucruSJ2bFZjH3FD9dVsm4GfigdJm4gqXX0VbMuiZJaiDdObFTq
	RUWBULnI6M3Y+StpeiOji1RsPtuS/evwl/7QTEUtkbKtblnrDtCGMqj5I2g+4+8eEsb6fMTioFva0
	3/LGMVSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWQS2-00000007MpC-1Wlm;
	Wed, 24 Jul 2024 01:05:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] Remove PG_error
Date: Wed, 24 Jul 2024 02:05:45 +0100
Message-ID: <20240724010550.1755992-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

There were four pulls I had to wait for before I could send this to you,
but PG_error is now unused and can be reclaimed.  It could wait until
next merge window, but I don't see the point.

The patches to do all this have been out for review since mid-April,
https://lore.kernel.org/linux-fsdevel/20240420025029.2166544-1-willy@infradead.org/
Current git with these patches builds with allmodconfig.

Matthew Wilcox (Oracle) (2):
  fs: Remove calls to set and clear the folio error flag
  mm: Remove PG_error

 Documentation/filesystems/vfs.rst | 3 +--
 include/linux/page-flags.h        | 6 +-----
 mm/filemap.c                      | 8 --------
 mm/migrate.c                      | 2 --
 mm/page_io.c                      | 4 +---
 5 files changed, 3 insertions(+), 20 deletions(-)

-- 
2.43.0


