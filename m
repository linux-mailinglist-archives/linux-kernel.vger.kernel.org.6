Return-Path: <linux-kernel+bounces-297734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 000B495BD05
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5A4B2942E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEA41CDFD4;
	Thu, 22 Aug 2024 17:12:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F581CDFAF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346745; cv=none; b=dek5azVRb2BqnbKtfI4qgLYWmpHRJ2fbOKc8ssWTF0MtzsIG4K7nIT+ec1RFdI/xZ+ISlvq3MOv3cpODcH+S7kd1lm9cQJFCtjGiU2V5kMp7GXSrA2mH4o7+SuQivcp1n9Vbozb2favoyqs1EmRCVW83RezX2B8V/YdYmC1iE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346745; c=relaxed/simple;
	bh=p4vi0B8+MIpGPq34NulXXPdfay7PqKpQm29u2vTektI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VO7LWbfSsMOFzy2yC1JmcCqUEntLCbjjqSYSO+t/d1lOQEehTyd7XAZdDeGNE8LklK96/GWAhzZN9T843hVYSj8ktA+t5kkmWt213o/U4A0B4oC0za47z3WNj7EkNF3AhC4oJyEAH+WLM0JM8rhFWs+4HVsngYKC+wQUijLFYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso117655639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346743; x=1724951543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4vi0B8+MIpGPq34NulXXPdfay7PqKpQm29u2vTektI=;
        b=NhtuQdGm9ZOXMyvqS1Et9XDWi31QYJtpNT64dQXogiaxpFVBXZnf2uYZZnhqgpSKPJ
         fmm/eERMEWrIhbbPgZ1sH1S4/mHf6f8L8YSNmxnD6XIeagQXQ2ff4NEsWBBvihbktIbv
         PyXYNjVZZuyDa/bTPNF/q8eDoGlyGd2NhrH0AW+t4TUSCSSIx1k1Fvg38j9EUXiPdRON
         wL63Fi9oZDvKII/2n0wLZLIjczUWFCLbVymgIBr98hD2QjU6jdxwfxpHn2fiiMeqe+6C
         n/9+I2zZqFG3G3KTsC8U9M9WWQmDciDZ95u9fFC2mTgyvBXgqd1pyFclExOT3s83OxWT
         dO3g==
X-Gm-Message-State: AOJu0Yzt+O1VsjUondjrlMadl1YFH2m0omZkf9O4KTl+C+VZ+tFsRblU
	TTNWYfeDHF+X4dqMV9B09UnDXpmRuHKp2ntt3iQCobKdJOfmG9ZlqsnnpdnIzIyfq/jHMq/X3NF
	kdy4LEFlef1Pz3zwTusApVWBJHsnk/g+qEyU2hMkUzRgXN3/H3oMOSl0=
X-Google-Smtp-Source: AGHT+IF6lB5kylHllOzvjM/y49Xr2ImxtqbLOjekD97bEGITvcZvi/YLOdZwA6Sxalkag5PJN6agHJB+lJSdmdwfMcjvTAdl3WaC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8609:b0:4b9:ad20:51f7 with SMTP id
 8926c6da1cb9f-4ce7f3cbab2mr28049173.1.1724346742858; Thu, 22 Aug 2024
 10:12:22 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:12:22 -0700
In-Reply-To: <0000000000003aacfb061aa140ad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013f785062048c3cd@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] WARNING in bch2_fs_ioctl
From: syzbot <syzbot+9757fdbdabd69eae08ad@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_ioctl
Author: kent.overstreet@linux.dev

#syz fix bcachefs: kill bch2_fs_usage_read()

