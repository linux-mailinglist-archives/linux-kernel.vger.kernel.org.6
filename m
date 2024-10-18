Return-Path: <linux-kernel+bounces-370977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0FE9A3493
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5671F21FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713AD17C9B9;
	Fri, 18 Oct 2024 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrxudGqm"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570281547C3;
	Fri, 18 Oct 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230719; cv=none; b=bJiw0vYVKXwlzD0srJxqeTpXE04z0ESeme+j46sxNPMwsmk5skkmJZZAdTcBZt7xw8EQp62+fvFX6/8Wgv/9ITrVmK5Sh2mcAbX98sW/jVePVnSM1OUvn8NeG8Ujy/4ihz+fRL7KM2x4ab8+LYyRDHLugPuKWjJ05NcKIlpUaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230719; c=relaxed/simple;
	bh=HLSs1bTpxFixzrpn4wyzbHhVx+6XHPwafunFJTLvOXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iXZGLZhLXUg26PlF93ySGpqdcHxc1XGBO5sfMlVOxsXCBTcIV90FIOc6MJ1JOgbHWDxFJ+iTqTuQw6k4+sCIEsyFPSjMSiO/i5I74ffmGVz59D3xdbmylRyKJ+pzMdgxrqUiwZkCazAlGspLUG4lFKOcrVWOftqAycQxNztUDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrxudGqm; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a0474e70eso230030466b.0;
        Thu, 17 Oct 2024 22:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729230717; x=1729835517; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HLSs1bTpxFixzrpn4wyzbHhVx+6XHPwafunFJTLvOXk=;
        b=BrxudGqmNng/evVRWpJ3Hyx+FyaX7uN7gWxuDIoOwo5wMmYtqHaTb0Ilo627aavJAD
         636rZhSfqtKjP6sZN5eFPX51TkULJjodD/qxGm7RT5qBkvC9/eBx/piLdHETfycxnvRc
         SIXJWgewImVBWGQxPGwhrq11ehqcczxOAqODLf6Q4hsQCHso5PHF4dTrQ4e4ozFOWmvd
         DFQuSp9LCRM7mYU9Ewlabhy1bF2jw490vsRHc0u6x6B4foKzIOUK0J/vTd3zxQZ2N3he
         FFbtlkf3gvP8UaRjjWdsP1vtOmlbvdvWBhDMo1m30wO8arvUHwU4CNXdh2xhHRMHQRIw
         6wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230717; x=1729835517;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLSs1bTpxFixzrpn4wyzbHhVx+6XHPwafunFJTLvOXk=;
        b=Hxj0Z07OGZqLnFvlfyfQ8Tu2gFFIkW05DrPN5mYqAHX+Zw82JgbIs87ml4WGU9eIVa
         Msq8/K1oPJY5snrINgJ4xibKyPcs0S1I2H7XfJhtlNBZKXr0Pps1tpoeGHmnFgQZlzgC
         pAdU2RNHgsKwT2kfHM7R04QOIpKo0QYCfw445ZI7pf3lo4i6DFoSuU/VfgCxUJnI/j4J
         rwpXy4PmcGt8GBX2Rj5/YTaDeQozcHgMIlAUoLD8BARjWbhPl5BwtA8t57HOPpebMrzA
         KjxGtyLRwSrvnBtfrwi2LaXq+pvK5MRbE/aK2Ok1b7dngqlNq3bp3hSoTWuTVSLjwoQb
         bQZg==
X-Forwarded-Encrypted: i=1; AJvYcCUgZbJH0/al/BEBmL6Menm7QerJnOBAxnrcTU/N2SzHd8s3OwVnpjRRTtPKYqvo5mtRUY3o4C8Saa02@vger.kernel.org, AJvYcCXKWi6lROAJwempUCfFKbAKQKCDTT0qFU6yyky7FlxiRIqlkHvFPF/9KigSpwRt81rvvYd+7O2PaY4p1d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvfeZW3dHXEUgeVOWpGBfACti9WLablfwEv34mTWnOdPAugTDz
	d3LwmceGVxSU1VOKLdNSJeMOn07V9xZ1TDv56Jq8X6BubyfkG78l
X-Google-Smtp-Source: AGHT+IH3hf5zZVuEO38gil91KQgp2pYj54Qdfu/b+0Mi8QbUv2PSTpj3xQwtU01L+hEBm7Euxm67/g==
X-Received: by 2002:a17:907:9803:b0:a9a:19c8:740c with SMTP id a640c23a62f3a-a9a69cccb7amr90361366b.47.1729230716465;
        Thu, 17 Oct 2024 22:51:56 -0700 (PDT)
Received: from [192.168.216.101] (public-gprs10413.centertel.pl. [87.96.40.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68aeedabsm46808966b.89.2024.10.17.22.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:51:56 -0700 (PDT)
Message-ID: <50361c479af3067031320b19fe650a32bec6d1ba.camel@gmail.com>
Subject: Re: [PATCH] usb: musb: Fix hardware lockup on first Rx endpoint
 request
From: Hubert =?UTF-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bin Liu <b-liu@ti.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 18 Oct 2024 07:51:54 +0200
In-Reply-To: <2024101625-fetal-oboe-1b9a@gregkh>
References: <e905e5d9c3e76786f154a87d54690fe1a90d755a.camel@gmail.com>
	 <2024101625-fetal-oboe-1b9a@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 10:27 +0200, Greg Kroah-Hartman wrote:
> What commit id does this fix?

This does not fix any commit in particular. Bisecting reveals baebdf48c360
("net: dev: Makes sure netif_rx() can be invoked in any context."), but it
did not create the problem, it just exposed it by changing the behaviour of
netif_rx(). Callback could be called from usb_ep_queue() since the very
beginning of the MUSB driver introduced by 550a7375fe72 ("USB: Add MUSB and
TUSB support").

