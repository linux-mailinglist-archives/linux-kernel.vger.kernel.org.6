Return-Path: <linux-kernel+bounces-326893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A6976E33
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAE8283A52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F8E1AC89B;
	Thu, 12 Sep 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jmKeTM0Y"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491844C8F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156358; cv=none; b=Vi+DIeX1cabRr282o9KuJls+K4QouwYjzMSM+oPb4ENVYMuycN+dLo7zzzzt/80AcrRo2RxK+sQ4QgUX+KqJTSKX66ki77dl8Qr8ZwqeZ9PieGSQDtHzpvF4RYQSjkdmLA1Hx9TwnRpwoXkFtr+b2+6+5obYGMJMhLIedyVV/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156358; c=relaxed/simple;
	bh=vupLqJtfOO3BNVxBIISs2OERCXIfsKlxgtcdJl4Vlv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=excmYTFGf2Euda+wOv8hr/YQx+M7fVoR4ErbWTRfoB9ODG2J4MlJ5ORoFDojRRPQw/wMplAkmWZU0lkOOqKdzj2S0I7nMUfQ0cPhAiIB7s5oXVmtvyer/9WkN4wsegpmJq7ixXS4r04pLNoRoD96MrhalaOweRqcde27E5NaBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jmKeTM0Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vupLqJtfOO3BNVxBIISs2OERCXIfsKlxgtcdJl4Vlv0=; b=jmKeTM0Yxj/CqrGPcgGasN371Y
	svzGfbc684U0ZrKtiy+HCXu3Z3/+QcJvmpDSM3CRAPEzEldD5uXRQ1IZF+a9vhpcOL4ymOvJMI8sW
	bWTKNSbXqH7xrbN3OMKvcEaxn4N+O3k3fGxz694OdJVADtFNWyO6bEASg4aqtQNhKER/9e0cxv6Iz
	my5aW4s5quLW8t0ruceYsI8nu+wkYiPRS4Fz8nLK2X2FbF0PWu0UUmf3TqZCLXHqAS7oaPRtuleEL
	QNgsp2rxpe/BYsv8R7a8NhAknNLDsSPU2B0ZjwXMO0STWP/3+R7Cwg1ndoytshiDop6mug4Xtksoq
	eriLNZTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1som7W-0000000Dcks-1zwD;
	Thu, 12 Sep 2024 15:52:34 +0000
Date: Thu, 12 Sep 2024 08:52:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] f2fs: fix to don't set SB_RDONLY in
 f2fs_handle_critical_error()
Message-ID: <ZuMOQg-0drvUCfOc@infradead.org>
References: <20240910030713.3716318-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910030713.3716318-1-chao@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Another problem is that it sets SB_RDONLY instead of an internal
shutdown flag. But that can be solved later.


