Return-Path: <linux-kernel+bounces-252019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF7930D19
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD4828138B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 03:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5F41836C1;
	Mon, 15 Jul 2024 03:55:01 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC9A3F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721015701; cv=none; b=WADBfVeD+gwN0FvnILsONjdW+wZx/YdAI2vb57b0w3LSgB0h3/hKC+rfVn1w6F+n7sfxHsXIOX1tmBeBpPO41Iroqp0gRV9bA5qMdsPNQrs3xc7uMUGtlHaYccya0y3heE/Z4syPY06MBcWDmpDZVRQX7eXCHt16x5JD7GtM0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721015701; c=relaxed/simple;
	bh=qV63diT1+B+3gTCA5RiV4tmyxv1J0f4bwZj2BF9wH8I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N6gihXwXPpmwemLMpTl9YgjHHSDZLOMhrB2Qz1ZLTE4pKnyK6oXlQ/sZllGl25cS4GX5Glm+7euBoBhyld45MPjsBqdCBUYs2BHbWXatzvIDQA6TCcqHYz5baDKWKd9hsfMMCgjYLhgPrxnczEpEWKb2bfc+beEAr3q4Nnh1pjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3810df375d0so40583765ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721015699; x=1721620499;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qV63diT1+B+3gTCA5RiV4tmyxv1J0f4bwZj2BF9wH8I=;
        b=ZofN53oDXgla3qOHza3XTHP2yXNwCSmgp4c7R/9AIbimjFHd2GgQKo44/NohYcxnnS
         ec/tQNBVMvbPf63RDxtq8MoxbgSFZ2XzgK6xTu0MSFjYwI7Qtd6Cb0cnspzfHagakHG5
         KLtSXM12gIon5rbOtIpAESFq0fy6/yMizqEXUxRZjDvXbJExqolvqQYu3OweznzKjalp
         u/aQCMmrrNTbmqmdUa3Ooq8TEgzfEKCqyCJ1MbFysdtqR87yQ0bnwgOhZROINU0+S0zl
         EAJPrQWtDGKdpaK5GMpsgQ/15hLRJbJoWpx+XOk0Aj7+nXiKlrjZfGBqjDChB2vJd4TK
         3oSw==
X-Gm-Message-State: AOJu0Yxj8qaqbfMe7fUzMupahqvHGHkFdMFquyeWO78uS2whjToD2Nd6
	x+P1PsgIlM0rU3gPzGDXYImJzknqNvKDY1fSR0SKqeC4DQlaSGMaTkI5UQI2Gl8hj0V6rAhgVjb
	iCexh6lyfwlVHo+5mE0vWl4xbHsOh/DmgUY5QsazSkhdtSqVYqb1l6Sk=
X-Google-Smtp-Source: AGHT+IGMPxuEcHQIKo0AUsjw6j1xXcgzUk2GTd8XowfblPe4Pil55KR+zbs4fWUeedLlCTZxDAoPvQHJLCttJUwz615S1Lpmjhsk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:78f:b0:380:e1e4:4ba3 with SMTP id
 e9e14a558f8ab-38ee32bac90mr3907055ab.2.1721015698799; Sun, 14 Jul 2024
 20:54:58 -0700 (PDT)
Date: Sun, 14 Jul 2024 20:54:58 -0700
In-Reply-To: <000000000000b1d03f061b4bf50b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006157ad061d41319f@google.com>
Subject: Re: [syzbot] Fix timer use-after-free on failed mount
From: syzbot <syzbot+59e0101c430934bc9a36@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Fix timer use-after-free on failed mount
Author: shenxiaxi26@gmail.com

#syz test

