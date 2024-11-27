Return-Path: <linux-kernel+bounces-424000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF6B9DAF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB27166814
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B020126B;
	Wed, 27 Nov 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1ZUI5UvD"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F12CCC0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732745140; cv=none; b=P7hHaWpKHkYhPQJiCjiXx3ThKOiROu3kbWzBlwjCFJyIgJHOXT5K/2yUVNtlU/HJ0DHU6Kz6rrprJoiaPzp1YQQemna5hqZAHG+Zj58lXjMlwT3eeSm8YPeQZiM4rSuMMlZp8MujzzBh4aQz8Orhm+Rkv2hVrmvVlFtrnwEATUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732745140; c=relaxed/simple;
	bh=2DT+WGDRnXjPE/3u0bVQ0Lu9TXcuPRwfjTdcxffFIYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBq49LHhvi4xr9YAvIQH+18/JWF9dMuvsxm+ojLfJf4SLbju2Kz6cVt1GsVpBWeV0543GAWNoPP1RxEoAbZXgvkOkF9z+Hy3UNmdkD2bK8ope9clbieLBdpeUhF2cl0EUIgGJGyMHeq/5G+yXvbEf+7GvieutssyKYtZ/+agZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1ZUI5UvD; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-724f42c1c38so243477b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732745138; x=1733349938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UMsGQydQR4ffQMrLiCfWPs1SrKc1nDVN+ATpbx3XMwQ=;
        b=1ZUI5UvDnYf8XFQFgzmCshvEys0Oi6ONTGcbyybec3VFnPIgZijcfA8vOP+fb0vkYz
         5JrRG6UYWh9RECeHlrNkrk39GSpoCr+i+FLL1lvun+fcmNbdqauuhJpMl8yhYQn/PKd8
         lEaIFBSJPR67zgt31MgmGTu4050NEDjEdiHjFs+r5WXAxKaS564SmFKRPGAaBtdjZOUU
         Bhak5hLVsRZ7LQlgRHe1TkZNxj/saSCO8B+V888pQq9Uk3PAhRoh70UCmc1PQKmCOTPS
         CQA8VOEtFvdil0sJnB8dSw86BMA7fBl/VpL4Olux1FhdHFusdnquWZWr1mj/pIQzKRM/
         o1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732745138; x=1733349938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMsGQydQR4ffQMrLiCfWPs1SrKc1nDVN+ATpbx3XMwQ=;
        b=KFqgNzOfaZEtwH/E86ZGVMjBYRTek3E1yIlwYHncYwe69uheFJmXT67ikYi7mJIR2I
         KK92j0/kqRzb4y7OIBDc8cL2PYWVMQbi9Fy5BAtn2HCAbIJbFRcOBnLJPlobSqlmbG5j
         o+C3FP1A1OM8TF4pcwzcX42nSdQuhBN7xVqAEOb7ir5D3y+npTgF31V8kTRzMW4O4bG7
         nhgFuBE7hSX2WDof8VCPWMm3uXJVnhiUIojfbbxIljEq+5J6AQ7b5DRQaPYaXnmaZAzm
         Rit8sJpdJioJS7/M1od19dsuAVJ0chmKjb1PfQ/1a/76P3yoWGXRLFUkpZey0AMiEoN/
         NLkg==
X-Forwarded-Encrypted: i=1; AJvYcCUVHmYls6ZePerAIOlH7TWqLT6dRu/5qOHMfJCt4rgSKvGc+LyelDMX3MTCxkm4Scxc1ONt0D721NPtCJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2a8mNKf0JcLwciGoo+g6uIXuki9OR55ur+7R9rghI6Uq3VN58
	js2clTPfgXpmStNSGKzEDq9P8FpKdYkrH5ot8OezQcilHNLr9mmFpAvbIt6cv4g=
X-Gm-Gg: ASbGncskYdc8C6m/FZMgt5L3cGZj1OBo2LsdSxiRsunmqox3bqohTrUM8bj3FX5nKI7
	PMB6i/cFOhJ2qd9tNerH+1h9DJKOcFParVJTyOucnLEpJNRa1OSAWCV7QoUERyFRI+gmxqvAs7/
	RYgP+7NVLYUhMTkjdwTdAL/gUXrKLrKqePLhPZIO3fK+3KiTW24QLFUe3PiGzVKMsXv0q3fVOLr
	3XdIWr1kTiBa0kf19gr25qVD7DHS9w6ARWoCBaMESHpHRXxRC5KbcUdsTDgKdtUo61+pANhGl+r
	w6SXG/oDcYsk07HxRCLlEtOdpw==
