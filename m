Return-Path: <linux-kernel+bounces-172559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830A8BF39F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98C71F22C72
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB04387;
	Wed,  8 May 2024 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UezWsYk8"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B36379CC
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127831; cv=none; b=P1KurHDLPfBr8uI+O33Ts5TPCeSiFLM+xG6fJdVCrDMoYjv9pfDVOcTdONRNNisCLzghtPXebUGXfEfhUL7dishhGSSkD6sTYPK88cMta+BBLDWWLKh9Z1pR4Cf/bRNHiPRytprRb/eE48k9TffxS4g5Y7H1chSPsslOPh/NeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127831; c=relaxed/simple;
	bh=1da0pLj5XHUXhL0lSN1ETeHymYQMRKeJgc8KotxtGlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkEcjs2jh+90l6sRUv8h+NU3DBW6/b2QAJuNqvgIIOtEtLadZr0FZ9d7nH8rbY2Lx1AlJUJNVTVQY7viFOk9mqgE5Kl759L21oYdWy/dkmu8S1MNjyQeqco4vLNVXkM25fnMmLWrI8102fjY4ZsygI0simca6jwxZ1mgLo55bck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UezWsYk8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ee7963db64so10306715ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 17:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715127829; x=1715732629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09NWd9Q6j/agwIZs1K4w41dSpMpn7Xn/XB8A6O9Z+yU=;
        b=UezWsYk88NTr0/agSOTLdpAAdm6/305PII96kYf5k1BwMyMGKDXbAgOOLl/uoYr4uf
         gSbfH1hsUrOnbimylY4521LuSh0w9BXxhzo+FYYBWCfouGdpz0IITOw9xkc8e4D0V4FR
         kNPmPceMg68hThOBjSRviSaLCtpRgQTf30swA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127829; x=1715732629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09NWd9Q6j/agwIZs1K4w41dSpMpn7Xn/XB8A6O9Z+yU=;
        b=N+TUXdcneHZkAtK4ujwwXiUvCGloai0vrLfqVPKHFxl1QzlctYLOM50/aI6EQH3jIL
         U7sGp4i8r0t5gEtZGXNTpGGA9+kATi9sIsvI5ndced4qN8tEDUBseB99qniofItOYWJw
         ReVJwf2GLyhm4VrU43kK1w0HxBlFmPU4+IWQBhDIBPRPOlX039/ql3eEkyN+BZSpRpic
         fppSVM88ouLY/I/yBc+EKsswiCmsfmns326k7OXzM3JCSRI4r2msMX+tH3IylYbW5JGH
         maVAmJOTdNZ0YrcrWr7ZFSys2JM36O6C8ViMUykWELC3uoDsfGuqpy+04sSPqy/WGibt
         Lm1w==
X-Forwarded-Encrypted: i=1; AJvYcCWAJEbLqvLUDwODpgB5Wea8QubBc7GIwVXh3OnpFvyU78a8GRwMxueqmEtbBMJc90tFYeoCTNlPBfCA7+Y+pOtKkO8AUmULJuSTgKc3
X-Gm-Message-State: AOJu0YyhmpUJOv9ClM7nV82KadW95mcCI7jf65DeztCQw+FyK1Hssy3I
	jxfHigssDfhNk97bcjKKDrEiqdcQPXYibrLnza42sUow8ZdOqVqFCxR98BTrhA==
X-Google-Smtp-Source: AGHT+IHuemiCrxMSHKVE5rfjo+Q/DiytZ800PCNfDHJmUYfSE9kSJVG4tzAseUtRbGaNhTJISUEAdw==
X-Received: by 2002:a17:903:4286:b0:1e4:6232:367a with SMTP id d9443c01a7336-1eeb01993b8mr12268225ad.22.1715127829507;
        Tue, 07 May 2024 17:23:49 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lg6-20020a170902fb8600b001eb7823164esm10550918plb.279.2024.05.07.17.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:23:49 -0700 (PDT)
Date: Tue, 7 May 2024 17:23:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: sr: fix unintentional arithmetic wraparound
Message-ID: <202405071715.BD7AA91C2@keescook>
References: <20240508-b4-b4-sio-sr_select_speed-v1-1-968906b908b7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508-b4-b4-sio-sr_select_speed-v1-1-968906b908b7@google.com>

