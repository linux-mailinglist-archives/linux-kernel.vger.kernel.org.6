Return-Path: <linux-kernel+bounces-324571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98848974E68
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5A11F270B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0A15DBB3;
	Wed, 11 Sep 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoA3XYGQ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8114AD0A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046445; cv=none; b=q70FIMGaunk633asdr5Vm9qMqmffVzqDPJ714EWeSCwcD8CaZxnfwThfYJDp4Nh3dqIQhBaxKCrW7XoJKmd3L73aYKJaoBERvsNFxu5Jtfrlce1Ti9qaUJu7HyJOGqz20Uz9H6RNO961Wkio4BO5w5b9W5t2nrVMgWZobctw9EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046445; c=relaxed/simple;
	bh=llbHvM2NSh1y9Ktj1BqB84u7m73YqVAzvlKA403MUSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilDMQQ7U5N39F987dP8dwXXxbmIsp4jkHgmkuWZEfH5hCeWAWPiaHNgN8+6l4qQ3ZxD5S32zmBwXvi5G4kdDXdGuARXGpMTcGU+wjreJ9yh8NeDMUxtK8bB/QMOFfOr7VBPI2z5gsEAluGu71BJanVKOyI7hyEY14ufxa7F98cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EoA3XYGQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365a9574b6so7623576e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726046441; x=1726651241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llbHvM2NSh1y9Ktj1BqB84u7m73YqVAzvlKA403MUSs=;
        b=EoA3XYGQoUzq6UBlaZg/vUeRaVVz32ALIMyUCn/kDhEMhJud/hQOh6/uT950heDPHt
         wfuKeGSQmEoUHHWmq9Ezvk86/6xqQCqtHP1fF7pjB2lK7mrO2bqJHPGGueWq+hStiTRM
         gHAJaMpVt1oKVSltp6MozltsGIszBDXRYSD8lnNX/AwfraU5DEOW1uZXRcxivTSirZcv
         1MteqQcgWQ0YpQISI0C8GlOcdDDHrmwkdjCe7MYIl91ik6OPvNpnV3zRbkuLy2Zw96aA
         uUgDjuaV7cIluDXGBSul9lyrCufYWCVI7bT/1nXVnuDlCOrOXk6TJ2CtViewkgh9XCGz
         eq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046441; x=1726651241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llbHvM2NSh1y9Ktj1BqB84u7m73YqVAzvlKA403MUSs=;
        b=vxa7Bhc17dhK+kIIe9YezHWaw+TyMhVaGk+oFjjfoLm8fYUwQjy8v4DFagjjPQWNOW
         iu+Fkz+QqwMry3pmBQXk67/jBqeBuF3ncytncrI8yB4DmdAUJSYjtBP+LqdBTHunBLJN
         OGseeRCd0maUmnHnDrYZlkfb63tQF96YPLusbyNJk9BP8hmTXjt7wK+E+X4GUvkTiqd1
         4FMgJ4lJZwVYJRBmX1C0HZ+0l/exMFd1umfPbN++av+k/nuW4TTJ6tu5jVhwwQ2YgshV
         sqQAfZTIbfm5T21Sp9ntTQNcf7a1nK73GdXu883+4p+pu6OHiLC9Rkjom5DgLRdoele9
         hPLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Rt5uDlRiQEKNBz14J6FEJilthZFW/x/Jbe79vG9gZ9br4QvAvM0LXoNzuyGiolxqehgoO9xP2DPrTaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5pHCs0wdwDszkNLeWXhdtr9JhvtPzwDTH7wIeeAq08GXkjfv
	s/blaXSyCh6v3i4iWb8lsOke1Yy8qno6HwcBt7INAWld9+7Xc+KqHd9LUfTbjmrnMMKwB6EBTtg
	NvVEAtgufYuWdybZhZL9H3GgabQPkhBDA86pf
X-Google-Smtp-Source: AGHT+IGLDjUNO1VR1Yljd5LCgc0RmDQJRXz4f3BqsbUQD+9Uc9X/sCaJ33fwYmRs04iln/kcXAKuf8+0IQ+O/NHhl9w=
X-Received: by 2002:a05:6512:1245:b0:536:54bd:8374 with SMTP id
 2adb3069b0e04-53658818949mr10161474e87.60.1726046440484; Wed, 11 Sep 2024
 02:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910174636.857352-1-maxime.chevallier@bootlin.com>
 <CANn89iKxDzbpMD6qV6YpuNM4Eq9EuUUmrms+7DKpuSUPv8ti-Q@mail.gmail.com>
 <20240911103322.20b7ff57@fedora.home> <20240911103744.251b0246@fedora.home>
In-Reply-To: <20240911103744.251b0246@fedora.home>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 11:20:29 +0200
Message-ID: <CANn89iKCj086chL-1fCR62H1Aq3qJ9MWsBapr=za8VSB4uPq2g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethtool: phy: Check the req_info.pdn field
 for GET commands
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	=?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>, 
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org, 
	Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Romain Gantois <romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 10:37=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi,
>
> On Wed, 11 Sep 2024 10:33:22 +0200
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
>
>
> > Sorry for asking that, but I missed the report from this current patch,
> > as well as the one you're referring to. I've looked-up the netdev
> > archive and the syzbot web interface [1] and found no reports for both
> > issues. I am clearly not looking at the right place, and/or I probably
> > need to open my eyes a bit more.
>
> Heh my bad, I just received the report in question. Looks like you are
> getting these before I do :)

I triage the reports, to avoid flooding mailing list with duplicates,
and possibly catch very serious security bugs.

I usually wait for some consistent signal like a repro, so that a
single email is sent to the list.

