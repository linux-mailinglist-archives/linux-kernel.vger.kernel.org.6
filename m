Return-Path: <linux-kernel+bounces-327620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E689497786B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8E91F25AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB09186E5E;
	Fri, 13 Sep 2024 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdqCjwGU"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFF2183CB1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726206030; cv=none; b=NnIIwlIMp8EnJLOD5aVsIlZt9EFCMhPuKhvysfg+2UoWynhn1l9Pgnqbm7/KPYxCNDCBA+4AI9pOeaYMi0zn9Z7TnpmDcuQKzQyLjTCLCwz1rE+8BUqLS33Ma6gkGXuQoRDbv+4UauP0cHiK04DIJu9UUM2bR5ynJMpKvdVG0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726206030; c=relaxed/simple;
	bh=d4e6r2tDo/HxOsfoAf4VVHG9Ax4r8Wfm8qGqpg1EePA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfZDW4FPGefmz6NgGJvMHkk1wsfUngl+1X5fwKYJF+1YHRapSMIbunuWRsWL3HqBqc+1xMafPibvWgZ9rXCN9Oj2HyRPMMmxg9DdQChTRiknR2XRrh0hoju7Gt1g4WzZm4UWq7E3z+ExIL6VXCA0zVjexsh+OlUQOfHkiz44x6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdqCjwGU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso10520405e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726206027; x=1726810827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqeBueurHg1MlYbxoLo01Cyqnr241lqjsc3UJHOuPFo=;
        b=UdqCjwGUGI5EDRv5umRwCXgp+HVx7NBRTtmu+/vtxcPFxiiNWj9xweq5MP1/oe1U0e
         FcZth0rb2LXTHx7PBj2p5WX+Velkwe12QX339knzK2l7MVIKu0++gtPVVyFJfCPkU1zB
         zRm3AnNFmpdEC82+LjF5LvTCJ/DUPvFLtu3YpcTKXCCmKgxmdFL4K/R/zQdpAcBVaxrU
         ncNNvO5NEynamDo+6gk9TmMUlHvLOX4reSBmfjbfZrfgHzwhlBePUmyOK8vURVZV3/yi
         cR6u6QFoqRph8LZXsAoLjVKYqYw73SNUJND3cPWHJ6sKDn3Le1PM9Rk9G0OyPAYgVhby
         t7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726206027; x=1726810827;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqeBueurHg1MlYbxoLo01Cyqnr241lqjsc3UJHOuPFo=;
        b=GJDLc7wXpxy+w04k2pf3ROm2aOAY+wj9k+TOkTt3Su2zYQ6zPlf/LGRk+7pQWByWoy
         wDQRq8XxfuuJxKwrOzW/hX3ld266FbX3I+isYyi2URTcVvUd2r7v8w31+5tAQV5PVSDt
         Xzoli62GjCJwIg/jxhbPTWZF4LGXdhX0LUuoNSNWatJ5Lf8fWR+EtFqvnhcI+DVJ1KD7
         Ivxl3345hwEcz7JLynVfmn2kcH/f9q3Frdhi/G/2gyByahe6/Lfsfxmv7aQ/vJ96bIZr
         CFgy5GHFGZpqFWMYWByzWVCPgZ8FOWzCW/lOu/S+7Hgqr/QB/HuLpSKgwfJ6Wlc9ydKi
         WKCg==
X-Gm-Message-State: AOJu0YyTBvZGvF4cG4lcxY880BCW7TaKqLz5PnJumSsDP+7QFDrQFIeP
	sincZLiJ1CE1H7d81XpX2FnuC+eRodezsRZGvQtVEEsXN8/kEpAx
X-Google-Smtp-Source: AGHT+IHFHXJvqh5YE9WoijwYaXi/zKjLEAnVxSOFH8ymQwiPDwQttWOmZq3Eb18i3jLZBDpzLua8Vw==
X-Received: by 2002:a05:600c:450a:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-42cbde23be4mr74941545e9.17.1726206026206;
        Thu, 12 Sep 2024 22:40:26 -0700 (PDT)
Received: from [192.168.0.10] ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b182004sm11524655e9.46.2024.09.12.22.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 22:40:25 -0700 (PDT)
Message-ID: <69776448-0328-4880-9108-54466e40ddd9@gmail.com>
Date: Fri, 13 Sep 2024 08:40:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Support alpha blending in MTK display driver
To: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>,
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 David Airlie <airlied@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?=
 <ck.hu@mediatek.com>, =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
 <Shawn.Sung@mediatek.com>, =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
 <Jason-JH.Lin@mediatek.com>
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
 <CAAOTY_8ThuusfHk9Gd5pFP8VhJkG2seuJmkFiruK1rPQFZGBzg@mail.gmail.com>
 <6c9b7f85-f92d-44ed-ae9d-00f6d55ea614@gmail.com>
 <a2cf4e9b9c3343a7398521760934f1740505aa13.camel@mediatek.com>
 <13f6dbc5d460e746352f68b001e85f870c89993d.camel@mediatek.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Language: en-US, tr, en-GB
In-Reply-To: <13f6dbc5d460e746352f68b001e85f870c89993d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2024-09-13 05:56 +03:00, Jason-JH Lin (林睿祥) wrote:
> Hi Alper,
> 
> I think that's a platform issue because it works find in my MT8188
> platform, but I don't have any MT8173 platform.
> 
> Can you help me test the fix patch in your MT8173 platform?
> I'll provide a fix patch in 2 weeks via Google Chat.
> 
> Regards,
> Jason-JH.Lin

I replied over Google Chat, but to make it clear for others on the
mailing list: Yes, I'll try to test patches when you send them.

> On Fri, 2024-09-13 at 01:25 +0000, CK Hu (胡俊光) wrote:
>> Hi, Jason:
>> 
>> Please help to fix this issue.
>> Otherwise, I would revert this series.
>> 
>> Regards,
>> CK
>> 
>> On Thu, 2024-09-12 at 23:29 +0300, Alper Nebi Yasak wrote:
>> >   
>> > External email : Please do not click links or open attachments
>> > until you have verified the sender or the content.
>> >  Hi,
>> > 
>> > On 2024-07-31 16:34 +03:00, Chun-Kuang Hu wrote:
>> > > Hi, Shawn:
>> > > 
>> > > Hsiao Chien Sung via B4 Relay
>> > > <devnull+shawn.sung.mediatek.com@kernel.org> 於 2024年7月17日 週三
>> > > 下午1:24寫道：
>> > > > 
>> > > > Support "Pre-multiplied" and "None" blend mode on MediaTek's
>> > > > chips by
>> > > > adding correct blend mode property when the planes init.
>> > > > Before this patch, only the "Coverage" mode (default) is
>> > > > supported.
>> > > 
>> > > For the whole series, applied to mediatek-drm-next [1], thanks.
>> > > 
>> > > [1] 
>> > > https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/log/?h=mediatek-drm-next
>> > 
>> > I am seeing broken colors on an MT8173 Chromebook with next-
>> > 20240912,
>> > which goes away if I git-revert this series (commits 1f66fe62cc09
>> > eb17c5909481 a3f7f7ef4bfe 59e9d9de25f0 4225d5d5e779).
>> > 
>> > To illustrate, I took a picture [1] of some color mixing diagrams
>> > from
>> > Wikipedia [2]. Do you have an idea of what goes wrong?
>> > 
>> > (I'm busy with too many things so I don't want to debug it now...)
>> > 
>> > [1] https://i.imgur.com/tNFvovB.jpeg
>> > [2] https://en.wikipedia.org/wiki/Color_space#Generic

