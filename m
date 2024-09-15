Return-Path: <linux-kernel+bounces-329686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F89794B5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD342830DF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA37182C3;
	Sun, 15 Sep 2024 06:11:49 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099361B85D6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726380709; cv=none; b=ryuEmieU6W+3aMPvsL/AgoG3JM5UgrJwxJi5esK4g+fin87Nz2nGYPIbvCIWBKDrbaI8mw0mmDKyFtsvJObWFTwdS8TuayWITHCAATkR4Z0l/H9UN+d+xlwXZvSs/ZN8MQr2WKVg+iRylYWfF5x1eM4ySZVip1IGDCdcGlaS0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726380709; c=relaxed/simple;
	bh=krM0vfjQ6huA4N4SXybTbbUXxW2Fq2dbHTuBWkmzobg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pmz5ihlEMrie9pm8nWdo6K4qCvbvqyggTa7yViA6QCNy5/l1HGXSVyUE/m7bWGYdO2liIbLCdySi0DqoGUmgJ7/qM+IgEGArxAbUxsUn9P/Q58UNWJuQUqw712LZmtIOD9RAqpISubmbeMiKx3tCIscQKqBDdfLk3H/lhUbrCpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a09aecb414so27872015ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 23:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726380707; x=1726985507;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krM0vfjQ6huA4N4SXybTbbUXxW2Fq2dbHTuBWkmzobg=;
        b=f+E4SOIVaXu2FZEIq/8wp6rbihd62TN+j2XHl+UlpK7fYXvnkUIOA/Lvy5TgcJuRVL
         3rZnls/f9elscp+xj3q342fvFwhk9sWA6XWP52Hn82UQZfdQ+cuht8M5lHxjMxU3KoSg
         A6hZHt/Xe10SofdALn8WqrM2xGUdvE6BhsNlHP7xKpW4QsE54kflA4ZUhICEjNOY7eth
         FTMMDb2LZK7H8mhch4V/VlAgcAPQXLC5os4Di0ABPWCOZXboVOdIbuJEe8r6BPJszbRx
         LuCZJYOCHD9swnO5JLSYfOGaD5313RdU5t4wEY8naNwTh+rznH+NRglbW93SHhyPZYdh
         arRg==
X-Gm-Message-State: AOJu0YyZBt3ekKRLZXe2XA23MHKa9ZE1nKPjIX2d71JvW28woPfift4L
	4L7JurQIbSP8g9iOJpBWiqIX8GMUkNf6dC5SCJJrKn+f5Dik11OOsBn+Ih8VDa/KCG+OdSqs73e
	0w3xktZTW32gE+TA6CMjxdzLD/fu1ZDc980Je+wp7luJ1QH8clA4fMgc=
X-Google-Smtp-Source: AGHT+IGjVktiMuLWJECbiF+IZlIsZ9MGZWs2fMTVS1U3gaaFTWtpforNtl7WYJZaWdeh2RJ049m/F+7UYKanxhXW3HyvFrGT1ieY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144e:b0:398:4bda:cf66 with SMTP id
 e9e14a558f8ab-3a084942bdfmr134727425ab.18.1726380707059; Sat, 14 Sep 2024
 23:11:47 -0700 (PDT)
Date: Sat, 14 Sep 2024 23:11:47 -0700
In-Reply-To: <000000000000ab9af106150da113@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000caaab006222254f9@google.com>
Subject: Re: [syzbot] memory leak in corrupted (2)
From: syzbot <syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: memory leak in corrupted (2)
Author: danielyangkang@gmail.com

#syz test

