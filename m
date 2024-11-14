Return-Path: <linux-kernel+bounces-410026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886939C95B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB16CB22963
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C601B1D61;
	Thu, 14 Nov 2024 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Au6fWA35"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834DD1AF0DD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625317; cv=none; b=FQLYPGV9QJgybZhccaWjOVHOPz0gzc/PKgb4uFsISBwv0dGrM9by1jsMJP+XIH0EAyDfiWJeGLmwxnH22U2kPCZ4SAOYa6AaooK9tr4rapOXnKQi47uHh5FiSaFb7JfjJ0LDOF8ajRPVYPLsBvVZy6st+fpFbuZ6N7S7ekUMbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625317; c=relaxed/simple;
	bh=MK2DhBLnwbG5e5ZmBE1yNvN+Cf6QzUUoBav5TZVEAPc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UX5imw2qmjG1kjiXxjyeEkMGDhLiWWNmDdywHPSmBX0poc2++ygfBl82InCt9Z875c673HlV/U5H9QShNZqL6aQtkeCuyPSx2XT+6opUDXYOKciF1Sz9sNcUoNkHp46ghp3CwZ85Lk3h8ISpoaKAp6xlFaL+oOqZDo9UhgyDozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Au6fWA35; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731625313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CO7x25wgzcGlKTf0gfOze2m5krBMIGAGOp6OTv9hDaA=;
	b=Au6fWA35pD3FvvLpQaWGqq+FNgVJUAHQR4c3DtYegOTqI+CHx2z7Bvew4lFNAk7gi5lWMG
	pQ+ZUrj4Fd+q8oEElPClgU3XFEn26rq5LqaaC0hNeGCXnM8Y9roKguQS0F8rooRvLvRfnL
	oo9U/x5FeeuyCqSR++/CzIzrhbRiq5Y=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] ext4: Annotate struct fname with __counted_by()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <173159220757.521904.13348650494002839092.b4-ty@mit.edu>
Date: Fri, 15 Nov 2024 00:01:39 +0100
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <67B144E1-F6E4-402F-B6E7-95159815542C@linux.dev>
References: <20241105101813.10864-2-thorsten.blum@linux.dev>
 <173159220757.521904.13348650494002839092.b4-ty@mit.edu>
To: Theodore Ts'o <tytso@mit.edu>
X-Migadu-Flow: FLOW_OUT

On 14. Nov 2024, at 14:53, Theodore Ts'o wrote:
> By the way, in general, you don't need to resend patches unless you
> need to rebase them to fix patch conflicts; I track requested patches
> using patchwork, and I tend to process and review patches in batches.
> 
> If you are concerned that I might have missed a patch, feel free to
> reply to the original patch with a ping.  I'll see it in my inbox, and
> even if it had gotten lost in my inbox, I can find the original patch
> using lore.kernel.org or patchwork.

Thanks for letting me know.

Best regards,
Thorsten


