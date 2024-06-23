Return-Path: <linux-kernel+bounces-226408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FD7913DF9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58D9281972
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E6318413F;
	Sun, 23 Jun 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZCw1rxvT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5QXfW4N+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B55364A1
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719173695; cv=none; b=i5i5mlSsea/agXFHHRh/mheLg7uybl1S3q9RS4WD013+z9P+58/O4gU/bxv6jKZaLL31cVbAAWZBeWoK18USD6wgarIw549mTwZ6ncvHqfPgXbCL+GhKC8NXiC9bmQkuigyvHonuvv6c87DzQy+FMi+u9Mp2MwQsUeOBB5A2EYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719173695; c=relaxed/simple;
	bh=ufcNYYAl64+y2wY1JCwO22hGdMgHakY6gmp+TxT3GP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kP24xeAFjtNWd4RorCSIxHQdpwcBhgmQCZD/F+plC/jNAmoVm0Jf7CkxbJdhVpcUdVOr72vbyB230vt1tLCgBPUGxk1sIQkLbHmg7EeQ5iGodekAUfwi3nzBYds9034dQnDmvVCopRBnSiOXjS3D80oM9nJR5cENU9SUBoCmkyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZCw1rxvT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5QXfW4N+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719173691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrIQQKdEMsIMapJpoUVOGPyFQNogkWNt13z5mBEumyw=;
	b=ZCw1rxvTdPa3WQOv8NbvOVrKO2zYENwn78OMJxz2u0Mu8ABx19xFXpA80E9TxRQh7zNr+m
	sYTZOjyU1GFSKt+GgR0QUc9UmdL+gEy46YTUgU8TGL6uPLLA8IzlNsvBCX4/6GRNPJ2wVP
	DN45M1hW1CGDH9Fol+1IdwcfCpeu3sQtQ6BF+79vGk0UchaGN84Im2egQ8zQjtd/qb5D0m
	vT1SclpEwYd0QZ0iLof7W0WkozeHarSl8LHX1WHgjJtA0FeKFC/VAvelfX3+LBre/5WiWp
	o4wFDP/Ih8ZQPMalva/u2VmkKIkvTcwaGH678dFiY8yqwTGqCibsYDhkoSIVHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719173691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrIQQKdEMsIMapJpoUVOGPyFQNogkWNt13z5mBEumyw=;
	b=5QXfW4N+7tXqdvaO0xlCE/I+T5ff1eBhFKQ/Wv5RvN8L8oaqVfBawylEakVVte+JTVjBev
	QYsV3aX1NVTIhVBg==
To: Michael Ellerman <mpe@ellerman.id.au>, "Nysal Jan K.A."
 <nysal@linux.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, Michal Suchanek
 <msuchanek@suse.de>, "Nysal Jan K.A" <nysal@linux.ibm.com>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Laurent Dufour <ldufour@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Skip offline cores when enabling SMT on PowerPC
In-Reply-To: <875xudoz4d.fsf@mail.lhotse>
References: <20240612185046.1826891-1-nysal@linux.ibm.com>
 <875xudoz4d.fsf@mail.lhotse>
Date: Sun, 23 Jun 2024 22:14:51 +0200
Message-ID: <87ikxza01w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael!

On Thu, Jun 13 2024 at 21:34, Michael Ellerman wrote:
> IIUIC the regression was in the ppc64_cpu userspace tool, which switched
> to using the new kernel interface without taking into account the way it
> behaves.
>
> Or are you saying the kernel behaviour changed on x86 after the powerpc
> HOTPLUG_SMT was added?

No. The mechanism was always this way. Only offline nodes have been
skipped. x86 never checked for the core being online.

> It's only x86 and powerpc right?
>
> Having different behaviour on the only two arches that support the
> interface does not seem like a good result.
>
>> What is the expected behaviour on x86 when enabling SMT and certain cores
>> are offline? 
>
> AFAIK no one really touches SMT on x86 other than to turn it off for
> security reasons.

Right. So changing it not to online a thread when the full core is
offline should not really break stuff.

OTH, the mechanism to figure that out on x86 is definitely different and
more complicated than on power because the sibling threads are not
having consecutive CPU numbers.

So I'm not sure whether it's worth to make this consistent and I
definitely can live with the proposed patches.

Thanks,

        tglx

