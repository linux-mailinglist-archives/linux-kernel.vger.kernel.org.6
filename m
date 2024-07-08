Return-Path: <linux-kernel+bounces-244192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABB392A093
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B6D285607
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A2A78C6B;
	Mon,  8 Jul 2024 10:56:22 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398617721
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720436182; cv=none; b=L9BhJ3KxGSU3CJEL50hwjESo8ktCIjspXYuKFq0Cte83+EV83CK4llP/CsDOE9TrAIgT9NObqOU79OF9hKJAdbXp9nPMapN6vDpKrrAEYGmlUzfyr+n9TyQkTkIYyPNR/5kBsXwS0Lcmb22YBdMFkKm7LJpSdLs0kLGh0s0SWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720436182; c=relaxed/simple;
	bh=Of8J21b9uvvAl/AlOsz7foY2sVQhphQEiZNlnPV7gzY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qdWY/q/pZ9T0MDSMOXn1DihkdxDzG2/Ujmflv8i5n4DmlhN0FmFk/cNFyY292ep/DbXUmIsPLMc/eqmqUtuywlEAJaFkhwR7PRdB//Fq+CtJIVrTiepOhia9KbTGw8r/ZZjsmj3l5xVU+TsLenzt/2Ff5CAlJ2TWTTKeT19hj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f95699cabcso173123539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 03:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720436180; x=1721040980;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of8J21b9uvvAl/AlOsz7foY2sVQhphQEiZNlnPV7gzY=;
        b=s/zyMhCZ8ZztRCmqEDH6S6XyVGXSRVdT10lKI9NUW4nIkUqSNPNdHHQdCIkAYeEHBX
         cCgrHem3K7i+zH3cZlS3Tbh61ECijxmUNGF1dVrBCMpgf13mo7rPPHEKp0fkdkinaYce
         oU5BA4dW62GgIA98R5R3QMAJilg+WqCjbY49EPaD6wfPFcni/Y/UhHInSo2AjOzIrze/
         QXqfVjk8OCdA1TpNKelptE3USiFutABLsLiE8sU5h41c3P38MsAgCNTbmxTmnMOtqNm4
         gMYU1Y98AwWlcbJ+X94UkRN7GR00fVpDiesB/aYJ+/9Xfgz80FKCSu6yMuZL+5WMQaFq
         ts3A==
X-Gm-Message-State: AOJu0Yysqfalbayf3gyqW+BHE547GrlyzEd3zQ3Rn5ImrGMkV4uwDBYO
	Yly9L+DLHxUcq7CEMkritpfOZqrvLiPHNC5N4SMvX8bdXiDSP+zACIuAVSc7w7XHRTr7rMmgJqa
	gu0JKa+4RC3bCt0vUzOuQn0IB+83tn9MFuR1pALReq+kiFFrmSFjO5jw=
X-Google-Smtp-Source: AGHT+IFfZl6F5msn0uL8iDuln4iUWl52gS+44Qf25qrxYmNe4N3zH+FZ3HZOiIy0MYaOYxL3cBfAYsdcf5+nWVIu43Vbr1zgUMb3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35aa:b0:4c0:9a3e:c26e with SMTP id
 8926c6da1cb9f-4c09a3ed314mr223597173.0.1720436180090; Mon, 08 Jul 2024
 03:56:20 -0700 (PDT)
Date: Mon, 08 Jul 2024 03:56:20 -0700
In-Reply-To: <000000000000051b2d06189716c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f9210061cba438f@google.com>
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

#syz test: https://github.com/9elements/linux.git
test_patch_dummy_hcd_hrtimer_fix

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


