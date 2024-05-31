Return-Path: <linux-kernel+bounces-196414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D28D5B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338201C234E6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3724474061;
	Fri, 31 May 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XTQwaxCn"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E517FE
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717141083; cv=none; b=lvR38OqPQoG04x6fE5kImn5GTLqU5CbuAaZsZ9jUdQ1MpZUeVSfHt9koN6JrdYyWVmzw9rbskfKOtl1q/oPibPNYLfbsCrNy0XNs533QDn9/Dh7hmojnDJeNz9NchF0bIBvnKslXGRd3iojXwsYvBDoqL0Gus6fcF2vq3Nu9DIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717141083; c=relaxed/simple;
	bh=gurpvuCLwCCqtr6nGqLjDnMgmJsVS4Q9jJFy/P1qkNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgnCLR2AbDIDdu39cQbsbMgpxcQk5kJ26VwZVwOeGO5UvqWtGLsKSA5OJptUWZ6lV6PHlXHN/CqGiWoBaF/TkxTriF0cwrnypDNasWKDXgbYV7hbjlPjqu5UCdwwIntXw8ynzA94FdyC25XQBqPzquhzC6jJ3nOL4u9yhsdfpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XTQwaxCn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E3F9760005;
	Fri, 31 May 2024 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717141079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NS4LzCN1pO33fpZ0/cCt0rMxXdCH9g78xsvQdKAp8AM=;
	b=XTQwaxCn0byIVdFiZbNzgMkyfVq+zQjfilPyG/z1uAOQ+qaKrx+/YOJ5E1YKBPheD3AC/+
	GRSGyn5ZanSJdM2WNmiNnc9ge9PJ0GURFBNvRAG4OzHOuy5cYcN58PxDXyVHYzdbeORW+I
	cuHDCgMy4DC7zMACjucxk6BupR8HFnsiqK5w9v/+VaskKEOcS6Tcz+MpdDGEZaoJaoObq7
	P0fC+YNbRCoMx+SOvA6jEHj4D2jRsR1dm64VzlpFE8yPB6WFzZ6ufM7y82cXY6Kw5QtQzf
	QuH3OSc0hAZrxLyCJDNxOGe5tDeFvyCYA2ZM+m2af+X7z3L5/C7MYgXu6b5ElQ==
Date: Fri, 31 May 2024 09:37:57 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: core: Make use of device_set_node()
Message-ID: <20240531093757.5e880c09@bootlin.com>
In-Reply-To: <20240530115147.1112498-1-andriy.shevchenko@linux.intel.com>
References: <20240530115147.1112498-1-andriy.shevchenko@linux.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andy,

On Thu, 30 May 2024 14:51:47 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use device_set_node() instead of assigning pdev->dev.of_node
> directly because it also sets the firmware node.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

