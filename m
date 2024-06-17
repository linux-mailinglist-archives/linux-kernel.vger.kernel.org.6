Return-Path: <linux-kernel+bounces-217190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8E90ACB9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA581C21A70
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E335194A6A;
	Mon, 17 Jun 2024 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyjETrKB"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB8317B515;
	Mon, 17 Jun 2024 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623083; cv=none; b=AGYI5WkAppdE8N7Azks87m5ndTnf7btS8/YLxxHSXb7RyRqJ0eQud1chWVNZN9dUxjVlBVz6AIyI7odtyNabgV61cbXclRW4XXRjCo+AZdosYsaa3sU+o/5+vvJVyGqIYUxR90mNAUtEIqDGzH4B8gLQ7y2Bs+IfDP6dx12LbEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623083; c=relaxed/simple;
	bh=1R/gFx9Klqha3kU9BqkNKnQ9gJqwp56eACgbNepYfSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzJP+oq0skxk76r8C5o7dFuW13CZ7powkJ3Wx3jbRfGVL9SdZ2vJfB9jnTZv3HXWRw0+OXICt1cW2Awgh425S/fBbj1+HK9NoIJQYTsrHo83xGOQtYtrjJmEe0veyKaJB/lWwxyQFxs0RB5pzpbXMchzWBjGjoMS/l2LGgCuZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyjETrKB; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7979198531fso316542085a.0;
        Mon, 17 Jun 2024 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718623081; x=1719227881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R/gFx9Klqha3kU9BqkNKnQ9gJqwp56eACgbNepYfSU=;
        b=cyjETrKBQFV1N0uE1pP75Dces+BM/NRi5WYQQbiPX+6Q9cZsRYt0Q556uqlQVFeP95
         I1M+uLN9M3U5SHuFMTiaEYElx8sUFKnq/hxOCQcJ4VI4ilxGvnrMRTZhux9LCHiKP6mq
         b1h9fgXhiunRiut0zIuakuQrHInx6ouO7YZGt4sUVRNkdgH7heKJBAhyL8+nFWvp/vMh
         rcDQtS/5U4DwIIUrW3PK7WR2GuTgH/THQlyjmL0oJH5dZp/E4JHBo+TSQJGvYIvIBZu0
         S9qn4jhmCL5L8KOwLejacWXM4jar76hWk/cuqLD6nR7kR1Hhc2aSGGuq6BruTfbnEmgh
         pEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718623081; x=1719227881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1R/gFx9Klqha3kU9BqkNKnQ9gJqwp56eACgbNepYfSU=;
        b=W9EJkNWnZ2pw7BqDNhm38w7Le8KnP8Yso6/NpE3pFW7Y9F2ouzbhz28MO9/3BbJlby
         pf4zL9jTh9AJwhcmKGxxpK5T4ihHeknG3Iy+BkVl5bOdHvhs4XU/Se3wxPpmbgLhyoFX
         EeloUSM9Snl2j/OL+CUojnEDoiyBkU44zi9BQBc4PNQUQUyt+Y2SBlldbLN+BujS7O/3
         7M6nnjikJiGwHZkNbGnyK4SliAXYW2dcBgYqtc5NbYmGrKsVD9Y0TEXmKci6tFRvrlhf
         fABJDxHpY8Zxco3cdlRZbPLFc8p/sccKht1fP0fkLAKI0uWomn2O5dr+sAm+HHZ5x2gr
         N+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYfDkF+jCRZ8p2FgRrg9Jv3NvNS7swBzMQYYHqqWDRoqzLfkAGrcxkDo0ksiFMKG0zHnyEyp+nxuPujsrQWXa8SD5qpEeBoG96MCfVWQEOOx5o8FoR42bFzRltVrWaOjcDzOy/25kXCA==
X-Gm-Message-State: AOJu0YwdIJnSR6aokA0K4vsqhLjfZ7x+cNzDGhJfwRwHB92BxRbOq0fc
	6fOSggYe8YVLV9aunXgrdp/r43m4pCx1xrl6C/RsvOzkucpLmGGQ66KVdfI2pPQ0KtQNlvJ5ZwI
	HhoVrAsIXi+FRWw9lBrfvoOyT61I=
X-Google-Smtp-Source: AGHT+IEyItUZz65B+zlSMBk6nl6Jg+t2tO7sCrLH5kOIrqFG6mZo+hISsRlvGiuQURieKYYrFVyjFrnVdE8+V+gytkY=
X-Received: by 2002:ac8:5a8c:0:b0:441:560e:4172 with SMTP id
 d75a77b69052e-4421687b4f3mr86953841cf.15.1718623080712; Mon, 17 Jun 2024
 04:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-5-jacobe.zang@wesion.com> <feeb8dcd-661f-415e-be08-afe175d0102e@gmail.com>
 <TYZPR03MB70012C66B789B09195FCD92580CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
In-Reply-To: <TYZPR03MB70012C66B789B09195FCD92580CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 17 Jun 2024 15:17:50 +0400
Message-ID: <CABjd4YyHUzm4EBPPzia5VRXGvJiXDObDHQYNCjpCMJDs=BqALg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: rockchip: Add AP6275P wireless support
 to Khadas Edge 2
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, Nick Xie <nick@khadas.com>, 
	"efectn@protonmail.com" <efectn@protonmail.com>, "jagan@edgeble.ai" <jagan@edgeble.ai>, 
	"dsimic@manjaro.org" <dsimic@manjaro.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 2:58=E2=80=AFPM Jacobe Zang <jacobe.zang@wesion.com=
> wrote:
>
> >I'm also wondering why would adding a DT node for a PCI device be needed
> >in the first place, given that PCI supports device discovery?
>
> In fact, I learn that PCIe bus devices do not need compatible to probe ju=
st now... Before sending this patch, I committed the code that added "pci14=
e4,449d" to vendor-prefix.yaml and net/wireless/brcm,brcm4329-fmac.yaml. No=
w I know the reason why my addition was rejected. By the way, except for th=
e compatible binding, is there any other binding that I should remove??

If your PCI bridge is functioning properly and if your WiFi adapter is
connected and physically enabled (in terms of power and RFKILL) I
believe it should be automatically discovered and you should see it in
lspci. No additional DT nodes needed - but check if you need any
additional DT property somewhere to keep the HYM8563 clock enabled.
I'm not sure your pcie@0,0 node is needed either.

Then it's up to the driver to recognize your adapter by its PCI ID and
attach. I guess you'd need to extend the hardware IDs table in the
brcmfmac driver for it to attach - similar to [1]

[1] https://github.com/armbian/build/blob/main/patch/kernel/archive/rockchi=
p-rk3588-6.10/0801-wireless-add-bcm43752.patch

Best regards,
Alexey

