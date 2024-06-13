Return-Path: <linux-kernel+bounces-213510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7FF907640
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601D2B20EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C0C149C4D;
	Thu, 13 Jun 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdHqJdde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A621474A8;
	Thu, 13 Jun 2024 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291555; cv=none; b=iRR5+9fD9oPMt1f9kmdme2OLA1SzWhI0gmjQBPmalaNqj0pBRBBLW1nQMOFngHgTscFf78JRZrsoQltkoqOrqQpvJkbIpr7Q2Ghkk9um+MNiqtCG8NpGKQiAr9IHoo0pt/8hG5+eqCLeiO8mihAWWvvt7PDg5OdQYxbyQfPCkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291555; c=relaxed/simple;
	bh=XsF8HkAJYL9Ss7pF8HPDdQHn7zyHWQqpDXPPFItQYms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUIaExzWoiSX1u08SEbjnUonrDuy8rFvjm/J+zfy8o2SBpjOSnNvsiIkLPCiVOP5o+a34bNezFpBBv6YilgmyMal+1DwpvvKI1jAgGlf58dr1YzjHZ5dU5YAVGsMqddzxugqnbPa9vlhA4pFllaVofFGKEVt7uumEveqnG5AJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdHqJdde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102F1C2BBFC;
	Thu, 13 Jun 2024 15:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718291554;
	bh=XsF8HkAJYL9Ss7pF8HPDdQHn7zyHWQqpDXPPFItQYms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PdHqJddemg5/0l6huu8epVk4gX6SFL8oHPYXL3vx0M0s4JQUCFJbGuqIlYn4D3b9V
	 gEinFkeEJiStL58PUrx/LHjUH8U66EUpnKj4cDOqDgsTEJShTVPkrl6lHT9KvzJf0p
	 6brJt8XKlyo6Q5osP2va+dPmHErV/uaWV7jXycdjltvDFWOLLgtqKFUnueV+c+RqsH
	 oYXr1kR3Fq2z9k31FtUl5ZaLgjkkUbtQglXgNJ+l/a/sF2JicCpXDLcD6UHL0eVQ9z
	 kuRZz8b0RKpGx2NbWlZ+M/J3AMVhAOaBvVe1DQQYxYlRUM66QObOXZmcVgszwn4zBS
	 kcZnF8Wi8dsGg==
Date: Thu, 13 Jun 2024 08:12:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "=?UTF-8?B?Q3PDs2vDoXMs?= Bence" <csokas.bence@prolan.hu>
Cc: Frank Li <Frank.Li@freescale.com>, "David S. Miller"
 <davem@davemloft.net>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Richard Cochran"
 <richardcochran@gmail.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH resubmit 2] net: fec: Fix FEC_ECR_EN1588 being cleared
 on link-down
Message-ID: <20240613081233.6ff570cd@kernel.org>
In-Reply-To: <20240611080405.673431-1-csokas.bence@prolan.hu>
References: <20240611080405.673431-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jun 2024 10:04:05 +0200 Cs=C3=B3k=C3=A1s, Bence wrote:
> +	if (fep->bufdesc_ex) {
> +		val =3D readl(fep->hwp + FEC_ECNTRL);
> +		val |=3D FEC_ECR_EN1588;
> +		writel(val, fep->hwp + FEC_ECNTRL);

FEC_ECNTRL gets written multiple times in this function,
including with 0, and then you RMW it to add this flag.

Is this intentional? It really seems like you should be
adding this flag more consistently or making sure its
not cleared, rather than appending "add it back" at the=20
end of the function...
--=20
pw-bot: cr

