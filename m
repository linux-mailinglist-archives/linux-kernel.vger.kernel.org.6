Return-Path: <linux-kernel+bounces-367999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB599A0955
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F7D2827A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D543208238;
	Wed, 16 Oct 2024 12:24:59 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F2207A03
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081498; cv=none; b=TLO8dJc91l0rLSCfh8mFxKdudaofh769384fJt5UDJPcZfpQ/+3z1e45pEG2t1RtqA1y0pmqtFQiQpuidAI4Yz9kYTc2PIMSNtQRn9xjzLoGLS9wuq0wZbqDxOLnMQzi+oJn7FGqbOWU719ctm2f9RqjTP9ZXDtcYnAq3vGPYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081498; c=relaxed/simple;
	bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M2tohwPTtMGy5RD7bQ//tpoAxpjvVzjNF29PNxWX5J4KirtVCoTefyVYc0CgFmh0P6QDhCMmbzv5nPCJdri0XZnLKOssOQaktb85poEtnsEv8MpI9t1VGEzp9CydNlIlsNB8ScLgsFaLkS0zI/TPCWQfbzVKFS007AmXaT6hX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so36055965ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729081496; x=1729686296;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
        b=AdRP1rQuGzrc3c67iMxuiS4TCrtH4Zscx+xwYX6H7VcU6vfk5jfLlDTymuOQv/EL1j
         wYNbAEXUmCQh5ojJS/dktKejZr6qz+Y8PFzzgns7wHdrKbI5nJWHwHnfW2nOMELQcacu
         TA6/8Ke9TF0k6K8iz/WLWb3m3RyMggq/Lw7oKz2HlMdBqKPB2hDeFOAcbLfRwL7S1MQW
         noleD8w1ZMeNKKOd28Zgw+EQMBvxxRAamk+4VVhpqeDnOXMYr7couGeyYRZSAaPmsZz8
         PbLSieypl+G90YdF5vLCtMMzyI2+Vq+N9mIG3zR86qmt1Tnj0TKG8XXu5WfBKZxz5U60
         0Iyw==
X-Gm-Message-State: AOJu0YzutN1Z8VTBeCYE7HePSp2EuS9H8LAUcOcrVQp0i4W1315BUhd2
	agtqXb/pqE5eoPjOm7dtfyrBrfDglSN2K2WV7flGymkpLXUeuDZIKrQwBcIQ24o4JySCOk8rogf
	/2WM/L96nwc14pGGz0iTOWNRLDufpWiMt+4Rbpo5w6wkMMjd2/Rl/LQ8=
X-Google-Smtp-Source: AGHT+IFtwoTDSmvFExLK6K5idK5cTMkctX8smPHuwVYUAUDmtNwnnxoWhgt95QOPF0aLiY7ell09S7LAJ0njE9E9bmvXwJT6W/7h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:3a0:c88c:e674 with SMTP id
 e9e14a558f8ab-3a3b5f1de0bmr153375675ab.1.1729081495988; Wed, 16 Oct 2024
 05:24:55 -0700 (PDT)
Date: Wed, 16 Oct 2024 05:24:55 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670fb097.050a0220.d5849.0015.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Author: cmeiohas@nvidia.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

