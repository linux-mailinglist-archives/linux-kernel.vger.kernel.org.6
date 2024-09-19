Return-Path: <linux-kernel+bounces-333792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D99597CE29
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F2E2840C9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA9138DDB;
	Thu, 19 Sep 2024 19:37:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9492AD39
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726774626; cv=none; b=FodlSHKKm12fvi4DZMWGO7AKmzx1t1IWTUd/hcXA+11mmKv38auU7vXXzIW3yPSQnnm0pEgZJGJsi087Lo5eQ2TWRA0SYsLFYKnLMmkQz6Tq3K6oJYiVk8pYtOoXqvBoDKh4imVuM7657q2YabpN2x/mfkdI8Y66tONLoTlrhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726774626; c=relaxed/simple;
	bh=h7cJFJvH2bii7WYkqUdFJoFaaZT4B06F01W+siRkutA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WDw62mV7rPPm5O6nHBNq2E7XwxbzfEKDmavVcze42+LlSdEC49a0XZRRPHZzDv+D9Sajb8MjJO4wMcjgKRy3Pu3jPZx8zgd9NAqwPqlaaPqEVfv55dwxYKrlCkoquNnbjc0+5HYaNrVZYBaLKAqkmtXk2ZQ3+FtsZxC4X/qCiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82aa3527331so148048039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 12:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726774623; x=1727379423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CRNWnXG6C62pd73O5+0DURKFiurkyy58Iv9yEaQuwU=;
        b=SS42DX4p8f03jfHkrgmgoGf1Ek1Ggjqapz8A5sRmbFMKEPfECS3aWOVTcultS2l/f+
         wwFlVrpN3f+Ph9q5jnzI5RnK0lVXEIt1uN8LSRwhzPPHeHlY/08Jjwmzl4Nc+PV9LQBA
         K/G2AaBCn9b2OCsb460VMrPT9cPZnuVqRU4QvfRHWm2fLimHz8HLTzGk2Y8sNoxhMjMF
         OGMlzJ1oKxTBshi/H8tvQ2MPgkYVavYWCZaXibYg1QFLVkPYViZLklxOsld8xa3btkZw
         clvEgMj8Qp2IcS7LXlEYjijlpDdkrjJarxrcTURXNU5FP6Ty9fzdFHh+P/N/RFXgB2hl
         BhHg==
X-Forwarded-Encrypted: i=1; AJvYcCUuQESm1IxRTpjTIrUDVyrP9+Smql8uZSt0jiF+TCF82UiecmRQJFP0oaprNNw4hBVOerhBNu1h7uL4l5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37BY6QYjb8czfveAqvHWq55qZErlV3R9q6GD5yonm8gWTZFxy
	iI1kC6TyM4xDj+/ocO0Wnaoc82OshL5Dd2OP2KUd28bF7ULa2D37Cdhach4ybC0m7JfIlbVlqz7
	6z+gwv+ij0HuiuDYyCqvwuqb1tGGNmYFtaicyYKhvD+Son8Ny7/SBJrg=
X-Google-Smtp-Source: AGHT+IEWigGKNkyjia5d2sn1U9cVlDImOMi4LZBpan1NY7y3ryjmidJ6A3/FBWMdIrvH645kOzaYezjv0UDb5xZ8rJdIberjuPNM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a5:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a0c8c808admr7797375ab.7.1726774623498; Thu, 19 Sep 2024
 12:37:03 -0700 (PDT)
Date: Thu, 19 Sep 2024 12:37:03 -0700
In-Reply-To: <CAHC9VhRpDPTopxgOEbDt1d_XyDVNzaA7++6UojWXidbpBHjeVA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec7d5f.050a0220.29194.0043.GAE@google.com>
Subject: Re: [syzbot] [audit?] general protection fault in smack_log_callback
From: syzbot <syzbot+044fdf24e96093584232@syzkaller.appspotmail.com>
To: audit@vger.kernel.org, casey@schaufler-ca.com, eparis@redhat.com, 
	jmorris@namei.org, john.johansen@canonical.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+044fdf24e96093584232@syzkaller.appspotmail.com
Tested-by: syzbot+044fdf24e96093584232@syzkaller.appspotmail.com

Tested on:

commit:         2004cef1 Merge tag 'sched-core-2024-09-19' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1784c427980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38d475ce6711b8b4
dashboard link: https://syzkaller.appspot.com/bug?extid=044fdf24e96093584232
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162b369f980000

Note: testing is done by a robot and is best-effort only.

