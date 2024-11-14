Return-Path: <linux-kernel+bounces-409232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9BC9C895E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C92B25065
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CF51F9A9E;
	Thu, 14 Nov 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Rt4/nLE1"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1E31F942F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585322; cv=none; b=VFgVWBNCQIjyT9mAwcOUhxsPIS6k76MBb35a5wpkbeKl74cFKETuKjmYIbK1htZDcdRESBNsTRvb9nU39R/fS/hPbu/QczXZP6F/DtDZvrQzCUcGiUNJ+9oLJnst4cdg0vBNsVdsnnvhVCpPiOr/N7LNryjIFyVRAbzzbpUepJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585322; c=relaxed/simple;
	bh=mFAbYoNztpIV+4IFZ9jTX8TLDXeEO7op1F9KNzb1l1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axmJoeNIrlLFUhxVRukfDz0loPEOcF5a4k2/XJNKyzVrwlcFTL3bOECXg4XbEE8r8Q8OmYAEt5jvSLq1iB6D9Xrhdq67dYbVCYb93z85jCszN/irfTxObldG4P5loK+VX5+R1hROWrMiNbkQnbznsUJW+CYxz0ugNSbazgfJcVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Rt4/nLE1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so37009466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731585318; x=1732190118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TykqvJZu7oobTkYrqspWrFCa8xwHBaWMCZeSIBVlCZw=;
        b=Rt4/nLE1rEMwBkYzxioe6bCmT4N4ICRDMUUl4fuyaBwzXrHA2bmEo8YU/gvEvs2dEf
         VbtCZgOHmy9qi4dcBzg8B+qA84UBkFlh1jusFm3yImJiswqRF5nWvwDCwEg2qdDRdxcr
         tjFzZ1XlnHKRLa/gZvD2OURBIg0KT7blDjYOAU1cWp+oYdNq7yrY7wQFzYjVFbNUFHFu
         ClObCN1mjTyW0yxd4lKE4nY1K3l7toWOrzX9d9T2I44wJ4O7xcghSZOdz1cu5LUDFn2o
         0NhaR75mxe3wpBueB/WTPYAtHdhdtfa6HhPZzG/xPiD/nBAZdg0RC8QvOc0qgNFFcSn1
         UHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731585318; x=1732190118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TykqvJZu7oobTkYrqspWrFCa8xwHBaWMCZeSIBVlCZw=;
        b=ORo5ad1zU+4JvMvpShMLfnzSVsNV57TdGs2EkuIVxWlVjcHKz2FcMxt9h9+ICJyJPL
         owobMDTwEBiuDoBpgl6Yimw5zMuTbzL9UfgJiSpvTOat4FabS20PWQZkjJk+1+NmlCca
         STY1M9yxha9dxF8nWTqaDNqk3/fYSSXqlPhmGXtUcOdm0AQOuyhglBXjOKIV+PzEA6O0
         LsH2RwL0Y7g8W2z9Q8fJ33n1tGJGRUvgLuQLZe/ZoJXY6gllYjpkz7MfwdluO70T1sF0
         6efRs3u+6du4cRwXgwfqAeRdcAxe5WrdfqeVryBnGtBYYgyQQDx5OSLDtO8r4vK3cYIZ
         00dA==
X-Forwarded-Encrypted: i=1; AJvYcCVXhYrqmEHMQdtyJ4WhEqXMm5OeP2SAulWqx3HA1T2XGMDtIYVeSGfieQCJrK+Jxkjx4RJxJd/4bpS6TWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZj26gVEdCXpp4eGiBt2D8edmCdfPeXNCvcLVXHFYwh5jl3Y+
	ybjUB7CIlB5GWDHQ4LU/lh1LTTeCKGnAHGbnONSHdPC1sEvzOSwU99F0/GRI5us=
X-Google-Smtp-Source: AGHT+IE/1TBRDr0zrGfCx62LhZdMXdC4i7gKZ6O1OikOKLIOjOf9iNHmbMOKdG/5UJAwkvlasJ5yig==
X-Received: by 2002:a05:6402:1cc1:b0:5ce:fa33:6c9f with SMTP id 4fb4d7f45d1cf-5cf77ecc8d2mr1814721a12.27.1731585317798;
        Thu, 14 Nov 2024 03:55:17 -0800 (PST)
