Return-Path: <linux-kernel+bounces-259591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F90939901
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E86B1C21A70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B3B13C66A;
	Tue, 23 Jul 2024 04:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b="cRqgEewk"
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B228E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721710669; cv=none; b=iuiAsPlsb9Uu4OyYZt+G3T0Rab6QWsMrq8zxYDG8/Aq9Vz4CKhBdcopx9qe3HhOCGKMxKX1xjBYmtNxilt6HycK7JRTL3//G7ppQ46PMW/ViAxJl/cnzo7SKVqWlZSyAhfccAnWIubBK3vMB2+IjyGL+ykbPZLxG5tw7V9lwM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721710669; c=relaxed/simple;
	bh=y8gfn6Nq4JP/a5Xp93MH9teIASqXRLUqnwsQNoN61bw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=otWOAl4i03YTAUG9Ms7Yvl0WHv9NbjFBdPAfrBmPmwelLFRPXyTKhk+iwTDe1N49K539fovQTK3zG7nh2XSZmFMPkAUvdmIepFRxUZxpbIT0U3J7sQQjRpuTcfs4F7Om5UlIugFU1gStyCwJcraMWEPLbByQo7WSt3FkU9Bx51w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b=cRqgEewk; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dominikbrodowski.net;
	s=k9.isilmar-4; t=1721710065;
	bh=y8gfn6Nq4JP/a5Xp93MH9teIASqXRLUqnwsQNoN61bw=;
	h=Date:From:To:Cc:Subject:From;
	b=cRqgEewkfTsaGE63kCeyPjY4KW9Hcgz8IQbzEj+EiUHbCXBtGrjIlEQDW2kemxOn0
	 JbyOJHwtpVTbdICbyEMn/7Z3X5ILgGIdWYPWuRccXezLQ8zTEScgw97AwPqEB251vV
	 CFmsgYxl+5fT2rtNkKWK1ETBENNlCRXy0Zo7UYzKxaDmjGfazH3PtxXbwWqZreUZZD
	 OE5Je3dBRkHunSAHLhnYpgPGWiuJ80u9rgoIlBHyViSCpBkoH+HeVjZzrfNTC+6k+3
	 kfcPgaPelfvhK+vqvX5bQzVSKkI00PQGWU8EL42+HZ/xk8XtXx/MB9dxD7fA4CcAtJ
	 wCB+HFGR3Z+Ug==
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id CC49B20050B;
	Tue, 23 Jul 2024 04:47:45 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id AAB2AA0086; Tue, 23 Jul 2024 06:36:09 +0200 (CEST)
Date: Tue, 23 Jul 2024 06:36:09 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCMCIA improvements for 6.11-rc1
Message-ID: <Zp8zOSU5FFgf16pr@shine.dominikbrodowski.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

a few PCMCIA changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454

  Merge tag 'powerpc-6.8-3' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2024-02-17 16:59:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.11-rc1

for you to fetch changes up to 0630e3bc0e91b57288921df2927859b23184ca45:

  pcmcia: add missing MODULE_DESCRIPTION() macros (2024-06-30 15:51:34 +0200)

----------------------------------------------------------------
PCMCIA: improvements for v6.11-rc1

A number of tiny cleanups of the PCMCIA subsystem by Jeff Johnson,
Jules Irenge, and Krzysztof Kozlowski.

----------------------------------------------------------------
Jeff Johnson (1):
      pcmcia: add missing MODULE_DESCRIPTION() macros

Jules Irenge (1):
      pcmcia: Use resource_size function on resource object

Krzysztof Kozlowski (1):
      pcmcia: bcm63xx: drop driver owner assignment

 drivers/pcmcia/bcm63xx_pcmcia.c | 1 -
 drivers/pcmcia/i82092.c         | 1 +
 drivers/pcmcia/i82365.c         | 1 +
 drivers/pcmcia/max1600.c        | 1 +
 drivers/pcmcia/rsrc_mgr.c       | 1 +
 drivers/pcmcia/yenta_socket.c   | 7 ++++---
 6 files changed, 8 insertions(+), 4 deletions(-)


Thanks,
	Dominik

