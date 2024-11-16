Return-Path: <linux-kernel+bounces-411552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA08B9CFBD2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A178B24724
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6790279E1;
	Sat, 16 Nov 2024 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFM4w4Ck"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5E10F7
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731718169; cv=none; b=JQrGoszNpyDB5Sl46rVuXDfaDSudufbBMqP3+GGNkVmCJXzJo3aHoVrGFkQeKtdpJmlDX0JFJ6Xc3pUYq59rIGjM1fz026I8ZzbuDnyNBKJbQsU7zSVH7HZ75hnjYsPkr+ld49ITiH0b6WYCPPJX6PW7IQ9p+YJrz27YGNmMc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731718169; c=relaxed/simple;
	bh=axzdPAEBjK7IpVZft9J6hbHCkZngjwl5o1ZPcFhsNhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXdFVmi4IbZlgwl9PJJV1ydX/7sRItZ6eqBbTv8jijkYBgaIP5zz1akmwYnUvJNYpkqTpJKxfABBZUlsyF2hVO4Qpj8dXfwzj1iKBOqBIA6uN9KN1d33eRwhLDhCNFEZqQ9kKTgATRMWvsm/w+sdzoR1MPdlkR68oJP1X153O5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFM4w4Ck; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa1e51ce601so32792866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731718165; x=1732322965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xwxoFfvf68t2c05O8hFSikNCB40lKremk6L5/gXfII=;
        b=KFM4w4CkFF9nd51Amt2pDOL26uukUjvv9T5vpTtKNsmoiJBF9RAalV1YQzdTm8bGUo
         P0LL1PiK3zvYrPmJ9+qUN7rNiceh8gUpv6eRVNg9oxEqY1TdlGx7vpn6xTdQ/G+cfDrF
         Ru5snX08HyntgxAcn09JovgIqlCR0/x3qWkEoRS4w9PxXBG/y2FR/N0cCFafxKIP3z6I
         FDCci9Lu1XnPiZc8dtplNTjWH6cPaJtxwoI2mPLgQ5H8l2msMLXS/39EB6rJ/1Zlanux
         YFz4eqJqb7X0vueTVoabpGBH+l/o5myLL8JvL1n+2S14nX8Xs7mdFGDGKSiUq9XKUmjB
         h+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731718165; x=1732322965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xwxoFfvf68t2c05O8hFSikNCB40lKremk6L5/gXfII=;
        b=h9z+yWHOi9Mk2uqWMj5ENXaNTBjZplGpXTYOkeum9QXEF+Xq2oOFzIXPxpj/Ec4Lfe
         T1s6MtvwMKhgNVZsksWVl7QDzXqKropRtwHWNv5jKouad68SNikJboQbMFadN5L4Ajwg
         kBFiK4VDO/xOd3fa4SIfZLStUmXQJoheB3c8MVhZ47ouRn7sGYdaYCWViTqp6sXPJprs
         UBhtba5DO+RA/PbyURk7pwJIBAy0anjf6mxjmt0z28W9/HUAqso7CTsovdZE0CmPXXD+
         84W3Vj+6+fXth7bkN17kljHGEAkerERSrYZWzbh9JBXzn5eZo4S5y34jqHnrfw73gqYe
         53Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXiBM+qyTIt20WUIIjoXhWQa/vxMAEX7oRX3DobdWsPOCniXp0BoThZOZmugPJmjHOZsTW/opBezZEEPEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznOLxEkUP9U0kYDL/6njeh9wS8EMS+ZbanSDyONo/g4/N5gykH
	J6yLzqkD9zYCr9zUXdseEHlUmoh4ugtQNkj7MDT3uli781lnxRfub0YPyGdHdshUD1Mm41M2HtB
	BZ5ZkM5P/xfBM+BTGSAOy8Ltbsr0=
X-Google-Smtp-Source: AGHT+IGJhrCM+OKJAlm6GHOVvnO748E+3lOceZsjr9NF3aDCAblWF1jPWsXgrJZf7IqJ02WctNO7J/Yo6xUcWus0bp0=
X-Received: by 2002:a17:906:c112:b0:aa4:7905:b823 with SMTP id
 a640c23a62f3a-aa48347cb36mr374323566b.32.1731718164714; Fri, 15 Nov 2024
 16:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115083727.30005-1-brookxu.cn@gmail.com> <20241115170411.GA23437@lst.de>
In-Reply-To: <20241115170411.GA23437@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Sat, 16 Nov 2024 08:49:12 +0800
Message-ID: <CADtkEec84+ECj_s4Seue5uC+xv3dBu6T4kaqeHMe9PLiLV6tUw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-core: auto add the new ns while UUID changed
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B411=E6=9C=8816=E6=97=A5=
=E5=91=A8=E5=85=AD 01:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 15, 2024 at 04:37:27PM +0800, brookxu.cn wrote:
> > From: "Chunguang.xu" <chunguang.xu@shopee.com>
> >
> > Now spdk will change UUID of ns while restarted if we have not
> > specified one. At this time, while host try to reconnected to target,
> > as UUID have changed, we will remove the old ns, but not add the ns
> > with the new UUID.
>
> And that is broken behavior.  The host must assume the namespace has
> been deleted and recreated when the eui/nguid/uuid change, and we need
> to catch this.
Yes, now we have remove the old ns and log the change to dmesg,  but I am
confused why not auto add the ns with new UUID, we should treat it as a new
ns? so that we can avoid an active controller with no ns, but actually it h=
ave
one.

>Fix your broken target code instead.
>

