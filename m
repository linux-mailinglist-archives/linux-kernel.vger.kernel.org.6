Return-Path: <linux-kernel+bounces-411812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E716B9CFFE4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE1C286BB3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2038518785B;
	Sat, 16 Nov 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="PyTVcIuG"
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7350F9CB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731775066; cv=none; b=sqI0qPewbqLXRMcODxlhnjbCOkAt74u/BgTyIy+jKwDYZ/LE4c9avEgSg1783YGdlgu2xOOuoJHVrzQ6UliTl8MumMw/kwakEUtkYycWA1plnFMOG1SrQy4HucrqHEFNPuaK9PLrhXCmrbSjIl1/qgI4o10i8Yuc43uIQmBKMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731775066; c=relaxed/simple;
	bh=fGRcLgTdAEn87VdKiChEPOpSyV2TeNOcjHVwbHLtHXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyqpkDIX58V3OriH7qgqxkUShPaNKOf7czc+cCO31RzwZgnnYgIH7ZUN+N9+pq50+31L3Rel2DDcRSkFSxx/ZXmtTxX2br8xP6NhpT++6BlcEaPcdLgLC/AYfrly0TG59zYl2RFDq+RisToVN1zAmZkTPAreEv3QyLrVlliAAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=PyTVcIuG; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=cpNm5dh0wytspX2vkDrBMvEUs3Vr1KnmEy3dyDTmaig=; b=PyTVcIuGH++Ou3695qVpd9C4xK
	qSELpqV59tB+bZtExb4/N0DX21Xo8C8GxNWz45Pqf5KeVjwwt5lbRWcIpvPhaoYVYiqwHMRhQo41S
	IcYflDrd45dEagojBCqrb2/GftNNvcpfJMKZqouSEXNUe+MJ4nd31zWMmO7+f/4Jv4rS0qyIdWdCz
	zhuhoYi9srVLFSCeAq9elYM6SovzgSvAbXumJvC1Mv75FfGD+wCpMjpWVTfLNlGyACkJBLsS6LbU4
	jjI+asSzYubStIoJHniBaP5nZJlS7NRpwtmMQFI+J/GmsJwVdtWcMUCSoKVGQXP7RbLk2QEAwnz75
	L7hZVRXrI9jaRYUTH2d+GkW1CSHWkqYlHJI0gP1ijNsnE3cPWxT84jVVS+pZLNR3cVLb0VEDr4NVp
	eP9HRx24xWvdiIUZX+LtSc+W/V5VCAKfEBNoyD3I7QO0PirnQFYC9Rvu/j5lvicJcQSS5eBejzEc8
	4ysXBUnE2xeo6rWgvsgDRYBF9n+emOn5/HaGJmfD4xR5dLq5dykuIWbunutK0Qrp9wJrWly1RJHRW
	l6YYGT1jBqL7KBmGcj4Ge3dyw4GW3o86hoUfslKQbY5uk8st3XXGUjwasxBw1QNeGgfsKwEjhYKxX
	qkrMxDCU5bmEEkM99uZ9zn/J4Ov5NKjXcToqne4FQ=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 Rex Nie <rexnie3@gmail.com>, Colin Ian King <colin.i.king@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p/fs: Different branch return the same value
Date: Sat, 16 Nov 2024 17:06:17 +0100
Message-ID: <2715835.jR4hUPQygh@silver>
In-Reply-To: <20241116152612.2423-1-rexnie3@gmail.com>
References: <20241116152612.2423-1-rexnie3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, November 16, 2024 4:26:12 PM CET Rex Nie wrote:
> The same code is executed when the condition ret < 0 is true or false.
> Remove the if branch and just return v9fs_init_inode_cache(). This
> does not change the semantics of the original code.
> 
> Signed-off-by: Rex Nie <rexnie3@gmail.com>
> ---
>  fs/9p/v9fs.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Too late to the party: :)

https://lore.kernel.org/all/20241107095756.10261-1-colin.i.king@gmail.com/

But thanks!

/Christian



