Return-Path: <linux-kernel+bounces-573293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BECA6D544
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824BC1892B11
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7A1257459;
	Mon, 24 Mar 2025 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fToEkBOA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF9257448
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802050; cv=none; b=H+kROXRQnjC/rdSiZ7OKlNaommvdrW7ReXfEr3jON1C49eT6+JXfHcuUg40e7P9tTuku82ZEKwepxUEFzpTDjX9YztEX8ca0PZcaC0yLXaejQf6Adxc1BG1u7ANanzIRF8BqfgNDszFlhAslSyWmvFN8D7fqSYVY+tfpaE6uFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802050; c=relaxed/simple;
	bh=KUqixwmO+35gYsBPPYWU1oROSkdcA9VLRLAUEx3ST9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxxujNwG3aYj1Zs2igTkcoim2uZmZfr6JQLVUBKwiExbXrENF57Z4Yrtau02+bKBSC4F5JXqfvLLpmUBqZ7KZad7rndtYq+Ky+r+YADWKuPmlglEwTz2Yti5c3fNQoKn6vLoZtzK/PDvsyn+aVIO2USd+T+5+rML4i4IfYULx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fToEkBOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C36C4CEDD;
	Mon, 24 Mar 2025 07:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742802049;
	bh=KUqixwmO+35gYsBPPYWU1oROSkdcA9VLRLAUEx3ST9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fToEkBOA6B+/Ut29QBr4OITyRoQ3XHfxV++qrtVoVMFtdaqZ15dwRmw5fcCAFjfAi
	 oUOZuQ/zSf/SNMewkiKwTqONwP+eQoOUlUU4hz5eenvSHoMfOMSfh1nEabMcclU9vB
	 xQbuwqFmevBqyfawnHg1sg8A7kt+Maq+Kd0hUsbp4t/vFsUvnMfY3OkLd4wtKAQxxp
	 BBjB2NKykr/obBR4x5MyuYvt8Bu/kwMNzykK9PyIlOm2K9tbphHGrUqIdJhVs9zSdx
	 Q0Jph1LQ+QWRnm0lti3uSBPNnxDoUd1pGfglDzgeDr7xpIuWSpzReJTAmDfqatLmr5
	 QlFC/ZVpZ421A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1twcQS-000000001Jn-02fA;
	Mon, 24 Mar 2025 08:40:48 +0100
Date: Mon, 24 Mar 2025 08:40:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: extend dma mask to 36 bits
Message-ID: <Z-EMgPg5Gp-JtTZp@hovoldconsulting.com>
References: <20250321162331.19507-1-johan+linaro@kernel.org>
 <bc3601ae-5639-4ee4-bbcb-4e39b542bfbe@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc3601ae-5639-4ee4-bbcb-4e39b542bfbe@quicinc.com>

On Mon, Mar 24, 2025 at 11:06:16AM +0800, Baochen Qiang wrote:
> On 3/22/2025 12:23 AM, Johan Hovold wrote:
> > Extend the DMA mask to 36 bits to avoid using bounce buffers on machines
> > without an iommu (under OS control) similar to what was done for ath11k
> > in commit dbd73acb22d8 ("wifi: ath11k: enable 36 bit mask for stream
> > DMA").
> > 
> > This specifically avoids using bounce buffers on Qualcomm Snapdragon X
> > Elite machines like the Lenovo ThinkPad T14s when running at EL1.
> 
> why bounce buffer is used at EL1? is it because IOMMU is not working at EL1?
> or even because IOMMU is not present on Elite machines?

As I mentioned above, the IOMMU is not under OS control. The boot
firmware / hypervisor has configured the IOMMU in by-pass mode and it's
effectively missing from the OS POV.

Note that this is also the case on Qualcomm platforms like sc8280xp
(e.g. the Lenovo ThinkPad X13s which already benefits from the extended
DMA mask for ath11k).

> > Note that the mask could possibly be extended further but unresolved DMA
> > issues with 64 GiB X Elite machines currently prevents that from being
> > tested.
> 
> could you help elaborate how it could be extended?

The mask should reflect the capability of the device. That may be
64 (or 40) bits, but I've only been able to test using 36 bits.

> > Also note that the driver is limited to 32 bits for coherent
> > allocations and that there is no need to check for errors when setting
> > masks larger than 32 bits.
> 
> why is it not necessary to check error?

The DMA-API documentation was recently updated to clarify that there is
no need to check for errors when settings DMA mask with 32 bits or more
as the call will never fail in that case. See commit

	f7ae20f2fc4e ("docs: dma: correct dma_set_mask() sample code")

Johan

