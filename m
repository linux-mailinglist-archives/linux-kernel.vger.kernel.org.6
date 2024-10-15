Return-Path: <linux-kernel+bounces-365266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCC99DFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03225280D49
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B671AB526;
	Tue, 15 Oct 2024 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MVl8ECzQ"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0332318BBAB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978689; cv=none; b=jnADhEaT5dJDewzEOB2dtDWBYdQiKuTWScQWe1tvcWF4wAm1zGtaiIO9kEPIbHLf+eriyFlTO316l8zb9RlpWAgaXPV6buI/oXfxECktOnWl8RXKEAdFmla0crJV7uu1xY3Hchr03fm0DAB+Tglf85Tt5S7HqukOpNvhbORxZnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978689; c=relaxed/simple;
	bh=hfK2U/GrNYgsYtl8NtSXyFYbjdCtuYMGCNrIn/wLtiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avi/quSzBSW8uPLye7IMhN88PozyPFlGZqE1NEqjE7cYEY4ctWV73hzHI0gUwfU/QYlLb4Am/i432+O6tUk9kH4oXLb/ys5tAoORVMa/TxiE9vPQopBzA9bNAx36D2apLIZDVZIzo8dNMAGbZ4cAaSn8XD+C6Oh+LbR1bb7wqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MVl8ECzQ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093997dffdso1390576a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728978686; x=1729583486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aaW2sa/1ZxtztZoldWmZYhD7VcMhjqCGkrdW4rioaxc=;
        b=MVl8ECzQEa1tbVUH82ZXxYOzRXBKBVViNbkl33XR62SUk+oPRJwWsnS0CpQ5GANxcq
         +1xZ9x18Lwk/Je+gYTvKMr3gSyJsS5pXnL8SHe9NtnD3ZWCbH+LjHG4fCTlE8+q+dBFE
         CCTE2PtyFTI6JlPOVgri+SL9Ld3tGnyB4hEG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978686; x=1729583486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aaW2sa/1ZxtztZoldWmZYhD7VcMhjqCGkrdW4rioaxc=;
        b=OGkmo8lUuYmmTEFDRLh9bt3PWf5+JaGNemKVvmvtY0eGXu5FgEDAzI9hNmdTZSoOLG
         +Ko9ggGgDQWXREzycrpVnTGG+p27mnbN+EjmLVEumRILdbq6MeGJQ23pfK7jkLn/S6QS
         XCaoTvWUBvQGdtAEvpPcAVXZgP+nzbc+RZu8+B4GE75z7pPlhB0wgERZoBpuEULsx+uJ
         B+rUoPJHzJBJ5zmuuHM+jDT7S1PSKwPITUvyYAsHpDh7SG7z73zHjirG04uDAtWvm7gi
         M4l4lVF4BXgxVClp2X7/XOT4K/vAYK3eNNZmNgefk5Bghwy/weBKUaRt2LaKriTrdoRy
         7s9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvw7An8xdhFxU5V/CLm5FFiIlWqui8415WSwkVWv/RAdb/MWobdUtQD88ky0rQrFa2C2Njt3zILmxAVwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWUNfj0TMqoj3RLXIi93q+ihKQrVHu8lOxgSjJfTFIMrNcuRK
	LlHQR8ZqVMMa+jpYiReRlafBJnSYGGsi8GizvCA3K/3EEle0358OmxHhLBRgHA==
X-Google-Smtp-Source: AGHT+IEfvWKZ1jcEyU30hF3ZW6BxaiMzf1hjuhVYl88Vngg8HNiMsojaXq2qzSwNVqU01VmSdulBrA==
X-Received: by 2002:a05:6358:52c5:b0:1b5:a38c:11d1 with SMTP id e5c5f4694b2df-1c32bc8c0f9mr537792955d.26.1728978685952;
        Tue, 15 Oct 2024 00:51:25 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:f99b:9883:3b88:182a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c713432sm730557a12.83.2024.10.15.00.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 00:51:25 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:51:21 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>, Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH v8 7/8] platform/chrome: Introduce device tree hardware
 prober
