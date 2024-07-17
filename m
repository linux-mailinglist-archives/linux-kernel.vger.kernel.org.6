Return-Path: <linux-kernel+bounces-254574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 189479334DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C4EB21130
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7FB138C;
	Wed, 17 Jul 2024 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/wXjLzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4646EC5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177628; cv=none; b=pfx/jrEifSq5zkDEEsHIx7l+VnEmRxQIVsCMqhRuJqtd/HG6HmNK4XkgOUyKPmKjqlZH3lc7O7AF7hKZYd7Xc1tPXhn9jyFZ7HSEn2IwfIhGbTxdzCzWqz8a31SIurKvSvs6X9NtZG3zanYCfy8J0K71bMSfmG1lJA6aHUePDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177628; c=relaxed/simple;
	bh=NtvslSoeOcdyt9E2tMWfN3uP5NFeqWYwbzi5YQv7twI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8ERsKM36nRVdxZP/PBLu7r2VB4ZZ2/YZmQYwKL6T6U5YVLjG/G2jwXNtY1QCqK0EDOB/F6WeGxmVBxQP1jitOfizzzbPRmQ/qOLIRdBUzxKJSpAj9x+WaFLAXVx1c2o3EzePD/+1AOYBLnlwSDRYi+36WEQDFLxjAa8ls62qE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/wXjLzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F314BC116B1;
	Wed, 17 Jul 2024 00:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721177628;
	bh=NtvslSoeOcdyt9E2tMWfN3uP5NFeqWYwbzi5YQv7twI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/wXjLzpMM7BPOn8qzk8O0Je0T9ax9+77ZO0jQ2iNOPZI2aJ1Ivsst2RRpe1qWDiy
	 UYSh0B29DMX0HDI83HONEsIzcyh7oALXssfH9lHCZ7eUcW+G1BP0z/8IrwL9ij4Vfo
	 1dCiGB/g+IP1ZsmlFB9OoILIQB5lrk2yriih7E5Yqc57SKDvhuEYWkniu/gX8zvG31
	 ucLBXs02h5JM5r4cjkcu4F+x1An6fLgTLu9EPXmheRgbNxiaIxkQPJB4lHASDEWzLu
	 tdgNSPrRUA77iUJE3pov5YUxVglehLI4Yi061X/kIa3Rd9pLDK4FD5n9rmkY28eASS
	 zdyQRgxaZwlgg==
Date: Tue, 16 Jul 2024 17:53:46 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Crash when booting UML after
 e3c92e81711d14b46c3121d36bc8e152cb843923
Message-ID: <20240717005346.GA516623@thelio-3990X>
References: <20240716143644.GA1827132@thelio-3990X>
 <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
 <CAHk-=whVPmZm=rMBf1qkJzfZeBx4Es15_w7VnPK1wEs=XYDUgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whVPmZm=rMBf1qkJzfZeBx4Es15_w7VnPK1wEs=XYDUgg@mail.gmail.com>

On Tue, Jul 16, 2024 at 05:41:14PM -0700, Linus Torvalds wrote:
> On Tue, 16 Jul 2024 at 16:18, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm... Does this simple (whitespace-damaged) patch fix it for you?
> 
> I verified that it seemed to generate the right (generic) code, so
> I've committed this fix. I didn't actually run your test-case, but it
> looks ObviouslyCorrect(tm).

Can confirm. I tried it initially and it did not seem to work but I
think I may have been using the wrong object folder or something. I can
confirm that the tree boots at commit 0434dbe32053 ("Merge tag
'linux_kselftest-next-6.11-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest").

Cheers,
Nathan

