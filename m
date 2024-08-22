Return-Path: <linux-kernel+bounces-296344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81BB95A98E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAE01F21B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D411712;
	Thu, 22 Aug 2024 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="fVe++O1g"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126920B04
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289456; cv=none; b=i3z55DrmRaxzcSX3qzSYeA+8zV06DqDBcCQZ5uw7IT6yNMjALeCB5AU92dgwNjereaF9C9hARA8a+mkJimaNs4UehoI+0waIDxXW1h1YWnw0DCemFTQ7EsF7A1dbel2NS3PQSR+lu/owg0gQSaWSGANizFMRTZCEHZDFcGAU/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289456; c=relaxed/simple;
	bh=0ocl6vAjLUjMe85M4UYlMut9slATQNpCCmfh9xaJJrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=IPJH2ofOn4tmkqFF6fQRlmQq6OmZhL4oQZzwsJ/Khpv6vORC9bfi2cUvBDGhPCKPjRaVgiuWl2KK15HZN4UtlFTWsz2BknL7BQlyyjVE+ck8k8/VCxXjQvH90HO+LWfjO7WmbJ9Uszs3JRAHxeWTGonvHz0ut5nQxZ3AtUY73x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=fVe++O1g; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4Wq50M4Kg1zDqXg
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1724289454; bh=0ocl6vAjLUjMe85M4UYlMut9slATQNpCCmfh9xaJJrE=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=fVe++O1gN9xCaszUhRvQC8ozoKjBrpPKlW/tSZCxo0BZ/ID4YMWSjJU6l9jj4oPjP
	 GAm5U4ykuxkBTIW0vQgq6dPL8Ysq1xQCKxGJ7OXwFrTiAd+ZiebcBUkce84FbAEqBy
	 fP9hj/rGV7/bDiqPuHFjz4RT9x0WQbk1kgtjrRA4=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Wq50D5qbvz9tN3;
	Thu, 22 Aug 2024 01:17:16 +0000 (UTC)
X-Riseup-User-ID: 544F8F7C7C3A49EB88682F1EC5343E8C89F0D55A160541232EC9FAD805D6580D
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Wq50C12Y3zJn1j;
	Thu, 22 Aug 2024 01:17:14 +0000 (UTC)
Message-ID: <d607cf0d-4de1-4a18-8075-d8f3fff98373@riseup.net>
Date: Wed, 21 Aug 2024 22:17:12 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] stagging: rtl8192e: Insert spaces around '|'
To: Hans Buss <hansbh123@gmail.com>
References: <20240822003156.141717-1-hansbh123@gmail.com>
Content-Language: en-US
Cc: linux-staging@lists.linux.dev, ~lkcamp/patches@lists.sr.ht,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeida@riseup.net>
In-Reply-To: <20240822003156.141717-1-hansbh123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hans,

Em 21/08/2024 21:31, Hans Buss escreveu:
> From: Hans Buss <hans.buss@mailfence.com>
> 
> Insert spaces around '|' to adhre to Linux kernel coding style.
> 
> CHECK: spaces preferred around that '|' (ctx:VxV)
> 
> Signed-off-by: Hans Buss <hans.buss@mailfence.com>

There's a small typo in your commit message, the correct name is 
staging, not "stagging".

> ---
>   drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
> index 1b444529b59c..e507593b939c 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
> @@ -229,7 +229,7 @@ enum _RTL8192PCI_HW {
>   				RATR_MCS6 | RATR_MCS7)
>   #define RATE_ALL_OFDM_2SS	(RATR_MCS8 | RATR_MCS9 | RATR_MCS10 |	\
>   				RATR_MCS11 | RATR_MCS12 | RATR_MCS13 |	\
> -				RATR_MCS14|RATR_MCS15)
> +				RATR_MCS14 | RATR_MCS15)
>   
>   	DRIVER_RSSI		= 0x32c,
>   	MCS_TXAGC		= 0x340,

