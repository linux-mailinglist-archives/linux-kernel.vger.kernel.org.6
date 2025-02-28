Return-Path: <linux-kernel+bounces-537863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DAAA491E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA9A3B58D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93B61C5D4C;
	Fri, 28 Feb 2025 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="jVOOip/Y"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C175748F;
	Fri, 28 Feb 2025 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726496; cv=none; b=hEvH+RsIJhDp8m9FLcQTTwY83IMhQDiljJIKcn65k52qkTrGDWWh72QMww+qrKLk2S7It+U8JDmxLIJ//Nj9LB/ECzbXnKGTWDWg44QsKp2JRA31nKoS64aG//RP1Qpop99o5sSO0G7LTnR2tUNtQFIS2b8TXxL9taXpsfwYrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726496; c=relaxed/simple;
	bh=0oGIPqR+xuqa+ZlC9cONFUewcTC04CZzgeAG8DnAtc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7qQe7jcDej47KAv6orqws6578cem6jZuijIoOitxsKqOUdzpKZzHaNe+vKzUBTDvZe7Ei2g7dhiV2GRkeBdar2iFI1/+bjts1wJHeAj9Qink/BN1gjNviLalIqII2o0Kyn2rsojje+iSXRX/YVp1xfyiOFV5UNkGl1gGbVRwFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=jVOOip/Y; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740726479; x=1741331279; i=deller@gmx.de;
	bh=SJrxyvd0RMUdwD95V90OXSdYyZ64YxQkPT3C5/xOCZ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jVOOip/YOsf+yuQHlaBM176G+lBzi1avdFl05GWGN2h06Bx+9qwqwJOp3oLi6iko
	 RAPin/nnWj7vQl72CuRzZswDVu/Pry5TJUrDmQyCU5Eqr0NBJXDPbFDJ4BxMFnO2N
	 Njxh7/UyG8/dmtyl5lxDu18I5yvv3DCuKcHeOzMfZBcG/Dt5ydScwVI0TEAymDxR9
	 LiYq8i/7aU3CoURRCZiBL+2vWUvWDtur4+NaZ6CvWkgROqFKiReZ8T7Hu2wJ9Erih
	 HQlmlA6Nt16VP1hCQxb0mGYJNqczhAIh0ScL8bShznCEvymTrK7EMRpa/8RmSP1AD
	 SnuRfJTmECdFO3BAnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.121]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1tXLWl0A8i-00Pvq6; Fri, 28
 Feb 2025 08:07:59 +0100
Message-ID: <2f0e2785-564d-44e2-ba45-d43dd2df0114@gmx.de>
Date: Fri, 28 Feb 2025 08:07:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: perf: use named initializers for struct
 miscdevice
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20250226-parisc-perf-miscdev-v1-1-8d541ac2092d@igalia.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250226-parisc-perf-miscdev-v1-1-8d541ac2092d@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6+f08gppdEDj9RqWb8LEurILt/xQ+5A7T3ToGF3bF3ksaZ7TK2m
 96EXYDvG6WhlwdLWI4E0495QbksOPa6zlaeEBftSxbrwp4Ajh7nj/F0kpfbmNTrtFgQEKrY
 oVArveqGlH/Pyvad3vlNuLCxk4cng03slDeAya15TsAr5giwurExG76xBMzh/XkaxbQEM0K
 WgA10n9HNAuVJHk5V7nUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fl0SXF0K0Dk=;1Y6pa2rPrhCAYGORXjRkyN6M9iM
 os2osMAHFaCaPBaZRd5s2BdtFs5JBaQtSsLPqeGql/AfBWC1eVKFZuVBbgx8mmfbP5o6OLrnR
 UTp+l9zgDVD3C1V8fFI13L3wiU2ca4F9y1zogR+otlL124Gk3GYvvat1aHms0yVsxM8ZblpqC
 nwCbOcGbU9LvYXmpR6YaM4vBjHnw10B2oG6Mu09n7ILF4XEvkXwdkpRAPiNxmwhgCAOTsIa5x
 fMpJvvanfc1jEfUMAKe9HQUrdYWzpl8iCKUqDieGmJV1pljITvBG0Rl6S96xuhHl9s/9MIuW0
 CkTDtByCQY2qtEg42aJY9GIGHWtRaqjNCBsUMB7DJB3XarBcVlt/g5rkJvzCWRRYiQ3kuggN3
 BNSvIVBVuL1h4KM2nxXwheDN/+qQXl5ZO9r72WevRprYS/rhBQUT4Big3Izj75aUCPtkhlQJ9
 MNPl+CW2hnB8DAE2x/xX2b/qW63eKmFpVRS1kgb7OHmAGEAE9qqrxQDCDNvg+LCnoPbMRT9BB
 OwzytE6CJJaAMr2eBJAPzMfJiFREhcE8Zlhz4WWQVkogAcYjjTH4lqo0WdSNwrZjlmAv7idRT
 5NpY6hP+xsSzlf1NwDQNvYXXCKblFrpQnpedAyarXg04wRJpIhlFIn9nyu4fRAN08WfjZl3dB
 N0EnUyKR0hcYQOyIhip1vlDNrmSGi3bQVx8aVBJvb7P2E5I6Wunf1pN9D+aPLZBNqqFYko9Wu
 EAmYIqysNj8hGv3gCKc0E1s5M+CzZlhNPsp+j1nrmS2aXjsjsGGebF9WPOcGPkWSKdGKNOSo/
 X+IuUrzAEsD++A7nGClo4/jzG0LjfITyHc7P6h8NfWIOWsRTd5MdJx8geoPK+YKmuEs2cTbL6
 p4t1LvYyu9rOVkWasHpAX5WUTJCnBsDFJgwKsYvQ0F5jn1mmbMfB90hMuG8W0DsgkfDCBEUS1
 3Fxa1IjtOloj4f4C62jeSSoBKnkWbNN/vK4XakuFOzzxH/PtOveUMM6U6AMDMd00DQEn4//VK
 f8pBLtSyPzXurYzgwolw2ZDip8PdzUVvxyL2aYEk9eN/NzqcEpPqmEvyHjtcBQcMw5Bt20AmH
 HsxfpzZ/3fA4Nmny6NxRpLyW97brL2CAGeefFHvfq0jNPmfQx/AnIdGHJOOKoQ6SxZWPxVKrL
 sYs1QiJGJYXp+7ygkneaKDsa0MKmjC7wLOyKK0j/zOBz8JQVBuC15xyVyl9F5v0s53SdItXS1
 UqSb2w3qiSjxKO7xvsMpJDI5qAHbt/CQchTEOa5aZz3oyg4COB7A6t1Hg/hF1cjmY7Law5b8M
 2EFNFeezDkJs8RMX4xuUIUfWnRjTuXzglRtB5LZB9qgKPOuVzbjEPRKcvZpyEdvPzM9Ssf7gj
 Q/WFYoPLDsp/7SvOnIwHMHLxEOLrNQW2ERE0FoDTgNXMBt07ciAVbVE4nHpsiIJVPS+Q0fAOv
 EFZNy7w==

On 2/26/25 19:09, Thadeu Lima de Souza Cascardo wrote:
> Though struct miscdevice has hardly changed over the years, this is good
> practice and also makes the core more readable.
>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   arch/parisc/kernel/perf.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

applied.

Thanks!
Helge

