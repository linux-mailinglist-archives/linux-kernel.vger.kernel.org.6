Return-Path: <linux-kernel+bounces-331991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A620497B3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D511F24976
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA92D186613;
	Tue, 17 Sep 2024 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nOLSqfeU"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC3185956
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726594988; cv=none; b=kg8Zdq7AcE6Ks+fxiO1OdbjLBt5iwq+Q0xp0zusZS7YpGxLufwWmmqTuYX2KA9+hGs9fBIX4Vi8rtijG8D6FySewW0ZUlt+au66hsxnLrdcyyvEKT4R/GstanEZICL43rWSXtto2C5Itxlx5oNCrP5FJvJ1CJgZ9l1GsDLxJP6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726594988; c=relaxed/simple;
	bh=TpOQe6/Dn8/qqvOC0gefwgldzlMRhxmrUp0J6F1YV2s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CN34KBCUs3IXGucqv5xxP5T25Cr/3+LPdAUxykpJUGwaDobf/9mB3dJxjHLwXW+PSWVndW4OUeAXlgpnxeowA661Kz1TKalM9ur/jw8kirx1otQdqQftE5fZgUzlwtOxqIRSJBQzU9nmSi2eXebNlVifO41xuqLqfk9Ta5+91tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nOLSqfeU; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726594963; x=1727199763; i=markus.elfring@web.de;
	bh=pWO2K5IT291YPVVlABU0X2IXqhtsWWaMdnFFVbIS0nQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nOLSqfeUaAi/83mr3M7ve0VpFC+MafCe5E5429bRzapNrRIOPMPsRzkVLZO1K/H3
	 2bR5Rda94WOeJvm0+8XiyVygNF0W1PxKTRaEJ285+FjrYCJ8RQysQLmVMst1jsjEY
	 rrlIlQcoPH//5mTrQUnbT3L1nwPkkCPpY7AQWeqwGgqB68KTh1ahcnGA8gEJHf2bO
	 a+P6c4m8SfDU2SQOX33RY9Yhs/13em0DGRGxCweNTKT28e5ad/m++RdBQuzVL/gP6
	 PpXkmDbTCMnw7Bh/3DCETCfedAdQWYrOKZlfbU0LYxwJehAh/h6/kMQNf2TbX7Qxd
	 R8nCzfd/eOc7ATV5LQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmhjm-1sA5bw3xmo-00fzWz; Tue, 17
 Sep 2024 19:42:43 +0200
Message-ID: <aa103a36-8cb3-4232-b4b7-3ffd117e303b@web.de>
Date: Tue, 17 Sep 2024 19:42:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] drm/mediatek: Use common error handling code in
 mtk_gem_prime_vmap()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Alexandre Mergnat <amergnat@baylibre.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 David Airlie <airlied@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 Sui Jingfeng <suijingfeng@loongson.cn>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <254d16d9-d56a-4f26-9914-db75e7aa4287@web.de>
Content-Language: en-GB
In-Reply-To: <254d16d9-d56a-4f26-9914-db75e7aa4287@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ezgH/8fZhFI1IrNh24hqxGOueTJdBwXGIwmeneXLT7XGQmG+3V4
 z//xu1M6oMbjsPr4NXuaJ03mTgKWia4i1uBGqfgmZ8Q28a3Dkm65V1D+MJmuufEsX0sg4mc
 tjL9pBs6prJYXwFEZyRK2Ivb8gMtHOle/MHWPYU3IU8mK71vUkSWAZrcmaXiepPEzCL/RXc
 sfT1Q9i/g1tuB1VN+us7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aomhZC9t42M=;tH2TV6U/oikQBx24ke6cbQaKNNk
 5aVG/0ORPx83Ltc+EJ6HAwycWg8bWs4jcBpBMqoB48FpOl8kA5105zrzU3FXdzIWxSMS+bGn0
 GxkRFke8i+DFXmE5ET6OUboflcwOLDHBvC22gFwVizMbvS87dZh9a/drZ6PKQ644DnnncFiTr
 71eZ83L0dT7bxdAPQ9c6DhgBp6w+ulfyKeioAmHvAsK2yhoaNvW4crGDETlKaXqxaO7Aco/L7
 N4IRnZUyDH77qweJ1nWZkU1Ol1cL9X+Yolu3XLex48Z8wdcMXYbVkE4/qgJ24cDJB6QU35Z3N
 JqBzC1GXbeXzIei4+gUKeopqr2hR0p9dq0IhXOMLzFQ7bEz0VpUoYNt+5bGw8ty0RNrxe89JN
 tAHl17rzrScENx72+etL1s7YXg4RHBNCOEz2FDuhdIaEOqoE1D7OsusXT0pXObw3q20DVWD/Y
 A+kP7X8XUnjM1Yi6Tqg/oWPtOf48FnBPwvN+Ee77N5BSgAdPFTZKGUHQwhIiQtBygT4EqwSzp
 1gAv+gpTUFzQTb4JJBvp8JUM6BrMSfYKntquoBp6MiHB+WAKN/2Lo4KQmXB2qeQeWqRM6BUp9
 vxCNMZDdZB2fo3U0v/LCfc36U9kKgmjrW7nX91SAWEjMI1HVLudgGL6a9GJcBAqE1TccDSBI8
 qe5WM+Vknyw3ru4gxh5d5AJRp+nizJQu8576r16nQkg0Kd28UEFKcdn2OU9X8305s0P/xIXmz
 gbOpjrW/pd8Tq/1bLxxbHIk/xaoS+w0cQa0CtLHMqk6bj7McA9DExt33JwE/j95JViOIxc2so
 BrSSOZpqessm8iBfa5zGFMHA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Sep 2024 19:06:23 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/mediatek/mtk_gem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_gem.c b/drivers/gpu/drm/mediatek=
/mtk_gem.c
index 9c7b7d0a3ffc..5713156efb4e 100644
=2D-- a/drivers/gpu/drm/mediatek/mtk_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_gem.c
@@ -251,8 +251,7 @@ int mtk_gem_prime_vmap(struct drm_gem_object *obj, str=
uct iosys_map *map)
 	mtk_gem->pages =3D kcalloc(npages, sizeof(*mtk_gem->pages), GFP_KERNEL);
 	if (!mtk_gem->pages) {
 		sg_free_table(sgt);
-		kfree(sgt);
-		return -ENOMEM;
+		goto free_sgt;
 	}

 	drm_prime_sg_to_page_array(sgt, mtk_gem->pages, npages);
@@ -261,9 +260,8 @@ int mtk_gem_prime_vmap(struct drm_gem_object *obj, str=
uct iosys_map *map)
 			       pgprot_writecombine(PAGE_KERNEL));
 	sg_free_table(sgt);
 	if (!mtk_gem->kvaddr) {
-		kfree(sgt);
 		kfree(mtk_gem->pages);
-		return -ENOMEM;
+		goto free_sgt;
 	}

 	kfree(sgt);
@@ -272,6 +270,10 @@ int mtk_gem_prime_vmap(struct drm_gem_object *obj, st=
ruct iosys_map *map)
 	iosys_map_set_vaddr(map, mtk_gem->kvaddr);

 	return 0;
+
+free_sgt:
+	kfree(sgt);
+	return -ENOMEM;
 }

 void mtk_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *m=
ap)
=2D-
2.46.0


