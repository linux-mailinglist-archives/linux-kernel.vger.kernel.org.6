Return-Path: <linux-kernel+bounces-527545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F76A40C80
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4217AC37F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C07DF71;
	Sun, 23 Feb 2025 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XhUHO1zw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8EECA4B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740275069; cv=none; b=DeCRrUmUt9awEX+6mLHatReuEzQxiUTPk9N0I5oivRUxeerkOC329/95WodBmRGqhvvwbNQsWL94LPeGGmKHmcB8zNcYcrBvjn3gEFyiYNtCkDVFvZcLYVfqtf77WhCRKmq2JOXuKvxTXXDu7b+B6JTf1ndaFw1MBnYl1qFmamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740275069; c=relaxed/simple;
	bh=zV/2J4qzn0ngZ2wEk4LuylyeLRI9omOQ83Y2xtt1JiE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l6jcp1wwCkV6995LOBeWaA+Q3fUWd20VxkcdmCMuZuTI3n9a14BmPHpJ2oHsK6IJ1J8e6R1CoqhEwU5HAWiMKBK9l9N0WTxxrOXE6e9PScaLwdk81nbtR9rui2vHzsdK+pEUN0RRXEBRFopcMnzDBF1Ki/HI8L4xTSLjNTbsu6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XhUHO1zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49605C4CED1;
	Sun, 23 Feb 2025 01:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740275068;
	bh=zV/2J4qzn0ngZ2wEk4LuylyeLRI9omOQ83Y2xtt1JiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XhUHO1zwWBMQxspln033yuiyHjIFQH8hwibGgaoOOjJV38X5Nj+DuAZvT8lFkvYL1
	 rwHFCIGkY0fiVt15cyz1WqSVi/gXLqhB9JgIk8/VNjzaIMdmxWgsS15ZVU9jWcyvDD
	 CdDZvIofTkxYJ5fJOAY1m2eOBkxM0QDd9QfvUK2A=
Date: Sat, 22 Feb 2025 17:44:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: kasong@tencent.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Some random fixes and cleanups to mm/swapfile.c
Message-Id: <20250222174427.2f7d1df81853fa01fa92eacf@linux-foundation.org>
In-Reply-To: <20250222160850.505274-1-shikemeng@huaweicloud.com>
References: <20250222160850.505274-1-shikemeng@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Feb 2025 00:08:44 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> This series includes several random fixes and cleanups to the mm/swapfile.c
> code. The issues were discovered during code review and can only manifest
> under extremely rare and race-condition scenarios. Further details about
> each fix can be found in the respective patches. Thanks for your
> attention!

Thanks.  I queued the first three patches in mm-hotfixes-stable, as
they address post-6.13 issues which should be addressed during this -rc
cycle.

I queued the other three patches for 6.15-rcX.

I corrected the Fixes: hash in [2/6].

I made some changelog alterations, along the lines that Kairui
mentioned.  Please check the results and send along any alterations
which you feel are desirable.


