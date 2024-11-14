Return-Path: <linux-kernel+bounces-408816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0B99C83DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB4E28796A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D903B1EBA11;
	Thu, 14 Nov 2024 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GxyE51Eu"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39E17ADE8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568479; cv=none; b=dUDf/T5REXJ2DVsdlV7w6uiFOU89mAfp1uuq0KRGFHW0Y7A9u32zYkuqlg8gHNIXmZa53MgBb/fsuWJVliSYwjwT6WqEemCGDaEzpOt5i+/PauyR03c7BfD7m6HnbrU3WdgNY74TI/5R8eAY63A7kGBle8b2bml8JNaeuC0HuDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568479; c=relaxed/simple;
	bh=WFjLSN0uEoXDoHWxklIpVNGsnMVkNGqmIjBH5NXkjEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bm+Ilxv0KsvAauvpeg64c3T+yKQn0rj9HvStdKAOAPllIfFLJ1ymAmikxYyElBOf8De07RzVEfZpRlG1Sjtp+PSwykITGxDb/dRFjlqGd26eV10KvAEU3vWTTe379RTRTPeaRzVipcD6UpqYauJUPGjnY5wiQJ7BHTREKIN6MSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GxyE51Eu; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76132FF804;
	Thu, 14 Nov 2024 07:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731568474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsDnUfrZgRFjY0UmHDUk9SJkSWvJeDPxPrYP69lT6wc=;
	b=GxyE51EuidCqn2Pdn8OFA7Sg+ji/0pvC1ymekdKgHVmZfvPCiqsiUouuyUi4tsY/fS7vN6
	cVDFaSLazT5yVHbAmh0kHHzGhgyZcEB4FtrRBrO50Fslm44scJDHFVdAfA+ykhXCnptg9j
	BGr7XT76RNrPgGZKZktJDuVVlLeZfPV9QvLhKZ97obQKy+0JyWMvazYCmv61ReV1WRLX7P
	QTvvr4vMHA3k0kdQB/TFuOTzi3YwDEiaWXn8QwzNOqF/026N6sFNf8+jg15XoAuw3nyLS1
	zmtwYNHyvI3M6JektsUL7TL/MBA5fdzQG9MG6bTqVvUZLJwZFijnTmGTeAYtbw==
Date: Thu, 14 Nov 2024 08:14:31 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: cpm1: tsa: switch to
 for_each_available_child_of_node_scoped()
Message-ID: <20241114081431.23296fd9@bootlin.com>
In-Reply-To: <20241002-tsa-scoped-v1-1-ba6a6d657f82@gmail.com>
References: <20241002-tsa-scoped-v1-1-ba6a6d657f82@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Javier,

On Wed, 02 Oct 2024 22:21:51 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The non-scoped variant of this macro turns error-prone as soon as error
> paths are included, because explicit calls to of_node_put() are required
> to avoid leaking memory.
> 
> Using its scoped counterpart simplifies the code by removing the need of
> explicit calls to of_node_put(), as they are automatically triggered as
> soon as the child node goes out of scope. Moreover, it is more robust as
> it accounts for new error paths without having to worry about
> decrementing the object's refcount.
> 
> Note that the device_node is declared within the macro, and its explicit
> declaration can be dropped as well if it is not used anywhere else.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/soc/fsl/qe/tsa.c | 28 ++++------------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

