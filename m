Return-Path: <linux-kernel+bounces-561076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6966A60D47
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B4C1651DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6F31EEA29;
	Fri, 14 Mar 2025 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CH1MAkRY"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A41C861D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944482; cv=none; b=pCURMME4uaZwpTcaIZLulGxXyhjA2PyDlM3NPwatpiEAyqC7CwX04Say1rXExASq8xvRIYWfTM/KDiW87CoBhhIcqUx6ai/dWsk+OJky7wnfpjwUvoLro/J4KT9RCRLkf9R/KCgaLrbBCGbhSSBHNCI5m8F9kUc5HjQ+uL1hBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944482; c=relaxed/simple;
	bh=+aTLYTgONcT4kv53BDyLj2LPzsie3l2WpHbTmLAjiX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfEu17d0tXLhBG4nrWWxsjn1kmqVppF1V9HbdMYi5tD31rUI60ciTeMY33P+w0Bo1juxalKyXlwh0rpvZrkjaVhHbu87BwuRVXn9Pe4Fmlb7MyH7DNQxyJXHmmIKyjwu5KmxzJH/jGHVtQKCkLEPb1qqYXdBJ8T3dFbiH01wZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CH1MAkRY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abbb12bea54so364484366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741944478; x=1742549278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7r0QX++u7FsRXvjWgiyZ7Brlo7OZ9nFdFPIIQMFJWBY=;
        b=CH1MAkRY+ev2LTVJoN7cI453ibg1zxvOFJl6xo7ijA+zv2uFyoJBg3gnLN2n6KrBRo
         hhCPdeQImpCL7Lmw+ZLQJCqRftX3WAo7JF8DijKfV+QFJxbgPmqjutT2HO4PWiV+EdDn
         bFReCPjxYKwTAii1d0OQdFcg3lRop75gkkbdXRuurdXSO6BmCCqyi4O0t9dr1Y6eJ6Yj
         YqoYjpqbc/FdypkMnCVbsIU7qUyw+gaLi7H8qdU0ASyvpwOwEJf/6OdmgXUbK4pX15Nh
         oMA7SITzpmlP4dZ6RhkfiNOBopICYq4tyt3YPpMY8a2RZBQCr4hQQ6qB+e2mp46J3gWs
         tqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944478; x=1742549278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r0QX++u7FsRXvjWgiyZ7Brlo7OZ9nFdFPIIQMFJWBY=;
        b=OrbTaP2DHukfz3lVLC2iOAhQYsU4zvCRRFsz33HNfgNhC2jYqeHDUVF7nDk9GM0+GN
         Om9k3i+HuYsLneMaeYoG8ljzoVdHPGpoxcBpQ8st3u0wUlWj3usGT780iFHFsJJjGwPZ
         eqnIarXnCCODKx61Qd+++HHTaynbY/32xtu4JqC9hrS6TZePcvhjrDc8Qs/hgs/G1ONd
         Ygx/+MbQVJ8gy56jVQgW/ngNhQqFdXcAcSNX9ZIam3sEPVImEHLtMLa/KvAz5YKB2g14
         g1z10yUylEtKQgAFOSjA5MZlxtHRlW7bbq1K8j41xRs/A9acWbUCFkRIspNie/9K7y9x
         z53g==
X-Forwarded-Encrypted: i=1; AJvYcCWn3wIiA1txHsi8jt4N0ZJAtxTpsWcoxXssFgSsd8M/RSDYruDQZKqtDcFpsVLwqtKONodB72WPLT3ymaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJC4yjxQmymfsQL6DFMS2Np/v1zVrK5HZUEsKokK/83kIAX7s+
	ULjP5Gfuy5UPSOPsxFon84+gtz1ePHwZP14mLnQmaF4y4TaWJgiaIM1/k2UhSdg=
