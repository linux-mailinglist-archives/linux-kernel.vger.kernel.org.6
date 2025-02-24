Return-Path: <linux-kernel+bounces-529531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5E0A42793
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4A93B702E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F38B262D05;
	Mon, 24 Feb 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="BV7CcMa5"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060126280C;
	Mon, 24 Feb 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413400; cv=pass; b=l1HN2PaB3TrWeq9wsmpb3jv0e7HPH2NaodaKTbkOSfIZ4qSQxSr6AmvPHuqV1jYlH/hYGHNl4KGaTYFvMbXimj4yXzVo5u4PKDO6TAgPe3fMw9yvT7zb9dM/VcPVnIYULUem6QIGUxb323KCuPcrRccLCToHB40gOWvRN0sQ3PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413400; c=relaxed/simple;
	bh=yUDPqWJAn1QuBpY+LecCYK+J86Z368gRsRpzovLjvFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KotA2U6ZOCYHDKnKI1PAUnWHjqDnBb+RIs+eo+kiL4/Y9FnUYgRBEYuvhyq/5ZVHDIpYe4eqviDj2mHQmzr4fKw86N41NxCm4+L/D4v7Okgt1p99uvfcVRNoIvVWPKs4601uHob7lYYYkoAd+AH2JROjJy72IRbnSpZ5rvTgklY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=BV7CcMa5; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740413381; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aIisYkxR7USnkz/L7VP4+tRDO1M+FV5bPTZiVveAFoDobPqvzBH+J1qNETy9qcgFkhHNhQpV+glY9RsoWINWHVraEmPWijQ5GHoDp9bjPlQkiL4V4LdyExMX+cbRWs/6WLq7VT73Y7XRcY/KOMPOveitaHDyI1rQIDe+I8+jDS8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740413381; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K0QcQE79+T+Gkm0QiqunnQ4Gi20EBmtYxx3mQVslkec=; 
	b=FzIDVcrObA/gHaQBORSFqZNoT88MfNGH1Rbw1oJPOoCSyWtj4+ftwudvSk+s8G0+v6aTxOs0ZtHiz8ThiXQJDZ0am/7ZN1QtTcahpgjT2OE8PljFhZ+EovQi8nOWzbTC5Gg53sMAHshwiGF9H9ogKkbo/BgpnmwnYbSAXi4pVyI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740413381;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=K0QcQE79+T+Gkm0QiqunnQ4Gi20EBmtYxx3mQVslkec=;
	b=BV7CcMa5wA7uNQPuUZfK9r/uD4XeRsa2SzHi4JpQoPrhuVM7ykb3qZpr62tzI6WC
	Crr6XwjAdizZ4G5NKd9wOiUiBcb9Esq+Ics9wd7n7pwDVVtS36km+/a5c1nYPoMv0pD
	OccvtWCFcqUt/ootaSeQi8HDxMc41WG74MyCruyI=
Received: by mx.zohomail.com with SMTPS id 1740413380078991.7727896242427;
	Mon, 24 Feb 2025 08:09:40 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm-graph: set fill colour of turned on nodes
Date: Mon, 24 Feb 2025 17:09:36 +0100
Message-ID: <6130937.lOV4Wx5bFT@workhorse>
In-Reply-To: <3d15fd23-3756-4a17-a447-b5ccb2c564df@sirena.org.uk>
References:
 <20250221-dapm-graph-node-colour-v1-1-514ed0aa7069@collabora.com>
 <20250224163311.0611da3f@booty>
 <3d15fd23-3756-4a17-a447-b5ccb2c564df@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 24 February 2025 16:42:08 Central European Standard Time Mark Brown 
wrote:
> On Mon, Feb 24, 2025 at 04:33:11PM +0100, Luca Ceresoli wrote:
> > Hello Nicolas,
> > 
> > +Cc: Mark Brown
> > 
> > On Fri, 21 Feb 2025 21:39:32 +0100
> > 
> > Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> > > Some tools like KGraphViewer interpret the "ON" nodes not having an
> > > explicitly set fill colour as them being entirely black, which obscures
> > > the text on them and looks funny. In fact, I thought they were off for
> > > the longest time. Comparing to the output of the `dot` tool, I assume
> > > they are supposed to be white.
> 
> As documented in submitting-patches.rst please send patches to the
> maintainers for the code you would like to change.  The normal kernel
> workflow is that people apply patches from their inboxes, if they aren't
> copied they are likely to not see the patch at all and it is much more
> difficult to apply patches.

Hi Mark,

I used b4 to submit the patch, which runs get-maintainer when I run b4 prep --
auto-to-cc. You can see that even running get_maintainer manually for this 
file, you're not one of the recipients:

 ./scripts/get_maintainer.pl -f tools/sound/dapm-graph
 Luca Ceresoli <luca.ceresoli@bootlin.com> (maintainer:SOUND - SOC LAYER / 
dapm-graph)
 linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / dapm-graph)
 linux-kernel@vger.kernel.org (open list)

It looks like you're not listed as a maintainer of this file or a parent tree 
in the MAINTAINERS file, which would explain the discrepancy.

Regards,
Nicolas Frattaroli



