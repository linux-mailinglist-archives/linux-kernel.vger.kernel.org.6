Return-Path: <linux-kernel+bounces-191313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B48D09B5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64F028233A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680F15F3ED;
	Mon, 27 May 2024 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="m9OAgr6I"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD91D53F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716833209; cv=none; b=ZXHbEdzBHeNcPbe/AFbQRU6Y1UBX6/XHhn2uwVjxfOGkUJY748tOnv45Ldd9IMiea6RUm09n4SzgwNHRcFKzYRLML3JgvcuyblMQXcU2/Jt5NAetFudPszP2Rf8lomtluVVy0OUxoCdYV4RinsxZyTKTeqc8UqZEAbrkZz4Zb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716833209; c=relaxed/simple;
	bh=pzZeJfyni1NMNSarctd7XFqTYT9P+RBcOOvt+eGWGOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TO5xsEY0MVcMVsGRGVbREECOIYQnjIQvloNn+d153vYLZLERrepJB12r64oIjJ5vujQBovDEG+VxvFy7088Elm9F6GOeyH8/4uk2xFOkBljdgffQJVYJGAkRV3uMM7d4xqLm6oIRHbSL2JBlg7hHqWDQIH5KDpxmgkHk8RhXsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=m9OAgr6I; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vp3W71TQtz9sS4;
	Mon, 27 May 2024 20:06:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1716833203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dRJfzl+erb4rP0hvVohvOtSHuuZdGY2XJTVv3TRXHpw=;
	b=m9OAgr6I2btEfKm+dEm4KPEFkDsJQk3ETNE69MsZ4cXYyp4S31oODCR+g0zBWrfKx/eIDC
	G52/WLXF575JUJH6bP8c6qz0JPCi/dxVGLyX+JVurdzsQqmUNNRPFe9f40VgyQwC0nStp8
	Vu7gZAoezq5hGQe0XUaDkCdN4Ly+uKezDu8AltOo0QR26gJv27+Hi5pr1ldoUZK3n0l+mR
	z3VVV38XMLmARwzDojgg8lQ9RNFC+n1sgxaF6+r9QBC6N9qal0bkucfsOmoxTbtQ1nj6Su
	hPaf8VeYbLxnpkcVdWbzvAa8K2PkGah2nri/ValvbCP6qsyg5eZp3CIn6oxrlw==
From: Ben Walsh <ben@jubnut.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 "Dustin L. Howett" <dustin@howett.net>, Kieran Levin <ktl@frame.work>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Mario Limonciello
 <mario.limonciello@amd.com>, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] platform/chrome: cros_ec_lpc: Correct ACPI name for
 Framework Laptop
In-Reply-To: <ZlKPwlF86Oe8OPK9@google.com>
References: <20240515055631.5775-1-ben@jubnut.com>
 <20240515055631.5775-6-ben@jubnut.com> <ZkscFnmHeWWma7Nb@google.com>
 <87jzjk1ibr.fsf@jubnut.com> <Zk_63rrDJFhN1Y1q@google.com>
 <87cypb12j9.fsf@jubnut.com> <ZlKPwlF86Oe8OPK9@google.com>
Date: Mon, 27 May 2024 19:06:40 +0100
Message-ID: <877cff2kpb.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4Vp3W71TQtz9sS4

Tzung-Bi Shih <tzungbi@kernel.org> writes:

> On Fri, May 24, 2024 at 07:35:22PM +0100, Ben Walsh wrote:

>> I could add a new quirk which provides an alternative ACPI match table
>> to be used instead of the default. In the default case the match_table
>> will contain only "GOOG0004" as before. But in the Framework EC case the
>> match table will be "PNP0C09".
>
> I think it doesn't work as the current quirk is handling in
> cros_ec_lpc_probe() which is after matching.

I was thinking of a new quirk called CROS_EC_LPC_QUIRK_ACPI_MATCH, and
putting it in cros_ec_lpc_init(), not cros_ec_lpc_probe(). Do we have to
do all quirk handling in cros_ec_lpc_probe()?

> My original idea: would it be possible to get the `adev` in cros_ec_lpc_probe()
> via any lookup API?  If yes, it could still use DMI match and get `adev` if
> required.

That works; I've tested it.

In this scenario we're not using the existing PNP0C09 platform device,
which means I can't look at
/sys/bus/acpi/devices/PNP0C09\:00/physical_node/driver and see the
driver. Is this OK?

(Note that ACPI_COMPANION_SET() doesn't fix this. You can use
acpi_bind_one() but that seems more like internal plumbing).

