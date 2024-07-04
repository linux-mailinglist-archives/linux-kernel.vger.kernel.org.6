Return-Path: <linux-kernel+bounces-240891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB47927440
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF821F226BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FFF1A38DD;
	Thu,  4 Jul 2024 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISJC6noj"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C551A0AEA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089819; cv=none; b=cUgu/SOnJrXYjkN8MgLzjb1sBQAnaTE3qw4UcComKIBvZ24yuIE8c0SSSSvDJy+8hmXLqv2tpF7MdKdiU4kA5iczhP4XsYbhXdGFWbOc5f0AKHKf0RPoRgd4zELPOc3JF50ixb20e+m4e4kw/eoVah35qZ2Iyk4CyQy4Okb6A1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089819; c=relaxed/simple;
	bh=kLrhaR+1UBp8gvQNoBqnTS0wMECkG7vE5QiNlpFWVGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMmuAlROZHzA0SyNMyHqsEcCS/66apP9SF8i9LUlUO9duFsQA9WfmAny/x+S4LIbtHKGtp5yBeEd1WydjzZ+rCTM0ZZTEcoY0aqB2vcn08X7QYDL//M4GWDhcKCuvzB7uX6Teqqh65aZPIB4P9OGNexld7zp2NwH014wuLJHs9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISJC6noj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70af8062039so371233b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 03:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720089817; x=1720694617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV1NRVd6+8QOeMy6RKDnNQikMEGyoeyplnHtMAi0lv8=;
        b=ISJC6nojBHXmeWYr+B9p6LEkNU5Rff7ELOiQf/HmuTO0RZWsn+ymiQ/7G2r21i7uMD
         jdxhxgY38LJCL2rJxM7BcAGXo9egSgOtvwNg43AXxsCLA+8q2FVLBrZIxV7XqWJZ7TyC
         OzyR0uFqF8/XpAfGSbYYqVCXqth2sPilT8WD1tLSQdj1uLanTs/GJg1HYkpJttCqcDfw
         vFQcYaMqQKvgl3UdvMyJ0UBoFKAGvaSqcMlHVuT8drx0iZe8q642oDiVSn+ER+6oiIfY
         fTk+Qpc1jn8F5y5mVkj/P/K66c2pff5k/csRMIrGOmxvSl8aaSEJ7CNdamf30RyNbHxB
         E02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720089817; x=1720694617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BV1NRVd6+8QOeMy6RKDnNQikMEGyoeyplnHtMAi0lv8=;
        b=IU2UtHoAg8lmk/pQPksB2lqzNBLQgn3lXSWMJ7e7ezylKDFdcSTycCHbZfIRnlpDgO
         nqz38XR6xMET/aQsY1i27DH7euExzd5Q2c4ic5gqKNreZZiho/IiVRQ/iF7Re5BN7/jv
         NdLkCycmhbgbNBwub1JhLisnGxbPLW6IAWYkrxlnrNRbn7eFVMFjGH2cNUOQpjdPVj6l
         z/R+77V8ZZJkc2ah06Ym772NGu1wwzRNxCD38t3TDD7C34DLovm7IaEdVjvKSsg4WcIp
         CmUb4lOtbwbOfPymIBPKc3J5RBqC/bUAQ0zb7aidD5wXXGImVYpuCT8jT5/x1GmFIgkI
         NvKg==
X-Gm-Message-State: AOJu0YydOkK4IMPAJ2Ofb+5ilIYOPEsMMOQFhzi+j5ILtI1dEChSe37Q
	QcizmpcxcKHsknBO48d4r0ne3QxCECEkYPkWFH622FLh51gw5f3k
X-Google-Smtp-Source: AGHT+IFwgszc+40tcdaP7jNGjzWN5U4vwFahbUKcjOP4NQirYKGBnXEukHVzk9WI/5Iy0igAeFveBQ==
X-Received: by 2002:a05:6a20:a125:b0:1bd:212d:ac63 with SMTP id adf61e73a8af0-1c0cc73ead8mr1412518637.22.1720089816667;
        Thu, 04 Jul 2024 03:43:36 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15698d6sm118819395ad.192.2024.07.04.03.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:43:36 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net] team: Fix ABBA deadlock caused by race in team_del_slave
