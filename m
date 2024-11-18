Return-Path: <linux-kernel+bounces-413275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AC09D16C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE918282A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD081C07C9;
	Mon, 18 Nov 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="HGRvEieg"
Received: from caracal.ash.relay.mailchannels.net (caracal.ash.relay.mailchannels.net [23.83.222.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CAE1BD4E2;
	Mon, 18 Nov 2024 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949693; cv=pass; b=HdNpil7VW4xZ3K7SzKdLYH+n9D12Xlccc400O+DUCTlMbfnfMlljoFJsHHw5++EK/45r4n/Y3v7mIALFIQ0JEBPTb7Yd3WEFYb1o2DUjG+hQeejRGeP1GtTOeEiJ6sxbwld5tLO5UswNnNKPiwORdHiUXEy8dVU7ZxbX/6cOTJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949693; c=relaxed/simple;
	bh=M6rsCIHZcAigq8kHezC+lUPcy49ca27h0PYMGsT2oMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSaLTbr6Vgu6SjZrDnDt/Niu3pspcZEaEa6jakk1QwEBLEwYba+iwW5PtVvoKvwmMK+CTDlEZGE1TiUAUd6Edo+tM3p8iJmJ5mZNqCQ37pOd3D2+X1XJ/q4ZBJ3rumVgC/FyaLgyxPwx/YB13E2jSf54ePwiD5/c6xpIYHOeR6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=HGRvEieg; arc=pass smtp.client-ip=23.83.222.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5D85A824828;
	Mon, 18 Nov 2024 16:57:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a282.dreamhost.com (trex-9.trex.outbound.svc.cluster.local [100.112.137.144])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C804282483B;
	Mon, 18 Nov 2024 16:57:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731949077; a=rsa-sha256;
	cv=none;
	b=kxlMbF7fMut/J0FfDoiLWatuAmR/osRD1WepZKhSPAkKq7fIaybk8HTe0kN8EGHgpCFGPm
	2tfP2Zz3m2vrsHxw4cXsLDoJcD4xBPEmiWM+7Php7cLRBX4lPVZwHoFWrhQbb5z9BC22P5
	f9HZHKZCsTZHjxfTW54TWc06vTzdk3/4jny74S0CPxSsY2s5p9z7ips12cGZmXmOCPtV2c
	m/C+ToEOPhUvKNvtQNbkh6I82uUeq8F2Egb0e8U3wmqH0mU8B/L0sZYH5lj96m4334TZfW
	4er+qvkjyuX35Q3mPIh5UYLEfVJNxKWzZ0v9aZlZ+mAgzkUGrXZzylAc2FNbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731949077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=M6rsCIHZcAigq8kHezC+lUPcy49ca27h0PYMGsT2oMY=;
	b=0AnASXnxXV82VsEVPxvxRvNUvSzBoMYCYl9xdDSKIujJm5FAnRy+j7AEt9DgnVMjPA7bv3
	D8QYmIRRmrWDGp2VA3uFbdd7/JNXQSylmM1o2YYxvYNMcWSpEmVPaSFmR/MKc6muff/w/X
	4oydx42ZVikWJb4wcduElaexfCNA+AsH67XVya0JRcG0sD1vgNsyGv67+EQrHZNaEPSYlr
	fSSmnSZn9TdJoFogr2puwiuOEUfz0K0c9E1OcxMF3aF/3DE3iexoeUQsPI7QesHaGFNTc3
	utX981wCB11bYVbG54q9wcA4jKLx91F0kXzEkqi+uV2lIZSXKGwB1wRcaRcw/g==
ARC-Authentication-Results: i=1;
	rspamd-7456989c76-b5jgc;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Minister-Trail: 6a6ba2de313d51c7_1731949077250_3014021018
X-MC-Loop-Signature: 1731949077250:3532320025
X-MC-Ingress-Time: 1731949077250
Received: from pdx1-sub0-mail-a282.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.137.144 (trex/7.0.2);
	Mon, 18 Nov 2024 16:57:57 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a282.dreamhost.com (Postfix) with ESMTPSA id 4XsYhy63Fvz1H;
	Mon, 18 Nov 2024 08:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1731949076;
	bh=M6rsCIHZcAigq8kHezC+lUPcy49ca27h0PYMGsT2oMY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=HGRvEiegxQf07F+hiZxIcchbcVgmTg8utpA/HWsbnrb8YlxssaFf8ozofTHVzK1c5
	 ttfl2FGNqS6ruR9w+mVMs7dYB0SnXq0rMtRGVW3r5mLw1PrUwIJ782FNvX5DiEYco4
	 0flD75MIp+0xg+v+Ng2aHrijbABz7SfZaC72HOFvQGjSreuXZNkPZprToMWt3A4IxO
	 5ljZKeqGMcoGar7dmHZYSdpyCjWO6Y5KP+NpCGhXckE3Kl2McNvs79jNB7q+klrrKF
	 3fyD70v/SEiEpEzWOQzXSczN87pEWFBcEKMlN1NTFLU4nSDrw+l0NO9s8mQvXs6Vik
	 7YbCHbExPFuFQ==
Date: Mon, 18 Nov 2024 08:57:51 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, paulmck@kernel.org, brauner@kernel.org,
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/5] mm: introduce vma_start_read_locked{_nested}
 helpers
Message-ID: <20241118165751.3eqb5d4vobslkjpi@offworld>
Mail-Followup-To: Suren Baghdasaryan <surenb@google.com>,
	akpm@linux-foundation.org, willy@infradead.org,
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, paulmck@kernel.org, brauner@kernel.org,
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20241117080931.600731-1-surenb@google.com>
 <20241117080931.600731-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241117080931.600731-2-surenb@google.com>
User-Agent: NeoMutt/20220429

On Sun, 17 Nov 2024, Suren Baghdasaryan wrote:

>Introduce helper functions which can be used to read-lock a VMA when
>holding mmap_lock for read. Replace direct accesses to vma->vm_lock
>with these new helpers.
>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Signed-off-by: Suren Baghdasaryan <surenb@google.com>

