Return-Path: <linux-kernel+bounces-192440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABF88D1D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0833D1C21C68
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CAC16F274;
	Tue, 28 May 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZJ2FMzRB"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B01F17C7F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903726; cv=none; b=j37A9nViaM7G7EWow+M0bS0RsWO0t1xW04nhfoKPYGeoSZ5pe0Ck7KSsszXudj0SrIlyIbUNcBbRn9rzI0oYJ2DazLCd1x72Vz0nk9zm1E3RFXxC6uzc7FZz5RTgouYVBqDZ4b8+YIj44VlE5G6OOwYDU9xm14P88k1UOhDHP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903726; c=relaxed/simple;
	bh=2NVRsI4C+Ib4XcAtq3SQ4Gn5LfuW1MpXprWBf4HbLc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YI5osqg8alCmOZy5QmN7ZbpKhNnx6SogAryXFKObSwGgao9J9qSNMIloplA5fuHGm9utqZuJ0CpxdxrSAT/fHWcz5Qny2JrAFjTIeK9DmlMPIsQIyvkY4ZKJkcldTzH12l8Xi9PxBoTVFf5hdqEtWWwsOWRrwP9CUy60Eih5uvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZJ2FMzRB; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-48a398971c4so267163137.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716903724; x=1717508524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJl/Niw9y8xeoAZXxTzkK3BRrY+A+J2TquBBGpBsalE=;
        b=ZJ2FMzRBnF5vTS4TwAk04YF6aKs3d7u28SfYRMlmmG2t5o0oO0B77pOwSdy0oayUzl
         ce2SLbKRqraYVuf4m69o/PkHhn2OJzkugnRjwXI0rYe3CowtE57VyLMeJlJrTThopm38
         p2hwrXzrylueY2+xtLdneEW5CH/vFVMgvATnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716903724; x=1717508524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJl/Niw9y8xeoAZXxTzkK3BRrY+A+J2TquBBGpBsalE=;
        b=e8GIGva5UzZT/kho/eGHphEmeDHl1VfQtuY1QVZDvSf07Q3rMYSUyrT5J1XU7rWYD5
         TeoEnUWtLpBq7+DsDZRFoVCIld/EhRtcd+CYCdDWixyeJgnmshceMS13OKhEyfvM80hT
         kozbcJYwfoRya0C5d3mPnqAVOJ6DLPUGl0jUxYT7+3BXEq2WjGAEmxFVGuvXqH4fYLaV
         s87GfnEZS1f64DiCSDdQp6FGVL62SFHtDZj1zYRlSZOf1XiJHU2H8UcbxcwQp5e+YumP
         kF2DjeT6kBlHH2tDxEFd1GV+yo19s49IYtMRUmQxtn8eEJTouHMVasOPnT2K+/fEbWTe
         J2kw==
X-Forwarded-Encrypted: i=1; AJvYcCVS1igqVTlDsoIu04tWufGXhc3+7BXMJ5odOl07ESRPYnSRqETfoBdrOqh0Odn2sZ8Jhftr/BDJYTcGzwADWwYY9v/18Rakp1aBU5q3
X-Gm-Message-State: AOJu0YwHdJa2j+3lSghIcHqV1scXxvPRVDVttCXqnwc1JZ0WxxXvEp5F
	/kZhwlV2GS+jdKjWFZCfRe2xSqhTNcqy6lQs/t8ZiUo74OSIqVqIVtJDzBJpgR8jWn2refyWlME
	=
X-Google-Smtp-Source: AGHT+IHmMuxR1NkeCdOeY/fKrEmAUbq5AWj4xWDUjLBRhz+ibafrZNyjft8fCTgjiP14OzVLTvra5A==
X-Received: by 2002:a05:6102:3b81:b0:47b:9fd6:233b with SMTP id ada2fe7eead31-48a386ff8b3mr10191560137.31.1716903723566;
        Tue, 28 May 2024 06:42:03 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd48978sm379380685a.132.2024.05.28.06.42.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 06:42:02 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43f87dd6866so881831cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:42:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUyIGbqLYoUZ6MQC4nxCincLMX+AQeHYArdp7Qb4S7d93Ko0SBcNWGpanAW2sgo8j0rXZcGOfpFId7IdwaXpNAnFDjTVrbbDpkFxeN
X-Received: by 2002:a05:622a:59ce:b0:43b:6b6:8cad with SMTP id
 d75a77b69052e-43fb9f403f9mr7315341cf.10.1716903722340; Tue, 28 May 2024
 06:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528121154.3662553-1-arnd@kernel.org>
In-Reply-To: <20240528121154.3662553-1-arnd@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 28 May 2024 06:41:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=BW3qjhn=Lp=vb6d1wHaUF6M98DUssEz-zZkL2TU=mw@mail.gmail.com>
Message-ID: <CAD=FV=U=BW3qjhn=Lp=vb6d1wHaUF6M98DUssEz-zZkL2TU=mw@mail.gmail.com>
Subject: Re: [PATCH] kdb: address -Wformat-security warnings
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Justin Stitt <justinstitt@google.com>, John Ogness <john.ogness@linutronix.de>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 28, 2024 at 5:12=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When -Wformat-security is not disabled, using a string pointer
> as a format causes a warning:
>
> kernel/debug/kdb/kdb_io.c: In function 'kdb_read':
> kernel/debug/kdb/kdb_io.c:365:36: error: format not a string literal and =
no format arguments [-Werror=3Dformat-security]
>   365 |                         kdb_printf(kdb_prompt_str);
>       |                                    ^~~~~~~~~~~~~~
> kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
> kernel/debug/kdb/kdb_io.c:456:20: error: format not a string literal and =
no format arguments [-Werror=3Dformat-security]
>   456 |         kdb_printf(kdb_prompt_str);
>       |                    ^~~~~~~~~~~~~~
>
> Use an explcit "%s" format instead.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/debug/kdb/kdb_io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
Reviewed-by: Douglas Anderson <dianders@chromium.org>

..probably also justifies a:

Cc: stable@vger.kernel.org


-Doug

