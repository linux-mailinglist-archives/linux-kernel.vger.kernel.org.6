Return-Path: <linux-kernel+bounces-409979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A104A9C94E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C31285B10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593801AF0CE;
	Thu, 14 Nov 2024 21:56:48 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873911AE01C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621408; cv=none; b=S5w3g/h/XaqqGW6cFoXDEsl0EqncOpphRTT9cIhVKAnnoPU2xQ8zAvPdzF2rtPVbugMgioAopeyQVjXDBiuHVNaOqK/E5g0Bz+DOd7dlUG9emWWHqNCSsmsDnRV2fX/dwhVfj1XOV1bfv7CFZVwceKhKYEdmttReYAQeJ4OH744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621408; c=relaxed/simple;
	bh=hbIpnS+URpvAyTJ1xTBqOdFUnKaXpRqxrapc6IgmV04=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uet9TrlkDuoRfm4ITMAIdNcUUt9NFuiKtRj4i+MjD293rJMBMXmCpHeuHD5T2gSgj3R4VXl6F/1DBv+k/AR1DWZbiPop636NaLeQv2mTBXnZi7vmoqZ6u4/28WiYTm/uhMH/XLSS38QG+Sl0sae7lZ5WqxudUiIZ9+l58Glzyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b563871eso12677695ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731621406; x=1732226206;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbIpnS+URpvAyTJ1xTBqOdFUnKaXpRqxrapc6IgmV04=;
        b=h/vauBlRhQArxvmo5HvjaqPxQ5FvMvUOsrJvPeciqgBeRWHtqnfEPlkbDjMCTvkpu0
         tw/hhNpzPxYglcuinB3i77muIo8FORjv3KhM2l5zVEFtdj0Mkz7OasArgWZ3NhutdWyd
         UTCc6xRtXvY0qxAgkYtj0ZaORoopatcAgGOJxa6BomNUozVKjfvfhM9diTrqv/m5AYmd
         SMD5PrHIk9WWEXMj7pPdxBr7HMkYWJbqHhPjRpVXruVosoMzpCyY+dJgoZOByoZWTysw
         9+h4BvJgodWJXW1aZMEng13eyUrKUPJ9nNGm6SCMum27qPCFy9tEuy9vvYGJOO3yS1LZ
         MR0Q==
X-Gm-Message-State: AOJu0Yw3wmqI2LRsqldg1w0CBEtqCjXBAb0wybBwl2gSCZutNC7gxXCa
	Ggb7F6EMlPGpDJci1n2kC/oA51itAOlenS6Wad5XMlis+6Qg/vZqNCKf1Y07ttsaJCpsch+0IiY
	As0KVMyqygYlrKNEiWaxYP6bxdz9BH0iAdLSGAnndN8IAY+9qiS2juXk=
X-Google-Smtp-Source: AGHT+IHLkg8qDGl7m5DPmyDOJJmh1Z9/UZjR3sUOvIS3L342kX8wKjlWcJwOSCaF3IFrDxQFdov6nfonqbQ5qFiP3gh6N/zMf1e1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca3:b0:3a6:cac0:12a6 with SMTP id
 e9e14a558f8ab-3a747f274admr3915645ab.0.1731621405816; Thu, 14 Nov 2024
 13:56:45 -0800 (PST)
Date: Thu, 14 Nov 2024 13:56:45 -0800
In-Reply-To: <672ecc13.050a0220.138bd5.0038.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6736721d.050a0220.1324f8.00a0.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in bch2_copygc
Author: gianf.trad@gmail.com

#syz test

