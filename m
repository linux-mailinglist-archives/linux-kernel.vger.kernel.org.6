Return-Path: <linux-kernel+bounces-297721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2330795BCC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5334F1C230E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9BC1CDFB5;
	Thu, 22 Aug 2024 17:06:46 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612B1CEAAC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346406; cv=none; b=uHrduvE3J5mMWaywSUsd3olXaiEAjInv/ej0OGHuWH7fNVBhS82NUIeSppDi8HOSiqrKcdlvxS5P9A1G68EPbhAEQnGvXCI8Hi2swkJWyWrhaDWF17fkwsGhZUbKz3heWkhOehMry/OhXArWibym/AKf1NB7HqH5czGHZ3nNWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346406; c=relaxed/simple;
	bh=/qSAb4EbQm8ZOgNZOPkJdeVzLRujU0+mkxOtIlIM8jw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R/bxlK8fQFDaNUGZmjUGSPFbFmLTGBbUnOqdBmjkzec8OeAfbzXBtsHCRNbQV46X+9yz1jvebNgKErdGPrjxMnTbX2iEEvhKMNlGu996jv1avr6MUMe9lGEdSZZTXwmTNxCMRe6qJv/Y1CjXwzjqx4DIXg77EtQwaBf2Iqxx9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so110975639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346404; x=1724951204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qSAb4EbQm8ZOgNZOPkJdeVzLRujU0+mkxOtIlIM8jw=;
        b=d6/QkFB1mE4lA9P7NPOHEVTHa/IVUK0NW5TPoGQbcr9YKefwaLZoS4+mRYTYoSt33h
         X9haoBFjYWKipU8dkRS7X4NnDPz+2qb3faO2t5YbBLRxxA/9Iqt+PT+x0xfTQwI0x9g1
         YSno5bX7WPTKnLzd84XgZNXAx+ZwZCEzsOe3PHnlpCs/ObYxa9kZwiczF8GmzVrdlUej
         zWCxvOLOiuFwrZwJLrdz/IJDjp/p1RluxaErNUslCIkfRPH1cnPdsJ5LnPJ3M7h3P6AW
         i+JoveW4WACrt8LKgiqzqEqIcqBfsMjOsw2+koSk0ob0LrH63IqGQ5HPryLnFXeumnb+
         rsEg==
X-Gm-Message-State: AOJu0YxijSqWXiuapKuNTv30F+dXOQdbCBt2siKZbZwo7Rz4TMFfbEpd
	XKn5shE0B0P8RWI6AixuCnKj1wD0G+7QYsA1PTynM4s7+1kC4eteqRTOy/czRJvjsx7xrgytMV2
	oUsrcGWswrs2QoPWP6wndCr41Sq7CKl/t3FpPlHKR8K7JdEXHUSmiOKM=
X-Google-Smtp-Source: AGHT+IGHWcWPFx61pIKYphXWB6NHsKy14eaNl9/H9JCrJS3oo37TwRcmE4dTpZ0ABQSuwzDxO2dMXeKHEyUpEicYig/4yh/zvIiA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d94:b0:398:36c0:796e with SMTP id
 e9e14a558f8ab-39d6c343399mr4202325ab.1.1724346404121; Thu, 22 Aug 2024
 10:06:44 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:06:44 -0700
In-Reply-To: <000000000000648e620617b9177a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e33e1d062048aef9@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_inode_v3_invalid
From: syzbot <syzbot+d3803303d5b280e059d8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_inode_v3_invalid
Author: kent.overstreet@linux.dev

#syz invalid

