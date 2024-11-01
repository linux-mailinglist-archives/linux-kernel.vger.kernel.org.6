Return-Path: <linux-kernel+bounces-392727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DDE9B9787
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A6AB203B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF2148857;
	Fri,  1 Nov 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TXushUYZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78E1CDFC0;
	Fri,  1 Nov 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485808; cv=none; b=kI4Ev9hd6luLt7m+xs4TBQBb1CCqBtWeF9iRDqtv6zRBmYZks3fwAP1vfh+jnQc3bM8an8K8/Xt6RQEuEwgushN/5YddXsD2qfXFv6C4L2l1W0f4te7snudQGLtAfExn/9xihV89IX9J2a45LIF/DUx6AlbanfZ8IwXV0mFA2Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485808; c=relaxed/simple;
	bh=M1AJnptp3q89FP8JKWFMSHQx2J6Ez6Csk6iW8Ojwuek=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Mv6LDh/eB1oFmZmvaRAY1D8nyGxZsC5sK7Y6V5JWfc0yj9uQfgiP9INFw/ys2oimKbZv46WDa+S7nr8z7CdohZ2svyjzaiLj9Ax5jCaybmh7m3SQclwNLQvG0Wm2zgg9boD/NoKKEInEYkpLKb6S6wz+fTj+nAeiNQDG+694E6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TXushUYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3112AC4CECD;
	Fri,  1 Nov 2024 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730485807;
	bh=M1AJnptp3q89FP8JKWFMSHQx2J6Ez6Csk6iW8Ojwuek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TXushUYZq3Mny+b91xw8UTojUT+2fIt447xCock7tlRnG7ihb7+iZXiQSnRj4Oh0a
	 AkZEmMr4BeA/6ejyUbWSeg+kbAeH5AomN3U/GAPMbs+4qzCsvFesPOSe2HcTRxOPyz
	 vJmWfcM8/XwysWJqjhMsmzcX6xHYbdaIzmdlRTNc=
Date: Fri, 1 Nov 2024 11:30:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, Barry
 Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>,
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH v5 0/5] mm: add more kernel parameters to control mTHP
Message-Id: <20241101113006.454a96eaafc723ebde69429f@linux-foundation.org>
In-Reply-To: <20241101165719.1074234-2-mcanal@igalia.com>
References: <20241101165719.1074234-2-mcanal@igalia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri,  1 Nov 2024 13:54:04 -0300 Ma=EDra Canal <mcanal@igalia.com> wrote:

> This series introduces four patches related to the kernel parameters
> controlling mTHP and a fifth patch replacing `strcpy()` for `strscpy()`
> in the file `mm/huge_memory.c`.

Thanks.  I extracted [1/1] from the series, as the first patch is
6.12-rcX material.


