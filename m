Return-Path: <linux-kernel+bounces-567420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBEFA685BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030BA19C6E72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9B211A28;
	Wed, 19 Mar 2025 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U+ajt2NO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E824E552
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368949; cv=none; b=idQv4zqSiR2x4okREpYq76vg04ZuextLX6EXWkPaHPYakuyISBJJmk0TDacvh9Dqmc2DjvXHFtfpZyMhKT6gVx1QlyDDJAI9aGrhJERUMScG27+OkbvMGlLkyTxrCdTxHnQySf1WVqlh6pg07weCqB/Cph8i+4CgplBR+ZvISEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368949; c=relaxed/simple;
	bh=4h97Bl2a32xA6tEXW8Z3sSz9LnKm+cJjIEjk8FVDRZQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G1fPa6mRf57vL5VUER2ljMF/CFKUP95FdESB2KjDMokiYGytjRbVX+/XAjEdkl8oLkRqsWVWIEfbZYVfMrJlWeTdOQM06/5xfGvX4caZt8ZOVxyK6XD8JVUCKvURQ1uOOrQTYpnqw/hBao4Zb2lBXLgtsN5Z8Ej6PEz/O5MczTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U+ajt2NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A794FC4CEEE;
	Wed, 19 Mar 2025 07:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742368948;
	bh=4h97Bl2a32xA6tEXW8Z3sSz9LnKm+cJjIEjk8FVDRZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U+ajt2NOWegeWGi+0XSPE2gcjNGcNMqw/uesrWsUNiPKH4uVJJn9uIYmSlYyYu+VY
	 5E9YlNaGYucRqimMJSnOuYucg+2ioUhsoAnRnoNVuuamaBM3VaPPE/Z5HwEHeFajKs
	 HlTLlIJS5ovums2xOxP7txie9ShtlK1Dl2PBQAvk=
Date: Wed, 19 Mar 2025 00:22:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: marc.herbert@linux.intel.com
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Marc Herbert <Marc.Herbert@linux.intel.com>
Subject: Re: [PATCH] mm/hugetlb: move hugetlb_sysctl_init() to the __init
 section
Message-Id: <20250319002228.44e220b1ffadb4cc994ad4cf@linux-foundation.org>
In-Reply-To: <20250319060041.2737320-1-marc.herbert@linux.intel.com>
References: <20250319060041.2737320-1-marc.herbert@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 06:00:30 +0000 marc.herbert@linux.intel.com wrote:

> From: Marc Herbert <Marc.Herbert@linux.intel.com>
> 
> hugetlb_sysctl_init() is only invoked once by an __init function and is
> merely a wrapper around another __init function so there is not reason
> to keep it.
> 
> Fixes the following warning when toning down some GCC inline options:
> 
>  WARNING: modpost: vmlinux: section mismatch in reference:
>    hugetlb_sysctl_init+0x1b (section: .text) ->
>      __register_sysctl_init (section: .init.text)
> 

Huh.  I wonder why this just started happening.

