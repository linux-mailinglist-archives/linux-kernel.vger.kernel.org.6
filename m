Return-Path: <linux-kernel+bounces-442728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05829EE0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6E8D168314
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B736020C018;
	Thu, 12 Dec 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRKccMB9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DA520C008
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990903; cv=none; b=NI4fC9oXxBSWB+RxMMDiyBnAQjsPlAwBtc0P0o1XKO8JqRG0cybuElM306Sqc7mI86qXaMiKXNP0Wpky6WyBzPZfn+3bHDPwpNS5IbuesPwlY3TVtjKendLWpnsU516sHvdlPHKXRJIKWR7twAzgz9P3XHe0aycmdX7m8b8N/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990903; c=relaxed/simple;
	bh=4zY98UHHGfgFUFQXkyrd6VkTOS0moSnEAon1VWvcJWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIi7+oifBUut7sUZISxVbSLwZbhUR9v5YKCFC5++Eg05U53AUpXwcS9bD7pWwWK+kRRUwNS+IZmP6LGTNIInjjf/jiWYWQd79O1E3MWM/LQFW7RLsIGavIkOD2r2DVpwgTI3lyHt+FEVUmaAOQVO1xUYGbDNGyKm5F1X/ZdjeOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRKccMB9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733990899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bjf1nmOaVLrku/wXD9lDjECZxn/Olb8fTnRITGTTN/E=;
	b=eRKccMB9S/K/gLAn/D4QJP+UX3uFs2y71HpcCjFpzFEI/21EEpjNeBlbfrBxR956U25OZY
	7KYm0CNYHglB5E1BHmjSfL5JmVi6908tt//juAIsmwhGzI+kt6t9t5mYrrWoBfTkidjjK2
	Pp/S1vrEc8sfmdjAgfo8vlL0r+BXu2Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-6Bl3i5vVP4S_qyzex_8RMQ-1; Thu, 12 Dec 2024 03:08:17 -0500
X-MC-Unique: 6Bl3i5vVP4S_qyzex_8RMQ-1
X-Mimecast-MFC-AGG-ID: 6Bl3i5vVP4S_qyzex_8RMQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4359eb032c9so2449165e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990896; x=1734595696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bjf1nmOaVLrku/wXD9lDjECZxn/Olb8fTnRITGTTN/E=;
        b=rl0qsXLd9MWWHmjat/HTjP0ftYOaM2xB1WlfxKTUjINvV9mfsjYqPQvdTNtKDtefe2
         mVVsLz2V2QIJJJzNOsytWjcyi2e+KmNbzLjGBMs4dekekQy5pcWubKCRVqn30N3o5RCW
         8X8qwVq5NTMGwbIOsEa/TtmUz17BhSKuZinLpQA/l1oyRwOULENWoxOB+qZalwFs0Hsr
         TmoM6eJVclCO2RUNm44QMjzHecpAvVi/SIpmcUU2FEicyDfOhgGLw1+B9Z3MmRnE714l
         XtreKYkdu49BeWnn2MRjOcTimceXJfprC+qfv7jL1PJiHxEP6NP+fQ+OrPMtXx/NmyU1
         gjag==
X-Forwarded-Encrypted: i=1; AJvYcCV1jLz3L/KnPo8yXfCiIACAUfDF94iyWGjSc5fa3h/Pid3a9fcw4AZ6VZrdnB7RE7qe4egfxO/C4QGZS6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YycOeWk6ooyFKU/nB6slV/tLQYcJZd/seV6LXSgl52y3HExjEyy
	1OX12k1CZEC+f7XOw508kDR/amiR9PSWn3IrjkIw22dmQNzwb/UPpJZEa4sVydtBZN89a0lnnEV
	1ILCECUnqgftfpZOvGIupEzdshUkhSLxK3FXQFYuGbHOaIbBLhd2iX0RQvkfOmg==
X-Gm-Gg: ASbGncvM69VbfGiNYrOLG6kVnqKvPVGR3UA+W/eVuW/p7GDFY7FEOZIaCwWygu4YfI/
	L8iPkENl0oRIO9Kbqd/BcsuAec+dbrmkPWQCiJnybVSZm2BQBNouyEQlTT1EicCJfD1dMYX5ufF
	zGgzWBC496Q2DP8nZ0G30orh7KkhqRnenjm53zSC3XDqFh4UzeIlHQP5xD6TFyT5dH4Ngj5y8VY
	iOTNwYmZuywF7pqKqh6nFNTeZl+AzF+WEMW5Cb4OH9+sN7CYq6Q/BQ2w/Njto/4qGMRrdEOk8Q/
	yFJaHV8=
X-Received: by 2002:adf:e18e:0:b0:386:4571:9a22 with SMTP id ffacd0b85a97d-38787695702mr1905594f8f.31.1733990896394;
        Thu, 12 Dec 2024 00:08:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTBQqIZP4mAbmNDkq+BdMt3lJ9rORZUl6zp6FVSlb2GdXN4hAbWa7GzDXPUGiEy3/sL0XluQ==
X-Received: by 2002:adf:e18e:0:b0:386:4571:9a22 with SMTP id ffacd0b85a97d-38787695702mr1905577f8f.31.1733990896075;
        Thu, 12 Dec 2024 00:08:16 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251dcdesm3227619f8f.104.2024.12.12.00.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 00:08:15 -0800 (PST)
Message-ID: <ee865add-5f30-4c7d-b14d-fbc693dba265@redhat.com>
Date: Thu, 12 Dec 2024 09:08:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] mdio support updates
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>,
 Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/24 16:52, Nikita Yushchenko wrote:
> This series cleans up rswitch mdio support, and adds C22 operations.
> 
> Nikita Yushchenko (4):
>   net: renesas: rswitch: do not write to MPSM register at init time
>   net: renesas: rswitch: align mdio C45 operations with datasheet
>   net: renesas: rswitch: use generic MPSM operation for mdio C45
>   net: renesas: rswitch: add mdio C22 support
> 
>  drivers/net/ethernet/renesas/rswitch.c | 79 ++++++++++++++++----------
>  drivers/net/ethernet/renesas/rswitch.h | 17 ++++--
>  2 files changed, 60 insertions(+), 36 deletions(-)

@Yoshihiro, could you please have a look here?

Thanks,

Paolo


