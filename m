Return-Path: <linux-kernel+bounces-369302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E19A1B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2A1B230EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3371C2438;
	Thu, 17 Oct 2024 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AknQCQRI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A761C1AC2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149444; cv=none; b=Ab80COohky9KRykoy6MKykh9JlLMutNOcIj9Lk8HUvy0C4KQn9KC8XGfxrUMR53DnXjMhL9i5j6WPtSanzNv0AHZnNhifeMwb2MMv54BZwsBpR4TxsH9C25Hcr+LRVgkDPcsCIW45yH8Cp0flf1w+II3SQUeWrjfN1rBNI1obg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149444; c=relaxed/simple;
	bh=fJTPFlMzrtCjECNIK7GmquHB5DSfo3m4dpTM1clfOUc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sV7RqcTSh+gWUzV+adu3VINNeHa3hf5dZP4rzzIBlvGeTVdrZXzCn0umo07O8FLDEjT8nl/mOeIxl7uUUl++HxF7KpPgaitwWQRBdzyTe8TZyDHML6cUaW7WMvTIEuXGGZdRSAuyvykrHFSUX7Bi+uKNRMseRQNtN+t12C0XkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AknQCQRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1299C4CEC3;
	Thu, 17 Oct 2024 07:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729149444;
	bh=fJTPFlMzrtCjECNIK7GmquHB5DSfo3m4dpTM1clfOUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AknQCQRIAyz7P3Eg6zgi6roOE6osqwY5leODvdR2Wfbt2++942Z9SiSugW+elnJDq
	 y36VF1IDSbawVfwqMPkG14JDPwi+G2S/S3kIXEJEmOkg8taG1FL65tDEPkqKpKKmye
	 cEiFzZjFYJM8gBJbbeGuuChB91cwx0NnbLlJVHVk=
Date: Thu, 17 Oct 2024 00:17:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox
 <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Bert Karwatzki <spasswolf@web.de>, Mikhail
 Gavrilov <mikhail.v.gavrilov@gmail.com>, maple-tree@lists.infradead.org
Subject: Re: [PATCH hotfix 6.12 v3 0/2] maple_tree: correct tree corruption
 on spanning store
Message-Id: <20241017001723.82bdd8c48e5be32c4fc70f5d@linux-foundation.org>
In-Reply-To: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
References: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Oct 2024 16:28:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Please note - I am intentionally holding off on cc'ing stable until we've
> had a chance to be satisfied the series has stabilised in 6.12 as this is a
> highly subtle change.

What's the status here?  Should I upstream this?  With cc:stable?

