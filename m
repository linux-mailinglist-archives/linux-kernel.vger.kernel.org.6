Return-Path: <linux-kernel+bounces-201746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CBC8FC2A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7C12843B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABD1130497;
	Wed,  5 Jun 2024 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUZVK7tI"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF87660DFA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717561548; cv=none; b=SfcqFfm0aaZIUxJY4jrZR15ZbnT/It4XjcEd7bWvlQ/IR93OCMs2Wj1NDUVomwzabyHEZmN8xwf0Hv2mv+lB7RhFmvfUDdpCebbN6mkEdODZ8AU+7gwoNFra3X7driLOiWa/mDYoIINF0aOQSEnQ6EJC761sSU2PQJuib6OmvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717561548; c=relaxed/simple;
	bh=g/5YMCb42qtGxp7osr6jvhFln2vqs6thuDpQEioZH94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA5aimz9X4UAAGzT7e5BgOgCpYPMbAzXpDuX5fhJ1iaQuHm1wXlulcZceEXy/2AThvam3KKhEB81y8/+RELOFXIiXkitFqkthuaShfOXPj47m5fFfVAF5O/EhuO9uC3B/vnK4ptiWxLMdzWGwpDr2Wutb1mudLpmbrP/986+beY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUZVK7tI; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfa48f505dfso6423204276.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 21:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717561546; x=1718166346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEbQ1d4r/s6evsOJRL2N+n6Aljt6mp5bELQcUaKfVp4=;
        b=nUZVK7tIkCttMQXjBFq1p327Sw2hzfkGiqR5inY9rLvilPOBXwdu673xOjCcLE3muj
         fiIJ3y+xBsG9wAOQgGywrrjb3GQiTgt8K8GoH09MoV9TlLtNJ6ZFGimPCEO0KAvIQUIq
         iF6Bp/hKuzmOsntcdbVB1Q476y1x8u8sP54OVnddnphgBqq9ED0EaWL7jga9rpI4efBD
         7dPd6QgYX3eDuj6z3XQMXdv/jLRRn2ZUN33b05CssaIf1k/QMQkiXOI6iupf/WzzoOQE
         /llkGdcEwiZ/Ef5sbhAp8gz2nERCNexmuQZiamdEwaMvFWoWly06vYETtSPUlf75hv66
         7XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717561546; x=1718166346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEbQ1d4r/s6evsOJRL2N+n6Aljt6mp5bELQcUaKfVp4=;
        b=sQ3nWI/5/PxWwqo3Lx81hvMSIHoxRVHwCbtgdUhn3QMWgS0eLogVPWwIMFONDg5QfO
         gxbFap5mCdO3aj28OLnWKPTX5q0uxSCmt0RsIo6fEIUaM3XLfCp58HBY/7ghCyk72w4X
         eze3HZHY4gVOX/rT79zm/pu1vczOWILOsjIUdEyHvJTeNGAwreyxuvH264C6jMxOGSLx
         oIS8AsZ3sziG/wfQ6NEr96cxXDJIoIbGGKOXVdDvAFN3zO5S7RQ91T1tPQfnfnLY1NIV
         111NwEbaEcuU24lmsGoZdaJN1I9RrmdcoqqGSdAOcjK3UexF6lqUKIpb8jP1To7dqbt7
         8NdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMxd08PAjHLKfJ913LXD2mjbMruTQ39fLgGr07FquMjrHUVX45nfjLK05FLQ7OEL/YJuLiX+MkHslYUi34Hx1UcvvkzGoXkju2pgyb
X-Gm-Message-State: AOJu0YxUz4rDVFHAu6oTWLjYqIlIKlvu23UqML3Oo5Mn8tPfLZCq1DRR
	x/Az3XQURCqxbhMpRw1KRdaJGXIdwmrzatV8FylUc1E2xw5nLhIk
