Return-Path: <linux-kernel+bounces-190486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E10E48CFF00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF62282F47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648FD1553B1;
	Mon, 27 May 2024 11:30:37 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28615535D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809437; cv=none; b=IMKcpYOZPIg+paT7IY94cPuWduliqYa8aMZgQuO8kN7z8FBgBe2n3Bq24REyhV64QpVXZ+whTAqxwi4WhC3HEUoyljZu1FzG3UA1gLTttxK14YtDR2Ic9M6xF/13XblYXWQQbGY+kwPceI9BXQhgCCMofwZhzKQw3x2kXGS4ASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809437; c=relaxed/simple;
	bh=2yJF3Jx10pcEpk1tSArLQZeYI1qZAenMo58wHcP+Svs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lSo/mKO23sFrEaCuAw3SOhxrLVkFgfc6cdvehjnACqVbGyw0EgVQwl1Chz5xP6WdyjDidaxcZF6RuM+72SK5JLCfUjrNx6ZCpSVsCVDlcQM7UIdNcQomPo9CQtOys9IOaUMPg+cGwCeEayY5OM6Bt23oBl3RYSq0pHsQSZyNwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3742c0af134so12789865ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716809435; x=1717414235;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yJF3Jx10pcEpk1tSArLQZeYI1qZAenMo58wHcP+Svs=;
        b=rrGEicuE5szovvH+RWP+KGZN3pGpXsDYjWU1CnW2OhM7Q2Qsd5xbBG/nHVju8G8H/H
         szOmpl0AOyToOoiF0SidY1ClW55T+hFwQZZ+98rLvlISiP+EX1IY/y4Dm37KiWPIOiSX
         0FM3VaFJthaJtBfLTVo9pOV31JKZGPItGwXsjT2b5CabJtKF+baIlEouPnEOBie6/1jX
         JbK/fW9fVKtNE2YvUU38us1F9BTp/aCfZeYPD6euuCk+5fPZRKxLlV0tSKlj0e/UHqwS
         xNPI5Od01Pc9/nOAvHbGyJkNMsuMYaKGDHKDfLHBVh/T/3CMzOknFS62imnqvZKzy8D2
         idzQ==
X-Gm-Message-State: AOJu0YwQkbrLFIQoJE3ksybQ+1NGejANvH3V+yLfH/FQTC5JHyKKWtJX
	3HqfwYRDPXZI9iyCoFz8oLsHHNrwfwXRTTKazXmNCGgufp3ikSUjyC1KuLnlnNqkADFUhkR0Vyl
	pTjEig817MF8O38BQhTN7r2NMIWRIFxsVD4qoPomZCpDP1GSTUBgCUw8=
X-Google-Smtp-Source: AGHT+IESVbreawKS5dRj1wg2CpOFvQK9yjxDoqvA2WUf3j2qx+8JYaSgFgAE/IWA8K5EgvIuzKtq9ldewHDW7IezgfBxG51cp0zq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a27:b0:374:529a:dfd3 with SMTP id
 e9e14a558f8ab-374529ae1c8mr3180265ab.4.1716809432121; Mon, 27 May 2024
 04:30:32 -0700 (PDT)
Date: Mon, 27 May 2024 04:30:32 -0700
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005952ff06196dd896@google.com>
Subject: Re: [syzbot] slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: slab-use-after-free Read in chrdev_open
Author: almaz.alexandrovich@paragon-software.com

#syz test


