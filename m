Return-Path: <linux-kernel+bounces-525373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBEA3EF1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EAB189CA2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093CF202C4F;
	Fri, 21 Feb 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op/2W77Z"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A41202C4A;
	Fri, 21 Feb 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127935; cv=none; b=fKf1ilykVkVfTGIyUdyFU5LDQMejapLdyFH6ap3ODlr80eu3RdIIY8pdqMolmvao5I8akVCSEdVifUk+YOZGL6whZyJ3oPMZtPcjd0NedbrHwK75ifes29KN6Vu3XG5DzdfEE/wuoxnOKxTxn726y9OTyqLEf6TpjOlceWDwFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127935; c=relaxed/simple;
	bh=jWobIjjmDN3S6Fnk2dQ+DGar/Fi8dKd+0Wo0aj7gSUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6RcoDIxhz6VyfQgXRWdN4xKoF5zkPqOGzYNQMc2FUK/ySJy+6Qbn5kT1iqf0lGIR9WxeWn+xoAtfd8WsP8bwqLpgG3Ocokr+LPXSWljskHcSzZhW35UKVIX/C5vZ3PB2UK0uC03cbyOUiaQFhZgzNvAcAwySWyLJ7puV06omDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op/2W77Z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22100006bc8so32386865ad.0;
        Fri, 21 Feb 2025 00:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740127933; x=1740732733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlIgqCz0Bm+91Vdon2hQ0cQM2Da+fTaQGYYMw9HsqC4=;
        b=Op/2W77Zjpz0Nzo5SGI3A2s9nVVPubLdj7uWHmjo44KTmJ7O4ivYL01oON8UT9BpX/
         1DyhUnWDO67Aoj3tk6+QDLutA3GPYhFWZTac7ST3xOKzafaMMUX5z8EcTZy9AMYpsGtj
         riRxE6tiqUjJvYlpMcTG7n5Qcj9QTHYTSRtn54mcKFXDwz4TlcbTgydaOjC3FHoc5HkC
         oEcGRPWm3HijJw7NyX+DcBzp6ZK4jC2BBztJkAIDmjmvjyDYFqg3FhRhkvf7SYz3sjMF
         WYpPC9Wo3JSaADfakjZQy7LKgAygOs21GEsjTKLX6GeUQ72XhPd14yUPvlYZwno0jjqQ
         nMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740127933; x=1740732733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlIgqCz0Bm+91Vdon2hQ0cQM2Da+fTaQGYYMw9HsqC4=;
        b=rWPSqkIYpaWpOSGqYdZTAeEUb115Z3bSpBBAtDjvz/qNeKEmYZ9msN0Q/O7opdTPpY
         Yd81TAI4+XxuG95CSwzELDNsswOsIfnJ9uKVQXWeC7PHbip9ffqmTra3Z/Po3VOCxzjC
         4y9nYYkIOvfffnL09OhnxFFMZ1d+BZSRM1WV/QMca+4BMNTeklYMVMfSGHweP1uYh8kJ
         YErHMTu38rA48KrToe20InKM3WDOFY+HgrhrVwL+MH71cGaAJIuRvFixbiNOChr+1XHo
         pSVNbHodtYvhB17vr+AXp1SULh6DYvKZ17EZ4+5IZdGBarufqfOw/qvEspwDOzi/wJmL
         mC4g==
X-Forwarded-Encrypted: i=1; AJvYcCWdAAkec8HZZGQ0ityS+vNG0jkCgYhk5e7HbQGZZnhtQ06EYE+XhLLtlxYM8ukKU3mLZvHBGKPeYpaVw4km@vger.kernel.org, AJvYcCX4x2kyYQRmvXIRNfAgJQDjHtZw2oI8Cc2Ui/VT82svTteP66SzdB9Iyj+POXTexzrLH61ZsWZt6hcX@vger.kernel.org
X-Gm-Message-State: AOJu0YwsVsmyrEEn9LvUV5PLNy5FqHLcOgq2NtpAMzCxLz7xZDodTPfp
	3NljnNBNpxFMYVmM703pZUurMwgUXmQL1aVcKnP0r22NvPqUN0xhu3kIo0vr2dlksrRkaAME5r2
	u8Emt0tsaZ49okEnuLUR3MA90dgQ=
X-Gm-Gg: ASbGnctz3aOXIkPnIFm5cb2sL+MvTFQfLavUhKYVmDjy6JbC46ye80mD1Dd3WNTwzz7
	YgbDTzSEjmTs3reWH6HtAyjc2ZVxvN/lDZ55Iyjz7/KCH9VRhqEFuGcoEfcZuAEoG9OzwxGiRYs
	eugZIgnHI0VXu4gltemiJeSXWZm3IFPxAezrHzdI1IOQ==
X-Google-Smtp-Source: AGHT+IE4RNFZsUdcC+Az/pPyn8dX9rljdP/Z5hfEIBv+Z54mKOPsANtz1C01SeJk4ImSyu09+DbDaPKDwVb/a6c1c1E=
X-Received: by 2002:a17:902:e80b:b0:215:6b4c:89fa with SMTP id
 d9443c01a7336-2219ff3604dmr36634085ad.8.1740127932926; Fri, 21 Feb 2025
 00:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-9-daniel.baluta@nxp.com> <c52e6c5c-f49e-4727-b669-086ae7cb0e1e@gmail.com>
 <6e03b0c09c4e6d222670025c6540f73a0a0a819d.camel@pengutronix.de> <9028f7a8-7cf7-4ebf-86a6-0d894c66edb1@gmail.com>
