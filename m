Return-Path: <linux-kernel+bounces-215627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF0690952A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 03:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10382B210D5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8303D9E;
	Sat, 15 Jun 2024 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b30AgN+H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4BD1870
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718413934; cv=none; b=rEGCWLuU/paOVgC2bF4bfWjjbHS4/MhyEK9TexoGkKCkvyHnGP2vEN9cw1y+qDuH6pXl3+KJaoYm8IZbQDHO5Z8Dp+cuwPHHfWPLvayVjRl0l2vkpfaBnt4zEjbIqV4b4Xp8mSM4AU6yDhACUUZH7Ft/rwxaF1SRIY9QZF2Bqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718413934; c=relaxed/simple;
	bh=LEcIDCJ7jSaGc8Hsgrcb9sbwFCel2QbuN39Me/cDGn8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U9jxKsE0g714KbRfaSgmxH0dzk3//9uSbdPIEX+iZkIByeHRKCnv/fpKEXBOwFIQ3h+rqJL8xRodsPnGo2M9RUiNF6fCVIGNuf2GdLlKG4q7FLaNmrEcaqv16rhjKRvNf4AadutuVzlbV26nWnG7NZG/vuPbk55uVdspdUUEUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b30AgN+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E588AC2BD10;
	Sat, 15 Jun 2024 01:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718413934;
	bh=LEcIDCJ7jSaGc8Hsgrcb9sbwFCel2QbuN39Me/cDGn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b30AgN+HmE375hJsXehs4UHGGFW/yl88OrkJDwmQQp3QeDdUkBZXgVVN/Mijf5yKm
	 8yRjjE/CQKtQZHgEwPPhnY1t74sqJ3gLUyYEu3lITZqecy+B0VGZkCJtlU/wTUXZZu
	 SDSclc8Q1A0g73E3e1a06deYcu/TWuX8wDA58iGY=
Date: Fri, 14 Jun 2024 18:12:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: jeffxu@chromium.org
Cc: jannh@google.com, sroettger@google.com, rdunlap@infradead.org,
 david@redhat.com, adhemerval.zanella@linaro.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org,
 keescook@chromium.org
Subject: Re: [PATCH v2 1/1] /proc/pid/smaps: add mseal info for vma
Message-Id: <20240614181213.3d42b3c3a031acd742349695@linux-foundation.org>
In-Reply-To: <20240614232014.806352-2-jeffxu@google.com>
References: <20240614232014.806352-1-jeffxu@google.com>
	<20240614232014.806352-2-jeffxu@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 23:20:14 +0000 jeffxu@chromium.org wrote:

> From: Jeff Xu <jeffxu@chromium.org>
> 
> Add sl in /proc/pid/smaps to indicate vma is sealed
> 
> ...
>
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -571,6 +571,7 @@ encoded manner. The codes are the following:
>      um    userfaultfd missing tracking
>      uw    userfaultfd wr-protect tracking
>      ss    shadow stack page
> +    sl    sealed
>      ==    =======================================

I'll queue this for 6.10-rcX as a fix for 8be7258aad44 ("mseal: add
mseal syscall").

