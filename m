Return-Path: <linux-kernel+bounces-554408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 433F8A5975B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17C53A7A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B622B8A9;
	Mon, 10 Mar 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKJBeT75"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D41A314B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616339; cv=none; b=rzcQaEN7cUpP/vbJtSITr2jQiRffYGZeEe5fAcm1K3EwfvFfqY0Cw12taxT0s8Tevo3/TxJZvh3odkLa7AKRW9Ty3GJXm55sEeS/2YR7jgaiJfpGzSLwQk9NmLVzc7LyGRH7wrvRDmQk0baf++WIZkQ5Wur8qHiiQMq3IvQvD4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616339; c=relaxed/simple;
	bh=BihBgh7TS5XLevpqxnAYTnNGMNQHGuA+q5aCD6ZoHl8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UdXJ7L3nFNUooaJHLdMrwPNGaayoXlG4WUXrLaw4MKwULfckDCBB0W7rqe5os/X26dN/2X6mHHi1MQ7u1f9iCfVqmU03iRBmVM+Ci1WS6drSL5EXFqAZBRKgni3no0uqghXzmK3uVLNvh6NrFZFTE8E+9XvuKwPNs3z+sosvsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yKJBeT75; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dc191ca8baso888439a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741616336; x=1742221136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+EZu2FAVpE4rN6ykqMMomZc+KrMKXYrOxtiXGRUCig=;
        b=yKJBeT756fe2lGkYV+XiR/3NbY96FpB567cVRq/Jj3BJGCdC3eeWEeHCw4UOxodoca
         2fyC3MSVLHDl4IgZ53gAOPBLVfDStx9Zac+GZsuPLjG9rx8plQTXWcSOrga+akIG0yBC
         kHuNq3tP5Am/y5lpt0TLkhDxK1vez6HFQVYAW8xTmDt1QZp8fYj2Kegb7cCfcgW6w6wi
         QL7L2fwhhlY+fRfWBQpFKJ+bHbiBnYWmyahdr2ChtA1GzeETY//38+dZHindCfnZ98B/
         h3YE48/Vl5i7O8ilOcvzaseMBzyYeQE0/DiePp8XFfl4ecWrSoPZbTezES6pcyqGtruw
         FIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616336; x=1742221136;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+EZu2FAVpE4rN6ykqMMomZc+KrMKXYrOxtiXGRUCig=;
        b=TVsVfKlkdiuw6BhC0DUzufRXj/umN+IHngv4eEk96JxoY92St7JOi/ym3Kja+aCdS0
         tK5GmBT0QJBczfpdUvmkByjOccYgAg1jAAYA3fCYUQj+bPa91BcUOw5b9WJ30WbD4jIq
         2/9zZpoeriaFvEGDGdTcaixusJtL5uldIwkJ/PGFn51qDvqrS2mIbAaQrW7U4ycMnvGf
         2art0XU0z4Tzu82a6pDP/jV5p+dQxT86mI+w4TzFpo85Cgo4HJv5LCUD/NjCxcKjCy1S
         yaNGgOeYkj5W87mC2T5Wyq3c1hHIptbL0Bf5A5btASaZrgveUCSpjrnSnIjJmSPyiCjA
         ig9A==
X-Forwarded-Encrypted: i=1; AJvYcCXfoyAfip8I4oj9wmhb38Gpo0lxpLO+FtFlkYfZPk2p02P86cEw3DL2KlpaI6aFdBB0FjpK6Mo41PMw0Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwswrDm/etVw40GlKPje6ryAt6++cqChKfKLeI9u4s7yrlj29
	HO0ZYTUTnsZChoLnyS4cpy92vLZ4uAYuKtK3jYXrlUu1XlV756u4baPQ88HeTLp9hBshmtNhmcm
	zfT0=
X-Gm-Gg: ASbGnct1EiMK6hc3OgCBk57SbLtXDF/36K6BOLCF906K0xfgPpyoM5h3BeXU/HGZJc6
	eoeboiVQ7oQz2BXxIQnx/8zBSUqJXol5fB8pYY5C8xDIU1Jwv5ljz6IqIjsrLda00/dOZvSlwGL
	yO+MdT7LjEb4uJ68Hs1CG9jVkptozFf9qUzYa4HAo69SOzbxighWqAAdaTBw26lEiu5JmK3BZ9N
	lJVcZioZov4yUsCjL9EfyiNba7MbU0YV5eG18WFN+/SESFrjzEHT6WOSiPMX5jO+vN1S1Oc2OVk
	XyBl7Uo4cnK5z+bdK40lxwgczfuPupCoqyaXsEq3E+gtgOVGqlHhCOEcPKtY
X-Google-Smtp-Source: AGHT+IHS0jBvu9XaHak0lQufHDfvzvcPfBU6Anyh683mM3GmEZy4fDxzSj+b5ABDl3rLWTDSOFRSVw==
X-Received: by 2002:a17:906:478a:b0:aac:619:6411 with SMTP id a640c23a62f3a-ac27162dcf7mr355324066b.11.1741616335619;
        Mon, 10 Mar 2025 07:18:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988e590sm763446566b.150.2025.03.10.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:18:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Xueqi Zhang <xueqi.zhang@mediatek.com>
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250307054515.23455-1-xueqi.zhang@mediatek.com>
References: <20250307054515.23455-1-xueqi.zhang@mediatek.com>
Subject: Re: [PATCH] memory: mtk-smi: Add ostd setting for mt8192
Message-Id: <174161633416.57206.15365261153795396869.b4-ty@linaro.org>
Date: Mon, 10 Mar 2025 15:18:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 07 Mar 2025 13:45:08 +0800, Xueqi Zhang wrote:
> Add initial ostd setting for mt8192. All the settings come from DE.
> These settings help adjust Multimedia HW's bandwidth limits to achieve
> a balanced bandwidth requirement.
> Without this, the VENC HW work abnormal while stress testing.
> 
> 

Applied, thanks!

[1/1] memory: mtk-smi: Add ostd setting for mt8192
      https://git.kernel.org/krzk/linux-mem-ctrl/c/90a0fbaac4a588a1116a191521c3c837c25582ee

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


