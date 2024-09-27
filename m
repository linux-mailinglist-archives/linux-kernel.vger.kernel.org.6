Return-Path: <linux-kernel+bounces-341185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F7D987C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5124A1F243A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A77AD2C;
	Fri, 27 Sep 2024 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3pz/ZwS2"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DAA136A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727397261; cv=none; b=WVIrPqLgryME+nbypSd1jm0+nter1OOkuyN7QWq5SDlyl0t0k1bkGJhMRVIpCoA9blkO9WeUbaZ+oHZCRLBHUXsPv1gW2D9yHkA47IlF1WT8RURnPPccTC7+ZEwEqIWFsvwOTxLaM05Cv6M6xQZSQALeKcmfkVwEddUCm3O8O/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727397261; c=relaxed/simple;
	bh=p+Y4dRmN73V4XXbhuXhuTz6H7JBOIuTlX2LKJsBXVWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIh5SGMF01EAcHKfpVtoW0Ci2+cwzH186UHI//uRtdj/RCflYpRunrs1Fso53mPSMQhULDbb1OS6OyxNvy1Upqg7Fm4tfn3FsABn4PrwY2JtNlP/2qY+O5VSe14oToc3giM9ENbvvZpGOBUHF2O/JE9MpwcdQit13KHhD+Q7xmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3pz/ZwS2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e09d9f2021so892521a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727397259; x=1728002059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAa75KbDqhJjx81DIDS15qaRvhgsnet+lGj3+ZM2t0A=;
        b=3pz/ZwS2bSrGapi7pgBHdQWZLoA0gyzCyV6T3Nk5Ygasbs9FQJ9zo9rAFDnkvh/63T
         2QphW1mII0nS+GoqfoBrdnGhd+raaDVwlNRKNYFr0LfeLod9RWonyu+mirt2rj/o2GKi
         hCZv9lhmmzMpZed493/8l2hFFFYgWeN6pF9UhH2/iN4+1U3ioJSOWdbewnsa7eEFwEnH
         dAXHALLeytjL9SGBdce1Ul0YNUVp6oqATiXRI9XMT0nniPgupCu5pmlHVG0jwdkfNeu0
         w2okzs2qV02FSkrvHUJFGtEEFFHQbqw8Qx0aEhg1+j/IC/ema7ZZD0i9KJvMNgGgSdjy
         vLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727397259; x=1728002059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAa75KbDqhJjx81DIDS15qaRvhgsnet+lGj3+ZM2t0A=;
        b=hQMnOcjeZIsCy1RaqIVO5qgTFn73au5RRMfhXIYwiEw9FCk+tIz8STJJgcxp7QxEYo
         l/wQV8r8pkWlp3fzbDmWQ2hy+RqhqW94uiJwFsUKMGl5uuT07NeHMy+nN4oIMTunkfAl
         X8GrC/SYMyzttP0ZRCC4Lyr+GTzCorEF42Qb7SBtuC3f1k4NqyIlw3REOiRRgfjGyf03
         jXcG1VF8iy+lUlumDxovTuOoWxo2iIFLMP144LO2U4hn4AQtR8/emVuQ4+GKcI3VkhIj
         TAUpFzwWYtacAtwjO6QhkiBRzwzN3vsm1xJ41oRRqxygGD/GkBeNZkLWI/8PNYssXymX
         F++w==
X-Forwarded-Encrypted: i=1; AJvYcCVZUR/ZjaM/OOBgEaAmOT2XJ54xPyL3058hN61pHfQkRd+3xm0clfNIWXXN+pmABp8NXjheNo0cMREAayY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgbnV9pub7dLXdFAv4vFuYXQPObQ4zJJkv3SQZolAyzEMbuiP6
	otI1T23wJV6qOWaAIp6zdLqiOLTGnBjJUejjDtlUIJPPeTbJk8vhpw+nPPKv8+cVd8HY3E9kq1P
	52a9aCJmdJOVxGBZnukXXNCzn5Ho6Gis+WE0q
X-Google-Smtp-Source: AGHT+IHQj7kaciFRp3wcKf/ExRdN+4TN7oaZukCduLsvkGSAeeeVgdNIhWzjO78CznXKmFNH7ByssFgcRN2I9grS0fA=
X-Received: by 2002:a17:90a:6784:b0:2d3:da82:28e0 with SMTP id
 98e67ed59e1d1-2e0b89e22f5mr1687315a91.9.1727397258838; Thu, 26 Sep 2024
 17:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-6-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-6-cmllamas@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Thu, 26 Sep 2024 17:34:04 -0700
Message-ID: <CAHRSSEzvTX6OMb_2kVZbKJhFPy8m8q3OPOQsxuOPGupsJUduWw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] binder: fix BINDER_WORK_CLEAR_FREEZE_NOTIFICATION
 debug logs
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:36=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
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

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 2be9f3559ed7..73dc6cbc1681 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6411,6 +6411,9 @@ static void print_binder_work_ilocked(struct seq_fi=
le *m,
>         case BINDER_WORK_FROZEN_BINDER:
>                 seq_printf(m, "%shas frozen binder\n", prefix);
>                 break;
> +       case BINDER_WORK_CLEAR_FREEZE_NOTIFICATION:
> +               seq_printf(m, "%shas cleared freeze notification\n", pref=
ix);
> +               break;
>         default:
>                 seq_printf(m, "%sunknown work: type %d\n", prefix, w->typ=
e);
>                 break;
> --
> 2.46.1.824.gd892dcdcdd-goog
>

