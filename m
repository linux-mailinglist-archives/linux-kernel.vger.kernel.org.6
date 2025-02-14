Return-Path: <linux-kernel+bounces-515386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6333A36435
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F43AA885
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA6267F7A;
	Fri, 14 Feb 2025 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcPTIBbj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E517B401
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553361; cv=none; b=b0qzUiNiCISbmxjeHBG4B4SfyK/CnBr2WNmLk/1C16PBLzzTZC9sM5dmccJa/al1S8t+WHXoYguXxHPDN3wxzFR7feUi1PjPXOHY9KWoSlnWuSV7OcJNEqGlUrf1+AWxupMccoohDei1qMpHev0NiJ0lFC2/0QJ47sYGs4h+lkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553361; c=relaxed/simple;
	bh=KZGoeHnmw/yKfWOv7ZM+YYJzQUs0bcPo1sbPgWXwOoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLzGsDw7EAVrJLwEr9NglUqKWzqZRzfdfuPdbtmgnwkzWxyLRPTJN/pw+TRsZtxK3EcSpXxDIo4AovZeCeU4tbUwydGe2ybMWRdsU2ka8IieV1gsRsWG/FCKSpHuA9ia5E/StW7v7oxVNIPkpr79BCWgNI/o/GgaKR0Z18rwgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcPTIBbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B947C4CED1;
	Fri, 14 Feb 2025 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739553360;
	bh=KZGoeHnmw/yKfWOv7ZM+YYJzQUs0bcPo1sbPgWXwOoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcPTIBbjstkv5qTYEbpsWQutE/cZ8FB5qnyX33vJjONBsLl9XEEfyxXZKBqFWlWOK
	 zC4OBtux4LR50qXr0Ol2W8B5ZDvWj++hGZQQifGZlHmsX40SoU9YZprCAVfJDb8Dhf
	 mXXErzaCGvFfVszjVV6XKd0JVYr02w2LI6RhmWFQSUp45YyPsYK+jFMAHK9hTbXpyd
	 z5poKGEBaNTm6g86ty4498vHTOBnduTgQRl6HBQFOdZM7HaBbfD+WPuJBXEE20NATZ
	 j48nzoRzJ0yNev/bbW6pBzcNeNjHD40q4bnIEABGYvMIxJDVdh4Raxbhp0dKF4N00f
	 7zyXHqra3B5IQ==
Date: Fri, 14 Feb 2025 07:15:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Provides a sysfs 'events' to expose core
 event counters
Message-ID: <Z696T34WYUQkJpa7@slm.duckdns.org>
References: <20250214095736.76693-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214095736.76693-1-changwoo@igalia.com>

On Fri, Feb 14, 2025 at 06:57:36PM +0900, Changwoo Min wrote:
> Add a sysfs entry at /sys/kernel/sched_ext/root/events to expose core
> event counters through the files system interface. Each line of the file
> shows the event name and its counter value.
> 
> In addition, the format of scx_dump_event() is adjusted as the event name
> gets longer.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>

Applied to sched_ext/for-6.15.

Thanks.

-- 
tejun

