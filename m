Return-Path: <linux-kernel+bounces-214728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE9E90893B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39575281855
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D624E19539F;
	Fri, 14 Jun 2024 10:03:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA521946A4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359384; cv=none; b=I5ynTVVDDcEeyrODoinQURYHTxk8fmz4XyUlM5juoJktjAqL4xxl3pto1+Qi8+IA2wcj+7NhyChxo1P7vPIDmSmDrTuJKhXZwFgdGGJaTLRz9xUAg/a5UE9wrIw6hjmeijePZVdgEwM7g3YKsGIu91Y+rET5IAJ9AlYJomj9UBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359384; c=relaxed/simple;
	bh=mAE1KXWMeF5E0ygvYIsll/84cv6zEcHwSDnICwAJGSs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gU8x2vP/n2MLUytVv1ivGGLnboP5Kc/b9IyyUq3GUJG4Fcue81BQG8e1zrlvzB1vccLeQBTiiaxJvh1OKtV3gh70cc2LUaHT6Aa9/bPNXODkPQ+2uh4Mg1UH3QUipMUxZfromQBjCL0g1EawgPmdkt3riYyG/FMr4pAjE7oDhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375d074398bso19191705ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718359382; x=1718964182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jde5MK0jeNOUc20kGI8HANdozM3inJTWkjenhEiT3+k=;
        b=ZE9FL4EmyU2P8+0OvEJXcbZtxZVZeZWWJJfiggFgjEJl29ma6BlJxsadK5JwmZK7Zi
         LEYns/jIsXchXjGmkxgX7CFiQeaNn03qCHr1nMxaCCrHKPJ+SaabNihJkpejDAj3obQT
         grJl1Nmfju102CIC3cTE6CDFvdH4HCBuKuyzCMIhZzFO0YUzCKWyhwr6WgHPn7FU7zG6
         apgK4SzQJ9WHT040AiiRcCDe6MiYZPr5UMd+ufQ7ziD+G8i7DPbs+tPjq0Zf66mFHD4Q
         dMGGR/SWhOxfmJpzct/hNAEkLyH54fn6vhFDtoC8m7LBKI64q+6amIONNz5wdmwOnlLb
         yPUg==
X-Forwarded-Encrypted: i=1; AJvYcCVU/I0U6CgtbsQgxlVoJDGlhQbDi7DWs3Zbk0ld+k9DDUGWGvwk9fGKzsFX8aCM7+jNKdtM89z6QLGHMp6wwSiw0jdXR7dD++OIWocd
X-Gm-Message-State: AOJu0YxedeKA3Oq/KIADYRbie23dK9mf73w0GMJA0tNdgmaldDEnNhE7
	tJ8H6JVVHiSpZn5+hn9cS5Vr9gV/CE5py5aX8KCljuqbaKMmc2Ohwf2NFmItRexMb2Sr/vs5CIH
	yVEr2QhD8k2vi2H50AzanP8RyvJKF8Oe5buHT8UplVuxTGfX1AOBlVus=
X-Google-Smtp-Source: AGHT+IFarjCZuN2u9mRextQbq5uR/kQaYkHfkbZjhlVbX5SwH+w4XzDvaFS19ZCcmljAghs1gZTYlNT90LjLebJNrYXhVs7FRrmz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:375:a202:2548 with SMTP id
 e9e14a558f8ab-375e0e1430dmr1120485ab.1.1718359382147; Fri, 14 Jun 2024
 03:03:02 -0700 (PDT)
Date: Fri, 14 Jun 2024 03:03:02 -0700
In-Reply-To: <3edac706-efb7-946a-ec72-02445ffb8ea4@netfilter.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091d4e5061ad6b88d@google.com>
Subject: Re: [syzbot] [netfilter?] net-next test error: WARNING: suspicious
 RCU usage in _destroy_all_sets
From: syzbot <syzbot+cfbe1da5fdfc39efc293@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://blackhole.kfki.hu/nf/main: failed to run ["git" "fetch" "--force" "e800a3db89c700d4929431441d645bfd641d2d3c" "main"]: exit status 128
fatal: unable to look up blackhole.kfki.hu (port 9418) (No address associated with hostname)



Tested on:

commit:         [unknown 
git tree:       git://blackhole.kfki.hu/nf main
kernel config:  https://syzkaller.appspot.com/x/.config?x=7266aeba025a54a4
dashboard link: https://syzkaller.appspot.com/bug?extid=cfbe1da5fdfc39efc293
compiler:       

Note: no patches were applied.

