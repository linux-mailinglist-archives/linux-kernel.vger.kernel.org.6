Return-Path: <linux-kernel+bounces-444193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D79F02B5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE1F16A431
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47EC5FB95;
	Fri, 13 Dec 2024 02:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K4Hx8Xfk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F22AD2D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057366; cv=none; b=lZWhkrTrtMB8ifP+XtlIv7gd6mmJi0fy11NOyAVslfNjUt7H/gejpnLfS9p4y6wIXFXtkXE7bpb/l2J6AaNUL4i0eoYV1tbV/H6RsoX2r2pn7DSLfsln6/XDePqK+N2A06dNLuny9HERgG63bwvwuWijM6fNu9IYBmEOlijM7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057366; c=relaxed/simple;
	bh=DjWZMTqJOcRGgdA+uiArB4Op70x1IL0Km0ID99UMobE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EAnQBvWozavf0gv7q/Z7InnOCqWi5q92LKbr7w1QuI2ahHBIcC7yJ1WPD0I0Q/PZncY1nxb2RF0GYuGV+9WQ4cZtl59SscGhC4m0h+Sw7+IvDk2XQZ8IvYx4+sCLshA6natc4IBC7nMdvwNjdkPdCpjbPKAZDcQB0y0VJXUSjCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K4Hx8Xfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642ABC4CECE;
	Fri, 13 Dec 2024 02:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734057365;
	bh=DjWZMTqJOcRGgdA+uiArB4Op70x1IL0Km0ID99UMobE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K4Hx8XfkpNfpyOC+b4i6l5IP4hXeIp3wFWmEt0HA18ybFM0TGTL1JJhvOkEcBHyu1
	 yW2wN2+b0b7Mr/hD47CUEfjp2pq8RZyAiqhP09TbWK5fpOv2RuTup1I7PacdYwDi2x
	 /PE8yPS1/KAN8Zw9nMIr6JVzBoPJvQx0Swgl+Amw=
Date: Thu, 12 Dec 2024 18:36:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add comments to do_mmap(), mmap_region() and
 vm_mmap()
Message-Id: <20241212183604.9da0c62eaa23770092798767@linux-foundation.org>
In-Reply-To: <20241212113152.28849-1-lorenzo.stoakes@oracle.com>
References: <20241212113152.28849-1-lorenzo.stoakes@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 11:31:52 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> It isn't always entirely clear to users the difference between do_mmap(),
> mmap_region() and vm_mmap(), so add comments to clarify what's going on in
> each.
> 
> This is compounded by the fact that we actually allow callers external to
> mm to invoke both do_mmap() and mmap_region() (!), the latter of which is
> really strictly speaking an internal memory mapping implementation detail.

Thanks, the world just improved.

These functions have pretty dumb names.  Patches to give them more
useful names would be small...


