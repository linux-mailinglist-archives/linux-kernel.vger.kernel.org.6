Return-Path: <linux-kernel+bounces-315261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3F696C01A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454921F25CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FD1DC1B1;
	Wed,  4 Sep 2024 14:19:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F13323D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459544; cv=none; b=LZRJipnml95BI8j5K1Dga0vOEoyHJ7CZegx5JxzTLGs/xdXcVt0FSxF+i3lGVzyORJWC5Ya5o+zQPo8zTbMn/4vP/on5pSBfY8z0A/bc2Q2IeCY7qU/o9pvlR3o9zJ1v55rHqLKXqWn5funYgwKNFGa5h5O9kr6nYaSypqgUDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459544; c=relaxed/simple;
	bh=5h+8bV3s952Fy/w+5Q/QydKHGAk7oPvTDOiXFrFlQpM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OcgC/k58NedWC5u6cYBZr5cNW3MI8HVgeW00ZfpdYlBPkXnE/NducSs2lSVCJ1LWztTPTNvaMepuvHUy0jrJfTJOKp0IrzoKnMD3EJ8e+O3haqXyjCEpFV+URUEP1VDvpOF7gt6zot8VbAFzBCMBYCXDHiDKBgk5alUqWx7Txcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d49576404so10730195ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459542; x=1726064342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uXo55ekk1/Yt55Qd2Vq1apYHrsMcvZpEmgkRYmZhrw=;
        b=o3gZ8D4dcgfcHLqjuMe612TDhibXAPUFyzs6b19DaDdWv3u5au9kV1VweJckDESjPo
         r6L3dSVH7XIxEvv0KaXvaAvkrHH/bNNxWuiNnueEekGBMxf75teeqnk+xAUrIL8Wt1in
         4DcFGtXJWcWC3FKAKFpqnuCYdGSk6mPhGJ9lEZJNXaKZvu9VwFlqNa4IdvyJN82JOl9T
         lVjky7/2KqpkzsXI2b/p4wDA9c4F0TYEzPVYAO1IX30kvsEUabefgyUAknO3gqUydpX9
         KeQE7obbDF7QRoyHW9Vquc6WqTRyj9B37eU+tVYuV1nzeKmgpVtF5pXJtBIUqko7XzCK
         rRnA==
X-Forwarded-Encrypted: i=1; AJvYcCWEaaZl8Q6mCsIHeAS33jhwa59eTb8KxRAgZd34LPgfw8pusGjLKxc3uUohLEEqM6XD/V4Ubt8GeXqonPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/doa23NvpgbIr6buC77LljJkAVBibLdTaW7H+umShaXwy/Fn
	eOAnzLGnAKqUeO3nOsNkAi5Uurbr6El+EPwitSNFmPTGpF5e/rMDdf/RVK6UO7yz1R1f8gUyLbc
	jR4gDFgPkCsfQ15ISsEgFUUuVOO6N+eGg23jY6w/igtzBPLWvWhZnIEA=
X-Google-Smtp-Source: AGHT+IEKAHyEx8HddpFpG0RLmA34Hw/bABBYzXXtC8JlE6UJsPjjod/swDpCp/YuI9ioWDvndUHzkcak3/hFE806zMct5zy5VNcT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1524:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39f73ba3e5emr1785655ab.4.1725459542115; Wed, 04 Sep 2024
 07:19:02 -0700 (PDT)
Date: Wed, 04 Sep 2024 07:19:02 -0700
In-Reply-To: <12d6f5c8-a480-435a-8490-09e31d403e78@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000151aa206214bdb58@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in vprintk_emit
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ntfs3/super.c
Hunk #1 FAILED at 1472.
1 out of 1 hunk FAILED



Tested on:

commit:         689ecd06 fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=4d2aaeff9eb5a2cfec70
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12041339980000


