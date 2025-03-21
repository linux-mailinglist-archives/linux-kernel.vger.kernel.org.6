Return-Path: <linux-kernel+bounces-570724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 954ACA6B3EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17DF1891ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82541D8E07;
	Fri, 21 Mar 2025 05:05:46 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21003184F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533546; cv=none; b=oTfz0kENtNAbXOFdjm9Z+3x+UJJyj1D/pc9BRgxxxybnmd9e3TtR/XVfBT25Uozi0Q7oKuFL9A0MWnr9yd+Dus4sOob+Jv6p0Y3Vs9liGlR+GyZnjKJBs9bIxulxrL2dAjozKMaexqu2erlyzbnv2eb83zQ+5CvOiac4hjjC0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533546; c=relaxed/simple;
	bh=hqE0DWR0QvEKKxfmQXgNlpXx/3yw+/ivNNrnEvnsOb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma1Eo3lecqxbt69a8ZCuhsHWteQdv67pGijeFTZgPTeYialdG3uJZ6crWsmTkTKWGAXwoL+hswyri10/QqXYfgs337dq9dZPxN88ZzLdsOhyzPx8B2TscNqyOdQ9omaJk1Q/LuO1J1E/sptS4qqS6e3rJVHZZ/R3LL8FJBT9N4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B02B968AA6; Fri, 21 Mar 2025 06:05:38 +0100 (CET)
Date: Fri, 21 Mar 2025 06:05:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?6YK15Z+55p2w?= <shaopeijie@cestc.cn>
Cc: Christoph Hellwig <hch@lst.de>, kbusch <kbusch@kernel.org>,
	axboe <axboe@kernel.dk>, sagi <sagi@grimberg.me>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"zhang.guanghui " <zhang.guanghui@cestc.cn>,
	gechangzhong <gechangzhong@cestc.cn>
Subject: Re: [PATCH] nvme-tcp: fix selinux denied when calling sock_sendmsg
Message-ID: <20250321050538.GA2038@lst.de>
References: <20250320072517.GA14672@lst.de> <1382721899.82743.1742525374789.JavaMail.xmail@wm-2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1382721899.82743.1742525374789.JavaMail.xmail@wm-2>
User-Agent: Mutt/1.5.17 (2007-11-01)

[note: your mail was mangled html, I'm trying to extract the answer]

On Fri, Mar 21, 2025 at 10:49:34AM +0800, 邵培杰 wrote:
> Sure. But on the target side, it's a bit different.
> All socket operations are done in the workqueue with domain kernel_t,
> the kernel_t can access other labels, so I think there's no issue.

Indeed.

> By
> the way, switching to sock_create_kern() could skip selinux avc
> permission check and might give a very small performance boost.

It also helps to avoid copy and paste bugs..

> I'll send an optimization patch later.

Thanks!

