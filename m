Return-Path: <linux-kernel+bounces-258087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC993834C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 05:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1033B2818E9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 03:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B9A2114;
	Sun, 21 Jul 2024 03:28:41 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781717FD
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721532521; cv=none; b=lOUBuwYVhHqNbvd1bEo7DRQm0wbXRGWgJXS+1z9ykEubyZ34gQo/Uerb21w+Wt+/DBNhSz5x9d+wwWIz/aLSMz07pmqrp2RYHCPOGEqS4m9JMS+nuh1zL1VRtIvNsrbtSGwnM8fT66abeRObd87GF9APaSprNDa1DEgPSqoXUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721532521; c=relaxed/simple;
	bh=70uBKlsSIB9UObOOlWBdrpPuwZWa0RSnPs3l9kX1rDc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NsvuHoUOx+rbPVMV3g4LVRHPMribLiHSL+A1asWLGwI4DzIgWMwu8P7BJAbq/90nTLtShuHlViSt6OMlz85QDtGw1QD2OUrZcCtFfXCHPF+yr2jV6aAW3P0VQpFbwAFst7EgzykeNtdhIdaQdtk7w5BEvaOVYX31lBUUvvn4Mc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8041a66f2ebso475368039f.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 20:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721532519; x=1722137319;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70uBKlsSIB9UObOOlWBdrpPuwZWa0RSnPs3l9kX1rDc=;
        b=PyLy7K9Hji+OlrorXYJEbCyYIIeWG8Vc8mPKoJY+mTCAfGlRiSa3DCihrHwykUUWlk
         OZLpUcEhbiAPQhUAV0bOFtaLVaKDC9m4M7cY5EgtK9s2JYkbLoWWlusvrejiEPpV8fwR
         I7XqwlELgsO4AUFTTk9K0GW+ksueYWdMr1N+sj+oOzpAIbAtfmuyLvZvdGjqKRraInKV
         CgmWy6JoeEWWyTvsTy7rsCHJfO3hFdOjygiCVTCzrlKzy5YKVqzQYzXudkWQqgte/R40
         o7vG+3RHkf8FnEsF+ZihpVF8ozUZ7GCckvPZFfJjqGT398wsuaFhGRzcVzOZofl8mrkX
         p5pw==
X-Gm-Message-State: AOJu0YwXeETQLAMEoWdmNeCXpMS4/zMGK53WbjeAZTGYeLDPubKgfbJe
	XWWHzO68q1TtJP4PfSqstcMAapB3Wua/u4QTM4+++gT2eGGm7lvz5QZvTQrROyt+RXEZHnvNYUg
	0yo4dv5WmoZNh7zHjfS9kfDoM8PqW2eTcwMhB30RsqYfKVACrErHBYCc=
X-Google-Smtp-Source: AGHT+IH3kqTESnOj1cMGx4oouHJZI79plUkxDiWGSXd6t1pi4261gZl+C8+FLYFuQzwHKiowdzQ73lImsRP4ajc9ibaGZAjkDDxv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8319:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4c23fe6d2c6mr231895173.4.1721532519011; Sat, 20 Jul 2024
 20:28:39 -0700 (PDT)
Date: Sat, 20 Jul 2024 20:28:38 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043e804061db986e2@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

