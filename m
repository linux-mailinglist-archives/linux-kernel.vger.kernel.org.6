Return-Path: <linux-kernel+bounces-541687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10747A4C019
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300AF3ACF38
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502CB20E6F7;
	Mon,  3 Mar 2025 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3PRnsBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17C1F3BAF;
	Mon,  3 Mar 2025 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004325; cv=none; b=nghX0oeZkLogR5qJ6NxrmzktZ4pZALh68uT+kA2THGp9VED4ez6TsZEpRIgO5ga1M2G2VjUA1WkTWJbkVXNhQZD5HeW3f+RA4ixhacixxmOPaai46rpSjn5CxXnweE5AtI3/Df5VDLTIspHIveSK4S2eJcrbzlHRyuliCY4oFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004325; c=relaxed/simple;
	bh=WgK8Yzpy8QNBwy1aVpbpb0LnXY+XMuQzRIKXc5Rbt7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuCu59Ht1uGDv42aHYW1BTXvYYrR3mIaeNuHFp/f6ymwqD0GY/tDPWBUvx7SbDUnlU2n6DYsJ9ciAp416mZDhFsTRzSCtL3h1ObjjazOo8SvDH+sy32aB15frOy8qNooKf1ycb2HNCi4hlxDcVz2g4sLp8Cv9nZq/Vg3UxgBYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3PRnsBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A4CC4CED6;
	Mon,  3 Mar 2025 12:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741004324;
	bh=WgK8Yzpy8QNBwy1aVpbpb0LnXY+XMuQzRIKXc5Rbt7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3PRnsBgLaj6pEwmo7HqPGydJ/qShWa6trbFXPg9M3gKzVYpXlBGYk3DuE5my7rhC
	 IRnEDHmp80LuIAVWFxJF8mUsJYI9rzo8WwB20WB99LAVox8f1uaKata1BMo9W/Rlym
	 EEqeJxjTBHh3geVusvN/8mlZE283MTaHYGBqZhgfKsgS1vIs+BJ0XdcmkYqIzLRP0d
	 rkK1NW7ESZJmP5Yb7Zk1gXW0kNa65+3NdX1dtXAl/ochG6tD78h235rvJaKl5TjA84
	 dcbmE75mXOQmEASUMtKaVBzNSkCYGyieS5dG8NLXA9hOGlIkw/ceMYexHDRrxiYMR6
	 VwgcR0gGOpsbA==
Date: Mon, 3 Mar 2025 14:18:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/siw: switch to using the crc32c library
Message-ID: <20250303121839.GA1665583@unreal>
References: <20250227051207.19470-1-ebiggers@kernel.org>
 <DM6PR15MB252204B65F9632684EA8B82A99CE2@DM6PR15MB2522.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DM6PR15MB252204B65F9632684EA8B82A99CE2@DM6PR15MB2522.namprd15.prod.outlook.com>

On Sun, Mar 02, 2025 at 03:11:42PM +0000, Bernard Metzler wrote:
>=20
>=20
> > -----Original Message-----
> > From: Eric Biggers <ebiggers@kernel.org>
> > Sent: Thursday, February 27, 2025 6:12 AM
> > To: Bernard Metzler <BMT@zurich.ibm.com>; Jason Gunthorpe <jgg@ziepe.ca=
>;
> > Leon Romanovsky <leon@kernel.org>; linux-rdma@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Subject: [EXTERNAL] [PATCH v2] RDMA/siw: switch to using the crc32c lib=
rary
> >=20
> > From: Eric Biggers <ebiggers@google.com>

<...>

> > 2.48.1
>=20
> Many thanks!
>=20
> Acked-by: Bernard Metzler <bmt@zurich.ibm.com>

Updated, but please try to trim your replies next time.

Thanks

