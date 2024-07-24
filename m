Return-Path: <linux-kernel+bounces-260493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB40193AA36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E9E1C222E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13655221;
	Wed, 24 Jul 2024 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="XxC/R8fu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VzxMX2nU"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1223B1;
	Wed, 24 Jul 2024 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721781894; cv=none; b=DXAonv22H+CQzvCrg6ExDplx0Mzvp+RXYTq/vk4VqQfFTQi8Y+yrmCUN9TiVzujbaKLlm8EPI4jcBCzbLiLrooRcp0qyMpphYFlhPTXZVeVDC1lZQ3214sObxSGe3c9m2dsSCblW+2GiCrASppIXSlDtXTMjlO7mSR7u9zjEiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721781894; c=relaxed/simple;
	bh=Ye/Uc2To1T0RkQ3SymcAf5UTBKbZVCr7TrpZJsXjvQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+SkYIfHZm78hUixGaT7bVjCU6uEMQnu3Eszbp65sAhYNDXqNHcIcPgafVAOOaRqpVMjOcf5L8tUTWvqGifcBPjS25v041FRzwVRvuMO4ew75iir9Ak+v3TzFyj3Q4pDE99I9Kbx+I9X52is4C7WnsmaTMC324wfQwworqoaOBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=XxC/R8fu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzxMX2nU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B3D5A114012D;
	Tue, 23 Jul 2024 20:44:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 23 Jul 2024 20:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1721781890; x=
	1721868290; bh=vNBWihlvNfIQ2dxVTaX54UXFf+AZdOglks4OXNVTmIo=; b=X
	xC/R8fu5MsxT0Mn7UAI/b+dbAfZC4CLXgYWiPHR58UOrLpK9ytF6EhV+1JgFw4DH
	wNTm+TTzM8V2yNeB92pddKbyt4+I+mVQoVbxRiP1FrmrO41SObaIwN0DNJRshrYZ
	kS+vWt4rjY4mSUTdl+RrlphcFSnL39255bpIzYftO7XbzEqQge28KzngD0T21HEC
	irarGmIvOKZHap0rp4vGnaltgFZFUMCQVw1a/6J3PH2yDPouOAmaX339MdO1Wt6v
	BatUcLSwLP6/oWqYv6FZ3i6e37c8B37zuB7TsnuxrPtrMJrF8R5huoRArMTEpGRt
	fsgYBn7dhGhQJ4Z8Fl1Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721781890; x=1721868290; bh=vNBWihlvNfIQ2dxVTaX54UXFf+AZ
	dOglks4OXNVTmIo=; b=VzxMX2nUhEkSxmGpCY8Q6wYR1+87o/SO9ZljoNuuUTqp
	HIDSg8ZvHPNuKva7tnIc2l5DBCo9RmdZqwp+Ppgid22s1FhxnAxKnV78tptuae84
	NOFnSDtcdsb0w7loPdss5CGVslgDqAUvs0f0Sa15/uJwBTMCKLwNl9esXjYyRgNJ
	O787I41EVN+1BoJo4j0OkuXyIRJ96zrYZ98fZ0JMZxcwIjxQdH3xz7IXv3wSJMEv
	M2a9/dg3URCf43jcHlH0f02qlBX26ghq1MrzpNnWMz5KhuTrGwdBh336lhjgOYSW
	AFECcNmgCPAsSPQUhkyShIEkiaQBsDUmIuVHhgGZFQ==
X-ME-Sender: <xms:gk6gZklOCVBBj2_-QdkJZSWPG1MI4PockI3NJyU1ZrKNhUD2aMNUMg>
    <xme:gk6gZj0HjjEOe4h2DiWpunDGKZjrMXyKHQwJ5RLRp3mWVbGnEBm2xuGxjmbyIwpHZ
    r_Gtw0VSiOA3txhTo0>
X-ME-Received: <xmr:gk6gZio7lj0GL3xNPR8OIQX348qYQnbPZAGuuY-j7baxv5AWeEbbgGlGhtxyIDCpCTZUfZhE9hvhruxWvxdyoDKyIDCBMCkcFWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeevieelhfdukeffheekffduudevvdefudelleefgeei
    leejheejuedvgefhteevvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:gk6gZglZum2eMwHNSpn1xrOEUPnuf5SahZm_nvecd42ehLIeXijBZQ>
    <xmx:gk6gZi3D5UKFLSnGyJLI7K8sM35ipJRp22H1lFjm1DsezZ_AVx-ayQ>
    <xmx:gk6gZnskkV11enjYYG2H_GugmrCivgeV8JgFRJHeEsp-XhIVuo4E8A>
    <xmx:gk6gZuWblPvBZ46pprZQkG6cljHGyP0YMo59N6Scs9sruBLiNMu1NA>
    <xmx:gk6gZsrXeumzAFzEEWjKpF3Ny2PC2X_dRTqmeFElO5c1bUI7HJQzxFhr>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 20:44:48 -0400 (EDT)
Date: Wed, 24 Jul 2024 09:44:46 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Edmund Raile <edmund.raile@proton.me>
Cc: clemens@ladisch.de, tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: firewire-lib: restore process context workqueue to
 prevent deadlock
Message-ID: <20240724004446.GA21424@workstation.local>
Mail-Followup-To: Edmund Raile <edmund.raile@proton.me>, clemens@ladisch.de,
	tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240718115637.12816-1-edmund.raile@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718115637.12816-1-edmund.raile@proton.me>

