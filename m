Return-Path: <linux-kernel+bounces-298504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C788E95C82D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDD21F22370
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEC61448ED;
	Fri, 23 Aug 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DS3NeA/+"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348F13D8A0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402159; cv=none; b=Qv4kw8jbtGtYW4PzgABCyvTNInme2IuX/SaF4ZpLlHodDchHxcSiUp+nV1STS4iJdqxe+YRPjvA7vexyoBhVtuPEMC6eYpRZrdTqN4F1INoensAMKqXxawO4LqoCM8y9sYNguxBZKw2Hc5IwlZLCNdOX1bCrr/h478P2I1pFo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402159; c=relaxed/simple;
	bh=SSJdcWWvkcJaYPpmg4+oAElFniyUTBrn36sBIM6Za64=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWOqwg6+fBcawaT23HzFfpXBucopx7j/Xp9ua2D6PQpWzH3C/8nyE9vZdT5Z9T/codrZDnE1n52q/6SEZO1jt4S3OF+JqU3cgF0VWS8KAP60jmptT2GTDBbYyMRrxKw02shK4+VvHvv5dKBQiiE2OstmKcMVEK1Q7gZmLoM2Xbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DS3NeA/+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34AC560004;
	Fri, 23 Aug 2024 08:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724402155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69yO0C3tHsQIwCW2Bx30gkmE6b4zJjcYJ2tGj3jy7us=;
	b=DS3NeA/+RXH5ymTR+N16n0aPz/KsQymvX1ECDmzkbMlden4DL9UHtkxXmRVUqAZiV4jkH7
	ogj+X6zeFazQYIYjMYt4gjgt65WH8fK25uX9zBOOsJfvKs2Kj+pDy+wjBlGjD7jDFNvQo0
	ELKPiJCk2ZQt+iHkiWL7hJyO3D5CpDHAGyrOxjEK8rFsKxzfS6rKqbWmTGLsBRVyCaCKw4
	MB/b4jd5diTbGNJjsWGmX+whFZ61ylhC+ohQJirQtzSwr2jBtrwTGC6wUHyFbmiC9+XC87
	hMeIHdKg4npCLcH5x1b6DBR+5q6tRF899JuxUWm+8n37RHQLvP2TDl9se5xMCQ==
Date: Fri, 23 Aug 2024 10:35:54 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>, Stephen Boyd
 <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, Alexis
 =?UTF-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND v2 0/3] scripts/decode_stacktrace.sh: improve
 error reporting and usability
Message-ID: <20240823103554.3d9b77c6@booty>
In-Reply-To: <20240823-decode_stacktrace-find_module-improvements-v2-0-d7a57d35558b@bootlin.com>
References: <20240823-decode_stacktrace-find_module-improvements-v2-0-d7a57d35558b@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello,

On Fri, 23 Aug 2024 10:27:41 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> This small series improves usability of scripts/decode_stacktrace.sh by
> improving the usage text and correctly reporting when modules are built
> without debugging symbols.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Initial submission of v2, May 2024:
https://lore.kernel.org/all/20240509-decode_stacktrace-find_module-improvements-v2-0-887fb6d5acb9@bootlin.com/

Had no replies, assuming it got forgotten.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

