Return-Path: <linux-kernel+bounces-226136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E62913ABC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 15:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAED2B21464
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 13:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6551F17FAD4;
	Sun, 23 Jun 2024 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bena.rocks header.i=@bena.rocks header.b="YOwuYS0H";
	dkim=pass (1024-bit key) header.d=bena.rocks header.i=@bena.rocks header.b="334FGn50"
Received: from insw.cz (mail.insw.cz [83.167.247.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E0C146003
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.167.247.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719147804; cv=none; b=Xl414Boxxi0vVGKStTvH0lnYe8BT84YFbezYLpvEaZwcaeFzJ2X/TZOhKOeoDrbpJ4/+xN/ask/hnNm/y8enxpUsR9+ISVwP3053FHCnwvJJFA+umdUGIQ03QjcBhtTYrj9eFR4xDKq0mXwMKsZ9+vo6GzRau0If3sT0PGaAPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719147804; c=relaxed/simple;
	bh=CYijQfKw6sxo3rxVVGuMozOA7miYk0CuOBZJW4UlfZI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mJNCO3c9fZFwBRprkjhDnzb3l/bxyNn7Fvr4QY1TnxSjvtlTWwaaaoLsYcDqlevyB030Q96OP5loEX9OZTDNeHzfJaAg1YUHnamIjcrwOdyaLGRoArDrbqXf8D+Zds8Rm//Hj+ebu7dUKJ8nDJiJDaEiK9LnYt1KjykYu3+wjpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bena.rocks; spf=pass smtp.mailfrom=bena.rocks; dkim=pass (1024-bit key) header.d=bena.rocks header.i=@bena.rocks header.b=YOwuYS0H; dkim=pass (1024-bit key) header.d=bena.rocks header.i=@bena.rocks header.b=334FGn50; arc=none smtp.client-ip=83.167.247.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bena.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bena.rocks
Received: from localhost (tm-irc.org [127.0.0.1])
	by insw.cz (Postfix) with ESMTP id 476C826E2E479
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:56:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bena.rocks; s=mail;
	t=1719147416; bh=CYijQfKw6sxo3rxVVGuMozOA7miYk0CuOBZJW4UlfZI=;
	h=Date:To:From:Subject;
	b=YOwuYS0HkgZWUMEQhGzP9BviF+MeotVgHQC3ZzfuzQgLDjTbG2Ek9RDAvOxFl3N0m
	 SZs5NZgMxz6cELL/J/4k0efFhbfvZdaM983ul/g5eF8VhBJb8v0Fx7dyYKmaiiAyVX
	 iAq/duysiCPcmx0n+d7e99GKBovwABXLX3gCrGtg=
X-Spam-Flag: NO
X-Spam-Score: -1.201
X-Spam-Level:
Authentication-Results: insw.cz (amavisd-new); dkim=pass (1024-bit key)
	header.d=bena.rocks
Received: from insw.cz ([127.0.0.1])
	by localhost (insw.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30nCMTELDnWw for <linux-kernel@vger.kernel.org>;
	Sun, 23 Jun 2024 14:56:55 +0200 (CEST)
Received: from [192.168.0.45] (ip-78-102-147-178.bb.vodafone.cz [78.102.147.178])
	by insw.cz (Postfix) with ESMTPSA id CFC9A26E2E476
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:56:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bena.rocks; s=mail;
	t=1719147415; bh=CYijQfKw6sxo3rxVVGuMozOA7miYk0CuOBZJW4UlfZI=;
	h=Date:To:From:Subject;
	b=334FGn50OAl+Z21SPEIKFzaHEte1K1Stm9srceM+uGVZd/qOKxDRjW18qCHhrLq4v
	 kFtX0REBlWi66Ws5uY3vWXi6Afirz/IB3at3I5rGA21K48ncXO4qSzaESw0LJHKROh
	 2RWulW4gdTkm7fV7926PXHuATWq7DJv3m9xxSFvI=
Message-ID: <45d9cf65-7d23-475b-83d0-4bf649553b02@bena.rocks>
Date: Sun, 23 Jun 2024 14:56:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: Petr Bena <petr@bena.rocks>
Subject: Why is Dirty and Writeback part of "MemAvailable" in /proc/meminfo?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Apologies if this is already answered somewhere, but quick google search 
returned nothing on-topic:

There is one thing that really puzzles me about /proc/meminfo (and 
subsequently about data reported by all other tools, like free, top etc. 
that take those numbers from same place) - why is "dirty" and 
"writeback" part of "available" memory?

My understanding is that "available" was introduced to confuse less 
users by relatively low amount of "free" memory, which is very often 
occupied by disk and FS caches as it can be dropped almost any time as 
needed, but that's not quite the case with writeback and dirty memory - 
both of them have to be written to the disk first, which is not an 
instant operation, in fact with slow storage it takes some time during 
which memory is unusable, so there is nothing inherently "available" 
about that memory.

If you configure your kernel for aggressive caching and run some large 
IO writing operations, most of your memory is going to be full by dirty 
pages and should some program need to quickly allocate it, it would 
fail, yet /proc/meminfo would be reporting plenty of available memory.

Shouldn't this logic be changed? What's the reasoning behind that?

Thanks


