Return-Path: <linux-kernel+bounces-421136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF3D9D8730
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A56284F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E59A1AE01B;
	Mon, 25 Nov 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzJHt4bJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013319993F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543034; cv=none; b=jQ7dA6ivbiCLdL+USc+oyVFAKOIUaTwnGvKFG0YCk+zBzgt+a9lbPj9yya5mZHukxy7xX2g2Y+j1ADk4h2XEZC/m3whuAuBtgy9QYtttzpsLNTKAKihwlvPmvFFXbEVsrNLvBTmKEFM3gAkcyv3afkyW/qK2AVnzEkTJNtfeG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543034; c=relaxed/simple;
	bh=+FdWbMF8ffqZ7lp6RGXaARc4HmHv7Xcqbl9/GJNnDn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jgHd3K1FChdUEeDRj3pMWwkY+xFWY4J69NvvNMNfQQROXyK1zwOJMQ0N+NbZtexCXKjhodqJYW7WSXKuuPAGXvGQ9XrUe79Ig7JDMUqvf9cN9WU4C9UahqHfk8PsBKcIm65KjKTNaY6auL+lgqtkcaF8ButDwhSztcSFD2LrFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzJHt4bJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995A0C4CECE;
	Mon, 25 Nov 2024 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543033;
	bh=+FdWbMF8ffqZ7lp6RGXaARc4HmHv7Xcqbl9/GJNnDn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kzJHt4bJW2mqFV5Gf5iBuSL6+BstXQA5Rwg32GnHqa9HQuRN8w7QEwNO4iGvwoRf7
	 +ZUv4NtluZ2X9lP/PAVzkf1lZQhKHtEeqMmOeUZeGVoMwxqCwh7S019fRZQFkl2iFS
	 SXhk+az+xKaT+IVttqyuUeaffSt9FzQKQvSjWBDNQx0sJ7xa2fEQR13Fxslm2QVWNZ
	 T8jUsQ+2ROF/Qsmhh9bjZhik+qVhmk/Bqb2fTx3eqo4w48DGurC5mcw/TXhXkA0KvF
	 WHi8YqjSfJpo6ILwxyXEJZgJaJQIib58YEyFCe1ILZsGGq1RYMu6U5waspJ3jqtjYe
	 GNDRDqet1EQPw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: alvinzhou.tw@gmail.com,  mwalle@kernel.org,  pratyush@kernel.org,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  chengminglin@mxic.com.tw,  leoyu@mxic.com.tw
Subject: Re: [PATCH] mtd: spi-nor: macronix: use nor->addr_nbytes
In-Reply-To: <20241111113609.12093-1-tudor.ambarus@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 13:36:09 +0200")
References: <20241111113609.12093-1-tudor.ambarus@linaro.org>
Date: Mon, 25 Nov 2024 13:57:11 +0000
Message-ID: <mafs0mshn5sco.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024, Tudor Ambarus wrote:

> Use the nor->addr_nbytes set by the core, we shouldn't use
> magic numbers or states that are not tracked by the core.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

