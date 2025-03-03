Return-Path: <linux-kernel+bounces-544817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C749BA4E5A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C7C17B479
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF972D0E0D;
	Tue,  4 Mar 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgPH6cRE"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838472D0E10
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103505; cv=pass; b=MalF2egI+LWQ5xIW768bfDxlyeCNmJqh6N3NZPF7R6r80mi477liC03/eIixgsd86AIH5SGCdsgt1dx/rK8TnIIRW7rT8d190n2vxj01+vbGUv+wZraIxPd2jpiwzERE4VO+AsLvkKaKoMF3bkLBtlOL3kcnmN3t/o7tGAeXTNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103505; c=relaxed/simple;
	bh=MJ1eWiZF1zNkmxOw5SUe/EJwnqJlYPHJ1CHEJLkZExk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9TPRP1sgI1GyGSDZzDw0Yq2y/KxkfXkT9lCWbMOP9p64NyNgJ2CGpJqEmEbG/Fngpft3HAaN7ynKGRFGwVjffLxSWFGJ/GDi5QsQWqSdHkvhrtBK1ZDMZ0UKSXMkDPwJgkgkGu8OEboTIvKSGH7ZDMVlBWxqVMB/ydBhIzJrYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgPH6cRE; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 071F040D9743
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:51:43 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GgPH6cRE
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g9l4fLPzG1Ny
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:50:03 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 0F6544271F; Tue,  4 Mar 2025 18:49:49 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgPH6cRE
X-Envelope-From: <linux-kernel+bounces-541756-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgPH6cRE
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 9768A41BAA
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:04:55 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 4BA9E3063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:04:55 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E403D16BAB5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A15C211261;
	Mon,  3 Mar 2025 13:04:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B866A1E521B;
	Mon,  3 Mar 2025 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007072; cv=none; b=OzhBZu3bTGjeVq4u+0o43R47bVjqOKnc3olTd/nMB69xdsdDz2KVklXiR96AXPHm4uk9qaptXD11b6Z9EPm0cjkzXd8NqHBNelFbUu+LExHmPKrsIp/CEz+myvYFLnB3ZLVQV3hDaBbihn0v9mv8IOgJJ+9NbY2S/P7/RwQd/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007072; c=relaxed/simple;
	bh=MJ1eWiZF1zNkmxOw5SUe/EJwnqJlYPHJ1CHEJLkZExk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfzliipKHexhhTVTFkYeJVkzFG5x6XV6rMiTrC5tr0InuF77reacHba8XoOI/UwCKY2so4U5Kp4OM1mT7KuOJj+zTiMo2XacDsXjH3u/tytg/dFHs8KHqlzPBwtlHtsm9qFdk/nEsgx0HHOLPsVQ7t/hCQD5U3HHlT+QUYO00z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgPH6cRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FA3C4CEE6;
	Mon,  3 Mar 2025 13:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007072;
	bh=MJ1eWiZF1zNkmxOw5SUe/EJwnqJlYPHJ1CHEJLkZExk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgPH6cRERh1HMBBuEM2ytiHoxcEIyQ8WHaLHvhXD58EXv078Ru8hCw/x65dwmTBP4
	 FnFXmWLTsOU2oI4ghoXEh/wKW6v0/L48r4z67qBYN6A3oQgbrEwpSlrM8fUdueHRWm
	 7i6xuao04uAPUVg51r9+Da3fmNWu0+Ba3hDEJWB9NoTvSSbXmsmKSHfXjPJwj5sCQS
	 ZVwRqbXN2/6xym99sAr/ifjoVnDgXVFKOvgx2jKJ/+wu1R4g/glb6BqWV38wtbCTVR
	 d+vB32cooXYt02OsyvInT9tfzxmHwfMrTt3bBR5MRTAwQuAO9dD2pTBBP6zar3cWI4
	 yIDrZdw9lr/ow==
Date: Mon, 3 Mar 2025 07:04:30 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: tiwai@suse.com, Xiubo.Lee@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
	krzk+dt@kernel.org, broonie@kernel.org, perex@perex.cz,
	shengjiu.wang@gmail.com, linuxppc-dev@lists.ozlabs.org,
	conor+dt@kernel.org, nicoleotsuka@gmail.com, festevam@gmail.com,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: dt-bindings: fsl,audmix: make 'dais' property
 to be optional
Message-ID: <174100706937.1425909.3592597206519179445.robh@kernel.org>
References: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
 <20250226100508.2352568-4-shengjiu.wang@nxp.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226100508.2352568-4-shengjiu.wang@nxp.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g9l4fLPzG1Ny
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708212.58479@s2n6w805/s/Js15Iw0pLcQ
X-ITU-MailScanner-SpamCheck: not spam


On Wed, 26 Feb 2025 18:05:07 +0800, Shengjiu Wang wrote:
> Make 'dais' property to be optional. When there is no 'dais' property,
> driver won't register the card, dts should have audio graph card node
> for linking this device.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,audmix.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



