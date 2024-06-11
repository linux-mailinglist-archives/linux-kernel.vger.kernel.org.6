Return-Path: <linux-kernel+bounces-210519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A317890450F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D25F28586D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67949824AF;
	Tue, 11 Jun 2024 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be5XVcO3"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AB123774;
	Tue, 11 Jun 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134738; cv=none; b=djMQmUWa11DhMrhnXs8ljlGRybmrnZsXAd5vU2C8Y+7m/uf1oANTMQo6olTRYXAzFb0f1K24JM4w9rb20UQcxhmr0LaJjfuJMlkumghi0PpwEy/pZNwN9FWRZI9wQLn9LZQYtvua0N6jaOFxY6RoXcub6iaqOxVwOgMtLSiT5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134738; c=relaxed/simple;
	bh=quPoIRLTASqEk/VSqotVK8hUmlWbu7gBN1746k7k+V0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GAzqRAB+GW3WUeCJU7hXZ2nN2sQGjojtfe3ou78KiLSqxOjmki5VR6kORwzHWlQkPnV7adjc22/G2sZ6vAoI/wzipJGvI+k6pL20ajEGOhRKjljYk2FFgJvTBlZ+hgpJ+HnLY/skp7tBPjuPc4xYVcJx87qYpVjf/d8IOc9lQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be5XVcO3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42278f3aea4so4252755e9.1;
        Tue, 11 Jun 2024 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718134734; x=1718739534; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mMuKKGbiLvzl7g567RMJt94PCP09N1aUUNw3PJ69S5U=;
        b=Be5XVcO3HwrvFPMrjhPWs//WDoqyYytmQp85QgqmpgIeRbiNNdfWJE7qMjbsMdR5EA
         6CjIvpLdFsLJLNwn8eXSJPS6/w1157ChhjeKahzTuutj+OsmE4H0SVDpx2CnfGg2pCrd
         tT/BHOZGo3alDsGbmOFCUj23XKn2Qz5i4aJqNaCc1mJq5FBGdNjTyF5tLr64CvFRte6Q
         Yb38xWLC7Fqo8Mhdy+1ngNq1ZSbYuNeewmN65QjBzet2aFB6apcKPSSfiijVXc8X8zgZ
         tCJ0wkbzUE8LwZ08Bknr8wh6q9DB4ncmeAHusYSn/GuwHhEyRo3Ro2X8N79eFQj2IDl/
         EbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718134734; x=1718739534;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMuKKGbiLvzl7g567RMJt94PCP09N1aUUNw3PJ69S5U=;
        b=KcZp4ToVdQrGP9SyO+tR1U6BTSQvgOQC1XSmSFaN6zXVF8PWA8WdAWoGwpQjCP07mi
         JfG5ngwaQtEta6ig7tOZ1HPr/bwaOe4lGLWAEafRWsmBKZ4ME/WrxkRgSp8FGDutazz4
         4FLLSS7xm8oNEPgmLVClGz8ZRgqZTdys6s7CtSsylT8AnG2ZXO05Ab7hQSqXfPsG2N/l
         wXc3TPWxi1fYPUAGvQ9Qi85fIc4RT71Nudr3+GdpgZZiIDSDDW5O0JUlK3IcJfj51tDz
         bqCG5X5Z0LqjR1gB4w3K2t2wijZdQVfa08iSjhew/z6w+SQgaC72gPTIcIzLz0hnrE/8
         4tyw==
X-Forwarded-Encrypted: i=1; AJvYcCX4ByEo6Vcaqh65MClWb8bmP6CZyUnxrbFSqJsZfifGWwGk06uKjTQP0HollgY1TXT58yBHH7do+SzhyZuOGWsw69+HLaCIBJVwACp64af0q19cvv4NCh9Q9RBPDjZBW4V8N5daKqTcUA==
X-Gm-Message-State: AOJu0Yx3yx1e+oDhWehteZUcrMj7XFGIdk3USliU3xEhAi+tAGlj20zG
	40LvUhUJiSUW06YBVNvNRn3Zqs4XKavXmT6Sjs/yfgLcYXhIwOW/
