Return-Path: <linux-kernel+bounces-420332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E309D78F7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9187281B57
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C0B15F3FF;
	Sun, 24 Nov 2024 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD9IRBdA"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09A2500BD
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732489120; cv=none; b=CQNeUr0mZMQCy52MLP+7FJVHGQVO87MnfYdFcIewVrwvfHvXFkuqb8xXFeP5Bs9czSkA/eqRAYULvds99fVQrRGsWu9Bl8FoV0ymi02+ulHunrXcZwxmMZZeC6sCWINKau7ZOTM6YrepsezV7Ma8XUPYi7tl9d8lkMZmg9yZnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732489120; c=relaxed/simple;
	bh=ZjuAMRHwncamsNIrC2i1xY9kC1cOxqLCQI7RzXBW4ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ0DRWU/OHARusWu6hW/ki1eAJ9xHf8MpliPVEBOdBe8af8Wy4Ncfd3mMbKlemXLzghLxJN6tf+pePFd1ThtfPNe+ppG59NaJlpCs2sK5gJ/2i+EZpeP+1TDESXlEdegm3ESzQEoqx6kaJsR0e3xcwf6wn/k12HpPHaVVdEhr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD9IRBdA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed49edd41so636508566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 14:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732489117; x=1733093917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJZn4r1Q1mVyx8xe9OjWZIQdyqdlmM4KAqXOvCd7B8A=;
        b=OD9IRBdA8we4BX6JnH12xhIZOt1R5ZGazfOjcXp97JDviG5Hm4RQ4HShustqG+8GfL
         oYaHeufh+q2O90iEL3l8JGqI3zIIT81RkJ37qAcSuVEjweQV4jb9BBucgKjD+LT1il4E
         OmU+lyy4BOeyVfgpi0hhVBqgVADgrFR8QIBYnibtIQm/s/WFmsyt0gyxqpc0r57110Gn
         Y+5PCGVT2MUw9J4Ipu2t4EN/ZjNO6RfD5XezvaJNqX8bAkmxN6iZDWH0rQYBxe1PPDOl
         LtChqLtoixKbLgyPnkjwBBfqE0CP+60U8kUcPjX68gmX86zOsGRJmyVTpdA0qT00QP3B
         qzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732489117; x=1733093917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJZn4r1Q1mVyx8xe9OjWZIQdyqdlmM4KAqXOvCd7B8A=;
        b=VrFWhx92aNiS1c0V/ZailEwq4DW96OTvaOpnRtJRS/NJ97SXbVMtCmz1kfPK/AXNGd
         +awf2KIRlq/X0V18+zVNYVwgx6QYjC6CrTom80yMb3ROE2UPc4Cgj3B9rzcawY7RDtF+
         wqHFoP9W1WUi6balK7lcwyYs0Zd8fTZkfRPsHmyT+4UdXLAHJIzxGZYw7p4ekP8LnJ3e
         3NSjTlYRHesB3K5LWjYI7mdLNkj26pUdG/StNCdmeQi1/6kprapy08TkXVnCobW0z/pA
         oYwLnxyvH7pl5Y5Zxj2cIFlDzh809Pv3RIHX5xo5nzLgXhkgb+brW4YIo7SC+a4GrYRA
         EsWw==
X-Forwarded-Encrypted: i=1; AJvYcCXjyFH7dAWc3KGGJkrNXuJbWekX2rNW86kZsvkajqk7B/j/t7+ovlYMjEhnRaWCN+GwJE1VGJZuiZRWN54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGs03oG+26nzMRj2RWyUsP0moqCw1d6S9JyYBY5g71rf6Y/nF
	/zlnwzJ39kokWvP2xKlMqNXgikbTwXrfugS3rTRvQaOdlf38e154T3iAt6V6fQp4DYJI+oVLgW+
	9sssSy6kNlZLaKKGVPl72gMA0KVk=
X-Gm-Gg: ASbGncuhPSxTk2346UR5YbwfCmLxO9ZnvUzfIbmbczRv1ChcCMg3qi7i4rritMBm7FS
	2e0SZkMrQYYXIawJt3bjFhZGGCNr8NA==
X-Google-Smtp-Source: AGHT+IEaat5Lo3zoMYsazU224LzNHL+gn1VeSlwrawrhbYhupgnxEoxvfhiEmoJgbcjr0GtT2Xt1R2cw4sPlnm4+GLM=
X-Received: by 2002:a17:906:2189:b0:aa5:2f8a:b958 with SMTP id
 a640c23a62f3a-aa52f8aca44mr565291566b.52.1732489116886; Sun, 24 Nov 2024
 14:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9txbfH8vf-YjwTXEYL729a6r2eeLBxCJc3MSD-t5jXVA-w@mail.gmail.com>
 <Z0NXQ6iRK43x6WbG@sashalap>
In-Reply-To: <Z0NXQ6iRK43x6WbG@sashalap>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 25 Nov 2024 08:58:25 +1000
Message-ID: <CAPM=9tw5eTBCDn93GyrMjF3r_kDbr2-v1GgKdZECFNupqakDFw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.13-rc1
To: Sasha Levin <sashal@kernel.org>, javier.carrasco.cruz@gmail.com, 
	CK Hu <ck.hu@mediatek.com>, wenst@chromium.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 02:41, Sasha Levin <sashal@kernel.org> wrote:
