Return-Path: <linux-kernel+bounces-334999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8785297DF86
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 01:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A471C20C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B528115380B;
	Sat, 21 Sep 2024 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="QU7L+5Yt";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="FP/AhXTb"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F153365
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726960535; cv=none; b=tH7qAg8ZG6fYp6JnEBrf9kKwrzAJri9dYTmB/U7DZL4uHcf/Q0xZiHddsbdkbKlU4pN2zDMmiG6XxCCnRLeiUQSnveAPS9ivNXRxDGSm2rRpAZlGawCylw1g16rWQwiiqw9fah2Jmchx82mqgoj+bFAmsDBp835HLmoR1E1oSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726960535; c=relaxed/simple;
	bh=BdCHZ4PAVP32GgB5s6IOXQZbkDK93jN9b4wimAr6nhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rifwTHZk5xu/M9WfczWghyBZAydS4tChE1qogxgIdDlFgyEfrET9EFBN2vkyKnCR/9DCzZnwGmyHJb8ubCFj/LjghVzPIx/ZJ9z9+sL8/p4cWy+j5Yjak6eZE4ZQaQGi4ZBli/qU4kxH+Pswq5Mg6suoBL5KweUwhFICWjF/zVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=QU7L+5Yt; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=FP/AhXTb; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=QU7L+5YtvCLNmytvy9JinCNFNEVpxdYjqRcOlChAo+3NsW79F/HxL80hQwZWi3Wv7x0u+eE3jw/y2qKdo4zwl12MREjKrOss9RapaenA4ri2seYF7FDA23/VEWKUpYs4r1sNXnSzLypFPxKJenSWz+bU4KKeNS7SvH6TdeX2HNYZrlj9zjknrmcNNRhRp+VMupE+y/Jk3Pmu4zoK0wcgQ7fwO0NUT4+jyfsNDxb92L0Q1pUfzkTzSakAq5pB1LnLEfMSgfZWSjo/qeXoCNXWKtad89AbVRs6aXvDLEKQuNxIBTn8EbHL8Vgr2TaenLEwStqe6VIpRSzMx8HUC/4PBA==; s=purelymail3; d=lkcamp.dev; v=1; bh=BdCHZ4PAVP32GgB5s6IOXQZbkDK93jN9b4wimAr6nhI=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=FP/AhXTbX/WCQNRDzpYyHUAWH4/vhL8CGjBrL3+XPoE5ct50Jafp/ItX7djP/pUwerpqBkUF3JbJ69ssnVYwjgriAQ50CSQDg9AIKo15/62nNpZCZABpbox9zagaAsZEPriWzSQTVZCU4nmEVJ+tEBV0VtWD7HKH+SyBIjIIS/OUlCKq6m64ZkD5YahAl6AzCcO0R9+GN0KTIK8Z4ChjusTEL1jHr3qSDiFd/TEdNAvKrJKz4QmPWCxtNWFErqNGCe51b0xH9Ei2DWYIQHcPgNLcICT8VdtFDZTCp8VVZybeUfUqpDRPDpEPavouoJL6eULTCgwXg647R0KyiLwoBA==; s=purelymail3; d=purelymail.com; v=1; bh=BdCHZ4PAVP32GgB5s6IOXQZbkDK93jN9b4wimAr6nhI=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1183207272;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 21 Sep 2024 23:15:28 +0000 (UTC)
Message-ID: <04b041a2-d38c-4399-b4a5-1506b5a23e55@lkcamp.dev>
Date: Sat, 21 Sep 2024 20:15:24 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] Add KUnit tests for kfifo
To: Diego Vieira <diego.daniel.professional@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: n@nfraprado.net, andrealmeid@riseup.net, vinicius@nukelet.com,
 ~lkcamp/patches@lists.sr.ht
References: <20240903213649.21467-1-diego.daniel.professional@gmail.com>
Content-Language: en-US
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
In-Reply-To: <20240903213649.21467-1-diego.daniel.professional@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 9/3/24 18:36, Diego Vieira wrote:
> Hi all,
> 
> This is part of a hackathon organized by LKCAMP [1], focused on writing
> tests using KUnit. We reached out a while ago asking for advice on what would
> be a useful contribution [2] and ended up choosing data structures that did
> not yet have tests.
> 
> This patch series depends on the patch that moves the KUnit tests on lib/
> into lib/tests/ [3].
> 
> This patch adds tests for the kfifo data structure, defined in
> include/linux/kfifo.h, and is inspired by the KUnit tests for the doubly
> linked list in lib/tests/list-test.c (previously at lib/list-test.c) [4].
> 
> [1] https://lkcamp.dev/about/
> [2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
> [3] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
> [4] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
> 
> ---
> Changes in v2:
>      - Add MODULE_DESCRIPTION()
>      - Move the tests from lib/kfifo-test.c to lib/tests/kfifo_kunit.c
> 
> Diego Vieira (1):
>    lib/tests/kfifo_kunit.c: add tests for the kfifo structure
> 
>   lib/Kconfig.debug       |  14 +++
>   lib/tests/Makefile      |   1 +
>   lib/tests/kfifo_kunit.c | 224 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 239 insertions(+)
>   create mode 100644 lib/tests/kfifo_kunit.c
> 

Gentle ping, is there any chance could we get some opinions on this? :-)

I know that this patch is quite big, plus LPC just ended and people are 
probably very busy, but we would really appreciate some feedback on this 
one. Thanks in advance!

Vinicius

