Return-Path: <linux-kernel+bounces-226518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F27913F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D072B21701
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4C620E6;
	Mon, 24 Jun 2024 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="meGrzdiu"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E810E9;
	Mon, 24 Jun 2024 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719190361; cv=none; b=e4d7tGeFCQvjkK7BFr3zBzv1LEvT8MOAXH1J3ojrui4sIfVR1XjhDvDEqS1NDCkD0u2xVx3oT1pBvVmUrXmaGVx17abVy9CTmydj8tXKaH8THCrMjYRpUMArjWyGhd0IIpS/2qr29WqsbgOt4jl2XhklkKPud+fbSl+fGVCGCzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719190361; c=relaxed/simple;
	bh=xFnTlCEXYNUtSI9aate1sM51RDE4KwtaTjPN+GQK0Qw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=REfrY+6Xe2iKwir2T+a5t3pt3Wcv0HuXVeefpsiKN1PGyZQxy9I2Urtu4J7IQbj/UM/RwSMGMmhJS0/E7G/uDKHh0ZYGsxjUz0NAHZOxvD8CTVQb9U2/Uq+GKLBSQdLfUbKHCfu7THRv1FUGQRwOhg0X4YNtinbZQ5YwsqcASr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=meGrzdiu; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-79-194.adl-adc-lon-bras32.tpg.internode.on.net [118.210.79.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8D5012009F;
	Mon, 24 Jun 2024 08:52:34 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1719190357;
	bh=NQqL7DsqxZzghaWKR/8rkG8Pl+N6DaWnsqVc3zJk2M0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=meGrzdiu/WAEEFAf5g1Gp251Pa8oZo7y56P+pBNGGYEQSlGxKyJJzf4Ft5MxIPlTL
	 56x9n73PsCInkrlWhxqfVp80Zstmo8KnP5PhseWejB7r9NUrgWxP4wFLm9d5j7fFNm
	 ZFIq+PeRz/h4T8C5QhdglMBfj6Hp9W2+on0+14vfcItCCLGOTIAHiPF1pA3JKfKmWW
	 0bwI5xL0INEg+H+mV/YGGS3Em/HWBF/ZKylB9YkjHp5GJLWpxlt+INFsk8ttNzvbnt
	 2XSdB1LCrcEC2+yLkX3bhU08x6JZ1TqMrdv+62TALyj+TmzAKNfvENO0vx/kiZWB0A
	 P+qptu4/hC2XQ==
Message-ID: <f31f59cc4381a41c57b94d10560ec2a7356f8868.camel@codeconstruct.com.au>
Subject: Re: [PATCH] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ma Ke <make24@iscas.ac.cn>, neal_liu@aspeedtech.com, 
	gregkh@linuxfoundation.org, joel@jms.id.au
Cc: linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 10:22:34 +0930
In-Reply-To: <20240622095618.1890093-1-make24@iscas.ac.cn>
References: <20240622095618.1890093-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-22 at 17:56 +0800, Ma Ke wrote:
> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.
>=20
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc=
/aspeed_udc.c
> index 3916c8e2ba01..95060592c231 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -1009,6 +1009,8 @@ static void ast_udc_getstatus(struct ast_udc_dev *u=
dc)
>  		break;
>  	case USB_RECIP_ENDPOINT:
>  		epnum =3D crq.wIndex & USB_ENDPOINT_NUMBER_MASK;
> +		if (epnum >=3D USB_MAX_ENDPOINTS)

Shouldn't this be `epnum >=3D AST_UDC_NUM_ENDPOINTS`? Further,
USB_MAX_ENDPOINTS doesn't appear to be defined here?

What steps did you take to test this patch?

Andrew

