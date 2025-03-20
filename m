Return-Path: <linux-kernel+bounces-569868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237ACA6A87C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD33C7A7992
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5481DF25C;
	Thu, 20 Mar 2025 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mnIx2gUj"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB9223321
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480935; cv=none; b=lLOHyTwtPOM/2yC5x4VxIQYGRoF6kbxzfpf3+zuiqmAoHK2TRWFxq7sk4bRD1j9q2XvHIAZ+cJY9xZ9FXrYmEtXn3orDyQhKb/IN3b0qv3BdjNA6OhUKaKDsBJIW5K+hD74CxgaMoFfyCrXJL0WbMJcEQ1JqYJJ8RV97TVJktFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480935; c=relaxed/simple;
	bh=e7SbSL6gVZh5tUbpFhDN0kH6G1Bj0Xle6+XlO+bCBwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giLmmvBoqZTUzoXaj5EwXHgTlpF04gaJXBHr2dzx7kFBp3d321/8/Qy1ODBYb/vQ5GkogOPbJKjhV2wmRbUDSZpkAktAEgnc/tbM4LXqmy2Dl/P/yPRxZzY4kUvq1be8GMJ3ndsESW4eHX6teb9J3hiHgB93bxw7blsMvXjyD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=mnIx2gUj; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e6c082eac0so7149686d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742480932; x=1743085732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCmrNL8RiiTrlyx/pTgIz0D5BwVSzJyDRl0mOvvunyI=;
        b=mnIx2gUj9al960GDc89fGmlWc8SzwESQFwQpCVhwMKt/uaa+RT/hmmxPsIS40Nnvau
         PxYZt21K6lR7y8+1+F2pDgyCkcjmO/5Wg58YG0e9Xz//VTk5vvdpVo5gZoKL7orf8D/3
         xwP0us+qpk1i/UzCH7F0h+9te789cXikPwvoWK+OU5KGbiizNMr+cvYjNQMJ+1jDY6Kx
         YfY9hrnsQ8GIP3lVwfGsabucQeRNI/68W1AZ93Fr6Im7trukTp2W3VhXeE6JQylYxuga
         jmq7lxLrfauKTjzUxF9FNhP7QGdXdLOrzex++AcNqf4I9DcBLQhiPTXP5sKLJysCjgLN
         84gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480932; x=1743085732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCmrNL8RiiTrlyx/pTgIz0D5BwVSzJyDRl0mOvvunyI=;
        b=aGTWtAD6VM2UsSM5xwMzJDvBBM3wYYqqXImFFJWvSo57t+EChU5SXlktTmCDJmKNvd
         f61NLMguAFhzwvJz3AMHx7KJ2ULkaichcUdW86j/6e8O8u1ilERsMnDdyIWNcGA1cypY
         48BTUWLc978uTPXgAxJFlNpXu3nojNqMhx9TsPij2Wb18OoyM7mAUb3H2zqXcA12sEGF
         ip3xm3Q/LvoNnnJDV18iCqYD7DZczPTE+SVyY1mfVAy2JYRdFWav0bqYOQreWVLAAaSF
         FSUAmazfjZEDoDkFV/KkWM9+DnCGJny8sFxTWbCa8mSaEIqcAt4jHl84hRUkPJzjLF2S
         NmWw==
X-Forwarded-Encrypted: i=1; AJvYcCUolf1Fo0s/ns2YLRToQFCcGe9nZf0IUMiJsUbHMRAEHLuji0fgTgoJKu0lGxKAu3VTZcEohk5WMsY8Vfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4QR2gAbx+WeVPHuO2A91j2L9vsgHMdt3bKSEijPkTuO0KMrDC
	oaiDy7x+rFn0ztynYcHIOgLcUY4THRT2eDsG/QLhWzp67qB8qHuhchoz65VRrng=
X-Gm-Gg: ASbGncv1wHWE8Upi+uuNbcpAiLSZt3WSNd1ayfevmhRpplKe68Q3fEn2aaIdxb+wfNA
	R9ydeA6MetGry86/sIMmaHMDWCUeRtUNV9/OQqprp1mitIdr5uuwOXM40fkDYQLwy/m2L4X/hfn
	QH7f8NJtY5BByXYBzngLiEdtEenR8Q3oZ30nfH/nhVCqqPQMIWx6mDNAa5ZnldgOU0a5UD1eYhI
	XogO9thXF2LeSTYt6tUQKs2th83rRRCnn32Jg3kXQdd/Q2jp5Ros0Zj6ROMKhfaN292Ey+aatdv
	YADY32xRZBezldPNPfw4iJCenEiT/4n0Reg6V8mQq58=
