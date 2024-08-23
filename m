Return-Path: <linux-kernel+bounces-299284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA395D253
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BD12830FC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C591898E6;
	Fri, 23 Aug 2024 16:03:35 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C50184550
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429014; cv=none; b=uofNSeLgjKEeTBh17eHvS+hQpDGgaWxghZU32mk0GzRHCMfLqs5tYNqm8hSv5sxAEES3l3rAqm+ZNotzFYgKmBgMFV/BZrSowigM0ijYs4fsreJmDcux3BllMvn+uawJTBN65MWFA+jYtZmrQ+zlXIRmvfcb+GTsmspMmgiiQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429014; c=relaxed/simple;
	bh=O8h/oDQ9OhVrNtG8+8Hq2SPgYnNHP2/INVqE1bKs624=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ZXlipVF/lnYq+6OIEzJb4axur6tRqgmj/TZdEsPy7sTthYcDYsOreNzC+TUh59MDqmAbDHPvkFL61237D3qHXl/Np+H1RnHEE5rsf4jR9QIjtjvE2cpy6U1FR0QXWM/fqGtQgqLBd4UxEA2joYJuXtfJcBkTFCFiEKJFt9lmOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d2ced7e8eso19935055ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429012; x=1725033812;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8h/oDQ9OhVrNtG8+8Hq2SPgYnNHP2/INVqE1bKs624=;
        b=FeMDzutm5wKEdKfrC7O78W7o+h+17qr2f27sJ58fNvUKFTHbWyQJGIOjVlivGNP1ih
         rAYNXqHd4kQGNO6USdAVEH+aeiZ/LaVn8U/yTH+xUkJh9ohmBUKquTGOkqXcHc45Mp4d
         PmVPdg2LZsKpQRWFSjUHoKpLd+DqPVGnUqsHXLSagxLCsVja16phBQWqerNBSdhI8+UP
         od7Ge4Fmlt0IhJyDBKmDYLreXzmOhyTIcelUUlF6EcgK5Wm1UoVlKHbBLL+Lvy3sbFvI
         17jfr9UOz7rcGjs6ijN41HwdKvdixyELBhMf/CUkEWhGfWCpY841T6OIqMEOWY6Mhr7i
         8dLw==
X-Forwarded-Encrypted: i=1; AJvYcCVKOS3shjMo6lV/AoAI3j9T24I+ABVj75S2Goyj93dXv/EMKA+45RYPaKYb2KQ8LMwCL0BFQ8Pd1MJnnQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG391/HLXFVzQCVJ2n7L44XslBZB4N7ZIXd21feJgo27gQNN+s
	dYGxhKsvJI7ZBaIHHJbEAS/pYmUT19sRIZZcbzfCSYfPKEPE1UPiQi2oSUu8i1Qs2Og+BODKM6U
	ML/jx2vPOKMBqizgpDqBZCIyi3NxlZX5J/vsPuVHlLIkYK5UIEL36Bwg=
X-Google-Smtp-Source: AGHT+IGqMlpcJ8qnY5g97+g8OlMMKjwRSt8aWEZUVLv0aafV7XuVaQqcUfI1QUE10rtsJdXnIKZ9Pz/5shwda6MK8Z/xwQ0fpg16
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d19:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-39e3c8d2ad1mr1803895ab.0.1724429012407; Fri, 23 Aug 2024
 09:03:32 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:03:32 -0700
In-Reply-To: <0131cdd475994b9c8f73a2cc202ba0b1@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9a47d06205bea40@google.com>
Subject: Re: possible deadlock in attr_data_get_block
From: syzbot <syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

This bug is already marked as fixed. No point in testing.

>

