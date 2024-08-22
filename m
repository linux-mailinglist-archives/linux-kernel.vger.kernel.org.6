Return-Path: <linux-kernel+bounces-297449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B4095B87A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E94B2ABB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1061CBE86;
	Thu, 22 Aug 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VT3u47Yj"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F442A9E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337025; cv=none; b=WeD6kJuNt3ISIqgBS67OUwccSjj8xvAmHJliRpFqkvXOsDUnarSG5M80Lw3BTkmnRck8FxRWAZG46jbpiRB8c8yr62iSZK6t8tP7QypFRzck845GdeDVFDOLmZm/ANPlKlxPWxdCB/NBLSXcewbqW0sPjGXoTe9vYlZguB/44I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337025; c=relaxed/simple;
	bh=jn506kOABGogquftoPFGSqZkTv7WWTTZWicv78hgAO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxstDH2l/9MxVk1cofy8rAiGP/5UhuS0TiHPzgEE1Bg67BJOABovPRN+9IL8ASZ4uiFzCxfMafIJlqldikms1eSL4tlJs34WKd9Ud4vduBB5iY89wWDcsgrK5gA/N06pX2/IKib3TRtudSMeywLl/ybdlTtaXoIMG8dNUA7GLPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VT3u47Yj; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-533462b9428so1493968e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724337022; x=1724941822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0AOgkHsmxrrYPyGQ/4+OtViWpYvO8BCZysRgvY+GiaY=;
        b=VT3u47YjR9IGyU/jMgtDEW/hHHCJ/rTIAc07//ewslcvK5Sg+rcgMcNnN4sPJNHpYn
         DcoqBv1/Tp5RTNFS52dE+Z7upK8swQGFlYY+8k8vTzYQofibOh3BcfYPkmmWGJImJLtm
         WHfc920OclE491CdLCKBTDS7MpdpF5QKGYfhnk1ZYhc5zrQEBiGjfe2SsXbq4DaC5UBX
         VlIwPWL6MP5zc/q4oCJQDXfyYf9JTCWYD32qYPQZYvRZFKPTCgduHVIedoUV5/x3rhnb
         69KkTdirdiZ7sI49DiEE6vvVAbG1WI+V1GuKhJ2zA+BDankuTBY4GVNthdmDt8r4iBnb
         jntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337022; x=1724941822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AOgkHsmxrrYPyGQ/4+OtViWpYvO8BCZysRgvY+GiaY=;
        b=sEZRaZlFS2bwMY66IdhGzEQ+7DCLDZY256WUI8yxNW/kHoZyQP6skdbjtae2pNxLoZ
         8beKQOoQQijqNcz4+dxz83SZw7S/V6n44RRMBG5h6hszH4qRVvMg5kuBYBciH5y5X9jh
         VqloeqAWp5ciT7PoYnon6w6pL3Ds+24+wTObgC0l2U44IXJOLfOCVN+7KvZy99NIyUy3
         PpmpNdzcOqf8qaS8o8YoZCBYP8fyPNskSC6zcHou8rH69K8vIRJ/I47VuKCovP8yBFEi
         UfNeD7IDzEC/pvLG9NiBPEB/iRNtniZEKPjw/H3nLdspdsDZv1PZX50yVS0JZ3RFiray
         pP5A==
X-Forwarded-Encrypted: i=1; AJvYcCXB/kQheqF5OntGNd3SzVC1fvdEchzHFAZVCjWq21c6wl20iKj056dJ8n0qkQ4ySLdeLvXPjjJy0sKsjaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNGBKjRiBS0/RuMI9dyMP7lk4k7GbgzmIWJJhda5wSZFNBsjB
	f/DSkS5Pcn6AKPD9DbtASMR787Z0l6JH7pPP+n4xS4j6LTcP/VcBfp4FBhHwUio=
X-Google-Smtp-Source: AGHT+IGSZcPc7HtL1sG19hUCiCBTwxU/ErZjo9Q2ro/3Je5UYCF2HgNJnsmS00Hm02ZgfSnuVdIs3g==
X-Received: by 2002:a05:6512:3c89:b0:52e:d0f8:2d43 with SMTP id 2adb3069b0e04-5334fbe593emr1904871e87.17.1724337021802;
        Thu, 22 Aug 2024 07:30:21 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484b29sm126444466b.162.2024.08.22.07.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:30:21 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:30:19 +0200
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
Message-ID: <ZsdLe-FY3bzzgU9v@nanopsycho.orion>
References: <20240805131815.7588-1-gakula@marvell.com>
 <20240805131815.7588-2-gakula@marvell.com>
 <ZrTnK78ITIGU-7qj@nanopsycho.orion>
 <CH0PR18MB4339720BC03E2E4E6FAC0251CD812@CH0PR18MB4339.namprd18.prod.outlook.com>
 <Zr9d18M31WsT1mgf@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr9d18M31WsT1mgf@nanopsycho.orion>

Fri, Aug 16, 2024 at 04:10:31PM CEST, jiri@resnulli.us wrote:
>Fri, Aug 16, 2024 at 03:36:41PM CEST, gakula@marvell.com wrote:
>>
>>
>>>-----Original Message-----
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Thursday, August 8, 2024 9:12 PM
>>>To: Geethasowjanya Akula <gakula@marvell.com>
>>>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>>>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>>>Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
>>><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>>>Subject: [EXTERNAL] Re: [net-next PATCH v10 01/11] octeontx2-pf: Refactoring
>>>RVU driver
>>>
>>>Mon, Aug 05, 2024 at 03:18:05PM CEST, gakula@marvell.com wrote:
>>>>Refactoring and export list of shared functions such that they can be
>>>>used by both RVU NIC and representor driver.
>>>>
>>>>Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>>>>Reviewed-by: Simon Horman <horms@kernel.org>
>>>>---
>>>> .../ethernet/marvell/octeontx2/af/common.h    |   2 +
>>>> .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +
>>>> .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
>>>> .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
>>>> .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
>>>> .../marvell/octeontx2/af/rvu_debugfs.c        |  27 --
>>>> .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  47 ++--
>>>> .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
>>>> .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
>>>> .../marvell/octeontx2/af/rvu_struct.h         |  26 ++
>>>> .../marvell/octeontx2/af/rvu_switch.c         |   2 +-
>>>> .../marvell/octeontx2/nic/otx2_common.c       |   6 +-
>>>> .../marvell/octeontx2/nic/otx2_common.h       |  43 ++--
>>>> .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 240 +++++++++++-------
>>>> .../marvell/octeontx2/nic/otx2_txrx.c         |  17 +-
>>>> .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
>>>> .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   7 +-
>>>> 17 files changed, 266 insertions(+), 178 deletions(-)
>>>
>>>How can anyone review this?
>>>
>>>If you need to refactor the code in preparation for a feature, you can do in in a
>>>separate patchset sent before the feature appears. This patch should be split
>>>into X patches. One logical change per patch.
>>If these changes are moved into a separate patchset.  How can someone understand and review 
>>them without knowing where they get reused.
>
>Describe it then. No problem.

I think you misunderstood.

You should describe the motivation for the refactor. Do the refactor in
a separate patchset, one logical change per patch. In the cover letter
tell what you do and why. Tell it is a preparation for follow-up
patchset that does X. Simple as that.

>

