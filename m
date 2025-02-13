Return-Path: <linux-kernel+bounces-513486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B12DA34B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323893BDA29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6049416BE17;
	Thu, 13 Feb 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+m0TgUz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E7C3595F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465134; cv=none; b=i2zSXhBZLQ53HX0FalyB3wDlJdt8/rUL6VSTVpi5GIkTl7pXvwjg4kekKuak3WivqHR//HBS5ah6z1lNLjR5b2JTtg+bMepUbLbifAYPs4dJQjlPnGib98DV5JtbfyiFFbxMgnuydYUWqlp48dwghzCJaxyjwoHpBKbZrwn4z5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465134; c=relaxed/simple;
	bh=ZaesJSO6y7Wm9i85r1JRy/ke5+3ORmTZeWNhNPvvzQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4Zh2VoAEaZ+Mt5JRtapAnXAcsEYd38dIW+lEDKUsg8i3rpTT9d3DNoE1vGjfJmVy9+y9fnxt4bTXmNMRl4an5IU1n50PbRiEjjwBgqv42DkRAxkdQLSHSp0F+iE5hm1t4hp87WANVKZZkjsfxwqwin2WOs4A/rAwk8LjqbRids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+m0TgUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12625C4CED1;
	Thu, 13 Feb 2025 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465134;
	bh=ZaesJSO6y7Wm9i85r1JRy/ke5+3ORmTZeWNhNPvvzQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+m0TgUzyExx7m3qCp3iDYmXCmVY4DbE+P5hFb9rFmEDaFLYgL//euIvqEhXoA7tj
	 fg83syJGsNxxcsnHRxZH8YOEsxtBqos+rC5Gaq/Cm483qnovhrRfmRpTjQH2DbKcTD
	 2fJEIaIo/vq8M01mNKaHX4wIRTC8YVCwkJdsqF60Q/0PeOYP9MMpqMVRX/ib9J1Tlp
	 Qc3DfuGdueey2PCVI2JeGojQMzGDqwincojHmQ0eo/eRLp1XvvWikwgxBMg+60e/Wd
	 0TWXBYCtfkf2qXJdtGQk32GPwQ21x/hxo4RO4tjlDfktQe1UdNbLGBexLIHFxICYdn
	 d/M/Y7rITNuhw==
Date: Thu, 13 Feb 2025 06:45:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provides a sysfs 'events' to expose core
 event counters
Message-ID: <Z64hrU6P67pUA5o9@slm.duckdns.org>
References: <20250210143643.220994-1-changwoo@igalia.com>
 <Z6o3WOGS5Pulha36@slm.duckdns.org>
 <8ce4d887-464c-4d4d-825d-0d01dcafe400@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce4d887-464c-4d4d-825d-0d01dcafe400@igalia.com>

Hello, sorry about the late reply.

On Tue, Feb 11, 2025 at 09:57:08AM +0900, Changwoo Min wrote:
> > This probably should belong to the root/ subdir as we'd probably want to
> > keep the event counter separate per scheduler instance in the
> > multi-scheduler future.
> 
> I feel this is a bit contradictory to the need to access the core
> event counters even after an scx scheduler is unloaded. In the
> current implementation, root/ subdir appears and disappears when
> an scx scheduler is loaded and unloaded.
> 
> We may change the scx_ktype to something similar to
> scx_global_attr_group in order to keep root/ subdir. We then show
> an empty file for root/ops when no scx scheduler is loaded while
> keep the root/events file intact. I am not sure if this is what
> we want.
> 
> What do you think?

Hmm... I don't think we can keep the directory for counters of schedulers
that have been unloaded. Looks like the right thing to do is giving up on
the idea of being able to access the counters after the scheduler is
unloaded. The counters are dumped on error exits, so hopefully this isn't
too big a loss. What do you think?

Thanks.

-- 
tejun

