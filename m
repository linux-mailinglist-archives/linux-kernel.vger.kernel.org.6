Return-Path: <linux-kernel+bounces-235788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B72A91D9AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2A21C21BF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7699F81ACA;
	Mon,  1 Jul 2024 08:07:56 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489B39FF3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821276; cv=none; b=MZ6ohQRSkU5yx6vlDqw65UaZqiavKjDr+TMj6oDw+ye8sbyuiDFHXM8IaXpJ029XuRsAB/n/dtcSYmpc2bOnoZUA//3TxnGuciLs4JC6dP35srzjWgEOmHg19Cwgk3oa7eH/Eo6obVc1SD3KsckoO0CQnBuZHfm9ooZe2eCn/5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821276; c=relaxed/simple;
	bh=Bz94elEHPz1zbjvcEHFc1YDv3mX8QFoL8smTwn7WggY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WHqGOjeiQ5HcCrUksbxty9eNEmACH4mZMBr/ru8owA2/8Ti3xaAn8nmxZCu+VG3USg4jHBCpYXvueNTgx+GXcC4iLqqyYimZ6YZ6N5eEGWUmXUV7R7PTP/GGxNDd4LMsbO8Q0KLHc2+7KzBbDN3fpmdo2626xuK/DmDiBm5K02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3ccfec801so283110739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719821274; x=1720426074;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz94elEHPz1zbjvcEHFc1YDv3mX8QFoL8smTwn7WggY=;
        b=hbGMxWiDOWl6i9Rsgu7imTo9EWanmdRPq54V6RWDbMrVoSZVdA3lX+bAKivXJw6nW5
         nfqFHS4upCFJIuGUBVKH3EUTc+XfGBOqZiDZEKzIbl2tg788GA97wr1RWj57j8GxdLmp
         LQ/qakEdj1g5IjyyqHbV3ZY1WWcRnFh8WOkQ130vZRZZL/GBMlnKnlVKKXr/AgFsr56Z
         nJYe9/nNn9S9/KEkniib0XPnaR+zwQe/CasmS23H0Qn/71wgDaLYAkxssuqSDFgmYJC8
         cD/lSiptPsLtbT4CJtUCHIjLiaqAZLRsbY6konSvyyHNDdblwMfhifWMc3sFX846VGTa
         Suag==
X-Forwarded-Encrypted: i=1; AJvYcCW7+gFf8BJY+qo7nauOmp3HvsOae2t7+eVzEIsI7JFm0z+joWdYfrPbwc3M4WrGJf5Tw8X6JbW0q6EB1082K8/Ayg7QUEv3bItH3shk
X-Gm-Message-State: AOJu0Yx9r7eEK/EGN2hf3nicEOYUcKjHtk8FFSw5qO9q7ieuwBKQ04eN
	mG3kXHsI2Dyt7vJsolYS1eFrJ1J/mWwUrDpkHrqnhLEo2F2F2b684kae5IrcPUd2c9OQ2vUhPKN
	0a/NMyNQdH/gyxqwPfX+v5V5oMGQNfhdtSynWhuBiYoJTOvGWsYjEgeM=
X-Google-Smtp-Source: AGHT+IGM+KRUlfdwC7sKMrEoWmEDCHPnF5A0mWRnAIL3AlDg7Dq3iCw4eQAyXOQXQyd7CMQSLs7AtOA6O6Ve7+pXeinV14HBjMKb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc8:b0:7f3:c811:3389 with SMTP id
 ca18e2360f4ac-7f62eea38bcmr39531039f.4.1719821273914; Mon, 01 Jul 2024
 01:07:53 -0700 (PDT)
Date: Mon, 01 Jul 2024 01:07:53 -0700
In-Reply-To: <20240701080749.12221-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bf25e061c2b187e@google.com>
Subject: Re: Test head for issue
From: syzbot <syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com>
To: wojciech.gladysz@infogain.com
Cc: wojciech.gladysz@infogain.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux

want either no args or 2 args (repo, branch), got 1


