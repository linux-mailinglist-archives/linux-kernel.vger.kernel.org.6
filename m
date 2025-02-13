Return-Path: <linux-kernel+bounces-513115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1B1A341AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606B516D9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E7A281357;
	Thu, 13 Feb 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HQonFS2/"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF56281345
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456143; cv=none; b=aoug/C9NqHUk8r2DyA+d8cztzC+NsObltCCNxLfqigrhAUWU3bHCGG8bBBU/mRtH6lQHUYsvwHtmSW/0EVh4rd0EFJittH7rF6i/iPZ8+hQ7AJgPDplqYNoWXNYzlbCPn4WdzGkZNPLgzTf7azOzEv/IaSxaksLprw3K9WI0668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456143; c=relaxed/simple;
	bh=lM4eQK1a+dpqClSkbP2WPK5Cq1Gt2NOwBVpKWn1R6qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaOnVplfQiwkZBzRsnYSRtjnyX7uzKOyQstT5hkMi9Dx5Bi05CJepESYiI0pAhdrTkpuArziB/VXY31Uf5w8l7V9ReIncrYK2FQ6lA3DnQvCOxXmpvaCXVp9f8PsHN5gt8CHRZwSFoWPuxXScxooJ4M39AW5XBstTBoy/+zAKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HQonFS2/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 70F1B3F16B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739456129;
	bh=etTbPWJYNgmS2bm/UegnueqUIMS4t2fMBvypTde4IMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=HQonFS2/Xm41zxUNIbRsgu0Yd8Z4Q8GP2Nwvnk/HHn/KO526ovhfTUdVkv0Pxs2WY
	 CFLS+yyuaNV2hUXTEKQxBqg4990BJowCo1x3lEkushFQTpWolNmtO+6N6ZGrSKyJVN
	 mhAHPVaQRvGbFFP01pL9RvKkoYRgJNZ50xG5iiilLRvXBNyPqk84F9njVkdAoH1sAT
	 HIe3DxXVgtJrXOwVHndHD0u6chUhSQZlGs41cLBaWQtwovJbjFwpCy319jnv9eOkqH
	 WoQHQ7M9vWihvCVBKUd3VoF8XhamQCgVy0p9SmG+eeUMN7cuNJh9LWzMEajcOm3fF7
	 dK7WJu8Mp+Lug==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220cad2206eso17960445ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456127; x=1740060927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etTbPWJYNgmS2bm/UegnueqUIMS4t2fMBvypTde4IMU=;
        b=B16QsX3wZkSWaRfRPsuOTsVj4Uvf5FWAFgMxVVpsS2wEk0j+9wXilCDE7JAh6A09Y/
         BKitcer7eCqZnllPo43qzsfc+cgR0KJGolysEc+dy6CwMnIZsyjMLobAxOsmAYEo3HDT
         W+4ZEG+HWAu815ROGgy0wY7Ox3OmWYoOiwhbcweAt/XDpTIRXr6ZC5lgqwXSwEI9UJmL
         6EYfOPQ07AhlPiRPvPrvj2ZR6RZAZre6lZl6QDsNPA91wXr1uYMyNC4eDL9Aa6cCVRye
         Q/bkXZ+KTQBJDs5g+bLYgdUlrHAvO1YMrzZu7yFmH7AcsvizwA20Uw7wgLlRhSWgqA3O
         Y1wg==
X-Forwarded-Encrypted: i=1; AJvYcCWVshoPntX0AbVU+TDkfmdYiHVftVEcQFaGEUJfhnWxuQWtanjMSFpO39EEcqv5ELsj20D9+ft7uBphEGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOqjaftTa5PZzhEk1pVTbmtx6GCKKvRzPgnMaa8MRJTxMvhPRj
	QoqIbMrbEdipGFnoM46UX4kBZPuc+hLPOj/roflAQC1JdPUEF+2R+xP6XIRhN8YKwH/oPmJxsj4
	i3dCMDJy9mmEiliATPiLejCba5NjygoYZXOFiWvLD5ruXQ+mlxLrr8UTa9CMN/j9wLfoZ0Hno2s
	l4/w==
X-Gm-Gg: ASbGncsPFgr6Nf+Ue8HWuvRPtcqP4jyON3ST3rjRhSwbRiUXAgfTq8RLdUwkC10mRpC
	8YzOpGom32NG+oolW3bkEoa/E94B6eqhWVSC2XudRnDa9Hq5egibuTjFbvH7UDPRAOjToAs6nvr
	oBkZiDZ5G3o7vEch+bgroL7wn9vm4y8EGNaNP8rEPDYbEPmVNLVMvmhFsOkVQNugldxQYLGlSOW
	WAtu2N6wujwASD4p3pYky0aFB6kV0n7bO5RpegjiIGBmCX1y02Pf6m3kRF1v2C9t2RH4aIQYGeU
	PYcusio=
