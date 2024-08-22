Return-Path: <linux-kernel+bounces-297718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D165A95BCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902AD2813C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E21CDFBC;
	Thu, 22 Aug 2024 17:05:50 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986EF1CDFBF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346349; cv=none; b=oNxvddlgJpE7rP5sbQz6dd5pGMmFGURHOfNJaf7fOaUxi5B+2zmhu8qzsi/oqjWi0YSyHX3x8OqNojQlf5o5NiRgh0QQVBBssiguPKRedwf2u7LLdV7P8s3hu4WlG8r5tUketXL2rnib6ZyAGw6HWN7zBxBE/JjmUb3LSloZTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346349; c=relaxed/simple;
	bh=aybPYL2O+U1ecqK9SG11Htg04ZfA0HAAxI9QR2r8bwk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hpy9sjHeTemyyrZQvmsM7CSPkcMurix+Ok6VX98e9RAAR3u/ap6sHrlQzJTc9dRRLj9R0I+IG+REzF9cJ2Jh+iED9Wkx8nHCxwI+pNu884BnbJApHaVtIwY/JIcPolEq6ktq1PaLHevMaLOA3F3HOe7JQpHsFpUtNBLBUDSru9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso108006839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346348; x=1724951148;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aybPYL2O+U1ecqK9SG11Htg04ZfA0HAAxI9QR2r8bwk=;
        b=jQ4XCEY6nkE/ca1QO1g0XDHpaP4FY/BkdXMzupbuAD0E0b4PGBR8DKMJmWDEZgIOcL
         FNGwYUjv6/cyy7RR9Ib2UiEkbw+5/NC852dNr/c/Q+mtCZz52U3KHwFwUUNIggICYaFi
         pr24Ip7BJZfnVZjjUBA378VyFumciDvGBNPFtYJX3au0qsf7g86cQwLysG2MwNLsuE5N
         WUJ26hSQWM845aiWkxrA5S2ZNJg8jGG2jZgFIiwINJnCEzGsSco5TDEPwpR8kXjgwS9g
         ZF/u2YWBDVOvfyMAy0gNfsUhiLx/rsHZBbqj0UslkYx9/EvQh+DbpmKAOE5B5WDIRsDK
         o98g==
X-Gm-Message-State: AOJu0Yz8ayz6/l378J7rPV02YXk7bDyyXyTi+5FYtWn9ZhliQygbBoO6
	4p1U39Zb8Ml9dL2lpIyPIHC5KZnT/+96pd9rtq7U9DafL8n+OFHCUt5t5dLfjldX4h3Kr6t16L6
	us2mZHDoV10VEpwMnm6xm/c5XZ/kCnKfL3Fez5BQ6CqQKHgZQvq7Lzvc=
X-Google-Smtp-Source: AGHT+IGEAUfZmEORqMpkWcoPc5rqsLJ76KulZ4FOKBaRVH+M7Wpoe41/EAwI0YlKpqj96AWMLSxB+dzgFJRVwpn1+WUK0v08lbTy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ed:b0:39a:ea7d:2a9a with SMTP id
 e9e14a558f8ab-39e3a8d705dmr169285ab.6.1724346347585; Thu, 22 Aug 2024
 10:05:47 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:05:47 -0700
In-Reply-To: <000000000000e15f4b06193763db@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084901f062048abcd@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in rw_aux_tree_set
From: syzbot <syzbot+681f3c43b6970652376b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in rw_aux_tree_set
Author: kent.overstreet@linux.dev

#syz invalid

