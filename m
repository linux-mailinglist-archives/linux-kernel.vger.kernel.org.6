Return-Path: <linux-kernel+bounces-292622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C1E957221
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90E8B2DC4F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCA18B495;
	Mon, 19 Aug 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oo3JYXkh"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4813218B46C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087749; cv=none; b=iVBUSNlJh07bxgeTCQ7ovitLtaqgTCsY+TNEJEy3UrXSccxjR/wSGi+o6oPedZf8XtFkYxWxbeDgJUic16ogYGlvr5rGiajRJVsKzby11jseOK/EuBp9UjClFIeD25hQA2H72kXVIWqz/3E/rPvo0BW9bImdUoK+L4luvYOGqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087749; c=relaxed/simple;
	bh=a9rr8Zzfaj6zR+sz7AUJcd59Kyz9qMEm5GJnXatsP/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ho7KTzXkchCSd2QO16nH/zikUiNIKI+YA4u1/uveT+NMLFJYRlEkQbuhPmK6t2kNijCIwM3WQ58UarKsYPLI1m15Mwkbw7Wd7BFqtFkO1YSv5uH5tn5jeJYfhYFXKJ4rxYLolcnjv4mvcGTguQX2i06dqiP7BzPmNzZHnhpLcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oo3JYXkh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52fc4388a64so5907164e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724087745; x=1724692545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGFAUwiyqzEsxE26Pwxg3nLYP/NXPqeq8pN8cKZ3Iww=;
        b=Oo3JYXkhMjvLaf0YkaAcIXACGXCuhtJFVQaFlDgvOX+mytrqPZlwm+f7XLpU+LOv4c
         7wyw4EuAZ2vF0gTC3Vjoq7PkXe/0Yef/eQZOcC+ykJhM33uk3nqZSKhXW/okLAVTqNIb
         BZiPm7aLbc7F8q1mCwvuxzKrBoqTa9shu+eViJdF7MQl5+p9sS0nAOgrx8Nuo/4uXAiv
         LTxv3htF5VjYT7KVTd2+IBRtCd44S/13rwsQs8mLNfUAOypob57+Ptfrn8dDo/RGLRA0
         YrTyAiOJOFm8KXkj4Sf7DoLUKTJaNq3UEUIUchH+YaocWETGMG19MyKLnb7HHd+wJq3Y
         2RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087745; x=1724692545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGFAUwiyqzEsxE26Pwxg3nLYP/NXPqeq8pN8cKZ3Iww=;
        b=jPGSRiL1OUL8hXRLaSMFD0LrbWNH7toQ0/iJoixuFKpn2Oq9YdxAxmQd5w+R/ns8Jx
         YmYgYl4pZAwkg3JI2jDvCGNaJum5Rgp78kEjkHPmdL664/fI/SX8w4vrV2He/Yq51btx
         vvEXOOBEHsKJBdezSx+Z53emlc7Nb52JBkukAkQ9gyFABVa9hDWb/2RTkDBeO9LZncJK
         PIDdMMqOgWPSlDFcLij6Az1bgrowgE5cKKqjBXda9QUtDUgJ058sWz7W1bxZrEzq8y9v
         5mkBOuOqiCxz/XSIA+5YZF81AMxN55bswRDJalbefaBKfdAPKr3KuSVQoSeqoQDOq0Cx
         mUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH2GHY/XLoiaIztO/EUYojJ0r7c7Z4UNPVLNN7Fy5/o0TwhBGXEhz/LFcnAv4JMeZEX8l1O6ka8raOhunvSVK4avoru6A/nCyvIV43
X-Gm-Message-State: AOJu0Ywl1X6lQ+g0XVNhfSokVTv+bevzcba8zGc0pPWte/1IXxJbh3BM
	gHnt/k+EGoEqk/mUAgiahKquIlBJ3s5nL2mB43TtEyWQYYKGCG87AYbYmWvcXBO6GL7MT/KriKF
	yPCq2Ax4J6aXJsyZJOrKOG9j9ZlPukxTvQJg5px3ba2/RIhVS3V9d
X-Google-Smtp-Source: AGHT+IG3RMSvTLr5DD7i3LgrwUZMDv9J+nc9wOhmqtPdDc6nEMnVt8MCjLw3hxdwcpq9I4ecKLq2S5tT7JLavdchNC0=
X-Received: by 2002:a05:6512:3dab:b0:52c:c5c4:43d4 with SMTP id
 2adb3069b0e04-5331c6f0065mr7523990e87.53.1724087744655; Mon, 19 Aug 2024
 10:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004fd05a06200be9c1@google.com>
In-Reply-To: <0000000000004fd05a06200be9c1@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 19:15:31 +0200
Message-ID: <CANn89iJF2TtaF3XBxGXtRQ_ek3RKSL5HWzVrb6r0PvZYVZwUUg@mail.gmail.com>
Subject: Re: [syzbot] [net?] Internal error in sprintf (3)
To: syzbot <syzbot+3c22895086835167a3ce@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:36=E2=80=AFPM syzbot
<syzbot+3c22895086835167a3ce@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    47ac09b91bef Linux 6.11-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10f4843998000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2b3e97716aa87=
b7b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3c2289508683516=
7a3ce
> compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (=
GNU Binutils for Debian) 2.40
> userspace arch: arm
>
> Unfortunately, I don't have any reproducer for this issue yet.

Stack overflow... we might simply reduce XMIT_RECURSION_LIMIT from 8 to 4 ?

