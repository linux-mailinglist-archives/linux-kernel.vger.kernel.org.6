Return-Path: <linux-kernel+bounces-363586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6D99C4BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA446B2976B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A4155742;
	Mon, 14 Oct 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T8+6Zwk+"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955D155751
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896244; cv=none; b=RUWqZQeNUJg/VtxgULwXo6oQ4oUh4Ox7HgWT1ZajTc18cRqHipwN26Qi/jJkxZ70ej6hqQjoUa5LffMHVGoR8PsMBi9s0yYYM4a13bIpvqr2ITawU4qV+7IoBznhfAJG0drpOhmx32TXpnSd4rB5qmC7/BNPTT49X5qcvk+GwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896244; c=relaxed/simple;
	bh=WOf4K4CWINZhQU4RFD35t8ijm9D51ZHFDnK/PsQjghA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+eroxLTNPK4Pr5Rm3Iep+qsAPnTB0jYWugU3mtFiJ1VoK2Nhto7My934Nv7tQzkgJfK332kAvTkKagYaSbmXODMPQTNnngJRiMWiTAXtsVUwwNy//Oo/52o3cdL5c8MObCU/Zf0w6CT9fjo+/G9jFLXdsCuxqx0SaoEs6fW38c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T8+6Zwk+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539fb49c64aso441688e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728896240; x=1729501040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvYtgp2zXj1eDnWfpqRa3Mn8iAnNIEg0eotITwWSLFI=;
        b=T8+6Zwk+qVO5pNR8GmNu38qiVD0UF8PbOLFwpdxklqRaN4g3yKh+afnYe9giLzB7im
         i97RHzK1Xhg7ibdZYJNw02uG5OZT2P/2ABOtZIWXil0NTvhFP594r7yEZjwBDMNUGamr
         N726RtvvRb92DVdivrm2AwCpw4FuaEO9cTkpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896240; x=1729501040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvYtgp2zXj1eDnWfpqRa3Mn8iAnNIEg0eotITwWSLFI=;
        b=n1cbDOqw6FkOOOhzSlZXBCGJ30yToA75F4rPR1PvwWeudzeUTcDixdr0aMypdRn/ou
         JsQUqPf10EyNvKobJTF+85/Nr9m+0zwZW0GjpBAY2xkH01IqyDvCR9H4qcqnq15crqiP
         tSnOndwoZzL/eBOzVhgEjhpRnZC22Q4AEBip044/4uGYXWM+IYT+N7U4wgV+JHQgIE6y
         4BDnBgLbOYlclDw+De364UsJADnaxxvH5oCzUldSQaO8nrEERZAeMg9aQ8GHXRO8ReL4
         BY7Wil2Em2hS9SirVj0/dMr7oSb3rGTd2Dzt9fK3LSABRtHWv4TgDTYNbIczcGXQejJV
         nwTw==
X-Gm-Message-State: AOJu0YwA6bVqZ+SXhIxlGE3WpNhko1+wCIA6+I+eD06t2se/Vtthi0lC
	duW6se1QJFdkRfAwFaLdS0Yo+qojW1LHn485/vMgtQtJDlNX5v1Xl32jydjGiiuRI7yFk1GXC3e
	d8FsCyYbnO96CBmaeJpMHAW4yPBXMnD0JpMma
X-Google-Smtp-Source: AGHT+IHq9hrF8UfsD+Sot6y/y1LSdy3W9HxkTmNkv6HPTeKREtJCEA/eiMV6U49rHkPg7/HD/5Oaq1as3HdfRFD7j78=
X-Received: by 2002:a05:6512:a8e:b0:539:8cd1:848 with SMTP id
 2adb3069b0e04-539e5733b50mr2642776e87.61.1728896240208; Mon, 14 Oct 2024
 01:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-b4-cleanup-h-of-node-put-thermal-v4-0-bfbe29ad81f4@linaro.org>
 <CAGXv+5FgLQMG=tA6d_gT71j5ZxWPa56rW1UmfUgKot4uCj56+g@mail.gmail.com> <b0d622cd-0d58-44e8-b168-8c69e46859a7@linaro.org>
In-Reply-To: <b0d622cd-0d58-44e8-b168-8c69e46859a7@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 14 Oct 2024 16:57:09 +0800
Message-ID: <CAGXv+5GXdU-LCnBEsy4pce+Mb-s9qwnYvN0FQ+pbOG4UzwPHfw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] thermal: scope/cleanup.h improvements
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:41=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 14/10/2024 10:32, Chen-Yu Tsai wrote:
> > On Fri, Oct 11, 2024 at 2:06=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Changes in v4:
> >> - Patch 2: rewrite, significant change: kzalloc() also with
> >>   scoped-handling so the entire error handling could be removed.
> >>   Due to above, drop review-tags (Chen-Yu, Jonathan).
> >> - Add Rb tags for other patches.
> >> - Link to v3: https://lore.kernel.org/r/20241008-b4-cleanup-h-of-node-=
put-thermal-v3-0-825122398f71@linaro.org
> >>
> >> Changes in v3:
> >> - Rebase, because there was bigger rework in thermal code.
> >>   This made two patches obsolete, but brought new one:
> >>   1/6: thermal: of: Simplify thermal_of_should_bind with scoped for ea=
ch OF child
> >> - Link to v2: https://lore.kernel.org/r/20240816-b4-cleanup-h-of-node-=
put-thermal-v2-0-cee9fc490478@linaro.org
> >>
> >> Changes in v2:
> >> - Drop left-over of_node_put in regular exit path (Chen-Yu)
> >> - Link to v1: https://lore.kernel.org/r/20240814-b4-cleanup-h-of-node-=
put-thermal-v1-0-7a1381e1627e@linaro.org
> >>
> >> Few code simplifications with scope/cleanup.h.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >> ---
> >> Krzysztof Kozlowski (6):
> >>       thermal: of: Simplify thermal_of_should_bind with scoped for eac=
h OF child
> >
> > I couldn't find this in my inbox. But since I already reviewed all the =
other
> > patches, and I looked at this one on lore, consider the whole series is=
 now
>
> Sorry for that. Your wens@csie.org was cc-ed, but not the chromium. If I
> respin, I will add both on Cc.

That's OK. I should've gotten a copy through LAKML but I could find no
trace of it in my chromium email, which is what I found weird.

ChenYu


> >
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>
>
> Best regards,
> Krzysztof
>

