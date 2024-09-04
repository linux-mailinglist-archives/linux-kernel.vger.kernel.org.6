Return-Path: <linux-kernel+bounces-314252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2A996B09B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46CB5B231EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303F84039;
	Wed,  4 Sep 2024 05:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b="VK1ZWPUJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cwdbY8uo"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08095B1E0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 05:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725428497; cv=none; b=uwAI3NfHiQH9Se7OQcw+mF45bFg/QZpSH03w/vfpM1fDcqIgCe67P7RRkt5D4IubaH3KV6gTjqu9a+HkaXkd/i4pJgtBL/r95XuKzJX0co/Z96hlWuCg8nFEkhhFDq7glgF54gw6ogt8kxKZRU9ylVMkOtGaGnWmxz5S84ZZIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725428497; c=relaxed/simple;
	bh=Y7YsT9fvbtKcJj92vaq/HFy20ldqx9xiytvJrgwg3K8=;
	h=From:To:Cc:Subject:Date:References:In-reply-to:Message-Id; b=pFdrj1uNeio0xMc394JDvSUiJQK9CyZTx91keDFV8RTC8cY0FbB7l5SGPbTA3vPOuqc6cVlkLkfsxD03uqSqK4GiH+lugmEhaF7vln+gwtMxP8Oap8LLpOQqzHzUkk9Ipwb3IZXzI5hj+9Ka03b8SsIzz9S86Bo5ECMMDAJubpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io; spf=pass smtp.mailfrom=devkernel.io; dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b=VK1ZWPUJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cwdbY8uo; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devkernel.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9DFD411401CB;
	Wed,  4 Sep 2024 01:41:33 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 01:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
	cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:references:reply-to:subject:subject:to:to; s=fm2; t=
	1725428493; x=1725514893; bh=Y7YsT9fvbtKcJj92vaq/HFy20ldqx9xiytv
	Jrgwg3K8=; b=VK1ZWPUJWWvBurABkXMhjG+pWBL9vNVAsxPeqMu6doBBMux5ciw
	qhYamQLZCXaIPVJs0UTMiFMUDNnJT4XvJWGa/EGgz699jfHrITp95wIToDPLWUoD
	AKXqtYS8/FVUJVPW+qgPO3NtcdxbqundfL5QrxGQ+lC8XF3I0ZkJLIsf09uDfr/6
	raJRHdeiolmmaP52eEV1VACW1uI1n60tqu3aXjFQ96xviHOe2x0qCsJZNtneo4FY
	rzTzNz36889nxlxOsZM/KEUJkq8lve/4BwoPpRAcH+MhcfdC992k9H82MSFWuo37
	k73My1LeQwlK1TEHm0FQzTH6UQu7ZUqKJOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725428493; x=
	1725514893; bh=Y7YsT9fvbtKcJj92vaq/HFy20ldqx9xiytvJrgwg3K8=; b=c
	wdbY8uoNZkVcX3h10+DFNP/mQX7ZRZKhOPwTtAhialpa7hjDZKnQL7iNIPNB9N8I
	35z5LBhxcdhafNgysAteE/qdO85TaBjv0fkrd57sPl2XmILnXj3THQ0JPWJ8Qcqa
	effDESDKrvuzN0kxsjdwD5DY6pDA4H1IsI8vOmURcMZZgx5uQG6uZC462iT7wyJw
	/wxJ7w4tKnvBz1mX9lrA8DfIr4R4EaumLtdJa96elAx7LDagTvpz82uePHaTRTyx
	F5l0yXu2ajGXO1xmGS9YB/PmiHvHX4Ls+q7pUmjF3dcgIwFDaCAZlMqTvMtgVat8
	2Tfyy2fs2bL3BYdfInjxQ==
X-ME-Sender: <xms:DfPXZumfKM6Uu3q5axWnl2visIzKvrBQ2nXe4HNFxfwxpxlwmuz1zg>
    <xme:DfPXZl2IuQdsC59sSTT5K1jRIVULTlUmAPxvIImb-Jme5UdFEnzlNtJgF-TpdFdeb
    z9W0nZ3g1d9g82gM64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgopfhokfffucdluddtmd
    enucfjughrpefohffvvefuffhffggjsedttddttderredtnecuhfhrohhmpefuthgvfhgr
    nhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrghtth
    gvrhhnpeehkeefgffgveegvedvtddttedvkeefvdelheehvdetfeejueetlefhjeevuddt
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshh
    hrseguvghvkhgvrhhnvghlrdhiohdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepgihurdigihhnrdhstgesghhmrghilhdrtghomhdprhgtph
    htthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopegrkhhpmheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepgihurdigihhnudeiseiithgvrdgtohhmrdgtnh
X-ME-Proxy: <xmx:DfPXZsr1nk2i9uUOPEXFq24t5oU6yKaQmCsdOVrcBVYV0sO4WlsmjA>
    <xmx:DfPXZimPneRM1bH6EP5PBEAjDO6UR6qyMpZe0PUtbur4FqAohl-gYg>
    <xmx:DfPXZs2OxKnZ9nqKKNIQWo3Xu58eOmLr5Q-OFP2ra9ylLuUnHjGzag>
    <xmx:DfPXZpuX38yZc_fQtNhcwe9zmOdH_Nid8oGdNmyuHEsQQfjKL1w11w>
    <xmx:DfPXZg8oCQmo1yq-kvVtVWR_f9aR6NSDNQKtDxX-prXJn8q8V87VYwTL>
Feedback-ID: i84614614:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F2DF72220083; Wed,  4 Sep 2024 01:41:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Stefan Roesch <shr@devkernel.io>
To: xu xin <xu.xin.sc@gmail.com>
Cc: david@redhat.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, hughd@google.com, xu.xin16@zte.com.cn
Subject: Re: [PATCH 0/3] mm/ksm: Support controlling KSM with PID
Date: Tue, 03 Sep 2024 22:31:38 -0700
References: <20240903043240.1776614-1-xu.xin16@zte.com.cn>
User-agent: mu4e 1.10.3; emacs 29.4
In-reply-to: <20240903043240.1776614-1-xu.xin16@zte.com.cn>
X-TUID: 620jP8gc0ek+
Message-Id: <20240904054132.F2DF72220083@mailuser.phl.internal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


xu xin <xu.xin.sc@gmail.com> writes:

> Hi,
>
> In the field of embedded Linux for cost considerations, resources including
> cpu and memory, are often not very sufficient, so the global deployment of
> KSM can be a mitigation strategy, which is feasible for closed system
> (scenarios without Internet connection). However, KSM has a side effect of
> increasing write time replication latency, which is somewhat unacceptable
> for latency sensitive applications. Therefore, it can be combined with the
> QoS of the business tasks to dynamically close some part of those already
> started processes in real time if the QoS degrade. Although it is also
> beneficial for server/cloud OS, the requirement of embedded system is more
> urgent and strong compared to cloud or server operating systems with
> sufficient memory.

In general I'd expect a different approach for embedded Linux. Evaluate
which processes benefit from KSM and only enable it for these processes.
On embedded platforms CPU is generally a scarce resource.

In addition there is already the KSM advisor which checks if VMA's are
have benefited from KSM sharing or not. If they haven't benefited then
they are skipped the next time. Have you evaluated this?

Simply turning on and off KSM for certain processes seems to be a bit
questionable. How do you evaluate that you have waited long enough? To
see the benefits for KSM you need to have at least two full scans. Are
you taking that into account.

I don't see a strong use case for implementing a second technique to
achieve something similar.

