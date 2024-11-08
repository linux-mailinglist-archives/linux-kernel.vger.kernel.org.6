Return-Path: <linux-kernel+bounces-401353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D471F9C192D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C3A1F23C90
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95031E0E0E;
	Fri,  8 Nov 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fUI8sPw3"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C661D04B9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058432; cv=none; b=qXYyXhZ3fwqQVsRdLVm3iFmCIQDUt/dcgYot0hT3mxxXmGEU4CAM7OkrGHCq34OF2n6xQS7Aw64is9w9hKmWJG9ItT5EVkZS3DXCtvd54Fl84frNnfWtjYKwz4EpPVWci50H7rArz0ZAhnDnN3k37vBk3K834tPlj/3yoy2kRNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058432; c=relaxed/simple;
	bh=jHGeaIeXbClXGW3OEnaUVDx57xoW1HF6tH5iHko0tNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7YpFeBh29EcqEDqzmKXSSibSDwX6iCEVYNuhB3L/1Maa2Eo3BSOb+dUvGOw9/P9CJIidNvByBECD7VUomAXea+ca4gEykppWikCy+ddxBrEAgTmLk1TGpULAJgg7nrMyMihAqYm5R64pJm8fVY77eacr2grjAkBoE6Nn6Wl+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fUI8sPw3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jHGeaIeXbClXGW3OEnaUVDx57xoW1HF6tH5iHko0tNw=;
	t=1731058430; x=1732268030; b=fUI8sPw3A+ZlktWlgF4RWSh2B5sj12vALQ9qNgIzwEWxtSp
	GNmK1elwggzbUoCRRxDvAgj7bsaRwTFPz1W8iDyjsr/gEs6F+h8JYxtYoyVStMWFZ03po8hjWDGkG
	HyPKQGHiIIrIr7FvNwqHJWgeFLSPUx4fBeSeR5Ikr/k2gio/1NxjWhoHcIgw2dvnxZtm65mR6VSnD
	WXodUzWAeG8+MzXvpg1mU+/Xvf+GC8M7PspO+GbVbacvAie1AeCyxXyhGwJ5fyT0rmWRpF69AZPVa
	3soLgVDc9y28hcoRFtRpMs8Ag3sPTu1nomq648ttwb7JDXzVKKdChwHP2hsj5seQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t9L7N-0000000HBo9-39zq;
	Fri, 08 Nov 2024 10:17:25 +0100
Message-ID: <065b0d76aeea7d3543d3eab302167af039e8f913.camel@sipsolutions.net>
Subject: Re: [PATCH] hostfs: Fix the NULL vs IS_ERR() bug for
 __filemap_get_folio()
From: Johannes Berg <johannes@sipsolutions.net>
To: Peng Zhang <zhangpeng362@huawei.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, willy@infradead.org, 
	josef@toxicpanda.com, brauner@kernel.org, zhangxiaoxu5@huawei.com, 
	wanghai38@huawei.com
Date: Fri, 08 Nov 2024 10:17:24 +0100
In-Reply-To: <20241104123440.1347175-1-zhangpeng362@huawei.com>
References: <20241104123440.1347175-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-11-04 at 20:34 +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
>=20
> The __filemap_get_folio() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.
>=20
> Fixes: 1da86618bdce ("fs: Convert aops->write_begin to take a folio")
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Not sure it's critical, but for um I wasn't planning to send a pull
request for 6.12-rc (and I suspect Richard also wasn't, as there are no
other fixes). Also, the original commit went through another tree.

Christian what do you think? Do you want to pick it up? Or should we
pick it up via um, but then likely only for 6.13?

If you could pick it up:
Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes


