Return-Path: <linux-kernel+bounces-347448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072AD98D2DD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C9FB22B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CA61CF5FC;
	Wed,  2 Oct 2024 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8ufLG6b"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF33C1CF2BA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871298; cv=none; b=F4skc+EpZ6/zA0SovbwS7/ZQ+f7owNm2RCpw1RBz3Fe8lz4VHKWB4tkJCSQVef3+hC7g63/Ne/dNSJu9FzsQHCVCF8lG7ykWVZoRGPfBhPL55OmhDvg3yr39LY/aoIe4GJhHV8NScdXxgG+K//kJN3S/t0boUinlL1RJt3Zkxg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871298; c=relaxed/simple;
	bh=kn1Dd/px1Ixz2rJpunVYZIZjoaQqQeBetzzxg5CJq7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCycMxfl/WWuK5IxGkPDfRGIRYXq53rZdMXly88wbMGB5PzyRVt/rKJCzLcoIgezJeMC02Z5UxZR1ysPwvBaZwBV3IJ2xltZvbo/elaJVjHbIQv8oBPWAJHUx6sivmVKhfFoaacHD0S9Tm2MNVPQlQBkiv+umHcsxNkMe780sFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8ufLG6b; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5399041167cso5579895e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727871295; x=1728476095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kn1Dd/px1Ixz2rJpunVYZIZjoaQqQeBetzzxg5CJq7Y=;
        b=W8ufLG6b5d70CfvRQUM3lfDDxe0RMWyE0v7Xu+JFYuzH8mTe1EtxUXAWI9gYPeRL2v
         2wXp0uE5MZrerqytILYjIWJ8RqUrAf0BZdG/R1oHIVhrIvr+sZdARSuC/q2mBy5oeCVm
         QfIG3OhvJXyT5Q2vZPSuuysyrAhs7Rm09S7EJfVE0Gu+4VOQw47wymqdWHkYQ7OJW+E2
         fpkWR4U8chybhGyerafpn25R5REX3+IEmzmrUp3wHjqQqt0xO4UrFZr9sqFlfH2nhcGD
         XseFqcBB4yx41lgqH8VFLcJISDxv4ISuTS/DCgr/QUbPwJUn5HMsDamAL3aYFijLLoSB
         xtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871295; x=1728476095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kn1Dd/px1Ixz2rJpunVYZIZjoaQqQeBetzzxg5CJq7Y=;
        b=uZEiPrSU6XzCH2fb7QddYSSfqc0jlBTCsRKyNeXP8Y78JdWv52AJJWVHbE89sNJ6QJ
         ZSSgDgBi9Wgn0+MU0c1wT6rQ9poU28n19rog6QgvpiP3Y2fWZsAsmT+2MnI3uBXdR5Gv
         8wsbAfqviLP+Y0nlRCqJONUo6cvtnikU7/7rCamwMNqaaUaL61FUd52JdfNMjmFOxPIK
         D2ogdWiwT8Ib/H3X2KuT7A+EAVmKrUy9tMM74A3TsdXQxyaZNuRjlN0CT/0q4GgM2rg+
         soJE4yNZB51vFmf0YglC6icJQuQoQ0/4DmG6M4tSy4HmhG6M8iuYEKgY7epDviCzXWLR
         59VA==
X-Forwarded-Encrypted: i=1; AJvYcCURg7wuwGpoSdrCAqUXNeDDcO3zQcWBC3UfJ745s5zYZpKxy9KFnqtKsje6rjBxpGJiTCar9C90JdpTB3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT/EZogTJThksCzX/da8OGF9wWOD6QEnugWaHrKChc7YVHvSly
	EQsNOobl85Iaf7uSV+LgtcenhiDK2t/lPtyYhPAxcVaUNOZyvKxFaZ7Q+puP3ub9GxG84EPsdTK
	9eHazLRWl1WEpdjdIPawm94Bw3ik=
X-Google-Smtp-Source: AGHT+IHLZlR5sPbJi6pSFv/Bu4vFdjMUz0c0zKHyOhto8MlpSlYJUJSnjsnyEKOpWeVMTU84J0RJLmTQwxaVDlPHAZQ=
X-Received: by 2002:a05:6512:3c8a:b0:535:6a34:b8c3 with SMTP id
 2adb3069b0e04-539a0658927mr2649946e87.5.1727871294749; Wed, 02 Oct 2024
 05:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f8846e.050a0220.aab67.000b.GAE@google.com> <66fcd082.050a0220.f28ec.04f1.GAE@google.com>
In-Reply-To: <66fcd082.050a0220.f28ec.04f1.GAE@google.com>
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Wed, 2 Oct 2024 20:14:41 +0800
Message-ID: <CAHQche_ieCFxXP-ricwnVMiwwikO8LojWomH9=5eCJEfTm8wVQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] possible deadlock in upgrade_mmap_lock_carefully
To: syzbot <syzbot+a6456f6334aa19425886@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, paul@paul-moore.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

It seems to be the same as [1].
New LSM hook position for remap_file_pages + IMA = deadlock.
The new LSM hook position is added for a bypass caused by
no check in remap_file_pages + READ_IMPLIES_EXEC in do_mmap.

I suggest fix it by removing the check and moving READ_IMPLIES_EXEC
out of do_mmap[2].

Link: https://lore.kernel.org/lkml/20240928065620.7abadb2d8552f03d785c77c9@linux-foundation.org/
[1]
Link: https://lore.kernel.org/all/20240928180044.50-1-ebpqwerty472123@gmail.com/
[2]