X-Received: by 2002:a17:902:e750:b0:220:e1e6:4457 with SMTP id d9443c01a7336-220e1e6462fmr21338165ad.26.1739456127494;
        Thu, 13 Feb 2025 06:15:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsxy8JsKyQT1ZjW0Hq56ese54zrZjLuKE/9plR0XYpYv1acRlAtcIwgptap2bfHRkZ0en9TQ==
X-Received: by 2002:a17:902:e750:b0:220:e1e6:4457 with SMTP id d9443c01a7336-220e1e6462fmr21337865ad.26.1739456127133;
        Thu, 13 Feb 2025 06:15:27 -0800 (PST)
Received: from localhost ([240f:74:7be:1:5439:d90c:a342:e2bb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545cf76sm12895615ad.131.2025.02.13.06.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:15:26 -0800 (PST)
Date: Thu, 13 Feb 2025 23:15:24 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-gpio@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] gpio: aggregator: expoose aggregator created
 via legacy sysfs to configfs
Message-ID: <m4rcdq452qrlsdk7lbwt6pq2qlpbat6trvgufl7erope5zojxz@ilsgzm2lquwt>
References: <20250203031213.399914-1-koichiro.den@canonical.com>
 <20250203031213.399914-9-koichiro.den@canonical.com>
 <CAMuHMdVNg5eAtKZ=X7qqnNybk1mS4-5HTVP_ut44D2qEpzkXPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVNg5eAtKZ=X7qqnNybk1mS4-5HTVP_ut44D2qEpzkXPA@mail.gmail.com>

On Wed, Feb 12, 2025 at 04:36:13PM GMT, Geert Uytterhoeven wrote:
> Hi Den-san,
> 
> Thanks for your patch!
> 
> On Mon, 3 Feb 2025 at 04:14, Koichiro Den <koichiro.den@canonical.com> wrote:
> > Expose settings for aggregators created using the sysfs 'new_device'
> > interface to configfs. Once written to 'new_device', an "_auto.<N>" path
> > appears in the configfs regardless of whether the probe succeeds.
> > Consequently, users can no longer use that prefix for custom GPIO
> > aggregator names. The 'live' attribute changes to 1 when the probe
> > succeeds and the GPIO forwarder is instantiated.
> >
> > Note that the aggregator device created via sysfs is asynchrnous, i.e.
> 
> asynchronous
> 
> > writing into 'new_device' returns without waiting for probe completion,
> > and the probe may succeed, fail, or eventually succeed via deferred
> > probe. Thus, the 'live' attribute may change from 0 to 1 asynchronously
> > without notice. So, editting key/offset/name while it's waiting for
> 
> editing
> 
> > deferred probe is prohibited.
> >
> > The configfs auto-generation relies on create_default_group(), which
> > inherently prohibits rmdir(2). To align with the limitation, this commit
> > also prohibits mkdir(2) for them. When users want to change the number
> > of lines for an aggregator initialized via 'new_device', they need to
> > tear down the device using 'delete_device' and reconfigure it from
> > scratch. This does not break previous behaviour; users of legacy sysfs
> > interface simply gain additional almost read-only configfs exposure.
> >
> > Still, users can write into 'live' attribute to toggle the device unless
> 
> write to the
> 
> > it's waiting for deferred probe. So once probe succeeds, they can
> > deactivate it in the same manner as the devices initialized via
> > configfs.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> 
> > @@ -73,6 +76,10 @@ struct gpio_aggregator_line {
> >         enum gpio_lookup_flags flags;
> >  };
> >
> > +struct gpio_aggregator_pdev_meta {
> > +       bool init_via_sysfs;
> > +};

Thanks for pointing out all of them above. Will fix them all in v3.

> 
> The use of this structure to indicate the instantiation method looks
> a bit hacky to me, but I don't see a better way...

I agree.

> 
> > +
> >  static DEFINE_MUTEX(gpio_aggregator_lock);     /* protects idr */
> >  static DEFINE_IDR(gpio_aggregator_idr);
> >
> > @@ -127,6 +134,14 @@ static bool aggr_is_active(struct gpio_aggregator *aggr)
> >         return !!aggr->pdev && platform_get_drvdata(aggr->pdev);
> >  }
> >
> > +/* Only aggregators created via legacy sysfs can be "activating". */
> > +static bool aggr_is_activating(struct gpio_aggregator *aggr)
> > +{
> > +       lockdep_assert_held(&aggr->lock);
> > +
> > +       return !!aggr->pdev && !platform_get_drvdata(aggr->pdev);
> 
> No need for "!!".

Will fix in v3.

> 
> > +}
> > +
> >  static size_t aggr_count_lines(struct gpio_aggregator *aggr)
> >  {
> >         lockdep_assert_held(&aggr->lock);
> 
> > @@ -1002,6 +1048,14 @@ gpio_aggr_make_group(struct config_group *group, const char *name)
> >         if (!aggr)
> >                 return ERR_PTR(-ENOMEM);
> >
> > +       /*
> > +        * "_auto" prefix is reserved for auto-generated config group
> > +        * for devices create via legacy sysfs interface.
> > +        */
> > +       if (strncmp(name, AGGREGATOR_LEGACY_PREFIX,
> > +                   sizeof(AGGREGATOR_LEGACY_PREFIX)) == 0)
> > +               return ERR_PTR(-EINVAL);
> 
> Missing kfree(aggr) in case of failure.

My bad. Will fix in v3.

> 
> > +
> >         mutex_lock(&gpio_aggregator_lock);
> >         aggr->id = idr_alloc(&gpio_aggregator_idr, aggr, 0, 0, GFP_KERNEL);
> >         mutex_unlock(&gpio_aggregator_lock);
> > @@ -1044,6 +1098,8 @@ static struct configfs_subsystem gpio_aggr_subsys = {
> >  static int aggr_parse(struct gpio_aggregator *aggr)
> >  {
> >         char *args = skip_spaces(aggr->args);
> > +       struct gpio_aggregator_line *line;
> > +       char name[CONFIGFS_ITEM_NAME_LEN];
> >         char *key, *offsets, *p;
> >         unsigned int i, n = 0;
> >         int error = 0;
> > @@ -1055,14 +1111,29 @@ static int aggr_parse(struct gpio_aggregator *aggr)
> >
> >         args = next_arg(args, &key, &p);
> >         while (*args) {
> > +               scnprintf(name, CONFIGFS_ITEM_NAME_LEN, "line%u", n);
> 
> sizeof(name), to protect against future changes of name[].

Right, will fix it in v3.

> 
> >  static ssize_t new_device_store(struct device_driver *driver, const char *buf,
> >                                 size_t count)
> >  {
> > +       struct gpio_aggregator_pdev_meta meta;
> 
> You might as well pre-initialize this:
> 
>    = { .init_via_sysfs = true };
>

Will do so in v3.

> > +       char name[CONFIGFS_ITEM_NAME_LEN];
> >         struct gpio_aggregator *aggr;
> >         struct platform_device *pdev;
> >         int res, id;
> > @@ -1112,6 +1210,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
> >
> >         memcpy(aggr->args, buf, count + 1);
> >
> > +       aggr->init_via_sysfs = true;
> >         aggr->lookups = kzalloc(struct_size(aggr->lookups, table, 1),
> >                                 GFP_KERNEL);
> >         if (!aggr->lookups) {
> > @@ -1128,10 +1227,22 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
> >                 goto free_table;
> >         }
> >
> > +       scnprintf(name, CONFIGFS_ITEM_NAME_LEN,
> 
> sizeof(name)

Will fix in v3.

> 
> > +                 "%s.%d", AGGREGATOR_LEGACY_PREFIX, id);
> > +       INIT_LIST_HEAD(&aggr->list_head);
> > +       mutex_init(&aggr->lock);
> > +       config_group_init_type_name(&aggr->group, name, &gpio_aggr_device_type);
> > +       init_completion(&aggr->probe_completion);
> 
> The code above is now almost identical to gpio_aggr_make_group().

(As I replied to your feedback to [PATCH v2 02/10]) I'll factor out the
common part and add new funcs, then use them in each.

> 
> > +
> > +       /* Expose to configfs */
> > +       res = configfs_register_group(&gpio_aggr_subsys.su_group, &aggr->group);
> > +       if (res)
> > +               goto remove_idr;
> > +
> >         aggr->lookups->dev_id = kasprintf(GFP_KERNEL, "%s.%d", DRV_NAME, id);
> >         if (!aggr->lookups->dev_id) {
> >                 res = -ENOMEM;
> > -               goto remove_idr;
> > +               goto unregister_group;
> >         }
> >
> >         res = aggr_parse(aggr);
> > @@ -1140,7 +1251,9 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
> >
> >         gpiod_add_lookup_table(aggr->lookups);
> >
> > -       pdev = platform_device_register_simple(DRV_NAME, id, NULL, 0);
> > +       meta.init_via_sysfs = true;
> > +
> > +       pdev = platform_device_register_data(NULL, DRV_NAME, id, &meta, sizeof(meta));
> >         if (IS_ERR(pdev)) {
> >                 res = PTR_ERR(pdev);
> >                 goto remove_table;
> 
> > @@ -1258,7 +1379,26 @@ static struct platform_driver gpio_aggregator_driver = {
> >
> >  static int __exit gpio_aggregator_idr_remove(int id, void *p, void *data)
> >  {
> > -       aggr_free(p);
> > +       /*
> > +        * There should be no aggregator created via configfs, as their
> > +        * presence would prevent module unloading.
> > +        */
> > +       struct gpio_aggregator *aggr = (struct gpio_aggregator *)p;
> 
> The cast is not needed.

Will fix in v3.

Thanks!

Koichiro

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

