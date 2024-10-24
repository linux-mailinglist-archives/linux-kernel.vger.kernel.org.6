Return-Path: <linux-kernel+bounces-380502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5859AEFAF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F8D283F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EC41F9ECE;
	Thu, 24 Oct 2024 18:30:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85ED200B9C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794606; cv=none; b=TutVGTYyk4YDQmqoXA6PfPjoOhBO5NGxZvg8CEPfSyB+Bo/LaKhkgt87mlgSZOdNecGGXaGRcOowRnhRV/Emv/yq+IZQqND/rIOPxDArs1PUiy9wKpNP1hxKqQvDdOcGXt8jVzRVs87Yrr9OzXeDyYALb8AzFWYhhL+uOPF71cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794606; c=relaxed/simple;
	bh=9CSA2wtJ2b7FiRGk2LVz318XJh4iHJrEfDtDomZ5T7w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JZTfhw9v/7gCouTDE0U/JdjYfrMVUsUptZl0ZkR49S+aqvnFgjKEwxzkurAVmB1AvlIRd/deQaAlYRbzzbMXwgqFl60z9A1hYP/bAO7F+v3XPxFHOIG64VP6kJqqsbuD+FGjZk9igc0Us9qUQ5CK4AlCx4UZviw5VXPsXWUNavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4daf7174eso13461305ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794603; x=1730399403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcUCv8Ag4XiQaZ07c4/AGaesgiDW9i6EJ2r+g/Xz83Y=;
        b=XpR3ANAmWJ/hI7b3zs2Xt359mn1tBfpv5as3/ImijDxzpJqnSEOw5lXUy6CxaWIIzi
         wnPXCQWwT/DejktNqhGMlLXZnKHZt887kOqHIuXaGmhbfH3tPHEAAndPyjHYJ6oXOfpb
         FzW2+zZbO6BTdRC/IyU6KSfsBtwIn6q9vCZe1610TfzROqniuNofUIrveisGhhr8V7pJ
         AiySp4w+rx7vUix9JPXmxJI93gYCv8x9BMldEnrnCEst+JQLV72QoLSjpVQPew6AHMjJ
         YRaOKvHdDJL0rxBtNvqWObJ3C+jYc83E5tV9zR65JmjPhHWTgnBEjsfN1cACwQur0GHi
         JqtA==
X-Forwarded-Encrypted: i=1; AJvYcCWiaLF3u1YyYO+B7wy4dWyobr0QCcUw+2YkbGqnxK57ax38238YABDIHfQjRTJiuWadyxS0lHLgsPAeqBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgv0Lfq+HxISr0oVEbeC70vH7iVgOLsUH0k/s2LG8n6A3/+CZf
	a3Yr+6LKNufA/LTGmDJkuHjY60iuxoKM7kAu2hY1c8jZlECRKccQsTez7GCX6YnNNw1Kir6Q/lC
	AbX++AIVC2FDBGIoF5fe+1zS007bdDIm0XnuU5miLepBdXvXd0QS8/s4=
X-Google-Smtp-Source: AGHT+IHYtORYopN3rLhm/mO36DzrThOSbzOwJr+7f+Yvkf+UR2aDdeQt+YL33Hy5yCNpOqkFA3eMMy7WzJuuZwx/L6bbF6plvZ2P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1848:b0:3a1:a293:4349 with SMTP id
 e9e14a558f8ab-3a4d59af493mr84613675ab.18.1729794603729; Thu, 24 Oct 2024
 11:30:03 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:30:03 -0700
In-Reply-To: <17634403-3bc8-41c8-80a9-1cc10041b1ce@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671a922b.050a0220.381c35.0002.GAE@google.com>
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/bluetooth/hci_core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         fb456083 Bluetooth: ISO: Fix UAF on iso_sock_timeout
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=d239903bd07761e5
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c4f640580000


