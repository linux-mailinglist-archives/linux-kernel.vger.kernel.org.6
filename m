Return-Path: <linux-kernel+bounces-187894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBBD8CDA37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FBA1F22387
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D7D762FF;
	Thu, 23 May 2024 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="kEtSnsGq"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F6849C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716490271; cv=none; b=opIOB1X/hA17N5OuF0bqSlIRzTot2vRYB59uxIDqLkUAgQKPjmcFqc3osbIA6vdGAexqDotYVLp7jh25qL2RykXcdDEr4jE6KPLuduTisKcLAA5Qg6xp4a6kmpe76b0+5R0hzSxb8XNpCzSa+v+nl6uFEya9Cw0b8C0zH4ImwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716490271; c=relaxed/simple;
	bh=O69u3F2Eb1LeRS151raa2cfdzD4uRhaGK6UM3e8yASk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mds/dA/G7KXQ5o8Yzp4WB2kC9z22tzPXzgbuughLzlE1EQmQbMcJZ0PqjusnRkO/asDWzECwUfk4vQHV0HQUdKDun0DpzEBzNTC5clozO/UvQj5J4w1DAwBClu+5DqiTlnLu9Kqb15ialdVCMjOBf7K/ohlDgkTVYRy1Uf0Ku7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=kEtSnsGq; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VlcTl6D2Lz9skk;
	Thu, 23 May 2024 20:42:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1716489723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O6sPCZS/YXpZlRbF7103nFwMsqEkLQgp0M11gQENI/E=;
	b=kEtSnsGqACAU3LbLA5VT8wELu43AbLtFiHoWZ19oMgtiEE69VPXf+DiPBBh9wcI1MlQX46
	2LcMrh6gLG5N18HhoVnFo+GFcxW3psbrO6nyZoM0iFbGBEanqBMqO8E7E7qqk5Dy4xrLd7
	X6NQE2zfdFHyv1QelV6vn2qvxVarvo7kRbBsjobR/de4Xz1Uwx+SwDcx6FTpV2uIQQwP+z
	uTLavDc44yN4rPb6Odn+VRcI+PiWwq+212aIPqj7v7p7MaeZjOi9wqHk4tsnaCazfQgMqq
	cjoQiArx2iR0JQx+8EeUyMkh+iOlJ84/PqagYqe6Z8WMAWkOFsPv0sX0E7czLw==
From: Ben Walsh <ben@jubnut.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 "Dustin L. Howett" <dustin@howett.net>, Kieran Levin <ktl@frame.work>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Mario Limonciello
 <mario.limonciello@amd.com>, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] platform/chrome: cros_ec_lpc: Correct ACPI name for
 Framework Laptop
In-Reply-To: <ZkscFnmHeWWma7Nb@google.com>
References: <20240515055631.5775-1-ben@jubnut.com>
 <20240515055631.5775-6-ben@jubnut.com> <ZkscFnmHeWWma7Nb@google.com>
Date: Thu, 23 May 2024 19:42:00 +0100
Message-ID: <87jzjk1ibr.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4VlcTl6D2Lz9skk

Tzung-Bi Shih <tzungbi@kernel.org> writes:

> On Wed, May 15, 2024 at 06:56:30AM +0100, Ben Walsh wrote:
>> Framework Laptops' ACPI exposes the EC as name "PNP0C09". Use this to
>> find the device. This makes it easy to find the AML mutex via the
>> ACPI_COMPANION device.
>>
>> The name "PNP0C09" is part of the ACPI standard, not Chrome-specific,
>> so only recognise the device if the DMI data is recognised too.
>
> I don't quite understand the statement.  Why it needs DMI data?

There are lots of computers with EC chips with ACPI name "PNP0C09"
because it's part of the ACPI standard (for example I have an Intel NUC
with one of these). Most of them don't support the cros_ec protocol, so
the cros_ec driver should ignore these chips. The Framework EC is
unusual in that it's called "PNP0C09" and supports the cros_ec protocol.

Before these patches, the cros_ec code just ignored PNP0C09 because it
wasn't in the match table. The cros_ec_lpc_init logic looked like:

  * dmi_match => ok
  * acpi_name == "GOOG0004" => ok
  * otherwise fail.

After the patch, cros_ec_lpc_init still has this behaviour. We have
"PNP0C09" in the match table so the driver gets hooked up correctly
with the right "ACPI_COMPANION" device, but we don't allow the match
to proceed unless we have the DMI data indicating it's a Framework EC.

>> -	} else if (!cros_ec_lpc_acpi_device_found) {
>> +	} else if (cros_ec_lpc_acpi_device_found <= 0) {
>> +		/* Standard EC "PNP0C09" not supported without DMI data */
>
> Also the way is a bit confusing as "PNP0C09" must be at index 0 in the
> acpi_device_id.

I need some way of saying "will we match PNP0C09?" The table index seems
a simple way of doing it. I could use a strcmp on the table match
instead?

Regarding your other emails, I agree with all your suggestions. Thanks
for reviewing!

