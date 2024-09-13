Return-Path: <linux-kernel+bounces-327849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14231977BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E1C282BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3793B1D798F;
	Fri, 13 Sep 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/WM/87y"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBD11D7984
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218528; cv=none; b=scW+XT+FLr/Vp8l19LSoD2RLx0r6I7Hwl1hsg6CK+olKYHHT7t87GUmZDeM3RD23loV1gFmT0edpKBDPAlCuTmHMtATSZ4Mikm6gQMGmBkeS8gzoIdIg14ALMpTax8dmv/OeQ9ORB2l+olqb3MZK0qdTT98QeZAc5Rzt1HWvlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218528; c=relaxed/simple;
	bh=gUf1P6a051fpQa+Zsx4o/CGIDi47nKng+PxliLFNe8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzeUO24v2Bq40PyrtNrstwBCRn3zmg6YsSlXNmQhsUPKf91hY6bwkw3tiWVEGefnTB6KW95+WNbOMrbMnXEUp9Y2FEXEx1K0aDwsKa2NZomPp+PvF65TzyRw1Tk9Fr6XVBsx+HJaL98L2i6vxu/W5G2aaqZ6Ewg6BweoVamPW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/WM/87y; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32971cso2351520a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726218525; x=1726823325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=if6lVwBQ3rYN29cQP9B8Wl2cgILO0Izj1asDZSpYXBY=;
        b=C/WM/87yoaDU/19p66AEaOh1TG4HZ79GogVWo3iZwG7abjhkQJVP8ZFN6JaC+7ViyH
         5wv/z6IYJuv8hCdbwrtGWkaUuHbsPjbu8ppOjV6T0cDD5vvxdZaEQdruKQTbPdcBDVhu
         UoIC08JXAmXgvd3w6Du9tl8+Q0UBQzUoqnhLSp/mqP96HwKrMPtX08lV8BKQMGRqvE3g
         A/C/h/6VWLVGR+gy3m8Gqo/WrxhDOIp9EiniFE0h9YduKfJM1oifgFhNfvTkMOcEfoci
         EncgFnTMD3iIm35Abl0vW8kk97bz3Cj0x6otmW+L23mgoJk2IlBpHKbZBbUt5h3+qxxy
         KwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726218525; x=1726823325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=if6lVwBQ3rYN29cQP9B8Wl2cgILO0Izj1asDZSpYXBY=;
        b=U503pixHVejtZR9ZRhm1kQ+LKfEVWOlL1Yb+z+B5mtNyjDlAUJZzf0SMgkpJuFB2V2
         CyVwI0Ftn36HhefDS8swo6Ra7vquBzG7SGDkeC5pcfl80wq4YLmwjJ8MOvrG2/Kt5o+s
         sMCPT6uL++FXhjN31npB+wXyvpfLdJN2Dj7tAlAcpheQvX8q+aa09epR2ky4Q1e/Xblh
         sRW/UexJSkxaX3arHj1fd9H4NBpS5vcoeY24Iq6OmgEK/k03ADksZpIAYzp6E15Th5rE
         gF3o3oV9yNqrNjtNETF/qGB+ePraO0OB5TvLt0IXeOaJOmqVzLIJB+8C8f3SZm/Mj74s
         ExcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK3MxvXKr8CCKGtDqAd4qGA1r3/okZelvQFpEPhSeRIf9An1JuqnxjRdyBn3d2yk7h7mLUWi8MGJ87yJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy3cqspZKy5cdmiu6lbhydv++a2fQk+NmQgHcUTUUJ7JRjM9Si
	7LwZ9SEfcmsQBURUOF07+3oqRnEhBTk7eiYzgTAy6UZdM+7ZSwSt/KuNaA5tCK/fp3Ni8umU7VG
	7K9C9Yh1TdTVLaSMtxWxynTAnh8mGfvZ+A4sM
X-Google-Smtp-Source: AGHT+IEp8fqNCUqCMu3S2VVPPVgj29Eg5Ceh1YsoPj1klDAxZJW1PBj/acrZ8GrRoLISfm8K+ddcAGtOTLtR5KhCm/U=
X-Received: by 2002:a17:907:60d4:b0:a86:a56d:c4eb with SMTP id
 a640c23a62f3a-a902973187dmr559124966b.61.1726218524456; Fri, 13 Sep 2024
 02:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000005348f9061ab8df82@google.com> <00000000000011b0080621f73dd2@google.com>
In-Reply-To: <00000000000011b0080621f73dd2@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 11:08:31 +0200
Message-ID: <CANn89iL0eakKDx9WvrP5zmMJV6=N75PAuTtDx3M=VfUbpXs4xQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in neigh_timer_handler (8)
To: syzbot <syzbot+5127feb52165f8ab165b@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, marcello.bauer@9elements.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, stern@rowland.harvard.edu, 
	sylv@sylv.io, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 4:47=E2=80=AFAM syzbot
<syzbot+5127feb52165f8ab165b@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 22f00812862564b314784167a89f27b444f82a46
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Fri Jun 14 01:30:43 2024 +0000
>
>     USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17eae0a998=
0000
> start commit:   dc772f8237f9 Merge tag 'mm-hotfixes-stable-2024-06-07-15-=
2..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D333ebe38d43c4=
2e2
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5127feb52165f8a=
b165b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17398dce980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D112fa5ac98000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log mes=
sages
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

#syz fix: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messa=
ges

