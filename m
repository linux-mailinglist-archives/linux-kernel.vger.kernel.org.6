Return-Path: <linux-kernel+bounces-545085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178F5A4E8D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DBE424F41
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D9A2D4F8E;
	Tue,  4 Mar 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jC3FiKE1"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969952D64E3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107629; cv=pass; b=LiVyYoql/4DOmqObfwXVfRVP7CC9SL+Et9UA3LbTFAxzG9Tk9YNFqXDn7IArHQKj2A8zy0xeZDNY1cjQiI2AauWjesIgzs8q/zR97JS7Yj+ozuVS67ognu6TmlgJPC/qKVYPlVTDBEoBfGBWZyGUz1okvykQ9WngSqjWKzrCpQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107629; c=relaxed/simple;
	bh=My0FAg9ECNGTXiPTr8yp95tKw/PNZxWh3Wz2mbCwVSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz5WdxOe19vAYLxUbRUvxhIh63FDyygUsXYFIPkGJhE/lVLyhQ/mrnRSkxP6oYfBbCs1UFxiHJ6ilnPWMYCknlxejmPG71CU0B2KjYHsFYEPWK1Y5Aji0BUF3sbw34ChTzyHez7G//7Q2YOro0NGo0Z7e0TwKEAXP/+OYad5Jmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jC3FiKE1; arc=none smtp.client-ip=212.227.15.3; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 9A96240D4DEA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:00:25 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=jC3FiKE1
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dmw3MJHzFxZG
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:46:56 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id AA17A42746; Tue,  4 Mar 2025 17:46:50 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jC3FiKE1
X-Envelope-From: <linux-kernel+bounces-541552-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jC3FiKE1
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 327A5427DF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:23:16 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id DA1F32DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:23:15 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF8F16D7A0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7ED1F790B;
	Mon,  3 Mar 2025 11:15:47 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144321F1921;
	Mon,  3 Mar 2025 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000544; cv=none; b=O6xOxIllun6LKZJJHD9Gno514rCmF7ipl11NKV4H8uOc+CI4yLabjUKuUIUZBlGt9g9OhzUKbZpPLNL1tuDabhzp0k0GjSCC69h6+G0sCdWibPyg+wBpbt4NiYoYIRBWQ3ZI+AIFzEQOxTzeo2eQw3hZer2/jWr4F1cCTsNZ9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000544; c=relaxed/simple;
	bh=My0FAg9ECNGTXiPTr8yp95tKw/PNZxWh3Wz2mbCwVSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GX//8KEh/jNiVJL4chIwr0CLfuFxlOr9H0amJMZm9/VYtEI9maDRcmHY2IwBzlywKcDUgAazraKRE4UaBn8oS9Ypd7/N5ki3Opj+P1wd/XX/vByZUJLgeRCcH/8OV3boacDWFusvcVDcbX75Dfi6XCC82eLuc9/tu6gng60EmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jC3FiKE1; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741000527; x=1741605327; i=markus.elfring@web.de;
	bh=My0FAg9ECNGTXiPTr8yp95tKw/PNZxWh3Wz2mbCwVSE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jC3FiKE1zwz0jH5Cs5wJHKsMGoy0dqE9amlLs10O3SwZB/FWdFjB9tSe0wJo4tsf
	 LJujFIQwUlJtAvjP5e4IhYpG46h9GTEeMKngt88WwHnPoxBilG8zm3+hkx53capMF
	 FIC0uDjHF/1el6X2TFLPdPuIQ1DJs9Lym2QFRu+ZlbOr8mpDJdrWpl5o4zY9gAF2o
	 YHqD69241/TPyrmkI+ZMEmfYykbYlvIPHRpcNJ2oblmaZYfbxcpSfHqDTKRzP0/SE
	 +Q7NFKHFaU4R11+vL9f/oudJ9x0zmbVLS/PWZk5lwXk0BaZiYtd8yK+uZmqjGPvvL
	 lyWRNaPLQ/0VZVQ1OA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8kX-1t06sA36Jl-00yCfC; Mon, 03
 Mar 2025 12:15:27 +0100
Message-ID: <10afda2a-4c52-47a8-bdfd-4bfd7bd9cb34@web.de>
Date: Mon, 3 Mar 2025 12:15:25 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mtd: rawnand: tegra: Simplify maximum determination in
 tegra_nand_setup_timing()
To: Miquel Raynal <miquel.raynal@bootlin.com>, linux-tegra@vger.kernel.org,
 linux-mtd@lists.infradead.org
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Lucas Stach <dev@lynxeye.de>,
 Richard Weinberger <richard@nod.at>, Stefan Agner <stefan@agner.ch>,
 Thierry Reding <thierry.reding@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Qasim Ijaz <qasdev00@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>
