Return-Path: <linux-kernel+bounces-379063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A79AD926
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99007283203
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC9522EE4;
	Thu, 24 Oct 2024 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FIZYV72Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674DA29
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729732938; cv=none; b=MBDZRZfOupzPZi2rAbFvjaci3nPhqfRdpmWLjM2dWUsuI+5vXnU3dj7j6VmYDMpRzxtOh1WoDnKfBC1h8PkZPf5yZ0nkDnK0kUSQOJTJ/NFsAqkXF+H0RAPFuaYuDmaO6MjtxrFrtKA+qjO2kv4HzHhBR7iJHa+0xPvmnpndIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729732938; c=relaxed/simple;
	bh=oCdhpVoh/SNCNsR3EypH5LjarVuXAX+BjqQknwkXXxw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g6JfC3E4hP3D+9yN70kyVX3imemXIaOLOsXuGaq7QAmNmO/o2Pjs+R19sLEApLffntUhvm/M95VoGr1ycuTBBWrs48xVd6fGus58NzFc2T8hgVIvVehP6l8yWIAgElqPQViL6lfobWtNBmz+fHUzxHjCphwOtbkhjChMOwXCUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FIZYV72Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F86C4CEC6;
	Thu, 24 Oct 2024 01:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729732938;
	bh=oCdhpVoh/SNCNsR3EypH5LjarVuXAX+BjqQknwkXXxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FIZYV72Qor/TzhluoP6m8ZPtQTci4oXMo9aqaHe9N+7RZtEmo7/UFi41TSKi+eqXY
	 lqOuuDO3VjsDI0q96CgcwxPZGpw2dRT7PQoAyTLTvf68sg3+c2TiCyOPGz4FJeMRB7
	 LgyfY9NmdWTyY7okPWVZR/KGcU3jM5uJyv9Fa2Z8=
Date: Wed, 23 Oct 2024 18:22:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, simona.vetter@ffwll.ch,
 felix.kuehling@amd.com, apopple@nvidia.com
Subject: Re: [PATCH v3 1/1] mm/migrate: Add migrate_device_pfns
Message-Id: <20241023182217.147ee87197b53d47057a4c06@linux-foundation.org>
In-Reply-To: <20241023233944.1798835-2-matthew.brost@intel.com>
References: <20241023233944.1798835-1-matthew.brost@intel.com>
	<20241023233944.1798835-2-matthew.brost@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 16:39:43 -0700 Matthew Brost <matthew.brost@intel.com> wrote:

> Part of series [1]. Sending as individual patch ahead of that series as
> this is a prerequisite for merging.

That's news to me - singleton patches are perfectly OK?

On Wed, 23 Oct 2024 16:39:44 -0700 Matthew Brost <matthew.brost@intel.com> wrote:

> Implement migrate_device_pfns to prepare an array of PFNs for migration.
> Handles non-contiguous ranges of device pages that require migration.

OK, that's "what".  We're more interested in "why".

> +EXPORT_SYMBOL(migrate_device_pfns);

And it's exported to modules, which adds to the significance.

Please fully describe the reasons for proposing this change.

