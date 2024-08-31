Return-Path: <linux-kernel+bounces-309625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624D966D87
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EEC3B220CB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215D44C8C;
	Sat, 31 Aug 2024 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h3DJE3uz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4C21D12FE
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725064419; cv=none; b=uTgoeQUXShvlPWEAavS+KoLbn+y0z9QMCyZor/0doWKpJUkzqopyYZ12ciDZM11D9xOfmPPoksht2nWcYmq+INxtQh3tVwBUvqdhi+SSvR18O6x7LKkmiAsoadiknoDs5yRSnXKXFNYq7Kih9onZATcCUAfPQv95bOZ4VTrayIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725064419; c=relaxed/simple;
	bh=/zwiYktsw8dhvsEPRVmjiwhged4kry9ZNXLHycg7zdA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KYmATqwdiHLb5sSCH1vuxTQvDobUCJ/CkIvi8MhZNVi/0g4Z+0aR2r8+NdPTIgasCKSnLI5HrxP1F53TVaIWoCJC5kToBHUC7u8YQLgSUzPJ+xeDHH0fgwo676YdaceLqgNGeyjQQe86AZreckeY+ZDcGxTVc24clnsmaq3XCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h3DJE3uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3EBC4CEC2;
	Sat, 31 Aug 2024 00:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725064418;
	bh=/zwiYktsw8dhvsEPRVmjiwhged4kry9ZNXLHycg7zdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h3DJE3uzr5u7e5QlVRfuaMKdOWZCSS0y+aO+RSY9Q1RBs64syNXhN5i0mJdqx5L5z
	 L4bzGegkyXJQdAk+WUTXY6Cydiv56sHJCiyQo31qChuuPTtkDjIMsEk+Vz3Kiszvc1
	 hc9kNBvLjjtW8wYMvadv+JsO1B5UDzUqV6fhc4AA=
Date: Fri, 30 Aug 2024 17:33:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Optimize vmap_lazy_nr arithmetic when
 purging each vmap_area
Message-Id: <20240830173338.20c174604ebd8807405a0908@linux-foundation.org>
In-Reply-To: <20240829130633.2184-1-ahuang12@lenovo.com>
References: <20240829130633.2184-1-ahuang12@lenovo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 21:06:33 +0800 Adrian Huang <adrianhuang0701@gmail.com> wrote:

> From: Adrian Huang <ahuang12@lenovo.com>
> 
> When running the vmalloc stress on a 448-core system, observe the average
> latency of purge_vmap_node() is about 2 seconds by using the eBPF/bcc
> 'funclatency.py' tool [1].
> 
> ...
>
> 3) The data in column "w/o patch" and "w/ patch"
>      * Unit: micro seconds (us)
>      * Each data is the average of 3-time measurements
> 
>          System        w/o patch (us)   w/ patch (us)    Improvement (%)
>      ---------------   --------------   -------------    -------------
>      72-core server          2194              14            99.36%
>      192-core server       143799            1139            99.21%
>      448-core server      1992122            6883            99.65%
> 

Holy cow.  I'll add cc:stable to this.  Partly because it fixes a
softlockup, partly because holy cow.


