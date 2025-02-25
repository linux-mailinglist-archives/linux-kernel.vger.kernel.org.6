Return-Path: <linux-kernel+bounces-530764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FB8A4380B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12B13AA0AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEC425EF9C;
	Tue, 25 Feb 2025 08:48:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95325D55D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473287; cv=none; b=NN5q45q2hn8vWAig491o/LurrzprFQMn5DmHNHseWylnz36386o7UYSpnmgDmPVkL54rO0Dy8aDVqRVkkODNMY4jg/96sZQPTj+MsGHzQzNOpJfBJTdBHqdk4qw9lMwodHkslVXuL6aiyZFVoGeWZbvKP15vHNEWO6UhzEBVMxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473287; c=relaxed/simple;
	bh=OHKlWGri6qWq1Dxq0BGK/tfWfNbWFrKNqYhwA2coYRM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ReSeME0zY2gjoK+ImYAzCoLVs+oyuABxfFOOHz0lTQGBPYtLHVEVTQuYutKA6swdBDRgOtJljMAjnS+kMnevKNM6E6Zym5kMDjjs6yfxvFJ8Xtfk+p3Awqk7xatJrf42CACMz6ZTce8jwtbsD7zcYhCYEukWu3ADywz4BWAqOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d18a1a0f0eso107952295ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740473284; x=1741078084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmDwwiwnY1/pn9LtAuEYnZkaVT7FgXu6jQtE0uKiD+4=;
        b=NPZXyfIkWalqoM41G+Cf1QP2acvXLCCs+KtkvGWK4aBmCcZi1pWO7qNoWy//nhjbr2
         1rKE36jUo8tk+NrS1+SL0SyYpoYHqByECbBhfFEQgnt2Wuatt6kAb3LFKUrrkSxmV1jS
         KbBJTpjP4VTVys0V8d+YJkXl1+nUzHEPhkCQGQPTPgTPrIMq8dHo0XU19SwEMMBoePc1
         ud4xD4EBz4VgjqCyUyQRIvgH7ZCDhH1xQ8WbAO2F7saKzfGsym1rIrV8ckryXD11K65M
         3QZlrfxp8QfkAIS954/U097O9yZfHe1msc4Thp6HVvxQrJip4LhEaGrozteUyCjWiqz/
         1bGg==
X-Forwarded-Encrypted: i=1; AJvYcCUopLx9E9OlqaOZy3euV4rrXOEfo+tGulcGdhdcrQ9vwb/5G8XqEaXoqB3abwRO52VepIJTPRtJRqdCK1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaO5idldJbeHfjCrwGGnnLzshNrfoW8Yuls5EUL2EU00u5C15
	30JTfgCffxuSvvqXkqIeqKqNf5Fvk+e8IACcsddIbCHdAsVoGG2VPWKt+jIXofdX54Eqz4mWJJq
	0ZN3yOE4rxWoZ+6z3itI4MWn2i3x3GJN3FWoThuM6CG/Kz8WySEDDKj4=
X-Google-Smtp-Source: AGHT+IGlAuR4a5sa8m5tx+eftwAoE3rYiz7tIrUM/PHyGCyswM2pWfbxLGW1/w9rGn1LkAPCBd1p6C0xsk51RT5YfusEUEyumWil
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3113:b0:3d2:b509:af44 with SMTP id
 e9e14a558f8ab-3d2cae6c9damr179390375ab.8.1740473284530; Tue, 25 Feb 2025
 00:48:04 -0800 (PST)
Date: Tue, 25 Feb 2025 00:48:04 -0800
In-Reply-To: <tencent_1C33E69E051B5B4B211B972571BA1CBB1C08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bd83c4.050a0220.bbfd1.00a0.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] [mm?] general protection fault in lock_vma_under_rcu
From: syzbot <syzbot+556fda2d78f9b0daa141@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

<stdin>:4:15: error: use of undeclared identifier '__ref_stack_chk_guard'


Tested on:

commit:         0226d0ce Add linux-next specific files for 20250225
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
dashboard link: https://syzkaller.appspot.com/bug?extid=556fda2d78f9b0daa141
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128a97a4580000


