Return-Path: <linux-kernel+bounces-367274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7E79A0064
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB57D1F260A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FECE189F3F;
	Wed, 16 Oct 2024 04:59:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E81021E3BA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054746; cv=none; b=FKoLfn0jlQmqrM2wCRim67ZoOKrEREtegfbN/J4r4u47xk5ljCoa7Ak671D2ui8ruq8Q+zTtCGL+mT01ySKXjyy+Id1UBS3uV21wkZ0cDdiGRY5girbgGJ0Zd9j7hlN887VPdbbkujw58fone0CjKWcOnqf3ILRedP8JfINzBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054746; c=relaxed/simple;
	bh=kMHTYsZkQXqBnWXHB0heoL7X17wRSsDRSTdq7M3hZ4I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WMk6lNTe5Z9aBMFdUtDbhbsyEzdkc1cyUc3rJM0E3SQjfSKgnjbY+Dwvg2b54xCQWd/PjkJuyMN9eApr7ccTEURKybKL8Lqh8XvucZQb2uUdFvPjzO7Elo2SeBF68Xi307JG3sNN+BGNLxKZX8GkL9HthClHUiDK3TjsxcxjA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b7d1e8a0so35197005ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729054744; x=1729659544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3794WB3k/1cVxmaJ0FD9ncVo/7iFu/UEHf4D+BVrjAU=;
        b=qre+6W8dQzs3GV6zjeysBEOA8tkpvwdYhM/DUuvqYW5+MLoZbrbe+G2B71VQw0aTix
         EmftV1t/1sBZs2zqXVQNbx25fhy3pUEg2sJpb3pDTQh/aS2cctUtSHHbPS9Y+mFdGT+L
         7ZbEcgxfi4ZmGX+pQflRIq2nTjPz9fmdvCxCfcPcWnYXZFzf+4HWyMgF4hQhs/jheXJU
         mWpPOfWF8EPyxR6FLISCEn5eSsQTuuvjpcod+GG8giP6bGm+7Qf12hCWST6rfeKhwYRa
         6hOf0c8GFPFmFWw0g2ScIT8mvfDCpjqMaqUnReym/05pGlCd0W43SURjEfDgLDb9gR+5
         CJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCW05F0hxHFfmW0uiR4mo5UPsJv1y673upf22FMn5ZICy0cUksKho9IudDAUfCCVWnpsBBkSLopvx3iO7Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76Cg8TTjojmCzk+BKoOyFLQy3/zAO4bQRSVI+2TqY6Kc/IqoX
	UTKzlQopQ8acfxSFt8jzVTFcIl4QbW7LMKfbDW81uC9D2MJNQ0soag9ptEeMExDQjErbFan3s3e
	QEpOkrSERNkhjNaG5ZQ8NXxYN2bKhXuigtsfh9pAfOdJsfVjs9cptFfs=
X-Google-Smtp-Source: AGHT+IF3UI/Nnr6qb5ZAzYtTWxCYw8THoFk0YqsPQrbQguLumDv6IBji6tmUpxqT7GGFcAaDlWRQASe7igGPKo+NimlmBKx31uow
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178b:b0:39f:36f3:1957 with SMTP id
 e9e14a558f8ab-3a3bcd9575fmr105304805ab.3.1729054744530; Tue, 15 Oct 2024
 21:59:04 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:59:04 -0700
In-Reply-To: <tencent_696EDEEECD8C8067C286EC12EB4651899506@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670f4818.050a0220.d5849.0011.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_inline
From: syzbot <syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
Tested-by: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com

Tested on:

commit:         2f87d091 Merge tag 'trace-ringbuffer-v6.12-rc3' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1256b727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=81092778aac03460d6b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1770d887980000

Note: testing is done by a robot and is best-effort only.

