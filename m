Return-Path: <linux-kernel+bounces-278460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E4594B08B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E13A284024
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C114144D11;
	Wed,  7 Aug 2024 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ecmu581L"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B3142E67;
	Wed,  7 Aug 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723059700; cv=none; b=GLzw55L83jw2sSybKGEZ03VNgXyTWWz4ipCIcxwotDjOG36nhjBHGrcBra0AWTzwyz0l0BZgLFRhbugFzapDYL0OXR9QCSBhIj+EibYspXZ17+w/RGEKgDDoh6OP6ZiJl3Zmza/tGSrr/f7vm0mXy0ql7niGSoB/i4Gu1fSJhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723059700; c=relaxed/simple;
	bh=gpyDMszpOK4qKsuK0T7T9GMX7DHn6RQb3K86nAJcV5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eO8f1+uM0ErQKI+e46Za1AnjRnkZla8zBvH0qgqeV2B3TwactvJartS8sfrGDvsV1G4LTxKNENBbEtT5UCbX7fDpY4+5eHNpraHy0U4+ct+epGl5nyYm48a2JZ14tKGSkJrZw/Cp/tpNmOfZo9aVwi0duPnPWvDQGZ5mDvoI3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ecmu581L; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 83E4A418AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723059697; bh=IfZErM8LuY8rSegWLf+G+df1DzJwhYdHZrffFsOLNgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ecmu581L/C5Lm+xWYVvphe+7QY2ro9gFhB7VNHaVts7cgxYzxwdo4LSMYoIpIpegq
	 r0Wg6l0gMpnWZ+wNY2AfJUuX1m5U55jBhFlr5ASM2/xmJb+rwHVQA8e7WvtJI75vGs
	 3g9wIAONeUmkrx9L1SEMRHDLqLLPkMqu6ZhJFXXhAIB2uIVo2RneMJDkYmDMZLLKbs
	 TTGdYl2/Vqf63VuDy6myK4wHclgGU4/lBHOSwtMBx9acFWNcgwJtdo89N1dqNDZ/5d
	 9M9JjmOrKuOcU6lqls7UOppG/6irtZNK5kGKCpCs/lITgBFl3k7fIcVo1mFNZdS35f
	 dqOsdOQMAATSg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 83E4A418AF;
	Wed,  7 Aug 2024 19:41:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, sergio.collado@gmail.com,
 peterz@infradead.org, rdunlap@infradead.org
Cc: bilbao@vt.edu, jembid@ucm.es, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: Re: [PATCH v3 0/1] docs: scheduler: Start documenting the EEVDF
 scheduler
In-Reply-To: <20240720002207.444286-1-carlos.bilbao.osdev@gmail.com>
References: <20240720002207.444286-1-carlos.bilbao.osdev@gmail.com>
Date: Wed, 07 Aug 2024 13:41:36 -0600
Message-ID: <87v80cqfwv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Carlos Bilbao <carlos.bilbao.osdev@gmail.com> writes:

> I was in the process of updating the CFS documentation, as Sergio propose=
d,
> when I realized we don't have any EEVDF documentation to point to. I have
> started it. I know it isn't a lot of info about EEVDF in the doc, but (1)=
 I
> wanted to get the ball rolling, and (2) I prefer to keep it light until we
> have a solid idea of how EEVDF will actually end up. This could take a
> while. When or if it stops being an option, we can revisit it.
>
> Sergio, if you=E2=80=99d like to update the Spanish translations of CFS a=
nd add one
> for this new EEVDF doc, please go for it! ;)
>
> Thanks,
> Carlos
>
> P.S.: Jon, I have triple-checked for compilation warnings, but if you
>       encounter any, please LMK the versions of your tools so I can match
>       them moving forward.
>
> Carlos:
>   docs: scheduler: Start documenting the EEVDF scheduler
>
> ---
> Changelog:
>   v3: Removed labels and used instead paths to documents.
>   v2: Move file within scheduler index. Remove incorrect subsection
>       numbering.
>
> ---
>  Documentation/scheduler/index.rst            |  1 +
>  Documentation/scheduler/sched-design-CFS.rst | 10 +++--
>  Documentation/scheduler/sched-eevdf.rst      | 43 ++++++++++++++++++++
>  3 files changed, 50 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/scheduler/sched-eevdf.rst

So, nobody has screamed, so I went ahead and applied this.

Thanks,

jon

