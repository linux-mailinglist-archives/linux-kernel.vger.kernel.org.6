Return-Path: <linux-kernel+bounces-276395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A3F9492F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814481C2127F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502DB18D65B;
	Tue,  6 Aug 2024 14:28:18 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E318D64C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954497; cv=none; b=Wba5vfmQzJ6wyxxHDYoy5VG4eJ6OZiRwMWnexW1/Uo0OftdNGD5ew3H4ug2hVcD/Smb2eaujpAfA1tdy3liVurQLMQ0BzjGREmaR+SvrU4yLuqHtbDocwoC3X+r1hxXGIRAplYYT0ew6NobVMGltoTMG8g6euqK7SCLn9Ye4xnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954497; c=relaxed/simple;
	bh=YuEzHyOwrCotlJYnPAX34kMLiynS52YdCJa52nTIBLU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MF4rTq4uAZ9wk8dnuDwYQTaE+LPFpgAKPTVD1qaqfGHk+VbrD6OKZsU+S/1KhHjnlBjunHZRyVMKt0I17aw3OMhMBbW0NBBsVtb6JfIaHdXeRyRHADPFftzHdvZDpwM3nC5+OP/9pzUsFVndW14NwB4XfXZbVGCeFlKQXSLpvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b3dc8cd61so10255155ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954496; x=1723559296;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yqshB/wX8WE1U9JQV/UjFjBkibixHjMuk3Xfmo5A70=;
        b=fiwKNLpzeQpKX6g14QJI2qe1YorBZM9D1CwqVO1Q7naFILUOFi48NvXdp99yMoMp0F
         wDemYCXay5i9bswEwaTss7+g2Q2k+uy8zYie1A7luaQHKgX2bosBnnS9pTuxbpoO4HJY
         eoDB7Kf8AxgjSjN9OrEy202mwrCP5ghesVLPawxtXsRBpnxWkqDhCFJ3rn9gD8ExzD0h
         j7Q6fBcT6aJ15ut+ilZhVSf2anL1ha097ZnKOQvFZnlUYF6NgzHU+sCyCnCh5ZvHNx1T
         wCCjPwjv+2x6Y3PGd4PTudVjoM9JRQukns87RtbI1mcBmRaNm08OiZjqVpyaaFABdiME
         II5Q==
X-Gm-Message-State: AOJu0Yx74nW2QQPbIgjY7xVbys+AFYHea7wc62GA6evVx1xTfo2h5CQr
	OYKWFmPARNoi/thayF+nzxUM6Ew3S2dbivphhXwOVAOFgVdT8xt/Lg89Qv/YvFI87kzLhNmLRGR
	VtyO76TEAd3OFqLEMOaj7ZaAhBGEG9A+EbfLZ5uLAeKgz/psq5qMiGZo=
X-Google-Smtp-Source: AGHT+IGs4U86NWdegcHT6uQ1zeLOd8lzwbx+Ht4yGlLCc9qPecf0mVS4gEQHjdw96AJnmmMda5AdI5sCzbRcVu7HjOvXO98t8D//
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d11:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-39b1fcb194emr9781865ab.6.1722954495717; Tue, 06 Aug 2024
 07:28:15 -0700 (PDT)
Date: Tue, 06 Aug 2024 07:28:15 -0700
In-Reply-To: <000000000000fa6583061ccb8e3d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae8596061f049afc@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bluetooth?] WARNING in __hci_cmd_sync_sk
From: syzbot <syzbot+f52b6db1fe57bfb08d49@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bluetooth?] WARNING in __hci_cmd_sync_sk
Author: djahchankoike@gmail.com

#syz fix: Bluetooth: L2CAP: Fix deadlock

Fixed upstream.

On Tue, Aug 6, 2024 at 10:45=E2=80=AFAM syzbot <
syzbot+f52b6db1fe57bfb08d49@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file net/bluetooth/hci_core.c
> patch: **** unexpected end of file in patch
>
>
>
> Tested on:
>
> commit:         b446a2da Merge tag 'linux_kselftest-fixes-6.11-rc3' of..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3456bae478301=
dc8
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Df52b6db1fe57bfb08d49
> compiler:
> patch:
> https://syzkaller.appspot.com/x/patch.diff?x=3D17b4c0f5980000
>
>

