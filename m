Return-Path: <linux-kernel+bounces-176807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F34C8C353E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 08:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3611F21370
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 06:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF220101CA;
	Sun, 12 May 2024 06:54:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95FF4E2
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715496848; cv=none; b=fzB+4/O+kcdoZ4zm3DYmVZ5aYxSwo1bYx57DL8sivblTMd3FkFeil1h5KpOCi5azL/9B3STlfENVXD5dYSRtyGpeXl1sLEeX7goV6KtnGtzfmQuk8iXhT+6iJVXlPF/J50rfDSinoWRyTVMs8jaKUEghFxG0lRpZDN29diNhYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715496848; c=relaxed/simple;
	bh=0jnJE1mc9sTx23ghngDhgbZeNM4gkDsZhq0VB7oL/7Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fJotvCpxKQqKJgHLENrsOYupv+oj/oPlsn/Km3B1xHVh3b1nETg5erIFKMHag6sZ8tK5EyNoenzRRaY3YL5egv1jzh3jC0Rkx8f+rLMm09ylsUEQp02JJFzhcpN5okK4rL9AD8ZeoC+BJGka0YI/OnSzV1k9dw8fMBlrska2YhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da42114485so421938139f.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 23:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715496846; x=1716101646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVa01wrkLCZS1Iz58XW2REP7xWRQdEWWA77IL8h/WjI=;
        b=JoiJyn+jlB6Xr+1NJ5PwuXr2JFgHzLt8eNG9v+D8iNnx9EKyrHcmZT3F9Uj9azGjbA
         dVyJ8YDEpDzApopVz4RmokDElcmjq4uCE+qljq1zR9/IgqoPGTi7Kuq4w4AhcCUFXvf0
         7EDAktAFpj9SUK0jwtQvpVYD7Eu6gQsdH5+ghh/ruyMx4XNw5AMpZ1hvaFnQcNhdnHz+
         h0rWTWuBwfJpkEjnJUTiDWNkMpEFErIkzTvMdLc4mP8o1Ghb2di+zWreUiFtwT/8n/UG
         0kAAWzQMk0s/Q8GDeb6K0szyDYEcNBh6t16SZyf5djXU/RjcFzD4J+x8gLMR5QZ6HEFD
         AGPw==
X-Gm-Message-State: AOJu0YxyuMLl6kX1C/VnsD9aWKJ8aDqde8gBYJn9Qk3tvmvtLVeUeIhX
	lg7Vk2DdRPrr8jTN480g2bI/vh7RpZyCxgV7be+yd0OvwwjYm0t73PZ5qAguRMn3UzxEwztCR4i
	46oTNZXqRVgq4v43qoYfBJj3nVhH1tK476pPjMU4slpuyyJAQ5wmJqy4=
X-Google-Smtp-Source: AGHT+IHsI5I29f0exBLXKzVbtuC2caWftTHYfGcjL1YqhP44CwnRHX1D1NQ+hOEUzOMmHVaWfqAVmxkDVO3sUqgeDxWTBg1ptOPc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b08:b0:7de:8cc5:fd1 with SMTP id
 ca18e2360f4ac-7e1b521bcacmr31797339f.3.1715496846384; Sat, 11 May 2024
 23:54:06 -0700 (PDT)
Date: Sat, 11 May 2024 23:54:06 -0700
In-Reply-To: <61335219-fbc4-4cd9-af8a-cf69f4c2c873@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024712f06183c3c53@google.com>
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem (2)
From: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com

Tested on:

commit:         cf87f46f Merge tag 'drm-fixes-2024-05-11' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1012ac00980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=116ce604980000

Note: testing is done by a robot and is best-effort only.

