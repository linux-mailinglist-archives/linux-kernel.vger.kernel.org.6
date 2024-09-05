Return-Path: <linux-kernel+bounces-317506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF596DF43
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E951C22C39
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA991A00FA;
	Thu,  5 Sep 2024 16:11:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634819FA87
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552664; cv=none; b=WoRS2HGrak2xWObY7uv8NDAy4sII+76ruSl/TLNY7Nmm8SgnYt4wzcrQcd/9OfJk/Ax3CMYEljqwThYh9nCqzCB5rq0K7Z7TE6wuXWcnrmOzPq0itJwtJbdnqNnt92pobX2SxTVeT7zi+Y64RvRuhX0HksyRgSrJbDD0P43Fwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552664; c=relaxed/simple;
	bh=voHjGLmjdyH+D2sThrc7Dqs2E/KTLhun0sRq1Eta180=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=drauPWfDu1A6SqYIar3pMCdTMGU0WzT75EqRbh7kMmYX3yseAfP3AXvE+g73GWmRldAdCeALtPLHKU+sO+qjrCvSbXwDPTZUm93r57eBsO8B5mAWiZKN3Fxlf+Fb7o8Aoh+AzsFZ4nAQ4qtCla8mTx4iJgTUEwOdlG1QLHLKp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a13f69336so314132939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 09:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552662; x=1726157462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTR1alho4B04P7mghFvwv7FnPpHD4zQpJo7kCHEn9+0=;
        b=nVPqybJr/7dZC6LlUVWiSg4oQSPnVPX29vQwr4HAL/x5GeZklHyZ4yS5JxtyR1fgjo
         M6AXYwID9LOzMP+7qGHpoCy8KNp4WoYsd2+0uMSnt03hiiHHgMhx9QOEWqF+3coFAhtW
         9C2j3EJphxXpxRf2q06QtoybwjaTYCsKN07oC22uW145g6fgIXZWiOixN1Fvbnt/d2Oj
         8/b310wkxKgN2cRr5tnAQaHxJhidWRBJUayLEoLGwexhDM8vDCY4P8K231eWehwe1qrf
         KAHmanKiTR1OD+58sSi9FW4hq62XsGbYbaAebjPpxa7uDsEJ+0miPwqgbBi8lHROHJbJ
         XwrA==
X-Forwarded-Encrypted: i=1; AJvYcCWfcyeRSN3y4ukrUnDYLE/QfZMNbBUIk2P+kUhSnEEGjGdoPf2MJ4g9JFQKGeji08Wlop5BYxnXDFKf3dU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sZGNkcBvv7QcxeeS0JWD0Ajb6TE7ledVc0ZCHaIMu+HeunEy
	Mz874GrWEWFyyVeSLip68IXjV12Hfp2l58liTkKbTcdNKtY/ZGrfiAGR46H7Y+Ke/NpaIvHYPe4
	qFWhJpYUiG19Mgp2gPJtQwoKxSy0kJWfmuKK5caa2AxOUEcZJL8pC4HM=
X-Google-Smtp-Source: AGHT+IG09++lc6rBvWY8p7YlcOTCsVQnQlPqwOtlC2qf5TfNhvndMdBXay1s1o7Q0G/KT1h2IIrLahtrW2jfPi915BkdTdZx/I4C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9820:b0:4c0:9a05:44c4 with SMTP id
 8926c6da1cb9f-4d017c4697bmr1312529173.0.1725552661566; Thu, 05 Sep 2024
 09:11:01 -0700 (PDT)
Date: Thu, 05 Sep 2024 09:11:01 -0700
In-Reply-To: <tencent_BBD3CC8A27DA46FB12D0C64E89AD2ECDEE06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f2bfa062161898a@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com

Tested on:

commit:         c763c433 Merge tag 'bcachefs-2024-09-04' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fdbd97980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c699864e165c51
dashboard link: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170fae53980000

Note: testing is done by a robot and is best-effort only.

