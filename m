Return-Path: <linux-kernel+bounces-377406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077C79ABE63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A78284FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B801474A4;
	Wed, 23 Oct 2024 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w1E5TLJU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864813AA31;
	Wed, 23 Oct 2024 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663648; cv=none; b=qTxcBl5vFNKymrACSUNKXJNfTyigHi7+EzC53MHuI0TejBWXLz/WSyhDdzQcbOGv2EK1dkyAtcXwD7Oa2/582debnY2/xKDbAicTjf53QH9rRmG9YB5BqZ4vG6xnnBoXw3LkVspc8oPSA0noz1jrPERy2I3G/hIBODkcwQV93rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663648; c=relaxed/simple;
	bh=PtLcYvKP0GfRAQi53/bCbk06mlyUQ8B3NMXd+33V9iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKsXqFicgZaelKfezdj3JqNJklJmhbcuJYn534FsjNqApsZ0ZyiaZR86GD0YT7tB+Xu0s4hBtwR2EChXPlNLLuLNF6XnJ4RUZj4HtBU+ZY4e7xSOtdmTr9KyQ3fOpSP6Qs+wHDJ2KZdMJwP44B6PREC1qXxU/ZqdT3zCNIsZn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w1E5TLJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967BEC4CEC7;
	Wed, 23 Oct 2024 06:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729663648;
	bh=PtLcYvKP0GfRAQi53/bCbk06mlyUQ8B3NMXd+33V9iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w1E5TLJUKyJFbVBjfd1b6eMRKeTrezyKji5SgY9obDN0FbWd68KrH15291SCYw4qh
	 vlewGVIzG7YVbFDTbQ8YjZPsABaeiJ2EnpTNGOONIN6YQ66bB6IE6AOHQ3ub1sUq6Z
	 qxJM9PFWWp5WFoZVdhDOM8iA62fjjyn1JlNk7M3c=
Date: Wed, 23 Oct 2024 08:07:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	yangerkun <yangerkun@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>,
	"zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
	chengzhihao1@huawei.com, zhangerying <zhangerying@huawei.com>
Subject: Re: CVE-2024-47725: dm-verity: restart or panic on an I/O error
Message-ID: <2024102352-stable-eats-61b2@gregkh>
References: <2024102104-CVE-2024-47725-f698@gregkh>
 <ba190e58-634a-247d-1751-b5ed7dd45982@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba190e58-634a-247d-1751-b5ed7dd45982@huawei.com>

On Wed, Oct 23, 2024 at 09:37:26AM +0800, Li Lingfeng wrote:
> Hi
> 
> I noticed that the fix patch for this CVE has been reverted by commit
> 462763212dd7("Revert: "dm-verity: restart or panic on an I/O error"").
> So should this CVE also be rejected?

Yes it should, as the revert happened in the same releases.  I'll go do
that now, thanks for the review!

greg k-h

