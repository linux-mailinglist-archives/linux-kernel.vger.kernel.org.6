Return-Path: <linux-kernel+bounces-248688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120F492E0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA16B220EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756B13D248;
	Thu, 11 Jul 2024 07:17:13 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431173BBED
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682232; cv=none; b=uVDSeTEgjztBcBsPnIWN0gC5gwaNj7DigMBqJOB5c3z0WAhyH7gwryD6+2ARARZ6f1shGiikjrRO4RprXYtMy348DorPguE/0YYzrx+OCEJZdn/cLYv/zG+mLkASQHbEwTRPxdOIij0AX74sBvTpDCqI7tq0thSp3Ncl5Pxl4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682232; c=relaxed/simple;
	bh=IeY3IOwRxLbBIXMQAe8r1IHpVuaS4Pf0HRidIAJ7sQg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lgKV8YjK/7V9ZhiTeTM4TzCMHGFePl0+uhzfcbu38aHHACwmCUu26kARSuUF6mDq1bguNm+ZQfFDTVaFauI7dcOkY+lI1MZ61kGz8f0ASkpxX8c/ZAiADph1Gut0YabMCxAJi4De+2hoBAmKTueNRWFe2qA6Lt6H23li7kgOxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8050ce2fd57so61589839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720682230; x=1721287030;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeY3IOwRxLbBIXMQAe8r1IHpVuaS4Pf0HRidIAJ7sQg=;
        b=vOt6Gn9MtL/WEEDUv/QeQ/7pe9mMyEGTY/Wr6LvMThdNR8QH/AcTetC8R8alxszk+e
         Ap5rPvCsuT/uJEQgH5+e0S5DxYWG74aWMbWyjN2dkBIqS/6yu7MIM0Bst1lyd09VDzs8
         2LGXHgsyoCoM5RQJ9/1qUOacxtpgF7RDxtQVXFqmbTiflzbh2jpsBsGsJHltkwz5L3ol
         Ceee4FMJ4gvNsv6Qat5i+Jc1OUtKhQh22VL1JBSfMb6MFQuuHpOBGCyw6MoePyOb6HPe
         Q1ZOaI7q4C0Zu6FO9HdhRtvGHaTQ+MzOmeCx91k/UcuPGBV2n/um55mqJI/pZtccUkQe
         9odg==
X-Gm-Message-State: AOJu0YxwC1tux8SFLXAnyyyAaeF2mz3T8nMZXJX33NiAI03dRRr8neb9
	YRtH9LG3RW29n+RhOkPxMe8YL7gS9d8sdvLowWOUfVr47Ht8wg9BUsWQB4yl5EBTWR0Ka0+Ho85
	Ucm1RG6HYm9cnARZxzpCiFDiYU04I8PCNT6BYyNkRF+ArvSDrgOPmYs8=
X-Google-Smtp-Source: AGHT+IHdP8IYrB9AIY+8OiozfB02A65QcvFuFZ0fV9CnnRJ/USXltCkyhX2IIE7qF0Q4eI2o/7JZi5Jg8F8J+RmkQsnBQptlVUn2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6282:b0:806:bf73:1167 with SMTP id
 ca18e2360f4ac-806bf7312aemr7767039f.3.1720682230318; Thu, 11 Jul 2024
 00:17:10 -0700 (PDT)
Date: Thu, 11 Jul 2024 00:17:10 -0700
In-Reply-To: <00000000000012d4ed0610537e34@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c15ec061cf38db5@google.com>
Subject: Re: [syzbot] slab-out-of-bounds Read in mi_enum_attr
From: syzbot <syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: slab-out-of-bounds Read in mi_enum_attr
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master


