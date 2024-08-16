Return-Path: <linux-kernel+bounces-289827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565D954C09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BE61C24446
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5A1BDA8C;
	Fri, 16 Aug 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Rc6C39sg"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4D01BD510
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817441; cv=none; b=QXxXwjGm2DEV0FwiCrSFn8uPKDl14LBqv0w7GIIBBigSIcE6V+6TK+sUkY8RqOH8HiZUEwlFNGumLEMvesxuiaMNAa3A2Mk04pumGmnBLX7pCMmSEaSP+PRVjD60kq5urwnNNVuFcROpUAdKQiTIsf4wWFpqjBpz8VYfwJRncN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817441; c=relaxed/simple;
	bh=psHb8N1x1GwxaHQF/qlrntKeqTMz1XDKVEqPx/u5D6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFb9kjlbtrYDzHkGKXCwoHqVdalnqKUQ8TOjxba9TIMHsiqgndvICez/FRnLHMf14zKVjd5ZGndgoyRrWo8D4L4TlzvkYWWhhvwagnFyfodG0DwSd+Fxs61u0m2UQ7SCizTfpuupGA5h4vEybtoSrfGORPocZbd2UxUespKW450=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Rc6C39sg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-429e29933aaso14215385e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723817436; x=1724422236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=miVZh/GI0HcREl2DDRTzth/cgjKJT8U5WJExR3abJFo=;
        b=Rc6C39sgG5iSqguNXRekYjur4CVWGL4T1KhhiEEgnhgCdEZhqFfQa922ebJ0sAfpPf
         QXtZQKGpGjwHm9sGwKtyvSJrQuckqAkZfhveco7XVaMEywsSnI6hRBDDPwx4f2CKJ8A1
         pic69sO3hWTcCOuk0fdojdPiDVKfTIhbUibW/rKArSJj66Da0r/Jf4BUocilbWbYHMjD
         bjMLyxn9jfc3LXKHtjTM5ue1aqRLjlQSCvUdFnO0Q99joPk5xdgZj5k/uLJXDxr8meBm
         hGfimfo64Rl9NsaDnh07mMSbUC2aS/xD+5M7dRvzzSRDjVgLyiLaXWxH8H5YqwzllWMq
         meBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723817436; x=1724422236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miVZh/GI0HcREl2DDRTzth/cgjKJT8U5WJExR3abJFo=;
        b=LnTiE6ZUI2IOL8aRtg3IQ5zBZ9owZjfQQKqZLD3d2Cly1kfVyDFEb5byeaMoHz6zz/
         Am9uBuTEclneKGxs8K2WEwEQ+F0SUs/8h61dbViPAxCz8Mce5UXqIq8n9lgsB0Nan0q/
         ACCYuGy9nQU7m+wV7FDKlvY2MdsROi8v8elz0L/Ha5tkwc5Ei5g8QGOdProHtC9W2ly2
         2VnQhkJlxmEJohkAhnAQ33W0PqFI0sJE0poPwC/KyHRtzdyziQQqaKrFSbGtKFwQQXgn
         UiLcLFsIwt9yNEk145m/qbkQtXRlQpLv3XLXcFDLYjOGgaW7xa3Pv2Io5+x6ppnzf07B
         4mfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC0TiUI2bsCQZ+3OVdCfHXQpQUwtPokHaPdR8jTs6iTyyy044AGA2uQfuTguDD24+yP/6XGKcxUl5yv48vOCOdDqujiB4DTied96EU
X-Gm-Message-State: AOJu0YxZKvRDmk8LrHOML9zhVZrfp3/m8dyYXB0PiL+7j8eJmkvvCqKA
	Ov4LrziWsv5X+1dtwtZBo4HwnAk05wvg/QbgBHADGIfIFZw1txdx5K3YOq9/V2o=
X-Google-Smtp-Source: AGHT+IGpkEEitEY+0w44espFmpSjByAEeYYXzVs7YJxJR1SO2wEpGer/EiQIMgOKiPhMsOmUx6eLxQ==
X-Received: by 2002:adf:ea8c:0:b0:371:828a:741d with SMTP id ffacd0b85a97d-37194455f9emr1709397f8f.21.1723817435849;
        Fri, 16 Aug 2024 07:10:35 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a6ddsm3712243f8f.58.2024.08.16.07.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:10:35 -0700 (PDT)
Date: Fri, 16 Aug 2024 16:10:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v10 01/11] octeontx2-pf:
 Refactoring RVU driver
Message-ID: <Zr9d18M31WsT1mgf@nanopsycho.orion>
References: <20240805131815.7588-1-gakula@marvell.com>
 <20240805131815.7588-2-gakula@marvell.com>
 <ZrTnK78ITIGU-7qj@nanopsycho.orion>
 <CH0PR18MB4339720BC03E2E4E6FAC0251CD812@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR18MB4339720BC03E2E4E6FAC0251CD812@CH0PR18MB4339.namprd18.prod.outlook.com>

Fri, Aug 16, 2024 at 03:36:41PM CEST, gakula@marvell.com wrote:
>
>
>>-----Original Message-----
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Thursday, August 8, 2024 9:12 PM
>>To: Geethasowjanya Akula <gakula@marvell.com>
>>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>>Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>>Subject: [EXTERNAL] Re: [net-next PATCH v10 01/11] octeontx2-pf: Refactoring
>>RVU driver
>>
>>Mon, Aug 05, 2024 at 03:18:05PM CEST, gakula@marvell.com wrote:
>>>Refactoring and export list of shared functions such that they can be
>>>used by both RVU NIC and representor driver.
>>>
>>>Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>>>Reviewed-by: Simon Horman <horms@kernel.org>
>>>---
>>> .../ethernet/marvell/octeontx2/af/common.h    |   2 +
>>> .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +
>>> .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
>>> .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
>>> .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
>>> .../marvell/octeontx2/af/rvu_debugfs.c        |  27 --
>>> .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  47 ++--
>>> .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
>>> .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
>>> .../marvell/octeontx2/af/rvu_struct.h         |  26 ++
>>> .../marvell/octeontx2/af/rvu_switch.c         |   2 +-
>>> .../marvell/octeontx2/nic/otx2_common.c       |   6 +-
>>> .../marvell/octeontx2/nic/otx2_common.h       |  43 ++--
>>> .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 240 +++++++++++-------
>>> .../marvell/octeontx2/nic/otx2_txrx.c         |  17 +-
>>> .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
>>> .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   7 +-
>>> 17 files changed, 266 insertions(+), 178 deletions(-)
>>
>>How can anyone review this?
>>
>>If you need to refactor the code in preparation for a feature, you can do in in a
>>separate patchset sent before the feature appears. This patch should be split
>>into X patches. One logical change per patch.
>If these changes are moved into a separate patchset.  How can someone understand and review 
>them without knowing where they get reused.

Describe it then. No problem.


