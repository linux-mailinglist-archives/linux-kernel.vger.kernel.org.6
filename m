Return-Path: <linux-kernel+bounces-285669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F5D95110D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940EE28368F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BBA4A0C;
	Wed, 14 Aug 2024 00:32:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E284A01
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723595526; cv=none; b=aaVO5TaC1DVSbfs2TwtnTNi7t44MuCQgOreqcMZxlLk6HJQL56mU2VBzhSbz7qhYInzk3Ab0zAWe0uWckjyvE8cFW6bQIRvGNGYuap/RKKcLI3cvsP+wAWdCWgKALrhb/fFMDaaTJ6OQXI8t+d8p4IPP3HayJBC7g+J8cc2rZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723595526; c=relaxed/simple;
	bh=0AJ0HRNyjUJdZzMl0FTmNH4D7MeA9pIfXvP+Njv1Cew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CpcUOZv6RS95a6pPFASZ9wmgXz2sZ0c+n0QtnAREoXcTzRsUdvddlW91eYlnIWqUS0umaNxk31HUW15jDJ/fTuBm8C1AIZMxdoyWe2fbovJcl2uOKtM0GxMBVI8EK2WfMEIGcGCta8rhKDhSOqZ1vF6bNMgc4nr06pHUUc0Yk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39b3d98c318so74740845ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723595524; x=1724200324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KN5LyX62t8kajm/Aoto7iYQTQrVYYSEk/pn2RlwMI5k=;
        b=XZS9MXnh1I0Tb9jvs0pCy9tvJUwd/dkirsrJLXfZMZxgy7o3VrYnRekfxFtT6b7V4g
         hfwIR9BeAi5FaF0Bb8l9Q4BYGEfh6ArrGYgqOByKbzRs4dQDwyF2HSz1jHXQXf4TpTeu
         xLRYDjXlrNSCpuGr2aW/kO/TzcaJOQP/LGbo0q2+7xXVn5a+vquvIcVq8Dn5Woxp3DfB
         NJuP+y7AhxOh6kX/FDp+MuJhOqA/L8KYlgXbYitbghwho2bT1Kzc/q/AU2lY8LGq/nAv
         R7GRhmKdIlXcH7mWU8CbtbvS1q+VP5JKVdHsQ/84iFuizPduqHfEGCoxfOFRIHflZDIu
         SvEw==
X-Forwarded-Encrypted: i=1; AJvYcCWfq5ptM3KNSX9RzyAhOQoIvVUjOEBCgBoKmXaI+R4RRkQl9g5YKqRJV+IU0AmMQMyR6Ww9TAuBas8h9NglqQKM4DTSUABKBtsJ3g3i
X-Gm-Message-State: AOJu0YydNKC0pNBgPfunFK2mgkVA6hIUxZ2kbtP7ONu1hhc8yxa61NIn
	Ng3Y5vHgkykZWIBokrHlqZ+KBr6UaLdwOPzqwEcPLbcxp4mAjPqScdupuHKx6gg10IIwvMbmZkW
	t3xkd65xoDh+VmNza+9135PtKqXr0VvnPZKHznSXtCEcqrovSn81NQ34=
X-Google-Smtp-Source: AGHT+IH/g8aCJGElQ8/VklE5ry7A0gnFjQgBbmtCcpZz0jkOADdHDRelv0/VaixlspNKb+4RvqquWD/KTAwBB1bAKcnlGLxEbNk8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c49:b0:374:9a34:a0a with SMTP id
 e9e14a558f8ab-39d12505416mr900485ab.6.1723595523843; Tue, 13 Aug 2024
 17:32:03 -0700 (PDT)
Date: Tue, 13 Aug 2024 17:32:03 -0700
In-Reply-To: <000000000000be3c1a0604b53a1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef7be4061f99da2f@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in filemap_unaccount_folio
From: syzbot <syzbot+17a207d226b8a5fb0fd9@syzkaller.appspotmail.com>
To: airlied@redhat.com, akpm@linux-foundation.org, christian.koenig@amd.com, 
	daniel@ffwll.ch, david@redhat.com, dri-devel@lists.freedesktop.org, 
	fengwei.yin@intel.com, gurchetansingh@chromium.org, hughd@google.com, 
	kraxel@redhat.com, linaro-mm-sig-bounces@lists.linaro.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mm@kvack.org, sumit.semwal@linaro.org, 
	syzkaller-bugs@googlegroups.com, vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7d79cd784470395539bda91bf0b3505ff5b2ab6d
Author: Vivek Kasireddy <vivek.kasireddy@intel.com>
Date:   Mon Jun 24 06:36:13 2024 +0000

    udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17dad691980000
start commit:   9b6de136b5f0 Merge tag 'loongarch-fixes-6.7-1' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
dashboard link: https://syzkaller.appspot.com/bug?extid=17a207d226b8a5fb0fd9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f58d67680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a78c62e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

