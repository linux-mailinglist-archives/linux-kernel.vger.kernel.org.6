Return-Path: <linux-kernel+bounces-220432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F66690E1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5771F23E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 02:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B2251C5A;
	Wed, 19 Jun 2024 02:32:11 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149A550275
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718764331; cv=none; b=ZJjUqsVsJPkHyjuDlAMpsiNLUYjF7sg5SR2SHNCzwE12qpSSpFqBo+Y2kXa/oc+FUA+UgPnxy+QxJx8lr9d4Zi/lOo7fU7inXw3VWUQY+Wrta+4EAz6mq8Uobls8PngtdmJiO6L9DQbOLb00WDdTWCsuWW8y3hIiu8stpC363vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718764331; c=relaxed/simple;
	bh=9BlIOw6AL9/ijp+TJRFrzlfX8W9IoV29wCMdzmF/haY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UaJIub6wVFSsuMW5GiQvfnyfz29ngl0L4XEV2mW3HAQydO6M2JUEXt1x4gK0ZzHgiFeuxw0H9OedDom6KaLE6ucBswpk4Y9BBpBEGto90PLJDwKoslDahF1cjQir/F5N6K/P5TWtI4OTFrcNwEbAqmxlBkMrCoKGAxSJaPABTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375d2ddeffbso68897745ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718764329; x=1719369129;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BlIOw6AL9/ijp+TJRFrzlfX8W9IoV29wCMdzmF/haY=;
        b=s8lQaBkfQMiSrrEq/HbMJlT3VYavQpXRTovEsGoIxvKJ9q2AGi4r4vBhT1l3aX3n6Y
         ZkCeO1jllk95GrI98Z+RwihIZ/kbx6wOufHHB8R2GZdKShVor16hp6aWmiOV7sIEyXd5
         y4SIMxOqt8sWFk1NFcVauERiowq4grj0HAtO3HtyfBM97OSYMoIFyVtse4abjr8/Soqi
         D9O8TDeX7qQ53umwto4PRoYdh0okpTg1QdXX2Vzic0V9Bksmm28gKWxRotPfH6f2QWR1
         g1w+WhLMFDIu8clqXyoJz0IqFGh4sJ1aHxdPfkvBSPDeFuMI3vZI5tPs60eMfVVkk78d
         zdaQ==
X-Gm-Message-State: AOJu0YxvqoIEg3tnrfgQd4zyXuwvhMeJDqzVeGlvnRxTf1ppgqs8AGh+
	buYSTTwC6XsgzxiEb8Y/czC+tx42x9ZuPzzef7o2F8GZJp9tQ4e858XwezicHzyu52wdsWBLsfC
	i97Di4sYvNM/DHPJdZLvvFE0Eqbfw7NG/11nswhJHx8xu7+siYaLrxpw=
X-Google-Smtp-Source: AGHT+IEl4/DXr71snqQju2QxbO964Ng4hU+k85Z5xSUDl/xm8ry2BRK5pJuIHBg2rf6yXRvfoDN/VQIhQl75e1fiKnuJ7e2QFwk6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138a:b0:375:e698:d0f3 with SMTP id
 e9e14a558f8ab-3761d4d20admr754675ab.0.1718764329204; Tue, 18 Jun 2024
 19:32:09 -0700 (PDT)
Date: Tue, 18 Jun 2024 19:32:09 -0700
In-Reply-To: <000000000000681a20061a81a6c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b8d16061b3501b5@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in strnchr
From: syzbot <syzbot+33bce7b14333572224b2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in strnchr
Author: luis.hernandez093@gmail.com

#syz test

