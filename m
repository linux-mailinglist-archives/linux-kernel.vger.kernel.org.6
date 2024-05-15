Return-Path: <linux-kernel+bounces-179696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3168C638C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283562832E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972E057C9A;
	Wed, 15 May 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sx0abYUl"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FDB57CB5
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715764736; cv=none; b=keT1DzaQr1Ah80p8fTXKjSGY63aiDRQ//sWUrrOGLNJeVfv2zeWflHErjgYGg5vRYtgzELAn0roL8HkTHo7yY1FTXemmlqhEy488f7oiDHnNpJMEdM4bzs80IKHpGw1UjnzLjISQtMU/cykMNxyOex3VzvejxDXeWk/sXrMLxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715764736; c=relaxed/simple;
	bh=fSK9h/gCpJhmaMaOGAGjU4D5aHmktAM02LLSkh05iT8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ew6ElyHW1VmtUvilasDljCCX/8sVvohc34pYV2f+t0Uh7EG3N9X16RmzK69S/08Kp7wjTk0JSraXObeU1KkQ2K4VOmBPIPTt75yPyIVhUcjSFrhllRGxAI1l03tzVNI9qA089yHONF3o3OLbq4LO8e+W7siT2UN0h+iha08Q438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sx0abYUl; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715764722; x=1716369522; i=markus.elfring@web.de;
	bh=bxm7PFm+rie4ZzlAqjg1Ckv2mEApVqgNMxWFDmfQvTk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sx0abYUlHgKmKAmfrT+gBwD4ZZCmtouEawn4YVPGklkN1ErubE7RuXCxI8AFz0hK
	 m5k3Wz85YPT8tCSQV5d0Ovxe9FH6KuYnoiRhwFxhpZoHnumzjumkunZ+cPULywwS/
	 mLcvbmz+/ajl55peTsQfhsTEBH+ISMoxg28AyPP8HFUJcGaTeHTw48sMZnwseOhCO
	 2o+jgsRQnYAROZrzsF/ciFiadX9rA52xPpxc369WfiaHCskS4JbOWxTsAu4xTSfhp
	 roBwQ+u/5fy9GNXipSqKwMbhFwuazpUrvGxB9O8WpT9beFKkQJ/FJipSMl81pBU/a
	 BxLhB/gCzVLMHWumDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhjm-1soijE1lWo-00ZOaR; Wed, 15
 May 2024 11:18:42 +0200
Message-ID: <bfece5e7-3c7f-44fd-9cf4-dc541d4e47e7@web.de>
Date: Wed, 15 May 2024 11:18:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kuro Chung <kuro.chung@ite.corp-partner.google.com>,
 dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Allen Chen <allen.chen@ite.com.tw>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kenneth Haung <kenneth.hung@ite.com.tw>, Kuro Chung <kuro.chung@ite.com.tw>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Pin-yen Lin <treapking@chromium.org>
References: <20240515072328.1010920-1-kuro.chung@ite.com.tw>
Subject: Re: [PATCH v8 0/1] drm/bridge: it6505: fix hibernate to resume no
 display issue
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240515072328.1010920-1-kuro.chung@ite.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kt7Z/wCrNxfV+dApqAha9L9wWAGslnES7TINSjFONy6KeqA744M
 sIOzWZovzfVs9NC+gmGrFxw7rPpxcJwBU1X7Fl/x9FOOov1oA50MXw79/ms1doYhlai+vib
 OkcBqhM99p3QEN0ZZ7aiYRWTKEvQto3aVCPGK96RKOabFTphsmM54fG2TpKNYltU/mqYIef
 btyGAi4FXZEMltQZOwgfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+RE1U0i96s4=;cWv86TqIwSZ+CYb9HILeajltDJw
 2bmAspgNWJSaClNGfmSFZzgL6+ncUz2fmwuO7ZGc4qlHGZ8xBIvWDKiCqOP0Sh/9rVtWcHopP
 np/U0hjcRxQcf/J/oyCoAMXiGJ235AZxQ+g6MjqQaPaEcypoShvaceJKo7xQMvwZSsZt5CinI
 dseLiM75+pIjDx9K8+BHkwI+Yt8hUIjX8WIsVGu0bbEV1MnHH55MQQ0SI4+NPBoj3oGY3+r5H
 0alyDIZtyhZpLX7F+FBItM6hRkIYeJK9kQJGj8RhbfBZw+VLKAiwoWh1fLv4JQrBYhXlYVY3z
 947lolQIWwGHd2Ck4qr1Jm8X47OcK7VrdhsYdaushGA0x/606TC0K2/eS+Cej1hkygJ0PCMAR
 r2fIL/eoC+JnR9ozuIV75HSZh0nbPrQvulSt6MabrToXt+BCdKxUElWsDXpxrmAMLD0/RA8V5
 bPG47mR/MIoUP7xnK3gFlEqkw//osTcK9KlKAnBE8W3Eu7LHxP7jgyT59GxyTMACu3HIYgE6P
 K1rZJ2ivuNSCf5FXNdonkvB2ANJLX4Ii8pDIYuCLo+o7xMjZpAK6tcIjpYlHfiJjjfHj1W6Da
 q0d3lboVTj4iV4Kxukw54eBvEOsAA/bBWmxjjyBn95BOyqCS7SEGOhZ5FtGSFZUkHolTnINBK
 5jgHd3UORJj0nTjbiu1bQCx0XXJhmHIpunIXPttPctS4wsgTOeeJemu4ciVFwxIY8ndIi5WZq
 w9s04c/ZRpul1aaLE1QYsuWqqbuBNICUp8SQqCbHWAdo219blnR0TbgnZrASgqyfGYQ374E/i
 yp9KbV9ko8S+LebEYyTfNQnXHiLktPrxIZZLGuadNJchs=

> New patch description for =E2=80=A6

* How do you think about to omit a cover letter for a single patch?

* Would it be helpful to specify any email addresses in the message field =
=E2=80=9CTo=E2=80=9D
  (besides =E2=80=9CCc=E2=80=9D)?

Regards,
Markus

