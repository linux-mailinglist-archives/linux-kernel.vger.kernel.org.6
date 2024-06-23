Return-Path: <linux-kernel+bounces-226454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C9913E8F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D532281569
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA581849FB;
	Sun, 23 Jun 2024 21:35:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C212E63
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719178505; cv=none; b=bTbQ3D41oiAk06ODsZYTPRIBMvdshU01jXlYlROpFWkrTOmBVWPKWNVThpRpkGOwyFnKqkw9KEWduQLqONa9YswHjUQouTlD0JG/SSoBtlTSJmn5d+JJEx3H7DPjM6KBTuOZ1CulTJahwcU02csGsG15CVuESiYvL8ADR71TqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719178505; c=relaxed/simple;
	bh=Sw+TD4YyZoaMLMRdVzFbPoB0nEwbx30qseviAQXTbqY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YGW8AIhwvuo3AdPeR4fDC05+BXsLH/bTKn8DitOILEgC7M+vl51TRQZVg3KLGvbswOZMNMqPufQkJDVPUdNew9spuvGhBOqkO+LKIcH05GL/WdFNW6mnsfYQie50yJCk1DjpB3bHSaca2SibiDLUHe6gHq783ITXpgVl2s/F11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb7cf84c6cso448763939f.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719178503; x=1719783303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8kOgzV2rObAvsB/l3xiHbVFH968lV1DaVZFHOSTDXs=;
        b=R8eOaoJnersTkh0R/xmMlhHDtRZqpIHJje8BbeV2BRuguDVqkYet8FGCDN/F3zH3CC
         vV/o5WmSnTQAsrLJcZAnwUZf0cQLsXQV7qazswFmsRMKYizUF2xklu0EAjiONSHIurMp
         q//YeR+dlEir9AHU3RHXQ7WJ4oTo73G5NJae44F1RTyi08p6zXbs7/rB7C8p5HUuNyty
         oK13UKgNa7BgFx0AnoAmKCS8+F1VJSYcdQ+ZG1xlHCckEG9ezuE7OTImfkc0PncLlVjw
         KKuKs8PVICvEKyNsQ9E41pIUK1yPKgHwX3HfF/1LA9sQv3rwFE1lhS2OMtvDmI90qij8
         ay5w==
X-Forwarded-Encrypted: i=1; AJvYcCUOtcIrr1PwfA/0HYz9zQo1gmaKsYmyxyQ2CScV/H4GVQUnVjHaOMv/hM4LuuBF0+3kx7QBYdei0DypjBVPf0yvCDxdvHNztm62eK1I
X-Gm-Message-State: AOJu0YzgUSEC9JLsj0QpnTCgBdvOWWnEFB25L0WysOv0b75l6BQl7n+Y
	/0ua0BeLSWSTmXAzrIB3lkxO2Rfoh2D/lA52Dl8ZIgyxVYkx4t2KEg4VsvrGwWgaVtAbF6wHEsZ
	nUHEbqZoZxYuQWCnI7H2bZ5yICdC+H/X9SIdU2MYqk3120gV+Kkor3LE=
X-Google-Smtp-Source: AGHT+IGJ+Ve0VSmOgbbOEpBDp3QjKEZQntdY2P7eAZkGNoth7HBddnTGdPLQtRt72mtgrIVRsiwGcffdX6TmtX1QseweatoVvLIj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:379b:b0:4b9:ef59:1d1d with SMTP id
 8926c6da1cb9f-4b9efb7a60amr55087173.3.1719178503642; Sun, 23 Jun 2024
 14:35:03 -0700 (PDT)
Date: Sun, 23 Jun 2024 14:35:03 -0700
In-Reply-To: <dc1baa76-a404-4896-a1b8-affdb2cc4ac8@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003f03e061b9570c0@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work (2)
From: syzbot <syzbot+3da70a0abd7f5765b6ea@syzkaller.appspotmail.com>
To: jain.abhinav177@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/nfc/nci/core.c
patch: **** unexpected end of file in patch



Tested on:

commit:         f2661062 Linux 6.10-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=3da70a0abd7f5765b6ea
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104e8a61980000


