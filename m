Return-Path: <linux-kernel+bounces-228577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EB99161D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8471F258D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0C148FEC;
	Tue, 25 Jun 2024 09:02:45 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FE146A81
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306165; cv=none; b=Jzgvrmm78/XjekatARVNi/TcKKxLHTyq0CUTnupjVRofsvFfwuikYD2AcOReciiTyOcG+w04yCpVAhi3+WJI/R0Yoni37lB28fr5iUNQG0jHvwi/Sztt8fDF8L16kXYXroE0iSv4y/ZIGvYLP9wvI2QDb0VJzCVhtaX85l27zJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306165; c=relaxed/simple;
	bh=gK1X5Yke3vjg7mc/pvW8oyjgI+okqIst9UeOYvFRaH4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G3hJ4DujnmXY/OhU5UJqmjH3BInPTm+fhYOjUcMUKB1pMDHC0YMFnD+vqVWyCs5U/7uNH7jLKwgBwlmcDTIXJWXq1NkmIXqslI3Eth9m3ztRFpYWdOFoBLDfq02i8ZcEdnPxHzPrYEsw/NOlH3sVIr5Okjv4Xv1IuW4NPJl+5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ebff1004acso651120839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719306163; x=1719910963;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK1X5Yke3vjg7mc/pvW8oyjgI+okqIst9UeOYvFRaH4=;
        b=ry2RxcXrZcAcBx1Pij6KiCTywtl5SVhrnEtLgtgdj/TVKk6iRclOiidrn+jGRihjto
         PwGhmVsNg0hl6Bx2ll4t6Q74zMg5S+rJ0duMbbStNw9HDmOah+TqFuBEwel0CAC9+zQg
         rurniwWdqKdKpwSPNlqyNVCii0XCdlAMovoUb58tTIHcGhYnRi83QbZ7yEh94Jom8KRv
         nUxPqZieJOdeZv3VgID5C8AaMBmFq8YZTlfu7iQ2x4jE2XmQJ1D9Q3VWuOoJPdyWiOya
         dche42bd2oG9oCF8pJPRFcWUrO6w+xhrciasAatcA9/sL3zUuJyzlqbEjJx0nBsGOXT2
         eqag==
X-Gm-Message-State: AOJu0YxeXhBYSuEj1q+PhQi66w8MylPWNGHEdWVmRPxemPly14LAHGgV
	AM3rrBf8Ly5xV+wSPNzatXEuOd8JfAfqbYmSRgkJcZZCVYEK9qYr1dl9F/kv/xieHq+M+pyba8D
	yN0izHYUMOlkkO1j8KuErksYnRhKqoSxDgRz+jSAP30tsjNMlQHTa1YU=
X-Google-Smtp-Source: AGHT+IFheV2aaL9R3ctVELdCd9ZwIljAabye+CPlZE8AHadmTaXjxFggNc3TRWVKuKbgeCQ3j9UwcpopPRdUIftnFuNT6l5y1KTW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1582:b0:7eb:98cb:d769 with SMTP id
 ca18e2360f4ac-7f3a75f48afmr18334239f.3.1719306162677; Tue, 25 Jun 2024
 02:02:42 -0700 (PDT)
Date: Tue, 25 Jun 2024 02:02:42 -0700
In-Reply-To: <000000000000051b2d06189716c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001640ac061bb3296a@google.com>
Subject: Re: [syzbot] Re: [syzbot] [usb?] INFO: rcu detected stall in
 schedule_timeout (6)
From: syzbot <syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in schedule_timeout (=
6)
Author: marcello.bauer@9elements.com

#syz test: https://github.com/9elements/linux
patch_dummy_hcd_hrtimer_fix

On Thu, 2024-05-16 at 15:01 -0700, syzbot wrote:
> syzbot has bisected this issue to:
>=20
> commit a7f3813e589fd8e2834720829a47b5eb914a9afe
> Author: Marcello Sylvester Bauer <sylv@sylv.io>
> Date:=C2=A0=C2=A0 Thu Apr 11 14:51:28 2024 +0000
>=20
> =C2=A0=C2=A0=C2=A0 usb: gadget: dummy_hcd: Switch to hrtimer transfer sch=
eduler
>=20
> bisection log:=C2=A0
> https://syzkaller.appspot.com/x/bisect.txt?x=3D119318d0980000
> start commit:=C2=A0=C2=A0 75fa778d74b7 Add linux-next specific files for
> 20240510
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-next
> final oops:=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/report.txt?x=3D139318d0980000
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=3D159318d0980000
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3Dccdd3ebd6715749a
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Dc793a7eca38803212c61
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.syz?x=3D16dcd598980000
> C reproducer:=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.c?x=3D151d9c78980000
>=20
> Reported-by: syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com
> Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer
> transfer scheduler")
>=20
> For information about bisection process see:
> https://goo.gl/tpsmEJ#bisection


