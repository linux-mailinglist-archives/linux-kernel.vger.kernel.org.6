Return-Path: <linux-kernel+bounces-396113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF93F9BC7F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E2B2837E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF701AA785;
	Tue,  5 Nov 2024 08:26:41 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9218C93B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795201; cv=none; b=X9PCLIoNMMmubC/0BeqEOmbLQLZYIDdkfW01Qx77WwEF4ob3VnHbl74fgNbJnlESaSjvVjbRiwlgMLG46ALf3L6ImBrEsYr1ph3dYCuqlaFppMRLuhaLWmNaJ0/T9mHB7GY3uMAaX2IkzsB6TGLQlVo53WocT+6KPuPrTPaZ/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795201; c=relaxed/simple;
	bh=M3lD6cxcnkextQjPr7CViWpMtHaB30dJ56Qz42cJpCA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=No5yvSTeLpwUe5gtyui7Va4yVquLtPSEBvhu5l/GQj9LkoWFhtXtkJfBhCUw4WBggNdfQR3UUNMXCuPPH4YYq5DbcrH8SH4wCJsBaEzdP9ZX9rvLSoE6oxsnCNBSq5Ajd5sF44IAajS2hi2HK4pFTnkxNRn2s40AKT/XV0vyOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ab1b39ab1so517463239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 00:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730795199; x=1731399999;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3lD6cxcnkextQjPr7CViWpMtHaB30dJ56Qz42cJpCA=;
        b=o5rxbAF4tDLIw3oo8eLY7aaP/J1UhlxAP8GDnACdbHqCbpEBtl1vWNFmOllrHfO+lU
         toKL7Osy1TnJKUOR1ybLbRlGotkmSQLzMLb87EYBFBePfvohnNVjXYSzHztkNnAUGBrC
         NSkLjvz3elI6EvGJ8GXrjwMhbxp4tLdjUQxKPfQS1mipcUj6570poFcy7OMIusdGvp3E
         DCN0pTqMLQvbmlWwOS1BKfU5TQPmlArHDlNovfdZbD6A0QExs9vlMJJkJGDk2jmHybhD
         tDYJCE2sauzx2x1iB3TH5r88KkiKtdOwoe1E5oTNDa6vGgu/GWPLlDPBvuI7GfxxlXRP
         JJdg==
X-Gm-Message-State: AOJu0YxLptiP/OOP3GOSThP1qte2jjsHyIn/C3svFFjGtJNZPu5DWpTl
	GjRZn6NIuJtpIVCWApJfgM1N4W7jPMLhtXHJeewSIqaUgHFHVgmST/cSHARBvrYBgHv1HDmWAoa
	num9n7Ofilxw0aH+WwNbXyGIAKOA7ToJ9pJRI4fbyiML9MPF6lfOsuhI=
X-Google-Smtp-Source: AGHT+IFwMOfNDUSBuqzd2Yk6iQ7bjLGiNtFW4WRv6evDedsXzgkoL1pVy5lbQvkzZGcoPJpFrsvpiDGuJTbjq0HxusjZUGgwF4/t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:3a0:a80a:997c with SMTP id
 e9e14a558f8ab-3a4ed2de690mr365950815ab.19.1730795198784; Tue, 05 Nov 2024
 00:26:38 -0800 (PST)
Date: Tue, 05 Nov 2024 00:26:38 -0800
In-Reply-To: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729d6be.050a0220.701a.0016.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in __hfs_ext_cache_extent (2)
Author: sarvesh20123@gmail.com

#syz test

