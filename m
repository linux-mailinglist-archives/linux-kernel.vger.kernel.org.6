Return-Path: <linux-kernel+bounces-412392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E5B9D0863
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F1AB21E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88812DD95;
	Mon, 18 Nov 2024 04:26:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A625760
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731903965; cv=none; b=AuZEiFoW7YHnBjaxd6FG2NrKmQBwsUh+KQkp1d0lrN/J5ygmIkIrOMkMESW4RKeoZ+xrhQlh2TpEFjQIPbj653bDGJuC5f4AtHuX8UGl2ULLN7ds1toonXMnw0X3jov0NeJ5F2Y8IHfzRyj0uJxhs74MPotQm4oFKvrfV+4xklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731903965; c=relaxed/simple;
	bh=+F/leo9AMvHi/x6zhlILa/kGrSWBNodPYGOKoHeoQNQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qYCZouqnVc8dYBhhWAWRC8TXnP5sGvKwKUly0mtIJbS+fNuKabn98gpaCqE/jHV5BM+NYaxza7kyDOnUMMOkX8CUcx0RYRzcM4+KIVrImGORYFvrUVPq97WNiKd/yeL+BqMPRoi6gB3p/3D+HJvlf4LO5KWHVFy2bLzYNXdRIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aaca0efc6so401941839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 20:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731903962; x=1732508762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++scD0/Zp9nBvwimBfYgYEDWjbK7zytp54LHcUwYAD0=;
        b=Aj4gw31vj//3LcQNIDG2XNLhYNW6etdYJlsdfQij1vR1uo5MMXp5DnEH7jXMX9zCza
         gXwHtIt/mU9yXUBk4wlIA/hBsYHTZ/0ZvLfFnpLsr4RuAL8xxVr/elBf4BCxCixmXmFL
         E4PD9pWp2mVMykdC6oYwtGakdI2Tlm+CBAa/HrIfNLbIkdUuPTLO0HAqe2lmrmCeWbEX
         Oaj1B3ieuaWIWKJxPGjSkwpZV+3+F+CYMASGugxUZz+dylb4hAQa5UpqhYO48f1TYHrd
         Wt2kzZ4uSh5ducM0HZM2v1MI80pQGNaaEOU1hWE7bKTVfBP2K0Bgz3KixEhzJ40GmIx2
         Si6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOXGSETKc6IWloTlvwd4Kqy/03vu+tXnnSrUpy7hngKsdUFFVJhWQBs540NOKyHYePgMIoGDOh4oyZwjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi18C4La0GlGt8ewDeXZtTJvyR7yo/A6cR5/70hnzyruZu0AUn
	XBg6xxtoDwt1jCe3C4Uki1Os6hEbxzqA8pbGohxQqVsPqJ+Wa7zNUvf1Yil0ocX7bbuUzG+OJLI
	vwbw9gLDXfJsi2pJyW1MtHdL7oq2csy74Os/iEpK3hbzUGoCJwUXkiGk=
X-Google-Smtp-Source: AGHT+IHdlUu9v6Io1kkQG1Qjb6FSL+pjjYpATweDMOl8zsf8NcLaaRMaYKI6xtxduEhiSn6MCGRPesYUVrTkSDaOKTbOqATlCz58
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3301:b0:3a0:a80a:997c with SMTP id
 e9e14a558f8ab-3a74807f1abmr101135815ab.19.1731903962679; Sun, 17 Nov 2024
 20:26:02 -0800 (PST)
Date: Sun, 17 Nov 2024 20:26:02 -0800
In-Reply-To: <i2eu66jkrzkudfoa4dmxbxvvsb77pmneou52wg2con6nbdjuov@apux3q3iqjme>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673ac1da.050a0220.87769.001e.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in mas_store_prealloc
From: syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo http://git.infradead.org/users/jedix/linux-maple.git/arm64_kernelci_20241117: failed to run ["git" "fetch" "--force" "9c3e06581107b2a32da6dcbdfdaa1a523995a2c7" "arm64_kernelci_20241117"]: exit status 128
fatal: http://git.infradead.org/users/jedix/linux-maple.git/info/refs not valid: could not determine hash algorithm; is this a git repository?



Tested on:

commit:         [unknown 
git tree:       http://git.infradead.org/users/jedix/linux-maple.git arm64_kernelci_20241117
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1eb85a42cb8ccec
dashboard link: https://syzkaller.appspot.com/bug?extid=bc6bfc25a68b7a020ee1
compiler:       
userspace arch: arm64

Note: no patches were applied.

