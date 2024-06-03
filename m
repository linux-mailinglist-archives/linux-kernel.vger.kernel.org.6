Return-Path: <linux-kernel+bounces-199246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB0A8D8456
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2665D2813C0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293C6839EA;
	Mon,  3 Jun 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1dHQY3o"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57891E892
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422537; cv=none; b=U1hvMg1MB2B4S/06bhp5OJ6hRyl2TFrJLIKVdtlcfaXgfGNDBHjSV/TMB9gfyyu4rfdSeawQ6HtRW+SxPJjY/XA5FQjc5UJNjUoRbc6Uippp87z5RsTey3aUo84JsgGiP8wOON71CUQwvRf9Bmev4hN50yJXeFI6SJduVMhOoDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422537; c=relaxed/simple;
	bh=o82meOjThmRLQUXQbyQGv4ifCD5QZt1UojwgVpF0kno=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=LR5iADI3WpkW8Zza4lDXlAt+j9RYxaTG25jlHFBJP/zuJCn9o8mrbl/66O/vsh7g//QDgiW2CC1TfTmV+tlMG/yYQqosovzToZjGQvge91fDbxb8HOCGdX6xbdv8IPuzXyY8hRVzh21LaVWwRtcdq3F3vK+HHdLQCFIBJv26+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1dHQY3o; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: willy@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717422532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjNZ+oF/vjWCQ/HREQOc/k5mgT/wWmurTJZuPcpHueg=;
	b=t1dHQY3oVSv8A1WxxJWuZYzI/r63+xFoBv6byEKkCYOb7/4GqdqWiel8RgbTMYfGeEqX90
	T2rtGURs5Nh6RQozkQumBbbjM7eznegFXWTdIjVTMygEhR2Sz+JV3+fKAaAFJkIPkHG09f
	S6JWNE+hSHu6BqQXI0vZx0B9+ufgU4M=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: rppt@kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Jun 2024 13:48:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <1bb60f7db3a11e86e6f48c1eefe7f27d7d23019c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm: pass the pfn to set_pageblock_migratetype
To: "Matthew Wilcox" <willy@infradead.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, hannes@cmpxchg.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Zl2_N9wHOh9ACQpt@casper.infradead.org>
References: <20240603124100.2834-1-yajun.deng@linux.dev>
 <Zl2_N9wHOh9ACQpt@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

June 3, 2024 at 9:03 PM, "Matthew Wilcox" <willy@infradead.org> wrote:



>=20
>=20On Mon, Jun 03, 2024 at 08:41:00PM +0800, Yajun Deng wrote:
>=20
>=20>=20
>=20> It is necessary to calculate the pfn in the set_pageblock_migratety=
pe(),
> >=20
>=20>  but most of the callers already have the pfn.
> >=20
>=20>=20=20
>=20>=20
>=20>  To reduce the calculation, pass the pfn to set_pageblock_migratety=
pe().
> >=20
>=20
> It's not exactly a hard computation though. Have you done any
>=20
>=20measurements that show this patch is an improvement?
>

No, just view the code. But some callers are in a for loop.

