Return-Path: <linux-kernel+bounces-333636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9E197CBAF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB880B22891
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B550919FA72;
	Thu, 19 Sep 2024 15:42:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194C51EF1D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760526; cv=none; b=MJR0aUWQ93OG9B2YwirzTMa6LvHYJJc1kKTENx56j9wuMu+a2w2wcc3Zcrxe700xy2HMUJLIwkQAsaj13M0wRo1v3k8kiTN4Shq99wXYDHqjiQhJ6eBDrU4Yzk7AUhXgWO59gAM5Y5rBjEtau8kLICJjpZkN7MC+KlEKM+ShylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760526; c=relaxed/simple;
	bh=s1601j0+Oxhrj04QYmpMQk/0cqhNQZ09t6PsGYwneis=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mogoPMN1YaQcaL6K4dF8YxfZe7JWYGYxyvrb7iWhL62KsDu9NXlWRd4q9Zmg+kncZhciGJvqYJMbwy1APwWjuz0bY/EguXbdXi0WukhrwbNEp062/e8Cs0d0/tMckh/gmyh4y1tlPAMJZOdBfVzNZlgaGdBcNbBb3HdSVa9d2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0a4db9807so15867115ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726760524; x=1727365324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1601j0+Oxhrj04QYmpMQk/0cqhNQZ09t6PsGYwneis=;
        b=LMBOcqQ6n+nTpTed43mfBda+kGLoa6Y3FcDe64SATSlcK7oPWciiPCQ/qaleJYruLk
         C+fYpDCjPizPnvlu7Dly9jmT/TcF6kygcua8IE+yt5UbARKno2tbRIJ4wB4lWi/ymj/9
         TVBGTdrgNmN3NLwmUa0fdo/MsYZCfKat45ozlVE+mZcuZ0SxRUjYCFnCLOzES32F33YM
         oXL69FoZfJJ0N762YNK4dmGqdAsyIpZjDYfXWKtK79FvhfNTMkzRFBLVg5cwn/K9i1xd
         vRDsxtqsgHE3SYXmXT0oby40UJ3mxoyOYq6cuWSdqRHandR+hC3R2/BzRiYlstmA+Y8N
         yevA==
X-Gm-Message-State: AOJu0YxhvpCABEvFgohUtpRzrIxLmdT4COLfp4OvtJqx7EWZ/1//VbcO
	hOQ5dMOkfx1GHlUGP/8fN8DpuNbU0JUUsLatNFis9uSKN2WRDAWfukE/yo5k2jfGe/QKGDBIIhG
	HceX9Sq98ayj8N555GSd/TFBpaCmdZmAQK5FPHt2xsP31v9gNwHNNLqs=
X-Google-Smtp-Source: AGHT+IHBooSCvAlOuSr0Mi7CQJyD4jHhZzJgFEf0CMD/oKiDCC9TYB3TwDJ6wkSroJ/vGGY5JOgrmYlljMDMIPPMRrtZmc08fk5x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4b:b0:39f:5e12:1dde with SMTP id
 e9e14a558f8ab-3a08494a548mr263035585ab.21.1726760524302; Thu, 19 Sep 2024
 08:42:04 -0700 (PDT)
Date: Thu, 19 Sep 2024 08:42:04 -0700
In-Reply-To: <000000000000f9e854062251d673@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec464c.050a0220.29194.0033.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in udf_get_fileshortad
From: syzbot <syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in udf_get_fileshortad
Author: gianf.trad@gmail.com

#syz test

