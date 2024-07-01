Return-Path: <linux-kernel+bounces-236342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9855091E0A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446922817D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75815E5CC;
	Mon,  1 Jul 2024 13:27:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBF46525
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840424; cv=none; b=oHhQ6r7oH0WZBovUvwAg56RgMsUMTUB6S1TVJIXRiAUCZhP2L1j1cnDbgQXBNFgm6b02Ruxwt+oDXxEuerymm8yDZkVrVsMWIcapn+GP9c7jBGb2HgwoggG7Nby8zY/vXs2t6pV1BzZtqzlBbp/+ByVTVuB8Q7Jak99LR5D6Fmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840424; c=relaxed/simple;
	bh=7o7h3aRw1fKVF58BGr7QHkMeysXzUN2BOyk2uThEnDY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jj9U2qOhFoOx9Gqg9V4LPQemm7Huw112uy5mmkB03seGCc5/VZ0ETDPxrjnaswyZWgF0XywkibpKu/xnX5wc/ekNkQ2cO1COtMDHMj9Q8JLaaVPDrSWbE4m7qbwVAJt8fBzAD6xEy3vKbhN8hPwjejnRoLkwVevEuuLrs33s5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so325080939f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 06:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719840423; x=1720445223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2fXiBu3B3/TGnIrsagutCSvt+rDbPq9f3lVsrIU9l0=;
        b=O2fjSlFlFD46uJxUU3ToqmqBAcl8W3Pfc7MmjDQ6VdTYnSOj/KQLiFn+T62OnY3u1R
         Nr2BeM0PdUuMbc1+hIBBq0RaHlNZyGpV0nI2DHpA21gv+8lw6fFy4T8zLIXuoqm5A58t
         4PiiEtgCxtJmRNpPikyPQxioy0XL9KBK762gNhcvY3NLptqnP8MAIuaApJONMeM9PHkf
         iXQAL4VhH9yIM0XuhhpBGhIUrmer3E7zlwobc7pAhTbpJWOtf4gmonj2naToMLkPEBo3
         3mydgigkpnY1rKIF35ZoXG2raAnfcdFcaZZFARmJCFW/FwqnWP4LzDYb5reIldjUw7jS
         EIPA==
X-Gm-Message-State: AOJu0YxZEtTKyjXlFotr0T1R6muZN0nuLh7618Mp0JHot+NLWXsoyI1Q
	5YaFqXIB2RqsPQZXJ5WomSbFy/z+do/cvynILqURwQgM8gl1eI2KrJGv6Be9URWRLERYDqBEcV7
	RUCPGFwwdOUHHiv7x3X7pt2xVdjRQ2FC2JULbt2b0lzK9TQhg6FSizPQ=
X-Google-Smtp-Source: AGHT+IHHR1AXoNnTFDicfcsA2PapQH5FuIxJ5sLQr0laA2srWPYtal0EKlPtyCufKgG8gf7IMp+4Eq6mMbYYGnHu8ylrSefQp6wl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15c2:b0:7eb:80e5:b5e2 with SMTP id
 ca18e2360f4ac-7f62ee8e547mr45386139f.2.1719840422758; Mon, 01 Jul 2024
 06:27:02 -0700 (PDT)
Date: Mon, 01 Jul 2024 06:27:02 -0700
In-Reply-To: <20240701130014.9207-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007819d1061c2f8d46@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_hash_lookup_elem
From: syzbot <syzbot+80cf9d55d6fd2d6a9838@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/07/01 13:26:53 ignoring optional flag "sandboxArg"="0"
2024/07/01 13:26:54 parsed 1 programs
2024/07/01 13:26:55 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=1780d2b9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ad6a8768920dd4b
dashboard link: https://syzkaller.appspot.com/bug?extid=80cf9d55d6fd2d6a9838
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b40476980000


