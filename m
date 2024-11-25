Return-Path: <linux-kernel+bounces-420545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B6D9D7C33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9303E1632D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9243D155747;
	Mon, 25 Nov 2024 07:55:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9E2500AE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521304; cv=none; b=Dq5LCvazlupbW8/Vhn5M3O4+BhIBcpKL6HThXnI1V+9OG2ysRIzIuPtUHMDMGnG3CViNbVGUawQL33emOY/iZjoJxDem6UWAdbL9msMmA7OqAQ4uXfJ/nPSMFcFSd9KqS4SKGAu+LQD8faE7fvIfUGVZY79XFW/wl80/eXEu/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521304; c=relaxed/simple;
	bh=cQCFdHI5v7iYD+faZRpRS4mdyyhWoFXP8q6aXTjO9qQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rOiP+CR4ZsiLahlN7FurhPY+jFDutGv4Jzqj55rG1P0LMg7PvGRNZJUj20Cro3mQ1J9t+q6OjGEcGoBijpRrasSsujwyZAS6TvqKj7Om0VYf/EUM+4sCZyzi86zpiSK8VXu0JMOJIzGMm4B4TqPvJTNkTebLqfNDG5jGJN0JMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so47598005ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 23:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732521302; x=1733126102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wuzzW3kznStW1ZY2qDRz1ckqBaso2qsNpoMZ+p0v5k=;
        b=SwqySh3uvXuQwP32fEktDiCcA/3ImsL5dSGvavxIepj6KVw6lFhzQdv6VfWivlIOdO
         EfihuFVrJdVB5ujTpDe6/WR2tXY1SYBRC8iF36w8SMai86yx2ASZ8gFryk5710BJq7sw
         bqQqPeI4Nd9rW3XtxMSQl4mr5599UUb0jjGq+/07q12cpuGh6ww+/hKLWL8ocxDEgaLy
         Q6fM2j8VgBcyjhrecIvN2vjJuixUTvG+nTrlwn8UQ721Lan5u3U1Z2YIz0lNQYOa/hMo
         DyNHDQtoC22kCfL3DGWg77uninGJfSAJgF+S9GEAwSaZFTMxLcyuishdVY/gdHUF3p27
         VdWA==
X-Forwarded-Encrypted: i=1; AJvYcCUinxQsZGLs/B6UIidellCG40f0ZS8nA2aY9pfKX/TAU5JxsxDteH+jj4/9JyXy7UyapP2vcHHIbwcT8YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXMLzp3sWM1F7qslXNRwwlBiRc+BXnHMZIk9OdkMmsU787seM
	8ZCoiPtLSshG/rcVE4HMmJmip9ioTDT+nXOLeAbv+HMDEpaLJ+1LHPEgxtHIdGggcwEzX8Ts/Hb
	0JabNB9jKKIFZ4pE2ecbYc2DkcZThuRn4n0o8psqgHLaMslgxWr/qpYU=
X-Google-Smtp-Source: AGHT+IGsewLnsQ1A1gYxwSgr2h9LCzTj4VsCBHSPniYDrfo0ClmiaqTLkpQ4+V4EWuDLmvFu3SREZrMjm2FydpjyXJ5FPiqdvfLq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c8:b0:3a7:464d:36a5 with SMTP id
 e9e14a558f8ab-3a79afd0df2mr132812555ab.21.1732521302016; Sun, 24 Nov 2024
 23:55:02 -0800 (PST)
Date: Sun, 24 Nov 2024 23:55:01 -0800
In-Reply-To: <CAHiZj8h7VTOdp3CnbocTn2c4QnVDQi+YeRUDACvoKgBDYi-4eg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67442d55.050a0220.1cc393.006d.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
From: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/linux/page-flags.h
patch: **** malformed patch at line 26:  	return &page[n].flags;




Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4515f1b6a4e50b7
dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174b5ee8580000


