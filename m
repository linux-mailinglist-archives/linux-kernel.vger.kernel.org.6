Return-Path: <linux-kernel+bounces-531061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EAEA43BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CEC3BAAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109F325D545;
	Tue, 25 Feb 2025 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XY3OmHW4"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3780199931
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479212; cv=none; b=Z2KnowWe0g8oRqF28+l7VjWITodtH5zol6p7ZTRHVBKiKeHrjeAzbSDz9KJkwry+0+4T1BLTdjB72xu/tcJ3oHBjQX+iZt+GZGrl11Fa+UGLm4qbfIvBXyXALsIDIRYhTQWNBggFiNrdqwR/z7fE50etdZJaa94ONtAv/VsWDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479212; c=relaxed/simple;
	bh=j0gOXPIKGBR6es09SS97gUwW35x9J1LC+Fhq/mqWwsI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=g7fWw7LkUTg6EMQZCgc5eJEoqI/+QdrPCEHVnwxUp5st4hud58H0GQIbS2jsx1ZSfpH+k5g/+8/Z2rYpjDd0egBHfljX9jbpOPSPlEr7W3CRYihU97bQlMxeh87UONY/ujRsrzQWhNNQ0kDV8MHoYx3nYn/WTDfb5uHi/30aeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XY3OmHW4; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740479202; x=1741084002; i=markus.elfring@web.de;
	bh=BypS39ZRkbVYHg9KLMo4KejA7snt9N8vXE+PW59GqWg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XY3OmHW4dF/XvVkKqCgeb2gYtnYoryKMu8/sKfnb1hD5CTdSpHVRI99aDxN+J3cM
	 ICtj+nooEXckiNAp4Ug/guhTOAetM8eBJbqaPDqEx+KL31HG67HuKX90GKd0Y37tP
	 ER6gqPRoCsa64QNUl9kv+wsJ9d6gzQnwWxE1EGI62/Yj+mnmX95B/asz29UmC3U1a
	 svAZv3uh65DUdXe8CJt4r8ycCiePKGDU8YQjB+eQej7lyfhxfoCmgN6wH4BBNKQrd
	 ZlckvpLs3YYpNuTdNU13rH7n51aoxqT7WYFOCP8a6R4aN4kaz9r8fyMm9hHKI6X7t
	 6x4yflswhs4bXgF37w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.36]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav2X-1tBbOD1EDr-00j0g2; Tue, 25
 Feb 2025 11:26:42 +0100
Message-ID: <0b18b6c3-1275-4560-a67d-a15382867954@web.de>
Date: Tue, 25 Feb 2025 11:26:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Fabien Parent
 <fparent@baylibre.com>, Hsiao Chien Sung <shawn.sung@mediatek.com>,
 Pablo Sun <pablo.sun@mediatek.com>
References: <20250212100012.33001-7-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 6/8] soc: mediatek: mt8365-mmsys: Fix routing table masks
 and values
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250212100012.33001-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EzHIUmeGE235QvGYzbi8u2fipYppf2iascydP1d2ZMQGWjfBdEw
 r/31IQKNePVtvPRbHYzY0DmyveIby3lLsyhlqWdT87gfBTxPTYX5IDvTjqTjLrraKKl2tSp
 xccWxhMo9iNLO0njR+spW/XBP0ibPx4vhnOxWbAU8pbE+ImLLQc+NBJdkip4SSrusL5OJsg
 j0BoGGwoSt+CW0RjUVUsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IzFamMO3EyQ=;fxzPkjtXifCI9ZLB6gx+AssHT9X
 yCQqovvJxnJx/kcl/8xnDQVN7YinmABdSvQTx9jvKCyugxduK2xwKbkCKSfjkFCZPi7W7/H48
 Wjw/48Bm6KUUdN+cUZ8wh+hKGaQRZkheYxjJdoqQQAwf9p5QxGKEu/vlzo8P316EqQyzn6MFZ
 nliBZ9czsXg8/vOOkuoKCHqAecgmcQ70KT3IJcWzgXizjeXUMNU1+8FN/vmKBhNIgw0seXTIN
 o60lGfpCU1iqUqntSitw9pDmut92ebiHCVglsK9LHtOFRFE206Q1Kdd3W/S3e13lazowOFC+N
 b6+X3nX0BaVp7PCcTtY7Zz4aHbmHE3PgWIQuOsp2Us2wUClwSa2Q1XQ0D9w618EKUb5wuE2tY
 pQJ/yF3JnLCvFAs8tvCAjsubU+H22ZbWE67I19qlrvn2XpUwAyUPZepu2k3IMeOnnJJahaVnq
 lvUHS5Kg3TyNYSSXds+yMwjgkvoVL7F/8TTXYrqY7v2IHf7fSOpJTEFr6jvZoHFR8vDjM01L8
 TT2bwfoC94qoYKE7hptP5T53YqkPRm2w+NMKDPp0EX8dHdg+MvwJGL8Wl2DL7dotXENV/22vM
 1rYymPwxFl2b7g6BGxTAv6bTGpe4QZxJkh/V2V00E8QlNN7DBTb/2p9wkwtu3ffz3qA1X2MYT
 FDxxw/jvJFaKrapzD/zBTS9TtOuUPnt5wQVeutRCL8kiyhN8F50X6nepyJ1ZJa2pfHs7t6KlI
 TGgFICeo9pqJPmA7MpINsejj75dM09210Pks/WkS1f7dzBXotb/l0q1RI8m6PRRs56r8msvQw
 m4k3qPmBvSsUx9ZGQG50Ohvnagom8NBUHXmYfIDXLiMB5bCSEQt0W8DrQnTC5dWwVRT6PE9sf
 ZozUbkQpHd4T5U8IFCGAxYE8fJdTNYdAn+UpfnYyhNlKv/j2H/rPKynkRCjwklX/mUOO/xXql
 sNeVAR+jnJw2XW4XqTz24MM+xD5A2dJWMf3ui59Hqwy4XImbaFuXQ8TFXbSeDdx9VF3mULHAJ
 K2YTp/bccu/KSjaE+mveR2FpICPWhSHOvdWQAziuirUYcEqR3Bx0CjeWPAfbUNz2/0CKmqH+z
 9FgBL0FluozC5B/JhurkIa5oyZvYRBKF5lmT84xPzTcxbcWqKbCQ7dNql7bBmSh6yxXh8EAtb
 yqlfT1b04Cc/zHEeeWaG7XN9M0VwU5cIz5vdfsBpzRqEwcgDokpThcNRj3Iz2afJ6YIhM/yuM
 hSbkb18PHYvzSYLpZqZgs5p4xhr17gDaMWHuj6P9VMClPUBe0C4rD7i3WGiXQa8X5xMtBJNrr
 7OIFc/nWt6F+1TzDO7jnV3bSlsxmu+bQZCBqqDW0gXO2UW6y4KusWrq3DpN5hvjJy7A2+yd6E
 19/OQUiewozC6iM5+9qmeVm/011Rav2yB4YTXeAO3WJ1t2RDFvZ+vK5uSeRtily+sTUisBLtC
 Kx/2zIH5IVkgwozkYMo5w338kk8g=

=E2=80=A6
> While at it, also change MOUT val definitions to BIT(x), as
> the MOUT registers are effectively checking for each bit to
> enable output to the corresponding HW.
=E2=80=A6

* You may occasionally put more than 59 characters into text lines
  of such a change description.

* Is there a need to offer changes in separate update steps?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.14-rc4#n81


Regards,
Markus

