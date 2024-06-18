Return-Path: <linux-kernel+bounces-219998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B99190DB55
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D71828382A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90213152511;
	Tue, 18 Jun 2024 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz8NXgs+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6814A08D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734120; cv=none; b=pYi+ZVsB/iL3rY6WOos4NE88ME3ujNPDovQO9po8hdE948/zTEZIsbADHkoOlB0XSEIHsPbe17GXfRuunUtHqVQ9hymxbPWc4IYjBZp+RGcYeRlhVTskejU/uRRAN4yJEs8FKkjXyM+8YJXfK74TBKksz8KXBgpHYUKIeGCltOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734120; c=relaxed/simple;
	bh=m4mtxs80iSRg+SgkNqqKBlFFtg1KExdvVx4uqBD1psg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co5vXb33LQn3mUjA0yNxwUI0P1tUwaXx5OagLnBbneiRBWIcl2NFX9e78smoUbAN8PISaHKt+G1H2VkhjuLCzE0tO+6qedVflfojxHrd8x9jPG5z/VUcS3sYb57CkpdqNnRPI/wTnrUVDqItB7QJl4JRjmeOG6wIRHgSVb8kdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz8NXgs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C5DC3277B;
	Tue, 18 Jun 2024 18:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734120;
	bh=m4mtxs80iSRg+SgkNqqKBlFFtg1KExdvVx4uqBD1psg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Lz8NXgs+IfhFkI6DtLZ2lQdnI/Nm0WWp+bC1iQlRKTuQETh/Iubm4SkU/WQsg6nHX
	 z1BhfnzLOXBGnBJjU1GmmnCiyfa0h9z/XSOAkREo40lxqvEb6HlIEjdIxUKWBwgYok
	 F1abTLp7Zb0bEFlrLnPeayep9cHWAgcpYxyGdbP5A1HBEzVpKaqmQxmDp/ic1m+FmR
	 POH5JkS3AA5ogUvifoT2dTk+qrAjvFVoSbhBheg+wV8KI7su8HqD13Ir3OCIdpWyFq
	 JPFM+aECx0fipC877QY2bwKfAHpFNm15bb87NJqCCOwcWMXXBF9a3Zhbi9QUB0YN6S
	 cS/Xj3nX8HzcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EA235CE05B6; Tue, 18 Jun 2024 11:08:39 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:08:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] context_tracking: Tag
 context_tracking_enabled_this_cpu() __always_inline
Message-ID: <12a4224d-64b0-4963-bf6e-c3050d4f9363@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240617155114.1471233-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617155114.1471233-1-seanjc@google.com>

On Mon, Jun 17, 2024 at 08:51:14AM -0700, Sean Christopherson wrote:
> Force context_tracking_enabled_this_cpu() to be inlined so that invoking
> it from guest_context_enter_irqoff(), which KVM uses in non-instrumentable
> code, doesn't unexpectedly leave a noinstr section.
> 
>   vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x1c7: call to
>     context_tracking_enabled_this_cpu() leaves .noinstr.text section
>   vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0x83: call to
>     context_tracking_enabled_this_cpu() leaves .noinstr.text section
> 
> Note, the CONFIG_CONTEXT_TRACKING_USER=n stub is already __always_inline.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thank you, Sean, I have queued this for further review and testing.

						Thanx, Paul

> ---
>  include/linux/context_tracking_state.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index bbff5f7f8803..1a23d8c7d8c3 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -113,7 +113,7 @@ static __always_inline bool context_tracking_enabled_cpu(int cpu)
>  	return context_tracking_enabled() && per_cpu(context_tracking.active, cpu);
>  }
>  
> -static inline bool context_tracking_enabled_this_cpu(void)
> +static __always_inline bool context_tracking_enabled_this_cpu(void)
>  {
>  	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
>  }
> 
> base-commit: e4e9e1067138e5620cf0500c3e5f6ebfb9d322c8
> -- 
> 2.45.2.627.g7a2c4fd464-goog
> 

