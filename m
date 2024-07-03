Return-Path: <linux-kernel+bounces-239382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDA6925E6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D56E1C20A78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646D31822CF;
	Wed,  3 Jul 2024 11:30:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E31822C1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006205; cv=none; b=eoL9KNU5yCjhvHvq+gOBGrnDbja1TkqfVxSJRi9qjztech5E3d5G0+NDs0WnjdzggCvSqzAN34RNVaA4kx31fCZVAjzyh3Kqyvc6t+RnThZPi6velHdrGR/Ms2FoK1ZJWjuvWY/48PGrlRqx/mYHkioG5X0tqqaRSqH5aXNwbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006205; c=relaxed/simple;
	bh=BfBH17VJtXddypEgWxOTCDyxog3F+1OJeoRSo4XyS88=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XRmlA8hOsbhmi0oH6nDLBMxNoI2mpkPCWuQ2leF+33mAQx9SMF2N62iKTTUQlA6gmJhp0A3QdO7CHDFXWsMnn1FWiUYJxeUqlF1YyAfGjwALwtkwCFTZHbOLcpiP8PE2iH9oHD8RIZBOTbx4FWSxgusHfhYH4CLjLqpuWAeL/Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3d2fd6ad6so597339539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 04:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720006203; x=1720611003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtDOwAyHfaH7yyD0GH2aSXDr9A+JGdnxgQykaBHcXN0=;
        b=HP8nLT/8HOoQMWm2O+P4JZBirejGVCCfl2VHIGIVmvVPri9lI0od1MuFbEPJFLDVHA
         I0w/1idhKeuN6c2cGLRqatvJSdFry/FzWjXtdlwaqhqWR1Fjz4zNol+EvbX9cltog2Gn
         hUVmskrRPxGtL8J7f2NrA6HC+T02cEpgIu46ebpbZkxmjd92oBBJtG2iUED4m/eO4rnJ
         mrK0pISTTkW4MLO6s5ESyOzT0eLV/npq1/hmpU3gEx4V0zhasnskOthN9LL9obxlSbdZ
         w5UMqP4jxFbOCaSUBI1UOTY/leUTJkXxFRjnKHjtqM91OBrMpUXBZ5U+VOtNQFbLffEp
         UGYg==
X-Gm-Message-State: AOJu0YxEGxoux2KNh+qM2rbY2wh4WR2/YI9QZPWv59m/w9nrhX8Ox+85
	TefglU1n9nQtJlDzHI6KSYOF+7fL9iViGCusMD5qXNKPGd5rBXu2vaVNfxVVWBqhx/9EZnuxfg6
	DUisXXz2NOZaM8XGYsa4qyPmvtjbCQ8ERJFWzBo5R4r+4+OCK0eoKaN0=
X-Google-Smtp-Source: AGHT+IEIax5/D/dGA9BMfrVKPEvu7Yt1XPECp25e7JFAWps+K01mgYPk8aNZatnMgXBVhW/z5tyDzrI3AxSBWUzCt8yxku8lQpR7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12c4:b0:488:9082:8dd0 with SMTP id
 8926c6da1cb9f-4bbb6892d94mr1132629173.0.1720006202854; Wed, 03 Jul 2024
 04:30:02 -0700 (PDT)
Date: Wed, 03 Jul 2024 04:30:02 -0700
In-Reply-To: <ZoU1Aa/JJ+60FZla@katalix.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bba661061c5626c5@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/l2tp/l2tp_core.c
Hunk #1 FAILED at 1290.
1 out of 1 hunk FAILED



Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177064e1980000


