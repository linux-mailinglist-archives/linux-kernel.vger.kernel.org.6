Return-Path: <linux-kernel+bounces-181957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC718C843B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248DA1F23200
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADECB2C85F;
	Fri, 17 May 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTPI1yah"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B792C68A
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715939466; cv=none; b=FyTRPI72C1hG5yFmJ3iXDfuX7cO4TMWVScWuXDp8CRrW44TUe7U+I6dAV5L6a1L/9UONQ9V/HS5FMBA4vcSwTtrAwfPDpHWU5XiXvei9K+kd7jz2XmRYw03u0rS8/04VnoUazNV1ba8NAMKxfO7wQuz8NmdZZOm37C1ol8dCUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715939466; c=relaxed/simple;
	bh=umr6x9k3m9I3EaMQpZAla3HYIuVCB+b9qLGvmHWWLBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV54yHlkLs3uTSlJ2wzmA1uurm/BOgNKLR3iVr04oMAD18eOBYWdusiU2gh599lYFv1AboJNyW74/BhWyZrJmJW5omJBe6hQcVp4Z0i9hNAt0xsD0iBzkbD4xl8Eg73ai45Wmp7Uu7DqrI2sW7jpjjOxd5rOFWKqp+qmaejiUe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rTPI1yah; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e428242a38so23119521fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715939461; x=1716544261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2L8RSK1UXgr12jXF9ubAdgAxLZaIH1liHhgWTNSlMsQ=;
        b=rTPI1yahKw340MOh4dMjhEOumBv0MWiuBtO2W5foCpzRzHU3y8UvXclEBXMugf3XrL
         Fr/y0bSFF4gcc9doIAFEQG+I0yY7iH7UUVgtF+c9qSp2UeMgFJQ3dlGQXiO6XFJbeZG+
         t4YnbNLaNsQt8+NMvQdQk1ik7Zrlo1A76KOnKbQ0sXdNhuteDIgfESCk0t8/+P0hB959
         /Y31YEDuTIiPFjv5sjaei1Ev46H/PPnpTebcv7T3tAlK7wb3heAxJ/nc+Iz8R3NUyYgl
         7stW1aM1gWNbjlPrDcYSJKU+UMvTyGzvNZ5cJAT/xexD3419pUI9QDVIR/fS+HUQkVkM
         F3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715939461; x=1716544261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2L8RSK1UXgr12jXF9ubAdgAxLZaIH1liHhgWTNSlMsQ=;
        b=vm/sZTXM/Skjgu7Zf9uKpIF/+F3kJxsgbLwa/t3BBwVLw+hIJ09s7Drn6Prufzgyhl
         /fhBM7j9dG+9ZZJwMgH1bJwkbA60j2pPBYNYqrppdzDOXbIADgfty+0rD17NN/sLazGR
         W+7JH9l7L9duTnLTyuzVHOhMTL0VmdDJn923wk4gzbSrxZXIXVqobu9PVAu8aQOdXpH+
         cQG5rzUAk5agSY5wowayfButd16ElLlmwqbnq8+IZPkp119Rnk7u2kDbH0UgbSPXA2j/
         rQO8XRZ+2aIw8FQ9jPkW00/XC4ED8QVJ9046ifPcsOzCSgVEjGR+RD0k+oQELADjhzEt
         sLeA==
X-Forwarded-Encrypted: i=1; AJvYcCX8fZzq0S6fDemVI2kEHRUDwL607Mjpua019/+L5lg3yUT0IkHFNtZokbhWoZmAS3q5dDDNsEdtSkojecLcT4NjdBZVIbi4w7PdWjSl
X-Gm-Message-State: AOJu0YxwKVyuXks+8OmHhw75FPVPdYdkNklDeXE4F7W0Ja8vDfsEV8SA
	P9RQPbSUPa9GCWP7mS4ISNXAS0WYYXaLyMTxnpLB1Lg2zjDf3+LDJN44VKGiq8w=
X-Google-Smtp-Source: AGHT+IE/i6HrkK9a32WnwA2ipdftjxu8Y3Zxt+EzO3KENJBumi5p2N0H8j3JeSeqai45ufNVMCWpLQ==
X-Received: by 2002:a05:651c:546:b0:2e5:4c78:1227 with SMTP id 38308e7fff4ca-2e54c7812famr187118681fa.31.1715939460955;
        Fri, 17 May 2024 02:51:00 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cfbd73547sm147700966b.171.2024.05.17.02.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 02:51:00 -0700 (PDT)
Date: Fri, 17 May 2024 11:50:58 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Icenowy Zheng <uwu@icenowy.me>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kang Chen <void0red@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/2] thermal/drivers/mediatek: fix a regression affecting
 other subsystems
Message-ID: <6b643d19-bdd9-4c35-a775-b8e3c21b75f5@suswa.mountain>
References: <20230529162056.3786301-1-uwu@icenowy.me>
 <40546a57-27ac-8bf9-a2d8-77f7d4ab4aad@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40546a57-27ac-8bf9-a2d8-77f7d4ab4aad@linaro.org>

On Tue, Jun 13, 2023 at 10:44:51AM +0200, Daniel Lezcano wrote:
> On 29/05/2023 18:20, Icenowy Zheng wrote:
> > In the commit I reverted as the first commit of this patchset, the
> > of_iomap function call, which allows multiple mapping of the same
> > physical memory space, is replaced to calling devm_of_iomap, which
> > registers exclusivity, and on my system (mt8173-elm), preventing display
> > from working.
> > 
> > So I reverted it, and to really solve the problem that the original
> > commit wants to solve, I read the source of auxadc-thermal and realized
> > that the address of these two memory blocks are not saved after probe,
> > and they're only used when initializing the thermal sensors. This leads
> > to my final fix, which is the second commit here, that adds of_iounmap
> > just to the probe function.
> > 
> > Icenowy Zheng (2):
> >    Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource
> >      leak in mtk_thermal_probe"
> >    thermal/drivers/mediatek: unmap foreign MMIO after probing
> > 
> >   drivers/thermal/mediatek/auxadc_thermal.c | 46 ++++++++++++-----------
> >   1 file changed, 24 insertions(+), 22 deletions(-)
> 
> I'll apply only the revert and let you revisit the patch 2 which could be
> improved.

What's the issue with patch 2/2?  It looks okay to me.

regards,
dan carpenter