Received: from [192.168.3.32] (cpe-188-129-45-253.dynamic.amis.hr. [188.129.45.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79b8a6f7sm495171a12.18.2024.11.14.03.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 03:55:17 -0800 (PST)
Message-ID: <296336ea-9181-4c85-92d4-4cee1866822e@sartura.hr>
Date: Thu, 14 Nov 2024 12:55:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] net: lan969x: add RGMII support
To: Daniel Machon <daniel.machon@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Russell King <linux@armlinux.org.uk>, jacob.e.keller@intel.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
Content-Language: en-US
From: Robert Marko <robert.marko@sartura.hr>
In-Reply-To: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 13. 11. 2024. 22:11, Daniel Machon wrote:
> == Description:
>
> This series is the fourth of a multi-part series, that prepares and adds
> support for the new lan969x switch driver.
>
> The upstreaming efforts is split into multiple series (might change a
> bit as we go along):
>
>          1) Prepare the Sparx5 driver for lan969x (merged)
>
>          2) Add support for lan969x (same basic features as Sparx5
>             provides excl. FDMA and VCAP, merged).
>
>          3) Add lan969x VCAP functionality (merged).
>
>      --> 4) Add RGMII support.
>
>          5) Add FDMA support.
>
> == RGMII support:
>
> The lan969x switch device includes two RGMII interfaces (port 28 and 29)
> supporting data speeds of 1 Gbps, 100 Mbps and 10 Mbps.
>
> Details are in the commit description of the patches.
>
> == Patch breakdown:
>
> Patch #1 does some preparation work.
>
> Patch #2 adds new function: is_port_rgmii() to the match data ops.
>
> Patch #3 uses the is_port_rgmii() in a number of places.
>
> Patch #4 uses the phy_interface_mode_is_rgmii() in a number of places.
>
> Patch #5 adds checks for RGMII PHY modes in sparx5_verify_speeds().
>
> Patch #6 adds registers required to configure RGMII.
>
> Patch #7 adds RGMII implementation.
>
> Patch #8 document RGMII delays.
>
> To: UNGLinuxDriver@microchip.com
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: David S. Miller <davem@davemloft.net>
> To: Eric Dumazet <edumazet@google.com>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Lars Povlsen <lars.povlsen@microchip.com>
> To: Steen Hegelund <Steen.Hegelund@microchip.com>
> To: Horatiu Vultur <horatiu.vultur@microchip.com>
> To: Russell King <linux@armlinux.org.uk>
> To: jacob.e.keller@intel.com
> To: robh@kernel.org
> To: krzk+dt@kernel.org
> To: conor+dt@kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Tested-by: Robert Marko <robert.marko@sartura.hr>

> ---
> Changes in v2:
>
>    Most changes are in patch #7. RGMII implementation has been moved to
>    it's own file lan969x_rgmii.c.
>
>    Details:
>
>      - Use ETH_P_8021Q and ETH_P_8021AD instead of the Sparx5 provided
>        equivalents (patch #7).
>      - Configure MAC delays through "{rx,tx}-internal-delay-ps"
>        properties (patch #7).
>      - Add selectors for all the phase shifts that the hardware supports
>        (instead of only 2.0 ns, patch #7).
>      - Add selectors for all the port speeds (instead of only 1000 mbps.)
>      - Document RGMII delays in dt-bindings.
>
>    - Link to v1: https://lore.kernel.org/r/20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com
>
> ---
> Daniel Machon (8):
>        net: sparx5: do some preparation work
>        net: sparx5: add function for RGMII port check
>        net: sparx5: use is_port_rgmii() throughout
>        net: sparx5: use phy_interface_mode_is_rgmii()
>        net: sparx5: verify RGMII speeds
>        net: lan969x: add RGMII registers
>        net: lan969x: add RGMII implementation
>        dt-bindings: net: sparx5: document RGMII MAC delays
>
>   .../bindings/net/microchip,sparx5-switch.yaml      |  20 ++
>   drivers/net/ethernet/microchip/lan969x/Makefile    |   2 +-
>   drivers/net/ethernet/microchip/lan969x/lan969x.c   |   5 +
>   drivers/net/ethernet/microchip/lan969x/lan969x.h   |  10 +
>   .../net/ethernet/microchip/lan969x/lan969x_rgmii.c | 237 +++++++++++++++++++++
>   .../net/ethernet/microchip/sparx5/sparx5_main.c    |  29 ++-
>   .../net/ethernet/microchip/sparx5/sparx5_main.h    |   3 +
>   .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 145 +++++++++++++
>   .../net/ethernet/microchip/sparx5/sparx5_phylink.c |   3 +
>   .../net/ethernet/microchip/sparx5/sparx5_port.c    |  57 +++--
>   .../net/ethernet/microchip/sparx5/sparx5_port.h    |   5 +
>   11 files changed, 488 insertions(+), 28 deletions(-)
> ---
> base-commit: 12079a59ce52e72a342c49cfacf0281213fd6f32
> change-id: 20241104-sparx5-lan969x-switch-driver-4-d59b7820485a
>
> Best regards,

