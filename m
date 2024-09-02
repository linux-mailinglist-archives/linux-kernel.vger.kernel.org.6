Return-Path: <linux-kernel+bounces-310908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC189682B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FD61C22380
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6945C187840;
	Mon,  2 Sep 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SZMzq1Ma"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0495187568
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268147; cv=none; b=fAOOmLXJh8/TmVu9FA6ID7Qs/zGmwyGb/L5tyg/eOSMnBIdcK723jS/4mA5JdJOGAxO5E0Ro6qvznJeSpp97Jx4LKe0Pv2Y7mQpFmFqjqfgSKoL2SO5Dfv3jIpeoQ0nxa0jkAlbQuax/VPQCcdovbM398FCw7Bk3+l2mnuhT98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268147; c=relaxed/simple;
	bh=pKJ69WgBoUOku0xgyepPvpHKeJ+qYkm2Mu/uS+vlzsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYSJCCCkq33rxOGWZVl3fmM5ml7XCyiPZwcYBZHMjauZXkSLw842HGdyS1DMpV/gYStcKHWfpjKbCueDNyBBoctaKyr2kiJ9OV+0p1Hzku+wVTFiL47a+DF7K4jGTDTEwqbyikQAtS8gSSDYTQ2xzru5bCkQXYX9ZQgSeDj9Evc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SZMzq1Ma; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53345dcd377so5432830e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725268144; x=1725872944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc+tIxGI3WkXrC4GyS0UazwJpXd6EeGAj+AW+8MBy5w=;
        b=SZMzq1Maq5rch+kT1AkfH9/43lrTYsSgLojebAUsI1qKoVG/VyQWRwCX+rS8hzSqOj
         eroSfimKCjnRqO5dv0I5DW/y5ggeB3U9Hu6geX2UILI1Mfn//p/kYmFo8vDKR7UuFeOf
         BT4guze6Zbq5hxd4NENyGGK/fh8YKAqO1Zs3rffkD7i3lujC8p2FiieT82Kxpy5h7+e7
         eoBtOKIxjkXYzyma3SNiDuzVkkwYErj/vbMtT2bIEAs1zbESPu4iLYnpBspQBeW/vmY4
         wVqr9e81XAvJCNUn9bnVLanj4Lslndn7Ci85A6CHA7DtBbfcEyz9YgvStRwrcedAT1MM
         jJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268144; x=1725872944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc+tIxGI3WkXrC4GyS0UazwJpXd6EeGAj+AW+8MBy5w=;
        b=OzwVwNPDo2xoTvhRZNDHRlH8s0jl4DMFBk67gUR77a7G43PTWxz6iO2+efn/lrDiKX
         RLYv320g2YFuesWofiedgXIqeAQYhLMx/vjt7NA3hsE4gB263WAynzAePhYZIgZ7pbvg
         DnQtN/lYQxDP2/UPxgv2OrYwWs5qRct1rbO0OPMvoxsCGf6XhyYJtVWiCQBjLNxqFDQa
         gwVKOYxMsVf0xEacJgl5DwGMLz6ckHa1NtJgcDi5s76FtZZejEgvpReoqeQq9YLpXbBt
         jaT79lsLLHlugvjs56Y6VmXd3bREb/SsBwLzqEanyX09Axx9K13wAF8A445gSDUhTipp
         ABQg==
X-Forwarded-Encrypted: i=1; AJvYcCUkwRcHXWWRIYAtebfsndAiUym477AOzq+5OewUwapqlO/ZUpz+V5MFxlsqulgmFqYW4ub9N1BgbTr5EZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LFcIqLNJpB+6Th35R8QprCJOhkc18jPzINluUbwj9GkMXYnI
	YQ7mQPPMsA8o7iutUUrrQHIarT0gK2RQeF/FvP3wPrwkl8PPYg40uOVtFS+dpT/QGSec3LvomYg
	w
X-Google-Smtp-Source: AGHT+IGE/GtNjsdfXTxeqr6p9FrfimaHQ9FGSfSyoXGsx0BhwbDRvvlZ17A524C8LUpRaD0LGFd9aA==
X-Received: by 2002:a05:6512:3da9:b0:530:ae4a:58d0 with SMTP id 2adb3069b0e04-53546af3605mr6730057e87.8.1725268143851;
        Mon, 02 Sep 2024 02:09:03 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6fa9sm528702166b.162.2024.09.02.02.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:09:03 -0700 (PDT)
Date: Mon, 2 Sep 2024 11:09:02 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <ZtWArlHgX8JnZjFm@tiehlicka>
References: <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area>
 <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <ZtPhAdqZgq6s4zmk@dread.disaster.area>
 <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>
 <ZtVzP2wfQoJrBXjF@tiehlicka>
 <CALOAHbAbzJL31jeGfXnbXmbXMpPv-Ak3o3t0tusjs-N-NHisiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAbzJL31jeGfXnbXmbXMpPv-Ak3o3t0tusjs-N-NHisiQ@mail.gmail.com>

On Mon 02-09-24 17:01:12, Yafang Shao wrote:
> > I really do not see why GFP_NOFAIL should be any special in this
> > specific case.
> 
> I believe there's no way to stop it from looping, even if you
> implement a sophisticated user space OOM killer. ;)

User space OOM killer should be helping to replenish a free memory and
we have some heuristics to help NOFAIL users out with some portion of
memory reserves already IIRC. So we do already give them some special
treatment in the page allocator path. Not so much in the reclaim path.
-- 
Michal Hocko
SUSE Labs

