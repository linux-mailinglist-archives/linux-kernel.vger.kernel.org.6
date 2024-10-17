Return-Path: <linux-kernel+bounces-370055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2244F9A26AB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6971F23A84
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E21DE4CB;
	Thu, 17 Oct 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XjFGeTHO"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9256111AD;
	Thu, 17 Oct 2024 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179238; cv=none; b=TjqDRCC6jWkRIuHEdjKa3oRoGMIeQy6VLJtVE50XpP51hXfqursS7iyYEEKpgeUIDpb6OMH3n8UTYXW69KjMYrmmoiAxRLXiXwekp1HgsByCGGsAazUbx0UTc1AhStE5dsL9ZPDcmhOqmHKgCEERtzH7SMvvmET7O5gpLMn/b38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179238; c=relaxed/simple;
	bh=3pMuEHpwOaSpll42N13R4aWE8EjuRuJR9CLBAND+jJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kUzQNdwGjyDIj2lX81mOM8hKBhhCdNc+6ySsTFrkbea+OoQsnFXP5NxLGIyN3RxXS4klLJDHriw/EmrMSn5sb2YkVO+rnJMmG0rfqWWHUdX60tmpngvyUd2IBLzNl4qEJPmkFv4KEtwvKjX8lqQAPuiVNIucqZDmVvL4MTlEBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XjFGeTHO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9342842BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729179232; bh=Cgf6dIwL5A+zDkEGbeh0z0XOnGyBlSao7mUP7QPyko4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XjFGeTHOtreC3i/PuRJlYTzD2k7pODOmNWJFeyN+dTfx0GggiYigf+UrxC8OrwBFJ
	 IdosYnmgj4pxMaXDImUni4vFxLdquj/6LHeEJHnlXew8yo6yyz0pTkNEnVfPWaXUIK
	 yqS5zkAfMD4/guWa2Y+x4AAZZfPdWvLtrbcXYh0vF6ALVk6rnNM90BUpZ9tDDHHrSQ
	 y1CjtuH6ZQPolTrW+zSS55vjMHWytABxfRRtcYN5z5MJfo1QmL1rgIimmI+LD2Haa9
	 rY3I3bFfpCj35xWAoi4TRmCPARIFy/OG3fCVO8qVy4yq3jEnsmasbEvULqnZq4LRXI
	 Q9ect6nwrCcNw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9342842BFE;
	Thu, 17 Oct 2024 15:33:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Horia Geanta
 <horia.geanta@freescale.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] kernel-doc: allow object-like macros in ReST output
In-Reply-To: <20241015181107.536894-1-rdunlap@infradead.org>
References: <20241015181107.536894-1-rdunlap@infradead.org>
Date: Thu, 17 Oct 2024 09:33:51 -0600
Message-ID: <87frou3fs0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> output_function_rst() does not handle object-like macros. It presents
> a trailing "()" while output_function_man() handles these macros
> correctly.
>
> Update output_function_rst() to handle object-like macros.
> Don't show the "Parameters" heading if there are no parameters.
>
> For output_function_man(), don't show the "ARGUMENTS" heading if there
> are no parameters.
>
> I have tested this quite a bit with my ad hoc test files for both ReST
> and man format outputs. The generated output looks good.
>
> Fixes: cbb4d3e6510b ("scripts/kernel-doc: handle object-like macros")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Horia Geanta <horia.geanta@freescale.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> ---
> Cc: linux-doc@vger.kernel.org
>
> @Jon, feel free to update the attribution for your patch or I can do it
> and send a v2 if you like.
>
>  scripts/kernel-doc |   43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)

Applied - thanks for doing this.

jon

