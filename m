Return-Path: <linux-kernel+bounces-199639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1748D8A1A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8392841FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0861386B9;
	Mon,  3 Jun 2024 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="V3qgGZXR"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC23137748
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442789; cv=none; b=FqOVvpQE2YOVGeyiip3DUYIjoBX+qUzPMKm8yDI8LU7QcSkM2UmL+JQjwW8APwNiLDJu8oe8w2+3cYCMEDpkwdNfrMtplluewRFLUoRpXqceShfw4yYBit/KlPPssHJ6e9Da12ptACBvl9XTg+umeM/30OLe1C0EWZr9pDTJExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442789; c=relaxed/simple;
	bh=d0aIKj9hD9AEClfSD2ht6q5cfgkUkDFP5cQwyrie3II=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=btpQtYkVFIzhpqSzkmC/rAAbZStp8/yLM+2sph7ix315M4rgJQ5mXh0heijRMv9D9q9Hs56i1qdhVR3BmpFW4cdfJyp4CaZ7sMMroYKaFwn7orBIyIBLiesbGKgk1+cF+RO3vf2p2Fc/LWpL0BkhlQzKpKaoFU36EjpDJJ+RKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=V3qgGZXR; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VtNxq0SV9z9sQb;
	Mon,  3 Jun 2024 21:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717442783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5XGR3aSMREVjpnJPLS8gCmXguO6yjczNgEYlWmCxUU=;
	b=V3qgGZXR4DEpLmYZq1YGI/CFTPLNLZZZYJXrwhRn8IU/BTLoBnGQ41D8L6rQtDX6hZDm73
	mLISi21yq0bib2XurB7v+2acJJLDzIXgRWatCuPmB9Ukz/6WUZz6uvKdlqJbfMq9nkVpz2
	fAdFH+QmFrB6gWxtJpO8/AwiWJRqnd7MTSgzS0aZLe0A8bm3VlR0mjaPUj+KTPXho8ptv0
	jn0pxU3dTFfPPUctlYjKs1tT9DvKyMrX7OXr6gOZUclHFG1nW6eheXHrohIcSA1pOjWMgp
	A6GCcAiK9kQ/eDUYKfUIbF4qDylMGNH7t894kCQxmdRDwJpO9t2uiQe6Dnix4A==
From: Ben Walsh <ben@jubnut.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 "Dustin L. Howett" <dustin@howett.net>, Kieran Levin <ktl@frame.work>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Mario Limonciello
 <mario.limonciello@amd.com>, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] platform/chrome: cros_ec_lpc: MEC access can
 return error code
In-Reply-To: <Zl2NMG3NdQHPfe7s@google.com>
References: <20240603063834.5580-1-ben@jubnut.com>
 <20240603063834.5580-2-ben@jubnut.com> <Zl2NMG3NdQHPfe7s@google.com>
Date: Mon, 03 Jun 2024 20:26:19 +0100
Message-ID: <87le3l25gk.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tzung-Bi Shih <tzungbi@kernel.org> writes:

> On Mon, Jun 03, 2024 at 07:38:30AM +0100, Ben Walsh wrote:
>> @@ -425,8 +469,8 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>>  	 */
>>  	cros_ec_lpc_ops.read = cros_ec_lpc_mec_read_bytes;
>>  	cros_ec_lpc_ops.write = cros_ec_lpc_mec_write_bytes;
>> -	cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
>> -	if (buf[0] != 'E' || buf[1] != 'C') {
>> +	ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, 2, buf);
>> +	if (ret < 0 || buf[0] != 'E' || buf[1] != 'C') {
>
> Slight concern: if the read failed (-EBUSY, because of the lock contention
> failed for example), does it still need to probe for non-MEC devices?

That's a very good point! Negative ret here means there's really an
error, not just "no MEC".

I think it's better to return early with the return code (not -ENODEV)
in these cases.

>> @@ -436,9 +480,9 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>>  		/* Re-assign read/write operations for the non MEC variant */
>>  		cros_ec_lpc_ops.read = cros_ec_lpc_read_bytes;
>>  		cros_ec_lpc_ops.write = cros_ec_lpc_write_bytes;
>> -		cros_ec_lpc_ops.read(ec_lpc->mmio_memory_base + EC_MEMMAP_ID, 2,
>> -				     buf);
>> -		if (buf[0] != 'E' || buf[1] != 'C') {
>> +		ret = cros_ec_lpc_ops.read(ec_lpc->mmio_memory_base + EC_MEMMAP_ID, 2,
>> +					   buf);
>> +		if (ret < 0 || buf[0] != 'E' || buf[1] != 'C') {
>>  			dev_err(dev, "EC ID not detected\n");
>>  			return -ENODEV;
>
> Similar concern here: should `ret < 0` see as a -ENODEV?

As above, I think it should "return ret".

