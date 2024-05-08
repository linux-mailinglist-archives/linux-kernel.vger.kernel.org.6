Return-Path: <linux-kernel+bounces-173638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32BC8C033B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DAD1F22844
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AEB12BEB6;
	Wed,  8 May 2024 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H0ZAeHvg"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55A127E34
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189684; cv=none; b=LGBLcH4j5Y6KmZprsYn5GIkg58b9vbmvTnvCNlQckOf6CGuZWViosgf+1iP7qG8SEW29XqKV0wsgxAW6IpeK/f8Y9ZIsXRmmmfomB9HY4PLnTLPMKk5FYUGetEaC526NNpgE3Qq+jEJiEjejbuPLf6dKHFRDTWVrjuEUKRKtp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189684; c=relaxed/simple;
	bh=HKvr42kCJ5T2vBl47UrgH9gPQIDs/Cx4DaxhFirh7Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2bFNuUsUY/ADoHzQDpSKswLO2k+IUxE5vtNANKI7lHLlzGX0LQ7a7XCuSwywekX5dlOJygolJUETJZXEtWL25VdYGiBOKCSgoxxpa5pVGVk+BjEaEyZB5zgWMonbDNwoRv+W+LxRERZA7wR5VodzrX38/YDHAL3o4LXJAjUGO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H0ZAeHvg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso31789b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715189682; x=1715794482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZlSdIb10yMdduLYmXyW631A2JIaNaeSFkZVL/IzXzM=;
        b=H0ZAeHvgm+nkTb/1J4vKErf34CkRMj+OfnSZ7Mu6aWZ/nALOmZJhB/qQ+iLV1KYUWn
         SgiZN4Pt5zczcJavaGcFIMgDHZQOGzEZ+aNDhUiEagj73+t7nygY75ruc4N+d1CbkAu+
         49udd0HxUgYJN39bYTLtHmlXFYzQVKGchRX0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189682; x=1715794482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZlSdIb10yMdduLYmXyW631A2JIaNaeSFkZVL/IzXzM=;
        b=vx3oJnZjvS7fWv5DijEK1dJGZoV6Th638zyM90UkR9XqxPazO4cAvGLvavsybJ3gb2
         QKRQKnYeFLM7BedGxVzNkzksTKDoLf7s8ui1jZpApjpEgBzW3xUjbh67cssG/xKihX6g
         3NubJTcUytV7gs1kX9O9aayiB5yl5kj0pZ9CMmywt5qEak7SwDjiSipM3lqbPgrdYqeh
         uOtuOkZE5fosWPdZHnPTswfrM2PBjbuxU5xtylJPlTPWzXls7NX5s74AeFkYbaCKptcS
         1FqK1y/gUTmQuJS+7sDKRe2QL+0OEH9yUhhZ7NtD80TVc22a73r9jE4xCjdWOo/RjXJ4
         F0oA==
X-Forwarded-Encrypted: i=1; AJvYcCXhLWcHLYHX3M9p4FkUB+M1Yjhe9IMZpXUsolSnYMu6P+KtaaF3vwKvmDg1uQlYtoYDzOuYqzsCLOjaycD8uq80oUndidAtZM7f34zh
X-Gm-Message-State: AOJu0YxMhj9SJKUcDx9cHEGN59K58TDdOUIMwpMAVwTV+1BUBCxlk9KY
	jShwiCOHQoIpN8MBiO8f7c7pks65PhP5Ju3HA9rDPTSf/+PMtM0SQaQ+3ma3xQ==
X-Google-Smtp-Source: AGHT+IGsPbeewYhYfLGgBNn4yC+he+DDIfnSNSANWyR5bFJKhyZXsgwA47/XfqmZijCPC22jnu5JHQ==
X-Received: by 2002:a05:6a00:610e:b0:6f3:ef3d:60f4 with SMTP id d2e1a72fcca58-6f49c2b10fdmr3369180b3a.33.1715189682342;
        Wed, 08 May 2024 10:34:42 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n5-20020a056a000d4500b006f448d3c700sm10388005pfv.142.2024.05.08.10.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:34:41 -0700 (PDT)
Date: Wed, 8 May 2024 10:34:41 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: sr: fix unintentional arithmetic wraparound
Message-ID: <202405081034.2BC4BCA4A8@keescook>
References: <20240508-b4-b4-sio-sr_select_speed-v2-1-00b68f724290@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508-b4-b4-sio-sr_select_speed-v2-1-00b68f724290@google.com>

On Wed, May 08, 2024 at 05:22:51PM +0000, Justin Stitt wrote:
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
> Firstly, let's change the type of "speed" to unsigned long as
> sr_select_speed()'s only caller passes in an unsigned long anyways.
> 
> $ git grep '\.select_speed'
> |	drivers/scsi/sr.c:      .select_speed           = sr_select_speed,
> ...
> |	static int cdrom_ioctl_select_speed(struct cdrom_device_info *cdi,
> |	                unsigned long arg)
> |	{
> |	        ...
> |	        return cdi->ops->select_speed(cdi, arg);
> |	}
> 
> Next, let's add an extra check to make sure we don't exceed 0xffff/177
> (350) since 0xffff is the max speed. This has two benefits: 1) we deal
> with integer overflow before it happens and 2) we properly respect the
> max speed of 0xffff. There are some "magic" numbers here but I did not
> want to change more than what was necessary.
> 
> Link: https://github.com/llvm/llvm-project/pull/82432 [1]
> Closes: https://github.com/KSPP/linux/issues/357
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, this looks good. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

