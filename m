Return-Path: <linux-kernel+bounces-421279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB69D88F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12409163501
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520FF1B3930;
	Mon, 25 Nov 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFQpEc4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75818D625;
	Mon, 25 Nov 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547768; cv=none; b=aF1aaLq+U/TvuH3xHyrneRz/mOLVw4/E+YyJpNuGn/w1JZMcAmjAwWF9UGLhjqOlvr49A/AT1c03sHmB59l5Lcs7B8AtXKUYOUvryz4JF7MzmCZaiVjtR3Aq5OyQyepa46Chm50mBYbPOmX+Bzs/4Igk07Tt41cva6XP+aH/mIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547768; c=relaxed/simple;
	bh=4aBhIIas2g47XBD+Cj3ATIb9SfoU/xoQ7kIOCisb/Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bd6XLbLhtSEnkKukJ47qwxLuj6VqZzmCqmUntWJ4NSRuYjAnWU36Qn1Rz+R5slGdG3zm5loh+E3xMLiW2Lpz4yaiWcL99AcM52DaEh7fFGmt2VMdS7TQNHO+wcOpeBtM7FSfqZBQKnvJnKQ0azl37hKY+Bs/erytNaMTPxJDReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFQpEc4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313E6C4CED3;
	Mon, 25 Nov 2024 15:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732547768;
	bh=4aBhIIas2g47XBD+Cj3ATIb9SfoU/xoQ7kIOCisb/Yw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mFQpEc4KUlWTi3xhk3J5Dd3opD45BUdR4HmXoViaKo53iOmlr3LT5tyqr26r0EjM+
	 uiVymGX4CknVBSsNVCi/9RYahmsE+G73wX7VjwOTjslDYnMY2F40bAmFB9NKtHmw/a
	 +S8Miz0rLXM9DdibDrqL9YovNxNw3+bz3+8XWkbS4Mso/an65FozRCARqLlRNkgW43
	 J7nH2T9v91SKhyG3Flpcor9xZnTPagCeiHiyqVqeDhRwBx136kEVjfWdmrSjPy2pG+
	 LKOxrj3pMzqdfMrDnLAUigzIHUG/t7AqDbGeGUelcMkyG+ONaBxCoKEnI5RLUOKwRJ
	 gzliRU/L+lBAA==
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e387e50d98eso3592174276.2;
        Mon, 25 Nov 2024 07:16:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdLgd+kFGOOkUorpkidSBK9i7Ps86J0EU1q1bXHeKlDvg8JnLle6MYTxCqxXdUL9QmHXYcpRZOd2jD@vger.kernel.org, AJvYcCXaZJDabfBl9lT6FSb71ZCGuw0aK8+NGhZJkdIwIvtY8K7MbqwBOdJKnYLIaDrvUEadDVz3KQj41JrXW24w@vger.kernel.org
X-Gm-Message-State: AOJu0YzA69edjFnNRnxkVK0NLfJ4M0NcQhMl4mx/Sd8D0ia20W+HiTj6
	pK4hkh+gq/vzOiB47YLksqHxwXvTkqwcb+C/gKT0myQRwL/tyyFAkVCVcNL7ZOb5jnT1kcn/HXu
	Mot2Eazbqhn/9JsPmTUHoxxvC1g==
X-Google-Smtp-Source: AGHT+IGfSzF+AAME0JLl7fPi7vJS2kbZWkzSHN4h0kq1G3ex531cZ18jVRYlr+fRubX4QkZcl6FJxvXJwzkjWhqg6UE=
X-Received: by 2002:a05:6902:c02:b0:e38:b6be:1d66 with SMTP id
 3f1490d57ef6-e38f8c0945fmr12034812276.46.1732547767078; Mon, 25 Nov 2024
 07:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118210730.GA3331421-robh@kernel.org> <Z0NUdoG17EwuCigT@sashalap>
 <c25e6a80-f6dc-4ef9-a90d-0fa09cbbc217@linaro.org> <Z0NbeyTwxo-M4Lgi@sashalap>
 <936bf452-3d1f-4940-9a91-69efcdc6985e@collabora.com> <CAGXv+5FLkZbZVHNkfRWuT+OioZ0TG=u2WfaFCx-jZFi73QHnVg@mail.gmail.com>
 <19ba4910-f909-41b4-ba62-c904bc37d41d@linaro.org> <e77669ea-9edd-4321-8d17-4da40161b59d@linaro.org>
 <Z0R6myuCR4Jpmc_y@sashalap>
