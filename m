Return-Path: <linux-kernel+bounces-279719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0294C0EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D25B1F23CF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5277E19005A;
	Thu,  8 Aug 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnVCfP3W"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8FB18F2CA;
	Thu,  8 Aug 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130490; cv=none; b=ZX8+f3LjonWWx0j2smkUehg12kvkpDQVU6b2G6xG/m5/fjSrtj2rV4DNUEDKWSvW3/qMwKPk2vPHJLi0391IBDEVbQizO62KhjTn0LLH1lCd30YYFUPxpJTPnqbVePChzCOJP50Fb/bHlGdHKl0nKqysZrkA8ZklHDxnzsawBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130490; c=relaxed/simple;
	bh=LLGMog3ghLftfvDRa/wahzoGWmeO97Nond6HOcgHgRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9NL51aaVXF4YOFR8ROn2vJpKhe7xANxen2/jBbnLRCKYUB+CsD3eYRKx2H2gfhdIziqxF8X20AdEPVBlBg3GJY46Kmg9q8FVRp6Gbq90TsKIp/FkrDOmeYJbQfK4PU9EQNds3F4Ue8eym8oVfb3F4KW9JJdMsHB70D3SHBiN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnVCfP3W; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81fbbd4775bso36285839f.3;
        Thu, 08 Aug 2024 08:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723130488; x=1723735288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0qrVoz2J1yx28Dbm2oNk/ENgURyNTgPZNBRNbJticAY=;
        b=KnVCfP3Wfea+1+HXozAqvzp+ZZW/HPQc0umDyTX4a/X8CteLoLPuycM0n7TilOePBK
         xJjRZDGArEPmhRrfB9peBdxDtoqrqwx/3T/vbyLyOwFPPgJvWC1MGquh5btIM0MBNXH4
         Fi0F7PGi3rrb10/4ENp4l6u2Akr0qP1DHWtQGaYWBbPlWHRFth6Ff7X5lG1S1Fz6wp22
         ozfTlBGwqHVAzqMYKHoEgBuCFEM2RbByer+0qnyyHtGgahljAZ9WD/gxeaR6Lbz+6Iak
         7rHf7MMtIJUBPWlkp2Zl2SzP06L/nqrOApOhWdgK/Bt0k7oOQcyuyTUfQFkolrfTTgPl
         KHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723130488; x=1723735288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qrVoz2J1yx28Dbm2oNk/ENgURyNTgPZNBRNbJticAY=;
        b=X4/4RUHZ0F0KkTq7kQLvyEhAvTkZUEtHo+4cRJex9PxItVhGrvKG+DN83b4GnCCTon
         UeL/Hkc5kuOrypdjTa022enZj2FotTF9csqC7fmO07cYqHjTuKZgEziwiTKZaq78e1Qf
         U/FbWhmWN5FDL/WR4dfM3mZDqTdknWjN/rIuVNFWH3ErcZwmJR9cm7hy0QwdiABULF0b
         +28BthVqRSLaomDrp0fcUaO6I2xCxoc1Q9NpTMyofnG7xsQeF7R7lgELs2yzQKCqgNIY
         RLth01U7OWXC0vm1VzNwkGZe6xzmmkZY9aAKrb5R9YH2EFGwXhGtOK/91cqpdpW0IXsE
         qEqg==
X-Forwarded-Encrypted: i=1; AJvYcCVEKvYZJt+GD9fF9PyJB43NzNYuu5Pn4skPjI0Xy03Ib9z1DnRhu/c80cNVOnQMfDTquOhYXvwFVqu9FcINWBG0w7o9iQUAu/Hh0UMZ/avzuOst+nAOt+lnw7X9LfK5uY3SRatjc+6e
X-Gm-Message-State: AOJu0YzGL2zsqx5+sE43e91OT1D1dYia+dX3FaDPm3lwGxwjtkh2+YAv
	9pUlnwHfWxqhNwbKbZZFMdJUxfZhiweTR/b7Uosu/p8p6HhnLs0iRKXUlLrJ
X-Google-Smtp-Source: AGHT+IEs8tUVdKoi2mlhhy5URJvruIz2li73IDosmzzBsr5cpVJfDlDP8mmFYdDbcMsYsd+UzYor9Q==
X-Received: by 2002:a05:6602:2ccb:b0:81f:9468:7c3c with SMTP id ca18e2360f4ac-82253855ad4mr253501139f.12.1723130488078;
        Thu, 08 Aug 2024 08:21:28 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([110.225.178.109])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b76346af44sm10032073a12.30.2024.08.08.08.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:21:27 -0700 (PDT)
Date: Thu, 8 Aug 2024 20:49:31 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: laurent.pinchart@ideasonboard.comdan, dan.carpenter@linaro.org,
	m.grzeschik@pengutronix.de
Cc: dan.scally@ideasonboard.com, gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Message-ID: <ZrTiA8vpsHyGWp72@embed-PC.myguest.virtualbox.org>
References: <20240802180247.519273-1-abhishektamboli9@gmail.com>
 <a779ee26-fe93-47ac-a25c-b842534e0317@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a779ee26-fe93-47ac-a25c-b842534e0317@suswa.mountain>

On Fri, Aug 02, 2024 at 01:40:48PM -0500, Dan Carpenter wrote:
> On Fri, Aug 02, 2024 at 11:32:47PM +0530, Abhishek Tamboli wrote:
> > Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
> > and uvc_v4l2_enum_format().
> > 
> > Fix the following smatch errors:
> > 
> > drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
> > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
> > error: 'fmtdesc' dereferencing possible ERR_PTR()
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> 
> When I reviewed these warnings in 2022, I assumed that the error
> checking was left out deliberately because it couldn't fail so I didn't
> report these warnings.
> 
> Almost all old Smatch warnings are false positives.  That doesn't mean
> Smatch is bad, it's just how it's going to be when you fix all the real
> bugs.  In this case, I just decided it was a false positive.  It's
> possible I was wrong.  Other times, I report the bug and the maintainers
> say that it's a false positive.
> 
> There are some old bugs which are real.  Sometimes I report a bug but
> the maintainer doesn't see the email because they go on vacation or
> something.  Or someone sends a patch but it doesn't get merged.  Another
> thing is that if a bug is over five years old and minor then I might not
> bother reporting it.  These days kernel developers are very good at
> fixing static checker bugs and these kinds of things are pretty rare.
> 
> I don't review old warnings in a systematic way.  If I fix a bug in a
> file, then I'll re-review all the old warnings.
> 
> If we decide to merge this code, it needs a Fixes tag.
> 
Hi,

I wanted to follow up on the patch I submitted to address a Smatch warning. 
While I understand that this warning might be a false positive, as mentioned in your 
reviews, I would greatly appreciate your guidance on whether this patch should be 
merged or if any further adjustments are needed. 

If we determine that the patch resolves a real issue, I am prepared to 
include the Fixes tag.

Regards,
Abhishek