On Wed, May 08, 2024 at 12:02:27AM +0000, Justin Stitt wrote:
> Running syzkaller with the newly reintroduced signed integer overflow
> sanitizer produces this report:
> 
> [   65.194362] ------------[ cut here ]------------
> [   65.197752] UBSAN: signed-integer-overflow in ../drivers/scsi/sr_ioctl.c:436:9
> [   65.203607] -2147483648 * 177 cannot be represented in type 'int'
> [   65.207911] CPU: 2 PID: 10416 Comm: syz-executor.1 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
> [   65.213585] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   65.219923] Call Trace:
> [   65.221556]  <TASK>
> [   65.223029]  dump_stack_lvl+0x93/0xd0
> [   65.225573]  handle_overflow+0x171/0x1b0
> [   65.228219]  sr_select_speed+0xeb/0xf0
> [   65.230786]  ? __pm_runtime_resume+0xe6/0x130
> [   65.233606]  sr_block_ioctl+0x15d/0x1d0
> ...
> 
> Historically, the signed integer overflow sanitizer did not work in the
> kernel due to its interaction with `-fwrapv` but this has since been
> changed [1] in the newest version of Clang. It was re-enabled in the
> kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
> sanitizer").
> 
> Let's add an extra check to make sure we don't exceed 0xffff/177 (350)
> since 0xffff is the max speed. This has two benefits: 1) we deal with
> integer overflow before it happens and 2) we properly respect the max
> speed of 0xffff. There are some "magic" numbers here but I did not want
> to change more than what was necessary.
> 
> Link: https://github.com/llvm/llvm-project/pull/82432 [1]
> Closes: https://github.com/KSPP/linux/issues/357
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Here's the syzkaller reproducer:
> r0 = openat$cdrom(0xffffffffffffff9c, &(0x7f0000000140), 0x800, 0x0)
> ioctl$CDROM_SELECT_SPEED(r0, 0x5322, 0x7ee9f7c1)
> 
> ... which was used against Kees' tree here (v6.8rc2):
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer
> 
> ... with this config:
> https://gist.github.com/JustinStitt/824976568b0f228ccbcbe49f3dee9bf4
> ---
>  drivers/scsi/sr_ioctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
> index 5b0b35e60e61..2d78bcf68eb3 100644
> --- a/drivers/scsi/sr_ioctl.c
> +++ b/drivers/scsi/sr_ioctl.c
> @@ -430,7 +430,8 @@ int sr_select_speed(struct cdrom_device_info *cdi, int speed)
>  	Scsi_CD *cd = cdi->handle;
>  	struct packet_command cgc;
>  
> -	if (speed == 0)
> +	/* avoid exceeding the max speed or overflowing integer bounds */
> +	if (speed == 0 || speed > 0xffff / 177)
>  		speed = 0xffff;	/* set to max */
>  	else
>  		speed *= 177;	/* Nx to kbyte/s */

I didn't see a "speed < 0" check, so I went to check the type on "speed"
and found it to be "int". So I'd expect such a check, but then I looked at
the interface: I think it's wrong that "speed" is an int at all. There's
only 1 caller, and 1 implementation of "select_speed":

$ git grep '\.select_speed'
drivers/scsi/sr.c:      .select_speed           = sr_select_speed,

static int cdrom_ioctl_select_speed(struct cdrom_device_info *cdi,
                unsigned long arg)
{
	...
        return cdi->ops->select_speed(cdi, arg);
}

And the arg there is unsigned long (?!).

So I think probably the prototype should be changed to unsigned long,
and then it can clamp the "speed" argument:

+	/* avoid exceeding the max speed or overflowing integer bounds */
+	speed = clamp(0, speed, 0xffff / 177);
 	if (speed == 0)
  		speed = 0xffff;	/* set to max */
  	else
  		speed *= 177;	/* Nx to kbyte/s */

Then the "negative" values go away are then correctly treated as
"too big" in the clamping.

-Kees

-- 
Kees Cook