In-Reply-To: <Z0R6myuCR4Jpmc_y@sashalap>
From: Rob Herring <robh@kernel.org>
Date: Mon, 25 Nov 2024 09:15:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+QBweDZ+1=FXq7Hez=+mhiOxOvurr3rP0+3y_FCd49Ew@mail.gmail.com>
Message-ID: <CAL_Jsq+QBweDZ+1=FXq7Hez=+mhiOxOvurr3rP0+3y_FCd49Ew@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for v6.13
To: Sasha Levin <sashal@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Saravana Kannan <saravanak@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 7:24=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Mon, Nov 25, 2024 at 12:33:48PM +0100, Krzysztof Kozlowski wrote:
> >On 25/11/2024 12:00, Krzysztof Kozlowski wrote:
> >> On 25/11/2024 11:34, Chen-Yu Tsai wrote:
> >>> On Mon, Nov 25, 2024 at 5:48=E2=80=AFPM AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>
> >>>> Il 24/11/24 17:59, Sasha Levin ha scritto:
> >>>>> On Sun, Nov 24, 2024 at 05:47:33PM +0100, Krzysztof Kozlowski wrote=
:
> >>>>>> On 24/11/2024 17:29, Sasha Levin wrote:
> >>>>>>> Hi Rob,
> >>>>>>>
> >>>>>>> On Mon, Nov 18, 2024 at 03:07:30PM -0600, Rob Herring wrote:
> >>>>>>>>      of: WARN on deprecated #address-cells/#size-cells handling
> >>>>>>>
> >>>>>>> With the commit above, I've started seeing boot warnings on a few
> >>>>>>
> >>>>>> And same boards do not report problems on the next?
> >>>>>
> >>>>> Looks like they do. I haven't checked it previously, but I see that=
 we
> >>>>> have similar warnings on a few boards that KernelCI is testing -nex=
t on.
> >>>>>
> >>>>
> >>>> That's... horrendous.
> >>>>
> >>>> I hope that we can get a proper fix with a bootloader update on thes=
e (now very
> >>>> old) devices... Adding a Google engineer to the loop so that he can =
follow up
> >>>> internally.
> >>>
> >>> AFAIK that's unlikely going to happen given the resources needed from
> >>> the ODMs for a firmware re-qualification. Or we would have fixed the =
GIC
> >>> bug in ATF and had pseudo-NMI.
> >>>
> >>> Some of the firmware code involved is 10 years old, so even the RK339=
9
> >>> Chromebooks, which no longer have support, could suffer from this as
> >>> well.
> >>>
> >>>> The alternative would be to hack-in a firmware node to mt8183-kukui.=
dtsi, but....
> >>>> ...ugh. That'd be indeed a hack for the sole purpose of fixing a boo=
tloader that
> >>>> is acting in a broken way, and I don't like that at all (...and I'm =
sure I'm not
> >>>> alone!).
> >>>
> >>
> >> Then we should add it to the exception list. Let me take a look at thi=
s.
> >https://lore.kernel.org/linux-devicetree/20241125113151.107812-1-krzyszt=
of.kozlowski@linaro.org/T/#u
> >
> >I sent a fix for this platform only. You did not paste links to other
> >failing platforms (and sorry but kernelci web interface was absolutely
> >unmanageable and unusable, so I am not going to even try to look for
> >them) so not sure who should be added to list of exceptions.
>
> The new dashboard isn't *that* bad :)

You are reporting this issue because it is that bad. I tested this on
KCI before this even went to next. I gave up trying to get boot logs
out from all the boards. Though which boards run seems to be a crap
shoot, but that's not a dashboard problem.

>
> A list of platforms that show this issue:
>
> - google,spherion-rev3 | google,spherion-rev2
> - google,steelix-sku131072 | google,steelix
> - google,tomato-rev2 | google,tomato | mediatek,mt8195
> - google,juniper-sku16 | google,juniper | mediatek,mt8183
> - google,kingoftown | qcom,sc7180
> - google,lazor-rev5-sku5 | google,lazor-rev5-sku6

Can I get a dump of the DTB for one of these boards? The upstream dts
files don't seem to have a /firmware node.

Rob

