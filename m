Return-Path: <linux-kernel+bounces-299251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274DF95D206
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CDBB275ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007871885AF;
	Fri, 23 Aug 2024 15:48:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA9B185E4E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428115; cv=none; b=YLbrJZv56sB3AK5+WWKdUdQ48GFUZw4K5sPrqpWGFwJyRKUUMUWGnN9KdRIygdj4uY4kgEc4kUnSs0SpVABOvdWJYgqm6klIjDvC1rPK98i2La8Gm8RPfkfD6xDMFw3FnjMBKSQbmPzclutIjH4fb1Ta6VhVq1jihzMLFOqwtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428115; c=relaxed/simple;
	bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=XmVe74SSCgdRUPVMxNCqElELWuyTem/dNwg3M8MPv92OkdZiWJ0X+1azop1Lu4dSlDT5FHUHc21uPued+8bO2iTEZDx3zMPuBihdkPC5NFvvmNziIY251qkvWSTizNigENOYxt2ei8Mlgdh8qzq5BZ27lftTqUFfEgHGqzuV9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2dee9722so23386045ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428113; x=1725032913;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
        b=NekwsXSFyKba3/mkbAU1E3hl973d585Q5c81/BLRhaYjqVzT27P8CoUWK897lLsY2c
         pnN+WtZjq/umf017UI3Q9TlnCNa0XlRCzDYvT3uOk8Lj4iXZvNlfOlEUO0fPbN6wFJJo
         tb4L9rIf2GvOhTlTSBUoTfEmI74Ib96SoAclZBILVQYfyzpCr1UR8MzXT5fOz/RAoadP
         qsU5oy+LgkB5xhO7qxhwb57IOII06iSTC8FEG1ysL35zmI8zsJ5y/+hpzsdnx03b5rmC
         nZF9zXUe5bryTxz1o9eUo4jNfrUOGQvh8kRsrheMLlrImTTj3oyloQIZQ/JJ9voneusr
         IMHg==
X-Forwarded-Encrypted: i=1; AJvYcCUVAqvGvfBxEL0fQlSwPnViX3OJn4VFCtdoYOjISgnlqbXvsfK1W5RdnT9eHUtm1Z1p7ox1NQ16nWbiiYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIknSC56LQoeQV8+ct90IORpjtAWxbWbs34yjORMFZ73as1MN0
	c9XLoX8BjQ5lsLegDOLWq6q4airZIp/itL3pIfJ8OtMj4vQEABkAkHOha+upmIUXeEZDzNdyKyu
	ep3pN+ayffxbOtnUbr4vW+CZ5PKFoZQelUzLW2FbrahDbaOySlUZQ7zI=
X-Google-Smtp-Source: AGHT+IElBLTuWBHWubK5SYKzmDvZ4QrDYFk4UWI1cHl3ZU6/vsFdxvMm92EE0vzJ6EfBAQNdrQUU216oyWArLOdaVuvZ7J1USU0J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c2:b0:395:fa9a:318e with SMTP id
 e9e14a558f8ab-39e3c8e3417mr1570545ab.0.1724428113326; Fri, 23 Aug 2024
 08:48:33 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:48:33 -0700
In-Reply-To: <ecc8f199b5a940f19a7c999d966d0282@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022c2e806205bb58c@google.com>
Subject: Re: possible deadlock in mi_read
From: syzbot <syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/Paragon-Software-Group/linux-ntfs3.git master

unknown command "test:https://github.com/Paragon-Software-Group/linux-ntfs3.git"

>

