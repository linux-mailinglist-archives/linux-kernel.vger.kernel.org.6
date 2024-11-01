Return-Path: <linux-kernel+bounces-393039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D597D9B9B3F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653AD1F21E27
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094E01D1F44;
	Fri,  1 Nov 2024 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGbpU3vw"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1621D555;
	Fri,  1 Nov 2024 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730504667; cv=none; b=gRtynGhtAA3i1cQ5EyiC/8+H4WfZhXqnoGjTFbIo9hh14XMUIWQwk8VJ/c9QDW0vQ9E89UWJlVA0jMnI4jq010UhlRnwJt90HbKSon77d77QR5g0w3v7UdSOGBGhyMg8udGhQka+3Q2HShAxU3v6kepH0M9Nu+vmGT5hCLcUNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730504667; c=relaxed/simple;
	bh=OfwXV0EML2Qo2agYug7N9wb4ZOvCenatc09gbx15RZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRvSdIEJqXptD+EfcnMAczq+H5kC7v628SXp70BFrs6Kf4WJM6b4/+aK+O/iCXUvq9VxrgbfKXrvU5enT5YH1+G6MA+WGbzaI6oIvzLXbNjGtVYEvNKpL6ycet98CF4tiSRxpa+xj03bF+Ync9XBn7mOVDZ+VomNNdNkVQUWs0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGbpU3vw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cbcd71012so29018175ad.3;
        Fri, 01 Nov 2024 16:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730504665; x=1731109465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SJ7eFnOIVvV61qcZaSJGkSfja+YHjEcx+Yj4vOLi4f0=;
        b=jGbpU3vw7du8r+a8T67UuuNFeTN4Ed1BZJLQudxIek79tlGx9K6AFTCuorq2IlfClB
         LPgvTWbD3yWZq7kR28+ML0DunvQrEamfEzEdhi9wpAzGPokYlWrVVD37bmr8x6kAh1Vo
         e8kxw1V23ZjtGIZt3aqX2GOWOt2D9NHfpwQd5GwN607Ku3YvlrC45WnDOqtkrJkqCUaf
         KYpBV22WP2qOfNxWhhth7YhlZVc8djUHR7MdKxgMWP8ORDUiDI7Gl3tIyFeEr2MB8I4Y
         4ac+2CajTyxKJgRYTc738J20wBgFWY0RImoQP6kHPmpftF14VtePnLzLbj4G0m8N/IZF
         PT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730504665; x=1731109465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJ7eFnOIVvV61qcZaSJGkSfja+YHjEcx+Yj4vOLi4f0=;
        b=FjCKNMmVKsFB5mBLIrRKanZ8JU2QZqXn9J8cHH20D5zlEILmkpNfW6+HPyuSTtOJ68
         GWwUNZn9j74G9hoKFa8YGBaXTwoxN2PRLqAMO3R57B379e1mc6hi3BBwy4NMU9vC3Ha7
         unT+Od3GBj2wQsdA0TYwUNmZtaqek0E6w/qmfPVmpu0i65biqk8QPKvTbLlGv1b/x7m7
         DGnozcDifXYDI9wSIducrT3FaV0wVjV0DFuhxG4u/f3179e9e7bvNyYM3qQBREgXiPNr
         cFOk+bnq58SGYbtlMW7eDBdzKF14DD+5C+RiLQqi2puCG9IsB6+7n5E8sAm86K3Pyzw/
         TP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6Z8dja64+0lyRhfc1rluA5qaxcaIlNmOSFfzAavHSBfP9c04Mi80mWBvdtoihbLIUGkXsk5V/clxAUGk=@vger.kernel.org, AJvYcCUfbYyvoN7R8eYQGy/PfPQKinZtpqtSqWzFfYCbBb/tXk4bUM2RRFae7hDuoktSvA4r9yUTfC1A0vDf@vger.kernel.org
X-Gm-Message-State: AOJu0YxdnRsNXOp44JOllj94IWTHyyHn7oFg+J2/rvS/ANMrJCm4/uAy
	MnP4eYFNBPv6mw+LLWzWjuxrkyD482S2ID5oSpEKTpYPAlNVEpEv
X-Google-Smtp-Source: AGHT+IHkGxFVU6H5gzWGCbeHC3vGSXCyIDfN2sFiShQruX6RRFKJwRUSKIwcZekXg1W+Z9/ruD9AQA==
X-Received: by 2002:a17:902:e552:b0:20c:5c37:e2c6 with SMTP id d9443c01a7336-2111aec87d9mr54393815ad.11.1730504665273;
        Fri, 01 Nov 2024 16:44:25 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2aa1sm26507185ad.164.2024.11.01.16.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 16:44:24 -0700 (PDT)
Date: Fri, 1 Nov 2024 16:44:22 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [usb?] KASAN: invalid-free in dev_free
Message-ID: <ZyVn1tNVntbykOuG@gmail.com>
References: <0000000000003c68f3061fd2c285@google.com>
 <000000000000e82e420622326e3f@google.com>
 <CA+fCnZd2b70N6nXTyWO2UYivh_U7Wey==XWURpFy7B_x8xEFHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZd2b70N6nXTyWO2UYivh_U7Wey==XWURpFy7B_x8xEFHQ@mail.gmail.com>

On Sat, Nov 02, 2024 at 12:26:30AM +0100, Andrey Konovalov wrote:
> On Mon, Sep 16, 2024 at 3:24 AM syzbot
> <syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    68d4209158f4 sub: cdns3: Use predefined PCI vendor ID cons..
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10a96200580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cb61872d4d8c5df9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1297cc07980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1217c8a9980000
> 
> Hi Chang,
> 
> I saw your patch testing request for this bug [1] (thank you for
> looking into it!), but your patch doesn't appear correct to me, even
> though it did satisfy syzbot. One issue that I see with the patch is
> calling spin_unlock_irqrestore(&dev->lock) after
> kref_put(&dev->count): kref_put() might free the device struct and
> spin_unlock_irqrestore() will then do a UAF.
> 
> I'm not sure what the correct patch would be though, as I don't
> understand what the issue is. It seems that dev_free() indeed gets
> called twice, but since it's guarded by kref_put(), this shouldn't
> happen AFAIU. Or at least we should get a bad refcount report.
> 
> Thanks!
> 
> [1] https://lore.kernel.org/all/6721d497.050a0220.35b515.0001.GAE@google.com/T/#mca35ec73d63ff30d7219b6739ed0801688f15f35
Hi Andrey,

Thank you for the acknowledgement! I realized that patch was incorrect
too which is why I haven't sent it out yet. I'll continue to look into
it. I'll keep you posted if I find a solution.

Thanks!

