Return-Path: <linux-kernel+bounces-343231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C9C98986A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34009283008
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D785C17E918;
	Sun, 29 Sep 2024 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CTj3BBL2"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EAB17E00B;
	Sun, 29 Sep 2024 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727652587; cv=none; b=EY9EpRapf17vwbokUdrbTSK5rs+nO8ASais7XzXo65WWFJ53JaPxVaewaf77/e4XHGEHWMpg28wel3j7HTMawUjl5b6yKdjxAlEkh7Sco9tQVfXyqlUV4qBcWX0zl/txD8pAe33rtRN0dQwN+bMRF9Ct3A/vQ9eJmaObUhabCPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727652587; c=relaxed/simple;
	bh=xSpe1d7cQVMTNSIqoym1nDp/5/hAhTRAAuBR8M6wIKA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rAbN/c8RwIzsoLC2tOoHNu9Bpwu8sMb+naI3BG4XwHZ763qeQqdqNuxiqB8T3l/TBkDWCANikbcDrPhkvLWM59pKjncSjz4AW4N/DUrTW0AEvPBDc3qzvSJ8Zj4gG1r/7Ln/x3VmW5w6aQYgBIyuZhlAEI1KY3Aqoi1kNEpuiBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CTj3BBL2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727652575;
	bh=xSpe1d7cQVMTNSIqoym1nDp/5/hAhTRAAuBR8M6wIKA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CTj3BBL2f55wdDTXiZktnMK3dqSnOUZ7VnxaXoVQw6BD/HL8Q+Youfoqf29Dgn0XR
	 y8eYvQ2Yh8uZ59+02zUkYEhOcrdYtshyUcQ3xPm2hPaCFN0reqapLHKDwo3Uvgx36M
	 6LzMUte85tIRNiMS8rB86VYj/4quaCYpOjN6Zu84V5efLu8eVx8iyqeg/AdVyMB71m
	 vw7PxLGyzBKRRIH+j6gIlQ1Mt+C02diAf/KE3Ar1jyVvg1e7lXoRqlX39sq2V0Yxms
	 J4nmphqq9ZBoNWsP/g2Z9X9kWJgL1eaj9OX2zhCsU2EkAUvhGwvg/4xfy2R7Q8hLgi
	 CUy+mifxz5qeQ==
Received: from [192.168.68.112] (ppp118-210-187-56.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.56])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A1CC06511E;
	Mon, 30 Sep 2024 07:29:32 +0800 (AWST)
Message-ID: <d63ce770e3f633292b771b46a45ffb46a70e5521.camel@codeconstruct.com.au>
Subject: Re: [PATCH] usb: gadget: Add check devm_kasprintf() returned value
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Charles Han <hanchunchao@inspur.com>, benh@kernel.crashing.org, 
	gregkh@linuxfoundation.org, joel@jms.id.au
Cc: felipe.balbi@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 30 Sep 2024 08:59:31 +0930
In-Reply-To: <20240929031423.40630-1-hanchunchao@inspur.com>
References: <20240929031423.40630-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-09-29 at 11:14 +0800, Charles Han wrote:
> devm_kasprintf() can return a NULL pointer on failure but this
> returned value in ast_vhub_init_dev() is not checked.
>=20
> Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

You should consider Greg's bot's reply to your other patch here also:

https://lore.kernel.org/all/2024092910-mobility-waking-758f@gregkh/

Andrew

