Return-Path: <linux-kernel+bounces-361138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A537399A417
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B8D282BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53E217918;
	Fri, 11 Oct 2024 12:41:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45392217338
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650465; cv=none; b=ZY4Srd3b30PBfzniinsDbXKHQGMO0Z8D1jL3O6gbBpUX2PFtS+V+c8wt95QtHI2ooChMhtCfO3Uj90kALLYa0edBxdK32m/5+/ccckBw87KRdMabd01TYUEesY1De41i6BDWnpvfLbQsj+FQfdOSv5U6goOVsBu4On/YMqIa1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650465; c=relaxed/simple;
	bh=/iltYyYzNZv0RuQT9d8EmcfwpXr/YmPbFJLp9vWfsSQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n60TxZxfVYgSitAcB2h1nPFjJOmaoK4Nx5J9P4EtYIr3HBbAUQZxZFaoDaouV9bhfHF+X9a+CTsDmTXqZjU25zjrpEQvyg+OX5Z/Ev6juf8AQ0Xg6xJBwzFlBIdYiRgw1leC0mpFdhDvvie6tUqbCxpZ/Umh1hURu1Orvaptyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8377e901e67so132799739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728650463; x=1729255263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kFehn05Ip9or4csMraQ7qF5L/dHsoUGd4pXT9+jDqk=;
        b=PkvHjgw2OmXYO2Stdh75M/DiepwidYMDGIO6a6rwuEWDXAE7FSuekReVqHb20Ccukz
         DvF6bmqdw4ChilHyElCsI5HOoA4FBDXg4di33Qp6thcAsVg1+75EnSh5bdpGGOXndGgX
         1tNk4M+QqhwxChZBlxDuSJaSrlNideMZWVZzCA7gG2NKoP4wFgWsgBNiJ+1fJDanQBRI
         V8FslAb/vGZquzK0SOoTn8+pPgG9Jf68GVBYYEH2sDEGjL41BJUO6m9rwl5ZUv4w4o+8
         Osjk53LBbX58NmAD276snYBbhNey/NH68JKrwSi/kCMM6J+aAQ5ko4p4QepTVK1IJXB1
         Bnwg==
X-Gm-Message-State: AOJu0YxnqHTFNE1v9hERUXmI3OyifhiOPpuEXW9skRb2uGJQDtRxJoC6
	JsXwQWc2PmTqnAmj/ChhqP5bbhxwOoE2Vzif68vak8fMChpuQ3Oy40vDaX5OmywaMLki/1AktGO
	XGFZGdJ24HBS6yW6CIajihdbB3f8NGGz+1D85z6S7e2XNWogkEiD6oV8=
X-Google-Smtp-Source: AGHT+IHHh2sQqjWd+LjdrwD5TmGyO85aPKqeZkHZsdSGgY2VGWp1BqFKJS1GI/d7KKar+9pM646UxdZo4QZmgvptX4ZKC1hNS4rq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1412:b0:82a:ac63:e7fc with SMTP id
 ca18e2360f4ac-83794a5fc8fmr178247639f.15.1728650463529; Fri, 11 Oct 2024
 05:41:03 -0700 (PDT)
Date: Fri, 11 Oct 2024 05:41:03 -0700
In-Reply-To: <CAN=OONyV0hn1DPJLZ1sSgy3X4_vV2FcOjeUX-TgN7e-gh6=pjQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67091cdf.050a0220.4cbc0.0007.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sarvesh20123@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/exfat/dir.c:747:17: error: no member named 'data' in 'struct buffer_head'


Tested on:

commit:         1d227fcc Merge tag 'net-6.12-rc3' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1fd45f2013d812f
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105c9fd0580000


