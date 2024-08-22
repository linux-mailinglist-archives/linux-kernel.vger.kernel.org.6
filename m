Return-Path: <linux-kernel+bounces-297737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CADE95BD12
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACA1B22760
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923911CE707;
	Thu, 22 Aug 2024 17:16:56 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4B01B948
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347016; cv=none; b=HIifV3+jAgDkagXRJwMF4awUj3kPp4OkiYH98w44mJzxgSaZEdKda75afFyZKv2EZJ0+bhBq8J9sLCu0gX6AUv2mlOto7j6RRE2zeE3ax6TthUSZFm/9A6vj/Ew6aFFJPWqspBHgfSQnJNr7Uhp9LWqFVjfyRwrZR4Vab1sOLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347016; c=relaxed/simple;
	bh=4xk6WH2N/xyEJ1eN/iWL4Q/CKxUOmlvKj3J/GjbzXyg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PORt2prLa8mqjHENu/qGXZslWiwyWSxmYn83rFAjPP6rY2MtWYVVWTODWx+fs2lkvnHmtyfV7lW4VTtJTlLza+TCFmOMS/BGj6nSUP2XKdbrPZk+BScx1YFiLr3c0XAoAYG9+Kn338hJQWm1XozcAsSMHSmWqD3BfIUAeQo2CL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d28a70743so9886365ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347014; x=1724951814;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xk6WH2N/xyEJ1eN/iWL4Q/CKxUOmlvKj3J/GjbzXyg=;
        b=pcuav1n7lE5yrVRSDFFmQ+y2DrCwB7Le2p3gUvBMPdi/FtyPO+wPfcgTKIlmhm80Q3
         KYxMVKIvvEBTi9dsC9Dj8zerFyIOk67rbcmAf7kl8wLRpRYGKgWqeVA3iND0603+KV0a
         jJIa/y31spHJwFjZ2F1PDqFwltyGXXUwFgqNf78Lwu8bxDH+YWB13kfZTcZyRzU06AMh
         +Q72EfoB0BGaLs9esaUZoMguAv4CwJDu1KMIVxhRkeZF6+71A4SJgnU2KBMT7knwQbkE
         xOFLEuGv+FW8XbWMhLv2Ra9S0nnScPngP+TWhnTWNQa/TyRmuXLgHbwqiBDzfA9AVU4e
         FMgg==
X-Gm-Message-State: AOJu0YyA7tJKtL1LmciKeEzWB0F5rri29qfkbQ2I/likdiBaPcZkr+6v
	Ze/7+cmQmEE+jLp3HQ0kohkOvUGdNeHeMPUj4zm4hQ+nSanxPGh8X80VLm7dzQeoTUbJrVvcBb+
	aEjG5R2FAgq5pFjaCdU3jOumq6AHjAmiCYyDTuJgS4Yt2N1lsYAMdf+U=
X-Google-Smtp-Source: AGHT+IE0foQoZM1hkcZJ3nSYSYPcvxzxcD3zky+WcmlXrAc/vAN5ENf4UBJVigB+eTSVD2ul8NEh8MzLpK26wa2DhN4WkTSs1fnx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1785:b0:39b:c00:85aa with SMTP id
 e9e14a558f8ab-39d7501b377mr1833155ab.0.1724347013985; Thu, 22 Aug 2024
 10:16:53 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:16:53 -0700
In-Reply-To: <000000000000dd79ba0619376337@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d0f47062048d3c1@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] kernel panic: not locked:
 inodes NUM:NUM:NUM cached
From: syzbot <syzbot+b01867e789ff58727a77@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] kernel panic: not locked: inodes NUM:NUM:NUM cached
Author: kent.overstreet@linux.dev

#syz fix bcachefs: kill key cache arg to bch2_assert_pos_locked()

