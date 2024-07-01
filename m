Return-Path: <linux-kernel+bounces-235817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 647A291DA0F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EF81F22305
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F83884A39;
	Mon,  1 Jul 2024 08:34:41 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D371583CA1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822881; cv=none; b=DAIugyGeAZA3mHF+oeq3Hk9qnA/ZKB7VwPQtXB1db+CeDoAKsrXvhvVqiNrtjF/RJfMalIrK2tL+3wCtxqEu4067qqpMlfZhnaasBCbS2vguofkraHpKHy5kyHCj8m/iAi0bHbYsRQc6yfDG1Xz2oxcJ8yXF2FIP2C/D5Xhf7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822881; c=relaxed/simple;
	bh=rvFmANxfKDovGT0vUwboKCecszQqOKm3OebHT9Hg6KQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LUfTG0EXjRDKbOzQGcgbaExVdpj+zJCbEsPLokHURGSyc9xBUJZGjRtr/tjYXi8wSJ67HG4Y/6qFx2vWqLNCRaLX85igWpn2UR62kL1HBWJ15VGesYD+q0qvy7hZhRE4ppBotC1UF9UEoyhEGryvgn3kZVApu+pvcnyNUgmQSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3761cec5b39so31235715ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719822879; x=1720427679;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvFmANxfKDovGT0vUwboKCecszQqOKm3OebHT9Hg6KQ=;
        b=LQPJA6vtKEIr+FlE5TPoQ72GqfzBnEFdoB96Dy49wcNBeNOHZxA3Zx6AfWLGlYv3Cx
         VE8pKoKhyB+EjwkjdII6gAB9zf+binPR3+qO95qka4T0ZKTqOqKbUR+Koq3bouKkUnPl
         i4lrQSrW86f11XwF/JnArekyFT+FCTTVaE9YLjcy7uaP/GeoxDMZLgKr4mT142pbkS9B
         GY5q4iYlDzLK2qr3I3UBmL9BbiJTGEW5h6dcWzdFlJFjIKVuz57vsNaFcaSBpRV3W1bb
         a0RMqkx4m4eLnprXHz39PaKet5Nbwp4J7p+V7vMxZZEZkcnxQpVCXkFYAJaphYEoL52I
         DeMQ==
X-Gm-Message-State: AOJu0YxlWrB55d4gOgg0PHTQA6ZbovtQ4PU5cAaTCgL6bgm3QMZHflem
	8b6V7I+KyXKzYdVBYlLS10p5DR1kaTVZujD/Lf02P5Oe35TICOH02TwrjdFeaZ0MioSyMhgVUr0
	n/MfL9zqzES6ZDhPWp939sSAWzzGFtzJ7iziCFKvm7DFrzhuR8wvbRWw=
X-Google-Smtp-Source: AGHT+IHEE3l9B8hCBo/rO/KiByNpChigb40x+TcD8gTRcWdiId3jERGn1THwNUZ7oKU1deIoeNsVG3AQ9HMPCuczWr6gvt2dj6eO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cd4:b0:37a:330c:1974 with SMTP id
 e9e14a558f8ab-37cd3b55fffmr2274185ab.6.1719822879161; Mon, 01 Jul 2024
 01:34:39 -0700 (PDT)
Date: Mon, 01 Jul 2024 01:34:39 -0700
In-Reply-To: <000000000000f19a1406109eb5c5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca0e64061c2b77fd@google.com>
Subject: Re: [syzbot] Test head for issue
From: syzbot <syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Test head for issue
Author: wojciech.gladysz@infogain.com

#syz test:

