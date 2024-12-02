Return-Path: <linux-kernel+bounces-427656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57949E0470
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C548C16B29B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF97A2036E2;
	Mon,  2 Dec 2024 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cgGOUKsW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047D1D90DB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148260; cv=none; b=lQe4t6PjEUzuN9JHi34gmII7qgQj7jHsGj+3ZBDf14DDyZhQJ3GGcYLsKCj3YOSuPBQ8ohyHXPKZzEEIgvxehihTQ2gowWfiklEzQhdWkHGBpzhJpTEHJbodDHb0bsCQX/6CK9UIVT/4vjiEmEfH25JdLQ1tY0RZ29crrcZnnik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148260; c=relaxed/simple;
	bh=z8XjXlfJUDZdUWM8qE+Z3eQnIwTz7N6JY/ALrAB+Jjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur6BkLzBNw48xnIo/7kLla9F5f5Ifp/0kNPD9+2Oocp5TU9qeCviA0Ckrn+bQo7o4lyFI/Y0YlkpZu80unoGs49YRp/V4h2IjdyYwNMgHUZwBXLODun6l7H4UHsH2+Ihsd8GmhNdhhnukrSnqgh94EGUTJDwREKKOcbgcEGe4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cgGOUKsW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733148256;
	bh=z8XjXlfJUDZdUWM8qE+Z3eQnIwTz7N6JY/ALrAB+Jjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgGOUKsWOWIF8R767p+CGGyiuGqgMqbxlMUfZJQUVyXS/+C/Hz1asY5AcNCUOhgfN
	 wqQHhVHLIH0eJDU/IxV9NXzGFj/YVEbMDvFRBL8pCyI14OsOG8XdpHh4h56XsWoyvF
	 dfmoTZ0Gn7q0zEkuE4EEwrmmCYOfOgm50HabVDZ90GKnEz1pI+PKBUtgPec0YSu3uU
	 1GbCQHsG1FLGY/5tGJigkqAQxmQZFw6yS3Ptp/8sQQ7RHJpSk32OKSRUM9DK93stct
	 EbL+EjPXzXHNKFVZS3JUGYiskPlW7QJnHTM3Ok6OLo37ToKKrFKLteMbCjnr6XYsjU
	 YECPvp20IKZXA==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C3FF317E36F7;
	Mon,  2 Dec 2024 15:04:14 +0100 (CET)
Date: Mon, 2 Dec 2024 09:04:12 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH] delay: Fix ndelay() spuriously treated as udelay()
Message-ID: <849adf54-e544-4924-822f-83566421c09f@notapiano>
References: <20241121152931.51884-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121152931.51884-1-frederic@kernel.org>

On Thu, Nov 21, 2024 at 04:29:31PM +0100, Frederic Weisbecker wrote:
> A recent rework on delay functions wrongly ended up calling __udelay()
> instead of __ndelay() for nanosecond delays, increasing those by 1000.
> 
> As a result hangs have been observed on boot
> 
> Restore the right function calls.
> 
> Fixes: 19e2d91d8cb1 ("delay: Rework udelay and ndelay")
> Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

It's possible to boot again on MT8195-Cherry-Tomato with this patch applied on
top of next-20241128.

Thanks,
Nícolas

