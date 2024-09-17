Return-Path: <linux-kernel+bounces-331982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A258397B3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7CF1C23895
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38DA16EC0E;
	Tue, 17 Sep 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gBEzK9qi"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B21185B55
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726594479; cv=none; b=GQoxQz95J9mU5RgryCSQzNYmwys0zv4EPPNExoQVMMibyxqTw2slF3HjYoPjMacfHGyRR5z7morLB5vQ78O0MVoWzKWOv+USAntaj4wK1GmeMCFeCiVQz+GVYmRnyowneTTExMKHJcZvHZ1o0tU293mVRiLVzOohVeF90y+cBXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726594479; c=relaxed/simple;
	bh=SXG4nbp1E10/7CtFdVuWUEEmvUcnDCAMLL89gDijIZQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JIOR9rhjTOWQR1y/nXb5JtYK4NMXiv5VtaTiKAnvrUGy56dPoBpFiY/zgPikiF+1/nQ3jo70MwtOr26P0zekzpeTmCoMzMpA7g52N5fFtsRNxgG1s+YTR5TbCsPZDwnX5qtxiTC2WwcIWj02mrJwc4ulXRk31nY9dLC1oxbBV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gBEzK9qi; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726594447; x=1727199247; i=markus.elfring@web.de;
	bh=VvxXMxcafFA0iLzl+qK+B8NzFkMQKxHmtwIhDsRZPXo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gBEzK9qi8UyIR092liEla+QBpZq0Ub7l2RhydbPCxF4mOLHJKtCl+2oqWdjWeeEC
	 zDiyqiGUCJnt9NAacejtUubzfwZDTKus1i3IbB07JL3lxn/sScsNMZfmVJcsFqDK+
	 G9QKcxcSUjqTHUWfml7bo/WRodevMTywyA10wilp2IOU0807AdoYjg2vPD4JYlW0e
	 1yr2hWqcbApFFDo51w3PLnFGcCfvqUsCKL344dWbpSEh3Ip0br510ELJMvBRIR1u2
	 Fr0eXZP0w/V3EyfaISAj5TjdoAcf1mZeeNPegbwBB9JjlQHL6Gje2Wnhr5Q4DfYsn
	 +uWe6cm8lHIla9adHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59iy-1sri151XV6-00FyQ9; Tue, 17
 Sep 2024 19:34:07 +0200
Message-ID: <254d16d9-d56a-4f26-9914-db75e7aa4287@web.de>
Date: Tue, 17 Sep 2024 19:34:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Alexandre Mergnat <amergnat@baylibre.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 David Airlie <airlied@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 Sui Jingfeng <suijingfeng@loongson.cn>,
 Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] drm/mediatek: Adjustments for mtk_gem_prime_vmap()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jv+5loKG9MPWnWE+0Bw5fMhaNdpSXHI8EOSzOuaZT4ehxYInQxj
 7c6Xgp9F+toHHG67l/6roH+nG6fFLgJMjqCbRlGtsDTIWblY7w6Feuju5nNwPbuqmV9qgyY
 huhUYjgAeEtyqwWqgF71riV05jqgOOLF3CNlpISn0YAniREiQ+vsCt6BhmpYuCGl2CSa1Ca
 75wXNYkbm/Wi6VT/gnjhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gJl61uCuOo0=;bfzP37UybJyqlZzICuvPdQFk1d8
 Ot9IuSNEXn1l5q56UfyK45AaxmXH2CuvIzBLMT6/OKcxICUwr0BblBrf429mQL6zQMIK/CkCI
 WXywfOmZYZ1GlZLnXJuw9owGD79v4/pxClkhNRnbAymTZpenkjcWiRmf9Sv8TDGceDOIeXEt6
 7LaUecWTUxqFI1U74KI6wIavFXAWn9vNMGBnFUy0pRml0Ete/hc0j/9Axpoq4M6HYGdHvgRMp
 laylo31IlmAmL26oH4lfTy3z+4lPGfvJtlF4A0sm9RD7CBrfj1OXU0Xx+9JflFN801xJNWGKb
 h4OskiRy+DX7tbsb2stt7tRJTxaJ/fgtSpaBcMWszdHc1GUJx2CTLDp5Sgg6DFZ34q34rALlR
 MFVCe4jwu5yO2se3BODmoos/cdaACr8e3NCMlyHNDuMpOJRPTb27JhnldY851MFsjkq7KxoP/
 hLxkA83ZEOSkx/1dttShIClxEqBgvklgJ++2SL+4RvUTtfkfsPqmWeelFv52Yig7x7ajSN1km
 YfKuiHy37thJ3B7W73Xr34PYEJb/vIFpuVVdnJsOHid0UijBrVI3jOVX4D65fKewkIcEgnaAH
 bnzJOBe0848ijaOd3tk0ZZg/cORfN2Nt7K4bV4R7/tnuQUY85Wv5NxHMgt9wTUgnvJKJm2auw
 vd0HKfL2SfusoZHyKf41KPkeblnsPFCqfiLJiAlr5koxhKwad01l19EXfKS78RaniIvkzexIU
 SqDx1juO9LeGmZNxCiyb80al4GHSSzQaA0aoCxw6uD0P3TjOxSpRqFlECVZhcKtpCio58G7lB
 McgTmXRJUMSz1kIWiwkzJBBg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Sep 2024 19:16:45 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Avoid duplicate sg_free_table(sgt) call
  Use common error handling code

 drivers/gpu/drm/mediatek/mtk_gem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

=2D-
2.46.0


