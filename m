Return-Path: <linux-kernel+bounces-421350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A5B9D89EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6178628498A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B75E1B4130;
	Mon, 25 Nov 2024 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SPJOUe4V"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2731B0F0F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550792; cv=none; b=rMK8mqtZ1emCAv+XdJXIjkoT61aCFJ4hq+zAwVkDD0qDEu01laxnfVoHPhTn5MqVBmnRccsVDTcO4adZGCtWxPGSORDx1JSCTAQ0/IIXpyrYendK4iL+bdaDyj/rhCFqNw7m1PTesTWCDmV5kl5XRk3pdd/sGaI276XD3PadUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550792; c=relaxed/simple;
	bh=P26TPqHyeSgVY+tJhSdEaAP5WEgQMA0brEC4dEZEvFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEWWA0dg9/wVl2MV7ZADrwwiRcQcUApmVMLzxwpTDYN4d1FB0CM0KT6LI1/NqunLvqGK7aCgX5vi16A8MSCPxmkkl4mqddx8YZaU5FzKC74uiN+0jiQn8Jxv8TWQ/JgSRTxK7EdSFX3r1J6ux9RW4mlOPH9OH4oGwpj5nK8BEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SPJOUe4V; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b673cb2708so7243685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1732550789; x=1733155589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9a9VnHGIm3FCJ1sQpVPUgDLqqd8uoWG359o3vCNQ3GQ=;
        b=SPJOUe4VMrwZ2xroHJva3Ik46hP77Pwanx2oVhm7u6b9nrc7CLN7rh+2rM8gm/qtBY
         h80FWrYrPBXwfuiAWeia856l5YwDzeZH/HsVWUkIu0ubL80TFTxDfuyCk1kvxnf6krJP
         TzJQHn6oNRTFtrGKITYCIy7aRjy9TmiEGnfJ1fYDRuWl7kW6lOSTW5nCZE9YoJzURmYE
         Y4pooOKpb2JCAXqYGmwbbs/eHMLAs8GkA2DHTd1h/C6K1l+NAvfz+/QpqCMXl62UhojU
         v5b7Q4KWBDAO7RdzGNdpZskvxJ8M0R6UvpFIev8i/gVJ+WxqI2VnnABzAUncnxCcsw7/
         UlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732550789; x=1733155589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a9VnHGIm3FCJ1sQpVPUgDLqqd8uoWG359o3vCNQ3GQ=;
        b=V+Qdbse+eHuIwmFti4GcP8jLYe72vBo8+MRUBtIkjTUrflkN9GdbFuCM05SLIeALTN
         0+0cepHOuOdXaGu5TsmTF6jIj40nB1abcEpQ+43GYSnTi8wloYdFkR5lCD8/W1TX+KMV
         NbuZ2TN4D/dvNMmsBKbuRaAeZI5+tV4u/AGc0ShrMvIK2toFVbiO0t+KERDfoqs0T8mX
         VeNJkP24p89n43NT4N/LIJcQTY7zzYIHUQKNNwkdp/cw+toSkH2f+poqC3jz5cnp/eVF
         yT4dqgsob6J1a8V9J/umYpG2wpiDAxax4ZMa2Csszbp/TPrJn5DKHXFm/qnANhg04U81
         6LUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUl7f7QSsLb+xYRwmkRCoYIQfToP98A99rTOuFh+QPCo++KH5oMz/kSN+yaiDWo1wbZYryrqmuouXS4I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGv3VohqdMUZtNbVuHWRhB/wiVoxTu7N2JkoZqbUgTnD//eWjo
	GT6hFEuF1wdDaMFtpg7VKVTc1njTb0aG0PVikx9bxnj/qQUquc/rAkiK3Xd2VDI=
