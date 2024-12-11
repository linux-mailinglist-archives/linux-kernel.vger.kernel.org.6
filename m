Return-Path: <linux-kernel+bounces-440826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7521B9EC4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020EB1641A5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD8F1C462D;
	Wed, 11 Dec 2024 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="Ki9h0kSp"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD21B85F8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898721; cv=none; b=qQTVJpWLLo/vQTQbb1WzPMte2DqqBjTbFy6UhET6XaNlYtjnmAWb/Ohm21n670FNcbvH3o0C8oHgC34ZuGwOUIUKZqWtdwj3yopTrPLuVeyYcs3cUUB9DyOAY5X+YBlsghuqTyDAtcup8xDIL+5Zqmk/gVNf3nLixO1e0rbM59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898721; c=relaxed/simple;
	bh=tjNGwI3JyN0lTO3lWL7gsHveByFhzhe+vTxNwm4q5pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfCIFOf0gx4+Yw5Vz7cIspcJecetoVg6UH5ikdNOZnAHgHNc2CtZe4ZrFm+MZuRgZDyiRyGuX4hwotYOkJCSe4hc/zGF6jiMtqIDmOt03YhX6x9NBC7LiKkKuQgGDGVa0dYwnYbfbntcHzKu0WpGN1hsSocPm1B/seVya2uRz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=Ki9h0kSp; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3a0d2d15adso4319297276.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733898719; x=1734503519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjNGwI3JyN0lTO3lWL7gsHveByFhzhe+vTxNwm4q5pY=;
        b=Ki9h0kSpjYYCAq9xspFL+RGLWwE2l4FMb+j35XA/Q/L5rYbQHER/D9ztM9Oq91ipBo
         Oymh7NDmiq2ehh9xO6smgy85hdgrCiU0z6z0Eawiyac5DXd743hvdQbKCHLTgapn1iyz
         h0/w9buxmPw5vkLiV4qxXWbM2JoFwQEX/MiyeN4UmeguyNMSCCT2J8Od71Jtw6AZlOdt
         yFySawq3YPok5GAMVCrXMTBBBYyMj0ARlKJC8w3bN6Cj+8BrRiYXMutohsYL/Hd6fVpv
         or9XwoEmQNVAyxAAAAGSmURqP1j00rcunRd1ZgRfL1sxtXIP+1jRQUKs/cXDa1SryvnY
         bDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898719; x=1734503519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjNGwI3JyN0lTO3lWL7gsHveByFhzhe+vTxNwm4q5pY=;
        b=JY06vdiMDOT0IZjnAhdIYOGBrqNFbf1H6W5fIidTxWweuZC/Hsyafm3MfP4VqbHht5
         hmmwMgRVc5y6J8kOczwlTSssQWMQp15mQt1dcg12ORE+e1rpb36zQJSbjCHlltGqs297
         WBcEgGXk/xkBqJQQojTuPHWs5QclDr8q8Ec66gPmDKWmet3fH7A/5fi5vNUTl1l6M45C
         qOR97plRkflelQFx3HlPjlLdOziM/E1GElFcPNr8k7V8no4rX5nqYcASA8u6JD74DEtM
         /FluQqcG8nmWkZuHf7AHQv3A0Vij5o7ydCytCO94Ptm0BRrr95KVOknegWTqNdKug3rf
         1QUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN5FxlUAMhsNRj7xd4mXyvviROEgQ5AzVs6R0vOkPKn/+kG/5r9CKdiBM2w/WjgKFNEcpN2Q+DAIs2pLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gqehqSlejp3ucjWW+k2AnNwRYaAqC+J8BajSd/DlAMx2VhrM
	AV+C1UHaSNeROQXWUWvrcyDc8aGSQYT32zXsrknBbEY6WTmKRSOKz68Pl0+SigsDFbG7DVoAZMu
	fOjMy6c+PEvLWktAOIgKqGyvACOVH4hhsVS+7qA==
X-Gm-Gg: ASbGncuhKZLANON2TjB8T/2XLTmdkU3nsnYtJ1uphMkkMsy3oAiMp0gAHTVX9swufBk
	OqAuW/3w/4odOE7bkQiASynCLz/9XkSFRmNQ=
X-Google-Smtp-Source: AGHT+IFpqB8++GwCPCoca2FkFUGl5QNG6byYHcL1Hv+rwtzJe7wqU8sOxBY+fjbLZRtRpSmjfnai+zERa+ZGtA5fiBE=
X-Received: by 2002:a05:6902:2b88:b0:e38:91e2:5173 with SMTP id
 3f1490d57ef6-e3c8e42e955mr1788501276.8.1733898718868; Tue, 10 Dec 2024
 22:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241201074212.2833277-1-andrew@andrewstrohman.com>
 <Z019fbECX6R4HHpm@nanopsycho.orion> <20241202094508.4tpbed2b4amyvbsi@skbuf>
In-Reply-To: <20241202094508.4tpbed2b4amyvbsi@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Tue, 10 Dec 2024 22:31:48 -0800
Message-ID: <CAA8ajJn63xVmU7vd8UWT3eYtsMpVmd_njeGZRVs2DFE9MK0Eww@mail.gmail.com>
Subject: Re: [PATCH net-next] dsa: Make offloading optional on per port basis
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

Thanks for the review. I've responded back to Jiri,
about making this more generic. I'm happy
to make this more generic, but I'd appreciate
some guidance on the best way forward.

So, if you have a suggestion about how to store
the configuration that signals that the port should
not be offloaded, I'd love to hear it.

As I described in my response to Jiri, it looks like
adding the next netdev feature will be painful.
Do you thinking adding a new netdev feature
is the best way forward here?


Thanks,

Andy





On Mon, Dec 2, 2024 at 1:45=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com> =
wrote:
>
> On Mon, Dec 02, 2024 at 10:27:25AM +0100, Jiri Pirko wrote:
> > Why is this DSA specific? Plus, you say you want to disable offloading
> > in general (DSA_FLAG_OFFLOADING_DISABLED), but you check the flag only
> > when joining bridge. I mean, shouldn't this be rather something exposed
> > by some common UAPI?
>
> I agree with this. The proposed functionality isn't DSA specific, and
> thus, the UAPI to configure it shouldn't be made so.
>
> > Btw, isn't NETIF_F_HW_L2FW_DOFFLOAD what you are looking for?
>
> Is it? macvlan uses NETIF_F_HW_L2FW_DOFFLOAD to detect presence of
> netdev_ops->ndo_dfwd_add_station(). Having to even consider macvlan
> offload and its implications just because somebody decided to monopolize
> the "l2-fwd-offload" name seems at least bizarre in my opinion.

