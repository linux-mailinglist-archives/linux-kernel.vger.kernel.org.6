Return-Path: <linux-kernel+bounces-288081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F1D953386
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4CDAB20CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364061A705B;
	Thu, 15 Aug 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ECYrY2g+"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DE18D64F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731371; cv=none; b=IiLHYj2aqhgQV6k0xuwfovRS/i9Z8+myWe7oAg2kXu2ovya0wMsCKkFuqGt9Zv6PPs/n4kZuksY/fQnfmSFmO8fS+H/84JUy8R7gPvz4cK8CWO2cdzTiKbLPi0CbNAOxyb9QxpImEmyZSoq+M9kIrQY2y2MyNurJ+O/x9znoZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731371; c=relaxed/simple;
	bh=CBbGXwKpWfZtOY3lnfYDdW3hW5Y5Qg6Ws+FAdH/xFo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE1ncxJLi9YiLipcLqk+Dgo5LI1pHe1fMjzrvcE12vidgs16E0BJ+OAn7SP4ZQNLongcuo5jHWUcxLSmwJEr/UiJNrWIN870KjY4leJNXKU9ckmnVAfwdmHfd4YnoRIMdIMbdzsnkeap1cv2cKuu/RmFyGaYMygTrQj28026FDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ECYrY2g+; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 Aug 2024 10:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723731367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2tYSK8p06bsoRJhHkMdpM1MeiXSBmcTwCM5x9J+HYkw=;
	b=ECYrY2g+yuAy3gfdijn+s+i2cA/mvWkyyAVM1mDye+m3PxD2pkCcsOj2r7sN4sZTejwn6V
	VmB5dC4h6ImwRZ0Qmcx2y31vNJ8oiPMH7BJ7GoLGU/1AiINnMEjoZol+sBiz1oVfms9NUM
	e5hXaBJYVX9Cpm1i1Bz+Vee3D3JNXDA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Li Zetao <lizetao1@huawei.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] bcachefs: support iopoll method
Message-ID: <rqt2hvqaukziy5pzg3v7conihbjwa2icej23qbay3zm5b5kn5s@cvccny7kpz7p>
References: <20240815142034.1561661-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815142034.1561661-1-lizetao1@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 15, 2024 at 10:20:34PM GMT, Li Zetao wrote:
> When bcachefs uses io_uring, implement the iopoll method to support
> IORING_SETUP_IOPOLL.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

tested?

