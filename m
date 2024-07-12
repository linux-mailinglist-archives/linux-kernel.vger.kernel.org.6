Return-Path: <linux-kernel+bounces-251160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4118993015F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16B31F22F91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B4F46542;
	Fri, 12 Jul 2024 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IJtK9LYW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299E8F6A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720817787; cv=none; b=K08R8RvXLrDxR81PsT320BEkBKMt40uAYQ20o//AvqMHmJXJ+L8H9m8TUY8FUoDSiJospX4q967fUHJPhaDObXsGIvin/PU3HuY8PhJF425b8tjnpdSmFchr0kb3MJCdTVGhdrs4DEiTqmcHkm3CvJRdhSn1YelCMeFfvKf1iIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720817787; c=relaxed/simple;
	bh=97/k8W97VFXseeyXUb7dFdkjvKl2R3JBWSCRoDDZVIE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WObIrNuG3KC+NpeyKgg1wTLAxlsJMCUDLjYfO/bIyEXEdLfa3lAv5q6ICT+N5LrPsbr6t5WmBJtj2BREUDlJ7G9Jc04EVYyAsnaAKLrFXgUvJ4cM+qMv3ULI1mh9vevgS7H/+E7EdyD+6JXh7gEOds+15QK0VDILTwdkNl9Ed/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IJtK9LYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF990C32782;
	Fri, 12 Jul 2024 20:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720817787;
	bh=97/k8W97VFXseeyXUb7dFdkjvKl2R3JBWSCRoDDZVIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IJtK9LYWV/hyZrVDz/8pb3w3m17cvPtiEdfn3KXR9Uk8G7fgjyulCNuToK+/Drq8y
	 sLLs/BeNerK8D2suE8g+S/gUXtr5QAerqDxx9OvmBmn5ZRyFShRkOtolhTLTUw1Q3b
	 0mwcpuyTRAmenQSnxWYgEtI8e5i4KhfwnFiIGujU=
Date: Fri, 12 Jul 2024 13:56:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: yangge <yangge1116@126.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 21cnbao@gmail.com, david@redhat.com,
 baolin.wang@linux.alibaba.com, aneesh.kumar@linux.ibm.com,
 liuzixing@hygon.cn
Subject: Re: [PATCH V4] mm/gup: Clear the LRU flag of a page before adding
 to LRU batch
Message-Id: <20240712135626.3a7cc4b9e959a1124614aa37@linux-foundation.org>
In-Reply-To: <503f0df7-91e8-07c1-c4a6-124cad9e65e7@google.com>
References: <1720075944-27201-1-git-send-email-yangge1116@126.com>
	<503f0df7-91e8-07c1-c4a6-124cad9e65e7@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 01:56:04 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> I have no objection to it going forward to 6.11-rc, but I do object to
> the Cc stable, and its current placing in mm-hotfixes-unstable (if that
> means it's to be rushed into 6.10 final).

No probs, I moved it to mm-unstable and removed cc:stable.

The issue sounds significant so someone might request a -stable
backport in the future, but the workflow doesn't have a way of
expressing that.


