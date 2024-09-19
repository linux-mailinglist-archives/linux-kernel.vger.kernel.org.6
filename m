Return-Path: <linux-kernel+bounces-333832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F0797CEB5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 23:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2FC2848E0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F514A09A;
	Thu, 19 Sep 2024 21:08:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFFC142659
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726780103; cv=none; b=mOjGQbWPS1h5/voGwkNDVvu/QKxzt/V/X1rECxqg87IDhy40w6mchrzgFu+mo0xGLSCGhegP5W3MX1a9Q52Ee0gBwehAdB85a80IcFKEbkFhvXLICPY8aCsLAAnJjMmzEVkRUT6rplDRXFGxZW+iaCGKNUOpKsNb5+mqS9840hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726780103; c=relaxed/simple;
	bh=11UbySa6dkYDjT9M66kSYCPLMOFE1PhiFbqRlZ1mVCU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ONpyEhrRv6jr+jqa76naBAIoejZu5uwb8ScZKlsbBXUmMQ+HpuW+CkzYkfxufaIZcC4koq/1YXNAbxEpaWx64C85wtS36RQxkGLxYgdSyEoMIvU2DuY8EyPBAXn0ZYmf4RMmM0HYA17pPGcVQR06NWyaalPiYKyjACUD1oi2RMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82aa467836eso266858339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726780101; x=1727384901;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11UbySa6dkYDjT9M66kSYCPLMOFE1PhiFbqRlZ1mVCU=;
        b=odUGmq2fSldH1VzUklMp/nTd0FgDfYyuBJr36Fi4w3hIxubRQLYOlhpbbsSeOlDa6u
         mf9Hxi1JFShk1H+0YJJXQdjOw+/rXljDvFgcCFAzen7P+LcqBlsLy+vcuMIE6rmfWA3Z
         trnuvrKdGMxwWNJRdrpDcLsjOQd825qy6/8Fo4AhZzLj/t1skq2Pd6Q3brXPetZdqNQ9
         /JWFaRJdr56agNwztvyYjodsU7b7wwfwW5pRCaiRnCbZlR2b5GfIPWVF9TCEFJIkUH4/
         CsMHthTdZlCh238lnk+qKDtJi7G9j4uVmK3/hY4D3SeLuNmEEX3M2pAjEN1+G6Hdc4Hg
         sTLQ==
X-Gm-Message-State: AOJu0YzadI2x+AzwfZpXyrmcugOe5sLMluLZrMwwqL4runydU9DKtmYI
	9GVZxpe9YXLo/vm2tXvRVxbpaG0/2G3O4kZmM4ZZZ8RChLqzrF04eGr33geYb5ZCmnMYgbVGeuM
	vDIyI19sxG90KDZ0kL1VEltmNbnc4hCH4SWQ4RsbICNyzsGKbwImb/hM=
X-Google-Smtp-Source: AGHT+IGn0xKjThVYHgOCjhY0cUhBUazJI/Ewbe7gYEEBYKivSG1tBW787gRlgXwPS+nkZRp1I1dxFTY7z9uEN5bFUELhM5EGRMlI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a3:b0:3a0:abd0:12b with SMTP id
 e9e14a558f8ab-3a0c8c9286bmr11142305ab.8.1726780101693; Thu, 19 Sep 2024
 14:08:21 -0700 (PDT)
Date: Thu, 19 Sep 2024 14:08:21 -0700
In-Reply-To: <00000000000087599b06225fc0a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec92c5.050a0220.2abe4d.0000.GAE@google.com>
Subject: Re: [syzbot] WARNING in bch2_journal_flush_seq_async
From: syzbot <syzbot+d119b445ec739e7f3068@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in bch2_journal_flush_seq_async
Author: pz010001011111@proton.me

#syz test

