Return-Path: <linux-kernel+bounces-523806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03169A3DB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADC917D0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179A81F8F09;
	Thu, 20 Feb 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mdoDf3rO"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF52BD11
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058807; cv=none; b=rmOShwPQLayz4uxhW2dG+mjI2ysfzET7kht1AiUax4JOcvLZunzwNqdDtguMxOU4RIAuh9gYxs2zBIYEYzYU0hFiRbriJUD7N9c6YvMAomZdLVirnffa+vz4Ow5wqRUvVlz6CUXOb3inafWIusWGrosSdKQE/Yi0u2XoFXrWB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058807; c=relaxed/simple;
	bh=yjEUde99KgzakBJbQx6a/8UMTsQ+4EbwER2WXeBEkDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+TxMEDefiJoMT6VrYf4fjt35dZcM/7YcWgdgAM6lXqZ1T+M/vpXz73RNI11f2MC7CExesBnZcLEyg+qiTQxx3bGRLuTl0FwBobDqvNJFaFVp28543TQKQE0/Zr9yE6uLIHl1SQA+rQzheh7jxy+AXP3N0VoWwwzoOoZxZNbnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mdoDf3rO; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 61A543F2CB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740058796;
	bh=iiP50cFP789o1GE1IPKlebj+94gihSf8dowgIFkuU9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=mdoDf3rOlOPLil0eAov/FGr+AFELlzASq9UxPTbPU6f9aqKl2qTfO7n/l1seo6qEz
	 HmRZ4/Lhl8kWdEVGEa20wTPzmuVH0sDiC633UpAAHHsUboczVJyjpNxpBA6aFVFykC
	 1T3rclJWAjz85BndnCeoPYNMFvh9Dg912QaJMYnrK4IJ+ZFqyxstQIMHLAY6NWby4Z
	 oZCsltIFCSFgbvNsW5XvWoQDKozm46JOWQ0QJpMnH6tSynrtspNWUzwVB1DPYjKD86
	 ZMMZz4pvD1JBpEkldROE2qLsf6ljV63ZXuFt/WR2zGgQjh0AV54kybumLpWoGXbqEs
	 Ot6q3e3lcRyig==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22114b800f0so28469515ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740058786; x=1740663586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiP50cFP789o1GE1IPKlebj+94gihSf8dowgIFkuU9c=;
        b=Klui48vEgoJCcXtRumoqq7fb9SODLMxCn0kZQxkVcQUgDoqQdXW+ToXlxcPWT1FKLD
         Kucxan1iCIKipFB63b1+N3tqhLpcFguMIoALEWULWlDKTMrtnGN2o4/dGvzs7dqf2Z24
         g+mgbOwbk6m+i2mgMGUm4Sg/lhh/7qjiqoy/Ld8TzYowsRq1lmoUyJSnvZtAoCkz/H3u
         IzXmewdSAbmL85Ozttwax+FQ1o9tXrBEUrg/gcidsMxXil9O6I5cmEjk4x/mVoIMPU7W
         Z2ZyBp4oMbNrJc81Ves9pllQF+HZ1ByNA4wT7L3/baQf6UVtDFt5YNue+U8w+HwnAnRR
         M5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCViDP/GyM1Liqh+NgkikQZ5UssEPWSTkI7SjI6lbq2445x1hPL/9lwvnoQpZoj4rM9rYnsrtD2qcHgmiac=@vger.kernel.org
X-Gm-Message-State: AOJu0YweVP9ULbmI8YklZVaEGqBCBt4rKrc+jVyo25oVOrWOlDjsIjbu
	uJVo6n4/S57d6Cjm3Q7uWCrN1O7AumeIPkIYaqdeV11UxB/OaPk8BycojGKbksB0LVxLAnTwqmK
	KSZ8TP4/SMQLb5h7Sz1eOJogR53ltG4RMo31VGJ8WTB7S2E4JYKZxy5gWFJF5jz+iPoBv4NI9dp
	CR8eJnT+RGHg==
X-Gm-Gg: ASbGnctCWlQUblKEHK//L+yQ3gtGD79WcSX0Aqrd7b8DdSS8pWnlqPeaZvIrf5lFb39
	kkEqaBSy6Nc/CXG0743R2MZQn+ZKuyl8O77p4TMaMCEowcpASIPzT+3fXS7/YQadATZTIM8BKfY
	QHzU2SdPPtO72jaDf6JxV02Shn0PrMjRSebsawgxKppjpBFEukKq0C3ir7jxTkHW8mGgpyxUvn8
	gRFC0DxRHkwB4uJ9Jtd0F8eXYfU804xFh6h8tgzoJVycV4c/ZxViTVE3hB0GFOeBMlg/XQxK7a+
	29Jb7yo=
X-Received: by 2002:a17:902:e801:b0:216:4064:53ad with SMTP id d9443c01a7336-221040bf829mr387389355ad.48.1740058786689;
        Thu, 20 Feb 2025 05:39:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhmAlPudojVgfawOJMuWdHGMWxc9h86if7RnadO0XpKZaLYbOxk06f6NJUmK9czRHJoKzPdQ==
