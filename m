Return-Path: <linux-kernel+bounces-427951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4AE9E0848
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7674C16ACE3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1609313B2A8;
	Mon,  2 Dec 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="einLBejf"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A363FB3B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155309; cv=none; b=b9BCp15nL/zy7zwFwr49E+GANrvprMns1psA1a9ZFuwGlvDB8S1aiiYSbyS/vHw8ny+qs4yQ7Ajq2d4zf3VFqQOZlDm/eRKfZ+uTlBRud6TlY0A8SyG1QB+xGFwp1qfMZ6K1kz5rkpjlETLLbGVRoYl8s2LNUh6D2SJFWhqXg7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155309; c=relaxed/simple;
	bh=25x8yzFcj40Yv7zT+NkMhOxiPU4nc3mDL/BfwbtHUYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YD/TTZQmaLrui+2jM3yWolYu4d6/VHtoc3e7faq5BZKtJktfJfCn+BQjrQYq2/Zjz4L0kJ/BrS1hWgwXudldknEejKQAw+36oR8UIbZCI9nNT+22s1UHuyX57hv19wuJLW003eOS7uZ65fqZV7739V8RDY1kltX800fNlkYMlLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=einLBejf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa52a5641f8so637129366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733155306; x=1733760106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KcIwgDwhH0r2JEAbp50oSCByWlOCYMPyzaBWedWcxxE=;
        b=einLBejfkoix3/hT+DvRNx4WweXLS+OI/E/V54ggg4YZICuugroE7vur5aYrURm+VO
         DL8iluvVMhrgfOx80zE4bAnOxejtwJadOAv9B533I+iyQDM9u2JJddx6EKe4VPrlci/D
         XfCyPYbwAg62FskO+OlZYiIL7g0vbGdcYWHsoIpKK7S8bfZquDAQHCSElyY0ATL26wtB
         DQh1Z+lHOEcfMjmTpygVVClrvCbxpp3vnv8hoHvLq6Jul5d5nBNg7TIoG7u5FMK15CpK
         bFpIegcdMX1MFkoLaS1Pai7FcjmS2kHziOBi8hecWhMr9WactyvbpRkk1JjtDsdhBthn
         ceEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733155306; x=1733760106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcIwgDwhH0r2JEAbp50oSCByWlOCYMPyzaBWedWcxxE=;
        b=A8wdrmvf+7oPIawFhEoea8M9/Qe7DdM7H+ps4D2d+xfUJybJ0WbFXR75DfEQUoERGd
         6whVx0B0FSlZilUujgcdxS2BujkqOFLn2J6SAcf86SeT6rwE5xrJteB0qGmT58IEfgvS
         RE7YhLXMrIdgo2sEzZ00DORBhvFn5umSIZgbaCTZa4D/7SzPu5P6Ti6W2LSgaM4UO/N+
         13d3SLWOUIwXiPiLDkzbWgaM2pfpyH0QbUpVK7zd4GwxZpzFd26Ri9KJiS21uy7guEMQ
         nodVN707RvUfw5cpi7pvjDz6ogN9u2oNm44R2jxq0pUyHUef/N3X0MQwM3LInAmzuGTE
         iwuw==
X-Forwarded-Encrypted: i=1; AJvYcCXqEDOdYxpALDU8+l5UYeyp9MfwCEZ2xschdG3scbJKZJWjdQUf8R/MWEnL9/+ysZapqDdlRc8of23jMTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbCb/IwM9ksjVW6zXQXHNGDMAP9sdqR+nVp0XjP8eseo4JXC/r
	nVrt8+UoQaOQZ80onhCbNSsmk5h0Hv8W9tzAUPnz3/yf+esZpZDatcPzPutHYSgVvyf4p0PvEhI
	5RhKu/kq0vKrWwNaZwU3BdsZQwXA=
X-Gm-Gg: ASbGncsoMmRaS4l0FKOaVPQ2FpZ+wrCe5FvGIHyP5VwVMHiilJf9NAdjA47avjU0REf
	u6CtnAyTIa4JfWym7OsNjAJGFHn5/t6vY
X-Google-Smtp-Source: AGHT+IGFABNZQaOPRburPWloYkSi4CpGPxba8eF7BykGzMmRWWY/MWtNoKOUl7owa7F4QGuaqVaPpnIxNrEo8kH/2NE=
X-Received: by 2002:a17:906:846c:b0:aa5:2a71:1646 with SMTP id
 a640c23a62f3a-aa580f56a7fmr1829897466b.33.1733155303815; Mon, 02 Dec 2024
 08:01:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012071919.3726-1-linux.amoon@gmail.com>
In-Reply-To: <20241012071919.3726-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 2 Dec 2024 21:31:26 +0530
Message-ID: <CANAwSgSusXfr73LNySLJVnYPDNsyYmK_=2+YXAwm6bLE+NsWdQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] RK3399: PCie Phy using new helper function
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Sat, 12 Oct 2024 at 12:49, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Few clean of the phy change and Using guard notation makes the code
> more compact and error handling for mutex_lock/mutex_unlock.
>
> Plz review te code changes, I tend to do silly mistake.
>
> v1:
> [1] https://lore.kernel.org/all/20240901183221.240361-5-linux.amoon@gmail.com/
> v2: Fix some typo in the subjects.
> [2] https://lore.kernel.org/all/20241006182445.3713-1-linux.amoon@gmail.com/
>

Do you have any device comments on these code changes?

> Thanks
> -Anand
>
Thank
-Anand

> Anand Moon (6):
>   phy: rockchip-pcie: Simplify error handling with dev_err_probe()
>   phy: rockchip-pcie: Use devm_clk_get_enabled() helper
>   phy: rockchip-pcie: Use regmap_read_poll_timeout() for PCIe reference
>     clk PLL status
>   phy: rockchip-pcie: Refactor mutex handling in
>     rockchip_pcie_phy_power_off()
>   phy: rockchip-pcie: Refactor mutex handling in
>     rockchip_pcie_phy_power_on()
>   phy: rockchip-pcie: Use guard notation when acquiring mutex
>
>  drivers/phy/rockchip/phy-rockchip-pcie.c | 148 +++++++----------------
>  1 file changed, 47 insertions(+), 101 deletions(-)
>
>
> base-commit: 09f6b0c8904bfaa1e0601bc102e1b6aa6de8c98f
> --
> 2.44.0
>

