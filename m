Return-Path: <linux-kernel+bounces-237720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CE923D22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2DA281104
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1E815CD75;
	Tue,  2 Jul 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NM7Nr6ER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98971C686
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921848; cv=none; b=jaCsXHeyIhS6twO6HNz8eRWbfDkijRxGneT9fcU5ZLCmDPwlTXOmTAy56szZJ7jzIo5T6MogagYBZDxC8nv3JwFSO1N8SR3Hdh3FShr1fli0pwd7ZAAkle4Kro+PNRSovv/8Qg6BgfruugGLXzms/G/evLve5haPe/xqTK0Ef54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921848; c=relaxed/simple;
	bh=U6k8vxYF1WQP7pgl6xyCEmERDtMiGkz6FFV4EynGhGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB8dOh+zBSxBkXMGl/DTomrZbq2QXIrkaaC7SeZ2jOWolfvoxylXlzPMPLV+ii5D4B1m45sgfL0LMT3MK2F7sqD516iR6wkdLPZWceZ8moAL8ArFVLZb9JD0m0gOMz/RQuvKAtBz05/J03FddCdEB/mNUD0uCXk154JN5WjdxG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NM7Nr6ER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D03AC116B1;
	Tue,  2 Jul 2024 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719921848;
	bh=U6k8vxYF1WQP7pgl6xyCEmERDtMiGkz6FFV4EynGhGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NM7Nr6ERvIfvMKmXwK5HRhN/eSBjfJJO0Je2geKQarmSq0axS+TJXPttHFFECbWWp
	 9vlFyKZoM9kMJw9I2ZFJlD42pRqDB3SVZxNTi+6SpQZqgpClKOkZP5Qd4biCQmOLQg
	 cLNhmmvYqHKOL+zjHP2wI6B4tgyGeQU2ZpJhCTHHWiFKS4Ht98ZWMw0cuSS9k0tS5X
	 uJOkyUAeGs+6jkMZ85ZRYudUQjPZ/vvf8jUtBHHmj+r3fRQiPFj9AQy1jNdwOO/eQO
	 FyySm0G5VJzmd40/B4S7Qul2V1JL/FuQ1SJD+v3/1axqrSS6gSe1JBYfygUjFMUVFx
	 QzYTklqX6yv4w==
Date: Tue, 2 Jul 2024 14:04:05 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] timers/migration: Read childmask and parent
 pointer in a single place
Message-ID: <ZoPstQRns3wl4Bf7@localhost.localdomain>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
 <20240701-tmigr-fixes-v3-5-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701-tmigr-fixes-v3-5-25cd5de318fb@linutronix.de>

Le Mon, Jul 01, 2024 at 12:18:41PM +0200, Anna-Maria Behnsen a écrit :
> Reading the childmask and parent pointer is required when propagating
> changes through the hierarchy. At the moment this reads are spread all over

*these

> the place which makes it harder to follow.
> 
> Move those reads to a single place to keep code clean.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

