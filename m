Return-Path: <linux-kernel+bounces-278019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6228194A97F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E7F1C20F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43783A1C4;
	Wed,  7 Aug 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+DI1AyP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19A2BD0D;
	Wed,  7 Aug 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039811; cv=none; b=qZ5pvaObxp47PyKAtB9Ls6gSVM9H5vDDIzEUUC5eApmpi0k/U3Q/lRV8B/+K8Xt7TbvswXAXeMBC+bs6aDNXtcEvTqmcYCRKKK3U17rXWNl3n5U1YRY7Ln4qv3xTzMyWwsC4QvjgiEdzhV+T1FYULqlH3DUluNNEXH5gEC4MqeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039811; c=relaxed/simple;
	bh=gPUG1/VZTWeXA9NVBdYdXwFhDcEr6wqbJist1704D94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVRBHRHazljT95L8BMnYGjqLQt3n4onumwauQcXoQn1thzS8+UZmDdQZkPXQubtHCyJZy1+LVkBuz1VAcRoOJGgU/30uSFXVmsOzST0m9QkcuWPx2tBsgJHOa4lYZzx08y0zIn+HII0maoQEIjpCQbvyOObzJFuAxKPxw1JbBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+DI1AyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41A0C4AF0B;
	Wed,  7 Aug 2024 14:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723039810;
	bh=gPUG1/VZTWeXA9NVBdYdXwFhDcEr6wqbJist1704D94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B+DI1AyPB53oW/pt0wzjhCpXn1Ptjw5ADybm/+TCvgupX6l05YwAY2Widg1KYz+pv
	 xBeVHXWf70iX9phW8BeMcukDV4BvDZTn8Nv9udVMWFYfbp+QKgQgMq9VEqQxkqKX8I
	 rhAMWQJNTvV69b9rQL/8H+enwrUj/NNKQOGFpNTLc6hivnRHelNzHQQ7w5ZvbDGcOA
	 P/QXKl/F9zyI1+KgoeNGwL2/94gt6tLLcr5vGhjC04R0MKDhQmh88NsvPL96hJvruz
	 yIzSBBMwrUGIyxNyG2opmUOL2k46FDTNBctZUWtYzzIq01f6QMABd9Bph3JoFbfXEv
	 1t8XycWmQDzkg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f032cb782dso17340091fa.3;
        Wed, 07 Aug 2024 07:10:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWb5LrQu0VW4P+sfp3scoAHgiXMTE4tVXMxPPOWGwMfaEiEGWA8/OaIx5SseCngW+em3uNUbb9g4UO9/jFBv4jcTvwVC8zcOFyYFTVUx0lf/BVfBOM8TQxanXFwzVEk0Lzu4ge8/9rpOg==
X-Gm-Message-State: AOJu0YwRbiB0iL4u3HPNcUQ712Zd3mJPimizhZFCRvICj0GN7AYi+Krk
	gezd7wgCw+N50NWrEq9+vZwYp//r+wDWl/I1n67zx5OnGm0U2BApV87eC9Cjg8go5B156BU1Bkk
	1vp2lFKJ0qzNtU5a8gkMa7uYPOw==
X-Google-Smtp-Source: AGHT+IG/CdqHXL/y15Zm006Q+Vwf6hbCGoS9C7TZuoSQlOw+gCC2V6nSn1RNbxdYOcoMYEz/7YKlIwgt4VGLe2RmynU=
X-Received: by 2002:a2e:9dc8:0:b0:2ef:3347:ee93 with SMTP id
 38308e7fff4ca-2f15ab39668mr133431111fa.44.1723039809037; Wed, 07 Aug 2024
 07:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807134032.1364503-2-stefan.wiehler@nokia.com>
In-Reply-To: <20240807134032.1364503-2-stefan.wiehler@nokia.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 Aug 2024 08:09:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKAotOxj59Hb-MbmXuaOq-kZaCxOn-wEQbz5h46MDj2nw@mail.gmail.com>
Message-ID: <CAL_JsqKAotOxj59Hb-MbmXuaOq-kZaCxOn-wEQbz5h46MDj2nw@mail.gmail.com>
Subject: Re: [PATCH v2] of/irq: Consider device address size in interrupt map walk
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 7:45=E2=80=AFAM Stefan Wiehler <stefan.wiehler@nokia=
.com> wrote:
>
> When of_irq_parse_raw() is invoked with a device address smaller than
> the interrupt parent node (from #address-cells property), KASAN detects
> the following out-of-bounds read when populating the initial match table
> (dyndbg=3D"func of_irq_parse_* +p"):
>
>   OF: of_irq_parse_one: dev=3D/soc@0/picasso/watchdog, index=3D0
>   OF:  parent=3D/soc@0/pci@878000000000/gpio0@17,0, intsize=3D2
>   OF:  intspec=3D4
>   OF: of_irq_parse_raw: ipar=3D/soc@0/pci@878000000000/gpio0@17,0, size=
=3D2
>   OF:  -> addrsize=3D3
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-out-of-bounds in of_irq_parse_raw+0x2b8/0x8d0
>   Read of size 4 at addr ffffff81beca5608 by task bash/764
>
>   CPU: 1 PID: 764 Comm: bash Tainted: G           O       6.1.67-484c6135=
61-nokia_sm_arm64 #1
>   Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.01-12=
.24.03-dirty 01/01/2023
>   Call trace:
>    dump_backtrace+0xdc/0x130
>    show_stack+0x1c/0x30
>    dump_stack_lvl+0x6c/0x84
>    print_report+0x150/0x448
>    kasan_report+0x98/0x140
>    __asan_load4+0x78/0xa0
>    of_irq_parse_raw+0x2b8/0x8d0
>    of_irq_parse_one+0x24c/0x270
>    parse_interrupts+0xc0/0x120
>    of_fwnode_add_links+0x100/0x2d0
>    fw_devlink_parse_fwtree+0x64/0xc0
>    device_add+0xb38/0xc30
>    of_device_add+0x64/0x90
>    of_platform_device_create_pdata+0xd0/0x170
>    of_platform_bus_create+0x244/0x600
>    of_platform_notify+0x1b0/0x254
>    blocking_notifier_call_chain+0x9c/0xd0
>    __of_changeset_entry_notify+0x1b8/0x230
>    __of_changeset_apply_notify+0x54/0xe4
>    of_overlay_fdt_apply+0xc04/0xd94
>    ...
>
>   The buggy address belongs to the object at ffffff81beca5600
>    which belongs to the cache kmalloc-128 of size 128
>   The buggy address is located 8 bytes inside of
>    128-byte region [ffffff81beca5600, ffffff81beca5680)
>
>   The buggy address belongs to the physical page:
>   page:00000000230d3d03 refcount:1 mapcount:0 mapping:0000000000000000 in=
dex:0x0 pfn:0x1beca4
>   head:00000000230d3d03 order:1 compound_mapcount:0 compound_pincount:0
>   flags: 0x8000000000010200(slab|head|zone=3D2)
>   raw: 8000000000010200 0000000000000000 dead000000000122 ffffff810000c30=
0
>   raw: 0000000000000000 0000000000200020 00000001ffffffff 000000000000000=
0
>   page dumped because: kasan: bad access detected
>
>   Memory state around the buggy address:
>    ffffff81beca5500: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffffff81beca5580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   >ffffff81beca5600: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                         ^
>    ffffff81beca5680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    ffffff81beca5700: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   OF:  -> got it !
>
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
> - Fixed of_get_address_cells() open brace found by checkpatch

Please don't send new versions right after the prior version. Give
people a chance to review.

Rob

