Return-Path: <linux-kernel+bounces-337584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF4984BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8101F245FC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D43613A884;
	Tue, 24 Sep 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m0iv3Lbw"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979013213A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727208839; cv=none; b=A1pMWIqglwKKgC771DYOuVAlfzeJwTA8zIsauocnVWvsudJMt+txRr1Rxh5H4gHsRUL21iOC0mvQbQfaa+Wz8Wd+6T7ALNzAzUiSNoKyc69HZTXrwjI50TmDUn3lfLIWHfeP1XZ3coFwzv60KaJPHsNGgZ4qbqLa4QZBk0+XNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727208839; c=relaxed/simple;
	bh=UK9L/prHXtK14kfr4R22UC6fhwv/P4BB5U+Jj5x7Z7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpzLjM8igtZaQ27WJgCPJm8CIn4dALizG7a0VHCYlYsjXpnpFaM6PzVgarHo658o1jrQXUH9qQbvtYth/TDRiR0v4TrNEwDZvgkfoixqF3jZuphuuqbrIcl/P26WJF9FOiAXLzcMmBipbTOoMzWSEx4gZAm9hTIMvTfSOG6KnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m0iv3Lbw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0ZDIZphHaZQWBEelz0NI1LbACsabpfkNya5R+pJ2qNA=; b=m0iv3LbwZ39btACpe8yrEQy4hM
	bbraWzShHNPMvB9jlsjdYgCKFrZ+3XPtPUKDBtqXkfyTRzcOYnv99R2b3trFfXxbQN1N/yubo2Z6c
	gCJ9QXAzPAxGr9XX+MpPn1+dbhWSXFvTvZgvdxNNZ5i4bmdnQIcLYMouO45MeaIiQB7EqKN0mnhns
	VR3H1Q1+05EgaFW+2b7gOfDPqhYUuF77XJSWRnCVy8TBr1i7ty7NcYZg0ra7Ys+CVTyoCPPgIk2Hb
	BtY+sg5C6Xh2MT2xJlwPmBccxTGwAV65Ym1djNgqcSAatJSi36f/FGFhA1K7YJWpaSxHE86s++bKX
	dQn+F0Zw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stBuy-0000000FDtT-2k0f;
	Tue, 24 Sep 2024 20:13:52 +0000
Date: Tue, 24 Sep 2024 21:13:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mm: refactor mm_access() to not return NULL
Message-ID: <20240924201352.GF3550746@ZenIV>
References: <20240924201023.193135-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924201023.193135-1-lorenzo.stoakes@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 24, 2024 at 09:10:23PM +0100, Lorenzo Stoakes wrote:
> +	if (IS_ERR(mm))
> +		return PTR_ERR(mm) == -ESRCH ? NULL : mm;

	Pet peeve: what's wrong with mm == ERR_PTR(-ESRCH)?

