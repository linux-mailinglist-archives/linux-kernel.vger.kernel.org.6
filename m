Return-Path: <linux-kernel+bounces-226414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A450913E0A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27631F21C66
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA76184121;
	Sun, 23 Jun 2024 20:25:45 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0549B1CD25
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719174345; cv=none; b=u/vOFo72xsy0aza1NG6dzaClroiIb2WtcBQ9qb8Gl9284fXzPezly3lYgu7wD0RyFokZ0o4ZR9vo6YfkVa5G8+QMDJmhUBmfvNmBEQAFYpngY66cruZTmWdVevlr39qCLDksm0CWNHV0ZTTx6d0ij+vE+R21khJhiaGmOykuhuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719174345; c=relaxed/simple;
	bh=tX5sFtqxeCHNT9BDOJBmciMQ3RdN9xbf2FmF0+2j/Zk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Ze/GpwyjOcFfDbWIlZP+dtMxFzavBE6tDPFBblhne21ejtVYUHt32B2lp8hDRGnsDnfkvBnNx8KeetgAp9SjZeLGs/mESHGJ3RBRCjCUS5Bu2JtgXe38c//Grh9ccwM9t08HsotvaMwXCHvUcan1I992n8wSrqdozrXRZAzm3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-376229f07a8so37297235ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 13:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719174343; x=1719779143;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4oeySFTSDG7xx7hKelNchcQLqk91D04mjP9rlFYcUc=;
        b=vdNoOt7uZqg41Nv/RzbO7Wee9PGrSCrTYTEKS/HN0yieeFyjPIa2tqylcgN2OrTe5K
         oZBGlIAl8Tgvm697K6k4I8CQL35cZ/Aor3+VV4U94cmAgvArDUdaUwnZBAHOhSrVnmSU
         o05/kxjPVcdJdqM8xIHmv0V5ITrJgbXAec5u/nBcGdbKmfbrXRy29BkWrL8LTjw1cuVc
         DlQWWpDHQFPulr5YjbdV8l9y2zJ06/Sx6ovRLQwPgmoU7W6yp6Yzy+krKZyMhqR8BKX4
         BigEC+8fWD7GitJptTBvzjFsjbvZBQDK8rnT9eebmg0KyrdGAdB6JDqp9K7lDqiDA/md
         kGqg==
X-Forwarded-Encrypted: i=1; AJvYcCUD1zDq60QuFIH6j2XOulE4zHyT5f/yN4Ex4jRvblZHRzTIjDvsiJ7DIQ3b8K43u7gha8Vaqpz5IrqzKpxvqQkUgo/ebzYUWcqO3kBk
X-Gm-Message-State: AOJu0YxwADd4p+xxrR+Vb7tluShgpRz/wVe9sXVUk0SomEDxYa37rzhQ
	wDN9cE2fN7tRhCgX+1BgWRKpo720jw1Q+a5cK+2fKSkQJYlk9WBoUocofByhJQAnj2/BKilwApl
	xjqMvG1WkbOrkDZKQ4/Bo7MvBkkcLMt6uYF/NX8VDngr9NGKPRCjBK48=
X-Google-Smtp-Source: AGHT+IEkSdRFgHbYAe8Shq3M94AFG/JL5F87uwyv6AYpKRdYo+ILPzjDTf3St0SlaKsP8jEP6aLh7XjNi0ZqwgPNoiV4swqLAhpm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b21:b0:374:a021:f1b2 with SMTP id
 e9e14a558f8ab-3763f7424b5mr1810525ab.5.1719174343223; Sun, 23 Jun 2024
 13:25:43 -0700 (PDT)
Date: Sun, 23 Jun 2024 13:25:43 -0700
In-Reply-To: <ae58eac2-003f-4d29-a228-ea9219ab24b8@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008f841061b947879@google.com>
Subject: Re: KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com>
To: jain.abhinav177@gmail.com
Cc: jain.abhinav177@gmail.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz=20

unknown command "testhttps://git.kernel.org/pub/scm/linux/kernel/git/torval=
ds/linux.git"

> testhttps://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=20
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git614da3=
8e2f7a>614da38e2f7a
>
>
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -1510,6 +1510,8 @@ static void nci_rx_work(struct work_struct *work)
>  =C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb;
>
>  =C2=A0=C2=A0=C2=A0=C2=A0 for (; (skb =3D skb_dequeue(&ndev->rx_q)); kcov=
_remote_stop()) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!skb)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return;
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 kcov_remote_start_common(skb=
_get_kcov_handle(skb));
>
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* Send copy to sniffer */
> --=20