In-Reply-To: <9028f7a8-7cf7-4ebf-86a6-0d894c66edb1@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 21 Feb 2025 10:52:00 +0200
X-Gm-Features: AWEUYZk3O0UDfRBUUGtaK3pMjLH9rJuAF3_7PiIGx3Zt9ZlWm0Pjpm4mYFBC0o4
Message-ID: <CAEnQRZC=U_Bw7Hzr14qu7O9YM=qcXeMTSGQnM-ZX_hqSyg4sqA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] imx_dsp_rproc: Use reset controller API to control
 the DSP
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Daniel Baluta <daniel.baluta@nxp.com>, robh@kernel.org, 
	shawnguo@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org, 
	shengjiu.wang@nxp.com, Frank.Li@nxp.com, peng.fan@nxp.com, 
	laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:20=E2=80=AFAM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
>
>
> On 2/20/2025 5:45 PM, Philipp Zabel wrote:
> > On Do, 2025-02-20 at 00:22 +0200, Laurentiu Mihalcea wrote:
> >> On 2/19/2025 9:21 PM, Daniel Baluta wrote:
> >>> Use the reset controller API to control the DSP on i.MX8MP. This way
> >>> we can have a better control of the resources and avoid using a sysco=
n
> >>> to access the audiomix bits.
> >>>
> >>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> >>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> >>> ---
> >>>  drivers/remoteproc/imx_dsp_rproc.c | 25 +++++++++++++++++--------
> >>>  drivers/remoteproc/imx_rproc.h     |  2 ++
> >>>  2 files changed, 19 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/=
imx_dsp_rproc.c
> >>> index ea5024919c2f..631563e4f86d 100644
> >>> --- a/drivers/remoteproc/imx_dsp_rproc.c
> >>> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> >>> @@ -19,6 +19,7 @@
> >>>  #include <linux/pm_runtime.h>
> >>>  #include <linux/regmap.h>
> >>>  #include <linux/remoteproc.h>
> >>> +#include <linux/reset.h>
> >>>  #include <linux/slab.h>
> >>>
> >>>  #include "imx_rproc.h"
> >>> @@ -111,6 +112,7 @@ enum imx_dsp_rp_mbox_messages {
> >>>   */
> >>>  struct imx_dsp_rproc {
> >>>     struct regmap                           *regmap;
> >>> +   struct reset_control                    *reset;
> >> Maybe rename this to "stall"? There's also the DAP stuff that's actual=
ly used
> >> to reset the core so this might be a bit confusing?
> > So Run/Stall does not actually reset anything? Maybe then it should not
> > be modeled as a reset control. It looks to me like the
> > DAP_PWRCTL[CORERESET] bit in the Audio Processor Debug region would be
> > a much better fit.
>
> Yep, it does not as far as I'm aware. This bit is used to insert stall cy=
cles
> into the accelerator's pipeline. As for the DAP bit: agreed.
>
> (Daniel pls feel free to correct me if I got something wrong here)
>
> For a bit of context here:
>
> Previous approach used a syscon to manage the Run/Stall bit (see [1], "fs=
l,dsp-ctrl"
> property). The main issue with that is that syscon doesn't enforce any de=
vice dependency
> (e.g: PM) and you do need the AUDIOMIX power domain to be powered on befo=
re accessing
> the registers from said syscon.
>
> Now, AUDIO_BLK_CTRL offers multiple DSP-related configuration bits (Run/S=
tall bit included).
> If we ever decide we want to access those bits we can't model them as res=
et controllers as it
> makes no sense whatsoever. As such, I think that modelling Run/Stall as a=
 reset controller is
> just an arguably unneeded and inaccurate (assuming reset controllers are =
supposed
> to model only actual reset signals) solution.
>
> IMO, unless someone can think of a scenario in which this would break, we=
 should just cut our
> losses and go back to the syscon-based approach. The DSP is already attac=
hed to the AUDIOMIX
> power domain so it should be on when attempting to access its registers. =
Also, the DSP
> should be the only device wanting to configure the DSP-related AUDIO_BLK_=
CTRL bits anyways?
>
> What are your thoughts on this?

Thanks Laurentiu. Your summary is spot on.

Controlling DSP is done via two memory areas:
 (1) Audiomix area for Run/Stall bits
 (2) Debug Acces Port (DAP)  area for software reset

We need to model this in our drivers and we need both of the areas.

For (1) the DSP node needs somehow to refer to audiomix dt node and our
initial choice was to use a syscon binding to Audiomix. This got us a NACK
from Frank  and  Krzysztof as we naturally should always bring syscon in
discussion if we can model the behavior using an existing system like reset
for example.

Modelling the Run/Stall bits as a reset controller is a little bit in
the grey area
but Frank Li made some valid points in the patch 2/8 of the series.

Daniel.

