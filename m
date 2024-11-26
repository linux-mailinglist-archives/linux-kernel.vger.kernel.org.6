Return-Path: <linux-kernel+bounces-421789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD469D9028
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4652898C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B0413FFC;
	Tue, 26 Nov 2024 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqU1a3Xb"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E3D26D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585888; cv=none; b=lwM3CgEwiT/b8gHP85lBimOTXg06USmROy3fvq8zzqWl0MPjD4q/NiZNqx1cwdnroIDaiVpb7zLOxOMl7qAeS5ynFPCZiRqsGjkdl/JvjLDPqjvRkMUn2azbfP6b09/+Dvn8ah2A+E8J/4ePvCt3g6/Zr/HXdpGioB7Vaj1JFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585888; c=relaxed/simple;
	bh=H0mFerbMaGcm5YSo+5mHe3ECjJkRkraKwOcgif5R6ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfV0VYyaD+t4Uqiq+zfYH/ECkt0pMU1JpEDy0Wb3MAiU2T2V3VNcwPrJw5h4NjSKI7JffRrt0nRGKLc9knsYGKbfwaJCbdm5hDIvc5IzFX9M1t33eNLUHQ/PkCe+tsTbl30VIi1F4KNdui6i99lMN4aVB0JVhSdPrYo7E78sG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqU1a3Xb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso4025616a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732585886; x=1733190686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJoYAYmeRsJLY19PSmXmZzQLTbquFpEYT2ck8bCoKAI=;
        b=PqU1a3XbCqjDSYisdnmuZyaIv3+5Cm7HNYtDBappyUWInOHCiabYAok7MSmUCvRezL
         +ozomiVBnWY4liwcb3eTXABilckrMbvc4JSaC9QgN4UfqbZM/UeZ3XHTsqo2gf/gzLW/
         3BcjNlPT1wAfbtTM100BQrKqBzXe1fhT5+ueVT2+xGXaSul7se5zx01mJwizMRFgeL0V
         WEHHUReb4yA+99bGIsMuajpnFy+OCxCCA6ywInHMiDEAl2vakNeH4kKYX2Fuamgn485Y
         zwNzl1F/XQjUfGwc/mTb6o76+8VZuzWg3q7omrsJlcVASfhQ1O0dbsrCaDra4v5UBuyO
         yQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732585886; x=1733190686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJoYAYmeRsJLY19PSmXmZzQLTbquFpEYT2ck8bCoKAI=;
        b=K1YFP8Z+6eeJDAxR3Lj7szJZShTJEaSG3un+JtHo+iizYjw409K7uytqKwFbbku89x
         2NOgKfF51frp7NVKm3iOBbO2jFpdjpvRlXqJ6LLkdJChtkvjSDKpbhS6K5UnAFGUvF1P
         WG9zWe7hbJR5LxyD5hnnuHpImLK7lwoUm2yKsvICbVDuCGnWO6tmJv2mBml/gWQznMlp
         PdvUmary/yu85mLn9XSvXfK0MksWxVW83WsRdBK5pxaitHwjYYg9jT2Cuvw2P52SVmQd
         Js3fwvx8CXoYfeDJX9JdHlbZ+DC+Rwq9KnzyKXO2u4Ln7+Gy+9Sv0W3yYQXUhVKIi/EJ
         3LHw==
X-Forwarded-Encrypted: i=1; AJvYcCXXx76QHHwq/4eJs+wdbMuPTwXUKDNq3gx1d1yFnCqLVg1Jj7wkX+kbeVb5f55eCfUN16iWRfbFBLQ369Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwdKTZiFLdszpmTnc4G4iLir0Swpuwzi45q0s6yP36U4gv/hec
	zlJV+S+SVlxAzqFWbSqTvjjYoHgN2SChboZptiKi6pX4KI8Phw3LXjqMXi+U55hRaayBJXC7R2k
	oOyBPIgA5pF3+x22cydAfESt3j6s=
X-Gm-Gg: ASbGncu+u1eYOMMnt9uVEZIs2K6ozeIvh5zcrWsCSNqbFyYl61jINnUpeBx07E3CXkj
	AGaPo6jcE2ZcsLTakMJh6UklZb6OQ0A==
X-Google-Smtp-Source: AGHT+IECCVnij2z/+srsyPC3YUKSlek8iSKr3GS456+2J0fRCkz1dFnAzFpIUD+FnI6gkzr8aPDBr+QNAg5FE/vVq9A=
X-Received: by 2002:a17:90b:3805:b0:2ea:aa30:5edf with SMTP id
 98e67ed59e1d1-2eb0e024afemr18190299a91.5.1732585885720; Mon, 25 Nov 2024
 17:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
In-Reply-To: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 26 Nov 2024 01:51:14 +0000
Message-ID: <CAJwJo6ZvS3B3b927zO1PpKX7p+7N75gE-44g2mVKkLXiaDBfPQ@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v6.13
To: pr-tracker-bot@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 01:45, Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> > The pull request you sent on Fri, 22 Nov 2024 09:17:47 +0100:
> >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.13
> >
> > has been merged into torvalds/linux.git:
> > https://git.kernel.org/torvalds/c/ceba6f6f33f29ab838b23a567621b847e527d085
>
> It seems to have a minor merge resolution artefact: iommu_present() now
> has a header declaration with no definition.

[Apparently, when you choose gmail option in chromium from the mail-to link,
 it erases In-Reply-To header, sorry about it, I'll avoid using it]

Thanks,
             Dmitry

