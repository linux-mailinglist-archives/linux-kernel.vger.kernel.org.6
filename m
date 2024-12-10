Return-Path: <linux-kernel+bounces-439481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 433549EAFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD25A2876D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A5319DF8B;
	Tue, 10 Dec 2024 11:28:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFA3C30
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830085; cv=none; b=IUGiTn7Lk8OKungAF3NehbUOibW+d1xwwIWI7K0LsC+7clnVx3IbGYwnl00jQ4IotaHgTOXus53aJ4qLinRTP0e2XVR/8bi2Yy2MKScdF3N5uSznWaXPYS7xH6fYsWAeDvqzkSnAmCTMw1niLwxDWqpqkkyqYaQGF8TWhiWb0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830085; c=relaxed/simple;
	bh=SjzLnlYktmmuQSYJwrvYLjfA3iqalqSjR0DfZKvMasM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G2khCzzEU/GaD2Uy42Xw317BH9WN3sLGjfPkcQptxDKes1TxHSZ8aGSDSQlGUsay6TSRe/95md6TNNjmslJdlFn4mO+yxBqmtvD2lobOUONCHkhawpitpvL6tAJ1VBCwILLz0xSv9XnFpTC1cyp0dzMzuz40HcRHs2S6tXwASLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7d60252cbso52249645ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830083; x=1734434883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5mJrIBinMwAvu6LKM4Ymoxb3s5dCIQlf2drJ+Vj6ug=;
        b=WZJgoXYpjIf7YkyME0Jn+vTaGXbNDTt/lPR8VvG9kV8yU0DBJNipxJdxYWmQGGeH2O
         1W8bfTruaQ9XdFik9jN+jhMJwpMLocV1QZavMS/uDfVE5iF6kVbuXfYmnWehDzwDcWaj
         BhT2B/1AifbQRTUIhIjJSwVHPTenY/JgmbumYAFxMXgOTRv+vBLSns4j10TdZBcG5St9
         usPagO0CxWgTb0PnVDg8U6JOSe5/jN737I39RnYuL1FYuhHREcwcxlexP4qUhTvUkrfU
         qg4WefoF6FFNgW7jLdxx193sX20/h6rXO1xz9T9Yr+SXzud1OyHWWDwOhzr736Zue6gj
         yaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRG+K6kX06y2zDQAkROwHOtNZXqHWhJw2tw1/9zRrKiM+P9jwNaC4MsjG3aLHz5aMXWnGCbNURt0G7luQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyr1+exASd8z1QdrU1HuDBoojkDfUUpzADM8/fXQvUpRK/TzJp
	dW09PyTq6zUjywBEJOC3Wtp18WP0bPrR/GiudEY2eF9oxrAAo8HR6CcyBV7E30mkVOkquJwr4mP
	R6CKT1l5G09ikrtFVZlvG/5IW4PzCtegPJvOcD1oXtu/pTAC8UWQFhqI=
X-Google-Smtp-Source: AGHT+IETDEMIdnt6zw4hoGV8dEHqD7EAcg14sMuN8/OeMuUHzRye3czGbR9sL/AJxPOhTDxajVFVyEGQE5aUidc0FZk0SpcOP0dp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184f:b0:3a7:ca83:3f9 with SMTP id
 e9e14a558f8ab-3a9dd39adcfmr29942065ab.4.1733830082993; Tue, 10 Dec 2024
 03:28:02 -0800 (PST)
Date: Tue, 10 Dec 2024 03:28:02 -0800
In-Reply-To: <tencent_E4D7465C09A9AEDF6EEE4C9AA7C386F1D206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675825c2.050a0220.2477f.0061.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_search_extent_list
From: syzbot <syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com
Tested-by: syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com

Tested on:

commit:         6ddd5d53 ocfs2: Take the smaller of l_next_free_rec an..
git tree:       https://github.com/ea1davis/linux ocfs2/syz
console output: https://syzkaller.appspot.com/x/log.txt?x=145d7c0f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82d76f5a1a8b5c36
dashboard link: https://syzkaller.appspot.com/bug?extid=2313dda4dc4885c93578
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

