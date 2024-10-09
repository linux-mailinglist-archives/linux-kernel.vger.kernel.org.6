Return-Path: <linux-kernel+bounces-357205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B4996D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E561C22045
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD9819D89D;
	Wed,  9 Oct 2024 14:22:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360219049B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483725; cv=none; b=B4avaagAd1cdplHPn7erbpI4y3IxHFVqLUC+0xklEmQMB+15QG2EIg1zZxsH5e6V12lt1rDq1xa8MRMV0XBgerGe2cW3jaepOTdL9msCI8TdljU2cXqphJrYBleswsCtp7ZkUL/IErd/547BG411tpoqz9fERsKdASFzO4gIAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483725; c=relaxed/simple;
	bh=rdTwC9g1YQdn8blr0oOCzASD4APdHtumGoFiz2JLNys=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n2Zqp5jMH4M8qwSDe/HSj+fXEStWSQRKsge24cATOAqnB5U3mkgaobr7L8MOxer32Z/QK14p8x1jKajbTRifIYJUL9Qw+4lbMtNbskpcYvc98w4zl1Ar1Hw0TT1g77TgX9IVNVm2M3hhb2tpMSWNJoAChBC5W0W49u+Q/BHw1XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a343860e72so71494405ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728483723; x=1729088523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLu7zt5XDQj9lOVwH7s1CPLkEn4z6TB/jyLQtPPFHbw=;
        b=C8v3Lsc17GamRaoRHipbBG3gEMlMYIu/9kDapAGqHJZ+qSwL9GbvzaGt13hG177NSU
         nbNlp9BZ8Wec4g0lV2T748EfBMskw8tc1gTMiFVrLq2eKeNQOJyUsmN1xYS+W5e8/OKd
         J2bWAHqtncpbyr98gXKtkLIXjjQyOMoM5i7bsSVO5wEvkSYTgFzVwUOER41sIQabH2eC
         oq2+tuixa5jSL5TJKa/QGEc9JGhVa6RXEQzDdPEq9FKV4FszUkVS9l8BW+jKkvmN1X4T
         G0Dvbz2I9UOWtTNEayqE49lyH8hervAE/eKFtabeEF2QcjeRA6T8HS3Yx+ad/28IyxwD
         nVxw==
X-Forwarded-Encrypted: i=1; AJvYcCVKJn10/hSf8bXUMWNduJ/e+vYJzYhicsDdfEBnzE0ZsyqC1BGYt6UgYw7B7QLE1wM1gIOr4+2Lm4rLr2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJ7F1OmfwyAQ4NERGJoGe51/1mQsx8CO2ASr1iw7d2oaDqjbD
	Y0ZhfxahgLYy3OTK//ej4+gKSWzSxKb0tnuxq0cngcjSPOHMT2PoxuDf9sOdAujFr6pMYmjbv1W
	AEFmK01CeOdK6zwoDcygbV349TDcamhGcEUC5f1NDEUPPKNrto0vjNhY=
X-Google-Smtp-Source: AGHT+IEK8FX7NodAq5saVixCi8T7A29A7in8NUOuVOSM3h42A/7ywcjR8wBDNEh7PxQjFVLMogb9rJy8ypFWL5pShX1qx5iwlkW6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1569:b0:3a0:90c7:f1b with SMTP id
 e9e14a558f8ab-3a397d0cd74mr23240065ab.12.1728483722706; Wed, 09 Oct 2024
 07:22:02 -0700 (PDT)
Date: Wed, 09 Oct 2024 07:22:02 -0700
In-Reply-To: <tencent_49BA6FBB7033A99E361BD24B1D1B94254108@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706918a.050a0220.1139e6.0002.GAE@google.com>
Subject: Re: [syzbot] [usb?] possible deadlock in chaoskey_open
From: syzbot <syzbot+5f1ce62e956b7b19610e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5f1ce62e956b7b19610e@syzkaller.appspotmail.com
Tested-by: syzbot+5f1ce62e956b7b19610e@syzkaller.appspotmail.com

Tested on:

commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12a49327980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=5f1ce62e956b7b19610e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f89f9f980000

Note: testing is done by a robot and is best-effort only.

