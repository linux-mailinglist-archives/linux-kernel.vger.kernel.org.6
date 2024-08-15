Return-Path: <linux-kernel+bounces-287708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B69952BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8702833A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017EF1DC482;
	Thu, 15 Aug 2024 08:58:18 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5A17623F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712297; cv=none; b=W2Wp+r9nuUBTP74nWuncgnxCC/Ht1FILuVnPetZNi6s02OveGrDb8zgH6+OBo4Lb1owHDKYi+whl7NKpjad0YZ3zNl39gqFvJ5twYdTPj3v++gfMOsQusfxUM4a880htUqLoGC0fHFg86xPo6LcUaj8Kh62G5sKB3vDXSnsjBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712297; c=relaxed/simple;
	bh=evFwm/CVXlrZL+OYNwhKqiKeB+wDiuWlLPBx8/hwoE4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F24cJRCrkqg2dwVW+UOMg27Wk3c+MTB6vyqAxi59yDDPaL4k9dkuWAzcIPleXaCRwo34+utaGD6dPy+CQXNCdSOlPfHLYz4e+ff9H9Dt10tND3jVHAWrJ/+7UWCFSBLVc0JJ5d5Q4pk56CfmuZbfie0XEuliAXDHuDZpqUxgybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3994393abd5so7447855ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723712295; x=1724317095;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evFwm/CVXlrZL+OYNwhKqiKeB+wDiuWlLPBx8/hwoE4=;
        b=AcSH+Koz/h1PDes7zc6oV2BcstAvHiymJDkYxe5AIZ8ZobB6SdhckKGl42cBpGlR9L
         bdezDgnhKdNalwHvBZMmW0zmsKTsDXasoTYRQkSe2ivZckZGfYaamwiPojvHNRALTbS/
         GtU7dXX4T0v4YA7VeChZ0cJKJUjZgTpGSs3e2H3RjL+4EZzZWtturFXQvopa3GfFsAwo
         QQ8SJYKZeLSEX2hd+WPpOEJZ84slUBNiPfeQzm9RHecFJWp+oRR1/kz2ovuviEltDUuF
         pCgQ1z01DIY3sweR8Qye3ByN1X6ty+X1fhUQ5tz5bV7GI/lUXDcKrYGTIA+cI58moyW/
         PtNw==
X-Gm-Message-State: AOJu0Yy3fWa7OYZZ343fyjkAnzoMo6Hii3Yne1YpiUq3yEz4FwwFWkAw
	8Z9Txs6EmhbDUEQLWNTtEI5WUE3cXiMRlNgactaqSKZrTAmkld3gma9oqsWITgqcl0CWpST69Ra
	xjCJ/n+XLMSR49SHkpe/9MKj8Qw3I6K1QIW5evQ9v5NZW/iRP9pl4k5w=
X-Google-Smtp-Source: AGHT+IERcahk9dFGNE+U6GmUpa4WbBOl2O5IydTQGOXP+cQ1zyJ41eEtWf+HM1c9kqUxprxkFLcXyMza9ZpJJNahqW63ypBO9yfC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138c:b0:396:dc3a:72f2 with SMTP id
 e9e14a558f8ab-39d124d5c0bmr4372355ab.3.1723712295387; Thu, 15 Aug 2024
 01:58:15 -0700 (PDT)
Date: Thu, 15 Aug 2024 01:58:15 -0700
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000fd2d4061fb50bd4@google.com>
Subject: Re: [syzbot] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: slab-use-after-free Read in chrdev_open
Author: almaz.alexandrovich@paragon-software.com

#syz test

