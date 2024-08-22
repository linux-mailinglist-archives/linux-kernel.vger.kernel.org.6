Return-Path: <linux-kernel+bounces-297723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CB995BCF6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1E6B26EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683261CDFBA;
	Thu, 22 Aug 2024 17:07:28 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C31CDFC7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346448; cv=none; b=Unst6lFhrGR2b4q8ZAxXiiPcAEBVQvfysRYJu9m1sc2VEgzZ5aPhZu5TQDrTHkvHj+HlqN+5ok6f4h8RXA4uQmI+zhyJGakgT1rOif3ukmamnxJcL3QknfIrLs5iA/NNuWLJYHcSyvYCaIWoqHewPhU6CvpzmFzd1UQKDDCtCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346448; c=relaxed/simple;
	bh=KqE8q8pZa3KwktBNz1V/yJfnYpn8l4oyDRhD7aQ4vCw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q0Aasg6SQiago2LjtedqX9RhuxgpZuX4b/bYU6nMSODleUt2ZGrsINjy1FcnhdjHAkX8fczHYnFMmRgvmdhg5ZKdeOMG1J0wjiEDu30FUvNuZJ1CHdb7HvyqC4OLu2/Sjhp+oKRbOi8zlfPShnQs9eejrUf14N18PDUus5dFnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-824c925d120so100429639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346446; x=1724951246;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqE8q8pZa3KwktBNz1V/yJfnYpn8l4oyDRhD7aQ4vCw=;
        b=K71M6wtbeRRDOZktEP4NgCMPHhM8HORZmBDqIZ+xdhRVcmHN5Vng0Oy/Fpbm/9ONE0
         FEqv/hVKwzCF7qFmHHqOgYqvuwS02qX48I64uxVs2aG3+ykOvFgYGqvviWWZNstZxVJA
         Ff/KujBgX3IZ5AcPjYsAc3ugfpRgdhzpGYWdjDE5/LtXmjU8tNzljqe3QAQkb5CqUxEB
         RqgiCcKW32ZgLaz735IuV+ZWzUeKrmOiIXSYXKanEcsNJTdVVqDx7Upea/nBkXbSK88E
         J9e0Yw0t3OA0mH8ZY2ctaebKXzjOL7j0ZpTTHbBWa0AD1jq+Qv63PXMSwwlp2hoEg+sf
         zBsg==
X-Gm-Message-State: AOJu0Yxxq9g/LDMxHJ3yKks7vBimzAKBgTgJPCompBEbcvxEzqYCpRcD
	ahzCDeJ0WNuCslQJdgbCelx4uLPusspBS5z1kx+N8XxFbVNwrUZU4C/s2JxT5gFdH7SU5FnysHl
	oE3ccnWyXTJ59qY3X8TzOGOSNFEJaHnvK6TLKgtoEvClzXVyId84RfVU=
X-Google-Smtp-Source: AGHT+IElAoUuD7RfBeLo4RN3xvaFFxKeba5V/gJKBCQzZzG1mrA/drMl6lybzsjdCEKaOC+RWAjOMJOO8ovmNtgn1QVjvbCIZm+w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8720:b0:4c0:8165:c395 with SMTP id
 8926c6da1cb9f-4ce7f50abc3mr17476173.3.1724346445561; Thu, 22 Aug 2024
 10:07:25 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:07:25 -0700
In-Reply-To: <00000000000060adac0617b917ab@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b8fd0062048b1de@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_inode_unpack
From: syzbot <syzbot+c123a98c7445baffb168@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_inode_unpack
Author: kent.overstreet@linux.dev

#syz invalid

