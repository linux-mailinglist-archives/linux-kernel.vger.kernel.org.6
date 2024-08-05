Return-Path: <linux-kernel+bounces-274104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B6947373
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D323281026
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74C847773;
	Mon,  5 Aug 2024 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d8XsitNZ"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E0A21
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826118; cv=none; b=cs8znwdLX9pCRCsGID2ZhnmFFsrViswjBLbnaniMGQnIuQ7W0vgkMtkTU24/6W7N7zzxZ7TGnOslWHYMkdDwjFeYLOFKNj06bOQKbeT7kICOVLwphPxceHImTi+gpwcTHJtVhvvE1e9gJ9wm3FHOF5T2vAkCPmy9LQqMIP73lTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826118; c=relaxed/simple;
	bh=R/RWB0I18d1inZlQWRojdpnVly4zMchOYDexcOOzPik=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DMQi6o8mgIQ2RJwOGLG7vXVkv1YUGkgOobhkP4sfDfzYL5WdikPfcaqcCIyYI8pCpug4+L+2ftOoRsHrbVTS/rh7YT8kMwUHn6Oj1HEMixZDn416rkW1EZNG1Sh3PMKwDJ7oFshXfwPMkXVmsYMgSV7mjTXxaZwvHqkqgfmVYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d8XsitNZ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722826113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut2CWxfoBkVGmPwssGyeaNNJ7cawC2VWIQeMNynvo9o=;
	b=d8XsitNZxiew75KmEMM2A7aDByi13kG5/WVT3lxV1S2L7XJ1K1zp3hhePhxHNbYfb/wV3j
	X7H6zLIkPYhwIsBGp208OsY/ArXY/n4JSSzhSY8f0fhWVReKVhrl+Vmgtx9OEKyBW6rP35
	iKuC6kXiiGv4zhzKn2kK1bNIeP+ETps=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: linux-next: Fixes tag needs some work in the mm-hotfixes tree
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240805071723.571c7654@canb.auug.org.au>
Date: Mon, 5 Aug 2024 10:47:54 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3507BDC6-16B2-4029-BF0A-9EBAFF6F91E8@linux.dev>
References: <20240805071723.571c7654@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT



> On Aug 5, 2024, at 05:17, Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Hi all,
>=20
> In commit
>=20
>  cbd28071cdab ("mm: list_lru: fix UAF for memory cgroup")
>=20
> Fixes tag
>=20
>  Fixes: 0a97c01cd20b ("list_lru: allow explicit memcg and NUMA node =
selection)
>=20
> has these problem(s):
>=20
>  - Subject has leading but no trailing quotes

Hi Stephen,

Thanks. In my v2, I've fixed this problem.

>=20
> --=20
> Cheers,
> Stephen Rothwell


