Return-Path: <linux-kernel+bounces-189280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571108CEDE2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 06:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E49281DBE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 04:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A603AD35;
	Sat, 25 May 2024 04:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEIyI9Th"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE32F3B;
	Sat, 25 May 2024 04:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716611721; cv=none; b=EWszvAJhIN8dX1Xl5BsyPFTR1RUZPdFxl6L1W8YFZ/LsZwhGacu/9AB/Cx44FDyyx6OjMPpsfZ6GCQtvr4OENUb6lIBNlHfFOzAKHZ5j2jE7uf3iE94aqmkhz9QWdUgc5DHwOtqX0JOH2Rde2cZy4h8DQ/nFTF2lrdnjAPK2Pis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716611721; c=relaxed/simple;
	bh=A1QDHnOHzNACr3BfijhiqwtFMxaQj6xtkzCa8TcMHp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6JBlKlpTjszMEA9cL34jh1qcwEjMjbUBqe2hzMm8zkEgujqAgtWC6ORSIQ2f8SdL4gqg5kLo3UxYtdmPrDo3jH4+8DTcDo75925a9iK4Xliq0PGcE+mN2NTu5kd/LGiPOpqfnKwIbKoiQQvCBxi/RHDG7FAie9P8dUwwuMwI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEIyI9Th; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-80325a42c43so958486241.1;
        Fri, 24 May 2024 21:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716611719; x=1717216519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWoy99LOaWUsln1ERoCJO5HjPgM8DNbI1vxUMTq+D6E=;
        b=lEIyI9ThKHfJl9zIPxu1hSO6Lh7saOedoTduSm/i93/k+QssHmI0V+fyNwX8d0ofBf
         etYuYMAVLF2MWO7GEWNB8y6GFzq5htm9RmXCGH+osw1N7vy0Xmdgzn6ZVj8o0s9+ZXCa
         6Vu/w1rNXxaV5EIQN35Dl4UOVIVEiobkzl14xiXb9CSCRAT73u9u2tWlakrYiUrVAdvU
         ip75LEVQvR0/bcsDlB6ZkjyyrlqTpj1yLaHZ2GWnmfFrGlO9Oqom4i50zDAa/jkmwe0n
         Sk9+zQG2GYkcqrHCI4lP7wzU4R8kTv7ZB0/K9Hv2BLqyVI4I43+58ac254WkTV2vJE5r
         0/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716611719; x=1717216519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWoy99LOaWUsln1ERoCJO5HjPgM8DNbI1vxUMTq+D6E=;
        b=Iv0GcCqUfNur4S7DLnCOuyQbGAoN+nqIEe7+Xx4DYW6hGfWDoC5BeItepEOVIMnAv1
         6ZraHdmF00Om83cO02wQ7Wv2hhim6EXfHagh8FihgZFjDtcuvzzXeL8Hgga+dVQR6Z62
         bW6Jr+bOc+u68UA3JUm9n8PXOSZR1KPyhwKGwXlDm9v8dOkyRVrLFlCOe4F5FExNnqK4
         jNyiu7kk1PPUIIkYMA1R4FSmBFtuCQNtDeYMW0FOLxW9P09wTWAggJPVz+eyMGMf+duZ
         tQPBo/R/RA8SSGfwjadqO4l6chJzMe9May299iga5sIpt0MjBUiQEi3jQg1cSC3oBIRz
         j6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWEaf87IDcDR42wj4wkJUl1nAN34VIH69oI0SXt1zMLyA5AuWT8Er/j1CgkJfW/4fARckkRumCfGq3QUMoKeWAVWnB2swjdeSNid2k6
X-Gm-Message-State: AOJu0YyVLpRWm8j1F1hsNDqbilVqRCvg/L2ZfwmnNI7xJkzVki0FWo86
	cPGMPnfbNpixHsY3O0yXUTJaROJhjfAZEyihUUzkmenp6uiCkWXd2LheDOZqUTEUQP3f2rx7JBW
	8jOM+WRld8HUG66q3HYDEVk4iV4U=
