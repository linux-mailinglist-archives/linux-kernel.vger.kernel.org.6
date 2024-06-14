Return-Path: <linux-kernel+bounces-214486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE9908563
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81AEB1F28D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E93157A43;
	Fri, 14 Jun 2024 07:55:42 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AD13B5B2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351741; cv=none; b=RKWvJtf1xfIjIDtsD699TMFWElLeSzEP6JdqoePqTXcsQTSlb5u1OVcLv1H5OCEwYGkSwfjeec5BiFwVAb8I0+p/07nvrAdCvZyHWQSiJ5Efdv2aQx/dVDohG4fZ89g1Y0FP04UUWmZiyK0fX95s9MyexF3228XGgLc6CpA7XWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351741; c=relaxed/simple;
	bh=mD1eNKj9xJJkCaDuwrzsb0YBR22K6yh8imL1FcsgBPI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q1N00ZKf74YYpGJmD1SKlvLzcvxoHrzwmoIYo45yq3DoP4hMePsXQ5TUxqevkiyFC3M9J1yx4AsdbvQA0KV6mC3Pl1p+QHAdAPrq2iYOiw6Z9MwgXSgxPzpJ+jqhj5BkC0+T6iCQJd5fnRudDl9FBmVrDSK0C0aFk/Xps4C66zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3737b3ae019so18309295ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718351739; x=1718956539;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD1eNKj9xJJkCaDuwrzsb0YBR22K6yh8imL1FcsgBPI=;
        b=rerV/RZsJS3qjFCtx3Q+fu2xpej7DGrtaGXomW7x9TpNJk/TAUEH/VePe1R3Torfb0
         xBnoEEvzogvRI+yWaBQlEMZ7aQ1Zzr9gJwFQpWjlr2RRQ5H0uhVaGI+WVIY8JytUlPwT
         L4Nt6MTZifnwuczo2Wr8WvaqzaJQnlMB+jsB32UzvwwFMinbQR1mcXplY+OoUwDW+Lh+
         B0Tgii2ncjwxRe4vu5vvlNy+Ke1A5Fo+ATY4L1QZDuaVdJS/4Vq5jajBQupHnn4DO8If
         aOuKKdd0PmMK3gUaW6Lw22nRzFOuRoVfOfZkciLtB3VJh9fWaGHDLwvJC4GkO04RdX88
         pBbA==
X-Gm-Message-State: AOJu0YwMS6QjxF1gSP8ZOKgFsN/XRzQzEx1lZnGGm8nEclqzaZmNo4PX
	LEEco6Wt/StOdr/gqsoe0tk73NPN3iaGMQhhuZmPXanacNMg3brPFqwdJip5oJZmGVkMM4+/OYM
	fVsjlKCk61ENVkWFE1aiDoRIvcWSXfUuZegJFpzdtP3dKZGMbvvdrntQ=
X-Google-Smtp-Source: AGHT+IGjTfF5IbeNuF5WTC9NmkxAGPcnRW3T31AKEXxiO02EHQqQBRCsStJ2WUa0I/IZbU5ycLPm2Ddvrjqv6XXpwrc79NAsba6u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:374:9a34:a0a with SMTP id
 e9e14a558f8ab-375e10b26a4mr757885ab.6.1718351739153; Fri, 14 Jun 2024
 00:55:39 -0700 (PDT)
Date: Fri, 14 Jun 2024 00:55:39 -0700
In-Reply-To: <0000000000008312ad06163b7225@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000030161061ad4f1e7@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_loo=
kup_percpu_elem
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux e=
478cf26c556e4ab572ab0ab2306c986901dcd61
The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

