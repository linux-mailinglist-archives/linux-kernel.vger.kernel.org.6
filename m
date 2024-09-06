Return-Path: <linux-kernel+bounces-319489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BC096FD4A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4E8B254AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AE8158845;
	Fri,  6 Sep 2024 21:25:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3EE13E03E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657927; cv=none; b=nN1PORHIGGP9u+D7MhKDDPvYJ/Yzt0XeShFdry6YRXpn3jok9147sIFoX3abtqQVk0AjW07Zqi/76EcH6IM2fPP8kU/3H3yxDNpM0tMG+m39JOA5KMje+Jz6RT9zQhAMlDoIwm0ziZRcYsAvO8661Bg1jij/gu+mjEZtMct6k9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657927; c=relaxed/simple;
	bh=GQCyioVrof/bjevN3BKIo0QLdo4E9gu/XT309SLWMTs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nLQu82ytdYFyqZxyomGn+OJmdsr57CpqiIUU4y0j/oeTsouSoslHZKGlDSMDmRKr4ZA3xDFcULK8MXD03hIxm4XjtkfhfPkehb/mKGragcbxjlBtIVPSMlFPX7EILTn20nAt+meZrGrGnr0t6uENQpL9SKN10ORFlZdxo/sFrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a330ab764so526343639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 14:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725657925; x=1726262725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQCyioVrof/bjevN3BKIo0QLdo4E9gu/XT309SLWMTs=;
        b=dltAI34E5Kmpbw80ynQ+HnKq7DXdZwoORQmEbCLVb/+t/hvAbyxnfwcaGpSxACj6dq
         RAv7WvycOmddXZcBLBJRFMCcUObbX+//yUgAoXOQprGO38ceNyvdbXI+ts79gVc1Ab3y
         91uLbMS8lal8wg5a5gQfTszVLVKTUp7aXqTcqXiWhc1DYm9v/Gu/KrL5pBxP1lH1W9KK
         oTAQPfq0zTQxhyG9vZQHv89r9JCkZSr+PEPp/EPhI+/xvQK+hp4v0dWVN6N/Ydk1J0XL
         jQoflhBTT20NfH3QMfWksenBLVAdhGb9rp8fSGr41J6avSqigRU2qPWGXQSxc5er3CtK
         pU4w==
X-Gm-Message-State: AOJu0YwLeXrgjKPotRVwmh9KR+PiPiU6J1192hwFUgA0njFF0iX7biGE
	2Ie/byi0mv+yVSDG/+u7APYRvq5W7oMka2aHKHVjfRPA9Qb7i8F+eNPqAJGS4qG8VbEFNV+Z1eb
	n1ZXKiYpvzJsgk8Pn1vX65DFj6QCt6ddzOLYzZfZtCdoNDWQnOoWdIFA=
X-Google-Smtp-Source: AGHT+IE4qLHABirkDiGt8vM956WjGVnPNSuYuAJfGgYebzS4nF7sg6sD3BhBZMN4l0Z1kYhQpwa9iyttao14m4NHXLzbvbJQmzYY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6c8e:b0:4d0:51aa:f250 with SMTP id
 8926c6da1cb9f-4d084fcc4b5mr132659173.3.1725657925053; Fri, 06 Sep 2024
 14:25:25 -0700 (PDT)
Date: Fri, 06 Sep 2024 14:25:25 -0700
In-Reply-To: <000000000000528f32061fb69112@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a07dce06217a0b15@google.com>
Subject: Re: [syzbot] [syzbot] [ocfs2?] general protection fault in ocfs2_buffer_cached
From: syzbot <syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [ocfs2?] general protection fault in ocfs2_buffer_cached
Author: ghanshyam1898@gmail.com

bug fix in some cases when bh is null

#syz test

