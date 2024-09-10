Return-Path: <linux-kernel+bounces-323938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8728197457E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AD01F26B47
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79B1917E3;
	Tue, 10 Sep 2024 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaUfMo+m"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6E1AB518
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006579; cv=none; b=WaoGbSL6Zn7YLX2BhhDR7Pxw5Iyc+y1r4DHZhEWHqqbsyjwNIWe4GbdXQZjAESHiBOM77/A8NJjd7zn/qVDQGdrTx/wvp5ASw1msoXZsTRKZtEZmHKl0NG3pgXzW+HiLO1OGGr9mhbKBY+kmBKPcbOQNtJmZ2zfiHu7vX7jRxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006579; c=relaxed/simple;
	bh=hHIg8i0gS3Bf6sinh0WN3XoEPUmj8P+7fJP2LdbCtG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFyXtatTiNp/LLpnVOo8qWnnoDYRaIbUSpwQpAXuAbEkvxnkqx5D/mkAsOkQw6x6YnMaxAo4bKIjmd4orYU/zPFCItHaHfqYqdA0I2LNormO8WomrT7GegSK3VP0ON5e5LJaVD+yF8vKGtx3QHLf++4cUyvvr5GugZQ/8aXikk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaUfMo+m; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c354091616so36948816d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726006576; x=1726611376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHIg8i0gS3Bf6sinh0WN3XoEPUmj8P+7fJP2LdbCtG0=;
        b=OaUfMo+mLyS2Pweu7wjMjlD+ZmF6j4JGTQWox8QvbfHCLZPEDUPVJU0dTLSzdHDvUD
         gvGDp1BU/TusZbQ9xNZpKN9xtsg4UU6/QltT6bVmrCZv7cf4hgtF+IRg48VWIoCAr+Hp
         ni4jklH67bv6HF7ed1282OaXd1xdeG/6aNdxfSNKOa2a3MHAggvBws9kWLOoPCz/zudl
         dK2UsCWTG0EWnXbwpq4IqF4E3MN/x491lZFTGb4csnFd7K8p4zQGESp4hHrC7SPQKud3
         L1c5lHK+2PG0urT8nH4oqb4WDrVY02gG62WDeyfA2eYw/GcmXw14+f+q5Zgf4t4PmFtX
         Y/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006576; x=1726611376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHIg8i0gS3Bf6sinh0WN3XoEPUmj8P+7fJP2LdbCtG0=;
        b=Exq9GnPoENgdNk761qF/F5NiNpi8670717xpZTxR4thea4AsROLHxIANv5bL5xs9uB
         +sV1LLRCwqKhkPcrETpY8xx2jRIeug4OSlqwRS25B8phqQmhzISVtbUHvfFoo4/mIXzo
         wx5pJCVE11CeBFU7+q1uLImHkXlaWTgXA0WWiO18TjZbuPsDe/bZO4oJJ1f2YUjfvdB4
         hLBapwCbnjiqhUME3zTiDX0ZczzZb+7B5Die2MTuXWilOhLY0mhvIaaVqjhrNgenFC40
         QBcLL2T+/NKBvrLLqNaInggqnl0+RVx0oV8MN2Qrqg1sh+1zpj8zgz+1DRRKo56+Aikr
         OoFA==
X-Forwarded-Encrypted: i=1; AJvYcCWRSE6nT5I+FLDXY7O+DTP4oMBorBWZLlkPXBrTOuxN+YWKyV9+pfo8d9MqNelmm1md5c5DaKkZsgXIyFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygiohed2Ip+CsNi+JnwV9fI0GrU4cQYKXGoOWoFmZoSUMcfqoO
	FqTER+H+8lv7mkMdRkUIu+JJa/5AM1ChOscQc4nmDMndwlJCqzIBGXi1DOGZmfxDUcRg9uAnUfs
	du7FMOKxuO4zeBBWtgDMfdaiB3syGmxqjq9EMTdn2
