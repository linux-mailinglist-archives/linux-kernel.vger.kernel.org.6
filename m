Return-Path: <linux-kernel+bounces-213817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 079A9907B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7F71F22FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6848914B06E;
	Thu, 13 Jun 2024 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="vrKjX2D7"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490E1304AB;
	Thu, 13 Jun 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302846; cv=none; b=jpvW0Ccfmtm6Y/tGWCp4ZAA1B9fHDQAob1JOuDgl7DVsMy8cUmWjjVOxoujuNAj50KlEl1OklAUAWdwQtRlxVFcdQeHCCbbQLq3WzvWv7zwRMElwz+eG6MsF0TxJNKggirADnRJS/q+m4WZdfD5WGfo8ZxFRlv+iFuUG/HM5asc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302846; c=relaxed/simple;
	bh=Jxi6LzoxFe6/Es5CcJBHKmyjm00LBf0fWA2mG4F9KIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o34YxeK+p0x07k6v7etUqfYjzqQxO8906k6Uetwjui6h7bQVUZQ9CccdQBggWTA7PxUjDUj6QccJmmGtMycIlmPdVvXM6UYWXUnHJutt2CSdlssfH8zCJwoLYtXA3p/6sBySutRNgYjgeNX1Ol1H+VwbbhT5c5YNLeCWNVAjv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=vrKjX2D7; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W0W1H41MGz9sn0;
	Thu, 13 Jun 2024 20:20:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1718302835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qcl0Kpi8F1Zd6Up/TvPeqT2EByKrLgmAlvLJOXgDFqc=;
	b=vrKjX2D73imzquXM63zrK22tv5b58SivpAeUy0/gNPU1Q2RKzMQhVq7QGAelkO1v94zkBJ
	yxOk2obcqaqk53V4TwBlGS/U2+4rHOlRQjyv97coR0eA8evCrnM38slQxtHg71Vo/w4dtw
	eTGLJO3HlAmhj7Xasi/dqblhBm3E7wMcMOpyhjk3xbk4TKrCumKYfauAcTyQDbl/vax1Pb
	5wz0drQJieiMyctk8UjOOOmakL8I++D9K/oPMoqjDF/VZ2/m0gzT6klraL8il0+ND9SqV7
	9PbvhosGV0otIn4yj8ReB5OTXGDVqpJ6HSNxPpD6rHMW1P7yFCjZP0Usi0VK2A==
From: Ben Walsh <ben@jubnut.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Fix error code in
 cros_ec_lpc_mec_read_bytes()
In-Reply-To: <3226cba0-82c5-47a3-89da-01ffa935a9dc@moroto.mountain>
References: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
 <87sexgrdk4.fsf@jubnut.com>
 <3226cba0-82c5-47a3-89da-01ffa935a9dc@moroto.mountain>
Date: Thu, 13 Jun 2024 19:20:32 +0100
Message-ID: <87sexgaemn.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4W0W1H41MGz9sn0


Dan Carpenter <dan.carpenter@linaro.org> writes:

> On Thu, Jun 13, 2024 at 05:51:39PM +0100, Ben Walsh wrote:
>> 
>> Thanks for fixing this! Unfortunately `in_range` returns -EINVAL if
>> length == 0 (see the definition of `fwk_ec_lpc_mec_in_range`). I'm sure
>> this broke something in my testing, but I can't find what it was now.
>
> I don't think fwk_ec_lpc_mec_in_range() is upstream.  This email is the
> only reference I can find to it on the internet.

Sorry, I mean cros_ec_lpc_mec_in_range().

>  int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length)
>  {
>  	if (length == 0)
> -		return -EINVAL;
> +		return 0;
>  
>  	if (WARN_ON(mec_emi_base == 0 || mec_emi_end == 0))
>  		return -EINVAL;
>
> But I don't like how subtle that is.  Probably adding a check for
> for if (length == 0) to the  to cros_ec_lpc_mec_read_bytes() seems
> like the best option.  I guess option 2 is the best option.

Thanks. I'll check out Tzung-Bi's suggestions as well before we decide.

