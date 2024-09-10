Return-Path: <linux-kernel+bounces-323469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E1973D82
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8563C1F28395
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E661940B2;
	Tue, 10 Sep 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="eJreuFlQ"
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5118DF8C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986457; cv=pass; b=OSpIMfKiNk6NfwbBiYtOlKDvZAFkKD/EQo+ee6jyDpVWoyiGfk4WfjU2viH2Vdt6kCvcNtO4ZbioJ6COAW+X+cSmtdtaZ5uO/g/VTtvNfkg34jX9aKGedIFYYurGYy9Lkc+6RrHjh1KNcCoSKS9Z6bi5WJVRyLlwOvpEnQqZOxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986457; c=relaxed/simple;
	bh=M21sw4QFggo2xdZPy1OShYN7xAGP0xryyJe2jxUadRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeeF9T++i+ClfKF4TZGXA88y7Hb8NEpnr31zInSaMFgYtJqxtsZ6Hudzk1yqamAp8CZZJhT6+23f6ZqZ3OaA6IzIBu0UPpS5QY8oRCrBC2CMwXPCZfRhoPp0WFQJb+4O75ex84WUS8KyXgvzAzgIftsVUW89oNB+39XE0ARUFHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=eJreuFlQ; arc=pass smtp.client-ip=23.83.212.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8CED624B00;
	Tue, 10 Sep 2024 16:31:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a297.dreamhost.com (trex-0.trex.outbound.svc.cluster.local [100.96.218.11])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 10BA224445;
	Tue, 10 Sep 2024 16:31:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1725985879; a=rsa-sha256;
	cv=none;
	b=O7RtYpU1hqHEthZTw0w/JwpstOigqfSGb0Q2TQGKyHFV8MbvXimUVBXNggCITqXcFbCVoK
	DjOW1+jn/+wNSzCjfMiPPrH0W62XlUiTtAGMRFH22mFXLdk+xDuyr6zXrXraJwcq6c8Pfr
	ayOWn8K1m2jhpspxqWfRPja4/We8CIo3fOo3ow/9Cigl8yQ0YDC9hMnzhp+IWHv2bN2Qoc
	HdQf3SZ0h056qo2pWRVtiKlg3M/q8uiIM/tvvrVsiunXoRt/fsO9TXf9XsCKn21GehpC6o
	vORfwZuaR8MYIfemWYINbe8HUerMF0XVNIC1tbp5fqkC0oOUw82xa/HSNkGW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1725985879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=M21sw4QFggo2xdZPy1OShYN7xAGP0xryyJe2jxUadRw=;
	b=g7v6hmlLuC/8skkcDAZ8CLLKsqtHB35U+gJ5HjkNBlsvBkEC97dICjM9K8Acs7Enc8MBWp
	9qTNnW9VfxrI/IXZrox+V5MMNhfDX97HqE5vSwrGzsrr5hIhgXsqKS7Y+F2kJlopRj3xXY
	fGpg2S7fMZ4rfYuz/Y1KlNDNm9kDYOVFXXAWL4fXp4mjB5sf5VJ53QteEh/Q+xjmBgpKPC
	GHVEo5qY5EhCMOXkw2cYOA7yf7lCvCxs/qBKTYBU7hKgOKDAf7IAXG1e+XP6yD/YLCBLnM
	qnw8NHZK7FbzEDOn/SBEKNJ+LJE9fSQH7rM7vd/enzhul0UTQX8fVssgAncU6Q==
ARC-Authentication-Results: i=1;
	rspamd-77766c4bb8-bfbzv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Occur-Army: 1db628342698e064_1725985879372_1003662781
X-MC-Loop-Signature: 1725985879372:3470074365
X-MC-Ingress-Time: 1725985879372
Received: from pdx1-sub0-mail-a297.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.218.11 (trex/7.0.2);
	Tue, 10 Sep 2024 16:31:19 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a297.dreamhost.com (Postfix) with ESMTPSA id 4X38N61tTFz6Y;
	Tue, 10 Sep 2024 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1725985878;
	bh=M21sw4QFggo2xdZPy1OShYN7xAGP0xryyJe2jxUadRw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=eJreuFlQ7v6fTX30v7AsCanQEyrZM0dAVnwf+u/uAkh/SCFoSaJE59VuyC6mL+rUc
	 pkUdU9W/AbwEktaw4Ckz1CLZY7r03k5+8ei95dVMv/yrdQrBUi+ZbgmZ2LK5sQ8pvV
	 uW2mmzXQW5jgHPRw33HhOf2aezPs2hVoStN0rJ1dI77eNiFIgTYi5ZA2+jEqZ9pka4
	 mblkRhOzVQVz1+zqAliwVEZtE+fFztpAoMZTegH4R/q/exKRRZ8EcczFszmhHSzLbK
	 DJQHqcMV22eMCC9EU5zpcFrTkpaJETQUe9stqt+SlPwP9nnC4RYIqn/dcj06aHjmoJ
	 4SgcLhNzuCeXA==
Date: Tue, 10 Sep 2024 09:31:15 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, rientjes@google.com,
	yosryahmed@google.com, hannes@cmpxchg.org, almasrymina@google.com,
	roman.gushchin@linux.dev, gthelen@google.com, dseo3@uci.edu,
	a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
Message-ID: <20240910163115.cg26kenlejlkmnsp@offworld>
Mail-Followup-To: Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, rientjes@google.com,
	yosryahmed@google.com, hannes@cmpxchg.org, almasrymina@google.com,
	roman.gushchin@linux.dev, gthelen@google.com, dseo3@uci.edu,
	a.manzanares@samsung.com, linux-kernel@vger.kernel.org
References: <20240904162740.1043168-1-dave@stgolabs.net>
 <Zt6hur2TZJUrJ2IU@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zt6hur2TZJUrJ2IU@tiehlicka>
User-Agent: NeoMutt/20220429

On Mon, 09 Sep 2024, Michal Hocko wrote:

>On Wed 04-09-24 09:27:40, Davidlohr Bueso wrote:
>> 1. Users who do not use memcg can benefit from proactive reclaim.
>
>It would be great to have some specific examples here. Is there a
>specific reason memcg is not used?

I know cases of people wanting to use this to free up fast memory
without incurring in extra latency spikes before a promotion occurs.
I do not have details as to why memcg is not used. I can also see
this for virtual machines running on specific nodes, reclaiming "extra"
memory based on wss and qos, as well as potential hibernation optimizations.

>> 2. Proactive reclaim on top tiers will trigger demotion, for which
>> memory is still byte-addressable. Reclaiming on the bottom nodes
>> will trigger evicting to swap (the traditional sense of reclaim).
>> This follows the semantics of what is today part of the aging process
>> on tiered memory, mirroring what every other form of reclaim does
>> (reactive and memcg proactive reclaim). Furthermore per-node proactive
>> reclaim is not as susceptible to the memcg charging problem mentioned
>> above.
>>
>> 3. Unlike memcg, there should be no surprises of callers expecting
>> reclaim but instead got a demotion. Essentially relying on behavior
>> of shrink_folio_list() after 6b426d071419 (mm: disable top-tier
>> fallback to reclaim on proactive reclaim), without the expectations
>> of try_to_free_mem_cgroup_pages().
>
>I am not sure I understand. If you demote then you effectively reclaim
>because you free up memory on the specific node. Or do I just misread
>what you mean? Maybe you meant to say that the overall memory
>consumption on all nodes is not affected?

Yes, exactly, that is what I meant to say.

>Your point 4 and 5 follows up on this so we should better clarify that
>before going there.