X-Google-Smtp-Source: AGHT+IE7+PCwTGsOGLwiN064VEeFPiMK7pULniFiVFZQCjwVIsX+SEk801jpxuToEYuiEcsMECmVLA==
X-Received: by 2002:a05:6214:2501:b0:6e8:9e9c:d20f with SMTP id 6a1803df08f44-6eb352b42b9mr46981316d6.21.1742480931559;
        Thu, 20 Mar 2025 07:28:51 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade34beb0sm95297196d6.105.2025.03.20.07.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:28:50 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:28:46 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Jingxiang Zeng <linuszeng@tencent.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhocko@kernel.org,
	muchun.song@linux.dev, kasong@tencent.com
Subject: Re: [RFC 2/5] memcontrol: add boot option to enable memsw account on
 dfl
Message-ID: <20250320142846.GG1876369@cmpxchg.org>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-3-jingxiangzeng.cas@gmail.com>
 <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
 <7ia4tt7ovekj.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ia4tt7ovekj.fsf@castle.c.googlers.com>

On Wed, Mar 19, 2025 at 10:30:20PM +0000, Roman Gushchin wrote:
> Shakeel Butt <shakeel.butt@linux.dev> writes:
> 
> > On Wed, Mar 19, 2025 at 02:41:45PM +0800, Jingxiang Zeng wrote:
> >> From: Zeng Jingxiang <linuszeng@tencent.com>
> >> 
> >> Added cgroup.memsw_account_on_dfl startup parameter, which
> >> is off by default. When enabled in cgroupv2 mode, the memory
> >> accounting mode of swap will be reverted to cgroupv1 mode.
> >> 
> >> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> >> ---
> >>  include/linux/memcontrol.h |  4 +++-
> >>  mm/memcontrol.c            | 11 +++++++++++
> >>  2 files changed, 14 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> >> index dcb087ee6e8d..96f2fad1c351 100644
> >> --- a/include/linux/memcontrol.h
> >> +++ b/include/linux/memcontrol.h
> >> @@ -62,10 +62,12 @@ struct mem_cgroup_reclaim_cookie {
> >>  
> >>  #ifdef CONFIG_MEMCG
> >>  
> >> +DECLARE_STATIC_KEY_FALSE(memsw_account_on_dfl);
> >>  /* Whether enable memory+swap account in cgroupv2 */
> >>  static inline bool do_memsw_account_on_dfl(void)
> >>  {
> >> -	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL);
> >> +	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL)
> >> +				|| static_branch_unlikely(&memsw_account_on_dfl);
> >
> > Why || in above condition? Shouldn't it be && ?
> >
> >>  }
> >>  
> >>  #define MEM_CGROUP_ID_SHIFT	16
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index 768d6b15dbfa..c1171fb2bfd6 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -5478,3 +5478,14 @@ static int __init mem_cgroup_swap_init(void)
> >>  subsys_initcall(mem_cgroup_swap_init);
> >>  
> >>  #endif /* CONFIG_SWAP */
> >> +
> >> +DEFINE_STATIC_KEY_FALSE(memsw_account_on_dfl);
> >> +static int __init memsw_account_on_dfl_setup(char *s)
> >> +{
> >> +	if (!strcmp(s, "1"))
> >> +		static_branch_enable(&memsw_account_on_dfl);
> >> +	else if (!strcmp(s, "0"))
> >> +		static_branch_disable(&memsw_account_on_dfl);
> >> +	return 1;
> >> +}
> >> +__setup("cgroup.memsw_account_on_dfl=", memsw_account_on_dfl_setup);
> >
> > Please keep the above in memcontrol-v1.c
> 
> Hm, I'm not sure about this. This feature might be actually useful with
> cgroup v2, as some companies are dependent on the old cgroup v1
> semantics here but otherwise would prefer to move to v2.
> In other words, I see it as a cgroup v2 feature, not as a cgroup v1.
> So there is no reason to move it into the cgroup v1 code.

Agreed. Let's think of this proposal as making memsw tracking and
control a full-fledged v2 feature.

> I think it deserves a separate config option (if we're really concerned
> about the memory overhead in struct mem_cgroup) or IMO better a
> boot/mount time option.

Yeah, a config option forces distros to enable it :/

I'm hesitant to agree with making it optional in any manner. If you
consider the functionality that is implemented, the overhead should be
fairly minimal. It isn't right now, because page_counter contains a
ton of stuff that isn't applicable to this new user. That overhead is
still paid for unnecessarily by users who _do_ need to enable it.

It seems like a good opportunity to refactor struct page_counter.


