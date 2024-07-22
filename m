Return-Path: <linux-kernel+bounces-258664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3D938B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C55F1F2198E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFE3166318;
	Mon, 22 Jul 2024 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub2pCdyY"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAEF1B977
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721637493; cv=none; b=mHWsZf1ai45JbDFHrp/EpFH3eoSuzYQ6SQF9CInjYhLvwRRQ3wRHNcItBXZE28eejLC2UHpv+8bpH/asXMpuNvtoetskP1fcMY/QIepBC71J6YlbKsaMIhzkbmkpIRdT3ExTciTPKiCn/3Z1+gAdNDj06Q7IhpceSbkFEnwgs10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721637493; c=relaxed/simple;
	bh=zj1cn66/vQ5MXFUAsLxAh/TomF3ys4vZsbL3NdjigaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdKJXmYRwTLTRixZPjleRlGLE7PK1XdUMHcbcVUtCbKIDr8EP31LMZalfVkHDKbeUHf8PHMmL98XzuSbGz08mbvI/fT2Xz12ByznWthoHiwKw1kbEQWa+E7sThjwXDukitBBttTBL3cnj9+T/ImFmM4H1LmfzOwlLCyB63OviXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub2pCdyY; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70361c6fd50so2019407a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721637491; x=1722242291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLy2SrIyNS/BtIAkKA6BvJoHkOLVxRWMUEDFd16KBRE=;
        b=Ub2pCdyYIeCE2dTa+eZLKsiqZeIajqCiYxKWGB0WoszKocOyKpWOuAK4DfsyhmDdCX
         amD5oD1QKUkSjNiBEvbVXfLJ9hCHBltWP9XXKhJntXW66yPcsNboDIR/s27xLTjoj+gl
         B8byA1/ns1fTZG+pF1LKEKRGNC3b3DC1qLynpkd2Hy0stBLZM3euyb5R1UmkCzoI0jvG
         QIJ4oAIByQtejTIKOBoCD3wxzLtC8zrssh9Q14DXOGDlIet9EAWda3zcAxc05sjdZQfq
         aCk6LFweuSaiZTotQHnA5A0AgnzlL5+qY/X8ciV+eZe603yHoxoD+opRL4cSCehqQSLP
         6jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721637491; x=1722242291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLy2SrIyNS/BtIAkKA6BvJoHkOLVxRWMUEDFd16KBRE=;
        b=ihnT76RWoWSI/6hlvb1Y3qKDLbYLIooomry+u4C6/W6qrrgr8Yf2aw9xJ2BmYrL4zM
         npv+vVNOr3/qgPlAI8gnztwuiT8hplvIGqLso1M8xehM3cL1MQX5s1xeJcMFWf5AhlJS
         qaqcSlKlhg/yn4l24v6RiO7D552kKA55FS6GcU4gjt9D+4O0wZGGKzt43U6/kIG2L+MH
         oQv0Uc2yX5DUMpDhk+meCSjXLjHrNUl4DmEsYZvTN3U39+1glMKfVisThlSOSic4OuD5
         zJR/62R3//BeNCxvgdrP+3hXb2PeY8YbRHt4FWfaOUcf66DaloytVsSBx7wasT5OqPfL
         6suA==
X-Forwarded-Encrypted: i=1; AJvYcCU38wWPImtDDdn1ZfFT9rDs9E8pOIjzx5LSSHpcHY5iqC1z4XKs3zIw3Re/jCpibf5CRGx5htjsppefIhCJtLSY7mNTj8WW5UTqYKUv
X-Gm-Message-State: AOJu0Ywa9qTQFJPlEN1KLdGAS6fKfCe6uilnAhs1IPI3E22k0PVsNUCy
	+fjqWWfN7YI2l3ijkOjZP1xEK8JHw3gDDMHcQSnMEGnP+Egkz0+VI2TUg5oFXTe6bgANbOa+I/7
	CApQfNMIUIj4eZAzBdTpVx73nZRg=
X-Google-Smtp-Source: AGHT+IED9sgp0XJRTrLdgRC9+QtNiUQcgpNSQZW++T17WK1mNEKhGIErQwceTSb8Zdl4TwT9yetFMFVBBj0lyMUU2OA=
X-Received: by 2002:a05:6830:6486:b0:704:4c66:b6f3 with SMTP id
 46e09a7af769-708fda82511mr9301123a34.7.1721637491606; Mon, 22 Jul 2024
 01:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129104106.43141-1-raphael.gallais-pou@foss.st.com> <21f4d43d-4abd-4aca-7abb-7321bcfa0f1d@foss.st.com>
In-Reply-To: <21f4d43d-4abd-4aca-7abb-7321bcfa0f1d@foss.st.com>
From: Yanjun Yang <yangyj.ee@gmail.com>
Date: Mon, 22 Jul 2024 16:38:00 +0800
Message-ID: <CAE8JAfy9NtBa--DnUt2AEZPFnvjU6idj8DqUbaeLaH0DMFvuhw@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH RESEND v3 0/3] Update STM DSI PHY driver
To: Philippe CORNU <philippe.cornu@foss.st.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Yannick Fertre <yannick.fertre@foss.st.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 8:47=E2=80=AFPM Philippe CORNU
<philippe.cornu@foss.st.com> wrote:
>
>
>
> On 1/29/24 11:41, Raphael Gallais-Pou wrote:
> >
> > This patch series aims to add several features of the dw-mipi-dsi phy
> > driver that are missing or need to be updated.
> >
> > First patch update a PM macro.
> >
> > Second patch adds runtime PM functionality to the driver.
> >
> > Third patch adds a clock provider generated by the PHY itself.  As
> > explained in the commit log of the second patch, a clock declaration is
> > missing.  Since this clock is parent of 'dsi_k', it leads to an orphan
> > clock.  Most importantly this patch is an anticipation for future
> > versions of the DSI PHY, and its inclusion within the display subsystem
> > and the DRM framework.
> >
> > Last patch fixes a corner effect introduced previously.  Since 'dsi' an=
d
> > 'dsi_k' are gated by the same bit on the same register, both reference
> > work as peripheral clock in the device-tree.
> >

This patch (commit id:185f99b614427360) seems to break the dsi of
stm32f469 chip.
I'm not familiar with the drm and the clock framework, maybe it's
because there is no
 "ck_dsi_phy" defined for stm32f469.
PS:  Sorry for receiving multiple copies of this email, I forgot to
use plain text mode last time.

> > ---
> > Changes in v3-resend:
> >       - Removed last patch as it has been merged
> > https://lore.kernel.org/lkml/bf49f4c9-9e81-4c91-972d-13782d996aaa@foss.=
st.com/
> >
> > Changes in v3:
> >       - Fix smatch warning (disable dsi->pclk when clk_register fails)
> >
> > Changes in v2:
> >       - Added patch 1/4 to use SYSTEM_SLEEP_PM_OPS instead of old macro
> >         and removed __maybe_used for accordingly
> >       - Changed SET_RUNTIME_PM_OPS to RUNTIME_PM_OPS
> >
> > Raphael Gallais-Pou (3):
> >    drm/stm: dsi: use new SYSTEM_SLEEP_PM_OPS() macro
> >    drm/stm: dsi: expose DSI PHY internal clock
> >
> > Yannick Fertre (1):
> >    drm/stm: dsi: add pm runtime ops
> >
> >   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 279 ++++++++++++++++++++++---=
-
> >   1 file changed, 238 insertions(+), 41 deletions(-)
> >
>
> Hi Rapha=C3=ABl & Yannick,
> Applied on drm-misc-next.
> Many thanks,
> Philippe :-)
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32

