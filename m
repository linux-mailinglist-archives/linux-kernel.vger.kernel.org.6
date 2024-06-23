Return-Path: <linux-kernel+bounces-226459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5913913E9B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D66281034
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520761849D5;
	Sun, 23 Jun 2024 21:45:44 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F02F24
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719179143; cv=none; b=qheqECHygRRAYOn/J1bkEnlPqTHNhTgz7tGaMzxY+Pd3nO6ad3z+j4StUt32Y1Kx+iiXEt91jojvCJvrH0eN9z/VOk95UYeXejvQwCiPxWaE9eesEqQrEHo7SF5mengBkUysMQ0Gc2VMilgcLzDIht3kLl2QCLJjMWgRIK13NHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719179143; c=relaxed/simple;
	bh=XWOPTv8e6+ydYMwf1M8G7Z7eNV8IWZuS0lWTIBAz0zM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I9EPa5tDlO18a15KrLuhGYoYCkMIlmiFyQID53p9egdfILxziFi8pnTj3lL+GBJ9Uj/IxJkePI8WCVkmt9mLCnJ7fJn/6remS2Nva8EBa0d9oxav7sWSKnik9mLCdCIeazIttsed0s9KNOECCB+e/aZgH+7KFmMd/rR6Kx+gVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37620c37ae8so43099385ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719179141; x=1719783941;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWOPTv8e6+ydYMwf1M8G7Z7eNV8IWZuS0lWTIBAz0zM=;
        b=mwz0wgZ/73vkpzw1fNk6ZhsRaxDi5xARVcQzNg1YpMZkwWnHJvptRycecKGccilQiJ
         c1eH2bTmS81zyYOZRrSp3vbx2EfNr+YEUIrnQBUnVBbLRh40YMkfTRFgTOkfQjHp7uNr
         3s1Hlsnt1CEIvz1DLpHrbkWLPX3AS3ArxQhHVWpwT7vqxFDSjmL/3na33ubW8u1AHNQk
         XG6hE1zTEkS3QBrx+E7yp5DyrCtYNTHFBJslZm31D+e9bskaNK11tRY18z4bogIejzRC
         qp4uC8ToJrDmfiHYLkbrKYqi2gGwqNiaOHqvpxQZfZsxpBtwA+zKOpGfgNz5zmciv1SE
         j41Q==
X-Gm-Message-State: AOJu0YyqnRgZeqc+/1xt7Barjr27d3J6wYsNd5Jrwjo5AkOdWejNAlvr
	aGlh13YDMibkYE4vnqMtqICIx0xTkFDmjVOEof7bY/J1YijssYwFF6Sqb+D+O2OpC6eyeLnfDTs
	6vFx8yGofP72w4MwWMJkl3VKjm/Pp6KM21qoPsGAXtSrhxmpHL6887TA=
X-Google-Smtp-Source: AGHT+IFVGhG8SGG8JG9OJfqE9mtzIIYPRx4OmL05vj5CFbjXDgPwmpFw9xsqTf3ZtZXyKnYbe3LFm0Wq9yPsz6OYzE8myyF969t7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:376:11a3:a36b with SMTP id
 e9e14a558f8ab-3763f4a93a0mr3303995ab.0.1719179141748; Sun, 23 Jun 2024
 14:45:41 -0700 (PDT)
Date: Sun, 23 Jun 2024 14:45:41 -0700
In-Reply-To: <000000000000747dd6061a974686@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ca7ef061b95966d@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in nci_rx_work
Author: jain.abhinav177@gmail.com

#syz test

