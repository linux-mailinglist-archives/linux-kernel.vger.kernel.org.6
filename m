Return-Path: <linux-kernel+bounces-254841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EA993385E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB83283176
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713AA219F3;
	Wed, 17 Jul 2024 07:54:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E90210EC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202844; cv=none; b=Enqa6n+FwmdnUTQSe1vkekJBXaRgeqA8nmmaO/QVj9ojPmuobqFAma0FVFuYF7HFL+QWA9JxJ/n3qSK/nCl/O8QjIyoPiG0WHNTP/GUIN9F5uQcpjQhDYKexyG97DjugFC7AD3Cvyt/4X0q82RkrBXCrDqFu3mzB2aotVes6MKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202844; c=relaxed/simple;
	bh=HTphJf/vtkaGyd9Fm9S2QENKL/UOHYmbtv2ZJ7xTSo0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z04ZjLw4VT3MH+1qwyPwB6na9G9hlYkL2caNYkgZNd8UJgz0i5Qb0teXkjEHzA+zjvYbhwEFWaqSI64DgRKVXMhi1pl5Cd2eHKbvP6/U2ZFzoVz9ZwmMKtSimCIYHNHOQ/dVFfa5ntUDi7i4E+rPcfUFedKbwLy4Bm3G7aCrAbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7fb15d52c5cso110820539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721202842; x=1721807642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=459Wh7MzFQMVmI1CINvASqTLvP2mJWqT1PrLK1j8cWc=;
        b=h27Uco3EtKI/X37uly+FEGsLq2RvG/aUPjy3+KOCm+IcvTNeNdqnQIpNkpumGUBQ2i
         6cLi6RqEXxOuhslb0/4xSYYbp83eUIzKdQUt4+FE4gVMNkuD57Xg6u8oKtDOqFz2zDLu
         +50UN79loE+Y7CLRavUpZiKlusARYCi3aiX+6q/i/EZt5PDff7t2csxHdt0NO+VQqygR
         K/Y68BjJIQ2jmEkcc7U+6BYmTLaXzs67Ug5VSXJPgMke84cjiKLhc6RL9YrZIVp/h92N
         gIZjdJCQJH+C+CF041SqaoJ45GbnFCojN/GqIz2qCEHF8HVvN9ZBLCjX/QvVqtnAmsSC
         5fkw==
X-Forwarded-Encrypted: i=1; AJvYcCWUievm8GDXJO1jsUCQcd0eRoSLILHZbSUUJMQ6W5lOpgF7dN3q3YlpwqUihWAJOAHmfz2MHuGIFxVgs1F6PioRO7ziw5yf2AB7TrCX
X-Gm-Message-State: AOJu0Yzb4lubb5uJswxGMosHXMMNxixplsPJKfEyc94pM20mSfgp6eOl
	VFxf4acRngRy8o/9oiZzJbpirCoVv4YPqWVp/YUmTFusqVk7d4tLsiACuu9URCYQT0LY5tY7jQg
	1Dm3Nxxr7F4riU8wGoz0el3chL9yMmZpg6U4QcLAgE8YDiTj9sXfe+38=
X-Google-Smtp-Source: AGHT+IFP0S3xxxWJCsw8bo32m8dJkh7cnYgUB+8eS65bkcveoWdI88X6R/Atwy8CYDB+GwzBKKs6Axosp7FG7bap07PJ/NNBpaja
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8717:b0:4b9:6f13:fb1a with SMTP id
 8926c6da1cb9f-4c215cc8f41mr33366173.4.1721202841758; Wed, 17 Jul 2024
 00:54:01 -0700 (PDT)
Date: Wed, 17 Jul 2024 00:54:01 -0700
In-Reply-To: <62834558-1286-4af2-ab6b-7d1ef309c793@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f83e76061d6cc375@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in attr_make_nonresident
From: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com

Tested on:

commit:         562d060b ntfs3: Convert attr_make_nonresident to use a..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16d54f31980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc26ad11927ab7fa
dashboard link: https://syzkaller.appspot.com/bug?extid=5b6ed16da1077f45bc8e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

