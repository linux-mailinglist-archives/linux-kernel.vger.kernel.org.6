Return-Path: <linux-kernel+bounces-348428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E92398E77F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A92288824
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944E1881E;
	Thu,  3 Oct 2024 00:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="YUF92g3U"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E27E9
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913767; cv=none; b=H8DbEH7dc0HQGZp1zdsfFyrQweDMxJ7sKnAaqSeYB6/9YoZ3FAe8QkolcCV5goN7cv8gn+t7ftHm7vUiWSNRn8ucD2KP8lUTEUCrh4A5Duv4TZ3NPO6ThCCO7RtsvSijr3wCKKC9mxWiELMuSprtpYsxVcC+o5CMSVjeskKXQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913767; c=relaxed/simple;
	bh=wxXe4ejVOJTns3zNleYmVuoYGt2G0cHj/836wq+z4t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Js6ALn0oR9oKvXN9m/tnnfdmTwDrUGnYYQMIN61VCgmTG1c0GzdTwQqFvYWP+AkSv2xkj1g+CgkyRy4e58FiYfjPUc9fe5Vrs/Tf8RWIJEV8Yo1ke2fbrNEGYocIzYADlqRSHE3G5w5TA/l9XdRBcVvG3GNqP4Sc8ULViF1MdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=YUF92g3U; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b58f2e1f4so1957635ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 17:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727913765; x=1728518565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gUM6/c8POo3ZmmnwIz3ZYq2oPmzsWDU4VKk2RR1uleQ=;
        b=YUF92g3Ub/bC6zHFYzuF0FrrOV5DUEtLZr1l7Ze6UWOycm3Zl+sDN9grY2JoZmJBIV
         53n1wFyTOaR8ca1cvaJ0f1jCSdvouEoHxRf+C4uO1bTLekm1QvYa2ZTy62ZJnDMFma8i
         yUjHsoUkY/14YtpYR3aLYaeS7oXomUgDAX+OfHn+fEV3cy7migzGPzKdf/q55rWBkiv+
         koMb9OQjEXydOHrpAJsHbiHm5Wxmp3E8yF8uTUniBhGaofBqTPZ+vtpHpzVMnNaq316C
         7KCGD5bo5y/68SIdR11R+vUg5k3to50Kux0Gby1SAi4iyVS5E3pzE8wTWTCNAYm8nAVv
         TMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727913765; x=1728518565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUM6/c8POo3ZmmnwIz3ZYq2oPmzsWDU4VKk2RR1uleQ=;
        b=Og5oNsai0rkl9HFuItUtZsF6C6EAVMsY/R8y3WYKjfcqjfCo3DGO/RgZTj2tJj/Uin
         9xrC8CjX4opeFNHuWETJcTK0O5vjm+Wy/SFZFMV+tVk4flIWh797y35yDhnYDZEpS642
         52g350F4DWmZ7GwG/e90Vw1fOyXC6AhcPcx4l9r4yUhlOg9IaeRJXNcnhtMgRBLp1cF0
         nh2sT1JG1FUpYHoQATdugdFsL9j6FzGJEqsHR97FoDrt8UML5n3CG35v5VZNtrm3DyJ1
         jSGESMv0D5cwcw1jX33s4x6o5ruZNC7l1Lgb+hXdhOTsKNku7XTX3ky/U2/8aDpdWMeN
         YBog==
X-Forwarded-Encrypted: i=1; AJvYcCXoG8Copf2MPhyk9hfhW/Pdy4cLLLJ5FCIvdp+uFgcDrd8W1+rGBTptSksAapZlTSn6SuML3J/qsb8gB90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGg4ULMYY59i6q1Ie8BCRip2g7lvtcX8vK3nuwsCOEho8ta10
	y3QWlsDcUa9uVqLsfCwCne5WFoUdNy1lnVgK2XQhhnRbE1vd2ZED63w9EhzPQg2RzCCiKKYX1zQ
	W
X-Google-Smtp-Source: AGHT+IHmCdNn6jRxhW0IWH2DWwz1m/iZxhIonrOaAjcX0AB8vRdu8ZUUUlS4NfAWFjw2P+QvaTjpcQ==
X-Received: by 2002:a17:902:f685:b0:208:d856:dbb7 with SMTP id d9443c01a7336-20bc5a5d0damr71931745ad.39.1727913764912;
        Wed, 02 Oct 2024 17:02:44 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f77d235sm2268445a91.22.2024.10.02.17.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 17:02:44 -0700 (PDT)
Date: Wed, 2 Oct 2024 17:02:42 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] pinctrl: Add T-Head TH1520 SoC pin controllers
Message-ID: <Zv3fIuMUhukmOWQJ@x1>
References: <20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com>
 <CACRpkdavPAv2sPRREQhx_A7EtOj6Ld_n+NcO+vH0QCnfVedXKw@mail.gmail.com>
 <Zv2SUVv2PUYqwOzh@x1>
 <CACRpkdZRg+k=N42EA3+3c4Er=DHf2Q1aVzzCM0OQuEx7xWMAvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZRg+k=N42EA3+3c4Er=DHf2Q1aVzzCM0OQuEx7xWMAvw@mail.gmail.com>

On Wed, Oct 02, 2024 at 10:46:41PM +0200, Linus Walleij wrote:
> On Wed, Oct 2, 2024 at 8:35 PM Drew Fustini <dfustini@tenstorrent.com> wrote:
> 
> > > Then I merged that into my "devel" branch for v6.13.
> >
> > Thanks for taking this. Will that also end up in linux-next eventually?
> 
> Yes next -next.
> 
> > I'm working on a TH1520 Ethernet driver which depends on the pinctrl
> > driver. Andrew Lunn replied to me that all the dependencies need to be
> > in linux-next [1].
> 
> Well compile-time dependencies for sure, run-time dependencies
> we are usually a bit lax with as long as we know they will
> get there eventually.
> 
> > > I think I'll make a stab at using guarded mutexes etc and see what
> > > you think about it!
> >
> > Do you mean using scoped_guard() for thp->mutex in
> > th1520_pinctrl_dt_node_to_map()?
> 
> For all mutex and spinlocks in the driver.

The thp->lock spinlock is already using scoped_guard() everywhere.

I will post a patch that adds guard() for the thp->mutex like this:

diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl-th1520.c
index 1bb78b212fd5..b7c2d998e9e7 100644
--- a/drivers/pinctrl/pinctrl-th1520.c
+++ b/drivers/pinctrl/pinctrl-th1520.c
@@ -444,8 +444,8 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
                return -ENOMEM;

        nmaps = 0;
-       mutex_lock(&thp->mutex);
-       for_each_available_child_of_node(np, child) {
+       guard(mutex)(&thp->mutex);
+       for_each_available_child_of_node_scoped(np, child) {
                unsigned int rollback = nmaps;
                enum th1520_muxtype muxtype;
                struct property *prop;
@@ -530,7 +530,6 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,

        *maps = map;
        *num_maps = nmaps;
-       mutex_unlock(&thp->mutex);
        return 0;

 free_configs:
@@ -538,7 +537,6 @@ static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 put_child:
        of_node_put(child);
        th1520_pinctrl_dt_free_map(pctldev, map, nmaps);
-       mutex_unlock(&thp->mutex);
        return ret;
 }

--
Thanks,
Drew

