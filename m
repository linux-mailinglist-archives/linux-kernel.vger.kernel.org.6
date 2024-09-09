Return-Path: <linux-kernel+bounces-321821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8477971FFA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F1D286D11
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A8117AE00;
	Mon,  9 Sep 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SnbcGoaj"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E480B179958
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901517; cv=none; b=hG7QGTALG+A8SSTQZxozvJNzIJc5hENiJbzuf0QappYY38idQhf1ghyRP7V5g3niidu9MaxOXjhopZDwTS5aHAWHRWhwCov/zz4AP0IIxNT2dYjBMPuZ3dOcwLgUU28yXhedeEg0/pM2YEZXE19TD9uD43/NRDle23V8pEd+WAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901517; c=relaxed/simple;
	bh=iQVNGf/RNaTqmXHtZ2AwDkYedkNJ2qEs9AXRXO35Q/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q4mdlrtc4+VlyM/zPD+bg/MpdOrQXDDHYLfpNcpHPKnAoOiuvLa4XACogToFObhp2bYs3EaC8y1Dd4/MgYJEw2bQ/j2R5pYzfeIfQbH6iKDaYEOIkg3sjSIFJ9Sni/u7g5tNlnW4GB+2DVfqyqjceOqB0CELKOFQZQ1tEy1BCVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SnbcGoaj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A65220B915B;
	Mon,  9 Sep 2024 10:05:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A65220B915B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725901515;
	bh=4JgTgr3lFtDzFfS92IhOuYLHsVxFaxs5XABBwY7FMgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnbcGoajTES6l0C7NpyVHRhyQfWjIgQr4Zt8UHn8fpuQztllcBz5veH4PJJFwSuPf
	 4J6mCtgHlQjj5CGO+qQ1AhP8wTuIGAkkj/bAqYkken0eOwBqSAAIW2+/CyMLvuGWES
	 QxNrOHX1Z2jJOWsimpfNdIq0rPbyAjxPa84+pRPQ=
From: Roman Kisel <romank@linux.microsoft.com>
To: oleg@redhat.com
Cc: akpm@linux-foundation.org,
	apais@microsoft.com,
	benhill@microsoft.com,
	ebiederm@xmission.com,
	linux-kernel@vger.kernel.org,
	romank@linux.microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	torvalds@linux-foundation.org,
	vdso@hexbites.dev
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
Date: Mon,  9 Sep 2024 10:05:14 -0700
Message-Id: <20240909170514.1112838-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909164251.GA14058@redhat.com>
References: <20240909164251.GA14058@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 09/09, Oleg Nesterov wrote:

> On 09/09, Roman Kisel wrote:
> >
> > On 9/8/2024, Oleg Nesterov wrote:
> >
> > > But you can safely ignore me, I do not pretend I understand the userspace's
> > > needs.
> > >
> > > And I guess people will use it anyway, so I won't argue with, say, a trivial
> > > patch which just adds
> > >
> > > case PR_GET_PTRACED:
> > >     error = !!current->ptrace;
> > >     break;
> > >
> > > into sys_prctl(), even if I agree that this probably just makes bad behavior
> > > easier.
> >
> > Very kind of you trying to build a longer table rather than a taller fence,
> > I appreciate that very much! Your aproach looks very neat indeed,
> 
> Well, you didn't answer my question in
> https://lore.kernel.org/all/20240906114819.GA20831@redhat.com/
> so I decided that a simpler change which returns !!current->ptrace instead
> of the tracer's pid might work as well.
> 

Apologies for that! After Linus had been added, I braced for the impact as
obviously I was not fixing anything urgent or making some breakthrough
deserving such attention. I guess I got my 101 on adding code to "./kernel" :D

> Sorry for annoying you.
> 
Sorry if my response carried that connotation. I indeed learned a lot from
your suggestions. I'll make sure to write better.

> Oleg.

Roman

