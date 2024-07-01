Return-Path: <linux-kernel+bounces-235878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C6491DAB5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133991C22393
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859BF12DD9B;
	Mon,  1 Jul 2024 08:54:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35328615A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824044; cv=none; b=ZjXkYNlO9phJBXADR1rNxrRDyuhMkYuRcM8yo9gYGK+NshqkEmWjC/SgLw4kQ++Eb+kov3EtspbESzvi2yM7+fZ5QafqZv2YlYMmnPmxuNEP80X21mYEQVf6ixOf9d29hjDc7UU8kA3uh65s3Rwf2UCOeG9tEFN9W7JPU7fey0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824044; c=relaxed/simple;
	bh=TqjaM7xt0ek5dDHAjepw5qMFWne6ltp/Ex5IKXsUvCE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FBM8Jm1tfdNPhhNhZnpx488Q68D11F9NMvjyzPFyZSAhEVUheyMTZRNClOMoK6kNyGfVWk51G/2UZEOrYMo4EEQd/WUdzdtXDqqMXWIF/p61jIakMkgcN2NONZm02Pqu5q8hRK5RyrKgRXpdzN4ets9AN75f0ShYHilEj7Qp+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f63ce98003so98833539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719824042; x=1720428842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDqqJsoTxHELNsp+DMkcgx+Y0MdUEPe6wiHKgIke+Tg=;
        b=aB/KlgyvPZtyLq6cttinTnC/r7VS6ePJNH//WSzoDLZaZOvTdp3Ktt6pQRa+dP4eG3
         DvbNWD8E75X8Kjn+Z4Te+xxnb47P/f38iAc+hLveRLfH0RXRbzZxO1NNX04o1i0yIH0m
         368bDT6ULTBX6BUfvwSXEqdIiR+qL9CMzUiIimyDiGuvPR1E1mc4vBd2rxJsGUvgxa/7
         0JOfeI4svznlHK0n5k9wCgQ1VBkb9GevnhivW839nRYtsoCT08gvOMSG3RqIsSPaABaR
         ENV8LjgOV41O5ZyRhmiUpeXBVE/Of6nmUBgy6j+1rTTLv0kH+KQ8+1vPK3uwlQY6wgF6
         uAJw==
X-Gm-Message-State: AOJu0YywmOQixRgQkjSUoGF9NZTCXGd4HzBm/oa9c51GxtnG8fdvkdvp
	5JJCCJivoctNsANzZqPJq+WDJDluwlldwB3sRl8DQTPhjjFMlKVoOBk4TS0a169G3JSLhaasshg
	CJB8ms2ra4Cb5zFnkXwUUQLiO8s5Ov3WNxe4CvWdl+xVjwwSOjZHQNo4=
X-Google-Smtp-Source: AGHT+IFmtK0G/r5Ob6nyiKfBVueWNNrNh6uwXSPCCPyJYKWykUTURtA2A5rG+LTd1p0alPwvKPDC1JT5VV8BqRofQ2CwtAzDSVIZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9806:b0:4b9:be4c:d603 with SMTP id
 8926c6da1cb9f-4bbb6e5b9d7mr314246173.4.1719824041858; Mon, 01 Jul 2024
 01:54:01 -0700 (PDT)
Date: Mon, 01 Jul 2024 01:54:01 -0700
In-Reply-To: <20240701082944.17441-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000176977061c2bbdeb@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in __block_commit_write
From: syzbot <syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://linux.googlesource.com/linux/kernel/git/torvalds/linux/---: failed to run ["git" "fetch" "--force" "5efaa37364b8874e2c0b1d9108beeed3d23b6a7c" "---"]: exit status 129
error: unknown option `-'
usage: git fetch [<options>] [<repository> [<refspec>...]]
   or: git fetch [<options>] <group>
   or: git fetch --multiple [<options>] [(<repository> | <group>)...]
   or: git fetch --all [<options>]

    -v, --verbose         be more verbose
    -q, --quiet           be more quiet
    --all                 fetch from all remotes
    --set-upstream        set upstream for git pull/fetch
    -a, --append          append to .git/FETCH_HEAD instead of overwriting
    --atomic              use atomic transaction to update references
    --upload-pack <path>  path to upload pack on remote end
    -f, --force           force overwrite of local reference
    -m, --multiple        fetch from multiple remotes
    -t, --tags            fetch all tags and associated objects
    -n                    do not fetch all tags (--no-tags)
    -j, --jobs <n>        number of submodules fetched in parallel
    --prefetch            modify the refspec to place all refs within refs/prefetch/
    -p, --prune           prune remote-tracking branches no longer on remote
    -P, --prune-tags      prune local tags no longer on remote and clobber changed tags
    --recurse-submodules[=<on-demand>]
                          control recursive fetching of submodules
    --dry-run             dry run
    --write-fetch-head    write fetched references to the FETCH_HEAD file
    -k, --keep            keep downloaded pack
    -u, --update-head-ok  allow updating of HEAD ref
    --progress            force progress reporting
    --depth <depth>       deepen history of shallow clone
    --shallow-since <time>
                          deepen history of shallow repository based on time
    --shallow-exclude <revision>
                          deepen history of shallow clone, excluding rev
    --deepen <n>          deepen history of shallow clone
    --unshallow           convert to a complete repository
    --refetch             re-fetch without negotiating common commits
    --update-shallow      accept refs that update .git/shallow
    --refmap <refmap>     specify fetch refmap
    -o, --server-option <server-specific>
                          option to transmit
    -4, --ipv4            use IPv4 addresses only
    -6, --ipv6            use IPv6 addresses only
    --negotiation-tip <revision>
                          report that we have only objects reachable from this object
    --negotiate-only      do not fetch a packfile; instead, print ancestors of negotiation tips
    --filter <args>       object filtering
    --auto-maintenance    run 'maintenance --auto' after fetching
    --auto-gc             run 'maintenance --auto' after fetching
    --show-forced-updates
                          check for forced-updates on all updated branches
    --write-commit-graph  write the commit-graph after fetching
    --stdin               accept refspecs from stdin




Tested on:

commit:         [unknown 
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux ---
kernel config:  https://syzkaller.appspot.com/x/.config?x=95dc1de8407c7270
dashboard link: https://syzkaller.appspot.com/bug?extid=18df508cf00a0598d9a6
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a45512980000


