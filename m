Return-Path: <linux-kernel+bounces-225751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E199134D0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F06D1F21E9D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E972170821;
	Sat, 22 Jun 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TiC6xX/q"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161CB660;
	Sat, 22 Jun 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069908; cv=none; b=sc2ELyi3pAekSNnKltqDLwgok5N6gc+aLrlrwtgrdBqO8Wijy5m7/o97Z0GfFOgmd6vrNtLc/tmaFtGfPBVteLmm2jNA39MbWwpbZog3P2EKZiGWh5f+vDZfeoJrNgCz9/V3sdEpBYrl5apqgNu6vz5j6LgKfw6fkJw8WtOmcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069908; c=relaxed/simple;
	bh=fUdDu2yoZ6+wNUWrwToAORtf2lLzJ28mpOYZoq94kRY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=neLcfQLlBrx37q32apQ6HXbXKBk2fHXrYeu0vykpGM8RdwmkX060/cedeODZY2VJJPKsOJMRTPTkqRFALgIn99fBHpwkeLdFtJt0vSsQSCklffwBkx6cTIlwMEzI0bweTXE5WVChnkMZERXWoh8654UdvxoXvVdJSdrFgK6I7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TiC6xX/q; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719069870; x=1719674670; i=markus.elfring@web.de;
	bh=WECqVRv0TZb8C3EeVUwSaylaWepEfohQXMBJFu7n5+E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TiC6xX/qTiwXM7MccOqGzXJiM8o/dpIoCuaAGXGIu0lL3Z2+vQpe3lZNIgE2X7kS
	 thJmUMEfvw1L2Brpg0vdQTpRABf137nKUrUTIWpAfhnCsgdIDftlMZZmWOJq1cQpy
	 pNndir5cSc/kwWMvXonAnP9E9evOd4aV43k46dyNYeajDWrulZOTcHRPjTZtrkuAn
	 AySA9dV5A2ClcTF+y9T4r6vChAFOpepBsiHdp0TJfOO2CknUodTj9OgM+O80n8Hai
	 HHt3QZpVEil/Ho102vR/h+rf9qp7czrhCSRg1YVPXRr4siKGiOBkvcJE0zppEcaNh
	 ++pne4RzU+7MgZjIkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6091-1sIZtd2lpL-00DHjP; Sat, 22
 Jun 2024 17:24:30 +0200
Message-ID: <bb23a7b0-dce6-4359-995a-2c12cf30cfff@web.de>
Date: Sat, 22 Jun 2024 17:24:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, linux-aspeed@lists.ozlabs.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joel Stanley <joel@jms.id.au>, Neal Liu <neal_liu@aspeedtech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240622095618.1890093-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] usb: gadget: aspeed_udc: validate endpoint index for ast
 udc
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240622095618.1890093-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yIDH9MnOrIf0xCjyLzgV99kn2dkVnUILL8Ig2mwCXjJ1DMn9JRf
 hwtJM/HMYJDzvWmRpWzeOVbgEWfOmdeqpLtVm6dy+WImF6+hxuh41iczAODFZj+4EjHeylD
 RWJTXrMJlJBKN5/aXx+aHfGF1vixbncCTvj6umHs2Vf0oeLQkx7xdhUDyhs9scmvZz+rlIc
 KrfidPgw7I1m/gpW/02/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BtDLJqtpZP4=;YBAa051E6UtkLYeabXtx0bDWGu/
 O3XQy4Cw5LGx+hpgnHBQF7I1hj0zHDYrqkcxs0vfCcNBZ7MWjhJDV4XzO9n2OSExZMaCegZUX
 vEaznDvYvvI4Q6kIunFKmKtqeedik/tYOq1iyfwndJz0UB9YkQbpNQkg6SZW8rQ/uhX9V+fsU
 0Oj9GMYfVFceTioDSTBp5MPOcXQGkSc+FFKsQsAvRSr9+OXiQpZgOFlZnZNFAvMvsYvMc6Lik
 KkTndu3bUBGdu1XsHLV7L1t8NlxoAZn5/666WLlY459CHusNOwHSf18g2hHo+sbSN9OoG5jjw
 X9kcDRBXaEJUCdONvGS/rQQpp5x8c+MP7JBEH6wkIhBRd7CytNABNLyUMKPURBPcRWztrY2AE
 PHWbs3SqMnpm2WFqOgjfoyTGWZ427jhDnJRzgZANAkD2Vv6oksEp0dgeYP8GOJ5dnyJnUluhw
 3XaKyDVr7pfVxNcBcEcH6Umm1ypb22Mk5FZSfdT1MDgyJ55MNXHPMHHZNq0onLkY53unuZP/1
 kU68XdYcktGMkNnebqcZBQzhe1ZR4yJztjIPCmhGj2l/ttozoYQ11kBiHZbmmTXIAFTlG8Enh
 EzxzstMLsev/GzqPD1idi9+8P5gGvwoPTkStZ5j5a6NsIefh/fA5OL9PLiZuAK5e0sZlpMFHi
 kYlqQLs6SP0cOZh46dqHIPv2XP+bLl3u6e+l0MN0lofv5o7lWtXgjbFo+uwKCbnSNKIgGQNeL
 w+x9kUlgGE885pW5DbqiSdSJufJZfWP9pKdjggWsQ91JBcumc1hs0bnRzd1P+hJ/1D6rS3Jd8
 5GmvR0yOUG+rLGwqv83NIZxwadLxHplV9kJP2OiEhni9g=

> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.

* Can an imperative wording be more desirable for such a change descriptio=
n?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n94

* Will any tags (like =E2=80=9CFixes=E2=80=9D) become relevant here?


Regards,
Markus