X-Google-Smtp-Source: AGHT+IH6j1CjcbCzXOH1/LDwJczOXPOc2Hu+rc7nUbxX9+q+uyt7yEQs7pN/cUoLVtxP6duCgszTtKHpKX9DYMGhazM=
X-Received: by 2002:a05:6214:3d08:b0:6c1:6b4c:6ba4 with SMTP id
 6a1803df08f44-6c5282fd494mr199592026d6.8.1726006576325; Tue, 10 Sep 2024
 15:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNgx6gQCqBq-L2P15ydaN_66sM9CgGa9GQYNzQsaa6Dkg@mail.gmail.com>
 <CABXGCsNztS8MLteq5=fcddwuQ1TCzeOM8TdVtpJ3crK=sV5PTQ@mail.gmail.com>
 <CABXGCsMdxHJ-MLkS0pm51Sk8g0PTghsuZxmowvj5t44bVN4ndA@mail.gmail.com>
 <ffd2c40c-1c2e-4465-b26f-88d5e08a80d9@amd.com> <CABXGCsOoL5vD0+FRALFQFr3ZBpb2z5mpGKzAD5RHoW9_sb5yaQ@mail.gmail.com>
 <f68020a3-c413-482d-beb2-5432d98a1d3e@amd.com> <CABXGCsMSTsBFW=OirDszPFVOiNgyOBSh3qyzAw-Coi-McnicAQ@mail.gmail.com>
 <04d3755d-f295-46d7-b35d-008b888b39ae@amd.com> <CABXGCsMDk59-P0Nr1v7KajKsoQh2966mykLPWQxajPtq=OGgXg@mail.gmail.com>
 <eeab54b4-c055-4992-9ca4-f9e382db68c4@amd.com> <6db472e4-cd90-4ba6-8368-725b10ba5b4a@amd.com>
In-Reply-To: <6db472e4-cd90-4ba6-8368-725b10ba5b4a@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 11 Sep 2024 03:16:05 +0500
Message-ID: <CABXGCsMaXUjHyySQqw7fPmoyDHSJ0yc0f6NPfOU2BRd_Hvj8TA@mail.gmail.com>
Subject: Re: 6.11/regression/bisected - after commit 1b04dcca4fb1, launching
 some RenPy games causes computer hang
To: Leo Li <sunpeng.li@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, zaeem.mohamed@amd.com, 
	pekka.paalanen@collabora.com, "Wheeler, Daniel" <daniel.wheeler@amd.com>, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:47=E2=80=AFPM Leo Li <sunpeng.li@amd.com> wrote:
>
> Thanks Mikhail, I think I know what's going on now.
>
> The `scale-monitor-framebuffer` experimental setting is what puts us down=
 the
> bad code path. It seems VRR has nothing to do with this issue, just setti=
ng
> `scale-monitor-framebuffer` is enough to reproduce.

I ran some additional tests:

1)
$ gsettings set org.gnome.mutter experimental-features
"['variable-refresh-rate']"
Symptoms: No

2)
$ gsettings set org.gnome.mutter experimental-features
"['scale-monitor-framebuffer']"
Symptoms: Screen flickers happening when moving cursor.

3)
$ gsettings set org.gnome.mutter experimental-features
"['variable-refresh-rate', 'scale-monitor-framebuffer']"
But Variable Refresh Rate is disabled in the display settings.
Symptoms: As previous - Screen flickers happening when moving cursor.

4)
$ gsettings set org.gnome.mutter experimental-features
"['variable-refresh-rate', 'scale-monitor-framebuffer']"
And Variable Refresh Rate is enabled in the display settings.
Symptoms: On Radeon 7900XTX hardware computer completely hangs without
any messages in kernel logs.

On Wed, Sep 11, 2024 at 2:11=E2=80=AFAM Leo Li <sunpeng.li@amd.com> wrote:
>
> Hi Mikhail,
>
> Can you give this patch a try to see if it helps?
> https://gist.github.com/leeonadoh/3271e90ec95d768424c572c970ada743
>

Thanks, with this patch, the issue is not reproduced anymore.
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

The only thing that worries me is the thought that the problem with
hang is now hidden.
It's one thing when the GPU hangs but the system continues to work,
another thing when the system hangs completely and even
Alt+SysRq+REISUB does not help to reboot the system. It shouldn't be
like this...

--=20
Best Regards,
Mike Gavrilov.

