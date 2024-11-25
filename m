Return-Path: <linux-kernel+bounces-421589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA449D8D53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E0BB22D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D751B87EF;
	Mon, 25 Nov 2024 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CQPCbUQ7"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A582B9BF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565929; cv=none; b=FC2LCyaFuFkR5Kk2pce36nKoXzlZ7hS02uVgqqljSiMVrgThplBO9YTI5SpRZ9iH0UYYbZcq4CtMfCQC7tkVl8qS30970HvT4eVs5C7HrAzcjZLHjQWx2rzFO88MmfcZQuT1cpGH71bF8UkdzK6Xh+9v/MuCFyznVDn3oYyhn1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565929; c=relaxed/simple;
	bh=s9hlzYt/MHo0Ztopa5TYJ75AX/kH7xf/MnzszTBkOxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBkxU3fGiU9srM+mj72NoWtZ7o6Kb2WD1XVVL6RdgaXO36BUElvWP7LAGTh7SbCKaUTclP/bRoLGvyTh0tvBy7AShW/2AmjYIBfA5nxFcfiih4L+mXxZFuFZ01gSrBOfxbskwBUvt09RnpRBquWDIgh+Ybh0+FLkFKHsNE0mQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CQPCbUQ7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d036963a6eso3319405a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732565925; x=1733170725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4EY5DppAwA0h8a9qcqbq9Vb3NGzr0pQtsRmicZxTlg=;
        b=CQPCbUQ7eSu0czZurjTXrxcQYJJwBA8qskEHo6F1rOJtTNsjZEfVligtiyTwIMjC36
         5T+RznMcZZ99m+ld9v774bIdx3bKlmqNDWKbQT6HGk8tVb82vznO+H48Zdpa1HZlf1Do
         oJqGXWIBwrpSgjeV29fgjgkih//a6qOYhzRFcRzo5wUpnRSHtom2gZUnQVWbHQEBnhV4
         MquUAV7EtBHxUagaPIOyQZyB4ofdR8nH2csKip1kjq2VyiSN5zn+vA6CpQtQBtyOGXiZ
         13mv1kJ5nfZF8FcX1gwLHsloBtoHdj7z3vcAjaIonjkm5VuxkxS3h7ye+rVYLnH3xvRE
         G0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732565925; x=1733170725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4EY5DppAwA0h8a9qcqbq9Vb3NGzr0pQtsRmicZxTlg=;
        b=XVYe+nTP4Mj5n4vAz+juGpnPEOA9y12i07bFcWawx569fgCfOA31Eq6TBcSThUSnfl
         HbAezcO4aBZT3oq/IbFb/B2sFJDbscP7qcgIJg8vtXMoWaTJgAYUfDfcrhU/DyXVbavI
         J24FUWm0GCI8m2EsWjEpnaPMT9+sfsSF0CQAg+24dJqZwT+w82T9unSeUgFgBvg+KNIU
         wAYabV3v8QSLbht1jVDO91qCns2N10Ld79YsBq5E+UJ4LL16HT9D74mbSRMjeimSJE1A
         WMucjQfZuyGwmXgL0Ih+yh7sVW+ccad74gxRACEFfnKEWdrJ6Bp04Gv1ni+r38gJEZbF
         weTQ==
X-Gm-Message-State: AOJu0Yx4oGSBhmnqexcigNSU9BTO1VZsy2GAN21Xeq3pqFUJ9SlcRU/4
	AKHzlu3D6pr2TnippGYgrtv0kCsOWnTDnnZo4wbbCyYkewEV60a6M5Q7A7vI/VJ2BsBHvDStkRn
	2
X-Gm-Gg: ASbGncttH49Gx5XL4ClP78/aH7M9FrJGhOvNGjnE2DY3Px6uBZetI/QLuO1uFrYUdTX
	P/30WEZfzvdNeIpRGBUclQh/WLCbr4rvG3rj4DlwvsNxeFnaEHKpWsI+mxLuyVlWgESNxghnmWI
	EVBW0ZECw4hFVwh3aBbMc9dtn/VW9SzoY6qeCNLqqKK+2WPXi91LxTisnBI1IRIn9h/I8R4eJts
	IkVV16tITK7SkGgH9HceGmzgYmdNHHMwGT6CjZCOQf03zuDrwISm6ODhDo1gBs=
X-Google-Smtp-Source: AGHT+IEjmidA5pwfdhfSFgiKX1B0pCEagcknIY2hHbH/vUENtn6//aEuZmHFWCyvUlJlIOg4H24JoA==
X-Received: by 2002:a17:906:9c2:b0:aa5:1cdf:7c02 with SMTP id a640c23a62f3a-aa51cdf8321mr997893166b.3.1732565925297;
        Mon, 25 Nov 2024 12:18:45 -0800 (PST)
Received: from localhost (109-81-88-120.rct.o2.cz. [109.81.88.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa545385bbcsm259975366b.185.2024.11.25.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 12:18:44 -0800 (PST)
Date: Mon, 25 Nov 2024 21:18:44 +0100
From: Michal Hocko <mhocko@suse.com>
To: Junjie Fu <fujunjie1@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, dave.hansen@intel.com, gourry@gourry.net
Subject: Re: [PATCH] mm/mempolicy: Fix decision-making issues for memory
 migration during NUMA balancing
Message-ID: <Z0TbpP02utF1lBzJ@tiehlicka>
References: <tencent_57D6CF437AF88E48DD5C5BD872753C43280A@qq.com>
 <Z0RgoOHMRFCTM1JB@tiehlicka>
 <tencent_52B8009E65148BE7B93C42479E6E642C0409@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_52B8009E65148BE7B93C42479E6E642C0409@qq.com>

On Tue 26-11-24 03:45:01, Junjie Fu wrote:
[...]
> I apologize for the oversight when reviewing the code regarding the process
> of setting only the first node in the nodemask for the MPOL_PREFERRED memory
> policy. 

There is no need to apologize! Really, this code is far from
straightforward and it is not easy to get all the loose ends together.
What helps though, is to help reviewers with the problem statement. It
often helps to state whether the fix is based on code review or it is
fixing a real life or even artificial workload.
-- 
Michal Hocko
SUSE Labs

