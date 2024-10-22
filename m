Return-Path: <linux-kernel+bounces-376478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A85F9AB22D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF9FB24C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8D119AD7E;
	Tue, 22 Oct 2024 15:31:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC931E481
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611065; cv=none; b=ku9R+15uQEFtx/YCDLQrVpcOMA3iphLijlibG/ScQEnO+2ppg6SH1AXquRysXVDGjItHw66aXwVcMr+FiJwQBQ7SrQOZxBmpyU7Q7fDrgIujIWyNPHxx88JS2ODfcjB04pL1G6oe91MGWwW5mX8eJv/GhS4va5Y1GWsIZE9HJ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611065; c=relaxed/simple;
	bh=dx6QxTPa/+mQ4n+fH7ym50nfkVSbWreEqPOdi1FIoYM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iQ7eowiVAHbj4A5kj1IvOGsz4QfgP3/5AJBljpP05EoiWUq35livdaU64Rg/N4bwngRtgDle8Ooca8W7h+o1hJMaOtaGCmxBjSMR62a14swvWPQKwh3xaR0hxKVcRl6PNW/QeQuC3ZYYn7D+YH4m63pcRGWh0jEZyD2vxHRqwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aed4f24a9so73497339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729611063; x=1730215863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLrx1E+31Z4OW10+IEI8u+uVs3kTaeUo1vQAtWeI+J4=;
        b=XhqnHu786UvjB1XV1jelcuDO/IpWfTx5a5vlYLb/gPEJjgmTJvAchRkXajrooFQpOm
         Qld/cTKtseUhdo9MD0WtxoGpr8a0ep77Gxhvh210+3Zo+sRNvLRTdtlrZ7vaXLrIyhzv
         9aj6IUI+8AG99kEH88HeCUs/KSb/zMKSCb7dHdq993BhDwSTfh7dxu8/9F2NWBMD28Qe
         6b5b59opbNJ9/tgjrK6fkF6ZosBcNPy8/CTgmN8EBKzwO2uCbrFsDbIJBQv6Xynbv3d+
         +j0K6IDzPS+iQA/gQcYYScmJCP4ej+Nw0iw9D/buzQenf4M/IT+8zNfoMx+ayiXPCpj9
         ArlA==
X-Forwarded-Encrypted: i=1; AJvYcCU2+8cWxgUOWzc46XFxiROfSvN6YApRYuxyfLC5stiid6ci/lK2DISEeFJBI0zaTIpUiQiv+KXQODXEhuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuK1iv0QX8EmbzCGCV1I2a0yh65+ltjWR2MU9UTdfqKLTW/b3q
	Zr7FNhql9x0EkXtAWVLU1ei36OLRHrQE/XN5DsvAKDn44nNRzQSXKIYmGhBA292Njdu4W+8fbFv
	jCoIk4vmlSETUh/aGkobElBLxTAE2HDw/UCdo6fmG7zvlr7GxfiWYXqU=
X-Google-Smtp-Source: AGHT+IFdvdlR6YQIyahOfH75Uqz6F9rwXGlLNt6wjo6UobtDESeiz2U3sOfU7f8neUoYGbvAvpvZ+CegSDI7C76l/r4XCb5cvuup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4f:b0:3a3:449b:597b with SMTP id
 e9e14a558f8ab-3a3f40a7ea9mr128631495ab.18.1729611063108; Tue, 22 Oct 2024
 08:31:03 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:31:03 -0700
In-Reply-To: <000000000000ae358c06202ca726@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6717c537.050a0220.10f4f4.0146.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_setattr
From: syzbot <syzbot+d78497256d53041ee229@syzkaller.appspotmail.com>
To: eadavis@qq.com, elic@nvidia.com, jasowang@redhat.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	mst@redhat.com, ocfs2-devel@lists.linux.dev, ocfs2-devel@oss.oracle.com, 
	parav@nvidia.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fc2640580000
start commit:   d12937763990 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14022640580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10022640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41330fd2db03893d
dashboard link: https://syzkaller.appspot.com/bug?extid=d78497256d53041ee229
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d0dc87980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e19430580000

Reported-by: syzbot+d78497256d53041ee229@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

