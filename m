Return-Path: <linux-kernel+bounces-218647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7848790C324
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE811C22605
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860D1B966;
	Tue, 18 Jun 2024 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SeAq3wJx"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C5DDC5;
	Tue, 18 Jun 2024 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718688846; cv=none; b=OodqXhTYbO9LKFwAcRcJXsYQxcWL6YnxxnDKalOtbna9r4N13wH9cMRfVmXP/MGBp0zlbGWTMFDE5AnKsWNy86SPDOo1eG0Namgza625yvGcC34vxgKaSHSfAXrKXAjAQWkyL0KbpNNyQskZVBSuzRtYeWVoIwOTep0VOX7A+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718688846; c=relaxed/simple;
	bh=pPBjLLd1qD7xbh1QyvJzn/FF4RRknIcpkXzlp21hR88=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PlsZEas2hN5bgLDJ4gI0b2e+DHQDCduL9bWzccDMvrV/jE46rmJnOceU1Z0v85M6j31xptCPLYdw6UpAbH0iGL7XWrKlebSOl0j3JfWVHXpm0vMS03GNbpNk4zWlxW5c2+8GRY72a4wk8LPgmXSM4bBiAEwr6Spz++nJ5NmRzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SeAq3wJx; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718688827; x=1719293627; i=markus.elfring@web.de;
	bh=Imj8HFamVBfFhq+MAPpqduItpT/fw/LWP4APQ+TZXEo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SeAq3wJxvAjOXQ7+Evi6pwAmfwqVOzw3sTKpv24tCS/xIZILyD7LASWAZk1JrjCc
	 kw9yySZcuK0a1RpTiX/eT+IPCq9V7x7ZrLbygXnJVJ/BEPqRUUbzT0t3o8Ve2hksU
	 /HnejQhIupuwcFejnD1+MBmV90rYXglTwpjRnRSeZGirL3YUwJ2/MqN+qJTbp1Xvf
	 y5ZEzY1+SvX8yz9Ecp69z89Vk6DEzyyxxIWb2mqVm1n9dRrVKpSnRCJ3HjEGzjg4d
	 Tb/5DOUZZATdzbIiegzNJ2Wgjrx8cSv30Cf8yAEz0+kgARoaZTWeAd5Iq8C9KxK10
	 WBGtT9OP0HZHqm/meg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfkd-1rw9zC395h-00IuOt; Tue, 18
 Jun 2024 07:33:47 +0200
Message-ID: <01e68055-cc6e-4756-8376-be6a67d57147@web.de>
Date: Tue, 18 Jun 2024 07:33:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@redhat.com>,
 David Airlie <airlied@gmail.com>, Lyude Paul <lyude@redhat.com>
References: <a3e8cecc-77dd-4a4a-bb12-c1d6759d3efb@moroto.mountain>
Subject: Re: [PATCH] drm/nouveau: Use kmemdup_array() instead of kmemdup()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a3e8cecc-77dd-4a4a-bb12-c1d6759d3efb@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SXNjjJwWZ0CpooJvXJaGmrK+/a+pR0c5MPCgMr8Ia7zScD2A9C1
 8BEQjiOVd7Xjp5nNm9fWK7zcer6uLGho0XnsPEkf/bTk72subJTR2xB2RWza69towSZF/dO
 TDNMVBms3B2YZ6Hm6nU4M//hBMCYKHWEF+EWn9oxfC/WeaA4xVexXc0Y7oLqFkcbyN3uDnF
 LORnyCVj2uPZtXuFwTS1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yAY/K/2AlyQ=;UIouGI+9NXthGhN7xrhZdQGVRrX
 Pl/xOcZg7kFUvM81rqVoYEEVARaWt5+zHz5oWuBaWuoB+ZdKP3nDHl9TCITd2ClJFxKRgRkq8
 4aps2JrCEXjSLvHWyr3ZG31Im4yOy7y5Qhn/i8KDs1koJqHxaLvm6XUjnsWrH1X9ZaaFRXrXz
 WelF2cidjHnfoDU78MCiCxHCey0P+E2vZYWSwnUor1r3luCzTFWTfm0vUQhAAAhNob3PKiM7X
 oKV0m/BjF81sCRyI2z21RkH0YC1JD1ZsDDrRqpKLyAX0fHysoxGxQbHcvu48cFblo/DJWPaea
 3AWK9T7iSKkTyQFTEDiOd+ye2MZTLzFpWenK5rvhNnUFuNcdnD21vaFwqr+bf+To2kb2NixTn
 ZRShtAl9KqhmH7i4kWJVCXpyY6Ow3BOKd3Nkt8h9D7bCH8haUg8W6NC0WVXMNVMY1Mas9civA
 zLUW2inBTg2Gpj2NQcu/01MAUlMLNfV7gNirkbTFDft7c0pfCUjDILFvt/79Qj5q9vqkbDqFp
 0TiUwbnnhzispuZDmlQfz5cpbaJsPlihkqXeSCLfFqZQF5X++piYTV6RTBDFzHw2kD41NJAww
 KFgNd+6yLajBv/JDnbdMBE732bIVi2LSE8MujjHyYgKgOKMq6KBLGqJBtDFY5p4K0kZq+JeMn
 zBZ3MeGsOtU5Sne71/vS5CorwJ5rdh/VMnlmPy1zoNB7g55fw0nkOniCjvuG7s4nYEc/QV75j
 841tGTr793JDSziES9UqhEjheinxc5KBYdDuLIQ3dk/HgWQmuYQgjGrKhgB14JDobeSskmpPF
 IuZxcj8XKxlGWMnMfw5yL9ZhNlUGUlcTXTxdAUpbbCkd4=

=E2=80=A6
> kmemdup_array() function has integer overflow checking built it. =E2=80=
=A6

                                                         built-in?

Regards,
Markus

