Return-Path: <linux-kernel+bounces-205868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB22900197
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EBF288633
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095FB186E55;
	Fri,  7 Jun 2024 11:05:17 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C715E5A3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758316; cv=none; b=GlCgP4lpMkFok2zsN0duMINgKt465igFt9XFRvkiaVf7xTDdmQ0U/sMhnWQIFPM6pOnwQOv0NR4tpRoSqR3LCVzq+8WmzXdxSyxwZo2lqM3Ez1JMyTIUebn0bAKh/HFbIo6YviBFeb45Va1D34bp1MWGASaeOIaZdIewcfDuxWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758316; c=relaxed/simple;
	bh=2hIGzyAM/ydipJ0a6gCRQYGh6EjForkYrE3iRYGhVM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UV6pHOi5ejfk/0dyp0mbwkGng+Zc2WVHpkPi/PmraOGIXXs0AZvKB7W7AoyOqfNLb6+R0AJ4mae113IZ3caBqAMVsxfvjUOBxbWSsfLVgNmAItKrqkTqCmw3xbTnoI8Uc4m+h3ZdvBwNnSkjFB4/n4DaIePlIb4Foz9s/qNplB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.117.214])
	by sina.com (172.16.235.25) with ESMTP
	id 6662E937000036D1; Fri, 7 Jun 2024 19:04:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 27571434210352
X-SMAIL-UIID: 7075AAB57E174405BDF22D17F8609E62-20240607-190426-1
From: Hillf Danton <hdanton@sina.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep worning
Date: Fri,  7 Jun 2024 19:04:14 +0800
Message-Id: <20240607110414.1953-1-hdanton@sina.com>
In-Reply-To: <20240606102921.GE13732@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org> <ZljyqODpCD0_5-YD@slm.duckdns.org> <20240531034851.GF3884@unreal> <Zl4jPImmEeRuYQjz@slm.duckdns.org> <20240604105456.1668-1-hdanton@sina.com> <20240604113834.GO3884@unreal> <Zl9BOaPDsQBc8hSL@slm.duckdns.org> <20240605111055.1843-1-hdanton@sina.com> <20240606073801.GA13732@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 6 Jun 2024 13:29:21 +0300 Leon Romanovsky wrote:
> On Thu, Jun 06, 2024 at 10:38:01AM +0300, Leon Romanovsky wrote:
> > 
> > Thanks, I started to run our tests with Dan's revert.
> > https://lore.kernel.org/all/171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com/
> > 
> > As premature results, it fixed my lockdep warnings, but it will take time till I get full confidence.
> 
> Don't series fixed reported issue.
> 
I am happy to nominate you for the 2024 Kidding Lore Award ($2) if the
uaf in the subject line got fixed with Dan's revert.

