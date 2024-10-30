Return-Path: <linux-kernel+bounces-389692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0455F9B7002
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDF6283086
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558DC213EF6;
	Wed, 30 Oct 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0g4T8Hs1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573015B0F7;
	Wed, 30 Oct 2024 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328661; cv=none; b=UxHED9Jvb7IuIaS7svoXmR0tBtk8rrjWdwdbua+8W+zX6mIKR5LT4ur18od6LR6bpIqK72bCUuoftfpIQVr+QYWceYJ4N+fE8zAUb2BZ3gOXh7Ea0DvpGDPJZW4DRWI66WYK30vVniCG+1tbqWVhdS+Up9EwaDLobR01S/J9Q90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328661; c=relaxed/simple;
	bh=5OZZ6STBtQXmhr91xWWz5jJKjpiLI9A86hy+nc8wTGA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DRdVZDLV+oEYvm1UU9vxCV0Slkp0JWQtsAmM5orSGkt9urQqbRx0xAdl9fH9QZ3yL0oNOxQa/iHWom7dUGitFobVyEN46KSBok40S+8Iv7fMC7pxlngFa+AnbGkBZGIJAqBG04CwV0g2QE8VaZgfPgKx+/CUl++AAag7ACbySiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0g4T8Hs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A806CC4CECE;
	Wed, 30 Oct 2024 22:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730328661;
	bh=5OZZ6STBtQXmhr91xWWz5jJKjpiLI9A86hy+nc8wTGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0g4T8Hs19OCvooOl/uZuULo6aOhdFF0w6meJj7vevJ3KsiVHQslxOige2fwxx+SEi
	 YhQerdgGE2t0bca9UW31bsCJ6XhBWUbd+PaihutG9GFRH+9lwaBL8r7z7SjL1g7dV5
	 Jn6pZ5RW6kGrxXt6j0xo90PSgMMLKIoln8fhXb4s=
Date: Wed, 30 Oct 2024 15:50:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, Barry
 Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3 0/4] mm: add more kernel parameters to control mTHP
Message-Id: <20241030155059.9e27019842ef7c009b728b27@linux-foundation.org>
In-Reply-To: <20241030130308.1066299-1-mcanal@igalia.com>
References: <20241030130308.1066299-1-mcanal@igalia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Oct 2024 09:58:54 -0300 Ma=EDra Canal <mcanal@igalia.com> wrote:

> The second and third patches focus on controlling THP support for shmem
> via the kernel command line. The second patch introduces a parameter to
> control the global default huge page allocation policy for the internal
> shmem mount.=20

The changelogs for patches 2 and 3 both say

: By configuring ..., applications that use shmem, such as the DRM GEM obje=
cts,
: can take advantage of mTHP before it's been configured through sysfs.

There isn't a lot of info here - please explain this timing issue in
more detail.

Because the question which leaps to mind is: shouldn't the
"applications that use shmem" be changed to "configure mTHP through
sysfs" *before* "using shmem"?  Seems pretty basic.


Also, please consider my question to be a critique of the changelogs.=20
If the changelogs were complete, I wouldn't need to ask any questions!

