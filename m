Return-Path: <linux-kernel+bounces-332803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0197BF05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39EA1C21694
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8D61C9856;
	Wed, 18 Sep 2024 16:14:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384DB381D5
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676046; cv=none; b=I023vSQroa4EQjlBnruG5mzYgzTFQPjscZZ4T4Rs6L+KoEuYaF4sQslbOkEbwEHMfsBeY3lIiqkSrv8HnFOSwAcuTgTfwmyhZ3M6Wx0OtlaZZCSP/sVaOgUxOaZCE2uqJgSI1YRRUqnmGGHKDskCbYuoY9EtG3IJw2Mgk3a3JkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676046; c=relaxed/simple;
	bh=K2vkl4AtIXeoNyM0pvs16ltj57H73Z1h7kcbdoyAyhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tLBXXzoJFbx+EN1tzNSG0QJ54G22XTe7l0qcoL5GtyYi7G6FiU7UZCtYGb06nfW/KBMAlR76e5KZyJEw1OagO/MJzqAFhEFsH3+7AegGoEswDWRuYenIDQT0fO8MnjcG6rO8HDswHb1IRWbrzilb0EFLWIJjeQ3SzUVhfl8r9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f5605c674so117200915ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726676044; x=1727280844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3CMp2w38Fzpt9HGNlajGtNiu+JDcJlEbTyaN/C+Ahc=;
        b=G2yXhynkwJ0WMq3ED3Vfd9iTNRHjIn7IMXdkDe4rPNSHef1Cv6H4WL620paJNYQRMx
         dAxmWt6/6jaSAKUP1TJ2iiENhf+2dufFH9LRz7Nd9xe+OLYEqHzrpsqa3/kg7H3XksXr
         uhjKlgBBlNRoF4GZC4MopPb8jD2YHVNNZuMPsX8zazuRwZEfge827evavouqxeKRU6nd
         npX9BK0RsvGy8UT+zC0Pzu4LVbpuzl/pUC4/4kuPwjuAxfeMCT3xcG+ekUKj7GHTJPUF
         nd2a1HxjrCq37tmI3KOdRY17SAeQcxzs2f3OO/ippNge2iM/FmMOEqXOvm4fmvQLxSRJ
         MN9g==
X-Gm-Message-State: AOJu0Yw0nwUeGmEJJ0umP1koliFM2mwUwUKZugn9O8JQEkiNOHzEfym9
	yNDXaVbAkHTaSdPoicE8tFQbxcABzSmBr+656EJw0hcxVQp4/PTAaUePzhTrnL3oQmxG6OBOjjk
	7LzFWP8GMqcK+XwLuLynkobjFV2lRPsBPF9EbCuypfYCcsBUtUKr30IA=
X-Google-Smtp-Source: AGHT+IFkQeINCQsQZs7hXabT6dA/2LeAUPhMPLr0n98Yl7Ar1kM2HvSbSZnyBxrEMHvIBSehTNN0Z/EPOO4kxqBTzD9W9A9X+tTM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:3a0:4c31:265c with SMTP id
 e9e14a558f8ab-3a08b7bc0d5mr190295825ab.26.1726676044328; Wed, 18 Sep 2024
 09:14:04 -0700 (PDT)
Date: Wed, 18 Sep 2024 09:14:04 -0700
In-Reply-To: <CAABpPxTDRvwd_Z4TV7-iba9t1xjWqg3HU+vfZ-XEa0O2ALpqaQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eafc4c.050a0220.252d9a.001a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_write_cluster_by_desc
From: syzbot <syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pvmohammedanees2003@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com
Tested-by: syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com

Tested on:

commit:         4a39ac5b Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f95207980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b74c2037cf7ab6b0
dashboard link: https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102cf500580000

Note: testing is done by a robot and is best-effort only.

