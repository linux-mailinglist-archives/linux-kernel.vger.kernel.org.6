Return-Path: <linux-kernel+bounces-297711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF1795BCB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFA0282BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A821CDFCE;
	Thu, 22 Aug 2024 17:04:30 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D91C9ED0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346270; cv=none; b=pyf3Ffl/vj4mXIf3RugXRXnqHicyqs1m+oxmz5QUADi4LLmuEJZw4ANdBSthMANEGExEmfM280ZJThteY1g6BX1U7Pa1PCp0+T/EpZJxeJuRl6oNesTz1gG636AWoL93AG2tL7gjTNxX3Ld+GGP5FqjiIHlzniHWgg5js0DAU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346270; c=relaxed/simple;
	bh=6LLHQQIYY1AfYN32edXb6CJxghy1h0YtGOj1/vxte2Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Oq44sT9k+PmeK+znkzywTKKn3DG1SNOVKhNlpzpF84WDeTUuNSXi5Y3BEMJBFsasHqtR1tGGRnnkd24S1cmscQgrsawhx5lDzPkaDh9prxwl8FO13UUdsCZd/ahxSUk0TTGguXAFaK+WNKkszszJzlvM6wpEvguAHziozLf+TCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d465cd64bso14267425ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346268; x=1724951068;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LLHQQIYY1AfYN32edXb6CJxghy1h0YtGOj1/vxte2Y=;
        b=UwI3gK+po+a1/ELJyKpUuNwlQqsBnVMqRTP+bmFV+7HevyAP5notVW1nzEz+PluR26
         c4Pbn2YEvQdBd39BAAwWg1Jcu8Za4G2civsh51u0pAPLi2hORbzFKyNNzhRIguIc2sji
         /0mqJh8l88GBjhZo4saZpUprT4IykwYPmJJ1oxpXY64JnuPc0o05NUHG5q0vzYFjw00S
         0GM9L35hWPUIfsprVSbaQhxc7tt+JJrVMgBmyWJLZC/ExlpBBftyo/Y6yIz5YPxVBvfY
         XwcTIvTcpRaND+hQJcmrj/qsT9LKsvaMnGsvXuY5xMngjvfHWYrtgrkvGHWbkXtMZsnn
         E/xA==
X-Gm-Message-State: AOJu0YyVoOVuh3jK7d4gUmH9P52FypduqpsF3U0EY0dX/QlTvhO1dV7a
	SmIZZnZw+M5YyQ8qrFEJuu0AyqmWeSh0v25pbatnPiRDpbx+uZCRvh8Jfefv5ohuhTlb95AyKF1
	UU1tfKvQxfR09ls/NnIubr2PmOc30Vl2lJkoDWWSThPtKO0jylHxV43s=
X-Google-Smtp-Source: AGHT+IHblKq/IzWCoofdgALTKArIUgoiQasrJObAN2sDJ6IBxmjSKoPp1EQcthgpHo0XvmzZ3jexnSukCDLzUBQdmDGA8AAn2j2g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:39a:ea86:12f2 with SMTP id
 e9e14a558f8ab-39e3a8daa86mr169605ab.6.1724346268092; Thu, 22 Aug 2024
 10:04:28 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:04:28 -0700
In-Reply-To: <00000000000064f7a40618158fd5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c79a53062048a6d8@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_checksum_update
From: syzbot <syzbot+8d0e17030490d2299222@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_checksum_update
Author: kent.overstreet@linux.dev

#syz invalid

