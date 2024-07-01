Return-Path: <linux-kernel+bounces-235811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0229C91D9F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86DE3B21F63
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA1A80BF8;
	Mon,  1 Jul 2024 08:32:10 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426239FCF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822729; cv=none; b=Ry7Ev8g1cVGRqupgXtL81x9Jl6oVV0Q7Jm8EIfOSYNw2NkmIN4GCQ45/3J63jNo0DY4Hetp9Nc+GBih+ZG3jCTXeLBTW42aneQ6yjnrEntAfqzGfDrNDZ0r9mNg1zBUcVHc1FVfEaQIru8MLlbHLwtXbo4VhkPAzNCYBiQZRXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822729; c=relaxed/simple;
	bh=Bz94elEHPz1zbjvcEHFc1YDv3mX8QFoL8smTwn7WggY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=rrm/ZLxaYCgk5cA79Hcz/avmAzLYdd96b89IgprpWH3oiIj2DCXhsrs/uQLNjAK08qy07exo0ls2Su2d32xaPkOreEtm0iJ11PLHgUv0NtzhrJdzFNoIGJe1fh66J4C5ByDbwDpRZ5HX2y8a1YVMcttZ4wpTsXXILKX5UpSXnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-375e4d55457so29886105ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719822727; x=1720427527;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz94elEHPz1zbjvcEHFc1YDv3mX8QFoL8smTwn7WggY=;
        b=Zeax5HO/V04rJ0+7+IhCWh5hLumIVrBOZEMwTezYuOmrXlLNgsp9gUENJ04wVWFLgB
         VcF40SxaTkmkv1N/xTH/gjWkHOxMS+zDh3jYLQOISnj5GU/3erKqZH2oVaeo715OmOog
         1emgmFXKDAeByNfOMBe6YPntu4yh5nLsivj9Ekcj9dJ5FJdAx3mXFdYn+FIaJgoMRy8j
         efOHWCoyU+WuxR9ddk4MbTOUvkQ/7VsmmiV2xd0QtoIbDHA0qQhHnOGGlgIubwmpCyDJ
         m7TAorNi19DQEo9ElEUQaRoYMS8W8AEbWAm/0AivbVpRCMad84kB8mGPAIniYS3r4PCd
         RWpA==
X-Forwarded-Encrypted: i=1; AJvYcCWxD3bmBtIRqR93J/ioDjnmPxqr9ssnEq8MRxc4J9bH62gf+UWfrIujIHXMWdcS3vBRikJKIRIVuuzr8f5dyH/Z3mX16cfW27VWYuRP
X-Gm-Message-State: AOJu0Yxnh9ocdVftKxK9uNNTU9eAQVXFHJzcIObiO4e9o9CYW0zYRxM5
	zI4fkYVGeuDNWBGNkVXZMvTnNHT/PypJQ5e7Z0c7pXxWUgT0HzdFj5up4lfu+SjQpQX50tE1O7O
	cLkQB7vgWHUUibLCh215484Hv3ZlqkZvAvI1iqDYQztOrZ3szHpIQ35I=
X-Google-Smtp-Source: AGHT+IFmEDVTBB7AcDzoYFPL6bAaF8jLYUJTWos1jmzdRa99WPUyfE0ncFrgyVtrmqTc14kcchXyMbc7p9fUuVdWDTy1TyxLDZm5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c605:0:b0:375:9deb:ceb8 with SMTP id
 e9e14a558f8ab-37cd2af838cmr1467035ab.3.1719822727401; Mon, 01 Jul 2024
 01:32:07 -0700 (PDT)
Date: Mon, 01 Jul 2024 01:32:07 -0700
In-Reply-To: <20240701083204.18577-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be6635061c2b6e63@google.com>
Subject: Re: Test head for issue
From: syzbot <syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com>
To: wojciech.gladysz@infogain.com
Cc: wojciech.gladysz@infogain.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux

want either no args or 2 args (repo, branch), got 1


