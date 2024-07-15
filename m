Return-Path: <linux-kernel+bounces-252315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A138931181
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE59B22479
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEC2187323;
	Mon, 15 Jul 2024 09:44:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39341C79
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036667; cv=none; b=dN3IePBcX0HDySVe6D7M0KfrDZSAEhYU+/JDrTuEDcHva15jC8N2ZwJBJvq4eVxSS98DAQW7Q/MER1kuWrnR6FKU6P2u8EdFFOWQr+B1/th2WRo8yKvkcq+YtCFHL2qOCbe6+3Huuaacp+JgEQC/rKNQWYlDzVi1byYEJdDQGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036667; c=relaxed/simple;
	bh=jPo7Vli9BpMzdTYxb+U9tU2OYPPX5gr1dwEed5wxg0I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JVgLQf9SMbyB2w1UTf3CWcY+M6nh1AmZgHMPNgTE8EV4S+In7TaOsWjc4s67Er/qzG+Rktu14VAaB0UQzq+TG5zV4qT05bfrHutvdhcEUBjSwenCpl/e1Ikbbpnbpu+1G3lrv9fuGiTFC3SpXKESkHNOBeyNUzbM04HMqsZszJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8036e96f0caso440417839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721036664; x=1721641464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPo7Vli9BpMzdTYxb+U9tU2OYPPX5gr1dwEed5wxg0I=;
        b=wwAORoJNsvCGDcAtR9kIlc13oqHe46+s/dSdi9JzoDSJeMsXZGpABhjpumvS8EHn9q
         iSctQ7FZGc5Zk8GiqHrnDAkfdVED6EIuj68Cv8vXAYO7vt21FE0KHrrHkHF2qPBGUSB4
         V2uNVc5vnwlUJKcJaa1xJgyc7IbPKlOEsYuQYv+lviBashWm+XV+aTmvDHK8ofuc+sxG
         U5N3SslB77FNTqKj6/3+ECULWs7HRsB0HDno3qJBJY+XlkMbomOMzjvDY8Fj6sbr++eb
         D1XKAssXd8lH6odsf5Nype32PYSyelBS03wrM9D7zwv+tkmJR1z7dfPS6qGTsC1F8ugF
         FF2g==
X-Gm-Message-State: AOJu0Ywp2R6GUSWtZYHoZ6YkvnfFbdvxbv1vfwSzKSwf+Aqe9yrNTWTA
	oyMmrGBYv2QREp3Cp2qImImjF7BdSnjHFx4yUS6xDlvCHJiUzZxqrb7xQvKUM7BY5L+tZASs131
	FlRwiXz2YIMy7VFoBBRerPrfGondRA/ZrPhWA2sH5+IFRzppb6ZQ7+AA=
X-Google-Smtp-Source: AGHT+IEj14IJ2fREYVP+eTDeHrv1FEr4nxa9Frf03dMA5EgQ2Xguwrq6uaiHoiCB3m0oa/I1wOCfxW5nv5R1EnRDE0gIrA2bFxTW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8701:b0:4c0:9a3e:c264 with SMTP id
 8926c6da1cb9f-4c0b29c31fcmr1161116173.2.1721036664504; Mon, 15 Jul 2024
 02:44:24 -0700 (PDT)
Date: Mon, 15 Jul 2024 02:44:24 -0700
In-Reply-To: <0000000000009a502f061d1ada4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000089a67061d4613d1@google.com>
Subject: Re: [syzbot] general protection fault in run_is_mapped_full linux-ntfs3/master
From: syzbot <syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: general protection fault in run_is_mapped_full linux-ntfs3/master
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master




