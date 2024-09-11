Return-Path: <linux-kernel+bounces-324791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE329750E3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E281C22C04
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB52C187FFF;
	Wed, 11 Sep 2024 11:33:39 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03118785F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054419; cv=none; b=nYfWRNhI9XDe6z4XiVCxAMitY6/CzzVb0rFRThzP/rnFFWg3e64UsDHS0D0CZU0PGPmw8TlugmCPK7JOG2PD4F5bc95ANOLEZkr0wVi2cEq8hXJCSwdL4ggYvJHMhMJN/ViTyp2owSAyX2S+pZBCN78PvsNj79oYHi0oANgXccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054419; c=relaxed/simple;
	bh=IzlrtpBuUEkl2AS/wbJLfkdZ5Y9XzjMa60wQk2jqqfM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LSDXywGyHKbjL+c+7ZxWGj9HcNrWqwTWQ7GoR6xMoAkfJADFDf/1N44OqWZBgykI9FnvVK9tcwWRXHmVVQATsWnJmwlQtle7JVeb0+UbnI4okhUDpTUpFhyowvz+qg5S+PThsL0Oq1Am++X4J/gRp0ZU93XfMP6LdhckeixVuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04c88a379so129222315ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 04:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726054417; x=1726659217;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzlrtpBuUEkl2AS/wbJLfkdZ5Y9XzjMa60wQk2jqqfM=;
        b=D6V1qb4wrcJBB3BrecjHsgvwPU1EYM9kOxydon4bL7UXOaJByR5xr2diNBSF+hpPe4
         7qJz7dHNpM1YpsB0PScUh7H3p8yqtUURqfm3AEKfaTyfNrgdPH9/vGqWImH4bgHow2Hm
         g6hQtvjlMYy46yXHHj6ChgLLGapl7Q5nY8dSFU6IxCVrYCIxEyoIMXmmgd3TF/RfswRl
         YirNDe2JHhU8ikIDeuH26ANE4Uojns9PzIvB/gDxGcKNTBZR/gwx4YoVu6MwcNKUQcXQ
         ns1dMBUBQtA1kcvaPN82RILTy0ZjkSWwT2wtNeROZCOTzEm8RRrF4ogXG3Zwp8GETUMX
         tPHA==
X-Gm-Message-State: AOJu0Yy5mM4UdzRYi3+4TmVl0X/C0OkEFUldBcn/35uP4VJw+kef+xM4
	Lxrj5nRmBl6kP9K/WVvtEkOWd4fjZ7DzTFWMLJ89NuoHcgNd9mndPeGdX6j+yI1kACvtstW2rsD
	j01XHqQQB+O0XFX0RmVu6GXP66gcMJXzX9CiAf4ibfn4whCl9iFxJhG0=
X-Google-Smtp-Source: AGHT+IGxiL1BSomS97kb8maKDRimV+P10VgKz1+cR0uw/i5hJsOKuh9cHVaH6oPWAiEAAkxp0e20IZ9Mu5j82dkbx2QP1Zl3GULe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170b:b0:3a0:452d:aaf7 with SMTP id
 e9e14a558f8ab-3a04f07e184mr224680335ab.11.1726054417097; Wed, 11 Sep 2024
 04:33:37 -0700 (PDT)
Date: Wed, 11 Sep 2024 04:33:37 -0700
In-Reply-To: <0000000000000311430620013217@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006507230621d65c51@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
Author: alibuda@linux.alibaba.com


#syz test


