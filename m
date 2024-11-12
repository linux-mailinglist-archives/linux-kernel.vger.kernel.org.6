Return-Path: <linux-kernel+bounces-404980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFBC9C4B47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005CE283970
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBA1202F85;
	Tue, 12 Nov 2024 00:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Hc/eJe0q"
Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795DF2022E1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372764; cv=fail; b=DHppT1GN9TE5FCSx0kwMw7m3lGceU6zYWmkKdCRf7OIgCIWmZJiSJUoi2XmrBkh44jj+ngEJ+g0OWi+qbjM32TSNkkrqdsrkYqoqOHT8jYSaVGl9MiQ0vEz3zeVI4KY838gSWqtgDWq5tLPWPmDCMK55L0UdBC0p9Hxy/9nmLE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372764; c=relaxed/simple;
	bh=XocY2VNAqTaw+4Ij7YiBqy+eKJbsm01Tjawy+yN/mP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaLQn7+K5TID0xoNyzvcjXIzgLHC81Y3MehAUya87+0BBJRjCqySSPdnGjQ+fzKV5IjHhG7MY+W/cogUXZKKy6MD/I7sI6TDqeLM7pukxRQSwOUcABXPjrFmJCsWy/+/jnDlBJr7AQhdeLYf42lOgV6v3r4Vci7axpuREWltiuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Hc/eJe0q; arc=fail smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8196C902A81;
	Tue, 12 Nov 2024 00:35:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a230.dreamhost.com (100-112-137-74.trex-nlb.outbound.svc.cluster.local [100.112.137.74])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0161F902BC6;
	Tue, 12 Nov 2024 00:35:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731371732; a=rsa-sha256;
	cv=none;
	b=bljxBgq8A0ejgTd4ZmqsHil2f5gi8Ordl6XnrWhpr8kjQ0fWQSONNKaxdh3FvynE3YtVf6
	fKVVVxhChpzYlsF+PVeAcOEKs1CI60+oLjBOugJqjHLWn0HMRtSTv7ZZn3pBaWDB1zpEif
	wKUPIF5tNc1SRlgVyoEvdcjQSVs4jGIVLd+4WwxnA8Rr4CtVNNo0Qv6qp/njGS1/B+R1Op
	p/vVShiwbRy2wiRwisNepqqBbWxLE/48R5uuN9z/tShFlvtj/DPf+nLC+BPHdfxMkVQSZS
	7QLtq+bVJMK7OReG6EUmdNVA57PxcLsT05SeCEhT0FudElVOgG2oU8ptFhvuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731371732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hkovgDxuBvO3O0rBrV7Wlv3C4Hl4IfbaIIFR4AmSZ24=;
	b=a+xWWeiFVdJxkTP3649JM4zobkgEYCluGizso/HEw1Ifo9iH7jpG9D4bFNy1Vu5dV37nC2
	HYt4iIbxuIAwxm9ZSSSyj1V45N80u42XomjbQ0TS0LAGoUg7c8EnaPi2V88EWPMf803aIv
	s1vJRLvqnkUSUBeGaRDNCsD+LFAAWeX1VMjWeX9+vY+/6qL4a8KNslnerRd+J6rKU18t0l
	taZLS4zw+T1Y7ZVrdu54NmSvCbN7JYt7v6UjUzJiFDdh5rplE9S1VE7ipPhR79UI4A0tiJ
	OKL2WmL/Ff6H9IkcYb9lsn3jQ8XHrufqtapgfi16N92UlhVR9d6iTXluBny/MQ==
ARC-Authentication-Results: i=1;
	rspamd-56654dd69b-kcrqr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Industry-Belong: 7fa3aafd1eff5db1_1731371732414_2690658296
X-MC-Loop-Signature: 1731371732414:3619922541
X-MC-Ingress-Time: 1731371732414
Received: from pdx1-sub0-mail-a230.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.137.74 (trex/7.0.2);
	Tue, 12 Nov 2024 00:35:32 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a230.dreamhost.com (Postfix) with ESMTPSA id 4XnSBB1cCmzF2;
	Mon, 11 Nov 2024 16:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1731371731;
	bh=Fo1WIGbUub6ojyw+6YyH8PQYOrpDKJdbcxN9q6NQnsk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Hc/eJe0q1zDOiZwKlL0yzLnOndbqJLWaeZAZJy0Ix7XdYJAYsn+lIPyx1gv2RVH7y
	 /GTwpbP1g2kUIyw6xF25aUX6UCt2sRmNeTD/CepxWBV7GpzXy8z9aJvaIyBo47sVNj
	 /PFAhKn39H6a52yArYUPM4mvtKr0u6XxqWqjupfx/ausWG00jOBliieCTGvv5Jdn/H
	 VNNKGVs6k1GvYFGEDufqyTAlSV3fewt0NUM7bX//YoErg0ksaDdQh7r+0tvqzjw72Q
	 iGeMDLtvBCdu3oTs8qM4gX0nzkUKHqKEyuPBJN8eEl/vRaAFNPjlphlrdh4NNn86gA
	 hTk0Vn11H76lA==
Date: Mon, 11 Nov 2024 16:35:27 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, paulmck@kernel.org, brauner@kernel.org,
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
	souravpanda@google.com, pasha.tatashin@soleen.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <20241112003527.ogtrnknjwvtqfewm@offworld>
Mail-Followup-To: Suren Baghdasaryan <surenb@google.com>,
	akpm@linux-foundation.org, willy@infradead.org,
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, paulmck@kernel.org, brauner@kernel.org,
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
	souravpanda@google.com, pasha.tatashin@soleen.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
References: <20241111205506.3404479-1-surenb@google.com>
 <20241111205506.3404479-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241111205506.3404479-4-surenb@google.com>
User-Agent: NeoMutt/20220429

On Mon, 11 Nov 2024, Suren Baghdasaryan wrote:

>@@ -787,7 +893,10 @@ static inline void vma_start_write(struct vm_area_struct *vma)
>	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
>	 */
>	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
>-	up_write(&vma->vm_lock.lock);
>+	/* Write barrier to ensure vm_lock_seq change is visible before count */
>+	smp_wmb();
>+	rwsem_release(&vma->vm_lock.dep_map, _RET_IP_);
>+	atomic_set(&vma->vm_lock.count, VMA_LOCK_UNLOCKED);

Too many barriers here. Just do atomic_set_release and remove that
smp_wmb(). And what you are doing is really ensuring nothing leaks out
of the critical region, so that comment should also be more generic.

I would expect regression testing to catch this sort of thing.

...

> #ifdef CONFIG_PER_VMA_LOCK
>+		struct wait_queue_head vma_writer_wait;

You might want to use rcuwait here instead, which is much more
optimized for the single waiter requirement vmas have.

Thanks,
Davidlohr