References: <d564cafe-d45a-40b5-9a91-a2e2b97c80d6@web.de>
 <87pliy9yyv.fsf@bootlin.com> <0193ac44-e858-4aff-a50f-dd95dbf3de5b@web.de>
 <87h64a9y04.fsf@bootlin.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87h64a9y04.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R1exJjdCQwDCi4tP+5q2mVtAJq6NaltfMACf/dznh3c2rORKP8d
 EjjNDUoCoUYK/hlQ18JBQvxCEai4B4jLmJCvRepLp06rXRRscEQnIunGbqWjJxlGdOa55J4
 th/oQDxXsk4Ga0eZZt8pvMIhamehVGQ6jakpIypJoEFdJhNHSZM2IKB5F9y9xhW0XqNl+wr
 iANKn8LFoBVo8c9eXiw3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9aGubQHfLpA=;X2oznE8qxdpeeK7RDktpeZ6VenX
 SY4S66SxXgz1fvqAzrjZGKCbALvFIOTlSeOrGRCklYGiRfYzeQ0gFJlv4KHA7JQhzD5r0BI4v
 Wz6N9/dPehIzl9RYlP0N8MAHti+KYioj4EYAKcLFjqvYSHmRmDdHWW/ilhqS+HM0q2ZMAEZja
 Q4r17eTq9w+q67VRYXOI5wbP5y09e79a/YdTMzknp/kU2IWg0DWNvmEPdBFPBlX+6dOoQgZRI
 czD7BgbMdJUyY1LF/K/dP13Uic8xLBKBqFDGNfN7ThTfkCTcwPHJ+81yayjP0R9/4LO+3SUWl
 oFtwfI0QVhm5D3GQnvoTQuYINWIoT9mmnO+2Iv380OIjtRQMGObZhmzYJzlaCu8wIIvnmg9VA
 wm2MMcfvA9YsWICoDWwNGKy1ZRFJdWJl+7UW4YxcvRerXqTWI/oDx/GZWFnTmFMEZZYxnMf+5
 aFLhXL7mryGxBAsLlQxNZE5HdYY2G/tJtoTONlFmKqbicGhDysEN46ZZ9PlbLTxUDymiehJAZ
 6COWzab92QXHQsK9/IaRAkx2MWcW+mSSzW1gjlr68lvY574+G2wBYyftLlWAUDax7TwmqEWbq
 uov7uz2SiPXSjLokY7R1NFhCUk2rXGslLd87ntSjMkG7gTYFAaXA06SnJ3JAlRZJFdDpNxdXA
 sk+0X9zBt0oB1InfFbS7l5wqq909vnZVNZcXiWYR4m3PtoqEQkqwwCdy9jXpncKy1hONv3gCI
 tKkTr2lmFwaGojxltZ90mfROkPwAIzC7n2g1hNuYSYCdkQUjub7wRX3maNqK8wSqg/hsFsZxY
 9vizJ2c/rmF3H2UvvBdmp6iBtRy4ePbp5eDgBOqAXcDHBJK/sBMD8/haItmCxVC/4UGseVR1g
 3jDeOBkQ5Hw8WA80Y+UAAlK/S4drhoDf9bnggFJBOH4agcS3jatZOwbkLPe5+vhQHBKTvofZ0
 YYTl8Ipnk8ivIuozDkaMieYQseJ5ypFE/jFyiGKAQnwYTg3LBgajq2eSypUY61kRi4yZERSBr
 Wek9Cfi/H1HmJ6l72jcFcFBxS366IexX/RaSv+mXdW6cT3dLRVTweKWXLe+k8pJlXGLaX9pSZ
 P2Jsafa7cDLgyGP+kUIF+QPNHjJDJx40aipZ/eEDa9EeiK9Sd7g1M3RedraDd4LDbQr2zd7LE
 0oz/4AFwoz+8F8OWHslygz11JlBgY/X3MahIgO6cOQpoIvgvxGNS4aOgK5sRNyWAapydIe5Lb
 GPI2jSktmQ1dKANNF8yAMXiE1EO9IuEkM6IoLmLsRjdwVOo4+XYSdnhYDc5E2ahL8J/dhEWc2
 157rZyW3tFYKyqTTK7HTusBHWxpU1D8YGBzexnzr8E7H7KfpRb812BUtX4A7GJKe89RRQDyFk
 jT+Oh6pfkm6PcunGZLMyDDXvCdI4Dbo4t2U5D1jfG66I53Q6/4VwEpemaEGbrXVMj97dl6yMx
 X22nRxA==
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dmw3MJHzFxZG
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712316.34353@2yQFlVPDI4j34KZqYomB5A
X-ITU-MailScanner-SpamCheck: not spam

>> You would eventually like to express that a maximum should be determine=
d
>> from three (or even four?) values.
>
> If there was a max4(), why not, but in this case I don't see the point.
Do you miss such a programming interface so far?
Would you be looking for corresponding software adjustments?

Regards,
Markus


