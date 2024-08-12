Return-Path: <linux-kernel+bounces-283541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D244A94F616
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C2A1F22BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BE3187FE9;
	Mon, 12 Aug 2024 17:49:54 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79814A0A0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484993; cv=none; b=KbR5E/uMkJRBFWRFPvAGIPL5/uunoXzS7jsProJ5qTeMmd6xcsOxAqARlVoEG0zRXB+aisFNovtxl+hSANqfC2ufseHV98QpSm2sH3J8oz32D08yEtnJHisybTcyya5k5qoqrQ5sFaLRMBmoK0hhL07CnLwa2tUmgTMj/WLRODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484993; c=relaxed/simple;
	bh=SATcx7gXb60Zgu1EMpXgbYeamJ/Bwx6cpA8Lm5dTxLs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c8keR06g5ZrO3n81nXD+TNRArgQUnFOfuZufCkwWdVopqekPCaP/+PcROxifiutkUGweHyxzQw69yKr8sMJsdjLPQlO/+rtB4lfWhINdOrkGYmBun7YYCdtYlsM6MjnQjULuCFajuNCzDViopDBXUuYXOg6i2GMoFipBvJJvH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-396c41de481so61679865ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484991; x=1724089791;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOywDPprPB4nkcZZlqy0RhhP2FOlgm1WtV5OufW4Bvs=;
        b=MtWZDYt+ycuy1BejZ+pesR5loU5hBCS40o3fL0k8VMpREQ6iHdaDbf2vRVUUJkmIzb
         yTzK+rL6baXqyksx5H5MmBqY/2HT1fden5PpD3mtDP9sXg9JlZb/nUY/uzAvyP+ycIn8
         Ir5wAYrHvwpai0dJo4mHEgGbEmFh7V3frJfcoU6IygeXtU53Yug/sAJocdXmt94oWzZ+
         u5oq5bpEnbfv98+dnfmfJ9KyAiNrQRyzCYxDPG2lXJXAqrkXdRN82EiMOkSsU8PNitOd
         V4AFj9CAXWKz+8g61+Y93vkDrU89viR55tB671N2X93pGMzXY0u8u3mbXaE1Dmg/QRHa
         9Fgw==
X-Gm-Message-State: AOJu0Yyd5YpXomhV9LN30EU7rjEQQzWchVMsOb9QA7dPmjRiuJQFi5XH
	kaoYtLi5TPGUCb03AseCTskYUAF3oM2aeWZtOuH/NW3+pfk7IqVT7oAgQbuCLnDt5eYnI90qZTR
	u3wKhc437Daf9ui4odxgjqspTi3dmq9WdbFw2jExORChnknbBLdH9rvg=
X-Google-Smtp-Source: AGHT+IGy3Z2R9ex5E6IQMLjMnaeDkfi2eY2ZdWCwSsE65l0H4wPd+ng9fUWGA1aZCSmgexBOBW2BJ0sbwkaSNSqkvB+2cxxb0prk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1489:b0:397:3e38:eb30 with SMTP id
 e9e14a558f8ab-39c47912e41mr642755ab.3.1723484991444; Mon, 12 Aug 2024
 10:49:51 -0700 (PDT)
Date: Mon, 12 Aug 2024 10:49:51 -0700
In-Reply-To: <0000000000004475f6061f548a43@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0ed7a061f801e1c@google.com>
Subject: Re: [syzbot] possible deadlock in __flush_workqueue (2)
From: syzbot <syzbot+e528c9aad0fb5383ec83@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible deadlock in __flush_workqueue (2)
Author: snovitoll@gmail.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux
refs/changes/82/25482/1

        Sabyrzhan Tasbolatov

