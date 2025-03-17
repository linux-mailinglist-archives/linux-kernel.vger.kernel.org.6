Return-Path: <linux-kernel+bounces-564486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8883CA65619
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3FE176EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFFF2475C2;
	Mon, 17 Mar 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D9CivxON"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6E236426
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226151; cv=none; b=V2icodFU9IK095Q3ic7J/SkerpdaLnPo2EycNbM04h1qSfMmwr51MVGCwpdie4OreWdRJbKtR9pRq+W22Cn3KYfSOWw1X9SBIP9y5kHNDHyRZpg0NXAmqls1yIumZeXJc4x0QreAWitVP2zVDR8IPheiUHeXmlUjKrkREzQ5k8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226151; c=relaxed/simple;
	bh=95C0iFKPFCJdqxunet5Y22/0vzP095YVnCIPv+/g1Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCGWUzrn+kmCqnH0TN85XNzvr2xX2zE9/JvPwgtxJ4T0vgFA2CaRRKnODmN1AOcO3GnZ6+ghSfi7oXAVVtreg2mUeU7ep5CKvxodT2Su95isEsFuCCtnsNhjiBYNQVMPFGaA94ZLCCmJqHiSyOCqaNFUJFfeKgElm9LAHRIEvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D9CivxON; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so2974751f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742226148; x=1742830948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Sl6TiBLO8N25M9MJl5F5cWXO3GkD985i4DUNgdnIpM=;
        b=D9CivxONF6M+3Nw3yUJKy0MVXwRHhUPDywMHgNFXXumfc10MGj+IUlaQg6vD8lAv+2
         PZBhyeBUQr7oGXHSCA1r1sX8lPHP8cU5tx/w+90RK3vvw/4Vp5nw3yDwmo9z7INSF+4X
         4w1OAUsoO3XWF6L7NL2DMU2NxDxj1EtVmMjwhdrGMF7pAS7Fj+GQ/9NbTlHuSL1shojp
         Zvh72QUj+mzs7BM+0FFFGuN6w9zA1nCu2N8/X0IxfkpmTpr//y71FHgIiN+D8Nz8+gqO
         O1yxojFfqyhyfcgidRBvYo5LMoNEle2L/8BcH+8S5SwqqUaGFyN5e2tQpFok+Kh10tTS
         vY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226148; x=1742830948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Sl6TiBLO8N25M9MJl5F5cWXO3GkD985i4DUNgdnIpM=;
        b=mizeqByN1DeLtGEttpS9LZv64eJ0vUBtCAwEx+p2tdKP/fwfRg5BVsZALIYK59TkG0
         5VrTM0rz+oCM+zI4W6VnMEsAqod3PpB9T2+4mYG36kbRbLzU29qhrDyuEd/ieDmD+/cb
         9exAZgTF5gryte1MfBCr1unZqhH0wPjgjgzlEhn5rUOUsCKYaLkKPU1p1oQ3/yuk45RA
         inE6DxN/LFW3JNBAlMr1cb66c161aRII9C3gYr0jS4akApAwpv5ORNs41nwsBUwgZWJJ
         r96SccaNCRbtG/J26ctx8ynsqj8ny9qxnf5IHvVro5c4XIzV98nuOwYqsrvgsUHuRN0Q
         j5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkvDJ5WakV8c4R5G+jAprIO2u35KXM02kw+KOPwqD/qFkgjBzTjLSWuYmw5N7/EjA20DIMs7jiMzyHgWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcslFEL9tiw4+zP0KbQxhCHMEx30FlMzTiUKsdb6oMNeDwecut
	dYgpB2UiaKyIEUOVn0mLGtSnCoo/j9IIaVUjPSOD2Y/z5sTgvjFSaNMjkBhlGcz8mUm6uCprMmy
	P
X-Gm-Gg: ASbGncu//lFOQxHixJZZLG0pCl/g+RPdl3mQeyNwfS9N3FqqAORntwoVZG2jDvLT2ML
	Jh3DRateGCcyPffop2VsPyYTkXOvhaCznDFnQW4vyC81Ja/nKSgfRb+TRjmJCferW4KC+VThRNf
	SkFJ5vJf+gSJijiV2BPibol1eTokGk3u0RSXTDZtqB3TgGWBownJWRgT5SxMw80vWl/wxBc6St3
	2MRn4gaewn3C4r76x/vf/gzrF/fv6AkCAjRUr+1z0nSu5yCkynD8Sl6ZkclL0eLjB5Z9BqvVuV1
	5oE1vMPGDqgJm3fU/8Hi0jXhcdhoKrQqBeaqLKwJOx2fQ9W+Q1m+cr9s/g==
X-Google-Smtp-Source: AGHT+IGFI7QGKei4yncWB619h0fAg9aDp6rT7ZSJlbo42qbdkjEdJIdxaXEtj/PmkeZ0XXSLhW6X3A==
X-Received: by 2002:a05:6000:470a:b0:391:9b2:f48d with SMTP id ffacd0b85a97d-3971e686fdcmr15861208f8f.33.1742226147727;
        Mon, 17 Mar 2025 08:42:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975b90sm15623852f8f.53.2025.03.17.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:42:27 -0700 (PDT)
Date: Mon, 17 Mar 2025 16:42:25 +0100
From: Petr Mladek <pmladek@suse.com>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v12 1/1] printk: Add an option to allow ttynull to be a
 default console device
Message-ID: <Z9hC4Ri39FsyOF0T@pathway.suse.cz>
References: <20250314160749.3286153-1-adamsimonelli@gmail.com>
 <20250314160749.3286153-2-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314160749.3286153-2-adamsimonelli@gmail.com>

On Fri 2025-03-14 12:07:49, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> The new option is CONFIG_NULL_TTY_DEFAULT_CONSOLE.
> 
> if enabled, and CONFIG_VT is disabled, ttynull will become the default
> primary console device.
> 
> ttynull will be the only console device usually with this option enabled.
> Some architectures do call add_preferred_console() which may add another
> console though.
> 
> Motivation:
> 
> Many distributions ship with CONFIG_VT enabled. On tested desktop hardware
> if CONFIG_VT is disabled, the default console device falls back to
> /dev/ttyS0 instead of /dev/tty.
> 
> This could cause issues in user space, and hardware problems:
> 
> 1. The user space issues include the case where  /dev/ttyS0 is
> disconnected, and the TCGETS ioctl, which some user space libraries use
> as a probe to determine if a file is a tty, is called on /dev/console and
> fails. Programs that call isatty() on /dev/console and get an incorrect
> false value may skip expected logging to /dev/console.
> 
> 2. The hardware issues include the case if a user has a science instrument
> or other device connected to the /dev/ttyS0 port, and they were to upgrade
> to a kernel that is disabling the CONFIG_VT option, kernel logs will then be
> sent to the device connected to /dev/ttyS0 unless they edit their kernel
> command line manually.
> 
> The new CONFIG_NULL_TTY_DEFAULT_CONSOLE option will give users and
> distribution maintainers an option to avoid this. Disabling CONFIG_VT and
> enabling CONFIG_NULL_TTY_DEFAULT_CONSOLE will ensure the default kernel
> console behavior is not dependent on hardware configuration by default, and
> avoid unexpected new behavior on devices connected to the /dev/ttyS0 serial
> port.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>

JFYI, the patch have been comitted into printk/linux.git,
branch for-6.15.

Best Regards,
Petr

