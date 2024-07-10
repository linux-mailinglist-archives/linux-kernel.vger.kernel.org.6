Return-Path: <linux-kernel+bounces-247044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A7692CA3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F67282B51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6781941C92;
	Wed, 10 Jul 2024 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwFGIxlV"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C910A47
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590525; cv=none; b=D/1uy3JrfaMJZmQWFcyT3egosKkgqYZTjaDaunpYb/O1cXCZSeQiRa/KIWod55hnSSEqCyMY0EGNt5XKfVLvI/XDPTWr6awaxLnKfJWogt5NOMhxcXi6fpJYukiANU1vjlQPSvdBipT0CW5GlnIGK9aFQwBe4HWPEZpcFheKRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590525; c=relaxed/simple;
	bh=4iq9U6XdO+rE5jpmKClt97kM5/zeGb+1/z7RYegUV0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/uSIVTIIJMU5ROaIX/g2Pf6oq5O5Pg/V6G9ZQXo+WcwcgKRkC8Lmvwwptk5NLp2p+17ttXUX7f7un4lsM18Y6dnfB7PPS4gMa7IN21Z9lbonWFft93TUm0DIDGqV8b06L2Tyu4HX7JO24nAdoCFQkQO1EgVZ+owvCxyJBa6sTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwFGIxlV; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a05c755477so66842685a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 22:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720590523; x=1721195323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z86NvuyzaJOPDfrjzycHXBN7UlfbAsixtiZJR+7NcKk=;
        b=VwFGIxlVAv+5n8JJoSPZzw8rDHEOA2x4BH8NnrtuADpI8TpJtuoHjCCDxpfQthwAqe
         3rQuHHlq5wrqTq+VEUTQWpV6XWWMhMXLsMVTraQe9QDlZJkkJloP1mVS4gqnZPZs/vG6
         hG5sOCCdl/wen0gzC9NqsucGR+UJgKE71n5V07hHnNPhO4zsgUM1458NAKpoinTUkBLg
         1amGoGt8/nu1+X5SqkUpPOGXcVRbPJP8mAjaWDIbqeLG2Vs/F4GS+L4jHwMtqOSEtaWT
         bMwMZYiHZUKR/sre/z6R8JZLDPnZrQu1LZELfFesQUKkHrgBFwqULvnavlq3rTNljgi8
         DHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720590523; x=1721195323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z86NvuyzaJOPDfrjzycHXBN7UlfbAsixtiZJR+7NcKk=;
        b=lRg0x1Xm9yRHt/iFTytUtaYJjrW5qsLUWj3YtsHpB9SOQPS+E2T8IZSdBR5RAPzSqw
         yChD67XB8XwqRkny+wiZZgt8EYhG0uVLeLkgDUJraSUzD1X6rc9DAOEpE0LhNSTzkZBC
         1QVJPMWvk7frpVTOn1/VqEcbx0kzJghcwBhECGHYm5HgGAtMXgA18FBY8Xyn4RF3BE2H
         +vRrjlXDAXc1/6P7cD6mewWRhJM8aY+CzE0wNh0//JUFM7DHo5slMUhFrMKYHkR3iHGb
         RHR8np6BZq+1NTUGTg7ufPSqL6eG8zFSpssMEAcm5rAqa+TKDU4LbJPtFtZ9G4QipaJW
         wJEA==
X-Forwarded-Encrypted: i=1; AJvYcCWqy6l9xYkvFnH47ou7bXtwqS/vUeyL/Tfztlupi0aplKzSsO2SdPcXgHf2hY1M024cwSrdWJOw3om30Ydtl+iCWyJK9ZLU+Iy50ayi
X-Gm-Message-State: AOJu0YzFLfj4X5IkaXEEpZ9V3VjuWjWgrMvc0O9VhHpoZnoNClQdRXKs
	6DEEH9LtlFtLhH4qShoFEnN/yHxc0QGQEndEqsUn4d/eRL5n8gwg