X-Google-Smtp-Source: AGHT+IGDx5f7VSHu8fYhbh4q9nBJtTrC0pCqjf9wS1OEJ/KEcEN279iY/nt7NkpxeR/7e0bLzLSSRg==
X-Received: by 2002:a05:6902:248f:b0:de5:5506:5213 with SMTP id 3f1490d57ef6-dfacab2a23dmr1639410276.11.1717561545749;
        Tue, 04 Jun 2024 21:25:45 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a74ffc0sm44671916d6.58.2024.06.04.21.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 21:25:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A50921200066;
	Wed,  5 Jun 2024 00:25:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Jun 2024 00:25:44 -0400
X-ME-Sender: <xms:yOhfZob7GI7k8K-oIpZ9rWNySdOGHCPeATtr30Tjfva7sqmm9d0FVQ>
    <xme:yOhfZjaYG07tDnHYbSalvwdeUrJtKxj6dmQEbTheTqLBnD0m5IQRfY8KdBqrRmt0w
    Efnf3v0_477ZvaqMw>
X-ME-Received: <xmr:yOhfZi-rqCnExYcoNUbbdtfTceHgp6jthvizDZPCbevV-mn7XtP2HObsKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:yOhfZiqJ1BwM8G70ErsKspBx1-R4YBH_nuyCDPIqlBdU0ax4S8llDQ>
    <xmx:yOhfZjrntVSw39qzqK8k2d5lsYgtdB2cnxORgERtrlOMGNaNity27w>
    <xmx:yOhfZgQskHVs2DwxO-BOL9uKCkl1OYohJF_u5AqkHagFGoWsJaB_gw>
    <xmx:yOhfZjrnOxRrRfQCOV6XprAzRgBUJuBnMWwB4pFEpZqepJq8x7EF4Q>
    <xmx:yOhfZo5caO0--mQQWrqS7sdcNRCKz6q_IyDDqculrFzTN18wjRKUU9Mu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 00:25:44 -0400 (EDT)
Date: Tue, 4 Jun 2024 21:25:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
	will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/4] tools/memory-model: Define applicable tags on
 operation in tools/...
Message-ID: <Zl_oxj9-ypX0U2HZ@Boquns-Mac-mini.home>
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <20240604160409.498190-1-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604160409.498190-1-jonas.oberhauser@huaweicloud.com>

On Tue, Jun 04, 2024 at 06:04:09PM +0200, Jonas Oberhauser wrote:
> Herd7 transforms reads, writes, and read-modify-writes by eliminating
> 'acquire tags from writes, 'release tags from reads, and 'acquire,
> 'release, and 'mb tags from failed read-modify-writes. We emulate this
> behavior by redefining Acquire, Release, and Mb sets in linux-kernel.bell
> to explicitly exclude those combinations.
> 
> Herd7 furthermore adds 'noreturn tag to certain reads. Currently herd7
> does not allow specifying the 'noreturn tag manually, but such manual
> declaration (e.g., through a syntax __atomic_op{noreturn}) would add
> invalid 'noreturn tags to writes; in preparation, we already also exclude
> this combination.
> 
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---
>  tools/memory-model/linux-kernel.bell | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index dba6b5b6dee0..2f49993644ed 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -36,6 +36,13 @@ enum Barriers = 'wmb (*smp_wmb*) ||
>  		'after-srcu-read-unlock (*smp_mb__after_srcu_read_unlock*)
>  instructions F[Barriers]
>  
> +(* Remove impossible tags, such as Acquire on a store or failed RMW *)

This comment needs a bit help, "failed RMW"s still exist, they just
don't provide ordering. How about:

(*
 * Filter out syntactic annotations that don't provide the corresponding
 * semantic ordering, such as Acquire on a store or Mb on a failed RMW.
 *)

?

Regards,
Boqun

> +let FailedRMW = RMW \ (domain(rmw) | range(rmw))
> +let Acquire = Acquire \ W \ FailedRMW
> +let Release = Release \ R \ FailedRMW
> +let Mb = Mb \ FailedRMW
> +let Noreturn = Noreturn \ W
> +
>  (* SRCU *)
>  enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
>  instructions SRCU[SRCU]
> -- 
> 2.34.1
> 

