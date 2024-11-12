Return-Path: <linux-kernel+bounces-404926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6609C4A72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DFC1F25522
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77683522A;
	Tue, 12 Nov 2024 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="fgxn6uia"
Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB54409
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370248; cv=pass; b=ERkGXPHZV8qYFmPI5rCtqdwE7BvWwGWF48a4WwSQpi49HU4RQ/x7ZJukzVGhJQGG3c1pPdWFS3wRR5Q4w+uVmtyXqhYI7aIuPB3DBBu5aH90KqXvV7P5sH3iJnJ4RPLSA0Zy4fjI1+64p2NBbcIs3kS+24Ow/9gFelWePYlO2HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370248; c=relaxed/simple;
	bh=PnPaTkz/j8AMd5LHmkQ7GOLMJZMrEcEBa/FseYLXUno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCVyi434K0J7A6nm+FIl3+GgukMkvmU1OndwkLTbL/mDeS0jPNGgapiRia69sLNXGh42MsIS54PHw0+E+VsHkYKpQErHyWJS+4wYuChDikJXPHxmio1zqG1qO07XH+rqSZxapXb0nTRDl1UQw0+8IcwIcQtpq9/HXPkBCBXBsfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=fgxn6uia; arc=pass smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1AF00C279A;
	Tue, 12 Nov 2024 00:03:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a230.dreamhost.com (100-112-192-11.trex-nlb.outbound.svc.cluster.local [100.112.192.11])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 85027C0F09;
	Tue, 12 Nov 2024 00:03:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731369819; a=rsa-sha256;
	cv=none;
	b=AA8r7Lfsfyc6jAPJLr5XpsvHR99BO4LHm9NRfi5NF7vNNa0h/WNkCUJsf41mxbOjViJNUf
	8wvjCG/iO536VWV2TeYflcnRjx7laj/h+/Vb6LMJ4pSv1Jfn7xLluUz2PNwmJEfUmmrPKY
	leJRer+tWS+34gxFLiU0YLd6fm9zsFPLDx9e9S4hL3i3oC8atGls/VIYfFrAQmptPLzYwb
	Av+A1nAY/7VWQlfhch0xLlMnVTGWzIDXvGcPIquhjbuAm03YWNmRUK6qWq0P40E3XzqAyF
	SdIeAjFv2syhnLG/4bwyfB6QunTjPaUgcPLCiwWWR/6ahHZQtUDN5QIfVAqqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731369819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PnPaTkz/j8AMd5LHmkQ7GOLMJZMrEcEBa/FseYLXUno=;
	b=gN9FhLNV5RqcIpcNLukaLmdAAgkWxBGE70aCX3k6xdFiPk68REKO+1f7Z2/Is3Y/Xywwdn
	vfK6hS3+WA6FqdIktqD87tTLgcs0Oci/mFYoiPHDYyZoaOe7VE4WXr4IPr0dmtvBKuVZtq
	JJP94FKZammAnqlHHj6vw3906uxPQV/sXo0mJfbPPwxTroQcaf6ZM1N1tyGa2EYY/kQQa6
	UBm8YiPiettVwF5+kMgWp8Wj5L9GKqZy1vH8dSd/n+UpxsMzjqNjp1BRqdxDZ2jXHYMdDS
	qiLjZlgFAFA1h8gQ1ERjyvBhVO6oqT5XDMcuOmwmoiKNzqxKEn1I1UQqraa1rg==
ARC-Authentication-Results: i=1;
	rspamd-56654dd69b-grk87;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Name-Drop: 7a143d8b438d51f1_1731369819970_3320855596
X-MC-Loop-Signature: 1731369819970:1898803580
X-MC-Ingress-Time: 1731369819970
Received: from pdx1-sub0-mail-a230.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.192.11 (trex/7.0.2);
	Tue, 12 Nov 2024 00:03:39 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a230.dreamhost.com (Postfix) with ESMTPSA id 4XnRTP4TcSz2y;
	Mon, 11 Nov 2024 16:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1731369819;
	bh=PnPaTkz/j8AMd5LHmkQ7GOLMJZMrEcEBa/FseYLXUno=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fgxn6uiaS8ypsuCKs0cHXT+1sOzMpC7K67ielKUzO1ZR1kTn7m+H8vR855m6dunSz
	 +VCsTnPRUropy+XjGfMDCpWOBAoM1ApS1Izrrf7HfTYxK0woaColyUi3WvYMS3rQ9M
	 Lvf8libQP2SNVxozaDUQ5OBPZl9OhQLfpX1LjZS2ZShxh8AkqOGfMI20jGDfVSnIrU
	 9k6JNpEd8EWCajopJr1FiUp2yB5czN6BoeACvpffEYd69vf3PozHPicdamOvEuitU/
	 XuiXnfzk578XcqT13g6gvi7CVnLweE09PD24kxW4rL6wccqlNwY3NIDifg7vcV4WMh
	 /NUXF+/fBs4SQ==
Date: Mon, 11 Nov 2024 16:03:34 -0800
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
Message-ID: <20241112000334.ppzn3fap5glivpxl@offworld>
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
 <20241111221839.w4rqqlvvkm42jdgm@offworld>
 <CAJuCfpGw1Nnh3nonDHv-UAeqTB=-3z1+hJk9Opy4X-6mbvdEhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJuCfpGw1Nnh3nonDHv-UAeqTB=-3z1+hJk9Opy4X-6mbvdEhw@mail.gmail.com>
User-Agent: NeoMutt/20220429

On Mon, 11 Nov 2024, Suren Baghdasaryan wrote:

>I'm not really trying to claim performance gains here. I just want to
>make sure there are no regressions.

You might also fine tune the atomics with acquire/release standard locking
semantics, you will probably see better numbers in Android than what you
currently have in patch 3 with full barriers - and not particularly risky
as callers expect that behaviour already.

Thanks,
Davidlohr

