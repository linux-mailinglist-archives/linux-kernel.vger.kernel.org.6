Return-Path: <linux-kernel+bounces-258216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480FF938515
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E531C20B27
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6375216193C;
	Sun, 21 Jul 2024 15:04:55 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E42C95
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721574295; cv=none; b=UXUM/V2g5tYiGRKe1232T0MA+++KsI69LX7pDK0+wTj4ECLOcVgIN/e/L6eB1HdQo3za36Xng6cTc58Z+FLf3rVBsvAZYeXbPDDunimw0SPFSmYnzK0lGO0c1oj6qDDLdIWMyTOy6/iPqiu+OzPB83lgUlV94/RLU9H2Jvi7o50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721574295; c=relaxed/simple;
	bh=1drD+HrjXkXj5AxlqRiVL4UG64Vp5PVqSuIuW641/qc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dLlJovVn+XljI6jVR/tT05/XVwXr3oB7+uFre36I6ru0o0qEGCohKQV63TakeTNXnc/8aZL5xcNROKNZLAkje2r2N2goduOtORinaHezsu6BFvCxNc9HfDIyI+cFnpMJeGwZ/WQEle0H5TYu3phJG98w9g4+51wIOif7IsaMSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39858681a32so37102055ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 08:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721574293; x=1722179093;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1drD+HrjXkXj5AxlqRiVL4UG64Vp5PVqSuIuW641/qc=;
        b=OxjVAHpB1ApLMfz2bFHtRlkD2I89c9QOVOZ5ZkH8HdmREzGHSV1suzNmz49cNs4eWG
         h0NbRdTapgPN5Wf3xF1GI5YVgi3a5SuwwAIBIWFiKDA3VehARXXIhTysJ60vyYEgH/U9
         KMgiAEnouVQ/Fz0AEjhDGLQE/zduGumwTVjMU/rTszNvaezGia2dMMvbKYxNgOOdM0FA
         1695d7MhnQKmKZASPqqrujvqNlUZoo+e7oCRtjJcKPlvaZpFLFvkdSS+qrtDFklhvKA6
         wDo8EmzLv0G7sKYx2+/mntxvki1wcncuXn36ta8LIpHp6bx5YGhFOSNQpGoBvbUg5mLS
         gfeg==
X-Gm-Message-State: AOJu0YzpHXiFuBMyiH6L+9Y96qvgiHYiEBqcUhSBWKb40WvHf0KzgfzG
	aKJ6CBifSh5Jvo/KaElD49xAaCj5vQ5BA0sxsq5OHPJQdeHtcdNhtUhMRqiMGobzxfkG8f/wLVm
	0rHll4cJJnXb+gSpBDKNXuFEWU2YWSYU5IZxT+VJH15Lf9lUZtoK+I+E=
X-Google-Smtp-Source: AGHT+IGeAVY/OmHD6bF60z9aJocjeSR3664r54xvO5QqclZsJbxm5wDwB+7bk2Mia7cPOcbKleaiP3Vw4Uj7HhS0Yj4W8e9p/Uxu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c6:b0:398:3831:4337 with SMTP id
 e9e14a558f8ab-398e7633e09mr3362505ab.5.1721574292715; Sun, 21 Jul 2024
 08:04:52 -0700 (PDT)
Date: Sun, 21 Jul 2024 08:04:52 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c0dcd061dc340b9@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free
 Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3f9fe37d9e16a6cfd5f4d1f536686ea71db3196f

