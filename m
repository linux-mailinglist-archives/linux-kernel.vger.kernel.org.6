Return-Path: <linux-kernel+bounces-255963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD9793471B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A974DB21C33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460A39FFE;
	Thu, 18 Jul 2024 04:18:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C261B86E7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 04:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721276305; cv=none; b=p7Djbmmp3hDsa1Z9uSYfXkZiB6HCwrhhrfrzc1YZRIGs3GEiK6obQAqZ0r/d4M18dE2BXBqDe+R4kK2FouaWHbRgtQxBS3yhJw5GucB4d8XwP4TMS8hPt3cA0627ov5x4Okhk7/FmC2BXTA9+a5zFKAc+FBHEUOnTK5wC3PY4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721276305; c=relaxed/simple;
	bh=Ib11ZoCrGibGhQLlrqZzmjRfKdVtR0ooj2C8/w48daM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NIkxxlYg/nW5NIgAeqCN1XwZ6MEWrh3+kGCZHkPRoI2ug+YVqtiRsDLDxMvdbcqSK1S+DZRftL2f+WED6nSeUrSCmYULtQbY5i14jVffnaSATrS0HtDUuV3cWf8PPycFqIqvTs7cmvNbwjbI4RoJmM55FIbHKxPeJfvmP9oxyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-396c41de481so3373745ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721276303; x=1721881103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib11ZoCrGibGhQLlrqZzmjRfKdVtR0ooj2C8/w48daM=;
        b=qvrbOvqpr403FFslS9Zh8tGIZwxwKn3AM2BvccCktKEpmwtXfwjUijiORwgWmmqTD9
         utMTL/kGT7or7QbcIe2QVlR6Ci6Zz5S8wGwETq9goCksfqu+g7rBztwTJVUvbGPlUXEk
         0uZeSXFxhRKxa6pgVB7dXS3M3arxqHFM8CIZRIM8GRG2t+kfrgnDPdC+Xc0j7Tgw0NGV
         rmHT+iGrcpv428jiGMwDD2eh43gEXNz+y+NRFRx6wjLqSEyf5dQZktt92fXuhl63VWd5
         DTVODa7jRMUJUzRa5LSMA4XHcZOx+/MolDb4zE4P5PDUc68ANvRpB4RXCX66TLy5rmYO
         Z7Qg==
X-Gm-Message-State: AOJu0YzLI4w1Ch1yVZt4Zo5hVUQyyzzYv2BeAqVKOvczbVNy2De6pzE8
	0rz3E62gy380vXqHO17wfiHN1we7XMMTvu4SiHQ7H6p9Scq1Wqq+zTQ7oHuiNgaKgFCRvigijQ8
	cyx/KnNFFh55m+q8ZSTxx67ixu7BNgQ3PSSu+tP9+WPdi3tJyAyaBj6M=
X-Google-Smtp-Source: AGHT+IGdBvKTKzumb7nxsv/HcA5sd4jdnCviHUAfRPOmZm5gtM363Wy9lQU/Ihzkl3Nzu7hUO3hDNhqVs01X5x+pnj+UGyXvMrhI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:382:6a83:f4fc with SMTP id
 e9e14a558f8ab-39558298dd6mr2731665ab.5.1721276303221; Wed, 17 Jul 2024
 21:18:23 -0700 (PDT)
Date: Wed, 17 Jul 2024 21:18:23 -0700
In-Reply-To: <00000000000077c88b061d7b893e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d38a4061d7dde66@google.com>
Subject: Re: [syzbot] WARNING: lock held when returning to user space in ns_ioctl
From: syzbot <syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING: lock held when returning to user space in ns_ioctl
Author: djahchankoike@gmail.com

#syz test

