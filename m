Return-Path: <linux-kernel+bounces-241752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6562927F25
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3959BB22ECD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D0143C6F;
	Thu,  4 Jul 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EZYggXcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6B73448
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720135590; cv=none; b=izi9A7tKUWVadHi9KBmuJqIPllKgGimED5xOKJQCBaidPxymsAJRKegJPEDg+ptK7+fZr6t7vjczAa8m8stHy6EQ3FSMXJ0CpvwxcBI3JJl6bb1FL8m/QCtWqFlOEx7eD8xWAw/ZOV6OiVVGbIRfVpJMs4fkj45qVQf1AmjRvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720135590; c=relaxed/simple;
	bh=4N9YUyDrPaqH7sykixS9Sq/oqokMBdI2QCszV5PFZh8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DDtMayTr7DzXBqnc0uiYZ7pbx6hmBQkbSL/s40W0zW0wPLUgerbTvB38k4hTGvAmF9Jm1yrobztP+TNWNELuohzMqHq6y9h+uAs9Zs44/6XY6K0rn4GCFRKS85bcaTc+KpHWEbYOHeq/hWo+dK2W8fV3Ylwybaa5iWskmBjWmF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EZYggXcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47D0C3277B;
	Thu,  4 Jul 2024 23:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720135589;
	bh=4N9YUyDrPaqH7sykixS9Sq/oqokMBdI2QCszV5PFZh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZYggXcDEOpP7bnex7zXO7Z5q4fsxcdGMMVhq4p6Qg9QyYPPKkJ8qmaeARye2N4yF
	 FU3Bn+gbgI+LSbEpjt12P+WXfZtwjvgznfwgDk3ywRxoIu+j+Cnql/yfq60GuAaNDH
	 uCeYqHuM5fiMF6qZ+3wwXFLMBCC4dq1+yEpZ97IQ=
Date: Thu, 4 Jul 2024 16:26:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Rui Qi <qirui.001@bytedance.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <nao.horiguchi@gmail.com>
Subject: Re: [PATCH] mm/memory-failure: allow memory allocation from
 emergency reserves
Message-Id: <20240704162629.cf750dd1ee58c70d358466f3@linux-foundation.org>
In-Reply-To: <070697f1-83f5-ff8e-dfc0-2f99c98c448c@huawei.com>
References: <20240625022342.6158-1-qirui.001@bytedance.com>
	<d7fb45a9-2d16-a2d5-59f4-f1e7a4362e33@huawei.com>
	<20240702001940.43a9447a76b51a871d8dec97@linux-foundation.org>
	<070697f1-83f5-ff8e-dfc0-2f99c98c448c@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 16:04:02 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> >> Tasks might not be killed even to_kill struct is allocated.
> >>
> >> ...
> >>
> >>> -	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
> >>> +	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC | __GFP_MEMALLOC);
> >>
> >> In already hardware poisoned code path, raw_hwp can be allocated to store raw page info
> >> without killing anything. So __GFP_MEMALLOC might not be suitable to use.
> >> Or am I miss something?
> > 
> > Yes, I'm doubtful about this patch.  I think that rather than poking at a
> > particular implementation, it would be helpful for us to see a complete
> > description of the issues which were observed, please.  Let's see the
> > bug report and we can discuss fixes later.
> 
> I agree with you, Andrew. Thanks. :)

I dropped the patch.  Please let's proceed as discussed above.

