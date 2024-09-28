Return-Path: <linux-kernel+bounces-342673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4836B98917A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 23:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0057A285DD5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A876116DEB2;
	Sat, 28 Sep 2024 21:14:20 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B6165EE8
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727558060; cv=none; b=V8jdvf5GNIUH1QHhqGdRZfCtxtAI7HKdIrZPe4sQ447wE9huhs0mDwQNDWov9aXqstb6pEhpXzKfqIKuiynt0gE8XuHoWy/dACGEKghix536nIQxmVwNwdrKHjahudAoCMqQFQMrMmF7uheHCprcZlAMSO21U8ufYnrUEklkw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727558060; c=relaxed/simple;
	bh=PMVvQvta97n+2SZ4yRIacGm4ap5cDQ+xs5rhYZ8ZOy0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=kDALCammGI5Ok5+keilbl+Ff4624TTtU+H7R8G7BV0zapwtCBrh5L9r07OwSU+rBD5qw3aL9VyKeRu5+HQE1azCIoyhDQb8pKRPmyOcgl5miQDWmrWoaUbiog6CF7/2zl21kNLuJ9PgyJBEt880sXHgoWw2Xpnj1q2aQeM1g3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82ad9fca5fcso304913339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 14:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727558058; x=1728162858;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBisxZh8b1zpgyBCd8fPm2fNG5Tg6kaNFcxq9GSBLjQ=;
        b=eYDh/HY75YtFRbaWslNu4qUYx5teAOqR3jLUK+LP0wdB2B+duG5/iNMlc/1BOwVPmC
         RHBymYaGOdBK5a4KND0DcdIjUa7uoRi8QyG28dDpIaVFrXJOdzQuyt2A5xqD3kHHjDfR
         mHHGDMbjenOiRvVIwIGS+CWdb/39D4aqTRdGkYsJHOuhdGBvgc1l4co/PWXs7Zo1+NdF
         cVIYvuUzmRLbttiXgGlqKGoWsgDThhPSvFmEZIoCvRhoekN0vtsb09ISSN47o/izvtcg
         7thDHrVG+x8BRi9ZEp+9ydBk8qqnqLcN0ntfGZTFl8sfYnWJA4pOvHpj2kZqDnlUg5Cz
         aBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXISb9Dv8+XL4W0fylabl/1HlWXikAY2OI3Nr4njvIuPglG79/AqxYiz9a8TlLILx8ysu5TOz2FnswyOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTTplKHO+yL+YvPzJj782FxjCN6Rtjqfk5Yf74IL/4esP1f06a
	STwTFIcx0bg7rkkbv3hp7YbWNo38n3zBs/dWSRXxg2g2LUWNcM3NRcoGNf4KwT68/dqIew2vFLk
	ZMlKtzpXdh79DQFLBUzRhg5KsM/QiQWmuNqYJPVcz67+d9LfoEtBhpFs=
X-Google-Smtp-Source: AGHT+IFk6kHjdKHP8STvSo/OfIQDYidtkyBp4HE5Lm59q+Gj8bVdiikLILQOJRV2WToKomYGcmbd95zRCoxCiDdvq2QW32ckHhuO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a81:b0:3a2:76c9:f2b7 with SMTP id
 e9e14a558f8ab-3a3452d120bmr58967615ab.24.1727558058214; Sat, 28 Sep 2024
 14:14:18 -0700 (PDT)
Date: Sat, 28 Sep 2024 14:14:18 -0700
In-Reply-To: <CAFRctSGbnUwgYE9yTU1V+ULZuo_AXxwHR8s-_7=+MiAHKE-Qow@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f871aa.050a0220.aab67.0008.GAE@google.com>
Subject: Re: KMSAN: uninit-value in mii_nway_restart
From: syzbot <syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com>
To: eslam.medhat1993@gmail.com
Cc: eslam.medhat1993@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This bug is already marked as fixed. No point in testing.

>
>
> -- 
>
> *Eslam Medhat Khafagy*
>
>    *https://www.linkedin.com/in/eslam-khafagy-a8a68159/
>    <https://www.linkedin.com/in/eslam-khafagy-a8a68159/>*

