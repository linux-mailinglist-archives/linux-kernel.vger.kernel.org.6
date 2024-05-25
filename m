Return-Path: <linux-kernel+bounces-189300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3058CEE1F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 09:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A9D280DB2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547D2FBED;
	Sat, 25 May 2024 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A8nGoJQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5251C14;
	Sat, 25 May 2024 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716621338; cv=none; b=JD9BZ6x80Hb1EPkfblFeNvZmKnrRDKS07aokDbRw2o11iA+9R+rrwaAV4pScDe+Xr/g9ssisBK/Hw49DiEkRTjCiTu4e5DZ6zQOonhrythK6EhWOU8oGksof3XguD7ayVk3Qao4RvjIfEyXywF/MkuAiMRsWdYPstfGSMrLDWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716621338; c=relaxed/simple;
	bh=C7BgGEUfWHbQ3EXaQ35fF08JLyI4lzFZ/v2XJNzTZ6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT3XGueSfcl+ipuYgxgP+NWWHrGVYAhIXWMM5EHdEf622UxdLykt6+brVw2eIYyjPrnmJ2JLIpuKWtQpTzWzCXvIR7IpEBwJyYgsAvpJyVYiKKx4YO/4q3aJxs6LrpP5XlXY9MnyYAxIZTi210/McmfqvxsvqWTN9Ws2emCzUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A8nGoJQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F75C3277B;
	Sat, 25 May 2024 07:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716621338;
	bh=C7BgGEUfWHbQ3EXaQ35fF08JLyI4lzFZ/v2XJNzTZ6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8nGoJQmkCxVF34se93KQ0DgjzCOwYJ2CcADg3Zmchg8/MF9FT8b7QSTrppaCfgP9
	 URDJwc2tuZfu4hXpAGrgnAYQXYn4tvmT8/GaihDE/1CJC22KfMENUVcx35ts51TK4M
	 M9QCvVIM9qhSfTV8D2D2yEavX7vX7QbQauZiPYJ0=
Date: Sat, 25 May 2024 09:15:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	linux-cve-announce@vger.kernel.org, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52656: io_uring: drop any code related to SCM_RIGHTS
Message-ID: <2024052542-diner-snare-a618@gregkh>
References: <2024051338-CVE-2023-52656-6545@gregkh>
 <871q5rqhuc.fsf@mailhost.krisman.be>
 <d1cb0cd3-0826-48fc-8713-8648d6eb9fd7@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1cb0cd3-0826-48fc-8713-8648d6eb9fd7@kernel.dk>

On Fri, May 24, 2024 at 10:57:07AM -0600, Jens Axboe wrote:
> On 5/24/24 10:45 AM, Gabriel Krisman Bertazi wrote:
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > 
> >> Description
> >> ===========
> >>
> >> In the Linux kernel, the following vulnerability has been resolved:
> >>
> >> io_uring: drop any code related to SCM_RIGHTS
> >>
> >> This is dead code after we dropped support for passing io_uring fds
> >> over SCM_RIGHTS, get rid of it.
> >>
> >> The Linux kernel CVE team has assigned CVE-2023-52656 to this issue.
> > 
> > Hello Greg,
> > 
> > [+Jens in Cc]
> > 
> > This is stable material, but doesn't deserve CVE status.  There is
> > nothing exploitable that is fixed here. Instead, this commit is dropping
> > unreachable code after the removal of a feature, following another CVE
> > report.  Doing the clean up in the original patch would have made the
> > real security fix harder to review.
> > 
> > The real issue was reported as CVE-2023-52654 and handled by a different
> > commit.
> 
> FWIW, the same is true for a number of other commits recently. They are
> nowhere near CVE material, it's just generic bug fixes.

Ok, glad to revoke them if you do not think they are user triggerable
issues.  I'll go reject this one right now, thanks.

greg k-h

