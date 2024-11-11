Return-Path: <linux-kernel+bounces-404856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9909C4934
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62ED9B266CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70B1BC08B;
	Mon, 11 Nov 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="grDLkr9L"
Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA06C16A397
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731364658; cv=fail; b=dinNOGErE4L71ES4+cr33rtrTw5RqeeqXzHgo6C9SpNyddWKhAVDo1epmbaOLO7MFNUSWrmLIE9PXEhhbN6b88MfzGf9yo5RsYfw5pp9ZdpqMX28vaHvd7d7EFrPIvbnAZ/cV/tjECW+q+JIj+VRvwq28+VsXtuIqPKzGee7je4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731364658; c=relaxed/simple;
	bh=rVXQpgZFFCB0B7kPGYqOLEcaXAM10/xQ6g5TjF+6I8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8xEMySVxNDye6+sPIcPZqnw8Cwpc99iCpt8cu7KHuHwIVCqf5I4DBetFsgHhXyOEEf2RTvMGkzmNyUxWmAf1TkvUvgv5Qk9abVLakivN7b736yGlRxQ0lG0toMgH5K8uVpxFa5Vgcfat5BFaMYGz0UNi+jx7oJ4LX1+dPhj7jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=grDLkr9L; arc=fail smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EFC65322BF8;
	Mon, 11 Nov 2024 22:18:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (trex-2.trex.outbound.svc.cluster.local [100.112.137.74])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 692AD322B3C;
	Mon, 11 Nov 2024 22:18:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731363524; a=rsa-sha256;
	cv=none;
	b=36cBZsi5eesov9QfMZjnzrg/LcWQgKY5kf1wZaws7g+aC2vjMg/avJLja6X84O/OxKsueU
	blITRT7jjLmQxipQiognLZB5KKsDTS/CpQ1lo4PHkGd/FAZMOA2im6NBfAv4k6tOATrSPi
	wFsgVn0WLUBphaeasDHsEgjn3iTyqye32JvHIdOzZr1x+KbtfFU837n9F9j3oC3yGc5tNL
	MqQ87qqrdMRg4mmCtKuaA3ByPHVEd8N3sjpgSk3MzfuusmLAkrqQ/Cv2q9VbvBI2JgDPbv
	5t6bpsCOHeOIcv46GyWRzK02dUuuVfn/W5oB2bZkRyco6mVC8SN97zjxK7A6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731363524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VICFEgoqAp63otwKjTCMukTH3bpEX8BxDVIH/F7xgnU=;
	b=hI7HsBM8o+l4O6yOEDXR7r/UH4axgB/lmiEVtYGz82DwJ9qUss2CL+t9fpMkOBuwe+fz6b
	v4MrPltBaj3LxtbObnFcQA8pscgFzOc2P8Jmvw0SolyuxTvVo0miHmWAxvU6JMnw4IjLhN
	BYq2+jhOZFH5nUtWm7SgRllI6Hpe289U0ZLgVirfSNpZNo9Tnsya89SXkVXyH6KbCg7D43
	IAvwU6ebyqr0AssK8F+N66NtYWFyShHUGKjws3a8hr8zPWXp0xRpQAWaJXWNblzb47YbPT
	jRrAZVO+JPHQNZpsJlbiywuU/HrMZn8zDq9tRofRevIxpDSNJPUQII3q+ofGEg==
ARC-Authentication-Results: i=1;
	rspamd-56654dd69b-grk87;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cold-Attack: 7b7202b34599eb7a_1731363524840_2325387013
X-MC-Loop-Signature: 1731363524840:2052108465
X-MC-Ingress-Time: 1731363524840
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.137.74 (trex/7.0.2);
	Mon, 11 Nov 2024 22:18:44 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4XnP8L3wwQz3N;
	Mon, 11 Nov 2024 14:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1731363524;
	bh=rVXQpgZFFCB0B7kPGYqOLEcaXAM10/xQ6g5TjF+6I8U=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=grDLkr9LQDkA+yPuDhKrvqAFjSkSoQbemh7TU9yAzsCEbt/HavjkCCqOSu+/SGsF1
	 c6F3iBXU/wemE3/v5CADdb0D2BPELH5Ml3lBnAknCKIehRIw/+PHqyfz4mi52I2RKx
	 bPXJNzIIig2tLo32ZhCDxlTc4Phss0WB/Y2iETBOy0An/HOJceGHNt9mwcGbbKpHUF
	 cCrHOBfwkid7z0VNzWxahmVh2SmGY0yiEr0EqIQAVaJj4ppPVziGHgpgThkNa/8OcF
	 PotTC2UEeyPflRyFcXg+k/jQhs3dPczUw918xn+eMN/KJQhfknwgz5hdkkuJrCGWMr
	 HVvG+MNz3jwnQ==
Date: Mon, 11 Nov 2024 14:18:39 -0800
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
Subject: Re: [PATCH 0/4] move per-vma lock into vm_area_struct
Message-ID: <20241111221839.w4rqqlvvkm42jdgm@offworld>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241111205506.3404479-1-surenb@google.com>
User-Agent: NeoMutt/20220429

On Mon, 11 Nov 2024, Suren Baghdasaryan wrote:

>To minimize memory overhead, vm_lock implementation is changed from
>using rw_semaphore (40 bytes) to an atomic (8 bytes) and several
>vm_area_struct members are moved into the last cacheline, resulting
>in a less fragmented structure:

I am not a fan of building a custom lock, replacing a standard one.
How much do we really care about this? rwsems are quite optimized
and are known to heavily affect mm performance altogether.

...

>Performance measurements using pft test on x86 do not show considerable
>difference, on Pixel 6 running Android it results in 3-5% improvement in
>faults per second.

pft is a very micro benchmark, these results do not justify this change, imo.

Thanks,
Davidlohr