Date: Thu,  4 Jul 2024 19:43:31 +0900
Message-Id: <20240704104331.90527-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000ffc5d80616fea23d@google.com>
References: <000000000000ffc5d80616fea23d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>
> On Wed, Jul 03, 2024 at 11:51:59PM +0900, Jeongjun Park wrote:
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&rdev->wiphy.mtx);
> >                                lock(team->team_lock_key#4);
> >                                lock(&rdev->wiphy.mtx);
> >   lock(team->team_lock_key#4);
> >
> > Deadlock occurs due to the above scenario. Therefore,
> > modify the code as shown in the patch below to prevent deadlock.
> >
> > Regards,
> > Jeongjun Park.
>
> The commit message should contain the patch description only (without
> salutations, etc.).
>
> >
> > Reported-and-tested-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
> > Fixes: 61dc3461b954 ("team: convert overall spinlock to mutex")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  drivers/net/team/team_core.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> > index ab1935a4aa2c..3ac82df876b0 100644
> > --- a/drivers/net/team/team_core.c
> > +++ b/drivers/net/team/team_core.c
> > @@ -1970,11 +1970,12 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
> >                           struct netlink_ext_ack *extack)
> >  {
> >         struct team *team = netdev_priv(dev);
> > -       int err;
> > +       int err, locked;
> > 
> > -       mutex_lock(&team->lock);
> > +       locked = mutex_trylock(&team->lock);
> >         err = team_port_add(team, port_dev, extack);
> > -       mutex_unlock(&team->lock);
> > +       if (locked)
> > +               mutex_unlock(&team->lock);
>
> This is not correct usage of 'mutex_trylock()' API. In such a case you
> could as well remove the lock completely from that part of code.
> If "mutex_trylock()" returns false it means the mutex cannot be taken
> (because it was already taken by other thread), so you should not modify
> the resources that were expected to be protected by the mutex.
> In other words, there is a risk of modifying resources using
> "team_port_add()" by several threads at a time.
>
> > 
> >         if (!err)
> >                 netdev_change_features(dev);
> > @@ -1985,11 +1986,12 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
> >  static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
> >  {
> >         struct team *team = netdev_priv(dev);
> > -       int err;
> > +       int err, locked;
> > 
> > -       mutex_lock(&team->lock);
> > +       locked = mutex_trylock(&team->lock);
> >         err = team_port_del(team, port_dev);
> > -       mutex_unlock(&team->lock);
> > +       if (locked)
> > +               mutex_unlock(&team->lock);
>
> The same story as in case of "team_add_slave()".
>
> > 
> >         if (err)
> >                 return err;
> > --
> >
>
> The patch does not seem to be a correct solution to remove a deadlock.
> Most probably a synchronization design needs an inspection.
> If you really want to use "mutex_trylock()" API, please consider several
> attempts of taking the mutex, but never modify the protected resources when
> the mutex is not taken successfully.
>

Thanks for your comment. I rewrote the patch based on those comments. 
This time, we modified it to return an error so that resources are not 
modified when a race situation occurs. We would appreciate your 
feedback on what this patch would be like.

> Thanks,
> Michal
>
>

Regards,
Jeongjun Park

---
 drivers/net/team/team_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..43d7c73b25aa 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1972,7 +1972,8 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
        struct team *team = netdev_priv(dev);
        int err;
 
-       mutex_lock(&team->lock);
+       if (!mutex_trylock(&team->lock))
+               return -EBUSY;
        err = team_port_add(team, port_dev, extack);
        mutex_unlock(&team->lock);
 
@@ -1987,7 +1988,8 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
        struct team *team = netdev_priv(dev);
        int err;
 
-       mutex_lock(&team->lock);
+       if (!mutex_trylock(&team->lock))
+               return -EBUSY;
        err = team_port_del(team, port_dev);
        mutex_unlock(&team->lock);
 
--

