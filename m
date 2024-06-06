Return-Path: <linux-kernel+bounces-204858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAFC8FF456
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23470287C22
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1330199382;
	Thu,  6 Jun 2024 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIoln4T4"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02913198E74;
	Thu,  6 Jun 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697348; cv=none; b=X5IifolTOrIAB2FWCYInGy8HZ+MfxutnMusXpBFNQTBZGiJ5bRMpZKFPEFrw2Oe1aJwg8apPxgKOOGl8HzePDXJO7rro5fd1ZDJUXPr6k2sNc2wKG+zsALsvH6wgR76DyG4uot5L6x69qVsUyuL1y9HtX3LvJpdTyELNlczuPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697348; c=relaxed/simple;
	bh=8rmvDfyR18J9R4Nr5L9/81wBXu6SoSVYsBY65zb4Wdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSLuW7Q0JIPkD5nHGOS+fDW+XhNe2fWAXeMpoyt3qusMA6VjEK3sScfbnpp4cAuboXvMFQ5+j4PGZ0FAx6n1hLqPQ2RpugY1sYenhrGkLyqbHEmiX6Os61IwPEEv98uc+OPANo0RNaHV0GtDcVlBhsJlGIJ2uYMalWQTAta2Y84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIoln4T4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2bfff08fc29so1105993a91.1;
        Thu, 06 Jun 2024 11:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717697346; x=1718302146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uSu71eHsqUtnpmvK2hW8dkSREGhr2OmLFu/qTAkXfY=;
        b=DIoln4T4hE34c4oSQm/+ZKvlffd/LP8+BVJV9odIfxkXXhwgbMBeSbjxyS5OeZkiTI
         J0i7AQobCP8dz3Q8vhLt61qMAkCUie0c7hlNZUyEk3f4HlrqK/wTJ8zSvTn1FgC4C61C
         grhzMJF+UIe3LPi3LnwKTZrzkj8RSSdd1ol6FSkD4W5huiciupqqcft6HLgvpvdw3U5M
         c5LDdHWuh+phKFMfFk+xm/f4uYfjwJUN3wUfHqbnp7CZm7rFBjCiFK+Goi5IctPpb631
         jTpV3nFWBnzT2NKVtYwBUS0THYLERPnfu36kesmb80Q3hzC4+fb9J51+LhwXgibisqUs
         mByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717697346; x=1718302146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uSu71eHsqUtnpmvK2hW8dkSREGhr2OmLFu/qTAkXfY=;
        b=d9XlemMqfkW8DWwtO6hZiotgETn94uPpbXe8Hk8aTOBk6NIJSKYGih7dCCDpbT8R5r
         tWk1ogLa+lVyqemLoHhD5hiy48gfNX/mWN7UEQHvhIuOrPx4DAmS1claPbtZVwtJ8hJF
         yjMBWWvFGMOY5Sn1E3lLtRO1LcE30RCC9V3YsPMyFlXL+0CCMQ85wCgcuGbtyqnkoIqx
         vJwx6RYfpqj6rkvrn3kg9XOHlizuUZJVj8V38ozBB0zHCjswso0T7gCjcRGUkLhVvGiL
         JzfrbxUl8rAAMoJ5MZtm1BYjjtK8Vm20wi0eEEMSMagytTBfUBAWqgNJWGe3zMeifl3A
         gUCg==
X-Forwarded-Encrypted: i=1; AJvYcCULtOdR29Q4h6ep7ucw0uksA7ZhoBSEKuoFPrcNsCj8oNvjqs0vFFxQSxTXafi7x4RFqqU1MzS6heFYwDPf8SLSaakTNz7MO3iOuPIn4bEyMOyJsIjhjPFsAiVq808gPyUvGafY9Wo9
X-Gm-Message-State: AOJu0YzoEAEGjZLj16gSed/9+SjvT1fVtmTJQRdNrLYmlKjMYY6ljoLp
	JptVFD6bUfXmiI6gcgOld/jJYOIDBZnG2j9f+xk4r+7oAOEU4KQ4sxZGsTgKoQCR30ddTcIVYrE
	f638PtagGQawBGhuCVCUkt/8QrZs=
X-Google-Smtp-Source: AGHT+IGVqfib7a6zT10Bihuq1okEft/QKigMZXkxBv7gI9UOhsg+rEzGiZYDIYZIVJEp5FciaEux0sVwRtv6+I1acYM=
X-Received: by 2002:a17:90a:4383:b0:2ac:9baf:25b5 with SMTP id
 98e67ed59e1d1-2c2bcc0b8c4mr271174a91.25.1717697345935; Thu, 06 Jun 2024
 11:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711026842-7268-1-git-send-email-shengjiu.wang@nxp.com>
 <20240424164725.GA18760@francesco-nb> <f0a38df8-9197-452d-a46f-2bc2697c1186@sirena.org.uk>
 <CAA+D8APWGk6oJJsfLhcOfyzMo7uNFABFmeF51gerSC_16xj9uQ@mail.gmail.com>
In-Reply-To: <CAA+D8APWGk6oJJsfLhcOfyzMo7uNFABFmeF51gerSC_16xj9uQ@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 6 Jun 2024 13:08:54 -0500
Message-ID: <CAHCN7xJgqz3_6j5dzJQ5OW_=g_VEYj4zNUBn-SjEBSj1GF9BSw@mail.gmail.com>
Subject: Re: [PATCH v4] clk: imx: imx8mp: Add pm_runtime support for power saving
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 7:37=E2=80=AFAM Shengjiu Wang <shengjiu.wang@gmail.=
com> wrote:
>
> On Mon, May 27, 2024 at 8:24=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> >
> > On Wed, Apr 24, 2024 at 06:47:25PM +0200, Francesco Dolcini wrote:
> > > On Thu, Mar 21, 2024 at 09:14:02PM +0800, Shengjiu Wang wrote:
> > > > Add pm_runtime support for power saving. In pm runtime suspend
> > > > state the registers will be reseted, so add registers save
> > > > in pm runtime suspend and restore them in pm runtime resume.
> > > >
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > >
> > > Is this introducing a regression?
> > >
> > >   800 13:50:19.713052  <6>[   16.531134] clk: Disabling unused clocks
> > >   801 13:50:19.727524  <2>[   16.535413] SError Interrupt on CPU2, co=
de 0x00000000bf000002 -- SError
> > >   802 13:50:19.731400  <4>[   16.535421] CPU: 2 PID: 1 Comm: swapper/=
0 Not tainted 6.9.0-rc5-next-20240424 #1
> > >   803 13:50:19.742514  <4>[   16.535428] Hardware name: Toradex Verdi=
n iMX8M Plus on Dahlia Board (DT)
> >
> > I am now seeing this failure in mainline on both the above board and
> > i.MX8MP-EVK.  There was a fix mentioned in the thread but it's not
> > landed for -rc1, both boards crash as above.  What's the plan for
> > getting this fixed, should the patch be reverted for now?
>
> https://lore.kernel.org/all/CAPDyKFp4V8f0iyeRASSEu4YaCSz0m56=3D8ssBJ9ogSv=
qG1dzMZA@mail.gmail.com/
>
> fixed is merged,  but may not in v6.10-rc1. Should anybody help to cherry=
-pick?

It appears that RC2 has this fix [1].

adam

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/di=
ff/drivers/pmdomain/imx/gpcv2.c?id=3Dv6.10-rc2&id2=3Dv6.10-rc1

>
> Best regards
> Shengjiu Wang
>

