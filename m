Return-Path: <linux-kernel+bounces-539633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9E8A4A6B5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB033BA1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B461DF26E;
	Fri, 28 Feb 2025 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aofqQntx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01523F380
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786638; cv=none; b=cKKB5/u9DqJb1eGWWB+bmTZsQ6DnPB4GWP8dBfGu+HfoO1y0KNylPs2JF9yH5SNxhAsggZVZzEm1gz8Hz/gtNeR/9bwTGRFfBCMFHyTAOiUsqGXYoa9W1xfRlQsGsKyiTm/9ZJdKPvCCYvTHrc/2J5u4YjTrxIdAnIfVgtj3mSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786638; c=relaxed/simple;
	bh=6LVtN213yQI1YA8Qd45CQJs8jfE44xjMuwqd+2VK1M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlhhMY69hzI3/5Fh7IFDFqOgdC34oNepYXFs3BCilYMz9ppDbruqLYC+qXOc5qi6VwhcUITHLb+XxxBYAGg5fScsvVcQzqaRryU6pnZrE7tW4zZvKUnSBQdHlRNdAZcwV8qR1usjw7UPPgn95RywBYK2Lp/U8IoXMtxFonpGBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aofqQntx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF275C4CED6;
	Fri, 28 Feb 2025 23:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740786638;
	bh=6LVtN213yQI1YA8Qd45CQJs8jfE44xjMuwqd+2VK1M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aofqQntx9PlyxoiqZVoQlBUAAJdtpeJj6jqiKHZim7FBJtzaFHoRVUk9tHy6GPUR7
	 U3QS4CleZy5qIwyoCVvfy27Hh5//9ZbSKHBQ+tVz+maqkfUxiPGuK8er4bDVQ0yEY3
	 TtDxYQrAfJJk+q6EUb4xyzqO2H/vF5hzwejdYO4xgnOtn4DVATAfPX9DXdyo7dq2tB
	 B49LnTp1Jwh6kvdyeGfjJtwaRKlhBledRM+bMMmMVum4hgClyd+sch5AYe6GSvOJJM
	 EjeFh5xjR2P6Tlkjietzou9ZWcXwEJn/vTJn37SS/SN+79VlQaT7I/EWwyZAyVE67L
	 XtTnz9GAuvNog==
Date: Fri, 28 Feb 2025 13:50:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: Andrea Righi <arighi@nvidia.com>, void@manifault.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Add trace point to track sched_ext core
 events
Message-ID: <Z8JLzOBMGvvAtu54@slm.duckdns.org>
References: <20250228085944.19451-1-changwoo@igalia.com>
 <Z8GKCkWNVN_Pbcc0@gpd3>
 <Z8Hy6qu8shpYOR83@slm.duckdns.org>
 <86a6c5c7-47b7-49af-af57-b1d2171ba97c@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a6c5c7-47b7-49af-af57-b1d2171ba97c@igalia.com>

Hello,

On Sat, Mar 01, 2025 at 08:33:36AM +0900, Changwoo Min wrote:
...
> You might have two options here: 1) returning per-CPU event
> counter or 2) returning aggregated event counter. The first opion
> will be fast but less meaningful from user's point of view
> compared to the second option. Assuming the tracepoint are not in
> the hot path, I think the second option will be better choice.
> I will add an @event field and a special version of
> scx_bpf_events() for faster aggregation.

Ah, right, let's forget about printing aggregate for now. That's not
difficult for anyone to find out if necessary after all.

Thanks.

-- 
tejun

