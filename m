Return-Path: <linux-kernel+bounces-372901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990799A4EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B8CB219B9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20D27DA62;
	Sat, 19 Oct 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQn/muxo"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2F173
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350820; cv=none; b=ogsKtcpP9gLeLIaMmXkG9WFsf6UUDbEcez5awL92JQ+O+qs7WKKq7QRmFOkFiityq6GmTsGc0So2MhwrCBoj5cJNE00M8PliP7ANwNEFON05HXLD9W9J12wh99U8aTxKSn7ewlORghpgVZ+0KZfWao0jMFP5XCAt4BSQpUhOUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350820; c=relaxed/simple;
	bh=r+4UF3bIyWHWZeMOvIqIxRJJnIHBaFwS9yuPhD+7+po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj4Cdb6rMAcSGUv8JqzXTm2zuJUMbfh3DaGud+H0JLslL/CQp0I0HkPzZ2ijHqoao+eUJezImWV8H1E7ffrkZKSbrfTCEqFVpLsHXmOGcz+xuHxJEYFE4PZ6tsExZtXtbR0XhkpsDVoSyuVIq3n4AHGRz6MtNt2nwlM8lTjFWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQn/muxo; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e13375d3so3425388e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729350816; x=1729955616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krDiZS5nG2/3uBKdMbeGhCgLy6IYu8PQz7aJnr+yJi8=;
        b=bQn/muxoGrGWq28VxfcE4wGq9KlccIihZm+JsL0tKJee+6mOoMSMHP1vqUUtT1i6v3
         CqjkRxpaxZfnZs3KMx8o4F6NOHPEf7uBrP/AFZnSqzUvc+/p16q+iK+OyrCxNtlyOtl4
         NhzVhL9+pUSBQAsVYcVSpE0ay7tjahQK7P3GurU6FH8Z4f3YPpjaxS+jh2O08X6C3B4h
         Y1A2b7+SmXwLmthLjUKak+/H+Ejzv5HZWLkFG9xGPEi4htLA+6kNR0N/wm1AXvX4Cg57
         RXycfz8da3p9TMeL1k6YvYpf9lyho9CbaZJ6Zo04lNBk57t0/G3bsqxp2EvHGb2RWvc7
         FmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729350816; x=1729955616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krDiZS5nG2/3uBKdMbeGhCgLy6IYu8PQz7aJnr+yJi8=;
        b=d1WRf++KTnhGd2WUTuwXdy39LTXzwi7DiWsNPK+XGQlYS6XPG53/Ur0GBha8P1L5J2
         yn4m3tKdMHc6B3ZmbXD22F+937Sj0ApJI1kEdO0AkHuTSjPDZTg9tJ4A22L8fAtWFQSI
         iND1k320MQAlzjtvapvZWX1VvnWhy3i/iMzR2tJXMi80qW/gWQ+mgtq7y/8xD7PmfYQv
         0HpRagxw7hUgcV88/Rb8XFyGUJbhsYZI+7rBnisJKi5cjBcJAfocTmrJOrtw7GlY3dqp
         ZbrULMpGhg9BrEvVYx+9reXkGgBxTRFPw5vEuafU/CtKaCbphaVQ8rf4We8TIBpgclJD
         LUPw==
X-Forwarded-Encrypted: i=1; AJvYcCXA7y3kAKFHrdb/6b0GqsyyjKxDtOFoyCG3z0LPhZ4/TB1lUtqsmvYIksVLemobo7ygWdUbKEgIZaCK03k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXJQ+vz5zh1qXeWHnlIsqO2cZKvyscTqjRU8hLHaY2uIvz3pt
	1NHlbrtIKiXiq77MZVLwoCUQpJzv9dfb3UvuwQOQ/X4mdbLLBWjsaSVu0xETpVg=
X-Google-Smtp-Source: AGHT+IFKuCMcWShdcdkh/ap+77wNM798VkP7IdlHdjPLjXCmNwfRyk8EffhOcww/3NmFY/vphGzgLA==
X-Received: by 2002:a05:6512:3a93:b0:539:f36c:dbac with SMTP id 2adb3069b0e04-53a15441a99mr3156756e87.4.1729350815916;
        Sat, 19 Oct 2024 08:13:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b92f7sm548187e87.71.2024.10.19.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:13:35 -0700 (PDT)
