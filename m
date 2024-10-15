Return-Path: <linux-kernel+bounces-365308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C847699E03C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7956A1F24502
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93B1BDAB9;
	Tue, 15 Oct 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhmo0han"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8601A7AF1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979447; cv=none; b=prWDruT5IB32OyarzhckbbfZ/HokBc3vW5F+/DSVo0luk37deFakiJSrpQOTLvdqWella3Ughplst4Gsry1DIb/qpxEL9VVocpgXoUQGiq2fB6KtlTi2bRYag7TN3aBD0Z7fc49Y9krbZZMhTQ85jjvV686Kcq3C01ihLTtraKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979447; c=relaxed/simple;
	bh=cg8ZTiKRHddH2LrkHl1Brodvt2NMZutN65i/7fv7CLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Za09kB1geVsMOp42Vq4VJqPVX5GLA/iU3vcw/1n4tOxf81M/iEUf6AZXne8hUy+pTHvxffW5gCAgI8gN4c51I904KoK5KEcvbzonP7OzyQDbXlLlP/Cf+fvfPtI7K048nXPP2F+cdMvaQbw0PlkeEVFqca/LvSz7rjjVZ2GDro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mhmo0han; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so6899321fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728979444; x=1729584244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg8ZTiKRHddH2LrkHl1Brodvt2NMZutN65i/7fv7CLc=;
        b=mhmo0hantn57SWaPFCp7/gJf7M+URmhe1rFdOo5F0/K1/7Me+HAZkbVKS7nsZjLUzm
         gOyjnoR8lcrvO6lthiw9cc1eWFyRT/tpWBks+2C26wV1wDQm8nE5yKwIUp9uDJVxRfvn
         nLkELe8MqkAGXtcE//rJWvxEVHX0776qWNTEoYMJ33Dzv3/cjMil8kVMwLzdfvNnh/dk
         qeztsMTBgs23YowTpnGZ6OUZXaiFJdIjalrRttOwZJTsa7a7nca18huX1KTnyIX3tGWN
         BaYw/d6ofznUof2OzKHlKSugAGZe9L716FE9tX9udtpHnBdOw1Xl2baf6t5fmy1+5BMC
         pr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979444; x=1729584244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg8ZTiKRHddH2LrkHl1Brodvt2NMZutN65i/7fv7CLc=;
        b=YLfCO4MP8yr4gHGRCD8puLk/37TaGRYcNk5Uz4JwsVpNWONRPlVgOTp9ipNtH4RdiA
         sIQ0dSnZ5ygiJc0DZIN2Mk9NW9aFeRmwckeMZg0DXnS8q6kKUwwnBkoHOtQLH4X8OS/I
         2eM0CZKfwxBXr1nqKZaez9QJjiiumZu6bsn/lS5Q9BkHNyqADgJZxXkjnKHAaOWnBHw6
         VzJOfC5by0cJtHvHv6XG4GPRZbkZdKVl6LJtorAfiacAPMUdIv7idpTxIDRORbTJAFyY
         79yZ83RzkVv4a5xzLbyx8NvgHh7Z9LmL/PpqXEgCgqP7olCgDx72kO+gn6p2vGNql/QA
         UHVw==
X-Forwarded-Encrypted: i=1; AJvYcCWOFz6kiZFf0Hkj+dfHaqP5ZmV5yQj94B1Q9rwBnOkctrChx0wMjarZGe6Y5I5U9aCKg22zN3WEmoQIPT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzthkYeTPuBLL6NUGVcQ5gWLM3stWS3XaH9FPO7AM26Ys0KApRA
	JUM4yJUkjYjIWlVhg9/raAzLv2NlhLCdEfVx/Jx658DclCB2W+WaqyVBo84raUEU9cNikdB4DYE
	51Ya0kCJlimqpqCcsaW6TmSDC8HyF+jFtHupHfA==
X-Google-Smtp-Source: AGHT+IFcQyrqiAdXJ+r9KDvXZ5YMMibfRlIbcBH5SMLB+VedSKbJjk6EUocMzB7vaVj1fgon7Ldo5J0xOGnBh/Tx5AE=
X-Received: by 2002:a2e:bc26:0:b0:2fa:d3a5:189c with SMTP id
 38308e7fff4ca-2fb3f2b22a7mr46261241fa.36.1728979444087; Tue, 15 Oct 2024
 01:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153041.1110364-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241014153041.1110364-1-vladimir.oltean@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 10:03:52 +0200
Message-ID: <CACRpkdZOQLnvcMEN=U-aAnJHHu2g6JoAK3US1heb1Rfr1KW9_A@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: dsa: vsc73xx: fix reception from VLAN-unaware bridges
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Pawel Dembicki <paweldembicki@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:30=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:

> Similar to the situation described for sja1105 in commit 1f9fc48fd302
> ("net: dsa: sja1105: fix reception from VLAN-unaware bridges"), the
> vsc73xx driver uses tag_8021q and doesn't need the ds->untag_bridge_pvid
> request. In fact, this option breaks packet reception.
>
> The ds->untag_bridge_pvid option strips VLANs from packets received on
> VLAN-unaware bridge ports. But those VLANs should already be stripped
> by tag_vsc73xx_8021q.c as part of vsc73xx_rcv() - they are not VLANs in
> VLAN-unaware mode, but DSA tags. Thus, dsa_software_vlan_untag() tries
> to untag a VLAN that doesn't exist, corrupting the packet.
>
> Fixes: 93e4649efa96 ("net: dsa: provide a software untagging function on =
RX for VLAN-aware bridges")
> Tested-by: Pawel Dembicki <paweldembicki@gmail.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

