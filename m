Return-Path: <linux-kernel+bounces-568383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A9FA694AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103221B608E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB031E0E14;
	Wed, 19 Mar 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Mzb/lx92"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0151DF991
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401001; cv=none; b=iWFvQPrm3JWLE7/M2WQdmRcOqo1X22h4zRqGqNL3MKMbNQAO2AKbeVb7XGEdVEV22XIlScUrDz7+FYzYUc3Pd3SsPUt4mRHNT5bR/3MAtMuHluPJEnAzyKxqExKszUxI2bffwdAoqgZFNFeWpmWL8jhnOXytmdMM+A/JpWisOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401001; c=relaxed/simple;
	bh=NK2p8XP5MbWRNZpYjgSOqd0EGPUspYPwngStqyotFC0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BY1hIUr8rC1fbU4nZIGkONTzpxb73c1icR+6cf+D/KU0Ii0eZV0yMbbr6tiFCDSwfQLIWw/EC2F/eHAT8OXsV/g6UcAWxf/OIQfBamWmnx9+w+U5y5dFecgq0ahAJfrQU+gwPFUtm1kU6ebemuIIMw37SX+TvyTctQrMW+LoPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Mzb/lx92; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250319161636d179b474efc1e4ea34
        for <linux-kernel@vger.kernel.org>;
        Wed, 19 Mar 2025 17:16:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MnYXiDZjqKVxg7WWziHarX+d0hjIdExLZOQ0h/DFHUc=;
 b=Mzb/lx92eUDI5Hqp5dDM//cwC+4G8p3xWxToy1ra9+s3tvGwKjReMavb84jkoBPqSFojJx
 iCfcdQ2Ma6PYADu89VDoFl/i0peM7GIrPhJ3mxjCt0zGhO4Rt6pu8OSkLul+Cv7m69TICrBa
 JQ8ZLUGfFbZs+kAbYrcHzwzrs9CjUd2rZ9vWmrQ19TuGFCEtpWlSTEunSn1e5tBrLThG2HEb
 zZrWr2vMw3BlDwssO7ZLFaDmintNy2cBw+yPMXEwgG2wfZ3IxaJpoOyjg46RI1nzC0u+m0Lx
 rx8m9vOxKB9eIpa+oRruokQMKhZvbgw0DSRFSFZZXi1aLKOPSFDMQdLQ==;
Message-ID: <d4b15c726e7c2219eb09b094ae9fc1299fae51e8.camel@siemens.com>
Subject: Re: [PATCH net-next] igc: Fix TX drops in XDP ZC
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Zdenek Bouska <zdenek.bouska@siemens.com>, Tony Nguyen	
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Andre Guedes
 <andre.guedes@intel.com>, Vedang Patel	 <vedang.patel@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>,  Jithu Joseph
 <jithu.joseph@intel.com>, Song Yoong Siang <yoong.siang.song@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 19 Mar 2025 17:16:35 +0100
In-Reply-To: <20250319-igc-fix-tx-zero-copy-drops-v1-1-d90bc63a4dc4@siemens.com>
References: 
	<20250319-igc-fix-tx-zero-copy-drops-v1-1-d90bc63a4dc4@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2025-03-19 at 15:18 +0100, Zdenek Bouska wrote:
> Fixes TX frame drops in AF_XDP zero copy mode when budget < 4.
> xsk_tx_peek_desc() consumed TX frame and it was ignored because of
> low budget. Not even AF_XDP completion was done for dropped frames.
>=20
> It can be reproduced on i226 by sending 100000x 60 B frames with
> launch time set to minimal IPG (672 ns between starts of frames)
> on 1Gbit/s. Always 1026 frames are not sent and are missing a
> completion.
>=20
> Fixes: 9acf59a752d4c ("igc: Enable TX via AF_XDP zero-copy")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethe=
rnet/intel/igc/igc_main.c
> index 472f009630c9..f2e0a30a3497 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -3042,7 +3042,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  	 * descriptors. Therefore, to be safe, we always ensure we have at leas=
t
>  	 * 4 descriptors available.
>  	 */
> -	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >=3D 4) {
> +	while (budget >=3D 4 && xsk_tx_peek_desc(pool, &xdp_desc)) {
>  		struct igc_metadata_request meta_req;
>  		struct xsk_tx_metadata *meta =3D NULL;
>  		struct igc_tx_buffer *bi;
>=20
> ---
> base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe
> change-id: 20250310-igc-fix-tx-zero-copy-drops-1c4a81441033
>=20
> Best regards,
> --=20
> Zdenek Bouska
>=20
> Siemens, s.r.o.
> Foundational Technologies


