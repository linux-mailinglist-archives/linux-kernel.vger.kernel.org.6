Return-Path: <linux-kernel+bounces-523743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE6A3DA9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D8170019E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3B21F76BD;
	Thu, 20 Feb 2025 12:58:45 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796691F5616
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056325; cv=none; b=rLQBq4YuJQWC49+DhNXaYiDDG5h+KrXe/kpwDNXXgw6/AcJuWedU6mYFt52l1wtqTOEEfeq6MJI3uUYDjBKYogF1fIMMxfPB4OIzqj5j+2JlET06OI+FXmBxGRfHAjxsIsRhtJ0ghuYWgMNo+2AHLkHr78mawIOB3Ei60um8U4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056325; c=relaxed/simple;
	bh=I401652Rn2tPXWoFjc24zoM80H6kDRUL0KMFPl5sW6o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=IzrEYBjorjn9hyL9PsCjZTx5K0ztu2MYIw/tYWMjfUqXYCUjpVPKm8eFUwW3ISDKgH9dJ5/IOH3AQx1+5t1m/80WkOprjKqPzPm/CAuJpRNKqmqKv90SPypNgODi2BMpVEHZAsYjlbhasBimWctJGw2QFlyM6BjyzmHl+mH/EAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b3a2f2d4so17054515ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056322; x=1740661122;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I401652Rn2tPXWoFjc24zoM80H6kDRUL0KMFPl5sW6o=;
        b=GNa9hVChu0ZHkaXk0gitAepW/CoKz7lzT2SZ9y6WfBr+OA3clOlbOTC2/+nZwWn2Bx
         zpOySdYJMkWZBmW3J8xe5iFmoCUejs+BRMDzdhD7qTZCKpT/Ukc+vbbiRSBHBsmC/UMB
         yy/yIYMUKKRk+a1RzuoNHu/ZBoyMJlxnNsf4wNq+2CO/5vBkDxSTp5KHEFBs7fOAwo9T
         GIP2Pr/hb5kfbFFq0NTJJTlx+ddhTxmGRJZO/tWBjHC0dy0NtpgMIeiYMNdPIpmoATzz
         zT4NeSlUwDlw2sV30vUel8n6TTOYyT5+/2ZYOH+5LJ7+ZgoCQVGq+hWw87ACzXWZgHUf
         Kc1Q==
X-Gm-Message-State: AOJu0Yyq9xHusWeQmqXLWbKxTcdpYn9gDHGdeBUKhRkhQGj0xN5rXMXx
	IJAp2rBSlXwgDAx4P9jCdrICjHKGREM0evRCDSoFjueRgP6jIC6S7qGBfakzeN0fz3jgE/5s6jK
	zMhTtx3s3HU1coi6NWUdW4sXdKl/sWGg9sqg7X6iNdb5zh9NN+bCZL+4=
X-Google-Smtp-Source: AGHT+IGmm+cxSW2B4Qrt2b/SeCb10mK5qlY+SbZN60S2qNAesXAq7o1TGLk2x/2gbA1ezo5hdTweEw0X5M/XslulWK/NyOdLPkg6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa4:b0:3d2:a94e:c35b with SMTP id
 e9e14a558f8ab-3d2c25dd4bfmr20586795ab.17.1740056322643; Thu, 20 Feb 2025
 04:58:42 -0800 (PST)
Date: Thu, 20 Feb 2025 04:58:42 -0800
In-Reply-To: <20250220125837.1034046-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b72702.050a0220.14d86d.0282.GAE@google.com>
Subject: Re: [syzbot] [media?] [usb?] WARNING in iguanair_get_features/usb_submit_urb
From: syzbot <syzbot+e3ae1e7f4b88f3e696f5@syzkaller.appspotmail.com>
To: n.zhandarovich@fintech.ru
Cc: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> Test if the issue is still active.
>
> #syz test

This crash does not have a reproducer. I cannot test it.


