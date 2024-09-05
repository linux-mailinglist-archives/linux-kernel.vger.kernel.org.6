Return-Path: <linux-kernel+bounces-318034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6945796E765
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877881C23298
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BFD288D1;
	Fri,  6 Sep 2024 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qqyi3i8B"
Received: from cheetah.ash.relay.mailchannels.net (cheetah.ash.relay.mailchannels.net [23.83.222.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF262233B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587630; cv=pass; b=RpN17+Ck7zRO0lm36xxHvug6r19wtaA/qpyANRqFtqahKyheuxhPdLUG30EJziAst7VC2cKnKdcyJfr1YNTn26pHlUk5CrhGRrjwtw7efU5GXHtoMI9e318eiQCwLVi0WVGoIWGNLpAdEfMymmQqWFidu4DqwGKRFIgu0izxZw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587630; c=relaxed/simple;
	bh=2S8X0xUANTwU9pJASFvGEzfejQnAoym/qG0XwbO7PsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8lQLUGEuB9yaXnqQwgP56chZiLQpBhS8ZF0egpUcYfoIB1pGFsGEtt0D2lmppnZEcfBl3/fDX7WnddDRZBMxy8v/VhpSWfBHqUe+YW+pGsfJuwBNfJzT7drdovHR67rOGjhRK5K7sIjfqcOHspFLEvgtabymwTS0Lttg13Jfyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=qqyi3i8B; arc=pass smtp.client-ip=23.83.222.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DA81EC5BC9;
	Thu,  5 Sep 2024 23:29:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7522CC5440;
	Thu,  5 Sep 2024 23:29:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1725578984; a=rsa-sha256;
	cv=none;
	b=TfCeLZsZ94X0XgUgThXmgdirNhq1lNs8KEf5GSLD2z7sGayx6KfW5+2Dx5VU+XUY0Kuk+z
	eemJls/HsZizIXMRPwpfiNzgOCJ0kmFaqGjG/4SUh9R4HlDpqBnAf8uVKmbLGxrcMMGyjS
	GZf67iMkXVjfOtxxOF13dE07B2TtVIOeurDU8GKkpLN+g0SUGUZJmXLFib/mUX+LmmWDxD
	B2c003pb5teZUnn6UTuKfYvGKkS46dmkrm9rYSiaj1Mgt8uwybxQ0oKhQoHjQ3JC4KA1kj
	ougt/a5kdGjNGO4vBLFEQiOf89xYdVntX97uA97OC+BAEenv/gmhnjKmxuXmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1725578984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2S8X0xUANTwU9pJASFvGEzfejQnAoym/qG0XwbO7PsE=;
	b=8FU7fqd+7U5bjunPkb6jhlB7LPlIN82fK7p9DiZw72/agyRcK0eX7XWdQ2jQdzAomwBp6o
	U81y3iJIUIqm428GmY7pBAgrI+Ox1cHi6pq7/HOqFudF7FdzJUbdSxkKEq0bB8xORJhyNu
	TdokuhEa17eCVK7Uq/T5xiQYh4WrRXLRxJXZpLJxCgwgLPKkEUYJ02fH+cXsdHd0BWTW0G
	KePVGw8EGe82qM0RV+gDMfE9/0INn5o5szT4j3SzfAtENDpJrJgCIBX5zjsbaD7zANCykV
	Q3RwJVAMaqVUfZTibDdu67EiKro6pEZkFB7+qIJJraWyiKmXAZLsVKVGCS5HyQ==
ARC-Authentication-Results: i=1;
	rspamd-85dcd79db4-h6mk5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Exultant-Unite: 443828df6cb4a34b_1725578984724_2528316108
X-MC-Loop-Signature: 1725578984724:3890867753
X-MC-Ingress-Time: 1725578984724
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.250.152 (trex/7.0.2);
	Thu, 05 Sep 2024 23:29:44 +0000
Received: from offworld (unknown [104.36.31.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4X0FvC6dVBz6h;
	Thu,  5 Sep 2024 16:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1725578984;
	bh=2S8X0xUANTwU9pJASFvGEzfejQnAoym/qG0XwbO7PsE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=qqyi3i8BBZVmKh0YZ03zuPNZSFxAI+8wfVcEQ6jWGmenQSoYDf/UDUWFlIuogCg6e
	 rfB6Orof8n/NAD8EPE+1C5/+93LMsLNTlS/iki5GHzVKD3nMSmND5sNa5iz4PDyVdm
	 aiNsZLt1pN+rniRZS3QdA+FYfvhwhcs8jkUla0VDeWlRhzDK99PUIa99RWeQk4lx4e
	 aGYlkleZLbeloHwelP3XgQm6HfCgatk+SyojFrJpLD4LWoErSxLjnPJMfji+AKwxK6
	 J+EnMWVTxQs64u8LmDxFg3up8VGbOYYo0bYitqbFBd1EbtW1wSfvxNo0q1iPo2/GkV
	 Edny2fyeCdMug==
Date: Thu, 5 Sep 2024 16:29:41 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Hillf Danton <hdanton@sina.com>
Cc: yosryahmed@google.com, mhocko@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
Message-ID: <jw5skccxwi3u7i2ieb2l5gamekobbiankxbdzcxtctd636fh4v@wrfgdmkomiu3>
Mail-Followup-To: Hillf Danton <hdanton@sina.com>, yosryahmed@google.com, 
	mhocko@kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20240904162740.1043168-1-dave@stgolabs.net>
 <20240905215945.1909-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240905215945.1909-1-hdanton@sina.com>
User-Agent: NeoMutt/20240425

On Fri, 06 Sep 2024, Hillf Danton wrote:\n
>The proactive reclaim on the cmdline looks like waste of cpu cycles before
>the cases where kswapd fails to work are spotted. It is not correct to add
>it because you can type the code.

Are you against proactive reclaim altogether (ie: memcg) or this patch in
particular, which extends its availability?

The benefits of proactive reclaim are well documented, and the community has
been overall favorable towards it. This operation is not meant to be generally
used, but there are real latency benefits to be had which are completely
unrelated to watermarks. Similarly, we have 'compact' as an alternative to
kcompactd (which was once upon a time part of kswapd).

