Return-Path: <linux-kernel+bounces-430346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FBB9E2FC4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C532831D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C1208983;
	Tue,  3 Dec 2024 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtOQHxoP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031A1DE2B2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268188; cv=none; b=cJExur9KzO8wqqwPKlqsQ6pu+AjHFYRrCUDu2gAZNzyIP+6AMHtCJygCi6jpn7Bk8T6E6iBDxuHge+ogg0ugXqP1qlLLuGll9p2pY7ImH+RZwFSKzMo54pf0/o4NzQztJnr41Z1BhT8zV9IsqtHPTmhEI1DKHUBVl7DKJzdb98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268188; c=relaxed/simple;
	bh=h0ExklUhCNLmdVoamLwWKMNar8UM8nhZLfksrgksxEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVqa7cwXSX704LNw0kS30dLhd9X3272w6V6XL5Bh3lAxchxHFyY61jpZH1Gh6ccljOlcYJmIA+rYVE9j0fEJO3nvm6OeKpBr4dYu83Mlnp8c223z6/VhBrANKFaxXNr+NAgId3iX87M5lBik+jT4X+IhHELD/v5+kDVBjVO+QNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtOQHxoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BC3C4CEDC;
	Tue,  3 Dec 2024 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733268187;
	bh=h0ExklUhCNLmdVoamLwWKMNar8UM8nhZLfksrgksxEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtOQHxoPF5q0OjK1bU4HH1dO5hTU4IldGn3m+5BLGTOlCvfNI4bjYsycpUGMgrdTp
	 SMooGMasmh5JL3a3v18lkdJfmJjQlpIdDGBCJ42sMGbpK8bcr+lafvOV5T6p4PDWzI
	 aM2xk81nDXfHaCUu7AuC09ElTNT+jsT5Q53W1peXMooCcEsfpgh0pALUAI4A6geYNj
	 BiinHKej5jn8J1NEiYecEy0E63LjTz9a2t0PdhM1DPQk6Jg2oIjoI7naARaGeyKpSV
	 2QqWf11A9UiZTYnrykJ+75Iobs9FszX8wtoNXcP/kGSYTkUj+VqpAqYP0CObfQSBEQ
	 Kh1Z3x/4cS9xg==
Date: Tue, 3 Dec 2024 13:23:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] sched_ext: Implement scx_rq_clock_update/stale()
Message-ID: <Z0-S2vvHF0kiEKHi@slm.duckdns.org>
References: <20241203142802.36305-1-changwoo@igalia.com>
 <20241203142802.36305-2-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203142802.36305-2-changwoo@igalia.com>

Hello,

On Tue, Dec 03, 2024 at 11:27:58PM +0900, Changwoo Min wrote:
...
> @@ -2505,19 +2538,6 @@ extern const struct sched_class rt_sched_class;
>  extern const struct sched_class fair_sched_class;
>  extern const struct sched_class idle_sched_class;
>  
> -#ifdef CONFIG_SCHED_CLASS_EXT
> -extern const struct sched_class ext_sched_class;
> -
> -DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);	/* SCX BPF scheduler loaded */
> -DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
> -
> -#define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
> -#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
> -#else /* !CONFIG_SCHED_CLASS_EXT */
> -#define scx_enabled()		false
> -#define scx_switched_all()	false
> -#endif /* !CONFIG_SCHED_CLASS_EXT */

Can you please separate out code relocations into a separate patch? Here,
it's on the smaller side but patches are difficult to read when they're
mixed up.

Thanks.

-- 
tejun

