Return-Path: <linux-kernel+bounces-188224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311228CDF63
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076F81C210D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BE72628D;
	Fri, 24 May 2024 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjTPaJIA"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04FE81F;
	Fri, 24 May 2024 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716516839; cv=none; b=iWssS+NAhBFb0o9rA2IhXDJcPk1zR5beM84lJbgGjo1p/lbSrodeVvjvuu0LUKt4nspmczHNrww7vy34JexvAq/A/RutnKdVllP20r7xbMYdaqghfZkLJFnyAUNLhbns8vYA2T25lHZsN17wd4KArr4w9hBpHsio3As4au0RIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716516839; c=relaxed/simple;
	bh=XkU1tXwZkmKmjxI73pUbqI9HHmRQiTPAwNA9fCGNSfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlNouQ43+s+8IVTAKw86UbT+CVYZxGf5BoE/Vag9rC1x2z5VBfSU5tUqwjZzLC4Cu9fo90wWNW1IHseSc4Sa5BTX+omhsKuLIaLVU/lYUS8RGbxYdEeAiUuuAvnzA5B8ErEN8xhah624y6KGYTitjDW+I6Jy5UJpDCOy4pFC784=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjTPaJIA; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4e4f0020ca3so169798e0c.2;
        Thu, 23 May 2024 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716516836; x=1717121636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jd7c8VnwZhh78ikfWZy1/DT0+s4OAj8DFKOiLZAPwYU=;
        b=IjTPaJIAIQbVlLZ51/+8Xl/I6fMducSw4D04ysHunsQ2pLLinV8hKcyu8XAiNAoYFp
         yrV1JUw6jbFt9JDyR1Qh7c+zjBeswjgBxddcjtIEoK0be5qqJ84fVzJllaeEIjQ55w7T
         tAa4W47wnbe3x3/betmrBcXSyoGYoeB+muzd0RMVw1ApquS/TaVWpcLFZ/ZWy+kLrwjj
         i61UUrS69F59Y/8D7xcglFMhxHINxwTUwvXso7EnmBG38ZHKyccJe/tMNo5X9oRKXGbR
         tp845mwt7H2B6eHHMgo0rG5FsVERRTFIDUBOtJUIs5B//w3+X5FemgUN3ufkEwpqZUdX
         0Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716516836; x=1717121636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jd7c8VnwZhh78ikfWZy1/DT0+s4OAj8DFKOiLZAPwYU=;
        b=MWJriONUqE0FpysDg1TA1VpKHMdLzuZ7qvgUAUipwGtB2NJHYV35UcCyWrIkV7C9+x
         j4QYwJuUi+i05MvNrMli3qVd/tJNK3EhtTAZjdrlR4WM2Y1IMv+Ox42VMeQogTacIoVc
         X0QsqcIoXC0L/xFt5ZTi+1upO6gjQVYM1ulQRxfU+ZsVYGqwjsIwOhMUDMhN65+s048f
         dtXjqMIYpGqv9Pnbajb8GC6hLLA1CmswUhGzIcrwuu63twaBlr12Hd6W8TwBa7MzwcMR
         z30RT1pdq9PqIIpnzQ/Lh2ixRR4MbniNcf4dnKWLjHbv+icD8GD2fWZZ+B622tiMBwo8
         +L/w==
X-Forwarded-Encrypted: i=1; AJvYcCXigCVoi98J2fdyewZs9XxoYwXJY4STCzoHd40Cey6lmLIzoVIolDjZwW8EpeNTvqphpvBQL7j0SFYf9nuHKHAhTuQcnvmnFDN7Sq99
X-Gm-Message-State: AOJu0Yx2ejhpHRDDY4j9ilKBZN/WlZZ9ytzldhaA3mCQOu3PbKugzrCw
	UfbQAjyCW4nykZDJMvBNFyqcN9BQ2JhvTO6TrXYFTmOabw7wyzBBre2X2wGpdTVc3uljWNoov7w
	1nWhVYLdqH9CwQCTEf+TRTbYcoeI=
X-Google-Smtp-Source: AGHT+IHFpj5geMyX0INc9Ahw21sQa9gGODkRNNIHXQL+S+iRTUDY8yTnp7ExL+T9yzkNPHm54POIst5qucVwoy2memo=
X-Received: by 2002:a05:6122:168e:b0:4df:261c:fc0c with SMTP id
 71dfb90a1353d-4e4f02e650cmr1092154e0c.13.1716516836500; Thu, 23 May 2024
 19:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523092608.874986-1-shichaorai@gmail.com> <a0afa88b-f84c-4b45-a265-2e6bcbb84b35@rowland.harvard.edu>
 <bb581989-4ac5-4ffe-9f80-01b5f993146f@rowland.harvard.edu>
 <CACjpba5iJ5dC=rB_Ckaqe4BKesrAN2VmsDCPZJ=frufNgA96Uw@mail.gmail.com> <eb995078-1923-43d5-a20f-9d4a7edee719@rowland.harvard.edu>
In-Reply-To: <eb995078-1923-43d5-a20f-9d4a7edee719@rowland.harvard.edu>
From: shichao lai <shichaorai@gmail.com>
Date: Fri, 24 May 2024 10:13:45 +0800
Message-ID: <CACjpba55sPDba9GfpMqe_GUgAtv=6MzWAnsgov-PdpFPEDxwGQ@mail.gmail.com>
Subject: Re: [PATCHv2] Check whether divisor is non-zero before division
To: Alan Stern <stern@rowland.harvard.edu>, gregkh@linuxfoundation.org, oneukum@suse.com
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>, 
	yue sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 12:30=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> Good work!  So the problem is that the driver believes the status[0] &
> 0x08 test.
>
> The way to fix this is to add an "initialized" flag to the alauda_info
> structure.  Then alauda_check_media() should call alauda_init_media() if
> the 0x08 bit is set in status[0] _or_ if info->initialized is 0.  And of
> course, alauda_check_media() should then set info->initialized to 1 if
> the alauda_init_media() call succeeds.
>
> Would you like to write and test a patch that does this?
>
> Alan Stern

I tried to do this. And the workflow can enter alauda_init_media(),
but there are still many conditions to satisfy in alauda_init_media().
Unfortunately alauda_init_media() stop and return here before
initializing uzonesize:

if (data[0] !=3D 0x14) {
    usb_stor_dbg(us, "Media not ready after ack\n");
    return USB_STOR_TRANSPORT_ERROR;
}

The data[0] is status[0] showed before, and it was 0x0036.
I am not familiar with the status code of alauda.
How can I deal with this condition?
Is it ok to pass this condition when info->initialized =3D=3D false, even
if the data[0] !=3D 0x14?

