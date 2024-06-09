Return-Path: <linux-kernel+bounces-207386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F0B90165B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B46281727
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4567343AC4;
	Sun,  9 Jun 2024 14:27:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A942233A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717943241; cv=none; b=LzklwGQGEnLnt0K+A675BEXGh/OGWEShA9XSY5qfCOEA16jioCscpkCHTPlPvJJ12blnfTyg1mzcyeqvO4CXenngw2ytt6rcux/3yaSgCckvyOhECUrWwWMRtdocwoVPN4+nVChLMYLmm2IKDNGXFv1S6nBi/s3FSDZmf7YjxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717943241; c=relaxed/simple;
	bh=uCueXMX0OM59PcADSVt5fbj4XY/6xP4O5x3Q6OOEq9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DlZe7czl16N7JIKNRpzp1uFYeeIY93THtTGL/LK2dOia0GZap3QTPxgkoT+d0ED/8XGpgysbYzXY0L7Dp3n6x4K+WJQHy00OY4EDbUBSXhuJYGoW41PdKbbgswjvXIM43aKoAp//cTxuuq5OntEeCbWv9X+j+2QTjiKglpvzN78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e69c0762b8so473756039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 07:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717943240; x=1718548040;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCueXMX0OM59PcADSVt5fbj4XY/6xP4O5x3Q6OOEq9U=;
        b=rWrHfTFeUX7nsbkzWL0/YuB8LD6I5jPgQdhIv7nnnHfGF42VZtiAaUDbSENHgOPFIy
         d8MFI50ovUQXx31EpDNNt+ovp0HHnhrFQ8vBBvozyiSm9Gs0MdnPvFj70nkZXckwUviW
         cBhnkIyugfsmQZ1h9l7oUXGs6zLqURM0KzkaKg9MASIAYtRR9IxCcTDg6ImhrwmsTuJw
         tzQHydNoMAOWu9I4kSk9aXm6672NWzNw3adJtjUU+JNc/b8ouhq0nks2soZ6zFemR07W
         WCf+1+SJG3R6cRY/khu66t+S2f5/XCeQpZ6E+im8/RiVkV4ftE6747Fxexvu+sd171mb
         GHag==
X-Gm-Message-State: AOJu0YwT2DeWAzXuH01z2I2fZwTyQFbfZXS3CDb2rV5D2TBgS/pXy/0Q
	rVsFSsIqtNpdnLLjK5ozkXxeHyb1fN4mg1aJOXkuQr2+5UMKKDPQ9DrFTDgzbiJYJN8VFTjEqwK
	5xbtGXZvDaaKi7nDelTJgKNjE0oQ37GNaunf3yBJ/NJiGzDAelcIaoeQ=
X-Google-Smtp-Source: AGHT+IF1i7BRptCTWbWJ3Pvm2I4/MXiPfhuok/5eqlVYFSmzq95QG8zw3B/h+dkE4e0TH01A5J0pH7vgEHrsJT3pdur6m9u7Mof5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14d0:b0:7eb:76f7:4857 with SMTP id
 ca18e2360f4ac-7eb76f76027mr9983339f.0.1717943239738; Sun, 09 Jun 2024
 07:27:19 -0700 (PDT)
Date: Sun, 09 Jun 2024 07:27:19 -0700
In-Reply-To: <000000000000141201061a75665a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c99a7061a75d4e3@google.com>
Subject: Re: [syzbot] Re: [syzbot] [usb?] WARNING in kcov_remote_start (4)
From: syzbot <syzbot+7110e6a4069f19537d85@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [usb?] WARNING in kcov_remote_start (4)
Author: penguin-kernel@i-love.sakura.ne.jp

#syz fix: kcov, usb: disable interrupts in kcov_remote_start_usb_softirq


