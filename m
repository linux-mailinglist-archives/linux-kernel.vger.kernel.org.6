Return-Path: <linux-kernel+bounces-189750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB108CF47F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82ED01F21367
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC9168D0;
	Sun, 26 May 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZSqgDlld";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5YvxaNoY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70F171B0
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716733402; cv=none; b=WdvUMXP3HKXoBjMJ0IjzgIMW3fDSvusvEbdbEi9k9I7hGT/eB5e1yn1dZADRHqGMuKEG03hiNNUMBXCAaHuxQRMsc/51etSY9ydhaZRdzDButJ0ZIuD+GShswZGbO7nd4ENHKCI5UyShIUcvVLhkGtN4cRFsPFYWQD9symw1byQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716733402; c=relaxed/simple;
	bh=0Htsacbl71hMZ/JTxhHysgW2DC0GjMffsquDYGrL/oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHj5hPfmZXP7FYDwYYwdCSaP/PhRx1tjY2Qhx/MLcSkwU4izA/MaoNBAtDKA9PiDm/EGIqiYKwWORcP6DLQz7V1P0EPLY1oKmrcXcIX0l6S6CUb8fsGrcZ6GSyv4kWzpWcQFX/sohYgzo2FHE97HdDj6qDO2AX9dFP95Zr9CuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZSqgDlld; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5YvxaNoY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 26 May 2024 16:23:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716733398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnCZ27QyK1irI3tnt2syPDNGF9wfvIINvO/4hdl5qxk=;
	b=ZSqgDlldMYgaRq0ImxIGO8GhOkh2H5EfzkftWY6MUNgx/osEHiJgmrLdPyY2XcLL3q0byq
	gtIF3SAPVCnuAzVyF6XHvxa7DJBSjTs9Ku8wI2qQYT7pMDRhj4pY2w180Ah+FcEHvjw8M8
	FkgvLgLyTuqrgyLoA+/qRTWTpJkfUDmyvMM5WW7cOj+7Nbj9CRPWFQhAGRgbGr0Xa8ejfj
	0EWrRJYXMOjWHB22Hpx8iuGGpkOcyXV9HEZmIT84tKBFwG2eMw5GUvTz3IbovU6jeD+sxZ
	C5RAhff1jQ1wq06Bw3gGOXCure/kmkbtDO82K4d3zIIppo0ZDig1Z87Qo5S84A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716733398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnCZ27QyK1irI3tnt2syPDNGF9wfvIINvO/4hdl5qxk=;
	b=5YvxaNoYNyYciKG2s/KkZerhDtblGES6SSQquaBB7zdwzPPajujWBUhNRw36PPQtQqnlp+
	WpVW1Ap1UN0yw4Ag==
From: Nam Cao <namcao@linutronix.de>
To: Michael Straube <straube.linux@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtl8192e: reduce indentation level
Message-ID: <20240526142311.e1zY6b-Z@linutronix.de>
References: <20240526111928.14574-1-straube.linux@gmail.com>
 <20240526111928.14574-2-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526111928.14574-2-straube.linux@gmail.com>

On Sun, May 26, 2024 at 01:19:26PM +0200, Michael Straube wrote:
> Reduce indentation level in _rtl92e_dm_rx_path_sel_byrssi() by negating
> if statements and use continue in for loops. This way the indentation
> level of the code that is covered by the if checks can be reduced. This
> improves readability and clears two checkpatch warnings.
> 
> WARNING: Too many leading tabs - consider code refactoring
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>

I don't see any functional change. This patch does as described:

Reviewed-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam

