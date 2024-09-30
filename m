Return-Path: <linux-kernel+bounces-344778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FC098AE2C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4079F1F21A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA961A262E;
	Mon, 30 Sep 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBQn5rmq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BF1A2578
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727774; cv=none; b=o/U/J2SurAQ2vAAVYBjn14vYWlVs4n8xpTJYW9NuKNz+uc0K8brYnudz6azKBO0TYLhDO3a4YpjdKFkHe4PPERwwo0fZ2c/I85wQ/Qus+3B4StyAfmUOG6pkfPEynAjPReccixe3BvUaILVa0UCCJyUKs60+yphZ+ue7cLb3bC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727774; c=relaxed/simple;
	bh=kMZH+xLU9w/w+jErL7nAUzTIjTaixU+hbZdI5UMjEAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyq3sk4gwVvryP4TE4ONRHu/E7IZxVZ2TCXiE51nvmtDoorCw4FWeOG/uFO1poWmsPhMKjFZ+AwA32e0dGV4eC/uyBTpHGMsTmpUqMX/6taBcXt+VONSH3XiXA43+FgVIAG2ocCbqWNXt5goGkRH086udpR9MFw4cHUjAyRb2e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBQn5rmq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727727771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVaqJm7tLoF1HWWT2ray8rPf/j7gC0aKBR8MDdz/TH4=;
	b=NBQn5rmq8W1u6x00+cf7A5Z1r3HaWw7qWaZvJVGgjkfIbwi2cZeBoXr9xaNIAwrUpvXwTt
	3RQ5B+QmBUShsnKaONL1qtsfEGzmVE08Ps8LjTrp56LLNOpkrOrjnXTFxN3/gJlEOHA9gX
	aj4PFuoEtRY6QR03DQ92a6XzV/T3Iek=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-zdjoiHiFMgOaITjYeaoBkA-1; Mon, 30 Sep 2024 16:22:48 -0400
X-MC-Unique: zdjoiHiFMgOaITjYeaoBkA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fac57a3f02so13479061fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727767; x=1728332567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVaqJm7tLoF1HWWT2ray8rPf/j7gC0aKBR8MDdz/TH4=;
        b=EJn3ZiY6MamJMrGevhCtCa5qSGd6hT4REkHKXWE3lfWQvLbbg7YbFhps2fmC4mxMNV
         +Ar8tppHkxSxVAwBzgZ2qWB/LpI0ahqWbLljnDmUN4rouDKURRSlv7Zj8XJjaYXSzIuz
         +lOHSiqXFr+1kjmnxPBb/vUw1L9SovQHLe8drNLjyyQBnEeul7AD/UwRnYsOcd+tRpNo
         kUweKdKJSQ18+/acaPoYpxuyWDcyZbQvnG9zJIqYwHtGqZVhCqlFO8ivqNy/rpHVKcL4
         UUtPn0+LmY32ZTmmTy9DHAYlo+WNtUNntNbt8W6dUH7Ti5RYpv5WLn0MSVOR0Rpw8fNF
         ztkw==
X-Forwarded-Encrypted: i=1; AJvYcCWrKa9TwHFj90ABpv9MXWXDYCQPGsryqlVmzYILQgZfy62saFCmMwku56U0BJxNiha2O+oZjdQpV6yUb9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3lOlXVHN1LasoTmPaHICHjD4KrGLoWqV47DAqgkcLFyO8SOKD
	IP7dnc63PDWeVNOJ2g7oGInYNpuiCOexlH7vmk9oyAg9523GfD/+RaSrBDAaVtqaX8LZM0i9v6s
	nA74QgbQTJl0VkTg89LTr16RbT7uht/UNOow9Gzk0tVl5VD6Ixlbdxcw37/MvSryvxzpnIozuqN
	jWD4JRiW8Gff1w3nD3mYa33iMnhF3RwWtKjXt0
X-Received: by 2002:a2e:a58d:0:b0:2ef:2cdb:5055 with SMTP id 38308e7fff4ca-2f9d3e56140mr78848781fa.20.1727727766770;
        Mon, 30 Sep 2024 13:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOED+J7NIK671EAM5WNjgF/ITexh9huIebyGUKOqbFC6PtuFqTW3MFJhR+aLaTHS/W0tzN6SptNXddUS+y8JA=
X-Received: by 2002:a2e:a58d:0:b0:2ef:2cdb:5055 with SMTP id
 38308e7fff4ca-2f9d3e56140mr78848661fa.20.1727727766316; Mon, 30 Sep 2024
 13:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930201358.2638665-1-aahringo@redhat.com> <20240930201358.2638665-12-aahringo@redhat.com>
In-Reply-To: <20240930201358.2638665-12-aahringo@redhat.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 30 Sep 2024 16:22:34 -0400
Message-ID: <CAK-6q+h2-APvPUUDYgjGx2FzeJVkeAzH5Br+27A6bZyztfD5mA@mail.gmail.com>
Subject: Re: [PATCHv2 dlm/next 11/12] dlm: add nldlm net-namespace aware UAPI
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev, song@kernel.org, yukuai3@huawei.com, 
	agruenba@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	netdev@vger.kernel.org, vvidic@valentin-vidic.from.hr, heming.zhao@suse.com, 
	lucien.xin@gmail.com, donald.hunter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 30, 2024 at 4:14=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Recent patches introduced support to separate DLM lockspaces on a per
> net-namespace basis. Currently the file based configfs mechanism is used
> to configure parts of DLM. Due the lack of namespace awareness (and it's
> probably complicated to add support for this) in configfs we introduce a
> socket based UAPI using "netlink". As the DLM subsystem offers now a
> config layer it can simultaneously being used with configfs, just that
> nldlm is net-namespace aware.
>
> Most of the current configfs functionality that is necessary to
> configure DLM is being adapted for now. The nldlm netlink interface
> offers also a multicast group for lockspace events NLDLM_MCGRP_EVENT.
> This event group can be used as alternative to the already existing udev
> event behaviour just it only contains DLM related subsystem events.
>
> Attributes e.g. nodeid, port, IP addresses are expected from the user
> space to fill those numbers as they appear on the wire. In case of DLM
> fields it is using little endian byte order.
>
> The dumps are being designed to scale in future with high numbers of
> members in a lockspace. E.g. dump members require an unique lockspace
> identifier (currently only the name) and nldlm is using a netlink dump
> behaviour to be prepared if all entries may not fit into one netlink
> message.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  Documentation/netlink/specs/nldlm.yaml |  438 ++++++++
>  fs/dlm/Makefile                        |    2 +
>  fs/dlm/config.c                        |   20 +-
>  fs/dlm/dlm_internal.h                  |    4 +
>  fs/dlm/lockspace.c                     |   13 +-
>  fs/dlm/netlink2.c                      | 1330 ++++++++++++++++++++++++

and this file shouldn't be there anymore. Will be dropped in v3.

- Alex


