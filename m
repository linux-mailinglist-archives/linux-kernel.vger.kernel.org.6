Return-Path: <linux-kernel+bounces-436198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8552E9E8263
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C4A1883E62
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9667A1552FA;
	Sat,  7 Dec 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qsU39YCb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23C28F5
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733608521; cv=none; b=sd8iTgsz3Ja8YMVr4ytr92n8Fuw24lr+DIrTNIEOUscoC4lTEzasDhE/W0tSvcuI/Gsg4k1+PUX/XqXlq2vZtmpthKNLwbCLYEjDP2Wz3wCY+RFNcgYrKvNDQ7PmTrXgW8XhZpbIWMbY186N6lClodi/HUj1lV1Jvg5np43zDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733608521; c=relaxed/simple;
	bh=/bqufkEBKU988iE4C9wT3S+MxNg6iN3+7Jk9c7jwPtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq5h1sKTZN/8wuWU1WV21KORj1ORKQZ60c4jDmkAWlz6CIcbSELaRpE0FpcjzWlpjuSU2CSh4qSSNLQOSZuC9N0J/xCfVisoT7FIt4bsK3Bo+9kUdemQV5DX+/AImY5ExHPYhKTFrRhhLUd9j7PqCNYCs9GMetcsh6Y/VDwRjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qsU39YCb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/bqufkEBKU988iE4C9wT3S+MxNg6iN3+7Jk9c7jwPtg=; b=qsU39YCb9QQtWNhLKc9LiZrWhV
	EO1HZ4AWVhW3fAPvqcHXce41vT27VcE5pBFtBE5SL5QbEl1kvsKvhWj439I8v6Dn8lqH2zYoavLc6
	vClA7IT9s34ByYmlS1YYIda6AjUhelk5dDP3Esn6Ikyzpm1eYRBZwHitg+sM+GiFT+yLY9TtZc4fO
	IwgFz1kbZ3kIBDh8bGTzTaao0z92YaTOjtkAxLtLXNPid4jV2j+Zi4wd+yY+mvN7H4dCjXEHAuAoZ
	NzwBK5LzVW3pkc/vX4lei0vdk4Ovy84h5LizCA3qp5BdJORR7FzyJvTlKY81VJ+upTnlXET4xn/6i
	+scRy3sw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tK2lc-0000000GXK8-06Gx;
	Sat, 07 Dec 2024 21:55:12 +0000
Date: Sat, 7 Dec 2024 21:55:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: SeongJae Park <sj@kernel.org>
Cc: Junjie Fu <fujunjie1@qq.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	mhocko@suse.com, gourry@gourry.net
Subject: Re: [PATCH] mempolicy.h: Remove unnecessary header file inclusions
Message-ID: <Z1TEP6Qzl5H11vpV@casper.infradead.org>
References: <tencent_08B979048FE091821B290B18AE97E70DC507@qq.com>
 <20241207195341.279560-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207195341.279560-1-sj@kernel.org>

On Sat, Dec 07, 2024 at 11:53:41AM -0800, SeongJae Park wrote:
> I noticed kunit UM build errors as below on mm-unstable, and git bisect points
> this patch.

this is correct, and should be squashed into the previous patch as a
fixup.