>
> On Thu, Nov 21, 2024 at 10:25:45AM +1000, Dave Airlie wrote:
> >Hi Linus,
> >
> >This is the main drm pull request for 6.13.
> >
> >I've done a test merge into your tree, there were two conflicts both
> >of which seem easy enough to resolve for you.
> >
> >There's a lot of rework, the panic helper support is being added to
> >more drivers, v3d gets support for HW superpages, scheduler
> >documentation, drm client and video aperture reworks, some new
> >MAINTAINERS added, amdgpu has the usual lots of IP refactors, Intel
> >has some Pantherlake enablement and xe is getting some SRIOV bits, but
> >just lots of stuff everywhere.
> >
> >Let me know if there are any issues,
>
> Hey Dave,
>
> After the PR was merged, I've started seeing boot failures reported by
> KernelCI:

I'll add the mediatek names I see who touched anything in the area recently.

Dave.
>
> [    4.395400] mediatek-drm mediatek-drm.5.auto: bound 1c014000.merge (ops 0xffffd35fd12975f8)
> [    4.396155] mediatek-drm mediatek-drm.5.auto: bound 1c000000.ovl (ops 0xffffd35fd12977b8)
> [    4.411951] mediatek-drm mediatek-drm.5.auto: bound 1c002000.rdma (ops 0xffffd35fd12989c0)
> [    4.536837] mediatek-drm mediatek-drm.5.auto: bound 1c004000.ccorr (ops 0xffffd35fd1296cf0)
> [    4.545181] mediatek-drm mediatek-drm.5.auto: bound 1c005000.aal (ops 0xffffd35fd1296a80)
> [    4.553344] mediatek-drm mediatek-drm.5.auto: bound 1c006000.gamma (ops 0xffffd35fd12972b0)
> [    4.561680] mediatek-drm mediatek-drm.5.auto: bound 1c014000.merge (ops 0xffffd35fd12975f8)
> [    4.570025] ------------[ cut here ]------------
> [    4.574630] refcount_t: underflow; use-after-free.
> [    4.579416] WARNING: CPU: 6 PID: 81 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0x148
> [    4.587670] Modules linked in:
> [    4.590714] CPU: 6 UID: 0 PID: 81 Comm: kworker/u32:3 Tainted: G        W          6.12.0 #1 cab58e2e59020ebd4be8ada89a65f465a316c742
> [    4.602695] Tainted: [W]=WARN
> [    4.605649] Hardware name: Acer Tomato (rev2) board (DT)
> [    4.610947] Workqueue: events_unbound deferred_probe_work_func
> [    4.616768] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    4.623715] pc : refcount_warn_saturate+0xf4/0x148
> [    4.628493] lr : refcount_warn_saturate+0xf4/0x148
> [    4.633270] sp : ffff8000807639c0
> [    4.636571] x29: ffff8000807639c0 x28: ffff34ff4116c640 x27: ffff34ff4368e080
> [    4.643693] x26: ffffd35fd1299ac8 x25: ffff34ff46c8c410 x24: 0000000000000000
> [    4.650814] x23: ffff34ff4368e080 x22: 00000000fffffdfb x21: 0000000000000002
> [    4.657934] x20: ffff34ff470c6000 x19: ffff34ff410c7c10 x18: 0000000000000006
> [    4.665055] x17: 666678302073706f x16: 2820656772656d2e x15: ffff800080763440
> [    4.672176] x14: 0000000000000000 x13: 2e656572662d7265 x12: ffffd35fd2ed14f0
> [    4.679297] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffd35fd0342150
> [    4.686418] x8 : c0000000ffffdfff x7 : ffffd35fd2e21450 x6 : 00000000000affa8
> [    4.693539] x5 : ffffd35fd2ed1498 x4 : 0000000000000000 x3 : 0000000000000000
> [    4.700660] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff34ff40932580
> [    4.707781] Call trace:
> [    4.710216]  refcount_warn_saturate+0xf4/0x148 (P)
> [    4.714993]  refcount_warn_saturate+0xf4/0x148 (L)
> [    4.719772]  kobject_put+0x110/0x118
> [    4.723335]  put_device+0x1c/0x38
> [    4.726638]  mtk_drm_bind+0x294/0x5c0
> [    4.730289]  try_to_bring_up_aggregate_device+0x16c/0x1e0
> [    4.735673]  __component_add+0xbc/0x1c0
> [    4.739495]  component_add+0x1c/0x30
> [    4.743058]  mtk_disp_rdma_probe+0x140/0x210
> [    4.747314]  platform_probe+0x70/0xd0
> [    4.750964]  really_probe+0xc4/0x2a8
> [    4.754527]  __driver_probe_device+0x80/0x140
> [    4.758870]  driver_probe_device+0x44/0x120
> [    4.763040]  __device_attach_driver+0xc0/0x108
> [    4.767470]  bus_for_each_drv+0x8c/0xf0
> [    4.771294]  __device_attach+0xa4/0x198
> [    4.775117]  device_initial_probe+0x1c/0x30
> [    4.779286]  bus_probe_device+0xb4/0xc0
> [    4.783109]  deferred_probe_work_func+0xb0/0x100
> [    4.787714]  process_one_work+0x18c/0x420
> [    4.791712]  worker_thread+0x30c/0x418
> [    4.795449]  kthread+0x128/0x138
> [    4.798665]  ret_from_fork+0x10/0x20
> [    4.802229] ---[ end trace 0000000000000000 ]---
>
> I don't think that I'll be able to bisect further as I don't have the
> relevant hardware available.
>
> --
> Thanks,
> Sasha

