Return-Path: <linux-kernel+bounces-433288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9959E560D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E726716BB3A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B17218EB2;
	Thu,  5 Dec 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaExnFKq"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA11218AD6;
	Thu,  5 Dec 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403474; cv=none; b=RQ/DBFCrG7iVYcONQFMnkdktDYgDz+dvcd2vgjuiVLDMihSrzZTdnbamsFPydxXMAAYv3+sH7KYBQdrQmWYf23wWrfl0Igu9dua3FnVBHSZpu+S8HjA/XJWnBLDc2dtpfXuNV5RAPYYXM7FtYf4UbO3vGbVRc75iivSXexwIasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403474; c=relaxed/simple;
	bh=f+QEjMwweGWb49Ggbwkzil84HB1C760r4oPZtgJQjZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIuiKfjgYmQeDgyJfjH0E6UycAPFJXuyvtsaB9kMwg5vOUSE+1bOfoWtjb9bI9JdW8+exYLISa5Q7kEtanP6HC2y2LkY4MkGnvyu/f34TykhJH9P5WHACOlB20Glajj2jX0TmWy5sNEtMXG9ptin2WcWNFnGYWVwuLXXuTLp8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaExnFKq; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-724e1742d0dso785151b3a.0;
        Thu, 05 Dec 2024 04:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733403473; x=1734008273; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aq3iziI69mktbCsrs1z3hU/Pmx1Y+cqw3p/KFX5yIX8=;
        b=gaExnFKqmx41JQ2vsR+PWbybk4EO/FJEUEhCQWRSogrPK62F8ei4r9WWsShfhEzrNC
         JSsRhZj3AH0QFS55dgoY458WqijLnE1FjAYU42x5JW5Z5o/dIwLzUg39RzCNZsP8bCg7
         NHHuNGNyo0nFXpQ/qbGgiWgFJ8zYZJ5W9v9pJ4kjCtFFJzTzifkq6sWiZH5OEgBrvMAN
         0bhX07EGnM5fTWAmM4cFHbuBaW0cCvWapK/r1gKPE+AvoLgv2+JH2+FXlkiKIYpttD7M
         U005CxuQRLrqMzFidoBnaGOE0gARGEbuY9nGQAR/a2fjriWl09eYjIAmKMSqdQ7kOnNo
         tL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733403473; x=1734008273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aq3iziI69mktbCsrs1z3hU/Pmx1Y+cqw3p/KFX5yIX8=;
        b=Nmi3fZla4qpKb5QqvM78GNm+rvAr4nB20CXPWkftwySfSq7Oztp9oblGkXCUGWmNVL
         p0uiTiI85V5PrH23lTnrdiTlotu6rro25LGGfx8Asj5XNrRhT8j6hgEfTf12xt7oDMv+
         v0BWEpFmvfErfYq7QVo/vzymalMdbC7uh1ltTe7TsqIbiLbBrPTQboFWndICnq3l12MT
         DFp5K6cc+ce7UZzvgg+vAwqJ8+90hal6UvIU9jB99zYkc5m62RxckSiJm2uHmifzngqy
         6Zn9byiap4YyupIL4oZCNAU5XrAYZ3aWjTwv9LJ/9iFrca/061izw4xZkn4kkhRXZTSb
         t1Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUdeFx5E7oT+MiJWrw4Yd1keFSXQ39rNAj+hYLDTeqBN+DLUey5PHIhgSv6eRI/1UMVEkwQrs3KEcuUzjQ=@vger.kernel.org, AJvYcCVqiG783vGFZWShvPVjemhg+3aKl85uRKav2I7xf2jB3mx/IMYepaOYLM+BLXLBKMpUXNUICB6jF369pvsCsdTJJDPWCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fYCB+0S9mYqHgy+f2z+2JE1hszY41OO24vMDJyaPv2PxPBnq
	gS83RFrbTKpsWwA+9yc27AlnYN9AsK3FFFjTCoz97m5m0DkLjq1+
