Return-Path: <linux-kernel+bounces-331271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A089B97AABE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B6A1C26F09
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 04:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5627A45008;
	Tue, 17 Sep 2024 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zach.us header.i=@zach.us header.b="CoIVm1Do"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F72B9B3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726547490; cv=none; b=uvg+a7843LplCeyCk5KOIiFaKoIgli0ttpSvg1Tq6A6zqdEF4PNulxdG9IUsfones32k2nhh5vd0Svt4iNQxAkq5Ut+7rQWLxDCXQ2OhsVeILWw90ujpHSm2zzkIHzKRBIAkYML2k34lvNLNvsek5RL+9u+ZaPISWxl6VwLrwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726547490; c=relaxed/simple;
	bh=l8miaHMe04523C6YCUfUQRfGF4ZRTHcQdIE0ha82H1Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=S76NDjj4EK0poijHJYp30gO9WrQuqaT/dpnW1tBzzEbClKA0x8fXun0ikrhfYuFF7K2UO/gynOoeU4ZMIJTNs5fJ181Xy9+E418KrFW+dfHrnOtwtcWwjQX9qOrOu1IHIYA4jdslgAgO44GVGyQDTCGk9lTmVwWFJpZc3elH29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zach.us; spf=none smtp.mailfrom=zach.us; dkim=pass (2048-bit key) header.d=zach.us header.i=@zach.us header.b=CoIVm1Do; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zach.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=zach.us
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6d5893cd721so30438457b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zach.us; s=google; t=1726547488; x=1727152288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LIHNcE4v45VqxruROqcgpWF9mo28yczvOySQoZ/7kjo=;
        b=CoIVm1DoZ2Sj62iGRLNMfnGKhTz2gvoS6CLJujqG8sr2QwQUujCe0nJO7YkfzYQKse
         fkiHqw2dTtHzIGj2TMpxgvnim3tPZCK/caT0cklqh2gKmcUx20LAgPnGENfON1y88TKT
         t4IfASHw/TNNToLjn443mxkjEamY+MNDxOucSmblnrR4StMrIqb6kDselMX+R5gJ3G0z
         P891UwF9IYt9j/vTKiZrKX2X1u5aX9llpIEuuteqnLveCYq0KE076zIZHaVyWqtQHh1E
         2FUhQxLuOihcAMYSZtNVI1pDO1pnge6uIDoaH/71KhobPY8fDxIqz/iXjuP3us75otHQ
         ZaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726547488; x=1727152288;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIHNcE4v45VqxruROqcgpWF9mo28yczvOySQoZ/7kjo=;
        b=RPFzxK36FmRCa9xva0wZJs3IgO2MAUeiEvMQZTnEb4yatefQTwaThbrtB1v8dhAdGP
         xQwsa3fag8QFyBhHBxyW+Yz8K01xVSLkI9KNoEAmjD/+Y+VVCrxNWA6+BFK9KJoLfSbB
         9Qp/3HavRs9bd3+sSTGlrCRfR8Kgpi06ziR95Fc565/Hd1IC+fq8Gvy4ZQxLP+iwpiYS
         sdhxZkDz9BT8zIECx5S1O6Y2zAK+xiBiowXb7GxVJvUXE0VG+L3ncT4YDx8bbQKG/vcj
         bytvwg7HYkwDCYLvkV7Q/YnJyYGuiQ52m+Q/APW+8l97lGsKoAi3XvYpC9ZHFs8P/a88
         BCRw==
X-Gm-Message-State: AOJu0YyUBj/l1lZ4CI1U8r1oL/RtwKvx0ZalW/oymbZ+El5BHdQcJY14
	CGUT/MYMYLFRK8dNL1D3JJ8nGvvThXuHhyqG8wTzASQYOy1eDpbmxDtUat1a34Gnco4+cQHU/hv
	g/lkF0jJnP0TotN8oS/79cEYQoSi6xgrnOgJiUiraIYQXW5kmENgMsQ==
X-Google-Smtp-Source: AGHT+IGQfAujIncgZNtuPIZLaroqEPGZbnEfG6FzYF5SiY4HBnyhDQbtOvg2tIf7Z7xScqm1pw4/wBTNSRTc1+6Vygg=
X-Received: by 2002:a05:690c:7204:b0:6db:b7a9:bc99 with SMTP id
 00721157ae682-6dbcc59b74emr113769267b3.43.1726547488077; Mon, 16 Sep 2024
 21:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zach Walton <me@zach.us>
Date: Mon, 16 Sep 2024 21:31:17 -0700
Message-ID: <CABQG4PHGcZggTbDytM4Qq_zk2r3GPGAXEKPiFf9htjFpp+ouKg@mail.gmail.com>
Subject: Allow ioctl TUNSETIFF without CAP_NET_ADMIN via seccomp?
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I was debugging a seccomp profile that attempts to allow TUNSETIFF in
a container, relevant bits:

...
      {
            "names":[
                  "ioctl"
            ],
            "action":"SCMP_ACT_ALLOW",
            "args":[
                  {
                        "index":1,
                        "value":1074025674,
                        "op":"SCMP_CMP_EQ"
                  },
                  {
                        "index":1,
                        "value":2147767498,
                        "op":"SCMP_CMP_EQ"
                  }
            ]
      },
...

...but I get:

Tuntap IOCTL TUNSETIFF failed [0], errno operation not permitted

Looking at the code, it seems that there's an explicit check for
CAP_NET_ADMIN, which I'd prefer not to grant the container because the
permissions are excessive (yes, I can lock it down with seccomp but
still...): https://github.com/torvalds/linux/blob/3352633ce6b221d64bf40644d412d9670e7d56e3/drivers/net/tun.c#L2758-L2759

Is it possible to update this check to allow TUNSETIFF operations if a
seccomp profile allowing it is in place? (I am not a kernel developer
and it's unlikely I could safely contribute this)