X-Received: by 2002:a17:902:e801:b0:216:4064:53ad with SMTP id d9443c01a7336-221040bf829mr387388975ad.48.1740058786301;
        Thu, 20 Feb 2025 05:39:46 -0800 (PST)
Received: from localhost ([240f:74:7be:1:256c:5029:b967:ebb0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm121209445ad.39.2025.02.20.05.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 05:39:46 -0800 (PST)
Date: Thu, 20 Feb 2025 22:39:44 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] gpio: introduce utilities for synchronous fake
 device creation
Message-ID: <fcfanp2bfokggj3dhzdceaza2bhxo7xrbru5cy36ciaumpfua2@kvabbos3znjt>
References: <20250218160333.605829-1-koichiro.den@canonical.com>
 <20250218160333.605829-2-koichiro.den@canonical.com>
 <CAMRc=MfmG0okVjV1nH78Aw18dFcoOAZ-UwU-iFc1VKb-BVcTxQ@mail.gmail.com>
 <wyicl2dgxkwxzfwd37cmhgshnqb3phmpeboz3gwqqfmbabaegy@tkjx56nj423u>
 <CAMRc=MdhkiaDs8t9BYveYhy86+svQkHnPxhGx56AMOs=7n9mcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdhkiaDs8t9BYveYhy86+svQkHnPxhGx56AMOs=7n9mcQ@mail.gmail.com>

On Thu, Feb 20, 2025 at 02:13:42PM GMT, Bartosz Golaszewski wrote:
> On Thu, Feb 20, 2025 at 2:07 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 12:06:33PM GMT, Bartosz Golaszewski wrote:
> > > On Tue, Feb 18, 2025 at 5:04 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> > > >
> > > > Both gpio-sim and gpio-virtuser share a mechanism to instantiate a
> > > > platform device, wait for probe completion, and retrieve the probe
> > > > success or error status synchronously. With gpio-aggregator planned to
> > > > adopt this approach for its configfs interface, it's time to factor
> > > > out the common code.
> 
> [snip]
> 
> > > > +void dev_sync_probe_init(struct dev_sync_probe_data *data)
> > > > +{
> > > > +       memset(data, 0, sizeof(*data));
> > > > +       init_completion(&data->probe_completion);
> > > > +       data->bus_notifier.notifier_call = dev_sync_probe_notifier_call;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dev_sync_probe_init);
> > > > +
> > > > +int dev_sync_probe_register(struct dev_sync_probe_data *data,
> > > > +                           struct platform_device_info *pdevinfo)
> > > > +{
> > > > +       struct platform_device *pdev;
> > > > +       char *name;
> > > > +
> > > > +       name = kasprintf(GFP_KERNEL, "%s.%u", pdevinfo->name, pdevinfo->id);
> > >
> > > pdevinfo->id is a signed integer
> > >
> > > I'm also wondering if we could avoid the allocation here and keep on
> > > using snprintf() like in the existing drivers? On the other hand,
> > > memory is cheap so no big deal.
> >
> > Are you assuming the following change?
> >
> >    struct dev_sync_probe_data {
> >           struct platform_device *pdev;
> >   -       const char *name;
> >   +       char name[32];
> >
> >           /* Synchronize with probe */
> >           struct notifier_block bus_notifier;
> >
> 
> No, I was thinking about a local buffer in the notifier handler, like
> what we do currently in gpio-sim, but no worries, you can keep it this
> way.
> 
> > >
> > > > +       if (!name)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       data->driver_bound = false;
> > > > +       data->name = name;
> > > > +       reinit_completion(&data->probe_completion);
> > > > +       bus_register_notifier(&platform_bus_type, &data->bus_notifier);
> > > > +
> > > > +       pdev = platform_device_register_full(pdevinfo);
> > > > +       if (IS_ERR(pdev)) {
> > > > +               bus_unregister_notifier(&platform_bus_type, &data->bus_notifier);
> > > > +               kfree(data->name);
> > >
> > > We could probably simplify it by using __free(kfree) with the name
> > > variable and just setting it at the end with no_free_ptr().
> >
> > platform_device_register_full() call path might finish probe so before
> > calling it, we need to make sure the 'name' is filled in. That's why I
> > didn't used __free(kfree).
> >
> 
> Not sure I understand this. Would you mind rephrasing?

dev_sync_probe_notifier_call() references dev_sync_probe_data's 'name'
field. In dev_sync_probe_register(), platform_device_register_full()
invocation can possibly succeed in the initial probe, meaning that
dev_sync_probe_notifier_call() can be invoked before
platform_device_register_full() returns. So, 'name' field must be set
beforehand, and I located 'data->name = name' as shown above;

If I used __free(kfree), the number of which I needed to write
'no_free_ptr(data->name);' would be the same (= 2 times). So I thought that
calling kfree(data->name) without __free(kfree) was simpler and better.

> 
> Bart

