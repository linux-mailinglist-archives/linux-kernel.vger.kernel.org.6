Return-Path: <linux-kernel+bounces-172206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F48B8BEEB1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17551C22D91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BB173527;
	Tue,  7 May 2024 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IVfcP88o"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF271B5C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116270; cv=none; b=r4GPHQvisAuXLYD5Pp0lPHvG1XXh304CO/uKj4PUVIDOwrWwoAiQvh7oyrOP1N4CBgXIGy5zvMSrtmxQNeGe1ZVz0djIgUU1TpjqvTtreiAPGZriyitWv2GpartSkL7lDK8zxqXc/penmGGwRXufTDRxyOHPf31OpqaVYqkps4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116270; c=relaxed/simple;
	bh=BW3xQ118lEJ2aa9gawOGG8xw8EFZVAp1SgnK+EUuTEs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnBzhf9Qgc4+3pdkmCb+8vfETTM8mvHiGzuuHBA6gmSY6s/7D4xzh9SisY5ANT0noAlzGi8H8EbMztqQdQcciSh5buOtBOnZwD+vw1Z8viBg0GobFAJ3DpshPqKFXe0ogpq/9y8E0aWZuHpoBUULgVebdhPDkHZzDB3vv+bgxU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IVfcP88o; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0729960002;
	Tue,  7 May 2024 21:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715116261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5ESSq2KvVPjsczAzIek0MhPysf96aqW+AbR1LnQtbk=;
	b=IVfcP88oUmXZ8dc9xbws7gHBC9icllDkT+qcUcu4ioKYoRMqRonFAMmkazSPBz/zfP3HdW
	LiZnpfi86Cweu+gNAT0CrJm3p2PgmZB4Wqdy2KA7gdI0wGD6FXVnNhfF6HEEMD8wU5/quD
	EtP71A33Xppe37v/RC3uzep6U/LmXQ2NH+B4lT/Mv9h1HzVhZ6u51GHQodbWMG9wSh93Am
	66T2jCo0CBj5O6l5AjnYOXvWzoViMALN3xhuXn4JAYWnJb+o9//shA2I0ZF7rGkvkbobRd
	brAwO3jHufNYYTPsa45tEUaIo99cHx1tApIyX1b3ShfzdKEwjkMakyCRWWJa7Q==
Date: Tue, 7 May 2024 23:10:57 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: dylan_hung@aspeedtech.com, gustavoars@kernel.org, keescook@chromium.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH] i3c: dw: Add hot-join support.
Message-ID: <171511624412.989201.16500909870135488623.b4-ty@bootlin.com>
References: <20240429073624.256830-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429073624.256830-1-billy_tsai@aspeedtech.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 29 Apr 2024 15:36:24 +0800, Billy Tsai wrote:
> Add hot-join support for dw i3c master controller.
> By default, the hot-join acknowledgment is disabled, and the hardware will
> automatically send the DISEC CCC when it receives the hot-join request.
> Users can use the sys entry to enable it.
> 
> 

Applied, thanks!

[1/1] i3c: dw: Add hot-join support.
      https://git.kernel.org/abelloni/c/acec16dbb338

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

