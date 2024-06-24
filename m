Return-Path: <linux-kernel+bounces-227981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A1291593F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31701C22E40
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FBD132122;
	Mon, 24 Jun 2024 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrOHeK73"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02A4962C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265773; cv=none; b=ObMwro9SNRTegeL5+6rSaH8m/1p+9POgPbiBLqI0EC8VWwei6bVtO64r4av7COnaabyMHWLP+VgSVBTQZVY6TCgmnNgi8panZDi3pyyBsnWQgiVQHCs142Rw8bRWI1BUlqOExzisjXuZDvWbu4PDSWFxwQcjJEUB67PvDPeHbNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265773; c=relaxed/simple;
	bh=NoMsGuylpEJI82FlH9CaAKGAu0TMQ1SmZandLQUgBAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+jwnKIsWYJmLWCIbA25Ji6sJa9LXyp9gpSrDYCWMU5J5HCnOCuiv85BzXsB5TmIuJ3s27/SoSbsDEWz1/UQYKtIOkeOV1HnhhMoM1HAlDo/KY0Pb2CgSrfhIGrwvqC9zr7703LaHb9P6+uDKUPV/7YwW7W6CLjOb3E29oVwMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrOHeK73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEB7C2BBFC;
	Mon, 24 Jun 2024 21:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719265773;
	bh=NoMsGuylpEJI82FlH9CaAKGAu0TMQ1SmZandLQUgBAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrOHeK73b3yB8k38TuJJReLU6gzg4sMKkvH5ANgXzeW5/xQx0OKtFTIRbxwFtRNoO
	 qan8ddebJOC2QYDsL3T9qBd+wCjcsOBhWbvnjEiScHqaF7mXWGAz39UwPh9emChG4N
	 V6rEYXBGH9SGmbzumMZD2RPyThE6hKDvS8bbhxHdG16qH7QboWHkWjX2tszqnqWC9Q
	 NiUXQ+3dBzRBx29nbiT0M1ipYMyznkgf/c+2PwnMbN2d4v06U513MEUxequy5lNQgp
	 +FZW0mQHVDW+7GSd4eM5ruRp9CrQScW/vre7iMKGhmOeBpayFlqbUzGTSCZX/x4Y7a
	 QYJbqEVjyAjDA==
Date: Mon, 24 Jun 2024 15:49:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: guanwentao@uniontech.com, huanglin@uniontech.com, axboe@fb.com,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND. PATCH] nvme/pci: Add APST quirk for Lenovo N60z laptop
Message-ID: <Znnp6jIfcNYoDb2m@kbusch-mbp.dhcp.thefacebook.com>
References: <AFD9EEAB191702D0+20240622042108.10427-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AFD9EEAB191702D0+20240622042108.10427-1-wangyuli@uniontech.com>

On Sat, Jun 22, 2024 at 12:21:08PM +0800, WangYuli wrote:
> There is a hardware power-saving problem with the Lenovo N60z
> board. When turn it on and leave it for 30 minutes, there is a
> 20% chance that a nvme disk will not wake up until reboot.
> 
> Signed-off-by: hmy <huanglin@uniontech.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/nvme/host/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 282d808400c5..1e0991667453 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2903,6 +2903,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  			return NVME_QUIRK_SIMPLE_SUSPEND;
>  	}
>  
> +	/*
> +	 * NVMe SSD drops off the PCIe bus after system idle
> +	 * for 30 minuites on a Lenovo N60z board.
> +	 */
> +	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
> +		return NVME_QUIRK_NO_APST;

Based on your commit message, it sounds like the platform works the
majority of the time. Is it possible that NVME_QUIRK_NO_DEEPEST_PS is
sufficient for this? Or do you really need to disable it entirely? The
power usage differences can be meaningful.

Also, 30 minutes of idle is an eternity for APST to kick in, so I'm
curious if there's something else going on here or if the breakage
occurs earlier than that.

