Return-Path: <linux-kernel+bounces-189018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22F8CE9F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371BF1F24CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A903D966;
	Fri, 24 May 2024 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="0vENYs8N"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70A2E3E9
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575732; cv=none; b=HY+Q6Rc1TeEdW+OLFI1ddym1rMkKp+ORHCE4jz6BUZK037u1zWhymGgoY3L0jVtOekL/UTudSgOoNzpWAcpqxnVju6BvTQpMoNMkgFVtS2j8zEYl15SKek17MR8PXLJ+CopVF9tXS9ekmzXAloMrYqt5IbtvOZ1bublsaPU2sYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575732; c=relaxed/simple;
	bh=KQpJGV/25wbn72h1ki7qnROH25i33ALjY/rSReptIzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N5fOf7454niOEvKditnG6KIjFlULGDE2ZWLKftj4XJaIPJ61LD2vO2kJyj0vn7WSTJn/GWSP4IOcQey0JARkrIcS8paq9Sb4IJfLDfTx6OfOGJQujtcINypAPOyejZDGlp9iRpOixKVpa8szYQzD7YO153zyQtbv++NA8r5zF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=0vENYs8N; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VmDHd3dNkz9sdm;
	Fri, 24 May 2024 20:35:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1716575725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+onRWGzx9O3X9IVjrTQAXaTDxgKaEx/1IU/4Sf9FiTc=;
	b=0vENYs8Nv8g6QD3KYmRexNZz2uNfiIMJz4xdyxs8ef/bks4Sa4N3lcy5XtOrTh4e+wtsrV
	rcBAgzJEGKFUoAScBPxPPk5b9IKRpvzIptGvj+iPaSiTwmV8dk59WLPhu/PYxMCpz0qsjf
	YwgFQB5sIOqIxrxx9ObE3xfzADTjuLUGsmss2+8rUej2tM6kWgyib19/+yjlFW6SOltE5l
	M5XD6bFoJOozaeFsc9gOUsFNDOIDoYkAr7siKlRd92gdoPHEmwdM6EqtJ+oQrlidHiOX+e
	5GAnyEjAXxXgB5a4IsNrz5j0D0s7EomEbwljXNeXEc2MNtSwL6e3V/ADiS41+g==
From: Ben Walsh <ben@jubnut.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 "Dustin L. Howett" <dustin@howett.net>, Kieran Levin <ktl@frame.work>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Mario Limonciello
 <mario.limonciello@amd.com>, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] platform/chrome: cros_ec_lpc: Correct ACPI name for
 Framework Laptop
In-Reply-To: <Zk_63rrDJFhN1Y1q@google.com>
References: <20240515055631.5775-1-ben@jubnut.com>
 <20240515055631.5775-6-ben@jubnut.com> <ZkscFnmHeWWma7Nb@google.com>
 <87jzjk1ibr.fsf@jubnut.com> <Zk_63rrDJFhN1Y1q@google.com>
Date: Fri, 24 May 2024 19:35:22 +0100
Message-ID: <87cypb12j9.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4VmDHd3dNkz9sdm

Tzung-Bi Shih <tzungbi@kernel.org> writes:

> From the context you provided, instead of matching "PNP0C09" in the driver,
> it makes more sense to me (for Framework EC):
>
> * Mainly use DMI match.
> * Add a quirk for looking up (acpi_get_devices()?) and binding
>   (e.g. ACPI_COMPANION_SET()) the `adev` in cros_ec_lpc_probe().

Sorry, I don't think I provided enough context. There is already a
platform device /sys/bus/platform/devices/PNP0C09:00 with a companion
acpi device /sys/bus/acpi/devices/PNP0C09:00. I think it makes sense to
bind the driver to the existing platform device.

I could add a new quirk which provides an alternative ACPI match table
to be used instead of the default. In the default case the match_table
will contain only "GOOG0004" as before. But in the Framework EC case the
match table will be "PNP0C09".

