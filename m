Return-Path: <linux-kernel+bounces-376237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8669AA1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192D71F232B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD46419D060;
	Tue, 22 Oct 2024 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oBMsbHcY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F250E19D89B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599247; cv=none; b=RF0hcNVwlpsgsR2w32AMkeEruoXc6GXX8Xq0QvtKaro9nWMcajHwRlZEu+1gLiQiFlq37TGJiMF442y7CVG6Q+dSgosuKxwXQOTWvcWvi0l0xY3MYidgljubCl1UuDjxF6H76qUefrochY0tOpsM/a2eLvHfnVJzq0Xxh1psfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599247; c=relaxed/simple;
	bh=xQV70bRXgVvjqjpl6+QehYXDW7xRJQVkFG8PtUOT3jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIyBgQaN1mZ+MDww9wr9JFNjObyM/XetMHrxEkqXlpJ0GGuNdSZA51/KFAhs+1lzgy4jk5OO9vQO6QGaSEtDL1awsW05gLlT44868cqc4sCq+KQpAzyfH5G60cFZ+e6Kl+WYbbZs2ndKNuqEyN4hyVl6qPwPniuQMealWQJrRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oBMsbHcY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mi3TrYlXX9OD5PlpFmztGdMGUKvouQ7YS5GcWdqkoJo=; b=oBMsbHcYqbNGufQtBZXiU3gBmd
	48VMgriW2+czbR44uj0CT8fbbZIwsRPt9ARXjZYpWZYrPEHhNXJMOEnEqlhJq6vGzX1OAdgSR/q2O
	1xOaLo2ng+y/TXqk+HZuzasd0lViaSX2v+Qi/lDc3iGU5kx1OTJY0DvBufhGHjPRF8p7OzXmXgEpI
	taWbvXJnBeZBX9uoDN7DLbcYPmTfXkFMgHeLsLIBLBaBaGvkGsKcrM9up7AnA/ga7mUTPgwrnfjX+
	O6gMXxtNYE88A13Bx4YovTDuQgCRpauoPRcNFWA8KIcX1bYQ7xw/8BXR9k+iTrZSmEj5meVkEtVL5
	/+1blGKA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Dlv-00000001btc-3qWw;
	Tue, 22 Oct 2024 12:13:59 +0000
Date: Tue, 22 Oct 2024 13:13:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: guohui.study@gmail.com, brauner@kernel.org, jack@suse.cz,
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	lizhi.xu@windriver.com, shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: Fix null-ptr-deref in write_special_inodes
Message-ID: <ZxeXBwLCsIwNYmlP@casper.infradead.org>
References: <CAHOo4gKf2mjPX8oAxCBUc74=+OToMdu6pe6iALGCOmXjToFaKw@mail.gmail.com>
 <tencent_7C86DFB364837BA979A3B0A44CF768577205@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7C86DFB364837BA979A3B0A44CF768577205@qq.com>

On Tue, Oct 15, 2024 at 12:50:05PM +0800, Edward Adam Davis wrote:
> There is a race condition when accessing ipimap and ipbmap.
> 
>         CPU1                              CPU2
> 	====                              ====
> 	jfs_umount
> 	sbi->ipimap = NULL;               lmLogSync

how are we unmounting the filesystem while still writing to it?

