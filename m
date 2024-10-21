Return-Path: <linux-kernel+bounces-374981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CD9A72C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0138F1C21799
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE8E1FBC8A;
	Mon, 21 Oct 2024 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WU1lhfCc"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6833C1FB3C3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537083; cv=none; b=XdyIogymqvKSBLHRCDO8gQ1jrBMWcIaZoFKe3LUeFdwxslFi653+1o7y/ltWAteefwGm9RqUDInPQrdzHryhvXhAxoCYY+kewWL6h5oVw+3bZaFT88AUeHExS9KdzPA7o+GszkxHMBTYhhNq3D2cRof6SkO5k64nxoUIbbtDA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537083; c=relaxed/simple;
	bh=PysUGtBPrSuesGgmYr6bDEcVlC+Z3tHnHKdsXTKbTwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2RpDp3V1o0dnzlPSD2UklCqXmRQvoRI4hv8X6ocgjK1vPWEL/86l1WHgxcMRW1wCKd23vzq0cQTQfK9pYLbglJFjwWuNmamRBb2xhyP1oBRQMiQgr8a7K+PGz80hsmU+VxqJm/180K8yhTyQSbUZwwJE5VgVs53gD3KAYPpFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WU1lhfCc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f58c68c5so7151669e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729537077; x=1730141877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LTRV3bBQxzuWsx6RapAOc7MDWRhOKcayDBqasSrcjC0=;
        b=WU1lhfCcx0yTB/9RalReAgahlyNJaq9NehdPHhE2+6AJJiQnWMuNC8xS1Ci2BxViEo
         mgnTpD57o8E8b4cDB5A+9p35EWG3zBADwq/uv1rH/WPPeze9oXoQBqEE4G5FdAn00m5I
         /WrDYqhjYjKqhQzHb8/OCVaViDnNUgpMdyDqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537077; x=1730141877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTRV3bBQxzuWsx6RapAOc7MDWRhOKcayDBqasSrcjC0=;
        b=bVKObw4FFCzTiAQgSUjwmhM9c+xVY9DDQKyoCTLblZ9dKSXnP8ak6m0S+B7arNJYJ2
         7iRtDhHgg1Kpig4inG7QZDsQ43w7jGRCg3ADE5VfCAFjeH4V3eGKiUTGcaEEHnNjb+Ek
         UE1WZa5V5oqDuU7PTnU/1dA8AT2AEtq45yOdLVxRGdsO7QV2U3V2TbZCciYzUuzvzMIw
         eeL9i7pOLz4XqsGxicM6sKLlqQb3/sBUOp8sKRKHJaytIpuMsAOCwfJl+ylj2h7l0ken
         IlJl+lC1qCoxZuIGK4Nd7H1YvGke++q+m9zEQQqfn8bNxZfBApLkJbuvWOrD8UBsgjzB
         nmWg==
X-Forwarded-Encrypted: i=1; AJvYcCWlG58pLYKRBO3BzePpyDMa0zPdniayLSmlj+PzFrMjq9MDi3HbkPeDjny4NDj6s6bT66+luidS+0TKv5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzACiZqZj/UScz3K0Zbf0X75SR0j1nhMxWYZKEiY+Ho2HZJ8juS
	jQIF1+VcqXBEzDAhPg1aHYx39gYlqvixpNoUw8Hn7sbyIFwYwOP59KS9vgQDJ/rSFrlPzWC/31t
	e5PhJiw==
X-Google-Smtp-Source: AGHT+IFC2S5D7VYt8eaZKHhQ5vKYXXIWltmHVwMPkF1rHR8GvUz//QADw5a5Z/3dbDhCkZaVdPa6bQ==
X-Received: by 2002:a05:6512:1292:b0:536:741a:6bc5 with SMTP id 2adb3069b0e04-53a1534083fmr11447314e87.12.1729537077185;
        Mon, 21 Oct 2024 11:57:57 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2242040bsm550235e87.176.2024.10.21.11.57.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 11:57:56 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f2b95775so5660500e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:57:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHNgXDSa2UE9WF2UmxmITvVfcnZjq1haBJ1Q+Mbv7HcvYOV0XnpjTq0k2ojG3SgQinN6/bEttcWiiIGbA=@vger.kernel.org
X-Received: by 2002:a05:6512:3b20:b0:539:901c:e2e with SMTP id
 2adb3069b0e04-53a154eb6famr10642034e87.58.1729537074916; Mon, 21 Oct 2024
 11:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807094725.2193423-1-pedro.falcato@gmail.com>
 <20241018172804.GA2151929@nvidia.com> <CAKbZUD0Z_Kyumx3ourywUYhfksGNgJWrCpjAdnxtsbwS4vMRkA@mail.gmail.com>
 <1cb07628-269c-4d6c-9936-f3a2b233165f@leemhuis.info> <b6852c2d-3371-47a4-bfeb-049f4048e88a@suse.cz>
 <ZxL3FsmjGrTT_EV9@codewreck.org> <d937fd92-249e-4660-a59a-ee85b6ec4691@suse.cz>
 <ZxafcO8KWMlXaeWE@telecaster.dhcp.thefacebook.com>
In-Reply-To: <ZxafcO8KWMlXaeWE@telecaster.dhcp.thefacebook.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Oct 2024 11:57:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpxeTifM1LFPQFR5_RjD2uvDAHbZ-ATCqox+RuFwkbDQ@mail.gmail.com>
Message-ID: <CAHk-=wjpxeTifM1LFPQFR5_RjD2uvDAHbZ-ATCqox+RuFwkbDQ@mail.gmail.com>
Subject: Re: [PATCH] 9p: Avoid creating multiple slab caches with the same name
To: Omar Sandoval <osandov@osandov.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Pedro Falcato <pedro.falcato@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 11:37, Omar Sandoval <osandov@osandov.com> wrote:
>
> FYI, drgn's CI started getting EIO errors from
> getdents("/sys/kernel/slab") that I bisected to this patch. The problem
> is that dev_name can be an arbitrary string. In my case, it is
> "/dev/root". This trips verify_dirent_name(), which fails if a filename
> contains a slash.

Bah. Does something silly like this fix it:

  --- a/net/9p/client.c
  +++ b/net/9p/client.c
  @@ -977,6 +977,7 @@ static int p9_client_version(struct p9_client *c)
   struct p9_client *p9_client_create(const char *dev_name, char *options)
   {
        int err;
  +     static atomic_t seqno = ATOMIC_INIT(0);
        struct p9_client *clnt;
        char *client_id;
        char *cache_name;
  @@ -1036,7 +1037,8 @@ struct p9_client *p9_client_create(const char
*dev_name, char *options)
        if (err)
                goto close_trans;

  -     cache_name = kasprintf(GFP_KERNEL, "9p-fcall-cache-%s", dev_name);
  +     cache_name = kasprintf(GFP_KERNEL,
  +             "9p-fcall-cache-%d", atomic_inc_return(&seqno));
        if (!cache_name) {
                err = -ENOMEM;
                goto close_trans;

(whitespace-damaged, but you get the idea)

                  Linus

