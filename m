Return-Path: <linux-kernel+bounces-354921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E40994496
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607001F25EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DBC18E368;
	Tue,  8 Oct 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nmlh7FCL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79118C345
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380660; cv=none; b=ctHPtHlyaj1UZYlxbrcznJ/83A3BSyO0SsYBgaulpKReD2BdGciPSzG3nmEM6rV38tnyiHSLQCIUX/KcxsvXeQkOvBx7UzigAlMTT+cMMt+TlMg50rpIZyfusPuyurdz4uBXLspVFv8FvFLEW2Qx4NJpi2D1lRIGukIThhS9zdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380660; c=relaxed/simple;
	bh=SDDLtyGwN3boJU9vuDQmf/lWBtfwjCJZjBYvHpbuZ8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqYN/uxurigOsnJLNQ5N9qYhmjbGYKXx54UDzRGk+OrOpeup9lm76ag4QZBfaAAxW51vdqzTcyn5C9zMhfaiAdydhWUjeuJgXsPeLzYHoDdH+P7vlGDqGFte9BiTra8jtOP/P0Dpk9NxSl1wI6dzuo75zURHvm4RElNmx2nCLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nmlh7FCL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728380657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BX5Wg/uFyRBw2TJnom7CLx4mNcqX+J1yoWEepUCTp/c=;
	b=Nmlh7FCLE5zq+yLDzuMdTpX8Y010FRd4UTip/FwepyuyKrN8RwDcQPPotUfw84Z6oPtwWg
	y/8jKeWtVBKbxpdIhIO3eNok66lBSbCOXjI12EXKQLWM7ztRXEmVsi4Tawk39l54Kd0UYe
	cpgsd5AU2KOi9I85awmLZWP9jER+I/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-vw1BFP7OOlun20-Nr8gU5Q-1; Tue, 08 Oct 2024 05:44:15 -0400
X-MC-Unique: vw1BFP7OOlun20-Nr8gU5Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d34f5b140so115384f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 02:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380654; x=1728985454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX5Wg/uFyRBw2TJnom7CLx4mNcqX+J1yoWEepUCTp/c=;
        b=KUMb1DCv5IYmzyuTKKrF1RuQICyCHpUVPXdhjINqag0BJcpiX1UnvMNedp2H0GwGvD
         bsa1X+6fHyUTILJ3+ZKRmEUUtbNgWweNuRM27zE4B0krQQh3AaDZEHWISpDO/stXRLNF
         6Y2adCajs45iy9pNC5+t3s/pREAffh3+Gc4c12MfiCZrDO6lZrGY//IbEFzjuqeXmgbt
         UYVAb2h/FPD8t1xYz8BIAVmlkwVwq2F0hjWxn+aMENBGD+g8Erd7ZfA/TLZQl2X76C6k
         9/Hdqntln9R11mS6H8r8vgZY/s87WjGpgu1QNGGWgOtF0Aewj/JIiRD+Iv5/7UFeI30y
         bqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC+va/66akqTrkgGVoB+m0mory5lA5GfqRcgl1tvg6bTk5kzQi3bP9VDbESW0thH1aJg/fHtI6Cl6yd0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08ocF8fSOGa4Pqqz2n4w6/QOpfx8RtbsfeFI/XS8S/oYo03w6
	mqIijBB0VnBDr76uAvawxeUqq3eG5pL6G4DA8h9W/XdJGEwrSMcItphN5vspGmRmW3LCVvKBEGf
	JQ78Na+3IRWAm6r5NzTNIB/D4btFf4TNyOaAmZ/qKuqmg6Q4lcdIbjaljmlOCeA==
X-Received: by 2002:a5d:526d:0:b0:374:c1de:5525 with SMTP id ffacd0b85a97d-37d0e6bb844mr8595637f8f.6.1728380654550;
        Tue, 08 Oct 2024 02:44:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE0ymeMn3DM2N0eULYBv2CdhcxLdElwe23PHauaKbNKnWEklD4+BLjiRWhCHYTYJucujP0uw==
X-Received: by 2002:a5d:526d:0:b0:374:c1de:5525 with SMTP id ffacd0b85a97d-37d0e6bb844mr8595617f8f.6.1728380654086;
        Tue, 08 Oct 2024 02:44:14 -0700 (PDT)
Received: from [192.168.88.248] (146-241-82-174.dyn.eolo.it. [146.241.82.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1697024fsm7658040f8f.95.2024.10.08.02.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 02:44:13 -0700 (PDT)
Message-ID: <460778bb-aa3c-4b5b-9bbc-a65833b9035c@redhat.com>
Date: Tue, 8 Oct 2024 11:44:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/1] Documentation: networking: add Twisted
 Pair Ethernet diagnostics at OSI Layer 1
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Lukasz Majewski <lukma@denx.de>,
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Divya.Koppera@microchip.com
References: <20241004121824.1716303-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241004121824.1716303-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/4/24 14:18, Oleksij Rempel wrote:
> This patch introduces a diagnostic guide for troubleshooting Twisted
> Pair  Ethernet variants at OSI Layer 1. It provides detailed steps for
> detecting  and resolving common link issues, such as incorrect wiring,
> cable damage,  and power delivery problems. The guide also includes
> interface verification  steps and PHY-specific diagnostics.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Very nice documentation! Just a minor not blocking note below.

[...]
> +- **Next Steps**:
> +
> +  - Record the output provided by `ethtool`, particularly noting the
> +    **master-slave status**, **speed**, **duplex**, and other relevant fields.
> +    This information will be useful for further analysis or troubleshooting.
> +    Once the **ethtool** output has been collected and stored, move on to the
> +    next diagnostic step.

Likely we will have to reword the this specific ethtool output at same 
point, and we will need to update this guide accordingly.

Cheers,

Paolo


