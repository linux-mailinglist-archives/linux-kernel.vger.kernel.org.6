Return-Path: <linux-kernel+bounces-385932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953549B3D42
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542932887BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D1520101D;
	Mon, 28 Oct 2024 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jpew2H3o"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46716201010
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152300; cv=none; b=HJmDDH71J2UPKIN7NptHB6lgLzNSCDyHURfD/eGaXxhYTiJWyE2DGXyB0ODk1sTeR74P90l3TC+sN+qOG0GCtxSnqjuVskuCUNyTE2JTBVACer7tbDl/F06hLZ6Yroz0DXJglS13I4Yafc0ngH96Gh9hmhpMpPgsX1sJocfNZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152300; c=relaxed/simple;
	bh=9qLDJXZ3fIjfSxkEuavE29HqShFtPoj5eTwQYhV+lUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo16F2bp7rxjvDxZk9mfNpIK22Y6Y8iftvoOCJQTu+1LbDYxIhbeZndeR+IyC9s6uKLnTlzYJlExWtiFP2wYXwm3baQoHtoeUYCWxR+oeR48FEhMQIg4yzHnBICYmNifWr7f2XWHiYuqnb35sjHUHpx5ecl7fbxwWUJGjrOQZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jpew2H3o; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e28fea0f5b8so4541933276.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730152297; x=1730757097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qLDJXZ3fIjfSxkEuavE29HqShFtPoj5eTwQYhV+lUM=;
        b=Jpew2H3o67UQIZ/w67BMTPkRegMPH/cAi2123A7wdMFEBI6U0Q7lWw05n54cypGPg2
         81wjp1m8m3Y1UQzpTEoxkUcSR3Krb2WQO/t/oQE0VT/CnA0vKJCMk8GRUxICgt8eYHKQ
         28wm63GwI6aItw9dAdAMDbtfnQKjzri8WNCl6MeOEpPVtRvvORgoa764YwAXONweomf9
         QTWYa+9QuRM48LxSlGE5Q8SflO5ggf02N4lpEWECPJk6YGym4ctd7MFR5Fb0spEpO2oW
         jvPVT+7IIw1SluQ1sVACcAE/dcbrO7FN/0o/mAuTMhcE1tmFawSKUZ9R8EKdGo1xd/yC
         V4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730152297; x=1730757097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qLDJXZ3fIjfSxkEuavE29HqShFtPoj5eTwQYhV+lUM=;
        b=CaJ0kavodsW9tYclEBnV0gV1NKmowiwwz4OT1smyweTDgkkD5Sd5v2LufjFjbYoRel
         5k4MeNk/nfhUrIZrQXRvMeoual8s8zTknDfnmn8hRREf6/ll3b0KCioaeQxmGW9BiwpX
         JPBCLkFleUi+JjxWaczip0IkzFWXVMwUuH9VtXXygfY6Q3yzEhEF+mjYYILZ/aDLx2G0
         9m/1j02XfOpsc1gPxLhKw3QFrt5jn607Hwk6VjZETv06EfpACAzPIx33f9KlIpwl5duA
         HszL9GWI8V6ui9+rszvZfRTJYSvH+UnRoCbGDSKSVFrvf+w/ugPKq7Dxv/mK+Tc8BxZO
         L15g==
X-Gm-Message-State: AOJu0YxVnX8kLfKlvpzRk8g9U9uCmxY6SbeS3lT++ziMNwf3+e6axtvB
	4M2EsuzOHDb59/hklUTTovUTVszM9KbPzn1BKGKjvjI68aY1BiU0phk+w8jS89Y/gyOjdXtc/s1
	ZvpkjMecYWUYw2kmYlzNfh1FXuUTByN0sTk0ang==
X-Google-Smtp-Source: AGHT+IHGeaxi9oCwvuuA7PbJZSA6oQ7alp5NrGsI3AtrEBKCd3bVoJxof6lJB9e1l9CVuxoUoBVjgK48/iKg/gyfopw=
X-Received: by 2002:a05:6902:2b87:b0:e0e:7fb3:cf88 with SMTP id
 3f1490d57ef6-e3087c35835mr6223710276.57.1730152297217; Mon, 28 Oct 2024
 14:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024094930.3221729-1-dario.binacchi@amarulasolutions.com>
 <CAPDyKFqqCWt5oCj6qBuP_oZ=O1kmkfMirYETPXEeW-AmiA9P+g@mail.gmail.com> <CABGWkvqbiuvBNy2wBT4yVgwP+CY67__+sNxN3vS3Bwss7AwQhA@mail.gmail.com>
In-Reply-To: <CABGWkvqbiuvBNy2wBT4yVgwP+CY67__+sNxN3vS3Bwss7AwQhA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Oct 2024 22:51:00 +0100
Message-ID: <CAPDyKFo0PpqvSHVgL3AaFQUR7B=+MqzCqkg4+t2Rt3nidQzYRw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: fix "sd_count" field setting
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Michael Trimarchi <michael@amarulasolutions.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Oct 2024 at 16:07, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> On Mon, Oct 28, 2024 at 2:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Thu, 24 Oct 2024 at 11:49, Dario Binacchi
> > <dario.binacchi@amarulasolutions.com> wrote:
> > >
> > > The "sd_count" field keeps track of the number of subdomains with pow=
er
> > > "on," so if pm_genpd_init() is called with the "is_off" parameter set=
 to
> > > false, it means that the power domain is already on, and therefore it=
s
> > > "sd_count" must be 1.
> >
> > genpd_sd_counter_inc() is being called when adding subdomains. Doesn't
> > that work correctly for you?
>
> In my use case the genpd_add_subdomain() is not called.
> I am working on :
> drivers/pmdomain/imx/gpcv2.c
> drivers/pmdomain/imx/imx8m-blk-ctrl.c

In that case you don't have a child-domain (subdomain), which means
the sd_count should be 0.

[...]

Kind regards
Uffe

