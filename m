Return-Path: <linux-kernel+bounces-410790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E2F9CE0F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF735282F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310461CDA18;
	Fri, 15 Nov 2024 14:11:16 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832A1BA86C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679875; cv=none; b=fkM+LUr5deNG4sYSu0NEsGnPWxzdfIjGimfA59Vsd7YXyyquyTTHBlwxPB+mAq5dllw3ov0u38Uh6Gbpu1ByhMOoP0GnvGg3+XOuJqJ/49TOME8AK1+YTSijKsSyWugA1XpnLMWch56jqtZESdHjI/pmQx3xbYOheU1U4hGC1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679875; c=relaxed/simple;
	bh=lv3007Jwe6szzwK3Ineb2yF+RPJbDYTYHAGqj80Akw4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=sbgHwdfZo+LxiqheXiN1juYSCkEwwJgqzivnJOyASTDFmzeocqmeiiNKu4F8MfuhEIlnU8cs5Zp6d21Cl2Y+VF2wUmOu3fl0RAt5ZVwP1NCxIpSycwGuypFERe18FUyzSJh3PDyXTZHvW/dD/PoK/hAbXk+GJjqNO8eot8MvAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b963ca02so7655535ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679873; x=1732284673;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ul7J8wvAu2BZqJVFr4I3MeNSMoxisq4JfNHuKXm1IHU=;
        b=Zb6bLiBynIQgsgQesDfWwUnLYHXHGZgijw1s6EIvMjz4uT/Fbk4nMLoUPasKMx/DQD
         ZWaMU2D8LoWtDzg2erbZUrBbsirE3EvMtWqvYx838vAo0qrIQGrNP0Wq+bvzIbJopW40
         XxneLqgMW0en24r+xBvXI5HqPkjOHSVigfGRnc4nepq0dRCg9n6cAOVRAMiT+XYf8xDg
         THyngjlCkURMj0WCIpuEI5S0oNAkAhaeQb5fKvr3yzUb99Fq+zfUOUrzLZwh3wbstS3/
         299cpyR01ryrIbbwF9obFqcvgXa9Mb2N1V5M6ZzrW5gYitbqzuBi4Fw8gVq03LVLJvjw
         HnMg==
X-Forwarded-Encrypted: i=1; AJvYcCXl9v9DjwHR9WLAiH1caWmuEmrcASF8xjFFFvU5ZVBKdj+PTnsAdMgAk7MwAy0k/xtobc8+l8fU50foCjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLsJ0+yuSfT9LHOem/FL8inVD3VBEus9L70FTvSgbLv6aeyet
	K+8suDesHGZItu+kTEZ4tyJ25z/n/bdOltTGQwbDVlETieYSmEAVqoodSls3ilpM+hJnQ5voa6K
	c2APpjLg/H2IhvL9jAXo8fz8Zp9iVKKdKRZajhIqk0Al8K+GQKM20e70=
X-Google-Smtp-Source: AGHT+IFfrju2aNBPaXrGdqtc4H2UqZc/ckvDgjgC8JieUc/1cskWfs9fHqxKMP4Aa5csTyASxlWycL3ozXfcjBA9xOgBvNavQkkv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218e:b0:3a4:e4d0:9051 with SMTP id
 e9e14a558f8ab-3a74808cc3emr30100305ab.24.1731679873195; Fri, 15 Nov 2024
 06:11:13 -0800 (PST)
Date: Fri, 15 Nov 2024 06:11:13 -0800
In-Reply-To: <PH0PR11MB7496D8FBFAC72061A9C5F07CD1242@PH0PR11MB7496.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67375681.050a0220.2a2fcc.007d.GAE@google.com>
Subject: Re: [Linux Kernel Bug] memory leak in ubi_attach
From: syzbot <syzbot+3a0f6c96e37e347c6ba9@syzkaller.appspotmail.com>
To: sudumbha@cisco.com
Cc: sudumbha@cisco.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git<http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git> 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b

This crash does not have a reproducer. I cannot test it.

>
> ----------------------------------------------------------------------------------
> diff --git a/mm/slub.c b/mm/slub.c
> index 5b832512044e..dc77128358d8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7098,8 +7098,11 @@ static int sysfs_slab_add(struct kmem_cache *s)
>
>     s->kobj.kset = kset;
>     err = kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s", name);
> -   if (err)
> +   if (err) {
> +       kfree_const(s->kobj.name);
> +       s->kobj.name = NULL;
>         goto out;
> +   }
>
>     err = sysfs_create_group(&s->kobj, &slab_attr_group);
>     if (err)
> --
> 2.42.0
>
> ----------------------------------------------------------------------------------
>
> Thanks & regards,
> Sudhir
>

