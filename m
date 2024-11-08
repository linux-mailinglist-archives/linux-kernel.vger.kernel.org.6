Return-Path: <linux-kernel+bounces-402422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D35F9C2756
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FC3B22304
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C681E1029;
	Fri,  8 Nov 2024 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PodNgzex"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEAD1AA1FD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731103946; cv=none; b=ucHxQeDckgAHfIfRIAQ6g6/0AxA878cWdu770j2d9CDqyI4rb4O9CCeIpfdJ43d39RITsm/1K40xa0a2RYG2qYpXL06eX8oa2iIrtr7BVjEtjVLri2zUDR9G9zAKwlY+GhNjxgcFDBFuk1DuRY3Ds1sWKRkvhldXCASFMcySOIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731103946; c=relaxed/simple;
	bh=Y5bDs9nzHxbt+UPqlyGAISPD2yqUwIfVQa57G5u5ZXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjWv0LqSneaFIRS8/6yR/mIgj9Zxt5ozXeP044zkaRyNsSHumLS+/jm/Zf/5lNpV4L1AKF/RpYg1dy78HePJAqsLEt5h/XCb2ofUTIRn59y7jj8TDCcrqqCSibff6s0HeFkplGwKBEn2uQPNlY1ygMlTQ8hQMQH92qmplVTs+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PodNgzex; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cf04f75e1aso3020971a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 14:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731103943; x=1731708743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KaeVr79q61Y3Gam887bzrKkz/UzFhMe5MAPAAQnkc54=;
        b=PodNgzexKNQBJtQJmcq0h0kP5F8r+EV4IE1bnAKurkDOSi9bISQAvgkmBYi9mSDuJ6
         qn5ZiAmjB4MQk2NkU88dhADaM/emUCaywAlvZY4m8dEVKPxO4mGY3Hozj64GSuAkWqS5
         CSP08Jg1GuSMMpTQsYtzgMuB5YjJ7ywYBdOK4jckBGIPaoPWFoi+Orzir0zircguNRqn
         G/m5Who/NMyux8DSDWPcIy4If6BUKkhikavNFj1laiCPTea0NB/BUzC5CpqAqW0ESI40
         Q3FutlUf59F2/5GELydW4ZPxgW2gujFVdKirGKRpOoP8GEwMW0Pe8y2PBBHvGj5WyAa2
         xROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731103943; x=1731708743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KaeVr79q61Y3Gam887bzrKkz/UzFhMe5MAPAAQnkc54=;
        b=ZFA2Xj7jd3vpGeN13Oj7S69Mscc+YRGEOv3yLLGZCxAKJ+QeHOFaPiwNGTJ9Ss+r7G
         CgGvxDJOup5s4y0S+VEqiG0r6d3Z8CyCeeeNoODO19umu9eWchgdegPp5fvP1PvCs5QY
         daXe5GkuVsneGm7FI79DAVIu22Byc9uGlHljOFXipVsuc6WbvqXPOj9IXNNrzO0cw8DN
         wQItj24dDuUKxLv5OBvyGxYTKtBJEmIcvoifm3ph9WVHLUTWECVY7J9JpPhm96ZRRxpT
         DZjTIZfU1S769TeaTXSnRwDUetcWTW7wxflEbD649X2pM56jUB89PxCkcmKlYKy4Ch8/
         gDZw==
X-Forwarded-Encrypted: i=1; AJvYcCX83kNleL3OOhkgH2gVtDn1S484o70QIGPujdVOdoVLen22tGPyRkquc1QdMOY2etnU+p/s8s23aC/sw78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHucdKs4Uh+zkdxAAv7mWMTlbIq4s8nFvHUhDlqEbEvFH/Lkx
	i98OOiuGs15EZR8b+qb70+j1nNaaeb+AgzZB/gKAuX9MoZoDlNvqff5AOeDmYNCjfVAB3r5MtEZ
	kpaKFKYeqhV2kARqBcl3YraZKWkk=
X-Google-Smtp-Source: AGHT+IFSL0Rj2MGxaQdDpfRcJh1RqKCazURp/EdKotRxtFoL7va3TLfHDNwmtxZ40d5yFwAeV0F9ZQMKfhlNCRAmLi4=
X-Received: by 2002:a50:954c:0:b0:5cf:e43:7695 with SMTP id
 4fb4d7f45d1cf-5cf0e4377d2mr2654802a12.11.1731103942600; Fri, 08 Nov 2024
 14:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <672ac50b.050a0220.2edce.1517.GAE@google.com> <20241107142335.GB1172372@cmpxchg.org>
In-Reply-To: <20241107142335.GB1172372@cmpxchg.org>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 8 Nov 2024 23:11:46 +0100
Message-ID: <CAFnufp3u9ytrCCN4vBqjn6SLGK_h+ue1tH1E_wRTw3s3ELf9ZA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] general protection fault in swap_reclaim_full_clusters
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: syzbot <syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Kairui Song <ryncsn@gmail.com>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Luca Boccassi <luca.boccassi@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 8 nov 2024 alle ore 18:35 Johannes Weiner
<hannes@cmpxchg.org> ha scritto:
> The syzbot console output indicates a virtual environment where
> swapfile is on a rotational device. In this case, clusters aren't
> actually used, and si->full_clusters is not initialized. Daan's report
> is from qemu, so likely rotational too.
>
> Make sure to only schedule the cluster reclaim work when clusters are
> actually in use.
>
> Link: https://lore.kernel.org/lkml/672ac50b.050a0220.2edce.1517.GAE@google.com/
> Link: https://github.com/systemd/systemd/issues/35044
> Fixes: 5168a68eb78f ("mm, swap: avoid over reclaim of full clusters")
> Reported-by: syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com
> Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/swapfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 46bd4b1a3c07..9c85bd46ab7f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -929,7 +929,7 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
>                 si->highest_bit = 0;
>                 del_from_avail_list(si);
>
> -               if (vm_swap_full())
> +               if (si->cluster_info && vm_swap_full())
>                         schedule_work(&si->reclaim_work);
>         }
>  }
> --

I've tested the patch and now the oomd test passes:

1/1 systemd:integration-tests / TEST-55-OOMD OK               63.48s

Tested-by: Matteo Croce <teknoraver@meta.com>

-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

