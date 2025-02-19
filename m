Return-Path: <linux-kernel+bounces-522726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A69A3CDEA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC2C3AFC61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F05263F25;
	Wed, 19 Feb 2025 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wzQff/eO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2B263898
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009134; cv=none; b=LHqscHkBzFrMZcQQLwJFB5V/w8/KGYplS8sr/+x87AYWgWZwaj7AjQILIOVYG+qPbb/73nxD8rsx4rxbd9PweVmjWZuP5VuT6wNRGvk00enaKPYh6GFXoGa3NZI2EKKGntLRwOqFx4ijEW1yCewGn6i6/Q6kqfK4yD/hMNDwl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009134; c=relaxed/simple;
	bh=LRzEFwyIrBQ74JDs/gdiaH0OrhDUHunRPLF7kmwnS6o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IlIz9a2Jf1yV/Hjhc8ZVBls9k2rV787YVa7Pzgc103XRgVewquLzhA+j0FBIsHTDYrZnCgqewHUN6GH/rx2Hfii1pQKZFqJKZGpJ0hY3Se4RtqogcyXU5x7sCPxlbXE/aeUE+LrkDIyN9rR3hCoBXy37nIB7TXjIP2FtY/rX5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wzQff/eO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74547C4CEE0;
	Wed, 19 Feb 2025 23:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740009133;
	bh=LRzEFwyIrBQ74JDs/gdiaH0OrhDUHunRPLF7kmwnS6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wzQff/eOT+u+AtG0ZT7G/dp+QoLv+4GFH94A5lV3pU0eEqGgk8EvbQRAOGvEVTd4I
	 mfQDv4TisX/2jopNlzVHMN/2BjVh+CnmXeS4Rz+/E7qk547VHFMs0RSvknkpFmbtYw
	 keHCHB/Jw+T0Zqp2c/lIb96W47aiPk3Eu49oXr2E=
Date: Wed, 19 Feb 2025 15:52:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@redhat.com,
 yuzhao@google.com, pasha.tatashin@soleen.com, hannes@cmpxchg.org,
 muchun.song@linux.dev
Subject: Re: [PATCH 0/4] mm: page_ext: Introduce new iteration API
Message-Id: <20250219155212.9474b8c44bd58780a54c8a6e@linux-foundation.org>
In-Reply-To: <cover.1739931468.git.luizcap@redhat.com>
References: <cover.1739931468.git.luizcap@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 21:17:46 -0500 Luiz Capitulino <luizcap@redhat.com> wrote:

> To fix this, this series introduces a new iteration API for page extension
> objects. The API checks if the next page extension object can be retrieved
> from the current section or if it needs to look up for it in another
> section.
> 
> ...

A regression since 6.12, so we should backport the fix.

> ...
>
>  include/linux/page_ext.h | 67 +++++++++++++++++++++++++++++++++++++---
>  mm/page_ext.c            | 48 ++++++++++++++++++++++++++++
>  mm/page_owner.c          | 61 +++++++++++++++++-------------------
>  mm/page_table_check.c    | 39 +++++++----------------
>  4 files changed, 152 insertions(+), 63 deletions(-)

That's a lot to backport!

Is there some quick-n-dirty fixup we can apply for the sake of -stable
kernels, then work on this long-term approach for future kernels?