Date: Sat, 19 Oct 2024 18:13:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: Re: fw_devlinks preventing a panel driver from probing
Message-ID: <wsg6abva53o3qxr2yycym7nubgr5rrvbmkq3oaf3zkqmmnaczs@a46rfhcxky6e>
References: <1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com>
 <34mewzvfyjsvyud3lzy6swxs7sr64xkgrbkxtvyw3czvoerct7@7guo32ehwa52>
 <5a540bdb-e3ca-494a-b68d-8f81f4d1cc1a@ideasonboard.com>
 <il3s26owmtyf3knniv7klkmw3uuz4dffrump7jo47dk6hxdsya@v5plmtjcbukf>
 <bed619c7-1a82-4328-825c-117c2ee3639d@ideasonboard.com>
 <CAA8EJprDdst-mcwMsWs=0AHGCNa_5Ng90tubSJ7VAHamx2T93g@mail.gmail.com>
 <babeae17-488d-4428-aa55-fdd904a5425e@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <babeae17-488d-4428-aa55-fdd904a5425e@ideasonboard.com>

On Fri, Oct 04, 2024 at 02:52:24PM +0300, Tomi Valkeinen wrote:
> Hi Dmitry,
> 
> On 27/09/2024 11:35, Dmitry Baryshkov wrote:
> > On Fri, 27 Sept 2024 at 08:41, Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> > > 
> > > On 27/09/2024 02:26, Dmitry Baryshkov wrote:
> > > > On Thu, Sep 26, 2024 at 02:52:35PM GMT, Tomi Valkeinen wrote:
> > > > > Hi,
> > > > > 
> > > > > On 21/09/2024 23:15, Dmitry Baryshkov wrote:
> > > > > > On Mon, Sep 16, 2024 at 02:51:57PM GMT, Tomi Valkeinen wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > We have an issue where two devices have dependencies to each other,
> > > > > > > according to drivers/base/core.c's fw_devlinks, and this prevents them from
> > > > > > > probing. I've been adding debugging to the core.c, but so far I don't quite
> > > > > > > grasp the issue, so I thought to ask. Maybe someone can instantly say that
> > > > > > > this just won't work...
> > > > > > 
> > > > > > Well, just 2c from my side. I consider that fw_devlink adds devlinks for
> > > > > > of-graph nodes to be a bug. It doesn't know about the actual direction
> > > > > > of dependencies between corresponding devices or about the actual
> > > > > > relationship between drivers. It results in a loop which is then broken
> > > > > > in some way. Sometimes this works. Sometimes it doesn't. Sometimes this
> > > > > > hides actual dependencies between devices. I tried reverting offending
> > > > > > parts of devlink, but this attempt failed.
> > > > > 
> > > > > I was also wondering about this. The of-graphs are always two-way links, so
> > > > > the system must always mark them as a cycle. But perhaps there are other
> > > > > benefits in the devlinks than dependency handling?
> > > > > 
> > > > > > > If I understand the fw_devlink code correctly, in a normal case the links
> > > > > > > formed with media graphs are marked as a cycle (FWLINK_FLAG_CYCLE), and then
> > > > > > > ignored as far as probing goes.
> > > > > > > 
> > > > > > > What we see here is that when using a single-link OLDI panel, the panel
> > > > > > > driver's probe never gets called, as it depends on the OLDI, and the link
> > > > > > > between the panel and the OLDI is not a cycle.
> > > > > > 
> > > > > > I think in your case you should be able to fix the issue by using the
> > > > > > FWNODE_FLAG_NOT_DEVICE, which is intented to be used in such cases. You
> > > > > 
> > > > > How would I go using FWNODE_FLAG_NOT_DEVICE? Won't this only make a
> > > > > difference if the flag is there at early stage when the linux devices are
> > > > > being created? I think it's too late if I set the flag when the dss driver
> > > > > is being probed.
> > > > 
> > > > I think you have the NOT_DEVICE case as the DSS device corresponds to
> > > > the parent of your OLDI nodes. There is no device which corresponds to
> > > > the oldi@0 / oldi@1 device nodes (which contain corresponding port
> > > > nodes).
> > > 
> > > Do you mean that I should already see FWNODE_FLAG_NOT_DEVICE set in the
> > > fwnode?
> > 
> > No, I think you should set it for you DSS links. If I understand
> > correctly, this should prevent fwdevlink from waiting on the OLDI to
> > materialize as a device.
> > Note: my understanding is based on a quick roaming through the code
> > some time ago.
> 
> Ok. Well, I did experiment with that, but I didn't figure out how to use it.
> Afaics, even if I set FWNODE_FLAG_NOT_DEVICE to the oldi nodes (just as an
> experiment I also set it to all the nodes from dss to oldi) in the DSS
> driver's probe, it doesn't help: the panel driver still doesn't probe.
> 
> I also wonder whether it would work reliably even if it did work. First the
> panel driver is prevented from probing as the oldi dependency is not
> present. Then the DSS driver probes, sets the above flag, but then it fails
> to probe as the panel is missing. At this point something should trigger the
> probing of the panel driver again, and I wonder if there's anything to
> trigger it.

My thought was that the flag should be set before panel / DSS drivers
being probed.

-- 
With best wishes
Dmitry

