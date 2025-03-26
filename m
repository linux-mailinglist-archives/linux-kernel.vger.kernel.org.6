Return-Path: <linux-kernel+bounces-576444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7314A70F53
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDA1178DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C92155A4D;
	Wed, 26 Mar 2025 03:20:20 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396F199BC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742959220; cv=none; b=t15H8QoFyKag6TIKQlc2LbeKw2f+1INunTd/TjnBpOVkyQJBO2GaJtn3w4qgmVQrl1ZG7X6GjlNJu5ZOcBiOOktaNQZSOdygxZfjOvlWgPn47z/hkzCIyyATwo3BPCyELqjF9enB19OvAjOuS1L5sbOMEUHEHIj3aRG8zy89SQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742959220; c=relaxed/simple;
	bh=9ny9b8OZzDjF6cEsSrOnPRFxohT3o+etqOMzJI15+Iw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NKMlIyhu4A/doo8holYVUuS2OGByelk1COhMaJVhaWWJHIukocZRzRG4u0v1t/j4tIbc0QXjoPH0dKuzD+p7fEZPXuJJpvec2A/cVG4ctTZ6G/hmrKA6gMYdpHNIgIk388Ul7GORiOoAqrwrM2FtnlkKB3lH+Pgz8AahoY2Rxdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d5b3819ff6so22538525ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742959218; x=1743564018;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ny9b8OZzDjF6cEsSrOnPRFxohT3o+etqOMzJI15+Iw=;
        b=iYfJep/JzFiMf6E4EeDxOtik373xi9Eszh5Pb6GsIW41fqUQSM1xsDCfpn7CPffC1i
         MYjItpfq+b/U4miQbZ+k5mp0MJkC25rv+7Z4lh7Q+LW5lPdOWmympigdY0BWujFHNwqI
         JEa/2FTjq65N5BLgJ4mdJEcPl3Kk1KAnufxBp0Stq386AqyD8oTcGpey39IJ3Ze+E8Qt
         XcfPnq7RDJxWKqlJggyt907H9zqPo5F0Z8HeZ1ZRX+VxxRoM99nNZcmDC3o9sdWJzgsX
         B3iWe4g9Of8gR/V+RTEr5oFjAiUaA+H6x7oyrsPFyIn0J0XQZ7FieDyNoh6RLta9o9zO
         B8yA==
X-Gm-Message-State: AOJu0Yw3h+EuuWYAmpBFnd1e6mRTufW5WQpzEX9ZudSzePeDB6iDTnTj
	pb1chzTFDIl2YGb1BlSgGb4ENifwIL1uL6ni/rEG/7b8M4GcgDsxjuaDHcJbjcq/f0VX6RBjZQ1
	HJyds/4N51Oln0eZdN/ce3FGAkFc4OTbftjBH6loA+LyUU43brkeITjQ=
X-Google-Smtp-Source: AGHT+IFcrluuG6HxiUa4NB0GVJx/3M9t7kK4I7Eo17d5PoVMCmnjB6LD3dRcD2rfuqptqBMyOgQ/Sz7XojIAIbo5DC3nMA+aFUbc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcf:b0:3d4:36da:19a9 with SMTP id
 e9e14a558f8ab-3d5961680ccmr170837045ab.15.1742959217971; Tue, 25 Mar 2025
 20:20:17 -0700 (PDT)
Date: Tue, 25 Mar 2025 20:20:17 -0700
In-Reply-To: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e37271.050a0220.a7ebc.0057.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
From: syzbot <syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
Author: richard120310@gmail.com

#syz test


