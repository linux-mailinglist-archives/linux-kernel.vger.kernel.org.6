Return-Path: <linux-kernel+bounces-341382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A13987F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB36E1C21F92
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6CD185B69;
	Fri, 27 Sep 2024 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5MeYwfA"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D117C205
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421644; cv=none; b=TjYqe4h16ysU0TELQcz+xUhC26msJJUrWo+QPYgvuk26hNuViqALmmoNPyw8RdFvO+FRa+1itAd/PEaeZg3XjebTNN4Kc+nBfs9HjDg6Rjh+u0Ps6qHgYuXyKUub80Lqy9xcwMMYdR5uvTrBhKr6eGa0HleLWwqsWdYyVv/cPo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421644; c=relaxed/simple;
	bh=qjitOK1YcSMSW6NZgtW9NMEyqllfS2BvU1QtZXtn/+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUuezOddbN+kkNaB8VoS3RBQjiuRD6c6gvu9mxwiD2JG+O/a8LkuoBsuHoM8kFYk+5Ysmq7e7L8Ow6eYbtNWLj3ATQKqovjKmS34ENfqMH9dmos7FkBxtP4iJGXlEuk8g6j7dgya7GQsjzKWlIRQG4KQCzUH97ubFqNliqhhrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5MeYwfA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so14436645e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727421641; x=1728026441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJwjg54ez6LY3LSCq+PwluXFVCb5wSM0uXPFYvorjEM=;
        b=w5MeYwfA4SKOSZARC85zCA4Ypcqg3zFx7fx0fovP77ObIsiiCTzYJ7b3XKBY7WwB4l
         iWf4Qi5jPsrFjg97W4D/79CMgSl/giJXJBRTtFdW7CoL2Q5THus62xNKq3HX+TI+c+yh
         0md6pACUFa3RiihiBRUrE5LysMc1DMdcyswJJKk9H9y28R8e5R/stl5NhkDAanioWy9C
         Wk2ydRvbr3CBkEahqo8m4WKPf0pVAUHWWl5chee3sPYUWEh8OPOHEBPtsNCLLycihLlJ
         6aBEET93J7HbhqzM2OYDt/K5bftscAlhpUwAll3mqyVdpnIqLCagyTFSOqZTEuFXfiV/
         8ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727421641; x=1728026441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJwjg54ez6LY3LSCq+PwluXFVCb5wSM0uXPFYvorjEM=;
        b=jtiEzbZm0bXk2FyhKo9GXSrQtl6QWM/kcfaRQeD29BfzTvd6ZzjfYX/gIg1/o5PydJ
         2b5v9knfK+0ixAXHAVm3o9hfW38R+2aOxRv4lHbdAgrDGs222UIU4L1LH6LLYl6z4oy0
         M5ybrq9qXpqw+ReJFO2ycfiDn0Tk2xcIV1bgM0f9dq5Oh+rHl7r7z+IwirauVAj9PI+p
         u8hMQDv/Sm7qjSrgpI/ol1YJgcHJQOBONwX2oJel5qdMTJPo0UePcNRaXMxkOuf5RRov
         azV5AWOc6D+u1vHbUY7yGX/xFFTh8kiKGjLeUiAY+sMut4DsN24K5METAqvpjrgULCgM
         DZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCVs00J1MOsE6aGBmOWv4HeREECQRzSSZn8XO4TYxjj6ufqlcIkLXFvJ+ABvqnRYxNwGNxm5g5GhdGug3/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76DjmFskZAZghsJRGItNSYjeKmUms2kZtsQc1MCRLzOhdksLf
	arAladK7AwhqHiER6zJz6otUIpMyTdntZzrJ3FgHIQ7yp7NnUlonIcqdVqXSyyeYUxcGH9eMD3k
	8W1Rt+zzPEqSBH2DsEL8Sx3GIKrymQ4FibiSY
X-Google-Smtp-Source: AGHT+IFzipfJaikoBI3u0lKydpv4uIgowVvGRMmPknfxC0GWHUwO1YMtKorNy6Qd6NIoiNxS3Rs/8IVP5gi21RdfBtU=
X-Received: by 2002:adf:dd8e:0:b0:374:c8d1:70be with SMTP id
 ffacd0b85a97d-37cd5b31966mr1223185f8f.38.1727421641522; Fri, 27 Sep 2024
 00:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-6-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-6-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 09:20:29 +0200
Message-ID: <CAH5fLgia2rRVfL7_sy25fLJ+63iYVsWX=wDvPsziYGcUNwjoXQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] binder: fix BINDER_WORK_CLEAR_FREEZE_NOTIFICATION
 debug logs
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:36=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> proc 699
> context binder-test
>   thread 699: l 00 need_return 0 tr 0
>   ref 25: desc 1 node 20 s 1 w 0 d 00000000c03e09a3
>   unknown work: type 11
>
> proc 640
> context binder-test
>   thread 640: l 00 need_return 0 tr 0
>   ref 8: desc 1 node 3 s 1 w 0 d 000000002bb493e1
>   has cleared freeze notification
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

