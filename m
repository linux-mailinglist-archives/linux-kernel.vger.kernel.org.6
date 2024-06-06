Return-Path: <linux-kernel+bounces-203617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02448FDE1C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C32285500
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22DD38F86;
	Thu,  6 Jun 2024 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="WefO5hWc"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A71754B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651419; cv=none; b=cjI2VmaX0ML1RNXHjXvK8Zo+XLBf2dJhpwnUBxBKrZT0Yipt2ecAUHybtJoFZC8qHt7U33yEeafsDXVaeG4oPanOqBiqcZcwGCj8VzGEArpVROucAYtkpBwRuELM0fLRbcoFE2wOzXo3jvA13VoKgAgHeKcGuKRnv58qHiOh+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651419; c=relaxed/simple;
	bh=jGFDFpw4UEL1HxMSWQ2cgc4Ox2CApc3r211koRhoItA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pU7KKDXO9+st4XJypfDq51M4WQhlgIQaxLSj8iYKQKqOs8S+RZW07sAT5CNWhbZ6BHGRokciSSVHwrtAknlKRHfHDCOwTreRjTDA62CmuyUEZ4sMNaKzat6mL0YczRC/+Y2/jb4gzNqnnNBr+ncUrtkPu3ug9Wz83/Dai+fAUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=WefO5hWc; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Vvt5x5rcsz9sqF;
	Thu,  6 Jun 2024 07:23:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717651413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCj8Hc+utnURtnGsh5wR4++fe9jJCCDRahhFYEREKbQ=;
	b=WefO5hWccRD6DW0SD4+kDwmLugeeSHcmH8p5bOjscZ5C9NG6IsrdB9YY/HtU/8pUO+fjM2
	FIDnxY8krkH9nLMzvHEWyfiyqlWdynIetuBvCJ1O5OAGPIxD2rB2aeOKsenVoo5BRQDwQ0
	hqzAPWMVLHDNKjQHq3SYtoUCqgfKh+65U/Ryhk9L4Cava3mEGTRL7Us09lKrBnfF/TTSiX
	AZH5jTfnU6EERNyaRdIMQvULKEYjUWlvdAiDFxIy2h24CGS1flahzMiHnZ283UnoGS/C1+
	dDCfhkVQNHtxteEpKwUf5AX6TMF/7pqjRZa901/2LEO3jCNAiRklWtnFa1RFFw==
From: Ben Walsh <ben@jubnut.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 "Dustin L. Howett" <dustin@howett.net>, Kieran Levin <ktl@frame.work>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Mario Limonciello
 <mario.limonciello@amd.com>, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] platform/chrome: cros_ec_lpc: MEC access can use
 an AML mutex
In-Reply-To: <ZmEpOQmzFv7Quakq@google.com>
References: <20240605063351.14836-1-ben@jubnut.com>
 <20240605063351.14836-3-ben@jubnut.com> <ZmEpOQmzFv7Quakq@google.com>
Date: Thu, 06 Jun 2024 06:23:30 +0100
Message-ID: <8734pqskz1.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4Vvt5x5rcsz9sqF

Tzung-Bi Shih <tzungbi@kernel.org> writes:

> A nit haven't caught in previous round review:
>
> - `if (ret)` for cros_ec_lpc_mec_lock().
> - `if (ret < 0)` for cros_ec_lpc_mec_unlock().
>
> If I see the inconsistency when reading the code, it would take me further
> cycles for seeking why.  We should fix it.
>
> No need to resend for this; I will fix it for you.

Oh yes. Thanks very much for fixing, and for reviewing!

