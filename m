Return-Path: <linux-kernel+bounces-240233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3386926A86
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA21284353
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18445191F80;
	Wed,  3 Jul 2024 21:41:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E6F49636
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042892; cv=none; b=tF4eS4nV5GmHQaLVjgrDvxALU86fKzkOL2QcvOj7p/ydBZrpDymWAm8Ch0tXXshEtvYayCZLZGkYY3D2Fi7wItG6IfXkaAN7uR/1VLtoQnUwB1r1BL+Vlr7CrFSihDF8RxdnbOn3QudteDWTD1p/BYCyYhI+5gc5VgsJoBUSsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042892; c=relaxed/simple;
	bh=1AOIWxxOBWX5vh1jRAP/DmyIESd9L2fe3ew2irm+bHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swhdXRBWua0A61UvjBbygYI07BA7GZhp1RpwRZ7WvpccOSaEBDaBRnR5sEm8vvmWj4mponogdMjn26tYdjCdbdjdWs3YixLS+R6hTdt598WN6PT6+QwY++R/E2daz/xCzu9Mh9awbALWb8nw9TiwDk2AkVfMTVq2+5YNF4Ecwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D106C2BD10;
	Wed,  3 Jul 2024 21:41:31 +0000 (UTC)
Date: Wed, 3 Jul 2024 17:41:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yang Jialong =?UTF-8?B?5p2o5L2z6b6Z?= <jialong.yang@shingroup.cn>
Cc: mhiramat@kernel.org, Karol Herbst <karolherbst@gmail.com>, Pekka
 Paalanen <ppaalanen@gmail.com>, mathieu.desnoyers@efficios.com, Michael
 Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] powerpc/mmiotrace: Add MMIO Tracing tool for
 PowerPC
Message-ID: <20240703174129.7e19a9a6@rorschach.local.home>
In-Reply-To: <5F5B4CCA07D939BE+1a8b7985-b0c6-4b03-8c31-d1281f7b56e4@shingroup.cn>
References: <2CCFA0BD64E5F2E0+e4c7fc43-47b1-4788-a7d2-44f6a33cff66@shingroup.cn>
	<5F5B4CCA07D939BE+1a8b7985-b0c6-4b03-8c31-d1281f7b56e4@shingroup.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jul 2024 15:39:09 +0800
Yang Jialong =E6=9D=A8=E4=BD=B3=E9=BE=99 <jialong.yang@shingroup.cn> wrote:

> Hello, mmiotrace maintainers.
>=20
> Here is a first version patch used to support mmiotrace function on=20
> powerpc platform. When I copy mmiotrace to powerpc archtecture, we found=
=20
> that there are many code are general, such as code in kmmio.c and=20
> mmio-mod.c in arch/x86/mm/.=C2=A0 But we have file trace_mmiotrace.c as a=
 low=20
> layer to finish the function. Whether we can abstract out one layer=20
> again or not?
>=20

The mmiotracer is at a minimal maintenance level. I constantly test it
and make sure it works (on x86) for every pull request I do. But I
haven't done much more than that.

If I ever got the time, I was going to make it work for SMP machines,
as it currently still requires running in UP (does a CPU hotplug to
shutdown all CPUs but one when enabled). But that's just because there
was no effort to make it multiprocessor safe. It is definitely doable.

But it is very low priority in my TODO list. I have no problem if you
want to clean it up and pull out the more generic parts. Hey, if you
have time, make it SMP safe if you can ;-)  Although that may remove
one of my biggest bug finders. You'd be amazed at what breaks when you
aggressively disable all but one CPU and then enable all of them back
up again.

-- Steve