X-Google-Smtp-Source: AGHT+IEltlKl2PJHg3RFm39OBPMjZ8HODMlAfcoAhjcRSnu6VwmW9h4bksPWqKeNgStjEZ96bmLh5Q==
X-Received: by 2002:a05:6a00:14d5:b0:724:63f1:a522 with SMTP id d2e1a72fcca58-7253017551amr6450497b3a.22.1732745138524;
        Wed, 27 Nov 2024 14:05:38 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254180fcb0sm49277b3a.147.2024.11.27.14.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 14:05:37 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tGQAA-00000003reS-1DGz;
	Thu, 28 Nov 2024 09:05:34 +1100
Date: Thu, 28 Nov 2024 09:05:34 +1100
From: Dave Chinner <david@fromorbit.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, cgroups@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] What memcg lifetime is required by list_lru_add?
Message-ID: <Z0eXrllVhRI9Ag5b@dread.disaster.area>
References: <CAH5fLghFWi=xbTgaG7oFNJo_7B7zoMRLCzeJLXd_U5ODVGaAUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLghFWi=xbTgaG7oFNJo_7B7zoMRLCzeJLXd_U5ODVGaAUA@mail.gmail.com>

On Wed, Nov 27, 2024 at 10:04:51PM +0100, Alice Ryhl wrote:
> Dear SHRINKER and MEMCG experts,
> 
> When using list_lru_add() and list_lru_del(), it seems to be required
> that you pass the same value of nid and memcg to both calls, since
> list_lru_del() might otherwise try to delete it from the wrong list /
> delete it while holding the wrong spinlock. I'm trying to understand
> the implications of this requirement on the lifetime of the memcg.
> 
> Now, looking at list_lru_add_obj() I noticed that it uses rcu locking
> to keep the memcg object alive for the duration of list_lru_add().
> That rcu locking is used here seems to imply that without it, the
> memcg could be deallocated during the list_lru_add() call, which is of
> course bad. But rcu is not enough on its own to keep the memcg alive
> all the way until the list_lru_del_obj() call, so how does it ensure
> that the memcg stays valid for that long?

We don't care if the memcg goes away whilst there are objects on the
LRU. memcg destruction will reparent the objects to a different
memcg via memcg_reparent_list_lrus() before the memcg is torn down.
New objects should not be added to the memcg LRUs once the memcg
teardown process starts, so there should never be add vs reparent
races during teardown.

Hence all the list_lru_add_obj() function needs to do is ensure that
the locking/lifecycle rules for the memcg object that
mem_cgroup_from_slab_obj() returns are obeyed.

> And if there is a mechanism
> to keep the memcg alive for the entire duration between add and del,

It's enforced by the -complex- state machine used to tear down
control groups.

tl;dr: If the memcg gets torn down, it will reparent the objects on
the LRU to it's parent memcg during the teardown process.

This reparenting happens in the cgroup ->css_offline() method, which
only happens after the cgroup reference count goes to zero and is
waited on via:

kill_css
  percpu_ref_kill_and_confirm(css_killed_ref_fn)
    <wait>
    css_killed_ref_fn
      offline_css
        mem_cgroup_css_offline
	  memcg_offline_kmem
	    {
	    .....
	    memcg_reparent_objcgs(memcg, parent);

        /*
         * After we have finished memcg_reparent_objcgs(), all list_lrus
         * corresponding to this cgroup are guaranteed to remain empty.
         * The ordering is imposed by list_lru_node->lock taken by
         * memcg_reparent_list_lrus().
         */
	    memcg_reparent_list_lrus(memcg, parent)
	    }

Then the cgroup teardown control code then schedules the freeing
of the memcg container via a RCU work callback when the reference
count is globally visible as killed and the reference count has gone
to zero.

Hence the cgroup infrastructure requires RCU protection for the
duration of unreferenced cgroup object accesses. This allows for
subsystems to perform operations on the cgroup object without
needing to holding cgroup references for every access. The complex,
multi-stage teardown process allows for cgroup objects to release
objects that it tracks hence avoiding the need for every object the
cgroup tracks to hold a reference count on the cgroup.

See the comment above css_free_rwork_fn() for more details about the
teardown process:

/*
 * css destruction is four-stage process.
 *
 * 1. Destruction starts.  Killing of the percpu_ref is initiated.
 *    Implemented in kill_css().
 *
 * 2. When the percpu_ref is confirmed to be visible as killed on all CPUs
 *    and thus css_tryget_online() is guaranteed to fail, the css can be
 *    offlined by invoking offline_css().  After offlining, the base ref is
 *    put.  Implemented in css_killed_work_fn().
 *
 * 3. When the percpu_ref reaches zero, the only possible remaining
 *    accessors are inside RCU read sections.  css_release() schedules the
 *    RCU callback.
 *
 * 4. After the grace period, the css can be freed.  Implemented in
 *    css_free_rwork_fn().
 *
 * It is actually hairier because both step 2 and 4 require process context
 * and thus involve punting to css->destroy_work adding two additional
 * steps to the already complex sequence.
 */

-Dave.
-- 
Dave Chinner
david@fromorbit.com

