Return-Path: <linux-kernel+bounces-335007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398AE97DF97
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 02:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578A11C20A0B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 00:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22F418A6A5;
	Sun, 22 Sep 2024 00:26:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0781718953D
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726964788; cv=none; b=P9s6bu0Xm3zZbQGbtaTYnZgQ0CqZOgCZkAwBucwnXJU3QMvlhOmUtMi9itWK4kcYGsWC6MpXVpdl9IgpPMiADmY8OOJOnSSC5Qe0+w0XEI8/+GZm/Qvbmkd6364ElWmsllZL3UitWR+/VwWyaDGAzjg9sduglb0HeuQrTZUXqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726964788; c=relaxed/simple;
	bh=3nxE61SAHWMmac3HzOp0hoeE/+FIcFf4/3Gr+ukaby0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IZ1q6SnOKkVGDCRT3JXxUfMrYe6TB2t+sFhHITBC7N7NqWKUBImYYl+49r+03/97v4S9g0A2K+jhHD0J5Xa94dbL+P8WK7hIC9UbGVNE8ONGszP7+TPkNuC6ZarJAkkkGFOCYz88u0euEb+yk2HEnk7gavZS4IdGmHwI5De8dQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cd83f0b2eso382175039f.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 17:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726964786; x=1727569586;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nxE61SAHWMmac3HzOp0hoeE/+FIcFf4/3Gr+ukaby0=;
        b=wkIKAxElAYEhSmQd32d5qDRyZw5mEUd5akrS82SMpTZ3aCk3LQ8ciq61JCMhxOsrRz
         zV6mO2ukq8UgYLXCHpBs+lCSECYbCsvixHauVcWB2lknMG7r+uZR9qJ1bVx5SrXtFvW6
         Za5qayzlAJUFHVabChjKDQpGat993jv7HxF7vIH8vzWZ+fIU3i+sOP/dDAXKuBFOGmzP
         ROvYJ0ts0VJdPTbzWoXk3LDXjmXaY1cHcu1VuDd7nqHG2LJeOmdn1u+svtgA4yPb7Upf
         4bRmGgugbe03vdyZmnLbjdzCvzE29t4I3t1G9WTJUErVZyOn2ibfO4rMV4Macrh2DX3j
         jMpw==
X-Gm-Message-State: AOJu0YwteyDJ0nnIJw/o3NOTgeqelCtsErow5FM/j82PewLwiRvsTEpy
	K3WE0B9DIAJkvG3szHkEpER4KGOuC2GVrhqI+s4DKXMtjLmwY0GAU8lWDdBG5oHhHvjPay3uYvq
	NjiI1jVDXGfbbm4E1IMVyKYwO1RUJAe1Ue7v1Ysa2b+lyNYSHyO6qgd0=
X-Google-Smtp-Source: AGHT+IGWZsghtNSiI9VBWSyosblzenIHfDR9kgcJMOiiOEuPXg09jieVyLz1+Kmco0P9CY4EYYV/NfiV5Vv3P5jrdtk5kznA55ik
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170c:b0:3a0:9e83:21e5 with SMTP id
 e9e14a558f8ab-3a0c8d2299dmr79127465ab.20.1726964784822; Sat, 21 Sep 2024
 17:26:24 -0700 (PDT)
Date: Sat, 21 Sep 2024 17:26:24 -0700
In-Reply-To: <000000000000b5ca0f06223dc3b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ef6430.050a0220.3195df.0073.GAE@google.com>
Subject: Re: [syzbot] general protection fault in prt_str
From: syzbot <syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: general protection fault in prt_str
Author: pvmohammedanees2003@gmail.com

#syz test

