Return-Path: <linux-kernel+bounces-332282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CEF97B7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1311F24A43
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E1B15572C;
	Wed, 18 Sep 2024 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3xtDg8pB"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644314C98
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640220; cv=none; b=WwDgBefgGmcJFSf6F1+xwWUm4HxpeEzAGlNw3E4Wrvw1+SUck5M5yxWPwdCcpJ7DqTDeJQiLs/BrTabYE5FZptU8ziS8EG9FgeyaSW/m6rZvKxGZKFkLo2eOcYm6nXF2Phhl39EboirPHGMhdqT1RLzE7fChqJR10SnLnAD0UPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640220; c=relaxed/simple;
	bh=Z9dOEclgXjAS0g/M3o24T3FFdUQ7kJJfJ6kqpGHE6i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VToR+073+P7hzzDJK/MTKHQJhSLFMxvSTMvgExVDdHOAQK27lKTH3n4GY9fxpQBHuoTOBNiSKrNJotbUc31wK2WACKUv3g5nN2JxWjP+M6AZlWqDohP+Z/oWlD61rpNR/RedG8gDUDX/3JAzfFbSbQKd1Q4U9VzQzdg6JPzRCyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3xtDg8pB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GkMYpHuBQrKKMyleWkYf8GBT0HHZeiHXvJyuSxqzyA0=; b=3xtDg8pBn7CawHQQ0YyhGSrNvE
	QyBmYGuWA8tnpp88+X2Oyj8i8nSV4s5enNsSY11PQJeY4HGPeit8QO02OWkvHxLz56wNzwXUO+RZk
	xxuXrCTaur47BROqvDe/wMvOaW0cTctKSzJyLaZcDUCa6OjCd+cUqRcqZ7j3bJ/BFQeLmywgg7DYW
	JtWCdT46/HgCGXWY6s1l61/mZxzi/i6PJp8LB9ceLMvyvdPnjSZv4LWjCVNdXWH6gN2tQqLrvPhnr
	NQAZqH9fazsTqCH6NpvtOGqU3ZFVdhoqyOwlJXpCg+EJVu3Z7ufn9JyrNgYQvKvJsmf4CWiq+TTla
	xzNt9TQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqnzl-00000007WnP-3WVj;
	Wed, 18 Sep 2024 06:16:57 +0000
Date: Tue, 17 Sep 2024 23:16:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org, kees@kernel.org
Subject: Re: Dead code by symbols
Message-ID: <ZupwWT5ZEHFmWIXz@infradead.org>
References: <ZugliLgw5VFb9yau@gallifrey>
 <d289061d-7dc8-41d7-a166-4b3b8dce886d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d289061d-7dc8-41d7-a166-4b3b8dce886d@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 17, 2024 at 01:39:35PM +0200, David Hildenbrand wrote:
> > Now, it does take some more guesswork, for example an unused function
> > which was added a couple of years back, might be something that's
> > there for consistency,
> 
> I know people will find reasons to do something like that, but we really
> *shouldn't* be maintaining / dragging along dead code that nobody might ever
> use.

There never is any reason to keep dead code around.


