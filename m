Return-Path: <linux-kernel+bounces-373231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD149A5406
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 14:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403C9B22CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 12:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A1191F66;
	Sun, 20 Oct 2024 12:38:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5065722338
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729427890; cv=none; b=ZAyxfruezgnPfF/5LRTh/O0lFmM+PpsG00EqMvbemya9N0sFVSYFmyABrcqWOjWLhzWnGmlcmfwguj6wg/1Vd8nkpucm8LTEK/IX9V7dILvcOVee6a/29c05wb1GWUJcgQtrrsTKli3kU94blRIs2PMXVa2OJ2HqfvoviLwHmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729427890; c=relaxed/simple;
	bh=7BEFaaok169hD29f3U7ZM6kdTNs/02qWrX4flaRMq2s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PKa181pfNGt+1N3E+7GhaKnt6cb7nt3I4ZdRMu4UGucKXVigUyD1VBHqrfDvaWtpfN6CY1dbd4A0sbnSysG2nxwah4KAosdq18NHN/pJ1lKU8eNWCF4kVjzPZma0od+uzjdf9A5DmFZZcUKegAYmPp3YX/R0OXdcCI1IdR4LGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3bb31e3cfso31829875ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 05:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729427887; x=1730032687;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BEFaaok169hD29f3U7ZM6kdTNs/02qWrX4flaRMq2s=;
        b=t/BjUZZ1uaQYdQJ8XC/npGhqhswieJ+i4yw4wh+qLQbloerO6rK0GwfeeA4DSfBm/5
         bKzZBhJ8LAVh4AgGNzeLhc8IwW3Em2HsS7nBOl7lLOvnVdPeO6HD7vDP7nbrFxPO9KCy
         GsMhZWGGFnbZp6IP42B4EhOE81odEpVTWr2skEClnvXFBWUsXmhz4p8dug6AkqNpBoka
         3ocNWqSnHef5YZBZNYtbdMqWFZ30KmsXlKmx3LMqTIDa63VBNtjPTbsY/8ZRdNU7nlF3
         6bQibYeXInG88zdG3iGD+UAHFcSvmLsljc4pMKv4SuYBYti2FBgrG8ryeNNIAwhm6zwX
         iZPw==
X-Gm-Message-State: AOJu0Yy9D+ejjK7MinzOIGGfAMEfnY3aQ9njGxUX8wFFjdcD04ff/yZb
	wA+QXO+omTPqSnsmcr1ZgoNHfP8GqZT3oHYDN2FpFPRc5ZHAymTXE9rOJ314yYyJ9uml18I6B6K
	6qDXA8FGkiiTTAbBGvCKVw7s1DY+Bc8qtIcULJofvJCC6iJudmQX7Bys=
X-Google-Smtp-Source: AGHT+IHQxMLrpTlNOUY3+z24jXIZ9GMpt30zYHqEcc2D/19izpvqnxwdOKFm75EtXgBAwG31r8RX+spVWCRb4Cl2gvXYXAV8R9L1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:3a3:b45b:a8cc with SMTP id
 e9e14a558f8ab-3a3f407449emr70441655ab.15.1729427887349; Sun, 20 Oct 2024
 05:38:07 -0700 (PDT)
Date: Sun, 20 Oct 2024 05:38:07 -0700
In-Reply-To: <67109a9f.050a0220.d9b66.0182.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714f9af.050a0220.1e4b4d.0040.GAE@google.com>
Subject: Re: [syzbot] kernel BUG in bch2_bucket_alloc_trans
From: syzbot <syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in bch2_bucket_alloc_trans
Author: pz010001011111@proton.me

#syz test

