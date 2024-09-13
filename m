Return-Path: <linux-kernel+bounces-328497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B308D9784F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2DF1C2144F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A42D39FD0;
	Fri, 13 Sep 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WHugccHc"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A439FCF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241757; cv=none; b=CRhVjhkngMzo+a6gl9XiMEs86Q8LDy6O0KGQFGOUjxXRRHnCt0LXEpw4fDbab5UAC0C1WfKFYNYlfNSr3ij+u3JQrVm34wOs9hfxYxy8c5V99MaQyG7WYpSDjkWiGNX11c+ICRzhsrIriisxmXiFn/rvDcyelU9HQYgi3nlziAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241757; c=relaxed/simple;
	bh=JVb8KMCM6jHWePJ+WwVGJto+gZZqwG8xSOjy87G2/0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYRkgRGN9R4JlTu0hRz4tXriGJGsMzXCKEdBp9q8Tp3hmq3cpHIGvWO3S1ZF/cEb6eUE1Ym1So2JTbdsJgQVJxGeI/GmyLIOXYIGgNhz/SWtnRlcHq9a/5NqXC0A/7AOnnTO1JMzHeeXQdZDe+zpGhPo3k4K3v7Ocb8eVqJLgm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WHugccHc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365b71a6bdso1365678e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726241754; x=1726846554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0JwKHRK3rl76CWQbkuUTWFIQpTK2A2oPr0BJFkbSag=;
        b=WHugccHc98Vp3frffJstD5/mOGg3TvLh4yx+6AmbAcDzYUaySi8qBLkfwIsbmWSa67
         3FHzeuhZFiXZTbxEXp/NYadjeqBmoYty5kEN2+ARkTMXVtjSE4u1BAENuULmgJXodRIY
         PBtM0vxFVKxXmkewgu0iLAkg0i3MqrdXksY0msVddLhcm3oWmOGRcj5BaMwKWCkkPu0a
         GYTohFea1yP3CnMqnWM8hydAkC0S3+WjtGcN9G/wXcV1prh+nhBvDl8mqFJc4HVRX+Cr
         2PjLZiwIhdjHcBWwNWRWqlgCNR4tWKaX5d09iwVGXlI0W+T4KrtJx+t8mQh4tE/v3L0x
         XEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241754; x=1726846554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0JwKHRK3rl76CWQbkuUTWFIQpTK2A2oPr0BJFkbSag=;
        b=ldLYwCJCmBzizdAt7opGc+kgX4iYijIvt/IU0GBp0Jmxneowi1ff+3vsu647wAPE21
         /jGCVuYRmdFy5pIX85WI39gYTKqVqopKZxBLh7VFJMPpSUVVSrU49UKTr1E2t9LGL5K+
         Oq9NxXRJv9Y2iAdcZDhWNTjs2XoQFW4DiA8Q4eOZYMeOjEap5NUQ6pp7+hxfM2pSxYiR
         D/x2UpdwE/exxr7mgp19axRz+qJQDRG8jUF6GzsYhIrAVd26gNvxSmbNKLcoQ86bNGOe
         xMaoAuq69PEO2Hqlu+bCHfQezzLUsNMS+zG2FmW0+bBN1aNllFmALR2JzX4FcRYvU6qN
         N0GA==
X-Forwarded-Encrypted: i=1; AJvYcCVXJhgv7noXBP4snD4yPgN3dNd1+zHpM7CcOAVXN/lxDisLrTiDDyv0PCmI9oU1sSppr1rGntuPcnvKOmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrjmyIAUHWJAwBz8xXhSUE4ste1kOJzk7KsjslUgaJGryjGrB
	JXfvilSq2DYpjG7QOPSm3M+IllvVHfOP9ES6piIk0VJxUXZIRmvvmiEhlU2dz2Q=
X-Google-Smtp-Source: AGHT+IGbQHDlO6Jy/xYSGiEtD0fGy9IlDo0xDLy8oCci62lxHIoe3G+0a1csHKqWGa38NhoeVuaDHw==
X-Received: by 2002:a05:6512:1092:b0:52c:9468:c991 with SMTP id 2adb3069b0e04-5367fec5715mr1865133e87.14.1726241753647;
        Fri, 13 Sep 2024 08:35:53 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c6117asm881339766b.98.2024.09.13.08.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:35:53 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:35:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: Raul E Rangel <rrangel@chromium.org>
Cc: linux-serial@vger.kernel.org, rafael.j.wysocki@intel.com,
	ribalda@chromium.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] earlycon: Print a notice when uartclk is unknown
Message-ID: <ZuRb130167L8bW40@pathway.suse.cz>
References: <20240912173901.3969597-1-rrangel@chromium.org>
 <20240912113616.2.Id2235082fc6c2d238789dfc3ee923492e9ed7387@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912113616.2.Id2235082fc6c2d238789dfc3ee923492e9ed7387@changeid>

On Thu 2024-09-12 11:36:20, Raul E Rangel wrote:
> When trying to construct an earlycon=uart parameter it's hard to debug
> why it's not working.  In my specific case it was because the default
> uartclk earlycon assumes doesn't match my hardware. This change adds a
> notice so that the user is made aware of that this assumption is being
> made. This should hopefully lead to them adding a <uartclk> option to
> their earlycon parameter.
> 
> Booting with `console=uart,mmio32,0xfedc9000,115200n8`:
> [    0.000000] earlycon: uart: Unknown uartclk, assuming 1843200hz
> [    0.000000] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '115200n8')
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