Message-ID: <20241015075121.GA292890@google.com>
References: <20241008073430.3992087-1-wenst@chromium.org>
 <20241008073430.3992087-8-wenst@chromium.org>
 <Zwfy6ER6sbr_QxsY@smile.fi.intel.com>
 <CAGXv+5FAhZQR+Tah_6Qxp4O7=x2RawfWuMh29_FT4mGQGQF84w@mail.gmail.com>
 <Zwz_p3o1PJF6sl2Y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zwz_p3o1PJF6sl2Y@smile.fi.intel.com>

On Mon, Oct 14, 2024 at 02:25:27PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 14, 2024 at 03:04:44PM +0800, Chen-Yu Tsai wrote:
> > On Thu, Oct 10, 2024 at 11:29 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Oct 08, 2024 at 03:34:26PM +0800, Chen-Yu Tsai wrote:
> 
> ...
> 
> > > > +static const struct chromeos_i2c_probe_data chromeos_i2c_probe_hana_trackpad = {
> > > > +     .cfg = &chromeos_i2c_probe_simple_trackpad_cfg,
> > >
> > >         .cfg = DEFINE_I2C_OF_PROBE_CFG(trackpad, i2c_of_probe_simple_ops),
> > >
> > > Or even
> > >
> > > #define DEFINE_I2C_OF_PROBE_CFG_SIMPLE(_type_)                  \
> > >         DEFINE_I2C_OF_PROBE_CFG(type, &i2c_of_probe_simple_ops)
> > >
> > > > +     .opts = &(const struct i2c_of_probe_simple_opts) {
> > >
> > > Perhaps also DEFINE_xxx for this compound literal?
> > 
> > I think it's better to leave this one as is.
> 
> Using a compound literal like this questions the entire approach.

I don't follow. It's a valid use.

> Why you can't you drop it and use the static initializers?

Did you mean split that part out as a separate variable:

	static const struct i2c_of_probe_simple_opts
	chromeos_i2c_probe_voltorb_tch_opts = {
		.res_node_compatible = "elan,ekth6915",
		.supply_name = "vcc33",
		.gpio_name = "reset",
		.post_power_on_delay_ms = 1,
		.post_gpio_config_delay_ms = 300,
		.gpio_assert_to_enable = true,
	};

	static const struct chromeos_i2c_probe_data
	chromeos_i2c_probe_voltorb_touchscreen = {
		.cfg = &chromeos_i2c_probe_simple_touchscreen_cfg,
		.opts = &chromeos_i2c_probe_voltorb_tch_opts,
	};

Instead of the following, which is slightly shorter, and gets rid of one
explicit symbol name:

	static const struct chromeos_i2c_probe_data
	chromeos_i2c_probe_voltorb_touchscreen = {
		.cfg = &chromeos_i2c_probe_simple_touchscreen_cfg,
		.opts = &(const struct i2c_of_probe_simple_opts) {
			.res_node_compatible = "elan,ekth6915",
			.supply_name = "vcc33",
			.gpio_name = "reset",
			.post_power_on_delay_ms = 1,
			.post_gpio_config_delay_ms = 300,
			.gpio_assert_to_enable = true,
		},
	};



ChenYu

> > Not every entry will
> > use the same combination of parameters. And having the entry spelled
> > out like this makes it easier to read which value is for what
> > parameter, instead of having to go up to the macro definition.
> > 
> > For comparison, this entry uses just two of the parameters, while for
> > another platform I'm working on the full set of parameters is needed.
> > 
> > > > +             .res_node_compatible = "elan,ekth3000",
> > > > +             .supply_name = "vcc",
> > > > +             /*
> > > > +              * ELAN trackpad needs 2 ms for H/W init and 100 ms for F/W init.
> > > > +              * Synaptics trackpad needs 100 ms.
> > > > +              * However, the regulator is set to "always-on", presumably to
> > > > +              * avoid this delay. The ELAN driver is also missing delays.
> > > > +              */
> > > > +             .post_power_on_delay_ms = 0,
> > > > +     }
> > > > +};
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

