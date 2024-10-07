Return-Path: <linux-kernel+bounces-353244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F62F992B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8051F23780
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5C81D222B;
	Mon,  7 Oct 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhYAv6KC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3F81D2715
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303123; cv=none; b=KjJ0EGotrhZgAkY5LN7iJ9jc23EK8fF7WQlw4FlIMq1cj9zsxZpYzAqEXMnPUugR+MXnWEhokcXO9F0Hp0xWbSDO/lbqQFEHgk/OeWUBjmxVZhrzypj51VkNVPqmHDFYHcBdIE3zg7NtJtWSAsFReQAe7Sw+KOT2dxr9HZqOVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303123; c=relaxed/simple;
	bh=4aClSqb3zVlRLnZXtppz4xCuDV82ll4KJ/g23i5DL2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiOTIBwb5RjZQVOHhY+LFm1eJeGIZcVhtpvXE6pEfCjrefAqDSweNWqOOqBw6AlO4h0rEXlBmvNYywvNOOcxLKpFPPH/JHU8niTQ56N7lHjmNAcKEjtbdusifDHKP4cAoQN3kRqET2Yq+uczyKqffiCgOX+xaqjG56QZycUZKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhYAv6KC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C79FC4CEC6;
	Mon,  7 Oct 2024 12:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728303123;
	bh=4aClSqb3zVlRLnZXtppz4xCuDV82ll4KJ/g23i5DL2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhYAv6KC3D6TKz9AQky8JLdlfoRBALi+f99YFGG8qFHO8VaKEo3y2YYKVSHTYtQDe
	 lwvURWNOMg8RgzVoVH+jZQ79ZUqPqIPN8yQJmanaUqKxFg0sVjSFlODGekGBswaUTr
	 /Qp0WijRJAkcArlCG80DudkSYkvISe/YwT3EbSBLdEA0WXir0ZE8ysgDVdYBkvaZUX
	 XDD7+HespHI11Hju+74hOZqVPNpHA7SJfHSmv5SKCSBSpPuv9ks0/UGYtREuQV8iG3
	 k7fHOpFfvZhyhruXQZVL/EUsyX0ayhbX+dRxb3t7o5gjvZ2bZIW6/TQA08kbOuUGbO
	 F7005pEqsCw4A==
Date: Mon, 7 Oct 2024 14:11:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	christian@brauner.io
Subject: Re: [PATCH v5] pidfd: add ioctl to retrieve pid info
Message-ID: <20241007-endsieg-pigmente-357468af306b@brauner>
References: <20241006145727.291401-1-luca.boccassi@gmail.com>
 <20241006172158.GA10213@redhat.com>
 <CAMw=ZnS1GTC9RGQCeTqB8g2b78mFXi4zLfg6bumrp+zmgx0VXg@mail.gmail.com>
 <20241006185537.GC10213@redhat.com>
 <CAMw=ZnQUfCy2RBHdkBJ9r-tK5OBidQd=zCKHeJGcfprj4+ELJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMw=ZnQUfCy2RBHdkBJ9r-tK5OBidQd=zCKHeJGcfprj4+ELJg@mail.gmail.com>

On Sun, Oct 06, 2024 at 10:33:08PM GMT, Luca Boccassi wrote:
> On Sun, 6 Oct 2024 at 19:56, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 10/06, Luca Boccassi wrote:
> > >
> > > I see, so what should I do here then? Check both? Or none?
> >
> > I don't know, because I don't know how are you going to use this API.
> >
> > > The caller
> > > needs to verify that the data is still valid at the point they use it
> > > anyway,
> >
> > So "none" should work fine? Just it should be documented that, say,
> > kinfo.pid can be 0 if we race with the exiting task.
> >
> > Just in case, you can also use lock_task_sighand() || return -ESRCH,
> > this way kinfo.*pid can't be zero. But I don't think this will buy too
> > much, the task can exit right after pidfd_info() returns.
> >
> > Oleg.
> 
> I think what we should do is check if any of those fields was set to
> 0, and return ESRCH in that case. This way either we return a full set
> of metadata that was correct at the time it was taken, or we provide
> nothing and a clear error. We cannot solve the race as you mentioned,
> but I think it is important to avoid providing incomplete information,
> so that either the data is complete or nothing is given back. If the
> information is complete but becomes stale later, that can happen and
> it's ok.

Agree.