X-Gm-Gg: ASbGncscauJsWDI3VO1VGixS2YCQhr/7iETJlbyfe+SpYELawD0KLy5H6U/08jTKb1n
	45gpmUmP03hvU71NU18BGAB8R53TGlvPiVQ8gy/QQ0lqEKv2+laPK2wzHvHlZX2s6M0NdyuZGmd
	mhWTsEAVEhfWWRlPGsRnluRMW6aj0TxM58+8AvNMetcwkKRW9BZ+8bfyFsyA8DM+hYzxldKmN+Q
	4T0uydeNlMBDCNeXEbD7p1rdruEHO4/q4bhXN0JzWMIiK26Wo/h2MYUdoN50D2NplaFxONvwMyN
	Xi04E8fLP9HKhVGXzl/nTmdtWTYFCDegPQY=
X-Google-Smtp-Source: AGHT+IE55aCWNNffPxQR1LsNEJ7M4lMOwJhPMcg1RI0t056r0i9TCZeKRVeIgZ80psxU71anDh3zyg==
X-Received: by 2002:a05:620a:880c:b0:7b6:6e7c:8efa with SMTP id af79cd13be357-7b66e7c926amr409889385a.53.1732550789224;
        Mon, 25 Nov 2024 08:06:29 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b23ed7sm43858756d6.75.2024.11.25.08.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 08:06:28 -0800 (PST)
Date: Mon, 25 Nov 2024 11:06:14 -0500
From: Gregory Price <gourry@gourry.net>
To: Michal Hocko <mhocko@suse.com>
Cc: Junjie Fu <fujunjie1@qq.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	dave.hansen@intel.com
Subject: Re: [PATCH] mm/mempolicy: Fix decision-making issues for memory
 migration during NUMA balancing
Message-ID: <Z0SgdhMOnpup1MdY@PC2K9PVX.TheFacebook.com>
References: <tencent_57D6CF437AF88E48DD5C5BD872753C43280A@qq.com>
 <Z0RgoOHMRFCTM1JB@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0RgoOHMRFCTM1JB@tiehlicka>

On Mon, Nov 25, 2024 at 12:33:52PM +0100, Michal Hocko wrote:
> On Sun 24-11-24 03:09:35, Junjie Fu wrote:
> > When handling a page fault caused by NUMA balancing (do_numa_page), it is
> > necessary to decide whether to migrate the current page to another node or
> > keep it on its current node. For pages with the MPOL_PREFERRED memory
> > policy, it is sufficient to check whether the first node set in the
> > nodemask is the same as the node where the page is currently located. If
> > this is the case, the page should remain in its current state. Otherwise,
> > migration to another node should be attempted.
> > 
> > Because the definition of MPOL_PREFERRED is as follows: "This mode sets the
> > preferred node for allocation. The kernel will try to allocate pages from
> > this node first and fall back to nearby nodes if the preferred node is low
> > on free memory. If the nodemask specifies more than one node ID, the first
> > node in the mask will be selected as the preferred node."
> > 
> > Thus, if the node where the current page resides is not the first node in
> > the nodemask, it is not the PREFERRED node, and memory migration can be
> > attempted.
> > 
> > However, in the original code, the check only verifies whether the current
> > node exists in the nodemask (which may or may not be the first node in the
> > mask). This could lead to a scenario where, if the current node is not the
> > first node in the nodemask, the code incorrectly decides not to attempt
> > migration to other nodes.
> > 
> > This behavior is clearly incorrect. If the target node for migration and
> > the page's current NUMA node are both within the nodemask but neither is
> > the first node, they should be treated with the same priority, and
> > migration attempts should proceed.
> 
> The code is clearly confusing but is there any actual problem to be
> solved? IIRC although we do keep nodemask for MPOL_PREFERRED
> policy we do not allow to set more than a single node to be set there.
> Have a look at mpol_new_preferred
>

concur here - the proposed patch doesn't actually change any behavior
(or it shouldn, at least).

Is there a migration error being observed that this patch fixes, or is
this just an `observational fix`?

~Gregory