X-Google-Smtp-Source: AGHT+IGuUFdxP9A7rzCeUnqQpqZyw+z6HN2pYdaw9hUO79s6ZPIB9eH9tXu9iYSUVf4hPnQogmksFj14wtcmJgMmOs8=
X-Received: by 2002:a67:fe84:0:b0:47b:e9ce:42ac with SMTP id
 ada2fe7eead31-48a38514990mr4246136137.4.1716611719055; Fri, 24 May 2024
 21:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523092608.874986-1-shichaorai@gmail.com> <a0afa88b-f84c-4b45-a265-2e6bcbb84b35@rowland.harvard.edu>
 <bb581989-4ac5-4ffe-9f80-01b5f993146f@rowland.harvard.edu>
 <CACjpba5iJ5dC=rB_Ckaqe4BKesrAN2VmsDCPZJ=frufNgA96Uw@mail.gmail.com>
 <eb995078-1923-43d5-a20f-9d4a7edee719@rowland.harvard.edu>
 <CACjpba55sPDba9GfpMqe_GUgAtv=6MzWAnsgov-PdpFPEDxwGQ@mail.gmail.com> <e1e593b2-fc50-4303-a01f-b7f7bf467c4e@rowland.harvard.edu>
In-Reply-To: <e1e593b2-fc50-4303-a01f-b7f7bf467c4e@rowland.harvard.edu>
From: shichao lai <shichaorai@gmail.com>
Date: Sat, 25 May 2024 12:35:07 +0800
Message-ID: <CACjpba4d6i99_NcoShrfsZztzjzBQaL1nDC5WMTj2eBuMoaoZQ@mail.gmail.com>
Subject: Re: [PATCHv2] Check whether divisor is non-zero before division
To: Alan Stern <stern@rowland.harvard.edu>, gregkh@linuxfoundation.org, oneukum@suse.com
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>, 
	yue sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 10:24=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
> If alauda_init_media() returns an error, leave info->initialized
> unchanged.  alauda_check_media() will return an error also, so the bad
> division won't take place.
>
> Alan Stern

Thanks! You also remind me that the return value from
alauda_init_media() is never used!
By this way, the workflow now seems to work correctly.
It tries to initialize multiple times, and finally disconnects due to
no response.

Now if possible, I will post a [PATCH v4] for this bug soon.
I want to know whether it is possible to add some tags like
Suggested-by or Reviewed-by for Dear Alan Stern, gregkh
and oneukum as thanks for your discussions.

e.g.
=3D=3D=3D=3D kernel log
[   47.266129][ T4125] alauda_check_media: before init_media,
status[0]: 0000000000000036
[   47.266555][ T4125] alauda_check_media: enter init_media
[   47.467314][    T9] usb 1-1: USB disconnect, device number 2
root@syzkaller:~# [   47.485304][ T4125] alauda_get_media_status: data=3D54=
, rc=3D4
[   47.485640][ T4125] alauda_init_media: exit in 391
[   47.486104][   T41] sd 2:0:0:0: [sdb] Read Capacity(10) failed:
Result: hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[   47.486591][   T41] sd 2:0:0:0: [sdb] Sense not available.
[   47.486889][   T41] sd 2:0:0:0: [sdb] 0 512-byte logical blocks: (0 B/0 =
B)
[   47.487212][   T41] sd 2:0:0:0: [sdb] 0-byte physical blocks
[   47.487515][   T41] sd 2:0:0:0: [sdb] Write Protect is off
[   47.487813][   T41] sd 2:0:0:0: [sdb] Asking for cache data failed
[   47.488104][   T41] sd 2:0:0:0: [sdb] Assuming drive cache: write throug=
h
[   47.491396][   T41] sd 2:0:0:0: [sdb] Attached SCSI removable disk
[   48.105309][ T1198] not responding...