Hi,

Thank you for your posting the patch, however I have some nitpickings
(and some requests to you).

On Thu, Jul 18, 2024 at 11:56:54AM +0000, Edmund Raile wrote:
> Commit b5b519965c4c ("ALSA: firewire-lib: operate for period elapse event
> in process context") removed the process context workqueue from
> amdtp_domain_stream_pcm_pointer() and update_pcm_pointers() to remove
> its overhead.
> 
> With RME Fireface 800, this lead to a regression since Kernels 5.14.0,
> causing a deadlock with eventual system freeze under ALSA operation:
> 
> ? tasklet_unlock_spin_wait
>  </NMI>
>  <TASK>
> ohci_flush_iso_completions firewire_ohci
> amdtp_domain_stream_pcm_pointer snd_firewire_lib
> snd_pcm_update_hw_ptr0 snd_pcm
> snd_pcm_status64 snd_pcm
> 
> ? native_queued_spin_lock_slowpath
>  </NMI>
>  <IRQ>
> _raw_spin_lock_irqsave
> snd_pcm_period_elapsed snd_pcm
> process_rx_packets snd_firewire_lib
> irq_target_callback snd_firewire_lib
> handle_it_packet firewire_ohci
> context_tasklet firewire_ohci
> 
> Restore the work queue to prevent deadlock between ALSA substream
> process context spin_lock of snd_pcm_stream_lock_irq() in snd_pcm_status64()
> and OHCI 1394 IT softIRQ context spin_lock of snd_pcm_stream_lock_irqsave()
> in snd_pcm_period_elapsed().
> 
> to reproduce the issue:
> direct ALSA playback to the device:
>   mpv --audio-device=alsa/sysdefault:CARD=Fireface800 Spor-Ignition.flac
> Time to occurrence: 2s to 30m
> Likelihood increased by:
>   - high CPU load
>     stress --cpu $(nproc)
>   - switching between applications via workspaces
>     tested with i915 in Xfce
> PulsaAudio / PipeWire conceal the issue as they run PCM substream
> without period wakeup mode, issuing less hardIRQs.
> 
> Closes: https://lore.kernel.org/regressions/kwryofzdmjvzkuw6j3clftsxmoolynljztxqwg76hzeo4simnl@jn3eo7pe642q/T/#u
> Fixes: 7ba5ca32fe6e ("ALSA: firewire-lib: operate for period elapse event in process context")
> Signed-off-by: Edmund Raile <edmund.raile@proton.me>
> ---
> This is the follow-up patch to the 5.14.0 regression I reported:
> https://lore.kernel.org/regressions/kwryofzdmjvzkuw6j3clftsxmoolynljztxqwg76hzeo4simnl@jn3eo7pe642q/T/#u
> ("[REGRESSION] ALSA: firewire-lib: snd_pcm_period_elapsed deadlock with Fireface 800")
> 
> Takashi Sakamoto explained the issue in his response to the regression:
> A. In the process context
>     * (lock A) Acquiring spin_lock by snd_pcm_stream_lock_irq() in
>                snd_pcm_status64()
>     * (lock B) Then attempt to enter tasklet
> 
> B. In the softIRQ context
>     * (lock B) Enter tasklet
>     * (lock A) Attempt to acquire spin_lock by snd_pcm_stream_lock_irqsave() in
>                snd_pcm_period_elapsed()
> 
> This leads me to believe this isn't just an issue limited to the RME Fireface

We are in the merge window to Linux kernel 6.11[1]. I prefer reviewing a
small and trivial patches in the weeks, thus I would like to postpone
applying this kind of patches after releasing -rc1 even if they look
good.

In Linux kernel development, we have the process to apply patches into
released kernels to fix bugs and regressions. As of today, the developers
pay some of their efforts to maintain the following kernels[2]:

* 6.10
* 6.9.10 
* 6.6.41
* 6.1.100
* 5.15.163
* 5.10.222
* 5.4.280
* 4.19.318

It is cleared that the issued changes were applied to v5.14 kernel, thus we
should lead the developers to find the posted patches and apply them to
future releases of each version. The process[3] have come into existence
enough before the regression report procedure[4]. I would like you to read
some documentation about the process and add more care for stable kernel
maintainers.

Well, the issued commits are (older at first):

* 7ba5ca32fe6
* b5b519965c4

As long as I can see, these commits can be reverted per each, with a
slight handy-changes. In the case, it is preferable to make a patchset
including these two revert patches. I would like to request it to you,
instead of the all-in-one patch, so that developers easily find the issued
commits (and work to apply these patches into kernels maintained
publicly/locally).

At last, I prefer that the whole patch comment is written by the
posters, instead of referring to comments by the others. I know that the
description about AB/BA deadlock is a bit hard to write, but it is enough
and satisfied for you to write what you understand about the issue. I'd
accept it.

[1] https://lore.kernel.org/lkml/CAHk-=wjV_O2g_K19McjGKrxFxMFDqex+fyGcKc3uac1ft_O2gg@mail.gmail.com/
[2] https://kernel.org/
[3] https://docs.kernel.org/process/stable-kernel-rules.html
[4] https://docs.kernel.org/process/handling-regressions.html


Thanks

Takashi Sakamoto

