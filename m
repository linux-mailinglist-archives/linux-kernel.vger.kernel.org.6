Return-Path: <linux-kernel+bounces-235987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1124991DC18
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A111C216C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35212D747;
	Mon,  1 Jul 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhtmeHKb"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D263126F02
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828537; cv=none; b=uGI9bQyOb5PAp+qCoxrySzLOGk6dgybNZqCSfU2st57RQFme+yqUUhrbzMcb4ypfOABp68nnj/LPMssrNHALAu04SOggwQddG7i4yxncLFb/d2FpdLaDxhMujoCfhPRkjZHImNZZ1bB7kkOgZSjRLujzazQqDZLQeqpn89V+MrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828537; c=relaxed/simple;
	bh=Aa++gCLn3lD+NqzuYFw3VYIsdm8ZENJyZaQkJnhuZ7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cunC8slxTxEOQ29bjI2wMm5zFz/DR9OGifhmqhdWauFQkuvwVX8zWdgkd7T4VM9JQLLlSjMibq2Uwtpf4qC+LvlcpXl21qQLYd2+cnHLC+KfTiyLdJbJJOISHk7DucHMTnlKONBxSAXguQZ2mnUv/a340xU0o7EjB9caRSc8ZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BhtmeHKb; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6325b04c275so27857957b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719828535; x=1720433335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NycmgRDsq327D/ssa2zH2umzDutW5jKnX1XFk2AIiOQ=;
        b=BhtmeHKbx7UCJOdCGlQI5WZyphmtyTgNXgMruzAXfr7c8kHkYCW3rrcqY0Yvlf5LB9
         VY+xtgQEESVNUOV7J8bwOsqjJ9ptgWgObwHviZTYTDCvf4HPfi2sUYGfrfUSypgJF4bE
         IcgQKY5H/3O8+7Dx7V8m7GvvEsZjeE1QakxvTTscKEe/rGYjXiLYIONIqO4QFJJR8DVx
         WqjOBEd5kposlpy7wRi8jPdN6r7DCBTuzD+orwImXa3LkIeuDTdwLWqc5TEHu++UmNfd
         B0GX5G6ngDC/isHkExBW2bjdv6roTggNWUfE9qtqY3Ly4gxyYWtKYD3lLil0IJFhGYsr
         /OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719828535; x=1720433335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NycmgRDsq327D/ssa2zH2umzDutW5jKnX1XFk2AIiOQ=;
        b=DIQ3xQRnLxLIN2EZ8fKb3IAVIrB26jggZOTmhDoRKj626nzFNm3WpOt7sVn8F3l7RW
         +qtEwUgwYdhT6Kqy6/n6RYoxKIsRDEBhxDsCsNEjcl+X5KLrUhZu4yiUNKsx/LW9JDHK
         HiaHp1rOpNOPWPDAx5kCpmRWxJOIBziyflRR1Mm6FbJOPzVVlhgTLPlJspaPbXiLYEYA
         q5uEmMQTmQ3mwwEgU5jH9sSPreMmHoyk9t3W7Z3SQ9UQy0RW7D06RsmgroqsKFAOhKga
         XM8sMRjO0m/v41PzTZyB3d4H22HgQ0krKhnq0t7H0ZIV1bysVGrL4wrWJATIFiz3lUKl
         FUaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWECmZI65Dj4fByoPjS7xj4xG6meo2f0z/8WvbL9L7zhOJ3TTJrKb6aKPLM9aeEXslJuGxMXs6pLhyrG8bFhTN0ItZuZ2PI4G3+O8U
X-Gm-Message-State: AOJu0YwkNGxe51CNRH8NKPR3zjHoJ03Z8CZna7/fxRJdacBsSmrSoMPB
	tOwrt470vnlchevwIS2mlIguquU7nvjTkP9G1xMBotYZVBTgLIP5iGzr2Mg72CCPUHRDiwavJDN
	tRYs9FXI4SsH0b5NiMQFSqU0oUpIkya7k/Hptm/ObTTPl4ndoByVkNONmv0s=
X-Google-Smtp-Source: AGHT+IGwi8WafEVjmBObOnzPp7tJ35c7X+EGOliYOe27SUZqWJxtxBxMEXMJreOS27yNOad4E5WT+Ba5yGrNIupy4u4=
X-Received: by 2002:a81:c441:0:b0:61a:d4ea:b856 with SMTP id
 00721157ae682-64c7277ca98mr42261657b3.40.1719828535353; Mon, 01 Jul 2024
 03:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZnxhiKAYvoqNIywH@sirena.org.uk> <20240701172655.3db48d51@canb.auug.org.au>
In-Reply-To: <20240701172655.3db48d51@canb.auug.org.au>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 1 Jul 2024 13:08:43 +0300
Message-ID: <CAA8EJprxGyEK-1jXBJOmBT_+VDyEKD2DVN8shwan60GO5-dopg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the rpmsg tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Chris Lew <quic_clew@quicinc.com>, 
	Steev Klimaszewski <steev@kali.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 10:26, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Mark,
>
> On Wed, 26 Jun 2024 19:44:24 +0100 Mark Brown <broonie@kernel.org> wrote:
> >
> > Hi all,
> >
> > After merging the rpmsg tree, today's linux-next build (KCONFIG_NAME)
> > failed like this:
> >
> > ERROR: modpost: "__auxiliary_driver_register" [drivers/soc/qcom/qcom_pd_mapper.ko] undefined!
> > ERROR: modpost: "servreg_loc_pfr_resp_ei" [drivers/soc/qcom/qcom_pd_mapper.ko] undefined!
> > ERROR: modpost: "auxiliary_driver_unregister" [drivers/soc/qcom/qcom_pd_mapper.ko] undefined!
> > ERROR: modpost: "servreg_get_domain_list_resp_ei" [drivers/soc/qcom/qcom_pd_mapper.ko] undefined!
> > ERROR: modpost: "servreg_get_domain_list_req_ei" [drivers/soc/qcom/qcom_pd_mapper.ko] undefined!
> > ERROR: modpost: "servreg_loc_pfr_req_ei" [drivers/soc/qcom/qcom_pd_mapper.ko] undefined!
> > ERROR: modpost: "auxiliary_device_init" [drivers/remoteproc/qcom_common.ko] undefined!
> > ERROR: modpost: "__auxiliary_device_add" [drivers/remoteproc/qcom_common.ko] undefined!
> >
> > Caused by commit
> >
> >   5b9f51b200dcb2c3924 ("remoteproc: qcom: enable in-kernel PD mapper")
> >
> > and likely others, I didn't look too hard.  I have used the tree from
> > 20240625 instead.
>
> I am still seeing this build failure in the arm multi_v7_defconfig build.

This should be fixed by
https://lore.kernel.org/linux-arm-msm/20240626-qcom-pd-mapper-fix-deps-v1-0-644678dc4663@linaro.org/
, hopefully Bjorn can pick it up.

-- 
With best wishes
Dmitry

