Return-Path: <linux-kernel+bounces-549055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8232AA54CA1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58601891C01
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACAC13B5B6;
	Thu,  6 Mar 2025 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Ejvj1ORD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8091304BA;
	Thu,  6 Mar 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269081; cv=none; b=uUwdl43zgEz2Lvqva4AmUIjmz5KQA0k2BA74B1Yxj+sirtuJ7N3QIxje73ez0q1LYL8iPpCx3UKvgueMat39DGxgHYIv/RR+qYOyt26+ypA2C3k2qdbtv5p66gALVVlgYyqP1WPb8lg7qvUG+8Lm2g7qdrMjEZkqrOwxLGklt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269081; c=relaxed/simple;
	bh=e9ZGFcbPg7p0RmBJkV377OQLqp4jQufxna77rBcTb5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BG2yFD3fTIEt/fYoiSxJGw3G3JiWzZEZ8xB8iA1iPTORzMO9OgEzXzXnD9oFWFwYUwyOXNxeqi18oSeacm/RPP4SgXE6ZV3+ymKH0PTeR1oM3iTjvrAEElBMEKwqrmQL9ZKn6YKraltYO6C942tqmxtj9ejTyKhWZNfbJ3WmtC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Ejvj1ORD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tfit3Fz0i31tRy70JNSd1EFtd6PuzVakM4X6XHPww3A=; b=Ejvj1ORDq3Xzz/I8L7kds7Y9Xq
	1/dh6WYh+ZOXL7uLac0XITB00b+xgwn3eYH25rvAqmifFDkIgGb7gMwg23nbr016dV2qH6dEds0/d
	nFmqG6/2x4MjzAXyDz7nsyN6UGfA8Gj0YPhzBj501xEQpTHao3mo7UCDx2AMCPvjlxqaQIFkzxcC1
	rIUC+yoVIVQy9Y3U7iakqAW1G3g/sRjntXIJ6utLWP5+Ue4Akw9pQtCsGndck1ipaQdUBQTSgn07P
	3p5FsgHIa2LRwCnnc10C9dj6JShiiZlhOpTtt+NtRrpp+Od11fEZwHrHSYpqaE9/julw1+4bUD5RN
	vEKh3wEQ==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqBd6-0003Vp-TB; Thu, 06 Mar 2025 14:51:16 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: amadeus@jmu.edu.cn, conor+dt@kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh@kernel.org, ziyao@disroot.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Thu, 06 Mar 2025 14:51:16 +0100
Message-ID: <7020561.MhkbZ0Pkbq@diego>
In-Reply-To: <20250306134002.380690-1-amadeus@jmu.edu.cn>
References:
 <4856313.kQq0lBPeGt@diego> <20250306134002.380690-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 6. M=C3=A4rz 2025, 14:40:02 MEZ schrieb Chukun Pan:
> Hi,
>=20
> > That sram is part of the soc (and has an mmio-address), so I'd think
> > it should live inside the soc node?
>=20
> But soc ranges starts from 0xfe000000, I don't know whether to change it.
> And all other nodes are 0xf..., except this sram.
> Any suggestions would be greatly appreciated.

darn ... I didn't realize that this is not sram, but main memory :-)

in freescale/s32g3.dtsi and blaize/blaize-blzp1600.dtsi I see structures li=
ke:

        reserved-memory  {
                #address-cells =3D <2>;
                #size-cells =3D <2>;
                ranges;
               =20
                scmi_shmem: shm@d0000000 {
                        compatible =3D "arm,scmi-shmem";
                        reg =3D <0x0 0xd0000000 0x0 0x80>;
                        no-map;
                };
        };

does something like this work on the rk3528?

Heiko



