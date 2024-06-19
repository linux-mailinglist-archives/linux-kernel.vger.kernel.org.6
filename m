Return-Path: <linux-kernel+bounces-221158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C766590EF9E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EBC0B22491
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B114014F108;
	Wed, 19 Jun 2024 14:02:03 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B81DDD1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805723; cv=none; b=X25Qh9qICm3KKz83GTk4WorxhhFvps65u0C7aCZzHKIcjHDEEziOx05nU76nu845180VwDpjrhU0TS7Z22+5a0/1VZIRXj+SCID3BsjS3C3E3lY0cdI8ZGAx4ZxHhjq8+SApgeMkza6In0y+S7adw0+wUPjAPXTS9NPQLBzG70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805723; c=relaxed/simple;
	bh=a5x3fZBuTurilP1lJX3BEd/oe1t12MtLNpXyZ32CN/E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=aKT/On+hghcRJCKkY8eABiu/YIBqabw1SlrZKswnmML+uMr8TZnu1NB62F7BhrdiTW+SM/HAEQv7/CCvfHzJHaZ4M0zQUlFMHo++JfPYk0op1O4vybFlTHlVuXc0Ae6k9S18x7wi75HrbJkkVvONCt8komJ7j7Grubebl0LU8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb846f49adso815898839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805721; x=1719410521;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5x3fZBuTurilP1lJX3BEd/oe1t12MtLNpXyZ32CN/E=;
        b=xBPis9k16oL+QSEfmE35RrhrkK5GrjMKzcg9z5sv5qVaBkeAKWxb/o8SKwpsVgvDbu
         GliuYu7/gydntE8AS6bXKHVG/SVTT41w+NwtQdtqxIU057u52NoShDH0hiBFRF08UoVJ
         5mYq8DCO6p8qAcas/hjLDdwU3r6dPVZtRwWRiFpbcZfJJ1LtWQaTSPySjyezNl5BkeNl
         d6Av0v9sC4TU0kRnt8UG5SRqjDZZpNAh9GxQU90ULWOaWS6xTx2vb9bDtOC6GtwdvJsA
         KQ2w10XnzahPq0rNnxuzE+aMr5IyNyMorhGNc/NYlSd3zva3IT6p8MvBrRDQ2Lc51MjN
         bnRw==
X-Forwarded-Encrypted: i=1; AJvYcCVbDtmXKkY2yaxIL4n4CQnTCpTMnhpGnzoxh/pwXydUg2NfMqo7cxfjjHQIjtOURll8iz/tE6YEroxcMONUcJnIGRjS4+WsHWS0R+oo
X-Gm-Message-State: AOJu0YyTqUsx0tOQX4H7Xp8gjc6330F5x/m4VPFdfz3fmmbPnDubtLqw
	rZ8/RdUMcYAtdd1kE5r6W25Lhmu0jFaB57QBGogVV/JkHqaan56MamE4QHyCB5bUySEh8N8GMJt
	Hdc5mOXuOLh28FQVCPrlu+7AZeZtBYTKvxqGXlMXu7Hdu+YZjFE+csHo=
X-Google-Smtp-Source: AGHT+IF1ENX17AlB5FFI7b+xHhcbb0jIK1HD9zAPhxxzJ+jpgkgYGyF1D+onSq+xMT6nf9Gc4AmUqkpRUbi+hHQ2qsinp99QHXNn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b49:b0:374:64df:681c with SMTP id
 e9e14a558f8ab-3761d751e2emr1920645ab.4.1718805721176; Wed, 19 Jun 2024
 07:02:01 -0700 (PDT)
Date: Wed, 19 Jun 2024 07:02:01 -0700
In-Reply-To: <PN2PR01MB48914ED83EB96F2270A2A124FCCF2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072ee64061b3ea47e@google.com>
Subject: Re: WARNING in sock_map_close
From: syzbot <syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com>
To: wojciech.gladysz@infogain.com
Cc: wojciech.gladysz@infogain.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux=
 c519cf9b7434183bb56ed1e200ac577a5fd34d9b

This bug is already marked as fixed. No point in testing.

>
> The information in this email is confidential and may be legally privileg=
ed. It is intended solely for the addressee and access to it by anyone else=
 is unauthorized. If you are not the intended recipient, any disclosure, co=
pying, distribution or any action taken or omitted to be taken based on it,=
 is strictly prohibited and may be unlawful.

