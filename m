Return-Path: <linux-kernel+bounces-357876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BB399773F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB55B214B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50F1E25E9;
	Wed,  9 Oct 2024 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="POkOiRiE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFB1E1A36;
	Wed,  9 Oct 2024 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508104; cv=none; b=qqVWqvkr16eC2C37pgjhpxEs4/OmCtShR1WIpyvzJX2zPiCE7NZA+U6hD8MTl2bOiT4qifvsDfa0npnXiTngykSAoIqArINCCvkkhM/jxon0bd664pNmSQfplvl/i+zMttN0k1QnARlT7ztCeMLRH+rTHOnJc4S4m8QR2NpF09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508104; c=relaxed/simple;
	bh=U7TqRRHty20VoO6nL6y+RwxqEmfTzgcg5lfdBgfAfGI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ip7m9E0XdcM8ZhJHuwfMVWbs/fx1JX4RHJilf5Hdvu+et7RSwFYj2f/8jWNfB65veRmgmWq4xHE0f3cyuKK04gQokoT7IuwPk296OdmrFD7pd2jZR0JnH+7V3KirKoEQvyp8bx5a7Y8xSKSPj5sgMFfiRwSmYuxc/FQb4B5mZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=POkOiRiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4439FC4CEC3;
	Wed,  9 Oct 2024 21:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728508103;
	bh=U7TqRRHty20VoO6nL6y+RwxqEmfTzgcg5lfdBgfAfGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=POkOiRiEWJzuYqxdCw2+wcxgrHEgTMtvy0ldlVa/ja86aQgOsOysob5Z12hlD1xQo
	 3Zmm/93gUHdLijTIXqy8fYcxY2Aik8qSLPPvTH4z0pn5KoeVWQni16NonVdtq3UZYI
	 XhWqVG4stAM9ZoMTDVGYG72VdEEoE4piiFYfVFmQ=
Date: Wed, 9 Oct 2024 14:08:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: kernel test robot <lkp@intel.com>, Jann Horn <jannh@google.com>,
 oe-kbuild-all@lists.linux.dev, Linux Memory Management List
 <linux-mm@kvack.org>, Hugh Dickins <hughd@google.com>, Oleg Nesterov
 <oleg@redhat.com>, Michal Hocko <mhocko@suse.com>, Helge Deller
 <deller@gmx.de>, Vlastimil Babka <vbabka@suse.cz>, Ben Hutchings
 <bwh@kernel.org>, Willy Tarreau <w@1wt.eu>, Rik van Riel <riel@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Enforce a minimal stack gap even against
 inaccessible VMAs
Message-Id: <20241009140822.0628a4d09312cbc19d73c6e4@linux-foundation.org>
In-Reply-To: <f065ca1a-473b-41da-998a-cd51ae1d201d@lucifer.local>
References: <20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com>
	<202410090632.brLG8w0b-lkp@intel.com>
	<f065ca1a-473b-41da-998a-cd51ae1d201d@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 15:53:50 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > All errors (new ones prefixed by >>):
> >
> >    mm/mmap.c: In function 'expand_upwards':
> > >> mm/mmap.c:1069:39: error: 'prev' undeclared (first use in this function)
> >     1069 |                 if (vma_is_accessible(prev))
> 
> Suspect this is just a simple typo and should be next rather than prev :>)

Agree, I'll make that change.

CONFIG_STACK_GROWSUP is only a parisc thing.  That makes runtime
testing difficult.

