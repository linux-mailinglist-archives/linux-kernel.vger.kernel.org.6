Return-Path: <linux-kernel+bounces-297715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66895BCBD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC971C22201
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E31CEAB6;
	Thu, 22 Aug 2024 17:05:17 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1B1CEAAB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346317; cv=none; b=Xz+bU2lEPIj/BWbyWqFlkBjQoW6wnPL7T0lrABt4GPzp9YPNJjkdi5lpBjWhmc96U5hkcMZeRkc0FDDEonlTcUja2CH06yFm6FXGDHGD2NfUZMyZ3AKE17hyciWEyL4fwkUfk62G7JeOfCIAbC8ZSITqEqRQo6mLxaP4BvRvF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346317; c=relaxed/simple;
	bh=n/j8NeecBJYXdgRLcU78ZiK6kEu4M1Vf2B0wUxKM1ts=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rXfYPZdog3hgmcqgG6mBzcztm9w+7Npu5vUgaczREtsFqS0fIV+0wDHRmQd8mbAmmfGLYrj052bBGIijoNDtwRf9lT0vYsvj5M39PMZ4mqLmtykarSPhzbZ4UUTKqVgyuarc8uwxosflVcOSAP8fkJGbYR4/CUz5n+VjrR1juPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d415635e6so11222305ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346315; x=1724951115;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/j8NeecBJYXdgRLcU78ZiK6kEu4M1Vf2B0wUxKM1ts=;
        b=XNjIA6IRzOpT+XD4YpUiYjQvfYYnXpScD3rgOYqigi8HpEpphA88Jt9TPyKGNFyQMu
         sKivrw21btR4XvY56aj5HQTsAeZpMVvfEz4FB+NHQGWr+dkZJyvRP/r3lO1AmrCe3BYD
         kbDt8uErxVXlvw/bXdCX6ZyQJGZFlqlZTDAxtaYymewFs2EUlQx1QSTgQ3Jj9KZDiz3y
         yyg54R7zKY2XE671o8uHsdPQOD+wO4BlxxCKOoJgMED84mjC7DYF9v9LtNGvomLDEPrk
         6hktvi79rWUXhtf0Qalkd7SeofD0Jo7NNEjDbPCy3/w2VtQE6vRfZc8w+S1QXuQ78Efz
         zoiQ==
X-Gm-Message-State: AOJu0Ywfuixo2hh+Ia2FXJZYFLLd+OM/kYpKv2hEypsQpw9Mc2rRXyUB
	cwB4rizO0o/0ilEW0uKfWEQkm700CPlny3l4j9X/Y4Wmh9xEiFSZYROH6RrTHh6B8lj/0x6Av9n
	OvBICahJ1yvlMKQ0IlUNhHmtzVk8tSAzztC8bH0mkWnbXQJknyZfyCa4=
X-Google-Smtp-Source: AGHT+IHw9Um/nA8kZUuG6mVDQcanA8OSNZ7Z6Et1W6fjMpl5xnl9I5+Hp1NZ7W4nAe1Y/G1EA/qS1YPd7toJzg3uBJBE8yF2O0NO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:397:b509:6441 with SMTP id
 e9e14a558f8ab-39e3a753ecbmr226555ab.2.1724346315083; Thu, 22 Aug 2024
 10:05:15 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:05:15 -0700
In-Reply-To: <0000000000009f9447061833d477@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094a58f062048a9b8@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_extent_update_i_size_sectors
From: syzbot <syzbot+eceea46e8838baeeba67@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_extent_update_i_size_sectors
Author: kent.overstreet@linux.dev

#syz invalid

