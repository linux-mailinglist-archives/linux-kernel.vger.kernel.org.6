Return-Path: <linux-kernel+bounces-361345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C7299A70D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333BB1C211E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87511940BC;
	Fri, 11 Oct 2024 15:00:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C2718EFF8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658807; cv=none; b=VOcx90UI8V/DCk90OS65VuBC+BEm/MgXaWKgeOmqDDfmE7HSVALahFvB2boEqcIwtm4qYWWSjMoZ3WqDlHChf2KGhlTiEzJQCXMMImjZ1Gzxy0x8WB15LC7pLZ5U4mbyGLto34JsOHtlDF42gfo8ICAtS1FUbAzedJLAChWEuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658807; c=relaxed/simple;
	bh=2Km6BL0FRqfzT5lZwFo14imXXYmVPoCW7wmjwz6b+WU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jt27kiAIlCS++JcD8kabaQGSCXZ0JQpVuK33SCqlJ0GI+W3aOciG1ipyWcimagx3PNO4i4vHcqppDz0cJ3/eZruO3EQu48ZaYbN8r8ffY5o0W3Fgj7ugiJvb1goZA7us7XYqnnRGJxBZnLGQHMgO3xB7DaZwI5LOtsZeKPYxpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b45bfc94so9568065ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658805; x=1729263605;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0ze3FDBtSlJGNVpIYg23jcNgdA3xWetND8s6HDKdd8=;
        b=nTpTDy7/I98YWM5GBC5nffZ4iuduzvD+njQtDp7TuGHBw+VR1pJVBB444bk24z0QLj
         TgBnYw4ix1HthPqbVxLTOxHNiz05fLDG2OcrFrDxttIdUnRV0RXHQLHu0NLsR3Ozobvm
         6wZPlKVjf1KHAQLLN4W5S4iZdy0LayxOdPFkNGEINXb4hmAOnZeaMa5wAc03V+IzV7mi
         Xg4BBMMrDmWSyfU6lddlejFM/i7FqN1AtjPETgZGSYvLoXeierzjScvt4+jPu7TfSXT1
         TpsJJJLnmAnK4VDAyOcBdgr7rnnh/GlLdxfrfc7GuStz8C1QAUFzUuGGveK33jVQxKBv
         2+GA==
X-Forwarded-Encrypted: i=1; AJvYcCUpNngJ9t1pD22HCrxj8aRRUr1mUqKv+/MCK0bY3hekfu5EFUSnsaM2nA0AQwLzexuU1/6q8BiqIRfkUZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJ27z+IgGLpD0jDXyGSLSOjx2m3Tk+WsoOeP/XuRby2yephP1
	lQYwa7Oa5FJR6+u2VWJROdUZL0wpREAJwvcxZ3GLCVwA+u8VgtFB2im301YNYxdltMuDEFw6Bvf
	/zYdY/FWmlrVzl12vZeJzVa5nJqltQ7TFISttSe0z4XZMo51gu4kpDbg=
X-Google-Smtp-Source: AGHT+IEkxWbRSE+bJK3OWzUdHz4d+eWSymS8o0irv99aFLwC2JsKgBuMI6jVPSkv83p8SmbpjhpJMCobr0krqH9+JrIcnr7OfHRZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d96:b0:3a3:b0d6:6b7a with SMTP id
 e9e14a558f8ab-3a3b5f9e4cdmr18900275ab.15.1728658805214; Fri, 11 Oct 2024
 08:00:05 -0700 (PDT)
Date: Fri, 11 Oct 2024 08:00:05 -0700
In-Reply-To: <9cc382bd-debc-42d6-977e-559d48b82f58@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67093d75.050a0220.4cbc0.000a.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, sylv@sylv.io, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/usb/gadget/udc/dummy_hcd.c
Hunk #4 FAILED at 1301.
Hunk #5 FAILED at 1323.
Hunk #6 succeeded at 1778 (offset 1 line).
Hunk #7 succeeded at 1809 (offset 1 line).
Hunk #8 succeeded at 1818 (offset 1 line).
Hunk #9 FAILED at 1995.
Hunk #10 FAILED at 2389.
Hunk #11 FAILED at 2467.
Hunk #12 FAILED at 2497.
Hunk #13 succeeded at 2519 (offset 2 lines).
6 out of 13 hunks FAILED



Tested on:

commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ae9fd0580000


