Return-Path: <linux-kernel+bounces-311007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0658A9683DB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7921F227D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69B1D31BD;
	Mon,  2 Sep 2024 09:57:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EE51C32F2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271038; cv=none; b=BNjQzPEpQDlVf27B9jZM9smbkRIIAoTgLtOpPt6gZzVhoA8H/mFiM3CUoNaRIhq6Yn2zbypV25KD5pLg9EWRzMv0OBsoBabYl8TfmDuuGUkv7tUgohNPe4HnXfDiTYsSsUGQJ07OjsDTNQ4q0IKfz/1rdqJ58vOKblvzVFd3MLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271038; c=relaxed/simple;
	bh=hKOYtnnjxBSyCwbBwUKJhrqYtwX0nxFcCtbqcBOBQXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qimbpLBRsp2eaO+OqkDvKuC8VjZ/qmAfIMSVHXxatHDOWW9vdsGmcW9GsuNSfvzRkU5xLArAl1Uu5P94Md3eLkI35vJH4Qj+IvNMXrqCSRDESnVAwLhxOR7tQQoUlbFI2eyCACjEtgdr4tevAhGvBmhe3Fb73hmALMSuLh/qcp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3o6-0004xr-F8; Mon, 02 Sep 2024 11:57:10 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3o5-004s9i-JQ; Mon, 02 Sep 2024 11:57:09 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3o5-000g7r-1g;
	Mon, 02 Sep 2024 11:57:09 +0200
Message-ID: <f4df713c2a5945395bbc73d6da412d7df4a0fc50.camel@pengutronix.de>
Subject: Re: [PATCH 3/5] reset: simplify locking with guard()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Antoine Tenart
 <atenart@kernel.org>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>,  Damien Le Moal <dlemoal@kernel.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 02 Sep 2024 11:57:09 +0200
In-Reply-To: <20240825-reset-cleanup-scoped-v1-3-03f6d834f8c0@linaro.org>
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
	 <20240825-reset-cleanup-scoped-v1-3-03f6d834f8c0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On So, 2024-08-25 at 16:14 +0200, Krzysztof Kozlowski wrote:
> Simplify error handling (less gotos) over locks with guard().
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

