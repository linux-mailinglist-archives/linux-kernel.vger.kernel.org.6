Return-Path: <linux-kernel+bounces-223471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7391138F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FEE1C21920
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71978C8C;
	Thu, 20 Jun 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="k/jVziH/"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E128C745EF;
	Thu, 20 Jun 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916138; cv=none; b=gQ/rgU8cFLiXLtKmc4y5+KA/TNWMubhd8jAwNtD8RPg9rc8ojg1gP05nUdq9CntmKEd35yJiffZEbgDtjyvnt1oZsfR3YJtKKV2r2+eTni+W4RRTGd6i2X6qbpHZZeu8q+/+z1gAUI4kjdHFIM0kwysha7F39IZTkHv8aEb35wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916138; c=relaxed/simple;
	bh=DrXA93yem7kpSAQKXAZ3duAKOyOncZJfLxoceIbKyEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaXF4ROcoO+Oq8EXylgfnG5Et/K3W95fRlxYOvlYQUg7RBq18FjUoVfa4fs27QtPxtFTbTMAUHUIqA2oL0b5wKEVca9wsP68z2c3ypp4lMbcDqqwsrH2J1Y/udbio4iEbpjmnJBp1U1xqXhR3eR8UxPeJby6m5grwWGr0Y7AEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=k/jVziH/; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718916126; x=1719520926; i=wahrenst@gmx.net;
	bh=EG3q4S6KfzEyj8HzO3hFQtrkMippDMNTA053axxrKEE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k/jVziH/A9lB9staHsYGtiPPbPTqy9iPZ/oGYX+n2Qhlz19VheB19G46SOgTiyc4
	 nQ3rg7VQaahl5rXosNv11Id4LGpENZpZeQyCBZC0SVRse0IgHjQt4jlwMkE95jFT8
	 5he3w+3tXKjMxbehKd7mE+YlHkWxnOt4GjlnZpZZ1rptzPZNkhFMqe+vjzfN4KVof
	 8mjVIO/wKdnogm5Je8Yfx5DtD7XylKeDLWp41oqddyURYuoCwIJVjw1umo/8Yt4Ar
	 9CWYLPAzMSxbnQym4RLvhDLW6flBkBNuAyesaLv41OH3lASaylEsHutAvAfxQHXdW
	 /BTQvI0M3ch+Tfv2ZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1sXEYT3EmN-00vWej; Thu, 20
 Jun 2024 22:42:06 +0200
Message-ID: <c4c9f013-3cff-47dd-9adb-76b30925d8c7@gmx.net>
Date: Thu, 20 Jun 2024 22:42:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vc04_services: use 'time_left' variable with
 wait_for_completion_timeout()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, linux-staging@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240620182538.5497-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240620182538.5497-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/PljUOGvJb5w8aUzifp/ONdkuICeeisq9ZwvMRafKV8lcmjZWFX
 apZF2FTuaiktuGVagxQwkm3/aoMHdH62lGFaDIIP8ciq1X1KpxcSCa4BDGPKzPaLV5nKgdM
 L/2sTE6WY4PgRgDHno6GcaENyVtdIfHtfubjy6eGkSFKxtXapAWPUwGXzwk4xwyALLbCiuC
 ARs4SZDufYA0dB4SfOpkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5ZAmFN1SBZY=;AGP+r+deZj0yLQcTBNsKBn+fj+n
 83I5Kx1re2qxug3jkU80zRLRynjfqUiaWiupb9zcB9muGNjc4dv47ZnkV5BmiE3ZHHp9Fcgd9
 aLkp6NgfJwiS5Ha7SWY9c252mwTEiYhdLL9O/HIT2VQ40XgA/lbLHA+NGJihuYrq/W0/v+Pfm
 V//h6sBX2c1zUgMWUwWZnM24iTdVSlGwM08wusOoP9WtfiPGGaHs6OHOdsUON6S3oVyf7nlHO
 W+U0+jh8U99khbKngdZYNSeIeEFWOoC02Zh7EvyP1wRpl02vD+irl5bafiBb+YSOh7J4ooKD4
 tO+LCWQK2PJPnrin1s1x/P4gcdxiNfj5TpwfAH2n6slx2nIvpemClP2AYKoFmlf0qAUJOsHLq
 7aN6BMQcccS7s14hIVMaPFSY1QNf7gtok0GnhCBmLUL2Co5VX0MQ0uDHfFh4WbTtKd5nrmAFo
 FKsk8RlinzAUSFX+leUbZm0rh0Btvzb6SB9z6k/WEVccPTYiCC+hFh0LaQSFzlPhd0AurRnY4
 GSOcUNruqXvxyGUjtPe7g7o5CV145tF66sMMXVNwOxFMwk9WXcghkg0JWL6XOWtfxvg8QHvH3
 qhkwu4nwQMlPVBQZi8vpEkwfA207KBjqG+pykswt4HfKpQVtuy+hNIR7lsu/MG50zx2LCDfje
 zrAr5VhZr2Y68T3+Qq+XYEUkmMsNnE1RhJYVJasl7cLZc/df4o28vHyXa/c4m/4HaxPhUR+cy
 jn4Oc8GWcZJf4I8y4ji8FKpNTdn1uSIAsn3BOimK0wPul0SsfnY7mBev9ACd+uzGEvGfAD5cD
 3ZWhcq6U1g7xEF72bVXUJU5M0DYKsATQNueJoEuuDVMgo=

Am 20.06.24 um 20:25 schrieb Wolfram Sang:
> There is a confusing pattern in the kernel to use a variable named
> 'timeout' to store the result of wait_for_completion_timeout() causing
> patterns like:
>
>          timeout = wait_for_completion_timeout(...)
>          if (!timeout) return -ETIMEDOUT;
>
> with all kinds of permutations. Use 'time_left' as a variable to make the
> code self explaining.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Thanks

