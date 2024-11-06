Return-Path: <linux-kernel+bounces-399018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258CE9BF983
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5508E1C21384
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F4020D501;
	Wed,  6 Nov 2024 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="W5t4Je9R"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DACB1DCB2B;
	Wed,  6 Nov 2024 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730933711; cv=none; b=BxQ7xNIeIuJRLUEcYhR0R4MZwGGS3BCypW3hu3A39/mxxpnjMz5uIxk1X/ujaxb2Qc7nBn/z5wraFXUk9radMhVF/GtqnjfhFcLO0aTRYa8fZklzzzpTh6xU8pdC7NPfSDgNFEf2RCENyhuIpETTmLc5GLiIcK6yK9WTb/Am/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730933711; c=relaxed/simple;
	bh=eAucZxAiDBMf47Qa+Wjc8Ga0Jsw0vkPiMm/77Uq8Prc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecw04feqCOjE1oVeJahIUg+78AHv0WsZXA5JQPfs2AhzVTKi+ve1nSDyyXOqmChUaWiJSAgVmEvDcg75ypEkgQyX/TR7vPPdkFWd7iFIUDNIKwSPkvGpAIUaB/3ZtlVdYCw1QopYCjrsEHMRWrXBkfrT29rKNPAjxfo9b1MNS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=W5t4Je9R; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 25DC614C1E1;
	Wed,  6 Nov 2024 23:55:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1730933707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nz16Qv+hGIj3IKOx0Q0S5uDQV5UTe5bS9QCsJFvhS1s=;
	b=W5t4Je9RYMifcG3158JnuDYqzcPM/8Bl3Wv4wBd6AMNBunrBpbQgaulBDYZxz1BPKgdbA1
	n4kRb34ym08opo6B8BCE/nvvpP+p+okLduncmahpdYUBHThH6dKciJd2HJH11FAP5PwLea
	H/A7oXDhtk7pYMJtRc7LQdLLlhKuDK0O+Kp+C3/iP/+YRpluF36IWNsHrhltK2fL+kjiHI
	Ye/TeIGQbmyPH3nQCXTGAGHlpxRMJWnHtPzri53LOlN0lRWBQTNofblM5GollqePwj3CYD
	E64VM3h9XHR4WRG1wfjIx81X2K/8hTVMyZFC0GiP4S0jwDLsyMxsYLfYpE5MqQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 75915786;
	Wed, 6 Nov 2024 22:55:03 +0000 (UTC)
Date: Thu, 7 Nov 2024 07:54:48 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs/9p: remove redundant variable ret
Message-ID: <ZyvzuHBSyfI63CT0@codewreck.org>
References: <20241106152209.1626630-1-colin.i.king@gmail.com>
 <23a44a2f-2a99-47a7-a446-d96b5adf62ec@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23a44a2f-2a99-47a7-a446-d96b5adf62ec@suswa.mountain>

Dan Carpenter wrote on Thu, Nov 07, 2024 at 12:45:33AM +0300:
> On Wed, Nov 06, 2024 at 03:22:09PM +0000, Colin Ian King wrote:
> > The assignments and return checks on ret are redundant. Clean up
> > the code by just returning the return value from the call to
> > v9fs_init_inode_cache.
> [...]
> 
> Better to delete the whole function and call v9fs_init_inode_cache()
> directly.

Makes sense, and if we go there delete v9fs_cache_unregister as well so
the init/destroy pair properly; that also is a single function call.

Thanks!
-- 
Dominique Martinet | Asmadeus

