Return-Path: <linux-kernel+bounces-174269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0058C0C59
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E971E1F21F86
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C115149DE5;
	Thu,  9 May 2024 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wqz2DLvV"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2814A08F
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242581; cv=none; b=kThB2Of249klWpPKO2fK05bJ6jK1GN+XjkVRmn3GzxKUQdP7vsAI1EPsKoFoFjXOKA/BfbPoY0FK06lMzSSgg8h0XqOHNBK4DcslO8bvMWwx+HAH+Svhi3FZvuO/TdAC0flw2cYNUfKhdDoi4zut3YCsy4nOcw4BQHZg7qKWV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242581; c=relaxed/simple;
	bh=fP267DkIP/myUWdMqJUAbtAyquv8Vz7o0FzzEuCDv5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXxOsKZxUHaqH5A1kUchDY7KH6+rmenOlY+yOjirUEl0Sd+1m3I2YeAkgzDaqTm06XX8Vertu2ufjYccCIC9wQmzXTSHal6b3ghC7wrxyU1Bfv9w6yZvV2sUUSK/PvHZ/btmb2WPCEdoN1XcmTkODRUcS8YajtyJuQli8yr0k0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wqz2DLvV; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95BE960002;
	Thu,  9 May 2024 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715242572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srdbwrmXQ6rD9fDEVis+vK9pkUg2h8unOQKwORt6s6k=;
	b=Wqz2DLvVix20sKlhMnKKl8sK9kTDkD4XB8DYVhHinWfIXvp1bKlFbb9QQJvjAiAIKKkt3t
	nHP3EOC4CWxNl7SorrcvNFYAQ8eK4K0BtwR9+wl2adXUoyNi6PPEJNklCxT2TfYlB5UVOF
	TV+VsI1LhQw4H2nMaPyNZFsgJWMBdT79fiOezFwhWS5PRTv9CdClZnEFz05o0ZhFVdE7lq
	7ElsQgX41q1ORGyoAjrn7jyxvmOzqvUg9CR9Zhik0Y5TiIBAki0XzJPlDDevhG/5mnzLBU
	8PGutuTMsyYTvHPTh4lflLiS9OkCAmwe6l6LxBz6aGwipmRmotDEWxYTlrrvcQ==
Date: Thu, 9 May 2024 10:16:10 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Alexis =?UTF-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>, Konstantin
 Khlebnikov <koct9i@gmail.com>, Sasha Levin <sashal@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] scripts/decode_stacktrace.sh: remove find_module
 recursion and improve error reporting
Message-ID: <20240509101610.5b9dc3a9@booty>
In-Reply-To: <CAE-0n52cX0qhTWdNtJEvy_GUEbXonf9LgmU253Rn8xTehj5OKg@mail.gmail.com>
References: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
	<20240311-decode_stacktrace-find_module-improvements-v1-1-8bea42b421aa@bootlin.com>
	<CAE-0n52cX0qhTWdNtJEvy_GUEbXonf9LgmU253Rn8xTehj5OKg@mail.gmail.com>
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

Hello Stephen,

On Wed, 8 May 2024 17:35:53 -0400
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Luca Ceresoli (2024-03-11 08:24:54)
> > The find_module() function can fail for two reasons:
> >
> >  * the module was not found
> >  * the module was found but without debugging info
> >
> > In both cases the user is reported the same error:
> >
> >    WARNING! Modules path isn't set, but is needed to parse this symbol
> >
> > This is misleading in case the modules path is set correctly.
> >
> > find_module() is currently implemented as a recursive function based on
> > global variables in order to check up to 4 different paths. This is not
> > straightforward to read and even less to modify.
> >
> > Besides, the debuginfod code at the beginning of find_module() is executed
> > identlcally every time the function is entered, i.e. up to 4 times per each  
> 
> s/identlcally/identically/

Well spotted!

Thanks for reviewing, v2 on its way.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

