Return-Path: <linux-kernel+bounces-173982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C69E8C08A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D7E284502
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074547774;
	Thu,  9 May 2024 00:46:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC15383A5
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215565; cv=none; b=uv1XvXJHGmxJnlAg466kOWLZI42IvCPmRyp9C0Oc0pXxnMBJavnEAJ+ZliFwBY1jTTAVeg4+bs+Pt/x09gGpWR6ECABkPtifCU/3tdePxtI7bHM3ci4UA8yiiCXA+XwyJLNaxUUD8/MTbcGRyZKs0Ffel5wwv4+G5yxtm7wbn9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215565; c=relaxed/simple;
	bh=Vzn2Qf/gDPEnRu+n/nGCMvhjrdT1tVYCUp6z7sRiEM4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XFhcqab8u/ZaVu3JmcsbSmR4Amd+6vwmcPeot9hBa/2hihnIasOEhcNPK6/FlFSl3A1wvBMvmNYGkpwdMwCZ30/7qp5q1874RGieBGM2oJGmMjwKEb92Yb6j+ojifEEBIhI2fsZTZLKUdnRVgdRXUEUSmqzSIbpTwyi26B92i2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36b3c9c65d7so3387695ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715215563; x=1715820363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9up4b+NdcT+UJfz4qS8w9gWF0+kOcxQYH2wzXgPCIoI=;
        b=SrUg/aZfetf6rAxYIOySzW7I22W6gqzQ585wugtkxGAqRm6axNkiWNnMpvX/LiftyR
         /SI3SrCCkpPDtGcoUqWip662OhXdI3I0hRi8kfVar6bquZKWL7BrZp51obIJoIhcruCF
         DGdFbu9xxLhfY8lgHMcOB8rCBwaZ5At42i5biO7/z972aUkx+Rf2J3AL+jv1sh81OFkC
         XIpwM0CchzrxphL1Gi3tkJLwNEq60GuypofPC4xMAAoOqpAjX90lZz6xs6y0gVP0RBZz
         lj0jvPnGv63QOyfvyd4we8iDlL3TbPSgXzaUkkceIVjhGKHxC5t235sM8fXO9epAeN0p
         H2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVadt7KPbW5A12WrDYwEni+mqEINu8vM0oBNCjbfE1HEljBPSOhBvgc41ShPSUKTEbX/s4R04C8glTRTb0SdSeXsHbTTTTvMA3Pp9Pi
X-Gm-Message-State: AOJu0YzJ3t9Wk3bkdXQp9UZ/J0nddzBbk5rPr7itFmvRj5158DMUCU31
	YnlB2rQVKyqKV0ozGtT1l90KRnY17rVHR9S8sfP+5x+10BjOZv6nrmBAIlSfiAoSt9BCPkSwOYU
	58JyysXYELsp9C+bKjDOequAUkMVynwGxmhlCQVdtrUQRYCE0JTN16oY=
X-Google-Smtp-Source: AGHT+IF9BWRQkA90ODGpk8XnEf1UKfEG/BWqt+fY/5dm7O+EyMLRbR2+IPYbwjSoxtJ34m8UcxVQuyk7b7Sw3n8/RXjbo+JWWPkx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a06:b0:36c:2ed4:8d4c with SMTP id
 e9e14a558f8ab-36caed8aaf9mr2195235ab.4.1715215562832; Wed, 08 May 2024
 17:46:02 -0700 (PDT)
Date: Wed, 08 May 2024 17:46:02 -0700
In-Reply-To: <20240509002056.670347-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000560f820617fabeb3@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_bkey_format_invalid
From: syzbot <syzbot+9833a1d29d4a44361e2c@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9833a1d29d4a44361e2c@syzkaller.appspotmail.com

Tested on:

commit:         e7b4ef8f Add linux-next specific files for 20240508
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1528303f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ad8383e989930f6
dashboard link: https://syzkaller.appspot.com/bug?extid=9833a1d29d4a44361e2c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1735e7c0980000

Note: testing is done by a robot and is best-effort only.

