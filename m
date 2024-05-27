Return-Path: <linux-kernel+bounces-190217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE2D8CFB65
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9CA281679
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDC35490F;
	Mon, 27 May 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EaDrhefw"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72F46453
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798500; cv=none; b=h9At1SW2qs0qDUXjp8rHNJOwofgdnfko/xkMWCxoYZuyM0xEb0OjZ6GaHcRH8SCBaIfxgawwgN9uuyITWCnm0zQmRUlWA0c0F+sLMoIu8dfzKDNoBG6qX88lduMcU7arXUPpQohujRlPburNpRA5x8R69jExbeqr6pCeSxq8S/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798500; c=relaxed/simple;
	bh=I2dFfh26l+6htx4A2es4uMpapQ+YgW1iGGGPGSM5nX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHseAOAeLov2vrFnjzblIFgR0AWBkIl3gSYuPd6bj+4MocDVim6Ch54yDkoORDZRXnXhg4U6AKEzJ63G99yk0/pj4SO3w9OHAZh0l4Gx32Bzs4YXKzjeG3HPRqRb8akBdG7hd8AwQJU3Ak0suhBw66yA1B9viSHfatIyJT45tgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EaDrhefw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57863a8f4b2so2494109a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716798497; x=1717403297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nD9laAvbqQPSf4T3VBuD4yAtj5SB6o2Jvt0/iLt+t+k=;
        b=EaDrhefwIaG00q4eN9sxH+Nrep9893hsQJLzbxaK5Jtx8UKjbfYrAMV2dKKbD4iRZl
         9VEwy4XDq+5tLsxkcNShQdw2MIEYc+3iYcfhwKKTaT7DXQu0R6rmBsK67Mdm0GjrHPTy
         2/CzBnVYBqbs7UtolIsMXW42c7XnUpyJMHcBnZQUxpq9Xx+sG29rjufM6wniWt0tiBCG
         uouGa/w3A+OKaiLROEtrBgTja4YrvEgMIPDhhrC976OEAu3U0/gWr3WNT7dJweLfk+TZ
         c8i/FXXwtfv7XF3l5Apy2SwX62ibPJEwRDGpdlDazlVYWQNMc9wwHmooR6CAUi6piwFz
         El3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716798497; x=1717403297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nD9laAvbqQPSf4T3VBuD4yAtj5SB6o2Jvt0/iLt+t+k=;
        b=dsIf6tLXANgrld3lg8bQeYzEs0shGJwMgG7y6plLwB8lWA+24PSLbWQAywe7vx7cxP
         E3g5c+7WULkiDSUkcNlfm+R6yikYrS1F6RNX5aVcy1EkZkwqCF0tzrKiPPAhaSrZbOn0
         Dz26RMnZuiNXxsffZ6d239wFn0JMRgHR7SqTgUZYX+JhH7SOoiFlAEl+iwh5GOM3sIwp
         StnZpe2CpEeJ88oW8GFFkcFk/Ujw9+m1RPETVFX92TWTgMWGPLoN5YjbbG7hiCt8qIaR
         wS1y6DiOjnYUO/2+BGFJBq2q8fISl3etLqg8DCDka10PAcbQicSYUehAaAz/noW2x9Qq
         Bm6w==
X-Forwarded-Encrypted: i=1; AJvYcCWM/rPy+hdvQhpbou4JW7+e7Wn+wMIND4u8ek6KYdPK9AzfDhVtpiVuxwofbtF1jbkbA+O8OS8+Sks59KaCeDVS2wEVl/DenQjD8FHW
X-Gm-Message-State: AOJu0YzgITEFtLJ9ExdT6agcX3WeNu7FRMPeiwZDVTP5Bo2s8f1ozucX
	o9hDTOV9tuXftUpg2jNdjnBgfv6hswfjea9on1C2VTeidPrQ53RTgWkY/x6406E=
X-Google-Smtp-Source: AGHT+IGhqSO1/rhzuiLgEOL9XfioS/OqMt1YxNJMb8zzs18KkPeun1uTzC/uLpw3ICBDu9lEfl2Qzw==
X-Received: by 2002:a17:906:3105:b0:a59:bfab:b25a with SMTP id a640c23a62f3a-a6265116f69mr550448566b.63.1716798496875;
        Mon, 27 May 2024 01:28:16 -0700 (PDT)
Received: from ?IPV6:2001:a61:139b:bf01:e8eb:4d8f:8770:df82? ([2001:a61:139b:bf01:e8eb:4d8f:8770:df82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817b15sm464678366b.40.2024.05.27.01.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:28:16 -0700 (PDT)
Message-ID: <a6c93527-fc78-4182-9341-97e2fe0d1ace@suse.com>
Date: Mon, 27 May 2024 10:28:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.05.24 16:08, Parthiban Veerasooran wrote:

Hi,

however you solve this, the descriptors are stored in wire order.

> +	if (dev->udev->descriptor.idVendor == 0x184F &&
> +	    dev->udev->descriptor.idProduct == 0x0051)
> +		write_buf |= LED_GPIO_CFG_LED_SEL;

This needs to be

if (dev->udev->descriptor.idVendor == cpu_to_le16(0x184F) &&
	dev->udev->descriptor.idProduct == cpu_to_le16(0x0051))

	HTH
		Oliver

