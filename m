Return-Path: <linux-kernel+bounces-183367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9367F8C9811
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7852814BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCADCC12C;
	Mon, 20 May 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XNIUyUXD"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F579DC
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716173902; cv=none; b=tC0ji1VsIyqputuqgfPah4XTRVtWgSSPBoBL4N4BLM6qowUCqyHCT1zBt4/XMlNu+5YZ/zGIPTMEzNSp1Smi+a6kEOcobfLZl/wnIENsn5VEw7U2Pj7i9UkKIoYrRiCPmh8WrGZakGqhzlzuEWdm0llMRywkIVySufzJjh+Pnwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716173902; c=relaxed/simple;
	bh=r94y7jKsCQRRHGJ+5mpHFx0/+fRIm83jhc8oLIT45YM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HYAt/jK1MSYjJSLnBKlEFexdK4/oDVYDtPWTupamwDBi2sEF+GWt5htH4vOmqowCBO4HM+wuETm3yDhWhXCadg0LzHzRQSHZjWLs2GnHmSJNolmKrUsUhGI5bNGYuo2Tp+FTjgqMvkEFEfvbav3O9sWg+kVpoR6dFQDFtPIrfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XNIUyUXD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux@weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716173896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r94y7jKsCQRRHGJ+5mpHFx0/+fRIm83jhc8oLIT45YM=;
	b=XNIUyUXDlITLKNPfmk2QBQ0mS2iScwy1UlTDZDhfqvAsh0bmsC6WDqRgVgnqXdTGlNTo59
	FtDHd0O3sDo7orHDsGPjDUjhoR8RnwD3c8AmDGWw3gGS0zk4DB+oBvBWjakeM3nOHMiSeW
	1Ppmfi/1jO0LmxohEC/SVVY2unMqyCs=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: j.granados@samsung.com
X-Envelope-To: mcgrof@kernel.org
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] mm/hugetlb: constify ctl_table arguments of utility
 functions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240518-sysctl-const-handler-hugetlb-v1-1-47e34e2871b2@weissschuh.net>
Date: Mon, 20 May 2024 10:57:40 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linux-MM <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org,
 Joel Granados <j.granados@samsung.com>,
 Luis Chamberlain <mcgrof@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8002B18-F0F9-4E53-8B7C-B843C83C1D46@linux.dev>
References: <20240518-sysctl-const-handler-hugetlb-v1-1-47e34e2871b2@weissschuh.net>
To: =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Migadu-Flow: FLOW_OUT



> On May 18, 2024, at 22:00, Thomas Wei=C3=9Fschuh =
<linux@weissschuh.net> wrote:
>=20
> The sysctl core is preparing to only expose instances of
> struct ctl_table as "const".
> This will also affect the ctl_table argument of sysctl handlers.
>=20
> As the function prototype of all sysctl handlers throughout the tree
> needs to stay consistent that change will be done in one commit.
>=20
> To reduce the size of that final commit, switch utility functions =
which
> are not bound by "typedef proc_handler" to "const struct ctl_table".
>=20
> No functional change.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


