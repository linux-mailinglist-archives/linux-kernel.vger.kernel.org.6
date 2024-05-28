Return-Path: <linux-kernel+bounces-192920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E6C8D2459
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67626285F14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EBD172769;
	Tue, 28 May 2024 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IzjARy5b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0B171E59;
	Tue, 28 May 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923196; cv=none; b=jDqiIm8FF97TkhoAYxlmpKUkgHj5GfvnHIrNP3WqtkUlpGASMo0ZvL1VeDOldqPRKBASROntrZ1ZLFXCvZi+Gq5g9tPQlYSbYpYdvSLRw8C5iVoRJCFMcCD70LN0ivg/NU1YNztJ4mhxawEe5tofzSRt2/mQuMmXTv00R4MHd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923196; c=relaxed/simple;
	bh=s9EOeQrIGWC5bgDBnmFxMry1eqom6yDwDCvVOpoohLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XazLDbB+VD31TyjAzP+baLpmSd4ysUjeHc3q4WWtluQ4TxyvPhWgEMJ4citzt0WRuXLLJ+pUIYF5Ela1eQN5zFRR6hbdgR6HDcWyUNGdHVWDhdeRc4Y9UxVyIyOtKrqhub9ybdyZ/flCxQSDjGRd0DC78UKXZ2cpZIiTLW6Uf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IzjARy5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EE8C3277B;
	Tue, 28 May 2024 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716923196;
	bh=s9EOeQrIGWC5bgDBnmFxMry1eqom6yDwDCvVOpoohLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzjARy5bs7+tqWNRl9ZvDuKXnDCN3CFFB1NKOVF35VpnISbwZmYP9e9zK0vt0klnU
	 2UCxwqSFx0azv3lRpxw8moM2tdA0FLz2WgzQrFHcR6WienR31OaFdueUW/HIGdemCm
	 DL8VCrkLRJ3MA4SsDA12PD4V80REnzXhLZV3OAmg=
Date: Tue, 28 May 2024 21:06:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: CVE-2023-52734: net: sched: sch: Bounds check priority
Message-ID: <2024052824-justice-lair-14e6@gregkh>
References: <2024052100-CVE-2023-52734-c8c2@gregkh>
 <ZlWNaIMC3NCkIFxv@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlWNaIMC3NCkIFxv@tiehlicka>

On Tue, May 28, 2024 at 09:53:12AM +0200, Michal Hocko wrote:
> Is this really soemthing that should be getting a CVE assigned?
> First the fix is incomplete - 9cec2aaffe96 ("net: sched: sch: Fix off by one in htb_activate_prios()")

Incomplete fixes are still part of a fix :)

> Second is this even real problem? https://lore.kernel.org/all/Y9V3mBmLUcrEdrTV@pop-os.localdomain/
> suggests it is not.

Ah, good catch, I didn't see that.  I'll go revoke this as it's not
doing anything.

> And third, WARN_ONs are considered a real deal by CVE team because
> somebody might be running with panic_on_warn. This patch adds one!

Yes, but if you can't hit that by anything from userspace, it's not an
issue and just dead code.  We'll have to wait for a future syzbot report
to prove that wrong :)

thanks for the review!

greg k-h