X-Google-Smtp-Source: AGHT+IHJG4CxOHoiEYQZFTcAR5H73GlsNVvt7EMw1Bte0lOGSli21iSBCvk7Dv1tJ+cisx7RdIKaHg==
X-Received: by 2002:a05:600c:314a:b0:422:1a82:3ebf with SMTP id 5b1f17b1804b1-4221a824515mr38327285e9.35.1718134733320;
        Tue, 11 Jun 2024 12:38:53 -0700 (PDT)
Received: from hermes.prahal.homelinux.net (91-175-163-178.subs.proxad.net. [91.175.163.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421791b1ea9sm135406905e9.21.2024.06.11.12.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:38:52 -0700 (PDT)
Message-ID: <2427291970ac0962bf56b2455e5cb26e49d42c51.camel@gmail.com>
Subject: Re: [PATCH 1/3] phy: rockchip: emmc: Enable pulldown for strobe line
From: Alban Browaeys <alban.browaeys@gmail.com>
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Conor Dooley
	 <conor@kernel.org>
Cc: dev@folker-schwesinger.de, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
 Abraham I <kishon@kernel.org>, Chris Ruehl <chris.ruehl@gtsys.com.hk>, Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Christopher Obbard <chris.obbard@collabora.com>, Doug Anderson
 <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Jensen
 Huang <jensenhuang@friendlyarm.com>,  linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,  linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,  devicetree@vger.kernel.org
Date: Tue, 11 Jun 2024 21:38:52 +0200
In-Reply-To: <2192003.Icojqenx9y@diego>
References: 
	<20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
	 <313d5a24b6cffa1a9160e624bb6855aa7f66589e.camel@gmail.com>
	 <20240411-mushily-pucker-732583c1d340@spud> <2192003.Icojqenx9y@diego>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

This is quite a detailed replied. in summary I believe the enable-
strobe property should be added as soon as possible to restore hs400
support.

In the process it will be easier to see if any upstream dts has hs400
enabled and does not require to force this enable-strobe property.=20

As far as I understood the only boards that do not support enable-
strobe pulldown by default do not support hs400 either (because they do
not support strobe pulldown enabled due to wiring issue, but that also
prevetn them from enabling hs400).

And then if I managed to convince you that the best policy is to
restore previous behaviour of not setting a default in the kernel (and
provides enable and disable properties for those that want to force
ether way be it due to wiring issues), remove these properties once the
default is removed.


Le vendredi 19 avril 2024 =C3=A0 16:31 +0200, Heiko St=C3=BCbner a =C3=A9cr=
it=C2=A0:
> Am Donnerstag, 11. April 2024, 17:42:24 CEST schrieb Conor Dooley:
> > On Wed, Apr 10, 2024 at 08:28:57PM +0200, Alban Browaeys wrote:
> > > Le jeudi 28 mars 2024 =C3=A0 18:01 +0000, Conor Dooley a =C3=A9crit :
> > > > On Thu, Mar 28, 2024 at 06:00:03PM +0100, Alban Browaeys wrote:
> > > > > Le mardi 26 mars 2024 =C3=A0 19:46 +0000, Conor Dooley a =C3=A9cr=
it :
> > > > > > On Tue, Mar 26, 2024 at 07:54:35PM +0100, Folker
> > > > > > Schwesinger via
> > > > > > B4
> > > > > > Relay wrote:
> > > > > > > From: Folker Schwesinger <dev@folker-schwesinger.de>
> > > > > > > -	if (of_property_read_bool(dev->of_node,
> > > > > > > "rockchip,enable-
> > > > > > > strobe-pulldown"))
> > > > > > > -		rk_phy->enable_strobe_pulldown =3D
> > > > > > > PHYCTRL_REN_STRB_ENABLE;
> > > > > > > +	if (of_property_read_bool(dev->of_node,
> > > > > > > "rockchip,disable-
> > > > > > > strobe-pulldown"))
> > > > > > > +		rk_phy->enable_strobe_pulldown =3D
> > > > > > > PHYCTRL_REN_STRB_DISABLE;
> > > > > >=20
> > > > > > Unfortunately you cannot do this.
> > > > > > Previously no property at all meant disabled and a property
> > > > > > was
> > > > > > required
> > > > > > to enable it. With this change the absence of a property
> > > > > > means
> > > > > > that
> > > > > > it
> > > > > > will be enabled.
> > > > > > An old devicetree is that wanted this to be disabled would
> > > > > > have
> > > > > > no
> > > > > > property and will now end up with it enabled. This is an
> > > > > > ABI
> > > > > > break
> > > > > > and is
> > > > > > clearly not backwards compatible, that's a NAK unless it is
> > > > > > demonstrable
> > > > > > that noone actually wants to disable it at all.
> > > > >=20
> > > > >=20
> > > > > But the patch that introduced the new default to disable the
> > > > > pulldown
> > > > > explicitely introduced a regression for at least 4 boards.
> > > > > It took time to sort out that the default to disable pulldown
> > > > > was
> > > > > the
> > > > > culprit but still.
> > > > > Will we carry this new behavor that breaks the default design
> > > > > for
> > > > > rk3399 because since the regression was introduced new board
> > > > > definition
> > > > > might have expceted this new behavior.
> > > > >=20
> > > > > Could the best option be to revert to =C3=A9not set a default
> > > > > enable/disable
> > > > > pulldown" (as before the commit that introduced the
> > > > > regression) and
> > > > > allow one to force the pulldown via the enable/disable
> > > > > pulldown
> > > > > property?
> > > > > I mean the commit that introduced a default value for the
> > > > > pulldown
> > > > > did
> > > > > not seem to be about fixing anything. But it broke a lot. ANd
> > > > > it
> > > > > was
> > > > > really really hard to find the description of this commit to
> > > > > understand
> > > > > that one had to enable pulldown to restore hs400.
> > > > >=20
> > > > > In more than 3 years, only one board maintainer noticed that
> > > > > this
> > > > > property was required to get back HS400=C2=A0 and thanks to a use=
r
> > > > > telling
> > > > > me that this board was working I found from this board that
> > > > > this
> > > > > property was "missing" from most board definitions (while it
> > > > > was
> > > > > not
> > > > > required before).
> > > > >=20
> > > > >=20
> > > > > I am all for not breaking ABI. But what about not reverting a
> > > > > patch
> > > > > that already broke ABI because this patch introduced a new
> > > > > ABI that
> > > > > we
> > > > > don't want to break?
> > > > > I mean shouldn't a new commit with a new ABI that regressed
> > > > > the
> > > > > kernel
> > > > > be reverted?
> > > >=20
> > > > I think I said it after OP replied to me yesterday, but this is
> > > > a
> > > > pretty
> > > > shitty situation in that the original default picked for the
> > > > property
> > > > was actually incorrect. Given it's been like this for four
> > > > years
> > > > before
> > > > anyone noticed, and others probably depend on the current
> > > > behaviour,
> > > > that's hard to justify.
> > > >=20
> > >=20
> > > A lot of people noticed fast that HS400 was broken in the 5.10
> > > branch
> > > but due to another commit (more later, ie double regulator init
> > > that
> > > messed up emmc) this second breakage was not detected. But mostly
> > > downstream. And most if not all rk3399 boards in Armbian had
> > > HS400
> > > disabled.
> > >=20
> > >=20
> > > It took 3 years to detect that HS400 was broken on a few boards
> > > like
> > > Rock Pi4 in the upstream kernel. Any might still be broken.
> > > I would not count on the fact that keeping the current behavior
> > > equals
> > > no more broken boards.
> > >=20
> > > From the previous exchanges the boards that requires the pulldown
> > > to be
> > > disabled seems well known.
> > >=20
> > > Though I am fine with adding a property to set enable pulldown to
> > > any
> > > board definition file where that is required.
> > >=20
> > > Only I do not believe keeping the statu quo equal everything
> > > works
> > > because it has been 3 years.
> >=20
> > FWIW, I didn't say this. Clearly if that was the case, this patch
> > would
> > never have arrived.
> >=20
> > > In fact this commit reached the downstream kernels way later. Any
> > > stayed with the 5.10 branch for years.
> > >=20
> > > But on the other side the disable pulldown by default is alraedy
> > > in
> > > stable/linux-rolling-lts .
> > >=20
> > > > > Mind fixing the initial regression 8b5c2b45b8f0 "phy:
> > > > > rockchip: set
> > > > > pulldown for strobe line in dts" does not necessarily mean
> > > > > changing
> > > > > the
> > > > > default to the opposite value but could also be reverting to
> > > > > not
> > > > > setting a default.
> > > >=20
> > > > That's also problematic, as the only way to do this is make
> > > > setting
> > > > one of the enabled or disabled properties required, which is
> > > > also an
> > > > ABI
> > > > break, since you'd then be rejecting probe if one is not
> > > > present.
> > >=20
> > >=20
> > > I don't understand.
> > > How reverting to not set either pulldown enabled or disabled by
> > > default
> > > force all board to set either enabled or disabled.
> > > I was telling about making the pulldown set by kernel optional be
> > > it
> > > enabled or disabled to revert to the previous behavior.=20
> > >=20
> > > I mean before the patch to set a default pulldown value (to
> > > disabled)
> > > there were no forced value.
> >=20
> > Ah, maybe I misunderstood what the code originally did. Did the
> > original
> > code leave the bit however the bootloader or reset value had left
> > it?
> > In that case, probe wouldn't be rejected and you'd not have the
> > sort of
> > issue that I mentioned above.
> >=20
> > > > > Though I don't know if there are pros to setting a default.
> > > >=20
> > > > What you probably have to weigh up is the cons of each side. If
> > > > what
> > > > you
> > > > lose is HS400 mode with what's in the kernel right now but
> > > > switching
> > > > to
> > > > what's been proposed would entirely break some boards, I know
> > > > which
> > > > I think the lesser of two evils is.
> > >=20
> > > More boards (even if not the most wide spread it seems) are
> > > broken by
> > > the current behavior.
> > >=20
> > > I agree that only HS400 is broken by keeping the status quo. But
> > > as far
> > > as I understand only HS400 will be broken either way.
> > > Be that by keeping the current disable pulldown which break the
> > > boards
> > > based on the rockchip default design or the boards that are non-
> > > standard or have a broken design.
> > > Both case this lead to data corruption on boot to eMMC.
> > >=20
> > > The only pro of keeping the current value the default is that
> > > most
> > > board broken by the new default introduced in 2020 "might"
> > > already be
> > > fixed (but that is just a guess).
>=20
> which I guess are the least stale boards too.
>=20
> > > > It's probably up to the platform maintainer to weigh in at this
> > > > point.
> > >=20
> > > I am not knowledged into the delegation scope. You mean that from
> > > now
> > > on it is up to the rockchip maintainer?
> > > I am fine with it either way.
> >=20
> > Yes, I meant the rockchip maintainer. I'm only a lowly bindings
> > maintainer, without any knowledge of rockchip specfics or the type
> > of
> > boards we're talking about being broken here. Someone has to make a
> > judgement call about which "no property" behaviour is used going
> > forward
> > and I don't want that to be me!
>=20
> I'm somehow all for not changing defaults again.
>=20
> I think in the past there was a similar example in some other kernel
> part,
> where some change broke the ABI, but meanwhile another ABI depended
> on the changed behaviour, so a revert was not possible.
>=20
> I think it's somewhat similar here. If the change has been in the
> kernel
> for 3-4 years now, I do think that ship has sailed somehow.
>=20
> As was said above, board introduced since 2020 might already be fixed
> and essentially for boards that weren't, it does look like these
> didn't run
> a mainline kernel for like 4 years now.


I agree that all board have been fixed. But not by adpating to the new
default since 2020 and relying on it nowadays.
Most if not all have disabled hs400es support (and the patch to disable
hs400 are only reaching upstream recently, ie only a year ago for the
latest ones).

The hs400es support was disabled as soon as the new default was
introduced. And in fact earlier due to a double init in regulator core,
when probe deferred was introduced, that also broke emmc on rk3399 a
few month before this new default was pushed to stable branch in 2020.
Ie it could be that until when this double init was fixed in august
2022 by=20
https://github.com/torvalds/linux/commit/8a866d527ac0441c0eb14a991fa11358b4=
76b11d,
no rk3399 board was able to test hs400es support with the new 2020
default.

The main thing that made it impossible to find this new default was bad
is that emmc hs400 support was already broken when the commit reached
the stable kernel.

Also a lot of users and devs use SD instead of EMMC.

Maybe before discussing if the new default should be kept for
stability, we should check if any upstream rk3399 board that still has
hs400es support without the "rockchip,enable-strobe-pulldown" (ie out
of:
arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts via arch/arm64/boot/dts/r=
ockchip/rk3399-nanopi4.dtsi
arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts via arch/arm64/boot/dts/r=
ockchip/rk3399-nanopi4.dtsi
arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts via arch/arm64/boot/dts=
/rockchip/rk3399-nanopi4.dtsi
arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts via arch/arm64/boot/dts/=
rockchip/rk3399-nanopi4.dtsi
) has working emmc hs400.
Could be there are none that have a working hs400 emmc.

Could we ask for these boards to be checked for working emmc with the
new 2020 default? (as we cannot assume that as even well maintained
board only found upstream they were broken in mid 2023, ie commit
2bd1d2dd808c60532283e9cf05110bf1bf2f9079 and
cee572756aa2cb46e959e9797ad4b730b78a050b for ROCK 4C+ and ROCK Pi 4)?=C2=A0
Then we will be confident the new 2020 default regression is required
by anything.

Ie, we assume they were working as nobody complains as most complains
never reach upstream ML...=C2=A0but the armbian forum were flooed with
complaints in these days. I was one of the complainer until I decided
to abandon other projects because this issue was too big to me (wel I
ended up and am still on SD since it took too long and I needed the
board, as did all other users. But I want this to change).
Only downstream disabled hs400es to get the board working. All rk3399
boards in Armbian are patched to remove hs400 support since at least
two years as far as I know.

These current boards with hs400es enabled upstream are:
arch/arm64/boot/dts/rockchip/rk3399-evb.dts
arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts via arch/arm64/boot/dts/roc=
kchip/rk3399-gru.dtsi
arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts via arch/arm64/boot/dts/r=
ockchip/rk3399-gru.dtsi
arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts via arch/arm64/boo=
t/dts/rockchip/rk3399-gru.dtsi
arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dts via arch/arm64/boot=
/dts/rockchip/rk3399-gru.dtsi
arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dts via arch/arm64/boot/=
dts/rockchip/rk3399-gru.dtsi
arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-captain.dts via arch/arm64/=
boot/dts/rockchip/rk3399-khadas-edge.dtsi
arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dts via arch/arm64/boot/d=
ts/rockchip/rk3399-khadas-edge.dtsi
arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dts via arch/arm64/boot/dts=
/rockchip/rk3399-khadas-edge.dtsi
arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts via arch/arm64/boot/dts=
/rockchip/rk3399-puma.dtsi
arch/arm64/boot/dts/rockchip/rk3399-ficus.dts via arch/arm64/boot/dts/rockc=
hip/rk3399-rock960.dtsi
arch/arm64/boot/dts/rockchip/rk3399-rock960.dts via arch/arm64/boot/dts/roc=
kchip/rk3399-rock960.dtsi
arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts via arch/arm64/b=
oot/dts/rockchip/rk3399-sapphire.dtsi
arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts via arch/arm64/boot/dts/ro=
ckchip/rk3399-sapphire.dtsi
arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts via arch/arm64/boot/=
dts/rockchip/rk3399pro-vmarc-som.dtsi

These board were broken by the new default though they only disabled hs enh=
anced strobe but left basic hs400 support:
arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-captain.dts via arch/arm64/=
boot/dts/rockchip/rk3399-khadas-edge.dtsi
arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dts via arch/arm64/boot/d=
ts/rockchip/rk3399-khadas-edge.dtsi
arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dts via arch/arm64/boot/dts=
/rockchip/rk3399-khadas-edge.dtsi
ie commit 6dd0053683804427529ef3523f7872f473440a19 in november of 2021.


Note: I have not checked that my board is working with mmc-hs400-1_8v
enabled and mmc-hs400-enhanced-strobe disabled. Could be that the new
default only break the enhanced strobe support, not hs400 per se. Back
then Armbian contributors disabled hs400 support.


Finally, it could be that one RK3399 board currently upstream depends
on this new default but I guess none.


!!!!!
The main issue and what bother me is whether any boards depend on the
previous default. This is the real issue.
That is previously the kernel value was left to the one set by the
bootloader or the hardware reset.
The Rockchip kernel default to enable strobe was told by Dragan Simic=20
to break RockPro64 and the Pinebook Pro due to them behing miswired.=C2=A0
But it was not the upstream behavior before the 2020 new disable by
default behavior was introduced. The previous behavior to leave teh
pulldown as is.
!!!!

The dev for commit 8b5c2b45b8f0a11c9072da0f7baf9ee986d3151e that
introduced the new disable-strobe by default tells he tested on his
"rk3399 customized board".




I wanted to sort out if it made sense to add "rockchip,enable-strobe-
pulldown" to most rk339 boards. But I should have first added this
property then discussed if we should revert the new 2020 default.
We could just remove all the "rockchip,enable-strobe-pulldown" later on
if we revert either to the previous behavior of not setting a default
or even to the Rockchip tree default to set it enable-strobe by
default.
I should not have kept the board broken in the mean time. It is not as
if I was introducing a new API that could be wrong. The API is already
there even if wrong.

I will try to carry forward the discussion. But unbreaking the board is
higher priority.

Could you test the enable-strobe property on all the dts that  disabled
hs400es due to this new default (I lack the hardware to test the
patches).
At least arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
arch/arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts
arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
and ping the board tester for other boards to test if they require
"rockchip,enable-strobe-pulldown" for EMMC HS400 write support (read is
fine even with the new default).


About:
On Tue, 2024-02-27 at 10:11 +0000, Folker Schwesinger wrote:
> with the following applied, the EMMC related errors are gone. dmesg
> only
> shows "Purging ... bytes" during my tests:
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index f2279aa6ca9e..ae0fb87e1a8b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -647,8 +647,10 @@ &saradc {
>  &sdhci {
>         max-frequency =3D <150000000>;
>         bus-width =3D <8>;
> -       mmc-hs200-1_8v;
> +       mmc-hs400-1_8v;
> +       mmc-hs400-enhanced-strobe;
>         non-removable;
> +       rockchip,enable-strobe-pulldown;
>         status =3D "okay";
>  };
>=20
> For testing I ran dd three times in a row:
>=20
> dd if=3D/dev/zero of=3D./zero.bin bs=3D1M count=3D5000
>=20
> I tested this on both a Rock 4SE board and a Rock Pi 4B+ board with
> the
> same results.

Folker, are you confident "Rock 4SE board and Rock Pi 4B+" were fixed
with above patch?
Ie the "rockchip,enable-strobe-pulldown;" should be under an
"rockchip,rk3399-emmc-phy" compaible node, that is &emmc_phy in
arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi, not sdhci.




Since the new default bahvior was introduced the only new board dts
with hs400es support introduced were:
- arm64/boot/dts/rockchip/rk3399-rock-4c-plus.dts in
246450344dad087a121befbed1aba776dba3d377 (but as shown above the
support was disabled in 2023 due to hs400es not working with the new
default. I believe the dts was designed against a kernel before the new
default disable-strobe).
- arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi in
b5edb04673700125bfd1d13e6c14747b1ecba522
which these board dts includes:
arch/arm64/boot/dts/rockchip/rk3399-rock-4se.dts
arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b.dts
arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
but the hs400es support was disabled
incee572756aa2cb46e959e9797ad4b730b78a050b due to not working with the
new disable-strobe

As far as I know no board with working hs400 was introduced after the
new behavior. We can assume that not setting a default as before this
new behavior will not break any board any more than it was before this
commit was introduced (and this commit introducing the new behavior
does not acknowledge fixing any boards).


Either way, I believe we should add "rockchip,enable-strobe-pulldown"
to any board dts with hs400 broken asap.


> So if it comes down to deciding who to keep working, I'm more in
> favor of
> those that did run on mainline in the years since.
>=20
>=20
> Though not sure if I understood all the details here yet.
>=20
>=20
> Heiko
>=20
> >=20
> > > I just wanted to point out that maybe we don't have to set a
> > > pulldown
> > > value after all. And that then all boards will be fine as before
> > > setting the pulldown explicitly was introduced.
> >=20
> > By "all boards will be fine" you mean "all boards that expected the
> > kernel didn't touch this bit will be fine". The boards that need
> > the
> > kernel to set this bit because it {comes out of reset,is set by
> > firmware}
> > incorrectly are going to need a property added if we revert the
> > default
> > behaviour to not touching the bit.
> >=20
> > > In fact I am more eager to get this fixed be it by adding a
> > > enable-
> > > pulldown property to the board definitions, than to change the
> > > current
> > > behavior.
> > > Just wanted to sort out if that was not the wrong way to fix this
> > > issue. (ie if adding a setting on most boards was wrong).
> >=20
> > > During more than 2 years, I tried various patches and discussed
> > > on
> > > forums about the HS400 breakage. I had bisected the regulator
> > > init
> > > issue in the 5.10 branch. Sadly it took so much time for this
> > > issue to
> > > be understood that when the force pulldown to disable commit was
> > > introduced downstream before the first issue go fixed.
> > > This only made the matter worse because when one fixed the double
> > > regulator init issue HS400 was still broken, this time because
> > > the
> > > pulldown was forced to disable. But nobody noticed this commit
> > > that
> > > forced a default pulldown state (that was older than the
> > > regulator
> > > commit from 5.13 backported to the 5.10 stable branch commit, but
> > > that
> > > reached downstream later due to not having been backported to
> > > 5.10 from
> > > 5.11).
> > > Otherwise we would have emailed immeditaly.
> > > Bisecting was only able to catch the first breakage (as it was
> > > only
> > > fixed after the second breakage was introduced).
> > >=20
> > > Maybe the problem is that me and others did not complained to the
> > > kernel upstream ML because we were using heavily patched
> > > downstream
> > > kernels (like most if not all downstream ARM kernels). So sadly,
> > > the
> > > forums from back then are filled with complaints but nothing
> > > seemed to
> > > have reached the Linux ML.
> >=20
> > Aye, and all I can really say there is to buy boards from a vendor
> > that
> > doesn't use some horribly hacked downstream kernel, which I know is
> > clearly an unsatisfactory suggestion. That said, we probably should
> > have
> > caught that the new default behaviour when the changes were made
> > was not
> > the default before. There was only one DT maintainer then though,
> > and
> > things just slip by :/
> >=20


The sad thing is the vendor indeed worked to upstream the code (though
it has since closed doors).
But as told previously, the emmc hs400 support was already broken by
the time the new default disable-strobe pulldown by default reached
stable. This due to another tricky to debug unrelated double init in
regulator core introduced a few months before the commit to disable-
strobe was introduced. No one could have caught that the new behavior
was broken on most rk3399 board by testing ... because it was not
possible to test hs400 emmc before the double init in regulator core
was fixed in august 2022.
I had bisected the breakage to this regulator core deferred probe
(commit "06653ebc0ad2e0b7d799cd71a5c2933ed2fb7a66"  "regulator: core:
resolve supply for boot-on/always-on regulators") when it broke in
5.10.60. But the new default behavior was no backported to the 5.10
branch so it confused me that the revert that got back hs400es on
helios64 in the 5.10 branch when finally fixed in the 5.16 branch (the
double init fixup) then emmc was still broken.
Only when arguing with an Armbian user that all rk3399 had emmc hs400es
broken did he argue that his board was working. And indeed it was the
only one which add "rockchip,enable-strobe-pulldown" to its dts as they
found about the new default behavior commit, cf
https://lore.kernel.org/lkml/eafd8d8c0cbcaca1b190f84ec17a1dcd7aec0306.camel=
@collabora.com/T/
"arm64: dts: rockchip: add enable-strobe-pulldown to emmc phy on
rk3399"


Heiko, you then asked:
On Tue, Aug 23, 2022 at 4:53 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
> I'm just wondering as the "offending" patch is from 2020, why this
only turns up now. Any ideas?


It turns out because this commit was not backported to stable branches.
And when it did most boards broke (it was panic in the forums with data
loss issues) and ended up with hs400 isabled in downstream kernel
(Armbian for one).
This discussion was in 2022. Only two dts files with hs400 support fo
rk3399 were added since then and had to disable hs400 later one because
of this default enable-strobe policy.


Also in this thread:
On Tue, Aug 23, 2022 at 10:13 PM Doug Anderson <dianders@chromium.org>
wrote:
> Ah, I see. So before the offending patch we used to just leave the
> pull state at whatever the default was when the kernel was booted.
> After the offending patch we chose a default.
>=20
> On kevin I see an external pull down on this line. Enabling both the
> internal and external is probably not a huge deal, it'll just affect
> the strength of the pull.
>=20
> On bob I _think_ the external pull down is also stuffed.
>=20
> ...so I guess that would explain why it didn't cause a problem for at
> least those two boards?
>=20
> -Doug


So it could be that disable by default broke most board but enabling by
default would break none, or only very specific board (that from my git
log inspection would have already been broken before the new behavior
was introduced).

then:
> I realized that only some devices may be affected, so I considered
> modifying rk3399-nanopi4.dtsi only,
> but other boards without external pull-down should still need this
> patch.
>=20
>=20
> BR,
> Jensen




It was pointed out that RockPro64 and Pinebook Pro had the strobe pin
miswired.=20

From: Dragan Simic @ 2024-02-27 16:00 UTC (permalink / raw)
> When it comes to HS400 support on the RockPro64 and the Pinebook Pro,
> they're unfortunately miswired in a hopeless way, causing the DATA
> STROBE signal from the eMMC chip (i.e. the eMMC module) not to even
> reach the right ball on the RK3399 SoC.
>=20
> Here are a few screenshots from the schematics that illustrate this
> issue (the first one is from the eMMC module schematic, the remaining
> two are from the RockPro64 schematic, which are pretty much exactly
> the same in the Pinebook Pro schematic):
>=20
> - https://i.imgur.com/MqD7rcG.png
> - https://i.imgur.com/hrlQBck.png
> - https://i.imgur.com/mtYvc9s.png
>=20
> There have been some Pine64 community attempts to have this fixed in
> new RockPro64 and Pinebook Pro hardware revisions, but such attempts
> unfortunately failed. :/
>=20
> Thus, we'll unfortunately have to deal with the whole thing on the
> board level, instead of making changes on the SoC level.


On Tue Mar 26, 2024 at 8:55 PM CET, Dragan Simic wrote:
> Moreover, as I already explained some time ago, [1] some boards and
> devices are unfortunately miswired, and we don't want to enable the
> DATA STROBE pull-down on such boards.



Maybe reverting to the previous of not setting a default for this
strobe pulldown in the kernel is the best option (the commit
introducing a default does not tell why it makes sense to set a default
in the kernel out of "the Rockchip kernel does it").


and:
On Wed, Aug 24, 2022 at 10:58 PM Doug Anderson <dianders@chromium.org>
wrote:
> I guess the other alternative would be to change how the dt property
> works. You could say:
>=20
> 1. If `enable-strobe-pulldown` is set then enable the strobe
> pulldown.
>=20
> 2. If `enable-strobe-pulldown` is not set then don't touch the pin in
> the kernel.
>=20
> 3. If someone later needs to explicitly disable the strobe pulldown
> they could add a new property like `disable-strobe-pulldown`.
>=20
>=20
> Obviously there are tradeoffs between that and what you've done and
> I'm happy to let others make the call of which they'd prefer.


This is a sane way policy to me.

Maybe Rockchip had a rationale to enable this strobe pulldown by
default. But I don't think there is any rationale to force this
pulldown to disabled by default.


In a secondary step, with extensive testing, if ever, I believe we
could still change the default to enable but add a disable-strobe for
RockPro64 and Pinebook Pro (broken due to a design mistake that is
specific to these boards as far as I understood).
But this can be worked on after any default is removed and merged only
when supported boards have been tested to be fine with this default.
As far as I understood setting the strobe pulldown to board with an
external pulldown is harmless, so only boards with miswired lines would
be broken and could be handled by adding disable-pulldown (which would
also document them not supporting hs400 in the dts instead of relying
on developers ot carry on this piece of information).

In fact I believe it would be good to add disable-strobe-pulldown
properties to the dts of boards which cannot support internal strobe
pulldown to be enabled, if only to document they cannot support it.


By the way how does the Rockchip kernel handles RockPro64 and Pinebook
Pro?
Are both RockPro64 V2.0 and V2.1 with DATA STROBE lines miswired?

Regards,
Alban

