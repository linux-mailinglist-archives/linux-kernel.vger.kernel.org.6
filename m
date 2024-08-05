Return-Path: <linux-kernel+bounces-274933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253EC947E68
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A19281B76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556E1591ED;
	Mon,  5 Aug 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="og23Hsjg"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5FB5464B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872644; cv=none; b=rkPCnoWcYzFiwLGfq6TA7UNVgOjqVKSYp5nMAQA4MdywxtVp8D0hppuNFkMweSP0aCgLlWdlIhIXuPbTJ+uQ52dcxYtrJwbVb7lcXGyc8s0BPhcCsTAEJSt//phT0TzsaP1AL/LRw+hLKIh82iy5pGx0c0l5Fbx1wdvl+I+LyQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872644; c=relaxed/simple;
	bh=WJQF1e1lGe1DHP8xXL81uq1JAQ4RrIakU9ICRRYsaow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NU95I+Vq+6JmsnSbcvnSbN8i9e3cHKRcREyV/qauLPSQ8iSlzJUdICGCIaTg83/n7eJdJ3Huw9/4UXpqzpKE0DNZyJ3hQS7u/Tpp2YIuL095lshXnyBi6XPoVmPTiFOcJ9pEjXdcLEHH7ZkSOwIAEFX7S/Fr+DWOfnZtOl6hBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=og23Hsjg; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bb96ef0e96so23265006d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722872641; x=1723477441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chvXENSfxaRr9pj6GM068Pc8pK4QQqniclzsqJg41Ag=;
        b=og23HsjgcEU8+Gw4PGnAUjmUSuzeceuk/AtVeyQ9EfrchF99wN6bCXSI5BDbIdRYZ+
         p8xZazfZjOdPqkzPuHkcS+5BxZ4WSHttr3Rkw84/I1AMNTixDpbuu3ToGMWRyh5xYm3k
         LTD+fZOkLhuV0CA3UmIVXixRJEf6qW6irnPtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872641; x=1723477441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chvXENSfxaRr9pj6GM068Pc8pK4QQqniclzsqJg41Ag=;
        b=Tmn34r5dCBxcUgP9KGFH4mCjFC5UIeC5A0W7+UTJMsASbOeC997kYmz87HsxzZXlZh
         88rBCnbWi/WJE8LU/gq4L3QY1C+pxFgB4qGKjDjULNsggTnCWksiHPhXLxyKbtxw7AOv
         BYTZnuK5wTCs6v6761araB7XtPtXaJVTlbahNHo7Erf6iqhw41kHsp0pP6BAUU9iEjfN
         dz7k2eveAkvI/QIiJahYFcbRtNGwjPlm1annKsOCt2dxYdS8YkftsFQjna4tw4LkjMn4
         BytGs23W6Keg+gX355x244zNAlNoD1SSI7RbCZ/RnRdoVVSF4r/mwaPe0oixNYB57k+K
         H1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUh8+cYZ6imuORqRP1ZHxafLLZ4SczmucI2sO0qEue27cQ+Qq21fZe1mnb3D1IeLTW9ORob7i/hoSaKFCgbJ8CHN0guw0ubIvBinNN7
X-Gm-Message-State: AOJu0YxvyhhzVFBEIsPPIMzGunYMe3vfXnzyuWU/IX1ShjYVoZf9pRoy
	FBfnsukuLmxk55S+mms7oDPt+7TjRKNRe+QgcgduAQJ8xxMaurnVZNI7JJUeRUCU+djvwqm/zfw
	=
X-Google-Smtp-Source: AGHT+IEpW8fbfcwehdeSOFKleu0cdWUBpPnW/Z9bJzHXjTAua7XMY5m1HCELnDngXl1Fbk3JwwF12g==
X-Received: by 2002:a05:6214:5a07:b0:6b5:12c:b345 with SMTP id 6a1803df08f44-6bb98361eaamr136412976d6.16.1722872641554;
        Mon, 05 Aug 2024 08:44:01 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c79c84esm36667706d6.50.2024.08.05.08.44.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:44:00 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fee2bfd28so462891cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:44:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWC/nqwHHhkpgw55ZUDF8wfv+VPvq/7PAaLHjMQE6tJrbFdy6cyh1EhW57Wzt+MZWx15SDafMKxzsJaxnC3SS1TvsZ/1vsM8QXR8DAn
X-Received: by 2002:a05:622a:591:b0:44f:ea7a:2119 with SMTP id
 d75a77b69052e-4519ae21848mr5655501cf.18.1722872639887; Mon, 05 Aug 2024
 08:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805102046.307511-1-jirislaby@kernel.org> <20240805102046.307511-4-jirislaby@kernel.org>
In-Reply-To: <20240805102046.307511-4-jirislaby@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 08:43:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1a1a=kkJ9bWXWOmu0hz6HqRuK=Vo=bhvFfSzeAWSWyw@mail.gmail.com>
Message-ID: <CAD=FV=X1a1a=kkJ9bWXWOmu0hz6HqRuK=Vo=bhvFfSzeAWSWyw@mail.gmail.com>
Subject: Re: [PATCH 03/13] serial: don't use uninitialized value in uart_poll_init()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 3:21=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kernel.=
org> wrote:
>
> Coverity reports (as CID 1536978) that uart_poll_init() passes
> uninitialized pm_state to uart_change_pm(). It is in case the first 'if'
> takes the true branch (does "goto out;").
>
> Fix this and simplify the function by simple guard(mutex). The code
> needs no labels after this at all. And it is pretty clear that the code
> has not fiddled with pm_state at that point.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Fixes: 5e227ef2aa38 (serial: uart_poll_init() should power on the UART)
> Cc: stable@vger.kernel.org
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/serial_core.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Thanks for the fix! Looks good.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: I'm happy to defer to others, but personally I'd consider
breaking this into two changes: one that fixes the problem without
using guard() (which should be pretty simple) and one that switches to
guard(). The issue is that at the time the bug was introduced the
guard() syntax didn't exist and that means backporting will be a bit
of a pain.

Oh, though I guess maybe it doesn't matter since the bug was
introduced in 6.4 and that's not an LTS kernel so nobody cares? ...and
guard() is in 6.6, so maybe things are fine the way you have it.

