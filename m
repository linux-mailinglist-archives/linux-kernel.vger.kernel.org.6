Return-Path: <linux-kernel+bounces-282870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 189DB94E9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F061F2266A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA3216D4F8;
	Mon, 12 Aug 2024 09:32:37 +0000 (UTC)
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071516D4DE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455157; cv=none; b=hcTNCB90TFwDgfkEl6vu1zyxKkCPXGTePoSdwMDv6I8bBW+vZh7fU3WvRjbAGC0NpnQaZZ89bNxH4vxSHb+d9NoFe82B/KOf+WwYy2YUxtP2xVsdJV2UKS0iQ5D5Qx2H1JFS7Rrkc6uEcTG7Jw15MzS+jFXPZqSHhXSfHZ7FwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455157; c=relaxed/simple;
	bh=5hei0DlKXyAOKcBifBbCcMuEVASmbUK5VD2vF0hgXe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/9cpVTxUTSbVDWV6/HuUAqu7KZF4g3TkxfqqkUgJWrkT5z77agc6k3X6KGEXBIBlsgKJVGkAP41TuCLlCLB3mulNKqllYm3hVoRuuQyAe3as0AmAVHKC+IlXCQSVgYd19afd0/zZgRKignJJtbP2k2iCohFXyhTPvqj1GZASV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.108] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <abelova@astralinux.ru>)
	id 1sdROV-005gCi-Cp; Mon, 12 Aug 2024 12:31:15 +0300
Received: from [10.177.20.58] (unknown [10.177.20.58])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Wj8RZ4dDkz1gwbf;
	Mon, 12 Aug 2024 12:31:54 +0300 (MSK)
Message-ID: <bb45ed80-7871-47ba-a1fd-ee71dc21a409@astralinux.ru>
Date: Mon, 12 Aug 2024 12:30:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] drm/meson: add check to prevent dereference of NULL
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240809124725.17956-1-abelova@astralinux.ru>
 <CAFBinCATiUnR=P9VRBxWeQhf49k6PVxK+nU95G7w94f-mR2HWQ@mail.gmail.com>
Content-Language: ru
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <CAFBinCATiUnR=P9VRBxWeQhf49k6PVxK+nU95G7w94f-mR2HWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehnrghsthgrshhirgcuuegvlhhovhgruceorggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepvdegleehkeejueehledvhffhuefhieejudevvdejtdeukefghffgveegteeikeeunecukfhppedutddrudejjedrvddtrdehkeenucfrrghrrghmpehhvghloheplgdutddrudejjedrvddtrdehkegnpdhinhgvthepuddtrddujeejrddvtddrheekmeegudeftdeipdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepmhgrrhhtihhnrdgslhhumhgvnhhsthhinhhglhesghhoohhglhgvmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhope
 grihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrnhhivghlsehffhiflhhlrdgthhdprhgtphhtthhopehkhhhilhhmrghnsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehjsghruhhnvghtsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqrghmlhhoghhitgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrghenucffrhdrhggvsgcutehnthhishhprghmmecunecuvfgrghhsme
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1723449779#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12102994, Updated: 2024-Aug-12 08:00:48 UTC]

Hello Martin,


10/08/24 12:09, Martin Blumenstingl пишет:
> Hello Anastasia,
>
> Thank you for working on this!
>
> On Fri, Aug 9, 2024 at 2:48 PM Anastasia Belova <abelova@astralinux.ru> wrote:
> [...]
>> @@ -373,9 +373,11 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>>   free_drm:
>>          drm_dev_put(drm);
>>
>> -       meson_encoder_dsi_remove(priv);
>> -       meson_encoder_hdmi_remove(priv);
>> -       meson_encoder_cvbs_remove(priv);
>> +       if (priv) {
>> +               meson_encoder_dsi_remove(priv);
>> +               meson_encoder_hdmi_remove(priv);
>> +               meson_encoder_cvbs_remove(priv);
>> +       }
> This is the straight-forward approach.
>
> There's been conversions from non-devm_ functions to their devm_*
> counterparts in the past in various subsystems.
> I just found that there's a devm_drm_dev_alloc() which seems to be
> calling drm_dev_put() automatically - but I have never used it myself
> before.
> As an alternative to your suggested approach: could you please look
> into whether devm_drm_dev_alloc() is a suitable replacement (if not:
> just explain why - then this patch is good to be merged)?

If I understood correctly, devm_drm_dev_alloc allows to delete drm_dev_put
from error path in meson_drv_bind_master and in meson_drv_unbind.

Then the proposed check may be ommited and function may just return
instead of jumping to free_drm.

And would it be better to rename free_drm to remove_encoders?

Thank you,
Anastasia Belova

