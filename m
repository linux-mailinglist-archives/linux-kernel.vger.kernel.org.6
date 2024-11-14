Return-Path: <linux-kernel+bounces-408561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D1E9C8072
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC641F21D86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBEC1E631A;
	Thu, 14 Nov 2024 02:20:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF81E22E4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550804; cv=none; b=SJXo49sM34Q+GyuufRto3WdtqhWIV/En8RM+xM0aqk8PUYUNbpyaTnTO2P8VmHQIEWrfERSuuw5Zy/O4aGIpVUa3P3wO37OsP0+Y+PrZBUSzF9dSQa0RJHlkTZcxiZviXuH9lRdoUCflvwY8a1a///mwPhiATIkDPmCBoizcPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550804; c=relaxed/simple;
	bh=BAUI5kXEAeacGTkjXvMghee907sMXclY4wUNAIZjN0I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=iE19jNjj8jCq8StyRRunvkG2lDrRkHOgp5/dJJt4cLUMRbeO1qrTGIywb76wUkSAnnfYKYC5NaPKCbJCIBppYH7Hroa+CsjIzKnSNr+jbfnu+X573NPZ69T3TZPn0zH0MH38fpxasxwVj40k+NUzwpe4aw87EirbKCTx1kE+8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a71cd4d01eso1715665ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550802; x=1732155602;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8h/nFIwvM94dOMmCJA6hWbIMchuZY6+Dxu6OhARge1E=;
        b=L1CIH84sYy/KNQuv3lKBIJLLjxwX+DFNL0ItXvhDgA9wOtuEMhsXg/psCS4Q1F26DE
         y5nET58KIKG8kNk8S26HyL/DfvuryqfiCD56KPyiQ6hUFISdyWVSvqf06eBK64BEcFMt
         i7mzqaQs05PAWjyE/dyD20hxwh3x9Wh1bTqmVZ6ExNeMFnJi+Md3zjSpzqM5qeOvdUNt
         Yed+EdA967fxwgxNvDRe7rnMImcbtg8pDKXT53TzLIcD3PXKYRiFBlPvr2OQJlCcaEER
         aMuxDYOrR0InErXV/hyp2Emq31S3oFw1OAcDzcxplosisIsg3Zw2W2gF2iP1L27mH9KS
         dw+w==
X-Forwarded-Encrypted: i=1; AJvYcCU9uOx2VHlaSSidQGtqxHuQXjYgKy/7Kc10hzo7qQw3oiZdvJVQOoVd0UBZtUICqUPjv7g2BcZvI8sKEkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3599rKPw8YN0MuP1KgwDd74/9lxK4bZbFbztW1HGGRTZLqwr
	zBsjNI9ZvJtkpaBMgT19lr3BYRvu6uygBTju8J2Qp8t6tUxef65P8Dqdd6QCHFudGoFvIFRhF2N
	1NtyTNsKf+ZsYwtPDwD7ybeAZgbLJ83W0sPQDzw2b+F2XJPyqWh6kXYA=
X-Google-Smtp-Source: AGHT+IHGaoveLLhtpecfsyvoC5qpg1gZsgFMHLqH/pzJ9YM3nHlzY7Oo3r9gPcTL5kSYC1QUY9OOGxsZx2Ru+IMFkPGFBx+4tyyk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca07:0:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3a6f1a45729mr222481285ab.24.1731550801796; Wed, 13 Nov 2024
 18:20:01 -0800 (PST)
Date: Wed, 13 Nov 2024 18:20:01 -0800
In-Reply-To: <6b1277a8-30a6-4d2b-9b25-93d105503ea3@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67355e51.050a0220.1324f8.008d.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] UBSAN: shift-out-of-bounds in s32ton
From: syzbot <syzbot+3fa2af55f15bd21cada9@syzkaller.appspotmail.com>
To: xiaopei01@kylinos.cn
Cc: 67321ded.050a0220.a83d0.0016.gae@google.com, linux-kernel@vger.kernel.org, 
	xiaopei01@kylinos.cn, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> s32ton always be 0 when n>=32,add check n.
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 81d6c734c8bc..ead1d338fa58 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -66,8 +66,11 @@ static s32 snto32(__u32 value, unsigned int n)
>
>   static u32 s32ton(__s32 value, unsigned int n)
>   {
> -       s32 a = value >> (n - 1);
> +       s32 a;
>
> +       if (n >= 32)
> +               return value;
> +       a = value >> (n - 1);
>          if (a && a != -1)
>                  return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
>          return value & ((1 << n) - 1);

