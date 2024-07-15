Return-Path: <linux-kernel+bounces-252274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4729310D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD141F22CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC661185E65;
	Mon, 15 Jul 2024 09:07:15 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51855223
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034435; cv=none; b=KP03Fp6WyoP5/k5s3fJJyppdM/TMD5pMTbTkxfMrvqESEGlYytMbDZeDRA1iOc9bkru8FA8QlPK6bYSn+P2RD+bjpWISM8Y7X0pWlim5vZd42tSfJPOUYUWu8Ulxv9uboz6GmUa1RbWOdEis9OaQpvsKHccBiNt9ELYd4Mvv9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034435; c=relaxed/simple;
	bh=ohuRCPHLd7+naRc1EyHBNadseHMXk4/75TaDOlTSTto=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QZk4WNyjZHIdNeNE09XIRs+DoS7PejkY6HBLcGGxIFE7hUe5zbJIHF1C6SFq0QQ9tE8mt8IgLNkN0poWOkZlqWsysfeNo2pfxLYOGZHu1/vjDfoDYa+/9qczXFxIuKJgvXVE8XN81GhhIYvw1KenAZI3r5ul9Wky3WYMqniuBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3810df375d0so42676595ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721034433; x=1721639233;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O96IdfMjsezekxWrIjuCiMGX07vQHStH3JV1FYX4ArQ=;
        b=b8ik6VDWlzXU0L4VFHKFQ0/zAQBhPpItLptvwJ+UHVcYY+C2csSPP5ND7HFIjN0rMi
         ZxWqTykCdS+TFYS5dpgd0tpUqY+IFT6IoK/Ugq7zSl0NlCb6AFB6K+GeMkKwWg8E2bFI
         0Y1ItpLpbVRwd9VIay52+wWRxbDrbsjwwbi9dti9Fd5iajze9iNqlDJMz17NsyC6H5Re
         RGw/KK/dsxN8Nv1zg1H8eDgGaTDMhx/+8a+VvltVtJMNTZt8KbgY7fGZcfHBzC459/aO
         PTpiZ4D+OrLaw/RxtgH3xTsxLOW87HIJwnQkRIDj4Tvg7XoeTHSx1DCSVdU2ou4xAZEt
         +5fA==
X-Gm-Message-State: AOJu0YyEIcRI03WkOE8aVIJ69eElN5LRY97as1RqPBccDi9G2vcvo1Yr
	fd9tpxrC5y92dlsKpyEQi7NQQ8WlM3lFN3PNuKyXiattSdMT88dJ8yThwLyVIRW2qOfqpIgAZHm
	BzW84VaYlqj6W2UbP9MRoeaIKdEkW8XUCCN9W49T7y1UD5Q8RWgqX1rs=
X-Google-Smtp-Source: AGHT+IGbJsNPAM9VqjFaTcArIS9GNq1lUKNyk9Agpt6+5Hb/V3WDwZlqSFSi9s+4XOO4xTwJBJUZM900wTmTYZmm7J/cYBtvt0un
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c562:0:b0:381:f3bf:c5d2 with SMTP id
 e9e14a558f8ab-38ee37a005bmr8183665ab.3.1721034433105; Mon, 15 Jul 2024
 02:07:13 -0700 (PDT)
Date: Mon, 15 Jul 2024 02:07:13 -0700
In-Reply-To: <0000000000009a502f061d1ada4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000081fa4061d458e02@google.com>
Subject: Re: [syzbot] general protection fault in run_is_mapped_full (possible
 patch with bug)
From: syzbot <syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: general protection fault in run_is_mapped_full (possible patch with bug)
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git 
eb95678ee930d67d79fc83f0a700245ae7230455




