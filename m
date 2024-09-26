Return-Path: <linux-kernel+bounces-341145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B54987BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74621F22A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4CC1B0136;
	Thu, 26 Sep 2024 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdrVq3NB"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091AF1B0125
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393167; cv=none; b=mJ/S4uxdTxUhiFYmTJ9LwIeh/npPr95M7XQCLtsJdie80/3hb0hUWdHm5+vtLCS4RmQfhLB9PYf2z68euc7XhHDsRK9pEtU2PjGfy7/wL5DgUtBlI0KgbupSS7dRCi8E/XIvzdkLDtQGULSH7Wq+nQvLp4HveJKfb9e8urMy3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393167; c=relaxed/simple;
	bh=WMLdA7MoVguTTo2CBeCYQVxalO4O/SouSyCUljx7PEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ed4u6CmbSRlnnONrddS9BLGDRGTPQqQofNLiTGjMjPg2e9jReyI+jYVbnGb5LVHBeyUVu0z4muYRpl6gRL1e7wiMH8k60jxML5+N+SyMp8DpgPX+5v8JQvnCshWDbQQmGwHtsg9XppU3eVqY6g5PZaqqWoGCVseP3CgVOK+5Kac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LdrVq3NB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so2053085e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727393164; x=1727997964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t5pseCPO6jN8nR6Udzs4lC47qwj/lhZ7DuKsdijaTSc=;
        b=LdrVq3NBRpgy4O2PaVLxnwjNFImI8Wpp7tLohURz8XLC/eZlTKl47WsteiW9LEh7L5
         2YTaiXIvY9o/W7baiAmxkGf3mUKKuDSjAf0NbjEfuGUBy+Mxp8S2NBzicIAztJiRuDav
         S2bDN2e7KmmKzQZOPPLfExcftEvJd9Esv0tvayV5EQturw4hKAzIhx2JOXDlq0CNJz23
         VYUaHi+7XQ1hu0/eT47M/GV4KD1FYQV3m3M3ciRziPZVEcjTT/GTOe/vN5SFVP8Cz524
         OYNjycxKurz8ItAWkSjFPjC09z8KjndeafxX68r/tJbju9iSd/vHw544ROsWYDMdpFzD
         2SUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393164; x=1727997964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5pseCPO6jN8nR6Udzs4lC47qwj/lhZ7DuKsdijaTSc=;
        b=oH1KwBH57Sb+mVRYzD5xtq0oWbrR2Yxcl1tjbT8Wvr6+at/QFbk6alNS/lKFygQhCe
         2gsucDiQG/mVI1UgPI4WjSU/Z3Mh0Xh0zrOKF82gMS9u/wW9gicV25n7kmUVanbfZkCy
         sCOpXWilqkRgmFMxrKeJbfMx+xudXEVU0i76Ok8bRQIwM0UjiGhv3xDjX3fbrUqg2Sw/
         b8+bgjMoaXnViL8Egs2FSypIm/acW8kYsGEYCFobexM/VmlsxUkgg5q/3t68PpTol6tP
         QlNyThtMU6mVDf2FYCWfnsbEAQ7qRLAKY2pbAuS74EDxmJuESQR797FZYE/CZ518tmNd
         Tcwg==
X-Forwarded-Encrypted: i=1; AJvYcCXd1+y2CXXK1Vj/qv2BU7b2X+u7zkn3p7MypqLdgDqVbyyBKud6TYrFlCi4X71o9FiQnCffVtLzLM0kfxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx085bTkDAI5w+agdGG0U0daIaHbhkQfWF3tWWukT1W139AHZoX
	i+H8sqnuOYdA3Hq8p7K9nY1QpXNGpXSeyckpGCOib108rMPfwmitPbyH+LKrPZc=
X-Google-Smtp-Source: AGHT+IFAmKWsef3dkLsjCXYV9pQHrb5CqKf+GuRXpmYITGvw+mF5uEPHe1Fq1aNMJshg42Udh6y/6A==
X-Received: by 2002:a05:6512:3b9b:b0:530:aea3:4659 with SMTP id 2adb3069b0e04-5389fc330ecmr749547e87.9.1727393164048;
        Thu, 26 Sep 2024 16:26:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a04399f4sm101721e87.190.2024.09.26.16.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 16:26:03 -0700 (PDT)
Date: Fri, 27 Sep 2024 02:26:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: Re: fw_devlinks preventing a panel driver from probing
Message-ID: <il3s26owmtyf3knniv7klkmw3uuz4dffrump7jo47dk6hxdsya@v5plmtjcbukf>
References: <1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com>
 <34mewzvfyjsvyud3lzy6swxs7sr64xkgrbkxtvyw3czvoerct7@7guo32ehwa52>
 <5a540bdb-e3ca-494a-b68d-8f81f4d1cc1a@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a540bdb-e3ca-494a-b68d-8f81f4d1cc1a@ideasonboard.com>

On Thu, Sep 26, 2024 at 02:52:35PM GMT, Tomi Valkeinen wrote:
> Hi,
> 
> On 21/09/2024 23:15, Dmitry Baryshkov wrote:
> > On Mon, Sep 16, 2024 at 02:51:57PM GMT, Tomi Valkeinen wrote:
> > > Hi,
> > > 
> > > We have an issue where two devices have dependencies to each other,
> > > according to drivers/base/core.c's fw_devlinks, and this prevents them from
> > > probing. I've been adding debugging to the core.c, but so far I don't quite
> > > grasp the issue, so I thought to ask. Maybe someone can instantly say that
> > > this just won't work...
> > 
> > Well, just 2c from my side. I consider that fw_devlink adds devlinks for
> > of-graph nodes to be a bug. It doesn't know about the actual direction
> > of dependencies between corresponding devices or about the actual
> > relationship between drivers. It results in a loop which is then broken
> > in some way. Sometimes this works. Sometimes it doesn't. Sometimes this
> > hides actual dependencies between devices. I tried reverting offending
> > parts of devlink, but this attempt failed.
> 
> I was also wondering about this. The of-graphs are always two-way links, so
> the system must always mark them as a cycle. But perhaps there are other
> benefits in the devlinks than dependency handling?
> 
> > > If I understand the fw_devlink code correctly, in a normal case the links
> > > formed with media graphs are marked as a cycle (FWLINK_FLAG_CYCLE), and then
> > > ignored as far as probing goes.
> > > 
> > > What we see here is that when using a single-link OLDI panel, the panel
> > > driver's probe never gets called, as it depends on the OLDI, and the link
> > > between the panel and the OLDI is not a cycle.
> > 
> > I think in your case you should be able to fix the issue by using the
> > FWNODE_FLAG_NOT_DEVICE, which is intented to be used in such cases. You
> 
> How would I go using FWNODE_FLAG_NOT_DEVICE? Won't this only make a
> difference if the flag is there at early stage when the linux devices are
> being created? I think it's too late if I set the flag when the dss driver
> is being probed.

I think you have the NOT_DEVICE case as the DSS device corresponds to
the parent of your OLDI nodes. There is no device which corresponds to
the oldi@0 / oldi@1 device nodes (which contain corresponding port
nodes).

> 
> > have a dependency on DT node which doesn't have backing device.
> 
> Well, there is a backing device, the DSS. But if you mean that the system at
> the moment cannot figure out that there is a backing device, then true.

-- 
With best wishes
Dmitry

