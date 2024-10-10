Return-Path: <linux-kernel+bounces-360083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91153999440
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B56B21F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B71E231B;
	Thu, 10 Oct 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FVPx5m0L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2018DF9E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594352; cv=none; b=qaCEVKfpoJRC98F8EM+NPAmnr1eLVq0l55yrYfXZJMXz0QfO1JfaXUMFgHrGrBVnG1Y9TdUujLYWN1HcNd6kV4nsizkuS+4cihHeGK2/PvbmLnwwptIkkjIyNLa5UaCEQr7Rsaak3jYbuFBVxbaXkqX5n7o1Lgf7auY53I6JfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594352; c=relaxed/simple;
	bh=T52c+uRGuMEbj+7K65qfg6C1v7zpGJnr0UBFuMgzSlQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dLrsq6XvU+lmOopYbi1v+pyxsUEAR11hgiQFCjOljUDWXEHOzBY3LKQaiC6DUBUNSRvJtpaeGjL8cBMTYxtARtU143UopzQ/afi18us0SMP804P8RIz9tfDqpYBf/4YftgoJf0rCV1Fo3yGepY04upDTOME66a65v/1sfEddv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FVPx5m0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1FDC4CEC5;
	Thu, 10 Oct 2024 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728594351;
	bh=T52c+uRGuMEbj+7K65qfg6C1v7zpGJnr0UBFuMgzSlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FVPx5m0L1hyhYm0Hbjq+0uv7+M1HRG1jVxO7m33fRsj2a1SrzbrkX7FJ44oSSGjWC
	 t6ADCCDh636qoFvgkE+TGWRks8WuFLf8xw+4TKQdpnERoJRIwtL5xdFZeONkSQOGFh
	 S2UPLTibuD1Uxurh+XTaqj3GH6cYUOUWtVX4+NvU=
Date: Thu, 10 Oct 2024 14:05:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: alexjlzheng@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 alexjlzheng@tencent.com, MengEn Sun <mengensun@tencent.com>
Subject: Re: [PATCH] mm: add pcp high_min high_max to proc zoneinfo
Message-Id: <20241010140550.bc083631920e64ab9642101f@linux-foundation.org>
In-Reply-To: <20241010120935.656619-1-mengensun@tencent.com>
References: <20241010120935.656619-1-mengensun@tencent.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 20:09:36 +0800 alexjlzheng@gmail.com wrote:

> From: MengEn Sun <mengensun@tencent.com>
> 
> when we do not config percpu_pagelist_high_fraction the kernel
> compute the pcp high_min/max by itself, which may be not easy
> to tell the really high_min/max.
> 
> we output the pcp high_min/max to the zoneinfo
> 

Fair enough.  I tuned the changelog a bit:

: When we do not set percpu_pagelist_high_fraction the kernel will compute
: the pcp high_min/max by itself, which makes it hard to determine the
: current high_min/max values.
: 
: So output the pcp high_min/max values to /proc/zoneinfo.


