Return-Path: <linux-kernel+bounces-230216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B28769179EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5946C1F22D71
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982715F318;
	Wed, 26 Jun 2024 07:40:21 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8581FBB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387620; cv=none; b=LupfxQnfl+E2kjtFN/Te4t00tl7crEGZIehfdQjiRqRmApvimsepAzkSbyk2rpt3+FS+WHesacNU601zv3LMFeMNiOHOThs6Yw99j1XES44URUNvps6gMWP4SIGU4vbEXiyE96nIEhPGN/E4KZjFAzluzqEzVanfQoe+6wO4Pwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387620; c=relaxed/simple;
	bh=tFUdYUqO2zHcvTWdo/F6Xr1eGMirb2xxUN7bO3zsX/I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X/H0qeMtjQPif77axezhphtsegfMRKJeAMPeTXiavPkf6jH+mfhmEtlq12PVVrJ/V4WO8M9yyqNG/ib6MwBYVHvKTlPLrdS8Yq0b0lMSEnTzDiI8PiPQTNDb5ItMWoTCeA/pcir0mRQA5CpTzvUagn6LUfE3zSyd2nHgDYMOUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-376282b0e2bso78604395ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719387618; x=1719992418;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFUdYUqO2zHcvTWdo/F6Xr1eGMirb2xxUN7bO3zsX/I=;
        b=Qvn4xrhzlmcaN1BaIYdyjFQHLsBSW51WvgaCHIGe+7fXuiu1+jYHRQzMGJ6l984Smo
         XFGhiFSqnAVOaYJvyDClNATZNcQM1pGXkEOCXJYcQPyJuAYhT/qxcNsPadehRrOglA/6
         JPXXotBw1jD987Ktn75I+BIsmTpgFyhPhPIZ4DytIB1znTZfcKCNfR2Nqi+u1wZi/rtO
         UbEE8Jcy9Od6J+atF7E7rQb4DxELHfshZ0a7NM74ycsnDFQlGrenbDh1XlmlZ4CvDgzl
         i2orFCn0fqS4Yn3/YEf5Lh3FwXeDP5GUqLG+cTtpDDdZe7O9UdnKmfGqUE2JkQ8LtTNs
         EVmw==
X-Gm-Message-State: AOJu0YxY/oFqo8HU8h5twBqepeVKt0o2DPc46Jx2/H+LNuoT2eoEO/gY
	LvV0KgWPk/PcJJXnRac6WhmN4snFL8Z91PlaniWt9nxkpG0peP9/XLxydmh1VaeaNGA9WMJZUJd
	59PexKMqhm7up2KVxtFSXR+GjUDbiOXTwrped6CvNsQiHj+ond4WxOME=
X-Google-Smtp-Source: AGHT+IEwgu3xhLTl95Fib+6zP3VSa64PbmKETDBLgegPXBweOjsJvVr9jmlDQE0JsvAm70rKM11evW/FoOw+NhkAULpvco25xCV5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138c:b0:378:3c30:7619 with SMTP id
 e9e14a558f8ab-3783c307801mr612815ab.5.1719387618518; Wed, 26 Jun 2024
 00:40:18 -0700 (PDT)
Date: Wed, 26 Jun 2024 00:40:18 -0700
In-Reply-To: <000000000000aaf7ec06186a8d13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bb442061bc62078@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __ext4_check_dir_entry (2)
From: syzbot <syzbot+11af34d3c0711f233fd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: use-after-free Read in __ext4_check_dir_entry (2)
Author: norbert.kaminski@infogain.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 55027e689933ba2e64f3d245fb1ff185b3e7fc81

