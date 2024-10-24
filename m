Return-Path: <linux-kernel+bounces-380295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60BB9AEBEF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6674B2852A4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D991F80BF;
	Thu, 24 Oct 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3dhrMLl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95D1CBA17;
	Thu, 24 Oct 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787110; cv=none; b=CFC1ku1msZ9fUe224FYjq9KqCoTWf91kUWiiV9/jc0uVd/hn3m/7zic/uXuToSXJgV7Wr5mKoT5kBd9TEAYa3vtx9oZ4NDnRfauCOuY4u9X1Huvu+HptMaWmzzWaZJb638Tb/C6DF2BHFtgMOCLe32GhVHGZP4bxKH7W8UiTSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787110; c=relaxed/simple;
	bh=GzICAYh6bjGfgV9C6PPyoTkjloSrnHwuu9P94evgThI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzfT09XECC8E6W9ldab3CgOKEx4PeytoKrdTiAQQ6x6GQ1jXaaWDu4VEfqbOvtiDfRBaAVdf0lf+vbtvOTIfJKvinj3749lURH9TIZcOjQjvE52G+gMIyoh5zoCelOvb9xqPIhV2AVWVTO0CAz51Z1iiVOwj/+kdXKCQws+F/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3dhrMLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F03CC4CEC7;
	Thu, 24 Oct 2024 16:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787110;
	bh=GzICAYh6bjGfgV9C6PPyoTkjloSrnHwuu9P94evgThI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3dhrMLl8apWp+gJODKUv8cMryScIDXECj9ASGjjBH2ZfMETMd/mv6jmuh6vKxS3b
	 Gc6yKU/UUOR7jibYD6wKhwMZWRVO1P6vQGeLO3vNbtGsKe2kYAgGWY6PJoNQQqhZMQ
	 VmP0kQ8CkO39A6usjVqBN2y6Ik0NGeTYYq73Q45PbbjH5fSs2lDC6bHxYZqwJtc34+
	 apG5RE5qqaTGo4I90mhEeFd3BwCnesKOZxuGtb5RKUs+ihomfX8a3BUsz7hZUQlpuB
	 CwfBAeQMTvkXxMsGuIhYVtxu9pwCtBfgH3KvJZJJ6b13eKG+Oz3TpcnorbUudXf3SA
	 RhoUvZ4NPRszQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t40eL-000000002ap-1a7L;
	Thu, 24 Oct 2024 18:25:25 +0200
Date: Thu, 24 Oct 2024 18:25:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Route pcie5 MSIs to the GIC
 ITS
Message-ID: <Zxp09Q1DPYf9BK0z@hovoldconsulting.com>
References: <20241024161814.1827514-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024161814.1827514-1-maz@kernel.org>

On Thu, Oct 24, 2024 at 05:18:14PM +0100, Marc Zyngier wrote:
> There is no reason to use the PCIe root port widget for MSIs for
> pcie5 while both pcie4 and pcie6a are enjoying the ITS.
> 
> This is specially useful when booting the kernel at EL2, as KVM
> can then configure the ITS to have MSIs directly injected in guests
> (since this machine has a GICv4.1 implementation).
> 
> Tested on a x1e001de devkit.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 3441d167a5cc..48f0ebd66863 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -3281,6 +3281,8 @@ pcie5: pci@1c00000 {
>  			linux,pci-domain = <5>;
>  			num-lanes = <2>;
>  
> +			msi-map = <0x0 &gic_its 0xd0000 0x10000>;

As I just mentioned in another thread, and in the commit message of
9c4cd0aef259 ("arm64: dts: qcom: x1e80100: enable GICv3 ITS for PCIe")
this was done on purpose as

	PCIe5 (and PCIe3) can currently only be used with the internal
	MSI controller due to a platform (firmware) limitation

Did you try this when booting in EL1? If so we may need to enable this
per board.

Johan

