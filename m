Return-Path: <linux-kernel+bounces-420830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCDC9D8379
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C40B16377B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91138193407;
	Mon, 25 Nov 2024 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RDxglYsK"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD00192D8F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530906; cv=none; b=HfKRX6RC2g3LOV1B+YS+bUqOTPGXWX5eyGF8hDpaQ4fJcec6yF4k6zMHycWB+gc2Tqwzdj4QEO8JFGRRCmDCAbsNPXnQBnhWFiALdfac9+/spfXC1XT6OzonMIu2dSbkvfjdqb+QI8SFzGraQsvngIGYROrM7Mzvr6IdgthRchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530906; c=relaxed/simple;
	bh=/G/uZopYt4hv+Lcz+c+B3nmd7SEVZd3MKlPVcqayPqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxFg2gt4XnYtfRbEseZQo+viMPTnLSjE8ssrbsz5b6qwLBq0hsuhRX7ol5yUVZrQoJkdPnU48yLbJ1ux+iE1Kue/wnL+sHca3+XS5j4/dEdzzys29+qiOvFeiPqOEFHgNrdjuayut8LuI/aEQMFcY9ZWRzSYj6u3WY7ZcbOlVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RDxglYsK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53dd0cb9ce3so3872253e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 02:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732530902; x=1733135702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxmYpn9UtZbrjXXIUIvDISofsYXFdnT0oXzeCM6Ecds=;
        b=RDxglYsKNWiN38QgulZOLgqrixYImvvRddiYyB0GqzCh4DYMuFOdOxOd7+Yg5oughv
         xgXpIPzITH6hH3fJAbcGwkUiurs5d7cDM/KSXiMijkJTS+tf3A1oGaqBjxTOnJ+v5xy+
         Zd/MElaYMnYB/pNVb1pRICN/V0L815nsBNyvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732530902; x=1733135702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxmYpn9UtZbrjXXIUIvDISofsYXFdnT0oXzeCM6Ecds=;
        b=q1UQLzv0XGLopUbTZ/97kRPkJQY18qgL+zHuewCkWsyDkg/joRNXe/eyKUUvhLPSa3
         T6e6PoIgAL/iKe85GhIQnuN+jQNUuldnvRU0XhCoaEcg1EFFTp0GjPWFyPoLm2XpgeOk
         xYSECSa2l1mpaEImb4riEGzXGywgFSyxA1ieIt9E91MEs58G/QxE0ZwcPZ//4sdpyyCQ
         WKVQOSUkQl80alGSOEFaBrjbi1Da8PbWts+EM34XFZuirsx9jD24KZAgagxWX2wme3bi
         Q08hFKZwPHmmwHnxdmD3unz1H68d0B/PuLz1hd6wisVAGt6QWfUP8wX2Wxlg//Z8RmrW
         Db7g==
X-Forwarded-Encrypted: i=1; AJvYcCWh9kS/WdBQf3/BiFCcDfP2BbrJC2Z9/iGbDRXqVYPEyvZCfIGaSNtWvtW9jzLC4svzQRM3fEKEAHARrpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCHw4nYSCOazERD4opwMM0qpapDjiSobmhif2QQOIduJijsRcP
	sikWCxBFnvV7hZnfBpAC3aT4zUEGLCrOM2snmu1vmTNNOH9DSegHj3ar/qE0NRFcqGJouBlxfl4
	JeCfU60usT3BhVyq6oXMA4M9FqE/fbEYKaY+N
X-Gm-Gg: ASbGncuuiToAPmoDPysck5VjlyP0GFHYJxaVmrgYTX4m/AA9tCBs3ZfOxWt1RhE2oeZ
	TKrpg8zOTxI41Aj+odVWAS8uBo/JgK+WCOBINVvQwyYFPj470qLLxNBwWaHE=
X-Google-Smtp-Source: AGHT+IEHifAyOLUrLFj5xqVNxTMQjPyhca/EKW65f9INz6n+Tx1MkLVmt7BlGlUvHohU6t7pp/A9okdrwg3M/nkVXj4=
X-Received: by 2002:a05:6512:6c7:b0:53d:de36:d0e5 with SMTP id
 2adb3069b0e04-53dde36d13fmr2346053e87.14.1732530902422; Mon, 25 Nov 2024
 02:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118210730.GA3331421-robh@kernel.org> <Z0NUdoG17EwuCigT@sashalap>
 <c25e6a80-f6dc-4ef9-a90d-0fa09cbbc217@linaro.org> <Z0NbeyTwxo-M4Lgi@sashalap> <936bf452-3d1f-4940-9a91-69efcdc6985e@collabora.com>
In-Reply-To: <936bf452-3d1f-4940-9a91-69efcdc6985e@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 25 Nov 2024 18:34:51 +0800
Message-ID: <CAGXv+5FLkZbZVHNkfRWuT+OioZ0TG=u2WfaFCx-jZFi73QHnVg@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for v6.13
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sasha Levin <sashal@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Rob Herring <robh@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 5:48=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 24/11/24 17:59, Sasha Levin ha scritto:
> > On Sun, Nov 24, 2024 at 05:47:33PM +0100, Krzysztof Kozlowski wrote:
> >> On 24/11/2024 17:29, Sasha Levin wrote:
> >>> Hi Rob,
> >>>
> >>> On Mon, Nov 18, 2024 at 03:07:30PM -0600, Rob Herring wrote:
> >>>>      of: WARN on deprecated #address-cells/#size-cells handling
> >>>
> >>> With the commit above, I've started seeing boot warnings on a few
> >>
> >> And same boards do not report problems on the next?
> >
> > Looks like they do. I haven't checked it previously, but I see that we
> > have similar warnings on a few boards that KernelCI is testing -next on=
.
> >
>
> That's... horrendous.
>
> I hope that we can get a proper fix with a bootloader update on these (no=
w very
> old) devices... Adding a Google engineer to the loop so that he can follo=
w up
> internally.

AFAIK that's unlikely going to happen given the resources needed from
the ODMs for a firmware re-qualification. Or we would have fixed the GIC
bug in ATF and had pseudo-NMI.

Some of the firmware code involved is 10 years old, so even the RK3399
Chromebooks, which no longer have support, could suffer from this as
well.

> The alternative would be to hack-in a firmware node to mt8183-kukui.dtsi,=
 but....
> ...ugh. That'd be indeed a hack for the sole purpose of fixing a bootload=
er that
> is acting in a broken way, and I don't like that at all (...and I'm sure =
I'm not
> alone!).


Regards
ChenYu

