Return-Path: <linux-kernel+bounces-371499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880579A3BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBC41F212DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBC5201101;
	Fri, 18 Oct 2024 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JUh3YSY0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336E18628F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248493; cv=none; b=dhahIQTcM4HnTjli21M+xnC3XKcrPBWN+pSr/7n41Lm5j4SSbEDOuOXvFJUrIz9utiEZaQstvC4U9f/ICTS6anoltwerBvupi6bFOrZXz38dBOcG+MgfVJCDh2AGejjPvfRw6LDj21JJ8izIl+UeKwyEDZZOZnelo0q996vMTxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248493; c=relaxed/simple;
	bh=5iBMk7nLlOS9FBKREcYlmQh+Knq3ZSK4FVQraeidYD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giEvoJ9wY2H2HOk3dIvJvC761z3q7RtctzWKo2WalWrMtV1r8aldXo8TmiI+ltVOomyCwboCE+TFQ+bRAtbcMl1Vq4gZPj0NioOLp5Qg/atlRZUn7eA84CQtZCoUp7kfL+6vfsAzC6PQ6TG1VT2+tiXbJ1v7R8k0+Okfvmuk0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JUh3YSY0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qQgpA8Kgm0TfWClwdNgyl3HOq4Bc93iATT5dTCcpRf8=; b=JUh3YSY0rc8GHtSQmwhNU8aLHE
	uuNRtU9hoEwnMxbwnPucJOj7cpVMj5JRlI16WrRKfiIHLLUGfeR1XtfuCWaxDgB1rEExrHP0hZoZm
	wKP1iMOXw3Ef0Gd1WMf0T5wi3rbQmmPlI61eTEW6in3Q1TeO8XxiPB9xqhAWOgJuob79mtIrEr6Cg
	6imx2+lfeSR/83LLVPVGPcD3xHovoDmPDgQnwICFAlsxfVWxMxTXX+bX29X5MomQCId9Nei1RiQjM
	DbZeF2WjThI8ru9OlYobEUOnTr5f8TyWQP2WqtQBbHzmzDXHouivid6GK6YLYjtE2IeJp9E1qig5Q
	22AducFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1kWd-0000000D0Yt-3D5S;
	Fri, 18 Oct 2024 10:48:07 +0000
Date: Fri, 18 Oct 2024 11:48:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
	ying.huang@intel.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: Remove redundant condition for THP folio
Message-ID: <ZxI85z2O0qV1Coat@casper.infradead.org>
References: <20241018094151.3458-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018094151.3458-1-dev.jain@arm.com>

On Fri, Oct 18, 2024 at 03:11:51PM +0530, Dev Jain wrote:
> folio_test_pmd_mappable() implies folio_test_large(), therefore,
> simplify the expression for is_thp.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

