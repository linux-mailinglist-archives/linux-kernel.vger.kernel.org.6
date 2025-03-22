Return-Path: <linux-kernel+bounces-572419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F50A6CA2A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E243AD2A1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE99221DA6;
	Sat, 22 Mar 2025 12:44:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185712B17C
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742647444; cv=none; b=koux/Ym1PF2ATktPnMSGfocuUtP/Mv4Lh50hitOAY1Wlv1ZaBLfDFdeTU04WnZxbG9SdhBJhgUTzle/i/YngQhEhNb0WwpB/C6QuXTdXPIBF+zvdNZEa7AWYEYI3RbDDUN9UD29hiVgsDarV8BPBN1ys3p8ZCPFql6BlO2fON3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742647444; c=relaxed/simple;
	bh=4sDLsXDAw4pHa4Bir6qC04E9rkcUjQd4sAQBFW78vKc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sGtpoMok6xULYbqLcDIIAQEj2BMFGGfyNYXP70ky1JAvnHokHLAs1S9zeWM5MoYXIhe0rKfz14zzhqRj9wMtBBLHTsJCeIX1n1MVdbzgGGo2wmcWXo4w58IgR8hTLJG1h/sH3SGettaMHHiffCbTfpZVRtEtvyut0qdx/9W/8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d43b460970so59688925ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 05:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742647442; x=1743252242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVF+PwONIaTJdkFX0hhjlzVj5s/XoXR24BPkRfJDqIA=;
        b=V5rrHistr+LadS2Psqal5/rc+yZnsjhwsB67ABfcIJ15ACkOeekeBfx5zSsLpp3YCV
         wz5TQkVupwYPwCI9z0zMbwSTwKz4mN/ffj3V3GDebs5MGcggDuKc0mNmUDU+XCS6ycmp
         lSCp0QHG0OTUfB25idSE7YJX3yyt8TkM71d2xpHH3gY+Ag+Ydu/PzXgacKNqGW2hCFcK
         75xwywqkOeIFBe33F1bGqeKGOhPoZ+zQSd7EH7NzI7xQgueWcskTnq6JgqPxiHGOepuD
         yuG7NkvRs8MWjYLTiNSrIQZlYXv62sX8YBG7ZwQIp6Q5oiUsJxph45P0Z2FecOqEoTJk
         8MDA==
X-Forwarded-Encrypted: i=1; AJvYcCUqKNjs8DsedeH00ON18L8TCh8YkEte0JcUB/qu5ogLzSEaNkm8AVPjOq/BDH2cBuhaDBCbgdkdxIvndZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfobaSI3APp9x9bmu1TlDbvfMRMWkZjhw7CagQ/C6pml6+nzBN
	zYptThYcwNjY2PASTd8Ryep41ESH2tpSdYTM3IGuLJ/WXWmtXCHSbEaP8XoX96gqNWXP58JWJv0
	M+joiZcbbxzB96cuM4jF+rCWJ0PdK8aDdd77W1UoCfIxI2ztfI/uwZ1c=
X-Google-Smtp-Source: AGHT+IEXA/MzJF+RIcAtENhkT/H575Y1nUCgQruEQpzFyIBHuJiMFT7lE+2HMIwkv1oUnuLpBKoKAPZ/2cKAzbbNH6aEZYDwzdRA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca45:0:b0:3d4:244b:db1d with SMTP id
 e9e14a558f8ab-3d5960f5b15mr63113585ab.6.1742647442222; Sat, 22 Mar 2025
 05:44:02 -0700 (PDT)
Date: Sat, 22 Mar 2025 05:44:02 -0700
In-Reply-To: <20250322122233.218306-1-duttaditya18@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67deb092.050a0220.31a16b.0039.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in add_missing_indices
From: syzbot <syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com>
To: duttaditya18@gmail.com, jfs-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         9388ec57 Add linux-next specific files for 20250321
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147b043f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4f3153a0a8b9aaf
dashboard link: https://syzkaller.appspot.com/bug?extid=b974bd41515f770c608b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1054b004580000


