Return-Path: <linux-kernel+bounces-407741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2359C727C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB712817B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2864A2022E1;
	Wed, 13 Nov 2024 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BdOMMl+8"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239241F1301
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506801; cv=none; b=B2D1+d4M0FNV9J1ktrSNqxRnsbd382VgOH/KIeFhrX5qTjCm2dSGQP+5Z9EkXJt+AU2n6AZRmd/3tuSTQ1HNmo82fyZ1W9Oiy/lGvEEXmutyYkBrnFD46v1TOlZiEWaEGJ7fd6yOQJKDIKwmYD0MewgZDVEY/+eVhItERoWHFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506801; c=relaxed/simple;
	bh=0fKqLzIm9Uj3vOox3uGDqxyOpl89mjm6yXUiBVRqWGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VztTdDXTcE68jtteZRJM1U92lF9Ln9nefPniCA7sjbDq3AJLy5Vu1V0tKwRsoL7X2tW7fV9sUOi+/atwcqDL8ZCYhxYNqDPiZqmY0hSp/5MCU618dKihDEsDDn4LS5RoMuSrAyIXDKlLV6KJE/iZ/imCsk5/n+GnkLNdSsmOSRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BdOMMl+8; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4609beb631aso53664511cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731506799; x=1732111599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n04eXx3+VgfYdeuuioz28LYYOMFjDIC5FvbOZurOlmg=;
        b=BdOMMl+8DcJ0YT2jMBFUkp8jfRPnc5mlnBmrY4nKC50iTFr4Oc/ei5I+ANrE94Kfsv
         MVRNEgpW7KI9Ravs63VB3z/G0XLimMbqF+BJVSRO/03qMW91PsOhu2V/Uha5BOo+YHnF
         mliX4JwkHkdweCz3VIKRv6jACVuDRm4Yzjzoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731506799; x=1732111599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n04eXx3+VgfYdeuuioz28LYYOMFjDIC5FvbOZurOlmg=;
        b=TxVtFdMJZG9OZrBIoN7hLhqwLgNvC0rZdyTcCAkOnPXkA0dNvXbufnZDNuEoU1q1wq
         hYkNZW/KBqrW0hFURibjThnVq6GuWdfjwbcRZ2YTlB5I9y2bUyY+kmH1rBaXyCoAWB+k
         VHHQMSQ/vR4pc4zTzfiRUoDD2F7LkxYh3cI+7b3/z4SIRK3Pa4vwoqy7A5iLvyGRpV6p
         c4VHnFPTO1dlW5T2yXkSSnJCx9CW1iWmeMK6kl1KcH7QZahtoRgXetQCT0KN7nUJLQAc
         f+cGZTDevzcnP1XBsEoVs3Uj9zBH5yzD9rwcGwD2TEaEuYsc/xSqGx9WN11uB5wuAUrK
         6c1w==
X-Forwarded-Encrypted: i=1; AJvYcCVySYSOuaGN0CJ2tc/c5qzffdivTF4yPPaId9lqDKsDgbcdeO8ueP4vu3Yc4ox4kkcoK1pozkVC27LuwIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJewGmoMBVrlRl8m47Vfn7zELoEYHKfmHbJ7bPjdTmBqRMXIsE
	E+TNhEFyt8JuFTgVouM1GRvQ2BLBQr/m/fK//hRgCxbnFO5Pno9R/ijOWVlcbIz4BbRZGZ8VxnM
	oywyR3tYqpTt5s0Enr+Hu+ANM712zVheDtD2PcQ==
X-Google-Smtp-Source: AGHT+IE9sec09qw2zVttuq0nP6xfpMnoEoUsplj7ka4DCtOBnPV+eGR/dUV+Y7nCGe35sDuh+bK9ggo3ciB3werkemA=
X-Received: by 2002:a05:622a:1302:b0:460:ae0f:470c with SMTP id
 d75a77b69052e-46309428d0bmr261546011cf.47.1731506798976; Wed, 13 Nov 2024
 06:06:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-statmount-v1-1-d98090c4c8be@kernel.org>
In-Reply-To: <20241112-statmount-v1-1-d98090c4c8be@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Nov 2024 15:06:28 +0100
Message-ID: <CAJfpeguRoXumEm6bkXdj8dtp3apSonhoaK7QFPaWAX+q7QniuQ@mail.gmail.com>
Subject: Re: [PATCH] samples: add a mountinfo program to demonstrate statmount()/listmount()
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Ian Kent <raven@themaw.net>, 
	David Howells <dhowells@redhat.com>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 22:21, Jeff Layton <jlayton@kernel.org> wrote:

> +               /* Walk the returned mntids and print info about each */
> +               for (i = 0; i < count; ++i) {
> +                       int ret = dump_mountinfo(mntid[i], mnt_ns_id);
> +
> +                       if (ret != 0)
> +                               return ret;
> +               }
> +               /* Set up last_mnt_id to pick up where we left off */
> +               last_mnt_id = mntid[count - 1] + 1;

The +1 is wrong, see do_listmount(), which already increments the last ID:

        first = mnt_find_id_at(ns, last_mnt_id + 1);

I also have some ideas for "cooked" interfaces that are easier to use.
See here:

    https://lore.kernel.org/all/CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com/
    https://lore.kernel.org/all/CAJfpeguMViqawKfJtM7_M9=m+6WsTcPfa_18t_rM9iuMG096RA@mail.gmail.com/

I can do an incremental patch to add these ideas to this example.

Thanks,
Miklos

