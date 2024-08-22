Return-Path: <linux-kernel+bounces-296623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B352995ACE5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 167D5B21906
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A869B56446;
	Thu, 22 Aug 2024 05:32:45 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67D1D130D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304765; cv=none; b=UtwFVTX5zoYlEnUwPBdTi28wXrR6ASrkZadxlwjWW3bjtabaJHSMEblupXqiyKOIb5MLPMQZ0Vd0H6PWA3anxBgesWgKdTikSTRYrqcGz87SH5AmsHzBPZ0Vak5Dk9Fpl5MFpNPjdGaR9FV/oe/xNv7R69yzHJ/PgQAqiLbiMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304765; c=relaxed/simple;
	bh=YrsFIe6hBFi6P+pJy24L5+ofrSoGYJlrcwpSg4VMYjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1dIZWfPIeG+xdnR2rqkrk3nSeXSaCjDv7/+vq4D9Fo8VWfcd9fzDu0LfnnSLxVncQb+heGq/m8cwGXUzYaGs2aqJJ4+ISbiXUgJXpm3ZvSH1+V1fVG5dUH3gleokmsPxkTBPGWbV6T74UeHQ/kKY6VTLoF4Fqz252BVwYHag+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 512C9227A8E; Thu, 22 Aug 2024 07:32:38 +0200 (CEST)
Date: Thu, 22 Aug 2024 07:32:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Stan Johnson <userm57@yahoo.com>,
	Finn Thain <fthain@linux-m68k.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in
 kernel mode
Message-ID: <20240822053238.GA2028@lst.de>
References: <2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu> <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de> <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 22, 2024 at 05:25:10AM +0000, LEROY Christophe wrote:
> > and this results in a call to dma_direct_allocation(), which has one
> > innocent looking memset():
> 
> 
> memset() can't be used on non-cached memory, memset_io() has to be used
> instead.

No, we use memset on uncached memory all the time.  Note that uncached
memory != __iomem memory, for which you DO have to use memset_io.


