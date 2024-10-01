Return-Path: <linux-kernel+bounces-346588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A6C98C643
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB38282D63
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4071CDA35;
	Tue,  1 Oct 2024 19:50:13 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F718754F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812213; cv=none; b=O0is6c5120Kd3wxepFe1go85PrTAbSZVWrnmmbTSBMrf0baubvw6bJQ8MXNXeGEIsdExPAVAugCCN/v+0GBkauyelbik8Aierdc4N+wxfL5FrMyKU1hLxBKSrhzPX2Jei5n9fx3/QWVm8anKctpBN5sLa1UQdS4x2X3yMTStZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812213; c=relaxed/simple;
	bh=NofxnHHE1OEIpHM337PlYpDvehTAntezbMq7Ut22eWk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xdti+/sZAm6e/IhDjd5LC9ymvY7d7g3X+EIFka1NdwbRAEU6x5A9OPPLmhAnH7fpmAukl13OEnSi+HZt8AADymqURVL6KiRq346JWx7qhdXld46KFdvLc+CWlftQ319Gnu8Uyd3zOUvJZytUxEw0szSP+bDCQc42rVeqvpdbt3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0ce4692a4so1780315ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 12:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727812211; x=1728417011;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BoQ32fk9hZansdyGk89dVZCOfWCc/liajL4Jhny+SU=;
        b=Nvk5Mlp5ukvsid6hPmaaMimaQteWItbmwXFuPI4hO5m824uwxZc6u+7E7AdsTHG+cp
         f0oLiH8kBxJ8YLFHx6+Bj5r+E5yOgXLE1laXKqDHZW3R1+INmf15NjnyqBL6VoSF7Lki
         thWUFK6X+rs2P+zMSdGMMtHbRkoqKzw5mfxAdmKX2qnpfCKJvhUmj8YWDU2GMcZe3fy0
         J86Z8fwrsCuBlrReI5txWHFXqar+qRXGJ9Xl4ZzWZjAv9eJIl+4Uk9baXgePhLkjInbn
         6yX9TSqbqh+U1wmo3o2w54O2KhhSQFtsOMXt24t0bhzgvHbypWyBOpZ8wW6Lx1A0VD97
         0+pA==
X-Gm-Message-State: AOJu0YyBbsRSd/fTT3egFH3MvyCgyKuiYM1pa4azo87Gn3wwHfJp6Pdh
	5vJqdibJLyJTT+PznAbvMdYKGzkbKwLhYqAMGwX8YZBuQsKnTRmMgbki743Pz8TZUfHOcskZfOl
	5HAx/AGrQ2zTMJcF9Q/AwG+J5/1Bc5F98ercmkyszFkZ2+ygrYrSjDec=
X-Google-Smtp-Source: AGHT+IHjZrHxLtnoS44ou5LiOnrmPK0PvqfjyxPPlB4FoMiU7qyW5h0l6LEm9fiEBvZzEnZ+nHjbjMkKe3XIehDYfrWRh42p3rFx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a365619998mr7099055ab.6.1727812210767; Tue, 01 Oct 2024
 12:50:10 -0700 (PDT)
Date: Tue, 01 Oct 2024 12:50:10 -0700
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc5272.050a0220.f28ec.04cb.GAE@google.com>
Subject: Re: [syzbot] Re: [PATCH v1] Bluetooth: SCO: Use disable_delayed_work_sync
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [PATCH v1] Bluetooth: SCO: Use disable_delayed_work_sync
Author: luiz.dentz@gmail.com

#syz test

On Tue, Oct 1, 2024 at 3:48=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This makes use of disable_delayed_work_sync instead
> cancel_delayed_work_sync as it not only cancel the ongoing work but also
> disables new submit which is disarable since the object holding the work
> is about to be freed.
>
> Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d465
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/sco.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index a5ac160c592e..f0604d7834df 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon, int e=
rr)
>         }
>
>         /* Ensure no more work items will run before freeing conn. */
> -       cancel_delayed_work_sync(&conn->timeout_work);
> +       disable_delayed_work_sync(&conn->timeout_work);
>
>         hcon->sco_data =3D NULL;
>         kfree(conn);
> --
> 2.46.1
>


--=20
Luiz Augusto von Dentz

