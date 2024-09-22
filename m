Return-Path: <linux-kernel+bounces-335095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F86997E0F7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 12:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B15281162
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFA0154442;
	Sun, 22 Sep 2024 10:47:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689F2C6BB
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727002028; cv=none; b=qmpkI6UAdAIy1iUSLjSXI787yV0C5KbLBCgeWs9AcXCl/kI3gUnWXpnh+7Wks8iV4XCVbvQ0891xYOtd8mEJ58+xzlnklgeSSfkJdJckL97SKlDC2a8Kb8FYEMJFRSckTbe5B6oo8gJKLK8rr+faiU+X2ku6ElZO7FGgXTfiiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727002028; c=relaxed/simple;
	bh=3KgHlkcEUQ60n1jQuFbKypbJzL+jy3JJSojLwHrNgDU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DJGOX0S6a95wtjcTa2NcHUe7GcnWGzaWG0bV0DrK+DwdXcDcSR+AvzXaRizYzCvAesCFoiDr38kzRdyH2hT0eWcdvvFZZ2+ruCHr5m/M3LGnJTwDtvK28XPzHkYJbLuWVXIb4t9UP6ZHS0uZY747Cs9oSS49JWlN2Tds/b15hns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cf28c74efso512714939f.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 03:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727002026; x=1727606826;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ikB8oCS2Dl+53992EajgFLBLmhhIz6tZr4OD6nhAq8=;
        b=YPsos9yrtScp8NqlMFAoP8c49TFx1IxpGbfj8nX8Zlc8BGTOTzVoCADVTPLji1+zgu
         Z/3SriyPbaM8xr1YT/dBV8DSFyk6/h/+zhOajslbq6BEnsIJ55GJfE8atstD8pFJ8iTC
         n82aQODYfcgKGcusAmteGucEpwiw8lorbsrEmzpmyhWBReHyIfUXa8GY5isPmutcxDKb
         fcq/63PuUZFjnkPO3iGTXKF9vh8xy10omxQoAPolPOm3wmwSUpkh0YP6CApWLDCY2TGM
         rTTpAGXosH6IMirv5tAsrve55pcsiUlE3il2rDa0Rdh3bfcHTOO7ebb9JN/w3xSaEZFj
         8yLA==
X-Forwarded-Encrypted: i=1; AJvYcCUf7NB51UiuVQ/f7cFsXmFr4gkWMJWArtZAbxGU7lHmb3l8jYl2SabOQuGVD2Af+SSWk2plDbYMkH5ZLO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxO3rkodXI7/W/n/4d23adAaguJ5fuSZyHuTDNidtKH1h5dVc/
	Cc78RvzsYy5WidFDD0DjoMttJO1GGt9tglD/0H3+RCAKVjuBmsacDYCo5phx7+KUafOZkVD5wCK
	4OqeRNvXdN9Q+p8RWqGvJVwzrxB2cLL+w+xtpwgMXU3DzvP/X75M0yYg=
X-Google-Smtp-Source: AGHT+IFDQ3Vu/+K1liil6EnMK8aThm/61EvjGw0RZ8pnVjdM7ujpj7G8qWbm7unMgINJTbLEkpETgbq/Vqm5lqm2wiW3/Tp+BUEa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:39d:4c8a:370d with SMTP id
 e9e14a558f8ab-3a0c9d70074mr65964215ab.18.1727002025877; Sun, 22 Sep 2024
 03:47:05 -0700 (PDT)
Date: Sun, 22 Sep 2024 03:47:05 -0700
In-Reply-To: <CAG-BmoeBgp7yEO_r4xkqmyMxBJ3Wmqp1UfYCJJHZmpaiTF7byA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eff5a9.050a0220.3195df.009a.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbNextAG (2)
From: syzbot <syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com>
To: ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
Tested-by: syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com

Tested on:

commit:         88264981 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141a4e07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c35dd9cab68a2dc
dashboard link: https://syzkaller.appspot.com/bug?extid=808f3f84407f08a93022
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15eaec27980000

Note: testing is done by a robot and is best-effort only.

