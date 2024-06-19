Return-Path: <linux-kernel+bounces-221159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF5890EFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606551C234AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7044D1482EE;
	Wed, 19 Jun 2024 14:02:53 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731D1DFCF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805773; cv=none; b=ErKB/lmlIcD6rYr7AeGfR4ZVqGKy6FQVw7SbbC53C7mswfIdW3eL5KXJ8vYiawQ9JBqb/bELZA7rHySbjJtI4K/R5eUm+7ddzlpy25Z3a0iQLeqwIy9gz2ftgCkhKD20uOLCXZQjGYRq0sD2RX9OdUq9uF34GFkGFqkvYzZXmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805773; c=relaxed/simple;
	bh=/mN8SOKC/5b7LQiZAGX0JfyY7hV7F6jFWteY9Cy07eA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=oacox+3uTDulpiniZVDCu/JanVNw5MzDWZTMNiEJ/48HVJxpLe2jFu6hUXy94uWg2fGp5jVdmzyNQY53U2patUixCbYfPu5QdHn2CnvSlwrkdd5N5SYWyWgDyyQBOLxmBpIUuJllhjTdB4d+HPyqRiENVZm9xbhwYuLtUjyRhrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37623e47362so3012965ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805771; x=1719410571;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mN8SOKC/5b7LQiZAGX0JfyY7hV7F6jFWteY9Cy07eA=;
        b=fccTZRSf/iGaewuk7v7J+M5ZqxWNPVGo6XXMM5CW5E7DFHlrm9zSX3KdYxfJuTKXXj
         ovQLNHLxea0WAtI7502ebZJ4D2i3Y5wBvKW97uiPMX3wMZ0i5O9akfjcZDmI0YhpFEkL
         7JtnN3slCAYSrj44kv2iW/dYojBdnunSgwI7zCid8Ran5G+tKUgR3lRkQLzuFbN13LRC
         s+4T71/VViE/m/+FbRMep535wKFnnARC32ioLymdXb5zs+n/D/NvPlatdUoBSX5TpNhu
         KPbuXF2Ns3aurDMgi0mMbhiAbYohZ2FoCbWhuMZS8ZFfLnWAUkoPIm/E9tdZQ1B0iDvD
         cUUA==
X-Forwarded-Encrypted: i=1; AJvYcCUEdPB3j4mAPhRyqQM1EeZERcZSElOnwSJ9wzVLDF1bti0T2IFH5P8FGweneF6+YNghxDGDdOUBwAuwMMEUljl+Y2q/QupnG1qGBWHk
X-Gm-Message-State: AOJu0Ywf4Qus7gFmXMUUia9MhwvPJusqAgyEp2tI63vsWsB3Sz+E6AD1
	xoRikk/HkQJfYuXX/JakZFuVi85uIUa0XajTprlRbAphhEvZu7dZTIs1JF0X2uOYxI+Sj6v62/0
	0GLucBw2lt2z9/CXLK3kl1bPZ/5mrprCQHDK2fQnpAO2gLCPFDCnpQ3o=
X-Google-Smtp-Source: AGHT+IFYQHgN9lpgAX2OJttJQvAHFJO9774Ic0iRqVQy67WIkOHOBlqDDZMeMqUhlDntejtG0tCbGUNaoVKewekhx8RsL8AOKZAJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138d:b0:375:9cb9:9d04 with SMTP id
 e9e14a558f8ab-3761d706b2dmr1209665ab.3.1718805770823; Wed, 19 Jun 2024
 07:02:50 -0700 (PDT)
Date: Wed, 19 Jun 2024 07:02:50 -0700
In-Reply-To: <PN2PR01MB4891A1254920C27F4688FBA5FCCF2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000687b59061b3ea794@google.com>
Subject: Re: WARNING in sock_map_close
From: syzbot <syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com>
To: wojciech.gladysz@infogain.com
Cc: wojciech.gladysz@infogain.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux=
 4b4647add7d3c8530493f7247d11e257ee425bf0

This bug is already marked as fixed. No point in testing.

> The information in this email is confidential and may be legally privileg=
ed. It is intended solely for the addressee and access to it by anyone else=
 is unauthorized. If you are not the intended recipient, any disclosure, co=
pying, distribution or any action taken or omitted to be taken based on it,=
 is strictly prohibited and may be unlawful.

