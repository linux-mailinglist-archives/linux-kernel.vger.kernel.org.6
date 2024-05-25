Return-Path: <linux-kernel+bounces-189425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017378CEFDA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 17:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F451F21603
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 15:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEFC83CA3;
	Sat, 25 May 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0qyl2cPB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424A1DFFC;
	Sat, 25 May 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716651441; cv=none; b=CrPCrkXeZ1/BcZ0/79gDQWlP0yDlPoWiaGyIKUztBPF9qy/zdJEcE1kQ31/FEGC9CaiRb1Jz6CSwfi2+hjqVRIVfDzj0xNkQkOL7LbhkCnF4FNqGyuWGtOYcBjQz5JpFx7lR8BP2ZG9hURPdWx++QAuYxb3CVupWpFy40tpDS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716651441; c=relaxed/simple;
	bh=uUjeSZ8n67tGvTCtDHKyxBGEkV9qifQrCGxlPSJk66o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+z64L7OVLQAv6yEJGY/ndMmSS/5j7Jg1hAQ+7ZVoVDAuJasCg4YOYv7qbe4H7dfOz3HWVz6caIHZvknbvhCVKXAKgGEBXYfZ/lGwmQq6HRGEHkEwKxnhg4LUsVomSfNYdeCF6e0OP+6QHLgbVM/H3mzHuy5wwfywjHlaNsT8xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0qyl2cPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04832C2BD11;
	Sat, 25 May 2024 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716651440;
	bh=uUjeSZ8n67tGvTCtDHKyxBGEkV9qifQrCGxlPSJk66o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0qyl2cPBnHKuucOVAjyKvESVrXQGsXxfKWpuN/BA28C774waGj//eRVoKn5AjWNdv
	 81ebPTjxtVd1eMjbo+6AHFuFYEgOg9vJ/tmsgxnVWx80ORphnw9fkjQ9mSftc/EpyM
	 zoM9ECcOjCTlbeg4glMTQWk3K6kYXrCmZW1GfWgQ=
Date: Sat, 25 May 2024 17:37:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	linux-cve-announce@vger.kernel.org, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Tam=E1s?= Koczka <poprdi@google.com>
Subject: Re: CVE-2023-52656: io_uring: drop any code related to SCM_RIGHTS
Message-ID: <2024052515-usual-chewer-cbb4@gregkh>
References: <2024051338-CVE-2023-52656-6545@gregkh>
 <871q5rqhuc.fsf@mailhost.krisman.be>
 <d1cb0cd3-0826-48fc-8713-8648d6eb9fd7@kernel.dk>
 <2024052542-diner-snare-a618@gregkh>
 <CAFswPa9jR6mKAsCrdmspCARe-evk16s1t0SG9LrRLCze_f6Ydw@mail.gmail.com>
 <ededb63f-7abc-4cca-8bf7-c767e6026e48@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ededb63f-7abc-4cca-8bf7-c767e6026e48@kernel.dk>

On Sat, May 25, 2024 at 09:28:35AM -0600, Jens Axboe wrote:
> On 5/25/24 9:09 AM, Eduardo' Vela" <Nava> wrote:
> > On Sat, 25 May 2024, 09:15 Greg Kroah-Hartman, <gregkh@linuxfoundation.org <mailto:gregkh@linuxfoundation.org>> wrote:
> > 
> >     On Fri, May 24, 2024 at 10:57:07AM -0600, Jens Axboe wrote:
> >     > On 5/24/24 10:45 AM, Gabriel Krisman Bertazi wrote:
> >     > > Greg Kroah-Hartman <gregkh@linuxfoundation.org <mailto:gregkh@linuxfoundation.org>> writes:
> >     > >
> >     > >> Description
> >     > >> ===========
> >     > >>
> >     > >> In the Linux kernel, the following vulnerability has been resolved:
> >     > >>
> >     > >> io_uring: drop any code related to SCM_RIGHTS
> >     > >>
> >     > >> This is dead code after we dropped support for passing io_uring fds
> >     > >> over SCM_RIGHTS, get rid of it.
> >     > >>
> >     > >> The Linux kernel CVE team has assigned CVE-2023-52656 to this issue.
> >     > >
> >     > > Hello Greg,
> >     > >
> >     > > [+Jens in Cc]
> >     > >
> >     > > This is stable material, but doesn't deserve CVE status.  There is
> >     > > nothing exploitable that is fixed here. Instead, this commit is dropping
> >     > > unreachable code after the removal of a feature, following another CVE
> >     > > report.  Doing the clean up in the original patch would have made the
> >     > > real security fix harder to review.
> >     > >
> >     > > The real issue was reported as CVE-2023-52654 and handled by a different
> >     > > commit.
> >     >
> >     > FWIW, the same is true for a number of other commits recently. They are
> >     > nowhere near CVE material, it's just generic bug fixes.
> > 
> >     Ok, glad to revoke them if you do not think they are user triggerable
> >     issues.  I'll go reject this one right now, thanks.
> > 
> > 
> > Good day!
> > 
> > So, either I'm completely lost or CVE-2023-52656 shouldn't have been
> > rejected. Forgive me for mudding the problem even more.
> > 
> > I think we need to unreject this CVE (CVE-2023-52656) or
> > CVE-2023-52654 should be amended to include the dead code removal
> > commit.. that said, that'll be weirder than just unrejecting this
> > commit.
> > 
> > The reason is that the commit "io_uring/af_unix: disable sending
> > io_uring over sockets" is not enough to fix the vulnerability in
> > stable branches, because e.g. bcedd497b3b4a0be56f3adf7c7542720eced0792
> > on 5.15 only fixes one path (io_sqe_file_register) to reach
> > unix_inflight(), but it is still reachable via another path
> > (io_sqe_fileS_register) which is only removed by
> > d909d381c3152393421403be4b6435f17a2378b4 ("io_uring: drop any code
> > related to SCM_RIGHTS").
> > 
> > Although that patch claims "it is dead code", this claim was only true
> > on upstream, but not on stable branches (or at least on 5.15 where the
> > vulnerability was proven to be reachable).
> > 
> > What a mess! ?
> 
> Ah right, yeah it was a mess because of the stable backports, it was not
> for the upstream front. Agree Greg, let's just keep it because of the
> stable side.

Now republished, thanks!

greg k-h

