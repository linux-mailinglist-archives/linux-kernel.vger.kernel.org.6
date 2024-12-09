Return-Path: <linux-kernel+bounces-438376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C789EA059
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8711667E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B919B3EC;
	Mon,  9 Dec 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctx+0Jzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D1F199EA3;
	Mon,  9 Dec 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776627; cv=none; b=Ehnw8zlVCoXxuG3LY+yPPmAXAVPBJetdmNeNYC861EyyoJU3NL0zul1Xk/Fekz045ByL1G/QybgKxE8FPe7GJv4xc+PmoVLdS1TzBUiVTx9lEqFRKQn5b8QOsCXVI6kRIErSkHaZmnvY38b5S26g1ZM5IdTITlNKKeHfEgZHVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776627; c=relaxed/simple;
	bh=vq2RaFKA1ZxoTyMKnkiNgT19gJJywdNSTlLNMy0BCIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deJnhwe472+xrbkyAQAlYOF0VLNT0/Hhp07M8stp+8tZfLHO0o7QoEkNhdS7r9JCaokVniSW6BYHtoqVmWrcNDc0DC9ooqhdR1/qLa1XRU89G2SzrNNM8DQquqGtBFp+5hTFy38DLsh8hC1J8SwVUc/jVCBMfUwTY8g/QPdvoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctx+0Jzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F090C4CED1;
	Mon,  9 Dec 2024 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733776626;
	bh=vq2RaFKA1ZxoTyMKnkiNgT19gJJywdNSTlLNMy0BCIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctx+0JzpqG5XDuXONPCXHmHjxt07PadT+D+r1K2tK28K/u1I6Np+krw2dz4GzIMLb
	 jqE2bBhne4KK8PsDjPgKvne/i/ifHY8PW+h3EoYdqTiMpY6s8cba3MZVbl242wbYas
	 7AZuHvHFm5q9qAEO5zqDqkArjq8ALUtUfIA8wMtNeEtlpSmmaX8Irwq/vCtxKfZ6Jp
	 7Yg1vft83tp+DcvcwmVnlTXx9/uTCwkErsgiR2oPjyjqJhNV7iYYxuuqcYiHipA8KH
	 ++Z909TcamOq8mueqe1Sog6oP0XloRFtrKgnzX4dwGYHC8UEn1z8LruYGYwRErD45U
	 gArMyXx6FCZjg==
Date: Mon, 9 Dec 2024 14:37:04 -0600
From: Rob Herring <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Leif Lindholm <leif.lindholm@linaro.org>,
	Stephen Boyd <stephen.boyd@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 06/10] of/fdt: Dump __be32 array in CPU type order in
 of_dump_addr()
Message-ID: <20241209203704.GB925532-robh@kernel.org>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
 <20241206-of_core_fix-v1-6-dc28ed56bec3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-of_core_fix-v1-6-dc28ed56bec3@quicinc.com>

On Fri, Dec 06, 2024 at 08:52:32AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> of_dump_addr() dumps __be32 array without conversion to CPU byte order
> in advance, that will reduce log readability for little endian CPUs.
> 
> Fix by be32_to_cpu() conversion before dump.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/fdt_address.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob

