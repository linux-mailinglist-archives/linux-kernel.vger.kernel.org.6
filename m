Return-Path: <linux-kernel+bounces-326352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9749976709
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819F9285C36
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C119F43E;
	Thu, 12 Sep 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VoKHfiif"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB919DFAC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138457; cv=none; b=ad3uS9823PalTmjS1GcbxFmTOA6wNYORRvxYnCYFjpHOO7vaENGsdpUHj1t6wRwSLIX5gNChhLG5mnJtKEHSh671LKQJpR6FRZ0VG9aB3W/KbcPyy9gQvYeevVk6u8CZIAq8Qg2hG+sAbwiDU+90jQ46cs6EtX82cvMIZmgsBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138457; c=relaxed/simple;
	bh=d0DzkbzKG76vXT0ymBXG4aOJbKILpuqsNeFGPFN/3rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO1pCwUW8VeLL5OZncjgWNJDKrqYQNMz0ocEicdQlNpxFpyO7O+mEeHIUfYiAxDt6NnLrzwUc/ZGaCNeODqFBwkv5HlvIYXruUXjVOJVrt27nhiGajGdhV5mJQJP0aqVjSsKZk3DDSZMc2Qm1mqbiJo+dH2SRiFo6c8FHZfLLhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VoKHfiif; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365c512b00so1009281e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726138454; x=1726743254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0DzkbzKG76vXT0ymBXG4aOJbKILpuqsNeFGPFN/3rM=;
        b=VoKHfiiffpGWaqPcytFJ2YGUgeG+wiZck0BCmNCxG+iWsJjh1bMkYOm4bvl4edsMFu
         GUlfl3RS4lRh7hs3wDjCooK9S05yHlY+8telkOyh/BSyIWVEx3nzYMrn0xmkP8AWfc5V
         B3yl2OQjqtAwzUWaDbnt4BX3hq6i/7VDdFehuxW1XOUMviAv8FYkB9rki96vquy9n1Lt
         M+vokpm6GKvW9Gv7z7PuTV+DEQlpdvUgawzk9krDSYaGJ8pVqgDeqGAwCZr5VBVm2d9f
         H8j+wrTVlurtdKu6Hvq8vhqh9/7QM7g+8QmyIYvMDT6hY4OxnK8k0/+gTEiUyc+zn9Nx
         Nvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726138454; x=1726743254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0DzkbzKG76vXT0ymBXG4aOJbKILpuqsNeFGPFN/3rM=;
        b=IMH+tN5M4KM9sTtf6RbsXSJOEsstmzvsWxVTNyATy1aQRyFbpG1f3bDgoBi50NxRar
         7EBfZqQjX6RmHhiu93mWzql9CjQFUAzWTDZQiUl4OQJdbPAKy+naus8BE8GMzQrEKf69
         w3Y8qdWJ40WsWbcrCi7jlBOWHNFgXWEo51jcSyzC7qO4/0X2wpp77o7CCQNyjSLE4G6C
         YveLTLwT+jttlQ9HYkuWicinvCP1mfD7pbkedOGmzP12Spe2grGPH7bAeE7dVWAnSTSW
         igveSclQAu/flUkLHULujU67GHEY5B5pxqBnrr5BZsOkBzRe5dGTxUKuPmWwmDeslmUR
         5olg==
X-Forwarded-Encrypted: i=1; AJvYcCXUQIQLlyRck+8X98e7gUAqr7SmZIQI7LxKaKa53A/xS2TB4pH4rq429WHcaWZJJVXX3aslVzpogiABeUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVksvz5bkH83/64TSld4+j5M20WoGbCj4sFLYnOtUyGdRk91R+
	XERuAB6UwGFsDwLFJFskJpbRi8Z1gROlC7UevCpd5q1RXnpQhKpdaPL8hShExJkYumdQRZ9IrQn
	4gNygmOOh+V1UjGweRnkrmEHPKiDGRJjqO9Ub
X-Google-Smtp-Source: AGHT+IGq6zXokPIMzhfJKZtNReSDwJ67+QqTvap67eYcwKY04gpU79NBiS1SHGCYFm5kv5weOdjx69Fb0lBE8fQ0/L4=
X-Received: by 2002:a05:6512:b9b:b0:536:52c4:e45c with SMTP id
 2adb3069b0e04-53678fcd1c1mr1486136e87.31.1726138453287; Thu, 12 Sep 2024
 03:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071702.221128-1-en-wei.wu@canonical.com> <20240912113518.5941b0cf@gmx.net>
In-Reply-To: <20240912113518.5941b0cf@gmx.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Sep 2024 12:53:59 +0200
Message-ID: <CANn89iK31kn7QRcFydsH79Pm_FNUkJXdft=x81jvKD90Z5Y0xg@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: Peter Seiderer <ps.report@gmx.net>
Cc: En-Wei Wu <en-wei.wu@canonical.com>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:35=E2=80=AFAM Peter Seiderer <ps.report@gmx.net>=
 wrote:
>

> Same change (and request for more debugging) already suggested in 2023, s=
ee [1]...
>
> Regards,
> Peter
>
> [1] https://lore.kernel.org/netdev/d1cf5a66-03e1-44b8-929d-ac123b1bbd7b@s=
ylv.io/T/

Indeed !
Nice to see some consistency among us :)

