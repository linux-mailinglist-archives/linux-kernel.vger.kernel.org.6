Return-Path: <linux-kernel+bounces-189317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352DE8CEE57
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 11:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C720E1F216CC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529031CD38;
	Sat, 25 May 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uqgZDG7R"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAC518635;
	Sat, 25 May 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716629909; cv=none; b=ckNPUfH5BqTM2GNtS5JaRn1+ebxqtbWL18XeREzykOlNFEC7/7W12Txxvl4Owptcn7KkstVXGG3/2bv6BAdujY2++cdXgt1ZJ1esnR49Eo+gU8LXo/TziX7OQ8vqB+Ks/OWNI0fV5hW5/pn+0tjZuEOyMRB9kquU7FfqsRry7No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716629909; c=relaxed/simple;
	bh=Al99sxoejdNoINbkYNcTmfr2Q6A57jN5aK9I7dlIghk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mfjqfA8RkezVtckLr6FSmsMQVeU+6DtKJzAUC415hcGBkPt2XCL/9z9Z2AhGBPG3v1laj8WNIB14aE2UUs4gq2l0oiJllf/LTSJLTgMvToQvU42uwpdDDVK1/gxozy/3hmaA+Qo0f92LhnzTX7V/cqZPI1Dny98PT7uAcaKU2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uqgZDG7R; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716629878; x=1717234678; i=markus.elfring@web.de;
	bh=Al99sxoejdNoINbkYNcTmfr2Q6A57jN5aK9I7dlIghk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uqgZDG7RGglf64ipJsRc76zS7mUyZQSqvxNKO16OcTp6oN6qBHWJtseVhGIn9pj8
	 HvcDL17L60l/QXDR5TBAu4ouVKXeA9WaetYAVaR0EnzeCBGW8XGk8AbQ3nbpThJ+L
	 3fwhZrhPHFHQT7b0rtGHqy1O/8TEQbroEwmI8EMCOOBrS2QDb1ZFnHgQ7Npo2P6mZ
	 Hk55GMLx9wb1BkBssoOAUoa3EMOJUwRv+tKBrVHlsuWRK4ih//iY7RLA8r/uUf9f8
	 6/eYkB7qoy0hfluD7B3VqPV3e6qIbqjvO24OW+4cUOSN/HjsIeIF2G1JSa8vvQX9E
	 FLVS8rs36dzpiWmKZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZMD-1s3yCV0MCf-00LqqR; Sat, 25
 May 2024 11:37:58 +0200
Message-ID: <1b55aad1-1442-41a5-acc6-16baab90c021@web.de>
Date: Sat, 25 May 2024 11:37:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Bell <dmoo_dv@protonmail.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <IPHlm5mOKUzYfwGy0auyufx-oPkSrtQjUjiQLbtvspD69UPX9O98iB8P2mqM8ahNaerz0yUa009f4XABRniq7aj2PUp83hbRVVhhKmqT0Ss=@protonmail.com>
Subject: Re: [PATCH] RISC-V: add Star64 board devicetree
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <IPHlm5mOKUzYfwGy0auyufx-oPkSrtQjUjiQLbtvspD69UPX9O98iB8P2mqM8ahNaerz0yUa009f4XABRniq7aj2PUp83hbRVVhhKmqT0Ss=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LsMJemhnw4gC5uXuCjSjRdCcV3bKa3+UZqXcRQZ+pwQN5gmBe8l
 n0ltfZxBuUO0OGWzTwFOlWfJzaemmJdyk7Z5JxUyEo0fiWi+t5lbvslIc4eR0E0oMwmulzv
 1tOrWDykoCco1XE82Bhuw6iKFjUCy5R/Rihi7FDWetxphcQQyvUmVoOyb+KHEZKBrkyN4ie
 pIPu8IW62eHl+3k7IY/zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PKJGWqlBrl4=;cM0/ZXfhYqM1Mkum3lccwU7cwUH
 yRVzM89bgfn3q6Aj+ZPzQNcfzxMedaytYENGuqIceaIA8zds1VjJU6a6A6IobeANATya7q5av
 AzH3ZBQXsGmLMiftWnDvLV65YAdJUkd+jby3884ieSAf11ioleUpWNbYiEwlENtabRpAP35zz
 3/5nJh4Zc4I+PDi+6fp6jBe3D6Z7SE6CfU+fYeafGqzYEaeWxgsJy6htOfx1kBHCemulfx/nF
 ankBqYwpKpRg/s4vSf+/Sr1Q6mE5ofukvoNs4ct8VpVCd5VMJNJVtt+dJm30arD5Huran1Z10
 UVLY9qsMYnTAif5sLR/3+sWhauWctlwIg+bY+0gk3r3+G4D++klCo7FQ+5ZkIJjR2RTgKIwhN
 1ZYNJvob+WFoSCEGGiUL1qwKJw+MjubE7bttwxb8iK1FS+R9/7zqSMyHgDj97c0HhyfIXAFk5
 I9Ouy4GCfhf8FtGM9UU7LzlBaRNCmZBHfe6W8V2zomLdiA351HHX285nv89IAkGjPjTX6gn2G
 kaBpIcOG+Mxf3zmjJNnjjG+xNH3SjaFDrbiScwsyCmCqtaGGBK3aBNuC0ZalGRpw9DrMCfbEX
 OOUNnk6l3D257qjrcKN7fKyzXZY01YJJxi3HjrUedb9vgiLc79xtpELaRuS+50eFMNQYistGO
 fBPuhOgZ0zkYjmGDWzq3pW8KNYXt600+jef3SPszomAx2+SRzpeIaxmZiyUWrT7+uRrXSWjvC
 dftrfrzFOC0FezvpZSr3FlQJn/vgtuG0W1qORpAi41K0C/ex65DaafMsG7s6aL1H1aX4Tz8Av
 Gh5eJ00QSWZ1tzwNmG903i3q7k7Jyfg6qUTrH0IWsWtWo=

=E2=80=A6
> The board features:
=E2=80=A6

Would you like to add an imperative wording for an improved change descrip=
tion?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n94

Regards,
Markus