X-Gm-Gg: ASbGncuYd/nhJ67UbftFgCfnm3hxy7b/SvGP71TJ0FWuPstm1BIT4Zte3a/E8wfSyuA
	dF/O/pJ072E+aONqK21PbahC5SVpNk4EtWAW4SaXkNIxuN2gpe5nlqxYpQogMQrWoPDkIweSzk4
	MJeBUoDlEUfjkcBrijtC4R4DeAlc0jnF4Nl6ljgeGr5Ql8/xgDoWXa5c2TdRfeI5tuPwXfjGP54
	60WD9UYUlxDhAuTsQlEfG549va8Hyuvpg0FzCTLDG9ArOC4HgelyOAWwUbOMdRNomxAMfc4q79f
	kCzs4az5LX9tntdYsPDM/KwcXpdQIPi29NE7/gI2xZP0w+8nMSyw2eyctA==
X-Google-Smtp-Source: AGHT+IEctQzZ0HoxHhORo57vJ0aGVrHIvZsJFWmzQWvSD+s8asx4gnK2dy6Kod28lb6eaB7ZdWhuIw==
X-Received: by 2002:a17:907:d92:b0:abe:fa18:1fc6 with SMTP id a640c23a62f3a-ac33010b594mr213491366b.10.1741944478527;
        Fri, 14 Mar 2025 02:27:58 -0700 (PDT)
Received: from localhost (109-81-85-167.rct.o2.cz. [109.81.85.167])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac314a4659csm199489766b.131.2025.03.14.02.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:27:58 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:27:57 +0100
From: Michal Hocko <mhocko@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev,
	yosry.ahmed@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: vmscan: skip the file folios in proactive reclaim
 if swappiness is MAX
Message-ID: <Z9P2nZ6b75FRMhCp@tiehlicka>
References: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
 <Z9PuXMlHycL6Gco0@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9PuXMlHycL6Gco0@tiehlicka>

On Fri 14-03-25 09:52:45, Michal Hocko wrote:
> On Fri 14-03-25 11:33:50, Zhongkun He wrote:
> > With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
> > memory.reclaim")', we can submit an additional swappiness=<val> argument
> > to memory.reclaim. It is very useful because we can dynamically adjust
> > the reclamation ratio based on the anonymous folios and file folios of
> > each cgroup. For example,when swappiness is set to 0, we only reclaim
> > from file folios.
> > 
> > However,we have also encountered a new issue: when swappiness is set to
> > the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> > to the knob of cache_trim_mode, which depends solely on the ratio of
> > inactive folios, regardless of whether there are a large number of cold
> > folios in anonymous folio list.
> > 
> > So, we hope to add a new control logic where proactive memory reclaim only
> > reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS.
> > For example, something like this:
> > 
> > echo "2M swappiness=200" > /sys/fs/cgroup/memory.reclaim
> > 
> > will perform reclaim on the rootcg with a swappiness setting of 200 (max
> > swappiness) regardless of the file folios. Users have a more comprehensive
> > view of the application's memory distribution because there are many
> > metrics available. For example, if we find that a certain cgroup has a
> > large number of inactive anon folios, we can reclaim only those and skip
> > file folios, because with the zram/zswap, the IO tradeoff that
> > cache_trim_mode is making doesn't hold - file refaults will cause IO,
> > whereas anon decompression will not.
> > 
> > With this patch, the swappiness argument of memory.reclaim has a more
> > precise semantics: 0 means reclaiming only from file pages, while 200
> > means reclaiming just from anonymous pages.
> 
> Haven't you said you will try a slightly different approach and always
> bypass LRU balancing heuristics for pro-active reclaim and swappiness
> provided? What has happened with that?

I have just noticed that you have followed up [1] with a concern that
using swappiness in the whole min-max range without any heuristics turns
out to be harder than just relying on the min and max as extremes.
What seems to be still missing (or maybe it is just me not seeing that)
is why should we only enforce those extreme ends of the range and still
preserve under-defined semantic for all other swappiness values in the
pro-active reclaim.

[1] https://lore.kernel.org/all/CACSyD1OHD8oXQcQmi1D9t2f5oeMVDvCQnYZUMQTGbqBz4YYKLQ@mail.gmail.com/T/#u
-- 
Michal Hocko
SUSE Labs

