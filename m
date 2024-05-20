Return-Path: <linux-kernel+bounces-183777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF0C8C9DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1348D283B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C70135A7F;
	Mon, 20 May 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rRKX+eZW"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF64A2D;
	Mon, 20 May 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716210811; cv=none; b=oMcBnlJlreHvg+i7a14pVU+WSNGrnG4ltJb4IZeFgXqWvWJRELT8Agc21/BvE2RpYemi8H1hgBmHfosrRumcOflBQ6CxOz6/cI9mqYRhwsHpjK0VajVPDgn0cWEzvRWpzBGsqizeGah/THW2wKXivKKNwRW3Hk4xqxxDLp0fng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716210811; c=relaxed/simple;
	bh=f7zIlcknMaJuKJEVnpdofgraR6IhmhMEOVN5APWMJaY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=awJ1IV3tx4Nn2eO5RfPlujjlvCYmbRmsk6azarTmkFikmm0dBRFsdr4G5VPRjNgBD2i9ThGo9M2LIw1ujY3Nl1Wj9fCBr5uOwkNzKU8UHDnaieoTGvJOVbZzWZQqzdvtK2viaGHV0Cj/C9c0zRyq9NeCXEfBZKG1H4hrxtGoMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rRKX+eZW; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716210778; x=1716815578; i=markus.elfring@web.de;
	bh=f7zIlcknMaJuKJEVnpdofgraR6IhmhMEOVN5APWMJaY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rRKX+eZW4YisSpqIwURkjHdrCoQ/cTALVkoumsDk8JeHbsMRgIsJ5fvEE49HoKAd
	 /w3jBufKysgBSEiEnBOR05kdvySaQe8G/pzEZlsc0SsBm5plG+ZQf4nUTaN5f2UD/
	 IPGwTQDfaPu51nbR19f5sKgRjt8iEnpeQhoEmKdeqchHmVW/08zmo1c3rVIMM7Hzw
	 5sv2M8+qOZvtH5/2fPJzZsS5qqZg4qchEsn/wUot7o6HHEBTwTa1JD+jRv7xKXgBa
	 V86Ly+rUqRzU+IarWJw9xhhaiIK6Q+75rKgJQUuWzQx8xkZjrgt9Qobv3Uh3GVNfM
	 gOn2coD7PS8iKnYpFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6HKG-1sBFju1vkO-006kUJ; Mon, 20
 May 2024 15:12:58 +0200
Message-ID: <303106f2-181c-46d7-9f76-223f9cf9e4aa@web.de>
Date: Mon, 20 May 2024 15:12:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kuro Chung <kuro.chung@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Allen Chen <allen.chen@ite.com.tw>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kenneth Haung <kenneth.hung@ite.com.tw>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pin-yen Lin <treapking@chromium.org>, Robert Foss <rfoss@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240520070409.1044236-1-kuro.chung@ite.com.tw>
Subject: Re: [PATCH v11] drm/bridge: it6505: fix hibernate to resume no
 display issue
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240520070409.1044236-1-kuro.chung@ite.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cLdn9iPKctZqvcO23ZhFt2x4JHo3hW6ETj0a6+vbqB0ZbV28ic8
 7/ebCRl5ftwg62yCO/c/Oy8hkeWmPJfa9y5ilNGf+mK6zzohSpEH7PgJqXhrJTxmfN809fo
 t1KFv5atAjdOcNNktb3JJYcE4B2eA5Xz8sbOMebkQvvjdV7XGnUhYEX0dvSoI+ArkOu+Qfr
 utsmq8XtdLCGBoO+K12uA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1V/0Y0MN62s=;C5nde+mng12X55c4UQ1OmScX4o9
 62fZhHFqQHumjOwBfAgOQGH8TOTeCBZhPDfPqPXEYL2bq07M/72kT2X1fC9cjpeXHvBgY09KC
 iuGHYs0lWKc1XfS7t4zsdzym5PAspEgfR2jKWgiiilkCNoHuY7nbdrTpa2QpsWSPZVM4804aP
 LXeF6d0EtN8zmIpwl85oj8Ao0jsOoLg4TiMyBvvw6EeNjHAIoXW98y72MXQWLcWYy4CrJA8c3
 StDqaXR1HiTPw/J29AmhsX16zKBcbw4g4IE/A/fwMnSAAyEjPbIfGlNhgZ2VSZuaZ2uJizBhe
 n1Q+c95IJk9GpzASZ+/zWqxl0z3ExaQGsO9CtKEhj4G+cG4a5SsK61yLs+4OpUwvkTDIHsLCv
 /PxDWDIkZXdJyhZgAnEVqz0Q+673xkjONKuAwFZxGL/FCTzCoyA5pmDVEjv0sWY3j67pbFk1h
 JrRPmvuxyE4FMoHOkk18NYXKUhzu+lyHcLj3Jt4FX9dCns4Id5VpWtuMVmQb71710WJFh63uJ
 wkQvqfswUYOCmHxtp+jqTyy2hxx8NXL4C0RHcPSOK1ic7/NhhOpEOx91bgCq4YTZu+X8b6VJP
 yH6fkAIga675dl/DetfRnlXS1nRX3xVggla7eZYM1/CComh361T7KwSpVAu1Kpy6T1ZtkkMqG
 DFbmP5QlKsyhaEa04wgIZLciYGa1eV6xiRTZ9WNgLtRZOoY2SF2ntKyNMxCVacA4FKL00FguS
 i+Z1qJhtFwUFDQ3X7oaGwWjnSI4swldtQ+8Qd6WUJDsBAzsXq87LBitc/fQ5X6bZGBjbibvIa
 7GFvn80/XjzoowhlhqBycOtWQEs2ThBArhkR5GI2LZ9xk=

> =E2=80=A6 This patch has been implemented to prevent =E2=80=A6

Under which circumstances will imperative wordings be applied for
another improved change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n94

Regards,
Markus

