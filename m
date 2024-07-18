Return-Path: <linux-kernel+bounces-256373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79B934D37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C831F21BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6113BC30;
	Thu, 18 Jul 2024 12:29:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1459679B99
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305745; cv=none; b=I8ec+eAsdqnPiVrFXQSMJ1YX1AZt2QDLioUp0+9uDNNCMis6nbzA1GzI8OLDGy3GalOI4fpDB7nfy0TdQjl47hov/weISzMpNlwS1cH5fro9Eydza8jBY1o3SalBMEuCSVp6DmgzlUSyUBLkvzmO/I/mFipeCuA+UwxXSF5LQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305745; c=relaxed/simple;
	bh=ED8byCh6AUGZ9GYBS8KSKVM+QIwrdqJChT8jSAO2Rtk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tE5kVVg6cejtKoYvx5ZzQ09havhVflfogY0V+n7JFqspmq5MI/1z243SHRGxMi3QlQRMzBXdYlz4iuywHmxWzB/voxAGaM1Ska1oCmGMAN7/lYK/zvdAtCeaOs5I/XMPatN311jHqaN78GCIAzEW0yJ0Q/8Q8ki1W0s60xIdaZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-802d5953345so111155139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721305743; x=1721910543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3r+kvhB5g0aZQ+STAN7dxRt8jUcohKh/npMMbZdKe8E=;
        b=E51a70HyLbpV+KJ5N7q35FTkNnRJRtciSrrf6Gkrd6Ux3cTC/4BDsD5LWqFPgFnpYg
         IDXsc+UuYYhvuiPY2xbw7ACbPnaYmsyHkZM91S9xD3pdogN/9J+kYejFytra6AyHm2Uk
         qSiZg7VHlmgN31qs9rC/qSaXdJzjARkA4IexcJ4/+mbS8TJTs7UOSvirW+tti61VK4iy
         sVKmQ1pgajMafbmOnVBwzDtTYEmpzHLWoPb9o3oJHTDKbYlGl4Q/nCBsBP2JghKa28jH
         mlcU488eE0jml7zFU2qBGq7mPv58OaOngrp6oKgtK1qVUltvH4xGTaWFJzP+WVuWd4xm
         Zbjw==
X-Forwarded-Encrypted: i=1; AJvYcCWgbUa5XIO7tQ853vuQG+RgeFVCvAFrriFYUWi1xs3Nfk7Bbw5vY1ZlhctQ8ZJ34MsQfK3InfaOWlvaEZLn9j5J+3Q6XSpUOXfJFM6g
X-Gm-Message-State: AOJu0Yy3kZa9exOD6sw9qXBetQogTD/GL21JOC5rQI7/Oi7OP4Yljqb5
	YGaAYQWA7cbMJvvMPkPUWgOruCe++2vytcFBR3jyltefrXbc4KmOeLGXw9WKsNb0N8Hp7tqaFDi
	4p/hRmc/VJNbc7j+tzBBFU/0BppmNFssa9M/qDYqvbxjxpDEim0Lw8YA=
X-Google-Smtp-Source: AGHT+IHuXu7QAtJJ7rIvNu30BtIVFVPay6xdP0Os0rPSd72JOv1QP6hIT9fXawc3I+8aLbfo57XTezf/LyEQ7AoRSzyTqkenR82J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:850d:b0:4c0:95c9:f77 with SMTP id
 8926c6da1cb9f-4c215cd8a23mr176607173.6.1721305743205; Thu, 18 Jul 2024
 05:29:03 -0700 (PDT)
Date: Thu, 18 Jul 2024 05:29:03 -0700
In-Reply-To: <20240718120439.59661-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005fb6eb061d84b95e@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/net/virtio_net.c:2898:52: error: use of undeclared identifier 'GFP_ZERO'


Tested on:

commit:         b1bc554e Merge tag 'media/v6.11-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=116413e9980000


