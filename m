Return-Path: <linux-kernel+bounces-555230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D71A5A72D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E353917538F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B9F1E8350;
	Mon, 10 Mar 2025 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="r0VLP32N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864B1E5B9D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645676; cv=none; b=tTRakemksmL1flZ1d7yhEu21BrVfNrGxfXUP2sSgCgev68SL5CRAAydW6pzRNtSMh0vxoiD8j1J6liADBCCKLrox8O1AFGt+OCUspZB6AyEa0+U51KhOWcsxdBd/rTFl2VHu24gCFrn+yGj8dbaUbaP/7sgP0R6trD5hQUSgCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645676; c=relaxed/simple;
	bh=otSsI19SozxcLaBjOGdeuxMvAtux8FfZ54syeGCQe90=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b98oj96p3TRBWfr1aOh/RiubxSVt5bSKQTzjFoZN+BHaaUInIKsJ+6DgUbkFUJbjQUHf1foNp31iZByIysxHd+SgNJvsF21e+3U0s5vCzzeZ6g7SQVxQpVSmozA5n1sUpsoP/4CccHq2KfDOzv8FCvwgHAnpjYaPwpiBrX/t+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=r0VLP32N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E64C4CEE5;
	Mon, 10 Mar 2025 22:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741645676;
	bh=otSsI19SozxcLaBjOGdeuxMvAtux8FfZ54syeGCQe90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r0VLP32N3uPAK4XEiEq34QUQIaHg9VpA9myMCxaGJOLXxgNoZV3sJ3eGnuB/ktlhR
	 01N3/cBSZDw2dk+nrnIcT0s0r45+E/RZldqllPLy3h43ApaQ6tJwbfWVAkQZkbzdEQ
	 ZY9UhB9HP9Ah8BYa934tTJsvQMmixexQ6+CoT4b8=
Date: Mon, 10 Mar 2025 15:27:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org,
 liam.howlett@oracle.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v3 5/6] maple_tree: add sufficient height
Message-Id: <20250310152755.fe5747bf67a79efcaac3499b@linux-foundation.org>
In-Reply-To: <b9175f2c-a28f-4f21-8879-fea7bbfdc5a3@oracle.com>
References: <20250227204823.758784-1-sidhartha.kumar@oracle.com>
	<20250227204823.758784-6-sidhartha.kumar@oracle.com>
	<your-ad-here.call-01741630424-ext-7048@work.hours>
	<b9175f2c-a28f-4f21-8879-fea7bbfdc5a3@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 17:01:28 -0400 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> Andrew, could you revert this 
> series from mm-unstable as I work on fixing this?

I have done so, thanks.

