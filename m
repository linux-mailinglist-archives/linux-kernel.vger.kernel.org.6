Return-Path: <linux-kernel+bounces-405889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5489C5892
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6772846E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF2913B584;
	Tue, 12 Nov 2024 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYw5imcB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61423433C0;
	Tue, 12 Nov 2024 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416772; cv=none; b=hONaGfATV8XG4VSAcmwRNQM0pwWFAjng8ekEbl4Apbm1NqBJ7wf9aajuFVZUyOFWm6BFwrSa33YdoYgh/gCekE+ZJfILDqDAoGNMxFz7GU7M8RgdIABaJYIa4tFPOcL9LM/qsV8iG7TJkCQCm3Fkq468fgJui0XoTQFe4Wb4JQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416772; c=relaxed/simple;
	bh=bM9nBG1OjDCb/Ngw88/ql6ZjrXxF2rOfAhx/y+BwB48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C3/RnVRbDBnp7kVZCbEjPewl4fZgpOOPxZFnRfIuDRP/QnxtyvJwU+9xPG52catDlbMg2RIXFn+ihZs82OmcwMoGiHxOcJLLxso/qhEsu9aCCaAhuL8keK0AXn3/9wDxYJUDFsOmaWEnFfHbSZki4estyccmFYJrfLy7Y/04uhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYw5imcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4BBC4CECD;
	Tue, 12 Nov 2024 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731416772;
	bh=bM9nBG1OjDCb/Ngw88/ql6ZjrXxF2rOfAhx/y+BwB48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TYw5imcBuNLJz0eYDWuR4WtmQU+uMPZnuwBkdZ3Zdtxi4400zXf4bfAWS9UxZDfqW
	 Rta4ixJQ8WvBFv3w/eJAmoM5+NLKqR33GxMu1OWy8jM5zN67syebOoGjqpATCF811Q
	 bfs1P2mmUnTRdb/mMsztkvLSMG58Qqk4LIVlk2ZIaAc5/AK+NwTHz31iSS6RNcRpTJ
	 xcrg2pvTHD9ZNTgvJYDXasvQx0cQOWQsqZSAklmXzntfhGM3wzpsCgf5QmW28Aq+gq
	 o1D4DOKlQcliTYGwhxhdhSQK70EwCkjrAX5qK5+qGWkPSrC7xZqQEXtsw4G79O+n6c
	 uvspPaE14vb1A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: peng.fan@oss.nxp.com,  m.felsch@pengutronix.de,  pratyush@kernel.org,
  mwalle@kernel.org,  miquel.raynal@bootlin.com,  richard@nod.at,
  robh@kernel.org,  krzk+dt@kernel.org,  conor+dt@kernel.org,
  shawnguo@kernel.org,  s.hauer@pengutronix.de,  kernel@pengutronix.de,
  festevam@gmail.com,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  imx@lists.linux.dev,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/3] mtd: spi-nor: use local variable for struct device
In-Reply-To: <20241111111946.9048-2-tudor.ambarus@linaro.org> (Tudor Ambarus's
	message of "Mon, 11 Nov 2024 13:19:45 +0200")
References: <20241111111946.9048-1-tudor.ambarus@linaro.org>
	<20241111111946.9048-2-tudor.ambarus@linaro.org>
Date: Tue, 12 Nov 2024 13:06:08 +0000
Message-ID: <mafs0frnw7gan.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024, Tudor Ambarus wrote:

> Use a local variable for the struct device pointers to avoid
> dereferencing.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

