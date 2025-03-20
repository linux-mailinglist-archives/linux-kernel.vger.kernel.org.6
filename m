Return-Path: <linux-kernel+bounces-569295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7CA6A10B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F63188C514
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F78205E3E;
	Thu, 20 Mar 2025 08:19:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D841E832E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458749; cv=none; b=ovydlyU0ovqD4ykAw6dNk8jPrrTOj+5D1PSbwg6WDALbbJDVuW7MSotHGRCQZynRzCStAgjhhXJt7NTtxsAVQSzwf4AjXMh97l8gmcv9fPd5g3dIZ+vf3KyzfwZNe4UxpCGt4DH0YdZC4u3gHQNtuqV+B+8geCTBj+Ub8cZIrZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458749; c=relaxed/simple;
	bh=dQSLooTmN2HIWPJybpTzymcE+nUlDPqrg9LSn3p/eek=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HQrPRnIf1tfv8OFlmfuJrfwc6rvL/Jr9ku6ORx+W0qaAzQXAlvP8odUb+ocQxchI+JV3Cb00UqJCLoUt9nGoNw0saNVcLT8JM4yB/YaiHvpCfX4z5Vq7Ot+k8sx/FmiG2X2oSGrzOpI7E66oeqNv/EYb5tbuR74eGdw+iSn/u50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d434c328dbso9160755ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458747; x=1743063547;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FkZsC+86W3g9jPGh3loS/ZM0dl7YZEVEqLlCHTRhnY=;
        b=qpNaHwCeArfM5iCF5mzMK4ObIXihx9x7uCeGsslMEjHP8nZOVHCyFtrS2jOIY02su3
         9aD31GtSp5owL2dW9Wg9tpbUC8LGasegLK9xbXXr3W16yvG7rmBRcW3E2MP4eontk4hJ
         LN60WZ8PVi9gWx7dQeWgzK4S+oOrSeL+dFs8H6tN9kWsC/g07YEMMWo8KXt5mr6qPZ03
         so/pofRFpKWfSPReZe3drQTNmm37noR4+/IlSz5DurCiUOKYI8w3bdimGXybNOeBsECB
         Yi3q+b//A8/rekSiOqVLgdlDFjsMUSH0HowSi77ImvQhdXaEdlIIR05Zv/EI6PYg1il2
         b2/g==
X-Forwarded-Encrypted: i=1; AJvYcCXBR2TzuPHCuk7g5Eqhq5t+qrHsUBqsiwuba52/IroufRMWHz29hknrL+V9rT70KNQXGQKq7I0QI1TLEHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXFjzZhgDhbjDz4CmCoOQ96bYMPyEp/TA9mZWnQQGZFtJa0Mw
	W5O0yBCHRNDkv5yRoc7C+u7U8jDOCr49sp1+v6iMLhVZsGpnenfi2UGBlZQpaiVvH11yg9Wbtht
	mo5diO/ee2WSwMc9DjajT/RVkKSttKcrR2tLNX5KvEcDD5FKFsVFrRJ0=
X-Google-Smtp-Source: AGHT+IHBHBHfCd1wdHWYTZ2r9LRa3Dj2LKb/16m3v+HxIa4TFf7nb/73CAlga1yPkZgEzbIT4nhHKljQF9D1QArJKYTQaL7Nj9CK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1549:b0:3d3:e3fc:d5e1 with SMTP id
 e9e14a558f8ab-3d586b1b246mr57152235ab.1.1742458747107; Thu, 20 Mar 2025
 01:19:07 -0700 (PDT)
Date: Thu, 20 Mar 2025 01:19:07 -0700
In-Reply-To: <CAMj1kXGxmGwJieicpgOcErBGaMm2=CZz9Ra6G203AobexUCyhQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67dbcf7b.050a0220.31a16b.0009.GAE@google.com>
Subject: Re: [syzbot] linux-next build error (20)
From: syzbot <syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com>
To: ardb@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com
Tested-by: syzbot+06fd1a3613c50d36129e@syzkaller.appspotmail.com

Tested on:

commit:         ff7f9b19 Add linux-next specific files for 20250319
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=4bdd42b70d1ca0a
dashboard link: https://syzkaller.appspot.com/bug?extid=06fd1a3613c50d36129e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174fe004580000

Note: testing is done by a robot and is best-effort only.

