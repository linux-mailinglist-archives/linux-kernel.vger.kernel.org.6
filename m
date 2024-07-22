Return-Path: <linux-kernel+bounces-258750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A60938C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5EC281EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474E316F269;
	Mon, 22 Jul 2024 09:43:54 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8816C860
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641433; cv=none; b=furyde2j8M9VsACE1ncVEd+vqp6AcIS/jh5zUx0iIGeR/GoIe8aZtI2iiGlWUZbXvOQOX4gbbVth323nakBfMNi91ZuA7zFVnXemO88TDQwhhRkMWPF0BEGfzO6R8FDs0EMS8g1TIk04RH5LktHIUmTnQqqFRUdP+jDP9euy/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641433; c=relaxed/simple;
	bh=EaWvQretHyZcgbc92k3ZHpy/Hyf7HvQbWkmyRfLFcTo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Uc+ra6qmukhX97XDA1E4e0dJd9QhgZ0D0jRSneaEZyrqysYwWVvjd/MrC5oqLl9nzW+QVg/pEacDbYgQb68OE2TQ6lZdU8S60Iq5WnZHzbuSLecuMItaGO3oA5gsVZbS5s+iA3KvRv6Rr88n7HP2I+PCKkvMG/sm+BEWIXwA6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81543eaa15cso679640139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721641431; x=1722246231;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaWvQretHyZcgbc92k3ZHpy/Hyf7HvQbWkmyRfLFcTo=;
        b=TYY6E3+/oGSqlh3HmjuUW4BjF376CDcqYb+CZbH1DNHdzQgeferLT1sW6Igsgt4HA7
         4JZzWnLXE5D/95+p2ift2+yeXMlG4fjnHJTYgB7wOF0xBnJpmwsjCPkUqSZE+dKbJtsj
         Fz3z3rTtNnARH57jYcJuYcQ8Oy8dCc9T0dQ1p5p9Ug3G7YBnu5/72utMx8ZSrSAxxnuB
         I6WwTZyzQ6KPyM9PrMTqGJcSPxnA5XcuAE9v2F4lL9YLM0GvRrulbm91g1Km3H0lDHgu
         P24n1OH1GXu5+yccvE/768+qKscOwYbOVjonx2ZJ0dSpkcq1JBF/TUrHMnN+PBWQqrna
         iCMQ==
X-Gm-Message-State: AOJu0YzfTej1g/GpHJ/j4ERCJD8WO/gpqvddcSVsAgSb+z4IlYqjC3nM
	PCl2a6ZTlJzd9o/R+9N+BeQvGw2M+L01YYSkxk2E+lMdujgQ45+NqWA0bATL14VK4aN6V1ZLrZ5
	28KC5f/z0ZKvgAE4gWZhI/jC8+bvWzmZL1Ks9rlRqy3Wn1eLZeBkMSSY=
X-Google-Smtp-Source: AGHT+IHope4tvoDhG1W89OqdPbRKw4PRPewgRtYC1BmFDQ9HS+qWcxqRCqgTbpBYYLM8ghS41RkIdYAe8vEEuU+neh/Xv0kA432n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8403:b0:4c0:a90d:4a7c with SMTP id
 8926c6da1cb9f-4c23ffc473fmr510036173.6.1721641431006; Mon, 22 Jul 2024
 02:43:51 -0700 (PDT)
Date: Mon, 22 Jul 2024 02:43:50 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed1320061dd2e18d@google.com>
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

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3b2aef99221d395ce37efa426d7b50e7dcd621d6

