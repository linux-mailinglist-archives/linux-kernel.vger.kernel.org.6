Return-Path: <linux-kernel+bounces-546271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F082A4F899
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DCB16F91A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB16C1F8677;
	Wed,  5 Mar 2025 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="03cl7met"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA071D8DEE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162826; cv=none; b=QicKW9nfyEEBCE9zrUKgUGxsDPt1jmIYmsDNHauekLnRlHQ3Bo/DkWQ0lVdDWaAwkFwLQQAPiiBlh7YpphLUkUbGyxAddMUDt9f8O0zPcfnSoTo6ldWG7AuijgLV7fWCnGtBzlcYC3YWVOIhPOi5oN22D2xj53JNgnVGH96W0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162826; c=relaxed/simple;
	bh=RWpWc+faJ0YZsTPx4jkXwG1vJYFHTnCeCj6HQ2ZWZ8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5PcUQHmnmsFEeBs1J+Fq8iVfDCmLk40DeGdqowBPSmqJpdnRXJ46VDEq1EGkEoMEZUlUjxTzi2tMEMwrzURfqkS3MoyOTB5C75ttn5JrfuU0RfNbm4OdufwGzBMVqFRq5MJXwMQYClDhlSda2kMw0OslChInwZITPKsHTufOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=03cl7met; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abfe7b5fbe8so423939166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741162821; x=1741767621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZ9TMmWBCnKwhuUOANBJp50uacRGJFZ/d6Ba0SS8K6o=;
        b=03cl7metXI1cLSykSQ15A0v9urzKwbn0ZkT+OxAUedRRVCcXmLO4k/5QngaDzqWWxx
         OJpFu0+eWvnv/Sj3U1pIo1XkyZXjKxeLn2K11hS2ZyZmSACwCW1dxHknTMgct0ASxAP8
         svykkAMIMCcArfI0VNMDN+dnaBE7rjvYnER16lHjGb/pweLNbHe/U0rLhR3vVOl3coRw
         HKggazQcB8fgfDAp9j0I1qh9v9+BNbiTaL7o4dLv0klNKODMsAqt1/uWNoGvtwMIyplc
         2WhF0vJI9xcORt0EiyhdFVep21WwHSiVHd8kw4DOsRavKYAhBZauJ/MB/Uf2vvVnmJ+1
         Hnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162821; x=1741767621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ9TMmWBCnKwhuUOANBJp50uacRGJFZ/d6Ba0SS8K6o=;
        b=ZAxTJfcKi34po/mu8MsCSItByx4tRaHGoNlV+T1XS0/ZLAp3HIchwAApu78x9xzBH9
         HAoB7jkKWmTBX6XnptFIJFQX1OX/YVKN2Fql+dgMOyD0fS22rPpl46h4YHf9eIzUzDGn
         3GCo23ogI+vOJxZIHPoJ12seYhqqYZBMA+c9USqAKWUu9sfRypJkXc9aRCvQ+4CMauEe
         MeqtyvdoCOkqJ8jJAV5u3nuAxasBfJOhwV0ivzzF9OYTzP+RxO3n5tYVQkmOG2lOxlmr
         rH2bsz9a6x9Gu24QkSRTpbAgllBzlYYyGOcX4EzUAHQLzkuZ6GT44w+Vc/x/dILSNMWW
         +C0w==
X-Forwarded-Encrypted: i=1; AJvYcCX12rZULaO0yx/r0+TvEJWP6AL3YK46+n1AO12xooZEdt2yc768RuIZCKVVbw0SpiF+zUfH+QuaMR69hRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQpPM2W8KO1ZszsyWZfV53gi59siQ5olDHJuHNPRrjw9g135zl
	ahhvoq8UJS3jwyNAR7YQuqQyQsQmIINvrE03XfhrqYksOK5e7dl1lW47wS2oAEQ=
X-Gm-Gg: ASbGncutAvBKa0pMs6b400nmC9+wQ2KFY7jwCkYR38RGDnWz6cAL3rRXGJZOEEfafLa
	3+6e/hIVbUFQXNGukhmoTzQG4h9KK4BBnVHFem3vb9KdyEqbP/uRkQ9uWk+pP2GpufNV1ruGbZ6
	1NR0pmPbZvHsh3DrHo4Qu6vK0zps9kandllsEa0cadRRKk87MFgjVfFkZD6uuQ9HSoYbHACeK3C
	4bB8SzUOqTK6xsmMhuXeGLqMFqo2ZdIjEufw04fHGplKhAe4fH9yE9VKMyMnzSlMC8/XU7Yoqja
	4+8ygpeCIqXg2xBgPq9SzC64PSgsRBGI2lJsHuz7xJH5th8GrIAgT1r8KkESk0JB6beSWTrOb6g
	A
X-Google-Smtp-Source: AGHT+IG3uX4osOFdkeIE8BVoOkaHQ2eM06ismAlJEsM6OrJRVb5spjiMCAH7SqlSZ6VKBFc01zjVCQ==
X-Received: by 2002:a05:6402:2714:b0:5dc:6e27:e6e8 with SMTP id 4fb4d7f45d1cf-5e59f47ced8mr4078134a12.24.1741162821234;
        Wed, 05 Mar 2025 00:20:21 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3f3bbfb3sm845989066b.77.2025.03.05.00.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:20:20 -0800 (PST)
Message-ID: <2690fc33-0646-4aff-aacf-2760706139e1@blackwall.org>
Date: Wed, 5 Mar 2025 10:20:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 04/15] netfilter: bridge: Add conntrack double
 vlan and pppoe
To: Eric Woudstra <ericwouds@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250228201533.23836-1-ericwouds@gmail.com>
 <20250228201533.23836-5-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-5-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
> packets that are passing a bridge.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/bridge/netfilter/nf_conntrack_bridge.c | 83 ++++++++++++++++++----
>  1 file changed, 71 insertions(+), 12 deletions(-)
>

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