X-Google-Smtp-Source: AGHT+IEPzqupu9wCQT5SlmX1xuSLqDOVaS4aS3BmlAgZVFVqtH93lQUJ8eZqieZsV111ahuSdaJ7dA==
X-Received: by 2002:a05:620a:3bd3:b0:79f:121d:d808 with SMTP id af79cd13be357-79f19bf00a1mr426347485a.71.1720590522944;
        Tue, 09 Jul 2024 22:48:42 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b1dd1sm164467485a.117.2024.07.09.22.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 22:48:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 243691200043;
	Wed, 10 Jul 2024 01:48:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Jul 2024 01:48:42 -0400
X-ME-Sender: <xms:uSCOZqx7sGF9T5nq37PK7B37X9aUft8o1gRQhU0xtmymd27j7Zi0Ag>
    <xme:uSCOZmRMx5kk2cY0HjQQ0nhSofVMku3SvODPCyBnCEhMdivA1WU2e4ElQmJe47EB7
    fLsnFeCa6-MsfWXjg>
X-ME-Received: <xmr:uSCOZsW2DaQfubUTtJHywdx32icdaWKwFrDEHqdtdxuONMiJkSVMzo_uUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedtgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:uSCOZgg8i8TxDdaLq4HjdurRd8aBWxqZicAUwXJTflj_bdHH6d1NCQ>
    <xmx:uSCOZsCD20rukaBluEVlfTrdO0OkIau5yPc5-T5-giAbaXUC-w8xjA>
    <xmx:uSCOZhI1vI0KMLrjeWG54UYxeWpX0bK8mflAc3ZexbBFEmp6FsCzWg>
    <xmx:uSCOZjBWBmyg2Jx-IDMVN6PIybKl9zfu1t-Hf4VYZ_WSBaNWerYiVA>
    <xmx:uiCOZkyfEs0Whd3qYzaKfSjPlXf9eZWMLEPKaKXiWICJDnlojjlEIEXd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jul 2024 01:48:40 -0400 (EDT)
Date: Tue, 9 Jul 2024 22:48:39 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, oleg@redhat.com,
	jolsa@kernel.org, clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 08/10] srcu: Add __srcu_clone_read_lock()
Message-ID: <Zo4gtyzNvinXBOHU@Boquns-Mac-mini.home>
References: <20240708091241.544262971@infradead.org>
 <20240708092416.010695534@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708092416.010695534@infradead.org>

On Mon, Jul 08, 2024 at 11:12:49AM +0200, Peter Zijlstra wrote:
> In order to support carrying an srcu_read_lock() section across fork,
> where both the parent and child process will do: srcu_read_unlock(),
> it is needed to account for the extra decrement with an extra
> increment at fork time.
> 

We also need to dup the per-task lock held stack in order to maintain
consistent data for lockdep, right?

Regards,
Boqun

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/srcu.h     |    1 +
>  include/linux/srcutiny.h |   10 ++++++++++
>  kernel/rcu/srcutree.c    |    5 +++++
>  3 files changed, 16 insertions(+)
> 
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -55,6 +55,7 @@ void call_srcu(struct srcu_struct *ssp,
>  		void (*func)(struct rcu_head *head));
>  void cleanup_srcu_struct(struct srcu_struct *ssp);
>  int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
> +void __srcu_clone_read_lock(struct srcu_struct *ssp, int idx);
>  void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
>  void synchronize_srcu(struct srcu_struct *ssp);
>  unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -71,6 +71,16 @@ static inline int __srcu_read_lock(struc
>  	return idx;
>  }
>  
> +static inline void __srcu_clone_read_lock(struct srcu_struct *ssp, int idx)
> +{
> +	int newval;
> +
> +	preempt_disable();  // Needed for PREEMPT_AUTO
> +	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1;
> +	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
> +	preempt_enable();
> +}
> +
>  static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
>  {
>  	synchronize_srcu(ssp);
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -720,6 +720,11 @@ int __srcu_read_lock(struct srcu_struct
>  }
>  EXPORT_SYMBOL_GPL(__srcu_read_lock);
>  
> +void __srcu_clone_read_lock(struct srcu_struct *ssp, int idx)
> +{
> +	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
> +}
> +
>  /*
>   * Removes the count for the old reader from the appropriate per-CPU
>   * element of the srcu_struct.  Note that this may well be a different
> 
> 

