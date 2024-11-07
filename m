Return-Path: <linux-kernel+bounces-399859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0890B9C0560
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F99DB23011
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED772076A5;
	Thu,  7 Nov 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="3BicXjfd"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200B91F4FA7;
	Thu,  7 Nov 2024 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981359; cv=none; b=UT9bjolDO5C4jmmFOk910yCnCoj9BcAUg2rc4UUqg2EWSriX+wTORBN6zh1HJ+WUe7AkXLEcRwxfSr0/9Dmhk8Q27KL/xdQdGyBEjOii1hAHxwPav8rpCBSAzZBhvt6M0uqIlnFJncYTxhVVpcEZVE8TbPetUaWxERqCsrDOsbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981359; c=relaxed/simple;
	bh=/9drwAQZ4B1kcyQrYubQ4oKjiSBhi8i9iVpWKQI/Meo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSqPDQkrgQsygc9QsVDJWGzT8IOPSNe/kkGon8+yf4MbWOUjxedpl5kVeLpEyCISqZF+gr3RsBSb7SFPjSoeMEVrKcmZoWCcJuQ9czR/0arMzlWSk67HtbzYuZNh8nlGWwHjvOAyIFhEvB67T/FBgSjSnsWcKehJeYrmGNlv7p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=3BicXjfd; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6E7D814C1E1;
	Thu,  7 Nov 2024 13:09:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1730981348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1dSQjqgROr/M7ts/dndMf6m4fRKg6+zb+E0VD6A/Lc=;
	b=3BicXjfdxow0IfvtXWRetgBjceifSidGAcB2toFEDdSsh2WF7vlkZLx2FRlZwBMcax8ZDl
	8MAuwPjTDpfBK0zTttYeMSs2U8v84Z1OuRGBkIGz0YTHW+zd7C7+m/kr+PGl+JKAzRqyni
	Uus3wvGJTP9LbBvddm2ROLbhEKVeKgX2DDW3MIsFaR72VfuMVpZ3F05OaJfRYLYQRCnalB
	ylfcuysYGqseaKhf0RXrWiP2pK2XcSDgtwWA1B0JyWWaDVxxxXQoNNS+jZyQtAgBnqouiU
	JIbVO82TufStYVumK56D/AQ0ufuCnf1FPPVPRDJ2ZOe3HCmfnmJpRrMtMnPp3g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 362e5ccb;
	Thu, 7 Nov 2024 12:09:04 +0000 (UTC)
Date: Thu, 7 Nov 2024 21:08:49 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Colin Ian King <colin.i.king@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] fs/9p: replace functions
 v9fs_cache_{register|unregister} with direct calls
Message-ID: <Zyyt0XUv0Ypl56qI@codewreck.org>
References: <20241107095756.10261-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107095756.10261-1-colin.i.king@gmail.com>

Colin Ian King wrote on Thu, Nov 07, 2024 at 09:57:56AM +0000:
> The helper functions v9fs_cache_register and v9fs_cache_unregister are
> trivial helper functions that don't offer any extra functionality and
> are unncessary. Replace them with direct calls to v9fs_init_inode_cache
> and v9fs_destroy_inode_cache respectively to simplify the code.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks!

Acked-by: Dominique Martinet <asmadeus@codewreck.org>


@Dan, I don't have anything queued up 9p-wise so if you want to take it
through the janitor tree it'll probably get in faster; otherwise (if
you'd rather I take it or no reply in a while) I'll pick it up when
other patches come in.

-- 
Dominique

