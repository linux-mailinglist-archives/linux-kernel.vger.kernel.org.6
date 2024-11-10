Return-Path: <linux-kernel+bounces-403299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D39C33CA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 17:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709D8281341
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B939355C29;
	Sun, 10 Nov 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mostlynerdless.de header.i=@mostlynerdless.de header.b="INBWz1WJ"
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA535219ED
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254967; cv=none; b=lHteCC6qgov5kQyN4xZGIK3MvoOXnqzVEblFGTGquj7JYhkmkVfzxZkwua54/mNNRjbqWuM/or+yBlcz1c6j9K2bnEzPjj+SsLxX8GF/D3M95H2BD4crgOOqUUXIqrknH0h0F3t8Vi+ROSHVRv+DOTrByB/tKiZZOvgFTTurE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254967; c=relaxed/simple;
	bh=4NAc2AkKLp5I66oeHbu8URv4jNovvI/XKC2rooRfomw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Ay7iFKUzJZMFBZ/CQAq+O00Jxnr2XXfMX1Z/5WN1MkfRylvoPhDGuLTsUTptUTQHiLSAYKkkFxKyRvAH32bdtP0slELwkGTSn6u9aTQEE5ObxRK7pQPxSbU03vwztR6TU8Iy00TmzFGrSHUv2ul/f4FIdlpLElcqmSMPjyRaeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mostlynerdless.de; spf=fail smtp.mailfrom=mostlynerdless.de; dkim=fail (0-bit key) header.d=mostlynerdless.de header.i=@mostlynerdless.de header.b=INBWz1WJ reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mostlynerdless.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mostlynerdless.de
Received: from helike.uberspace.de (helike.uberspace.de [185.26.156.135])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 781091801EB
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 17:09:16 +0100 (CET)
Received: (qmail 1702 invoked by uid 988); 10 Nov 2024 16:09:16 -0000
Authentication-Results: helike.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by helike.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sun, 10 Nov 2024 17:09:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 10 Nov 2024 16:09:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Johannes Bechberger" <me@mostlynerdless.de>
Message-ID: <42a6a270d7b01c02eb4d78bb408165641c6b435a@mostlynerdless.de>
TLS-Required: No
Subject: Re: [PATCH 2/3] sched_ext: Rename scx_bpf_consume() to
 scx_bpf_dsq_move_to_local()
To: "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min" <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, sched-ext@meta.com, ggherdovich@suse.com,
 dschatzberg@meta.com, yougmark94@gmail.com, changwoo@igalia.com,
 kernel-dev@igalia.com
In-Reply-To: <ZzCej_1NNr2wB0AD@gpd3>
References: <20241109194853.580310-1-tj@kernel.org>
 <20241109194853.580310-3-tj@kernel.org>
 <81281555-d57f-4507-a3a5-ea9d1aa27871@gmail.com>
 <ZzCej_1NNr2wB0AD@gpd3>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.999999) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=mostlynerdless.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=4NAc2AkKLp5I66oeHbu8URv4jNovvI/XKC2rooRfomw=;
	b=INBWz1WJzki5zGzAN2lwyJfpvQcFnROS8ISugzZgGqg/xMa0O1bEZ27bNG9VGQXrixT53JUDlP
	byalxs5BQPfw9pj70/6ccr+gpYb2QJXX252/qG+ybobgg3Osd0DS660WtFqTUBD2XXmU3z8r0S4D
	59bCmXPxrTQMbju9PDToBl8Zrx5YTt7MK6bmif1IzedMPuxUXV29n1JzyxONXaXmUgrSUGQKk3l/
	TwvYCu/X/MEhVbRPixghBR/gW4Ru1n6VVXS54ycsBgG45CQ1548b9jFMu8Gr9Ffczx0M1utpLiam
	K2cwJcMPe5fABciCYsPLcLIx4IsqHV1qhTCppCrg6RDC/HL8DrsXehUo1ccAZxn8gIC1fDmR4q6a
	/xEch679DehGljJC+uMUkkyAqwWTQZj1mMa4A1MDltc+R7PkRh/ZHA+FDVTfOJLPmWe61GHymkJH
	Eji1CZWs6YhUXb5Fl9YijTojN1VzhAtt4giGhJ/cnpA9/MmyLrgIQbM+Ax3/ofjls6XBrs5Ix3mQ
	TQvAQJ5YF2HJFOomfI2bCH4oc5LyzgWX/ec0bbhh9zyG9qYQidmW6rRLp5lSrVfy0Xtszm+Xp1F6
	pV0v6AEgrgkjZdIpNl/FV2e2P6jk1h8AkHCdx6i4MGchFHsajYIV1mweVq/ldhdC9ZNWkX91zxGg
	M=

Hello all,

the changes look really good and the renaming will make it much easier
to explain what a simple scheduler does, lowering the entry barrier.

> > * Insert @p into the vtime priority queue of the DSQ identified by @d=
sq_id.
> > - * Tasks queued into the priority queue are ordered by @vtime and al=
ways
> > - * consumed after the tasks in the FIFO queue. All other aspects are=
 identical
> > - * to scx_bpf_dsq_insert().
> > + * Tasks queued into the priority queue are ordered by @vtime. All o=
ther aspects
> > + * are identical to scx_bpf_dsq_insert().
> >
> > I suggest keeping this part, "and always consumed after the tasks
> > in the FIFO queue." Otherwise, IIRC, there is no place to explain
> > the priority between FIFO and priority DSQs explicitly.
> >
> I think we don't allow anymore to use the FIFO queue and the prio queue
> at the same time. Maybe we should clarify this here and also mention
> that we can't use scx_bpf_dsq_insert_vtime() with the built-in DSQs.
>
> Thanks,
> -Andrea
>

I would like to second that we clarify the differences between the built-=
in
and the non-builtin DSQs.

Also: Could we mention that the priority queue is stable? If I remember c=
orrectly,
then tasks with the same priority are scheduled in a FIFO manner.

Regards
Johannes

