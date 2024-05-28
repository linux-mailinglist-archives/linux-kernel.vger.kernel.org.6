Return-Path: <linux-kernel+bounces-192140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9418D18FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC021F25D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E244B16C85D;
	Tue, 28 May 2024 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dlrQvACE"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A816C455
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893660; cv=none; b=BSFvblF68aRqsUYofIV0Jmz28yQ7QB1tI10XER/mRZK05DPDHK2iB58DxkN8jJI0CghgIzFR2VHax3UQVGEK0bPoTQXsLqQ4qQF6FRz8mgC9DvWzV83wcCoySbiBWUEF89grxVA5zjXDcsE2zDJb1iogxxVzNogL86KCcM8HmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893660; c=relaxed/simple;
	bh=6DsDltk3tw6ZUlKan1Hi5KU8wAdc0A7pjp2K5oIFm5w=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f99TnE8v2aT8vwEYOZ45e5ZSO1YJe5Db41C7kEP8XiZgrKXFz6qOGF6wVej9iol9NhVEkBem61zglwQN3HhMC1UcxyaUQQrw8Zds7SBC2bSpwiB40F1lKfpByPz46OFPU8QEPxidFTjYBBqsv12swYa9pTVW37sOQF5Q0bHYWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dlrQvACE; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 008E6424BE
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716893654;
	bh=t+MxTuy89r1XuUchAjCOh9jZjiiQ9E0Lr8aKDQQ8Cs0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=dlrQvACEix3tkkCTVnzmCmdJr4ZfoNHp1zrfsk9beHxf4aQqnGNHibu8t2yWecSji
	 ghjebFTmZJzsgLux1g8nbSchrDVHa8WEoCWx2mBzxY/re0wJ307+4OERyD5nwieTV/
	 979lxYykQN6ZmMFjMiWVHM/ZBiKZ6Ta2XCFK9j6KA7dK5KuLUj3owmeJDyRknT+JpK
	 IY0q4v07Iq55thKlaT0Tq3U3wEjNUoLj2x4M7kFBFFRYL8bSWaO2vCYHwx7AkzENjX
	 naeF+J/bRuPXjWi1sxVDUAlf0LTlkGyD5hvbvFBmGDbhHdQYvIjfJxn+GokOvpp/nx
	 eiREY3GUrRXFA==
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c9c4a2ae6aso764978b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 03:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716893653; x=1717498453;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+MxTuy89r1XuUchAjCOh9jZjiiQ9E0Lr8aKDQQ8Cs0=;
        b=u1pF4b8Hp8eqCV0yycQzcqeQTbjurtbpmoQmJ7JrnRiaYd5ZPTCckshnDMaesSSlii
         XREPHCL2/Sf7Wt0Zu/Fsyk3sP9B3tmQsCtFM3850p4+OWbPlWZskrL6gW0BwcdEyevi2
         zdoRTwsC/VjgsCtZ39EPDLiAAduxT1pLu33fLd2iL1F/DkruLmFJrxThKBgiqoHer3Oa
         fXJvG7I1VSxDr+DydUpnpW9rkpO7RX8eFBtiXLDW8Pwe6N3ZDsWDtaLIJ+BtvEzBtFQm
         xRyZsD6Ul3C7RGoavNcg1Rmckv5NV6GV7qlnBiw4WWnUiU+gFGo+BZp5gxym0IJCNALa
         uNhA==
X-Gm-Message-State: AOJu0YyD6GGYTsDB3rJcPzzD6Hc2ba5Nq2bED/cTsgSne7xpHxZPwx7f
	iBg3XcoTGFFYW7zCyCioN0a0F7drCAHxS+/EGYGAQ5q4ZeEJa8T6OmV8tcaKYsgGsw5JI4GowvN
	saOthCPxqhusybHwpxIHqzSk5yIHO70K1aQLeiwnIV4E08BKWE3sbrPRZVY/2Bjt3pJ62O4bwUd
	nmpcFdB3B4n+vOYfBbFwyFlEDGih8tJ/4ufy+RqoZKEkvfeDf4jyqv
X-Received: by 2002:a05:6808:13c3:b0:3c9:6987:1799 with SMTP id 5614622812f47-3d1a7c30f2dmr14667507b6e.55.1716893651286;
        Tue, 28 May 2024 03:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRnQ2YYO2njdHSKr+gsseo2W9USVkHj8m9Htc1vxAMSS1DDFiKtyDLGfxlb2TUj9R9LX16696Z0LisylVtCkk=
X-Received: by 2002:a05:6808:13c3:b0:3c9:6987:1799 with SMTP id
 5614622812f47-3d1a7c30f2dmr14667457b6e.55.1716893649577; Tue, 28 May 2024
 03:54:09 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 May 2024 06:54:08 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240528015120.128716-1-minda.chen@starfivetech.com>
References: <20240528015120.128716-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 28 May 2024 06:54:08 -0400
Message-ID: <CAJM55Z8KuzCMEqE4x2rsoiJTjkWhf-B5bCzaWMhbtDndZfNNOw@mail.gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: dwmac: starfive: update Maintainer
To: Minda Chen <minda.chen@starfivetech.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Minda Chen wrote:
> Update the maintainer of starfive dwmac driver.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..2637efd7660a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21316,7 +21316,7 @@ F:	arch/riscv/boot/dts/starfive/
>
>  STARFIVE DWMAC GLUE LAYER
>  M:	Emil Renner Berthing <kernel@esmil.dk>
> -M:	Samin Guo <samin.guo@starfivetech.com>
> +M:	Minda Chen <minda.chen@starfivetech.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> --
> 2.17.1
>