X-Gm-Gg: ASbGncvOdEx0mdokLUWtk+ttPfSEcn/jT5BkyVNIBaPZeI/T63n+B+WaOyvVNWEWgMk
	64OYgVT9GamC+ykb9h9RwtFVKggva37L6H2JPAeXkNSzgdYfvzT7hDW0Fy1clfg3fceQRPgMlBX
	hhQoEtTmNwLHBOYh2nHiL2pvIRQyh+hR3nLr+6XqT+Iui5P7hE81NjpywXKSwQWxfcGMUVgpQZK
	oy/MIBdoUX5Hpb7lr4c2vxhKzuqTa1AI+s3UzMpu2QJLZmx3dL7rxMrJHnvMB8cWOrmykZbzXw6
	4JrglaVK
X-Google-Smtp-Source: AGHT+IGBMI/1XFytpCT83hNDKxJvPXVWv9gw3oX70liuFLqY2Zi5tkqhmBixwKK42uqCLlJjF1lYZQ==
X-Received: by 2002:a05:6a00:cd3:b0:725:a78c:6c31 with SMTP id d2e1a72fcca58-725a78c6d15mr2604680b3a.3.1733403472646;
        Thu, 05 Dec 2024 04:57:52 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2cc6eadsm1201242b3a.188.2024.12.05.04.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:57:52 -0800 (PST)
Date: Thu, 5 Dec 2024 09:57:48 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dell.Client.Kernel@dell.com, Hans de Goede <hdegoede@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, mario.limonciello@amd.com, platform-driver-x86@vger.kernel.org, 
	w_armin@gmx.de
Subject: Re: [RFC PATCH 19/21] platform-x86: Rename alienare-wmi
Message-ID: <qkffthwqi5lumtx4mnhqff3cpxcfem5kbo3m2geajbpjxg6yj3@po7v5x7ixrhw>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
 <20241205004709.2186969-2-kuurtb@gmail.com>
 <41ea44ee-fa2d-5e06-1080-5bb61fee1352@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41ea44ee-fa2d-5e06-1080-5bb61fee1352@linux.intel.com>

On Thu, Dec 05, 2024 at 01:16:59PM +0200, Ilpo Järvinen wrote:
> On Wed, 4 Dec 2024, Kurt Borja wrote:
> 
> > In order to eventually split the module:
> > 
> > Rename alienware-wmi.c -> alienware-wmi-base.c
> > 
> > And modify MAINTAINERS accordingly.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  MAINTAINERS                                                    | 3 ++-
> >  drivers/platform/x86/dell/Makefile                             | 1 +
> >  .../x86/dell/{alienware-wmi.c => alienware-wmi-base.c}         | 0
> >  3 files changed, 3 insertions(+), 1 deletion(-)
> >  rename drivers/platform/x86/dell/{alienware-wmi.c => alienware-wmi-base.c} (100%)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3809931b9240..a4d02074dd91 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -787,7 +787,8 @@ ALIENWARE WMI DRIVER
> >  L:	Dell.Client.Kernel@dell.com
> >  S:	Maintained
> >  F:	Documentation/wmi/devices/alienware-wmi.rst
> > -F:	drivers/platform/x86/dell/alienware-wmi.c
> > +F:	drivers/platform/x86/dell/alienware-wmi-*
> > +F:	drivers/platform/x86/dell/alienware-wmi.*
> 
> Why not F: drivers/platform/x86/dell/alienware-wmi*

Of course, my bad!

> 
> ?
> 
> >  ALLEGRO DVT VIDEO IP CORE DRIVER
> >  M:	Michael Tretter <m.tretter@pengutronix.de>
> > diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
> > index 79d60f1bf4c1..5e7496aeb070 100644
> > --- a/drivers/platform/x86/dell/Makefile
> > +++ b/drivers/platform/x86/dell/Makefile
> > @@ -5,6 +5,7 @@
> >  #
> >  
> >  obj-$(CONFIG_ALIENWARE_WMI)		+= alienware-wmi.o
> > +alienware-wmi-objs			:= alienware-wmi-base.o
> >  obj-$(CONFIG_DCDBAS)			+= dcdbas.o
> >  obj-$(CONFIG_DELL_LAPTOP)		+= dell-laptop.o
> >  obj-$(CONFIG_DELL_RBTN)			+= dell-rbtn.o
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi-base.c
> > similarity index 100%
> > rename from drivers/platform/x86/dell/alienware-wmi.c
> > rename to drivers/platform/x86/dell/alienware-wmi-base.c
> > 
> 
> -- 
>  i.
> 

