Return-Path: <linux-kernel+bounces-379012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E69AD8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85502842FA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E0B1EABAE;
	Wed, 23 Oct 2024 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ejMTJVlb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DEE1A2C32
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727476; cv=none; b=fS0s00UWaSmmd/WUEu2ouytvQIlBtHP1/XLBpuc7vxqr+9/XHwGN32qbuQhYBXNukwD0j3He0oD/CG9fWfB8bfyJ2Dd3dkn4tdrq1b8pzytQ0kFtlHnN4tdMzqqf8V4fLl+TlYaeCCbSyv5QEu3cIwZm+oXeTucQLjdBjenv49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727476; c=relaxed/simple;
	bh=tOZhLRxidymKCjRrKhnrUX/ok8moZodUQb17kcBnaM4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tunSbcZJv38AxkGAg7n7tqF+/0RoSs+m/0lCMhr0lx3V++ta5TQnZDmBtK38hBzeDuTiBTF3iZ0U+/GN2C/NNq6E7G49CosMpog923DnBLr/rxponcE9us1vSZiAB2Zb2bKhwmFbpUlbupK6e4BOIK3B8ntOnu7ss7nzMpQ5BMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ejMTJVlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5A6C4CEC6;
	Wed, 23 Oct 2024 23:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729727475;
	bh=tOZhLRxidymKCjRrKhnrUX/ok8moZodUQb17kcBnaM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ejMTJVlbeGGXuvrnkU8BuiyXJWHHcG7iK0SYGd1wJEGPzDdZdIgtMBSPWAsOiXhT4
	 mFThJC8JNnjh5yxB53ovx5G/+yRQkv8u/bPmcjKb1E6kR2zBzypwc3R/JEKphHUsKy
	 Xx6YZ1RViDA3vz+B7loVdZhTOowmbY6qKfsa2fz8=
Date: Wed, 23 Oct 2024 16:51:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wladislav Wiebe <wladislav.kw@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Vlastimil Babka
 <vbabka@suse.cz>
Subject: Re: [PATCH] tools/mm: -Werror fixes in page-types/slabinfo
Message-Id: <20241023165115.b524c51e80c36e120edabb36@linux-foundation.org>
In-Reply-To: <c1ceb507-94bc-461c-934d-c19b77edd825@gmail.com>
References: <c1ceb507-94bc-461c-934d-c19b77edd825@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Oct 2024 19:21:13 +0200 Wladislav Wiebe <wladislav.kw@gmail.com>=
 wrote:

> Commit e6d2c436ff693 ("tools/mm: allow users to provide
> additional cflags/ldflags") passes now CFLAGS to Makefile.
> With this, build systems with default -Werror enabled found:
>=20
> slabinfo.c:1300:25: error: ignoring return value of 'chdir'
> declared with attribute 'warn_unused_result' [-Werror=3Dunused-result]
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
chdir("..");
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
^~~~~~~~~~~
> page-types.c:397:35: error: format '%lu' expects argument of type
> 'long unsigned int', but argument 2 has type 'uint64_t'
> {aka 'long long unsigned int'} [-Werror=3Dformat=3D]
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
printf("%lu\t", mapcnt0);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 ~~^=A0=A0=A0=A0 ~~~~~~~
> ..
>=20
> Fix page-types by using PRIu64 for uint64_t prints and check
> in slabinfo for return code on chdir("..").
>=20

Thanks.

Your email client messed this up in strange ways, so I basically typed
it in again.  I added the Fixes: target and a cc:stable.


