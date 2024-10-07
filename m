Return-Path: <linux-kernel+bounces-354219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FBB9939E0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B858CB2398F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2004718F2F7;
	Mon,  7 Oct 2024 22:09:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379A18CBF0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338945; cv=none; b=C/ZnSHA7/2dj4jzXrSHsezHCIqFwPs62IpdqMvEgeXnlgGbKFdpwa/yotzOhRW7p7c+AvG4w4hSAl7nIJmkY2a/lVdlwcS1SC4QTSwn1Kc/ksSEA6+Q/E2G82VSqF3IRFfW8nsQD51uIRp46tAyKqS4RAnMSmvj3clmEOW/dntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338945; c=relaxed/simple;
	bh=XSKtX9BcU4wj7hStskhewofmcwA+N7Ql+LZI/lCtHgg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a1TySxnMJGHkYXoTDtFe66y6DnsGWLbH/Fawe3FgNfZdP8n2Yy8wIz2N9SZl6ceSwVz640mNVZKZxoQoHbDFlo08vV7ihpEqLodNmX0T9rKAUfT7L9MuWR/9ybyV2LyvympwCuzFHmX0Yb5qtsJAiYciKwpQqLE9qL7zHZqwqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cf30e0092so463108539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 15:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728338943; x=1728943743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DP2k4mj3sf3Eb5z5MiN/qyV4BcX8fZFDlFlRxSV2Jo4=;
        b=CJ4r+yKj2+a0c3togcddmbDBSbB1Ms4giedFAG1nXXQp1TMs/UpWjhkEnaUI1UJ71Y
         FznIA9MRzPSCwUiyKXaZyozZN31AFlOIy/rgUSMeli/r2C0URleaHx69d3laeHU75MyE
         NUbUiTUCcpxSqH1VyLzW5ZuDO0DEL1B0S0vCcbM7iMv8EBrApkPkuHTCHhVALkljEV9O
         SdD6HacaO6L7QG96wqrcHUakAV2JZytAK6UlAVACn9G6m1KkslCRYIdbCLHf/gtVEymo
         yog3QArdwNciBv7TlZQBumrB4pHZ1tBGkfYlG5I/JHIC+U7diTHbHJXNUlQipvKeWfFc
         Uc8Q==
X-Gm-Message-State: AOJu0YwXNObjgDkLEjJltJODAdB3R0sLes6Xk1Xj9rKIo4pndo/YqZqq
	xgzijz0XBzv78Dww/OP1yGz0d2IvhpQdlcqNVNNiIXx/+4nQtTNAb/Rbze5r+/2xfQTZINYH+cK
	5yfNf0XeHeJrFR+YtDJ/5ktbvfAzZ/OdCSyl+NmrijgtEMnOWWiD5n+Q=
X-Google-Smtp-Source: AGHT+IHVv+ZxNsL4WOn7ij6+pyfzKZoZtBlcOV8h9lm6/HFBzefqOQEeYx5V0IsLZoaRaKiu/qmjSadI9WgsKczwgQoKIIfBqNJR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c03:b0:82c:fdc2:e25a with SMTP id
 ca18e2360f4ac-834f7a90c2cmr1459853139f.0.1728338943011; Mon, 07 Oct 2024
 15:09:03 -0700 (PDT)
Date: Mon, 07 Oct 2024 15:09:02 -0700
In-Reply-To: <0uXIx6_m3Tho5irFNPyOCVxkEwglXY68vmpOxPp7JMeSZQl-lCrilzFNqzy_Z7yscH3dc1oeZ3zY0rwJF4IBvqa_uNjFDRermHIphBt2YgE=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67045bfe.050a0220.20acde.1ece.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in bch2_replicas_entry_validate
From: syzbot <syzbot+4d24267b490e2b68a5fa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d24267b490e2b68a5fa@syzkaller.appspotmail.com
Tested-by: syzbot+4d24267b490e2b68a5fa@syzkaller.appspotmail.com

Tested on:

commit:         1166d22b bcachefs: Kill bch2_propagate_key_to_snapshot..
git tree:       https://github.com/koverstreet/bcachefs.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=160e2327980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f009dd80b3799c2
dashboard link: https://syzkaller.appspot.com/bug?extid=4d24267b490e2b68a5fa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

