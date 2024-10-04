Return-Path: <linux-kernel+bounces-350011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9715C98FEA8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941AC1C232C1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7013C8EA;
	Fri,  4 Oct 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tNEi/nkp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158017758;
	Fri,  4 Oct 2024 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029530; cv=none; b=ZD3sSmuSDhu1khjPhqXsn+2p/qTro1AYsSnSy8EFpr6C447kIxXSGCGnaxypuFmiVVWj9MUAOU3y+StkSdn99XR+Sw4h9tp8LOlFecWEjbMhF5aRN1Qsvp6p6n7iatl1Lpdcbc5IGJZKQr0VvSWEJL/BM25jXZ9vx+2dVr3fqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029530; c=relaxed/simple;
	bh=27vdyBwZrOTnjtEnm92fTx/uIulW8vv6bAvMEt++eiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJtkxQXJ9VU7aGtmTtD0hFCJAb5fICvLmQ/E1Z3+yRx2zlPMVp6GEGmIXy3DejcE5pt+9nQ3ZDiGCvayLtZvvc2j11ue2qOtXHjfPPf7q7qPRy9dEabVPGKtyll7eKZdnNMxxNdzroJdsBgJYsfQrXkoq3NGApHtVKuk1SRmbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tNEi/nkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36D3C4CECC;
	Fri,  4 Oct 2024 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728029530;
	bh=27vdyBwZrOTnjtEnm92fTx/uIulW8vv6bAvMEt++eiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNEi/nkpZnf9gHaw5GEFi5YYEKgxD3JhdEcrjdkTXAI3aTIWzA2PJ1M2j3nS5VSbG
	 W9RBAOZO1Oq04gBBj5ZlLlFwdSxHLr22JwQrS/caL9wGiRqdYih7gfAHxwRqDG5YNt
	 MHrB+sxbB0zFd6cIPLMF6hV4/XfrVRFQ3Oa44zQo=
Date: Fri, 4 Oct 2024 10:12:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tipd: Fix dereferencing freed memory 'fw
 in core.c
Message-ID: <2024100444-unwound-poppy-97ec@gregkh>
References: <20240923092625.2673-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923092625.2673-1-kdipendra88@gmail.com>

On Mon, Sep 23, 2024 at 09:26:24AM +0000, Dipendra Khadka wrote:
> Smatch reported dereferencing freed memory 'fw' in tps6598x_apply_patch().
> 
> Invoking relrease_firmware(fw) just after checking ret.
> 
> Fixes: 916b8e5fa73d ("usb: typec: tipd: add error log to provide firmware name and size")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
> v2:
>  - Updated patch subject.
>  - Updated patch description.
>  - Added Fixes tag.
> v1: 
>  drivers/usb/typec/tipd/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index ea768b19a7f1..70bf8023ea35 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1191,12 +1191,13 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
>  	dev_info(tps->dev, "Firmware update succeeded\n");
>  
>  release_fw:
> -	release_firmware(fw);
>  	if (ret) {
>  		dev_err(tps->dev, "Failed to write patch %s of %zu bytes\n",
>  			firmware_name, fw->size);
>  	}
>  
> +	relrease_firmware(fw);

Any specific reason why you did not even compile this version of the
patch?

{sigh}


