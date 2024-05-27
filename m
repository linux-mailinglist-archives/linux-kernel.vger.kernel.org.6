Return-Path: <linux-kernel+bounces-191066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA718D0619
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79EA1C212C8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A501017E8F1;
	Mon, 27 May 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Lb+dpalC"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F917E8E8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823541; cv=none; b=nzdumVQh0cj7/yAMIq/p8AMDgavJVxMS9a/GRjQ8A2Q7QhUpgHY39dU/Q2/jiFs4j4AZXdYb2/prciL6H9BbMIB9a1himMxaBwqDuHl+XH3wyjRdx//gxgTT85twicxTkL53xQscZKRihjLkyuFH+ikuRP+FNRlt4sTxINQ67Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823541; c=relaxed/simple;
	bh=YAjC+AWcuEwWtYc+0bhe6ljoU6fNPzKyPApNDIZd6II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qS3pDhO7tiZ5gCsJHoWtTyTQRKPxetoYGbmD8x/v6EZjUNVqQmrgY6LltZrXjlfJh2/rgmv1pch3STStEZ3hFra1Pbc6OEDXKagoQA4KlXjm3VTy9Ru8EZqyFh7HJBGGqFtA2d94OMO1cWKeBP5SoAZuDVu1bWBAoYGpx91tuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Lb+dpalC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5785fc9c543so3408059a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716823538; x=1717428338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YAjC+AWcuEwWtYc+0bhe6ljoU6fNPzKyPApNDIZd6II=;
        b=Lb+dpalC/Nw2Hg8mLHKNzAKEJ+qv5HTzEPde+UF77N4fqlOigIc/Cxb3FQtNgxjpdp
         TdjPEDYZ1q0X7q4oeqvq4LIAS+AMuVIje0I+MOE8vyi30cU8A0Ea9U8ThQ0dV15Q6vei
         t5KM0uATWqCE/xp2OJZ5KL3gWNUJpvZLiFqxnpbCR7+MWC0fuuCNuApFj1qMjrAwYQoN
         C0Qh/iTqj9kEdzn4/jL5/K05KitZGXyGL9J80fy2ZJK/X10su15I8evUalxXvkLn8Y2a
         8krAZlc8y1hCMrHEBSOsFpwPme4n87czPqP637fLSW7ru4Q/meBGHGWVykFuqTo7FV3r
         jOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716823538; x=1717428338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAjC+AWcuEwWtYc+0bhe6ljoU6fNPzKyPApNDIZd6II=;
        b=EGh6adNTLQvR3m1fxTdStqE/PjrP166hBC1lB9vg2GLBlf2eYyuZsRwC5yc2Kn6/bQ
         A50Fx/BwR+mmd748guHR60nLpKHgpH3ha/Sea5uyb8skN+anJ+/7vCUCYfjnZSkPqSxd
         1D2nu+9pMmGAkg19ypv/xVbBYz78yArDC3EU9GX8cGzG2iCr2k95cSv6aP/vjHzVtFz3
         6XmbIL3g9Uf4F/CzbA0pqY/yHN0lxLZdlyG+rYGcRKYfNXuK1knX6VhNyf93kl45dQul
         fWU8IFKa+z9L9viPePhJc6p5mvEXNCAjpQXUc8eMxmAraUPztc6fnmBlKbkdVw9tpg8L
         eWog==
X-Forwarded-Encrypted: i=1; AJvYcCWiYSCkuFlT/T71IvoP5q1sQ0I4L+gtIrJSyNSzlgGr28PetwGRInkUyIPEQS0bdV/iNn5zU1h33xCkTGN1IhtukvaNt+3h4duAVqgY
X-Gm-Message-State: AOJu0YwX4zZwM71RPGhobj/SqITvAVSla3qsOTAFwNJjsY35uRurBtxt
	5gJ59bmKeEY7tUijYF+5z+l9XpUPUhwW2tBJzEdUZh53wN/TdDJ7yVkkDalZiQU=
X-Google-Smtp-Source: AGHT+IGiRaldR9hXVy64MuaHnv1OfdgE/94U8ZZ1bdADsFNgO9ZW17mi5WmshRO62qu9oJ2+WFqVOw==
X-Received: by 2002:a50:ab13:0:b0:578:5d8a:cd91 with SMTP id 4fb4d7f45d1cf-5785d8ad8e6mr7556248a12.41.1716823538210;
        Mon, 27 May 2024 08:25:38 -0700 (PDT)
Received: from [192.168.1.70] ([84.102.31.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c3bbee4asm2952382a12.76.2024.05.27.08.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 08:25:37 -0700 (PDT)
Message-ID: <61a1be10-7df3-4ba7-b7b4-ccc7f0379656@baylibre.com>
Date: Mon, 27 May 2024 17:25:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] dt-bindings: thermal: mediatek: Rename thermal
 zone definitions for MT8186 and MT8188
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
 <20240524-mtk-thermal-mt818x-dtsi-v5-1-56f8579820e7@baylibre.com>
 <20240524-concerned-fritter-262f5e16293e@spud>
 <20240524-clatter-antivirus-b1939900ee58@spud>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240524-clatter-antivirus-b1939900ee58@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/24 20:27, Conor Dooley wrote:
> On Fri, May 24, 2024 at 07:24:47PM +0100, Conor Dooley wrote:
>> On Fri, May 24, 2024 at 11:04:34AM +0200, Julien Panis wrote:
>>> Use thermal zone names that make more sense.
>>>
>>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
>> Removing the defines is an ABI break. If these are all the same devices,
>> but with more accurate naming, then keep the old defines and add new
>> ones. However, the GPU1 define changes in the course of this patch which
>> is more problematic.
>>> [RFC] When PATCH 1/6 and 2/6 are squashed, checkpatch raises this WARNING:
>>> "DT binding docs and includes should be a separate patch." That's why I
>>> split them in this v5. The problem is that the driver can't be compiled
>>> any more at PATCH 1/6. It needs PATCH 2/6 to be compiled. Should the
>>> checkpatch warning be ignored here ? Should I finally squash PATCH 1/6
>>> and PATCH 2/6 ?
> Heh, and there's just one of the issues caused by your ABI break...

Conor,

Would Russell's suggestion be acceptable for you ?
I mean, this one:
https://lore.kernel.org/all/ZlDMNkdE2jmFgD8B@shell.armlinux.org.uk/

I could implement it, but before submitting it I would like to make
sure that it suits everyone.

Julien

>
>> Why do these names even make more sense? Where did the old names come
>> from and where do the new?
>
> Thanks,
> Conor


