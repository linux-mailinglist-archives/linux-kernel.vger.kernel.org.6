Return-Path: <linux-kernel+bounces-360768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46391999F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E011C2218C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F0F20B218;
	Fri, 11 Oct 2024 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LIGxc7DE"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEDC20A5D3;
	Fri, 11 Oct 2024 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636654; cv=none; b=cXAX8Bkrz9sGY/O5NlT1pA406MadPCuDVNmdlnoJZaZZGvr9eWLJlnwWoky04UY5BMgdVVuglO2bU+QinhmyFUYi9cUmzW6sOgS4+YuIibtPKljHSCsYQ0/WyLzZV6l1nkEm37OZ3oo93U5xwNrKcURetmu962zEDyNMGVWZA/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636654; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6t27KSsnrybyJixSGEzIWknPItbFYhgb1tf0mBWTv+jDgSHRiDTkqtA5jbrQI0eVROZg/BmFczAMfZ6fCfuH3AR8xl7O0A1g+4LtvAb8gHz3K88wkVTVUDZgd6HMdyl0hyVwfFOcnNZ7gq0cICFosjqn2EPaYBvjBUh+xMjkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LIGxc7DE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=LIGxc7DEbWTRPIy7xRgUuR2FfS
	/PhyQs77EAPi2l5TSjvGFlKlf7AjKSXnAsUG1YY1Lk2BUddJ5VfSKJq40SmfyDuHJCEBW1m2J9B7a
	iWtnATttRtFChAIj5mVzaxG3iIgqedIF3V9sdX4we7h1ZXZQvkyd5hnaYVLrvCWVc/neFPdWVRSaR
	yqP6Nl52eOxAtPvXQL1K0UjtBDyKAiX1jlh2WwMNKaTRQ5sNJfcRTzd4nnjViJeQKQY/Yu0gyKZxa
	GmT2iZVXeZ9oSGJUfH+NoyiZHBRuHKo58OdrDK1Cz75EJ/8ff/a/ALFFKYS2xTpQrAHJl4pgtthIP
	LgkcOUMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szBMK-0000000Fjf8-0GWf;
	Fri, 11 Oct 2024 08:50:52 +0000
Date: Fri, 11 Oct 2024 01:50:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: cem@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2] xfs_logprint: Fix super block buffer interpretation
 issue
Message-ID: <Zwjm7KgmRHym6kbv@infradead.org>
References: <20241011075253.2369053-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011075253.2369053-1-chizhiling@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

