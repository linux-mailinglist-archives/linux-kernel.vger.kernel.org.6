Return-Path: <linux-kernel+bounces-378745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADE69AD4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7D91C22258
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92CE1D9A58;
	Wed, 23 Oct 2024 19:29:35 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23B1AD3F6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711775; cv=none; b=kS3sF3YLkBZgOfSlYhN08Jf8r5mWJMqZ3DyWYadbmnyx1Gr6U8EDLxrg1pOQv3jgiv6BYo8Tg0bsaLziH8ZjSgGjXLoBEE6v3cszmPsTm3N1amffG20oTs4qzWDelDcTBcTKp0jLKVGo1/+bTgCuKAAhuAow3y+f+B5DPOlZ8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711775; c=relaxed/simple;
	bh=hihkxg++1I2d8UXzK2GoaMpbRjnUaSBa72NKtBV9OhE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ez2Pfya/dSgIh4UHKFNt+OWRunQgZ+3pr7R9Cv/BK1S76tSCEbMUIdK7jYF6yNgNp2fYkqk2dJcEbZa64wPJO+C4oDGGrob/bFODqp0qQNQEYs8fQluaPE2/g8MigiweNgo61vLkb6iTrue2Vv/ay6Avl5ZbRUzMRrSQcYjqri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b4395dedso1769265ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729711773; x=1730316573;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hihkxg++1I2d8UXzK2GoaMpbRjnUaSBa72NKtBV9OhE=;
        b=DAvVdX7ibWC0v99BXYXzeiseyIWvr/N50snIIj/gO4E2Wp3ucNd/orovMcwWTk5LZr
         QCAMtK9EH0v8ZTcfuJK5FIxLpQ99t5B9EeYmkWhU5nBhOc/KEA2rWm6JkbpuRtNUdnDq
         M5uQZ28M2jdrxVz91IKmHzRnxIkMCtcot/qGCBCFwRaFlnObAYFt52cUGY8lFCW02Hwk
         +aNNmNvsaxPy15Etm7JUBva/A4wHWgv4tbLU+5m0hhu7szgtw9qNXpiRwjTwNPnhcmuI
         XmZlrTuQoJ5W6lRn4HWsWa+L6S5TRk+GZs9BdxTA7D8rzqdmEIYByKwqcT2tTBsp0f42
         sE0g==
X-Gm-Message-State: AOJu0YxBPzeSWXPmEQVTJnWBfTcj+w5fRyscaoNMOkaMrNwIIJx65wEe
	d/YZpyLnqD9qcP6nfGsDFn9kk4s8+J9NuNBnRqzJkffCI3OpXVmj6OBV9m5NS7FXvz9SEDuO+jQ
	dtWbMHWuedMeP7EpmsQHoyTtNTm1QJ55JSPnX+jhGL9W4HLKLYkYf22Y=
X-Google-Smtp-Source: AGHT+IH6/T8As6yyVxttPo/oT2mtcTFTO+E8AcTH51+0nKlyLcpClSw3dOeDdOFeQQ5EfK8JETivM2FOoaNGXASno0Ohskj6+sUu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:194c:0:b0:3a4:d94f:5b52 with SMTP id
 e9e14a558f8ab-3a4d94f66b5mr22144155ab.20.1729711773133; Wed, 23 Oct 2024
 12:29:33 -0700 (PDT)
Date: Wed, 23 Oct 2024 12:29:33 -0700
In-Reply-To: <671907d4.050a0220.1e4b4d.008e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67194e9d.050a0220.1e4b4d.0094.GAE@google.com>
Subject: Re: [syzbot] [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in validate_sb_layout
From: syzbot <syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in validate_sb_layout
Author: gianf.trad@gmail.com

#syz test

