Return-Path: <linux-kernel+bounces-239578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC892625F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5540281827
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038D17B42F;
	Wed,  3 Jul 2024 13:56:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593B173336
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014964; cv=none; b=Yn5pJ+E/sIFPBn3v87ChR0wLWl+f2XFD3FJ9gzBmzA60+BkHGnN/Qb58763Exqqpo0GC/WCnhRV5D+DLI0xIekNjnFcMPKdIakxvHcevu3o9QA/NfX5fVHhBlDxqiWpTXfjDLOTVnS+yUtOKQNGcJUA8CHOyjl6wUzSEyL5ABDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014964; c=relaxed/simple;
	bh=ogDzCFWf02n0NhfQtrOVZBGui4ufGppKy2clFYNagHs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ol+hGF+vKw9oN6jMATDqXO60gGgR6XS80gIPa/f2SKIVGoPbEtlQSb77eHkmaOuI04HAxfqZ2nk9fKkw1I152Cjqh//Pr+/SelAE294dOf5yWnwKK6UmaHzG/PUAgcEx4MLNmRey5wml5/Bv71FmLkLGWgGuvnZHKASTKgXcrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3c9b72aebso583933139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 06:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720014962; x=1720619762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdq3tCuwQI7n1SBMovokzqtbZQ3gSeo6Hdp/WmawlMs=;
        b=FHZ3dTybCbLcsNEGQa0bKFYtAd3+98peA1EXHF6W6Rapdy+zyL+iVzeFCH6i00cOYO
         MBhJSUSwrNQpPKHksCMUuy/jXmcxTqHnhOyNoHeCkMBvv0Tue+zny0HEu/iZHnTGOAbi
         IVUTWEURyCHFsNNBIWhx4H0MOkeslP5gK9RUZmxAEXgs2+wn+/aJUX/rFR44q94LDJI+
         ie+tcit9z7rZyhi1YcXW73x1LJz4rpGCqQplpVvWyIB3pRGtUZbSCVQ7HjxJD8/7QZIU
         OTvbnjsnluvbMfSxdPY3x8528++4dJkQg6m2Lk6LhIray2vf+ln3pAzVaCyJ7jug7L3C
         4YxQ==
X-Gm-Message-State: AOJu0YzxTvFMFNoBo/PaSwgjxs+BNFwexrVirV5MbZtI3pGXCxNbmOo4
	1LjUMu/PHAOTCFfyH4EFdESH5SdXEoR1nJ5TaxQY9gG8XTXoD+6ZWOu86ytvvR6bfdf9+2F5BTx
	rc45EKFhXWPb5OjbZPAIy6mV3bbcWbs1mCZbxbPHtT0RbbzrIg/MTrH0=
X-Google-Smtp-Source: AGHT+IGdPgzclsT1Avf35z8PIjaFfO2Dyj4IQIm1vY9gWUxMTSKN/6uAP2iE+61ZcC0RGxTQBsOJJz0kS8TRV6r6BO7bSgXSnF9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:860c:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4bd4861db3dmr267983173.4.1720014962233; Wed, 03 Jul 2024
 06:56:02 -0700 (PDT)
Date: Wed, 03 Jul 2024 06:56:02 -0700
In-Reply-To: <ZoU+7gbOSzWMOOPC@katalix.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d527f8061c5830eb@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/l2tp/l2tp_core.c:1301:24: error: use of undeclared identifier 'pos'


Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c5a181980000


