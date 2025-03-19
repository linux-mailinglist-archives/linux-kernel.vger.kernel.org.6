Return-Path: <linux-kernel+bounces-568493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D6FA69648
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA96172099
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0A1E5B84;
	Wed, 19 Mar 2025 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nDcjkp10"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA835942
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404949; cv=none; b=EmDZvDsjDcJbWTDx9G6C/Fn3W90DAQRu5xlRwlUuhL7Tb78sIXvI4MpvVcmsFjga0vawfH1tPeODGf8cAf/407aw1ClXHKew4WEdrpFM0VKE5HRgPjP76tZoZ008DeBAn9T4GKCYirhZow1b4armIjhe+WbTcjL1RDkuumKfu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404949; c=relaxed/simple;
	bh=GdlXrLjIqRHRmMZr9riQZWECKIuymuAngwx+w+PJyy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS+WY2PNIKzJF5iXvPZ7PymU/s029NAS9teDk5CVcP78mCNI15FnVQrcSSTTajdLmekYPGEQ7bJBjTwIGnUCUgkhWtofxNs5tw+iI0V3XOUruWSDP6DQLHyXM8ouVVp/42wf3N+xux5Z+/r/Ni5QxXLmYKrUz8iSL9JoGM6P3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=nDcjkp10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1CAC4CEE4;
	Wed, 19 Mar 2025 17:22:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nDcjkp10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1742404947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XFgAAU4nogsE5+YBKyx7IrTulOkeZwuxSUhDz/b70/U=;
	b=nDcjkp10UBb1nWaIkUR3QipayhqCP7koieFUjzafoRUVW9Uvd9CCOwQSW/T644il4LpoJs
	eUGTFT7CWaCobivuUVtCykx44VzpKdhZFpY58xbeq+hbN3hUu6fjSd3qeAIOf9B7PUiUJM
	1m+DchDfDjIaZPlmIKTasvTTpdAGRwU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f9ef307f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 17:22:26 +0000 (UTC)
Date: Wed, 19 Mar 2025 18:22:23 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: vmgenid: Add Null check for device
Message-ID: <Z9r9T26d7Sk0R9jB@zx2c4.com>
References: <20250313042600.1168619-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313042600.1168619-1-chenyuan0y@gmail.com>

On Wed, Mar 12, 2025 at 11:26:00PM -0500, Chenyuan Yang wrote:
> Not all devices have an ACPI companion fwnode, so device might be NULL.
> This is similar to the commit cd2fd6eab480
> ("platform/x86: int3472: Check for adev == NULL").
> 
> Add a check for device not being set and return -ENODEV in that case to
> avoid a possible NULL pointer deref in vmgenid_add_acpi().

Is this causing a crash on some systems? What's happening here? "Not all
devices" - which ones, and why?

Jason

