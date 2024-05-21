Return-Path: <linux-kernel+bounces-184501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E568CA79A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BD11F22871
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AA2405E6;
	Tue, 21 May 2024 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hdr1VATd"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF04256A;
	Tue, 21 May 2024 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716268620; cv=none; b=LwlXm5gWZAXmkgRxeGfXGJNkyak0AOI39+P9O6hSNW+yRDEtGL/P06pZSshzA3LHxYijjFvrpypcMOkbDePWm5ZFAvL7ObZUJnnJBPaAoIjuZE7VTZngm3s+MnPBXPO1YJUisHGqC7+5xBFznspnjmhjnBr3jHcH1fdC142zxxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716268620; c=relaxed/simple;
	bh=/s6qGPTiO3NdFoPJ8/vp10uRHmTzmRiDeMvPwnZ8c5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4i9xNcKrJBO4hn8MWsSiq1KkOyyP19ieDLCM9ikauqSo4no0gsNGYfwcgKfJn5FOhuAZ3SmhPZhKBerf+XYpg8i/+TOFEU7TOPJ/0TD6a+MVUJo0VXFqAQK/42MpA+WIOyzIO01nBciMcN7BY5BxINYNj6knV7+7EfV0AfFqiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hdr1VATd; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716268594; x=1716873394; i=markus.elfring@web.de;
	bh=hgUwu3svSa/mKw/B4ZxaOIDnZq+qTy2nIfXUeSQJiaw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hdr1VATdqSfzqdqxwbRX6qFA7xw6+YPfKYJY39hNnw1C9+FhJfxLSaJw18zxGScm
	 8ouY2p3XlX3q4ad3eT1kFSfbiRwFfF4HeeL5dseJF+8fB6MTfD1C0xoOsFThqC/Ws
	 B7kBY3L3MxSSKVsYlMwtdqO8+BGNRNcKK7N44agWCWt/pQUgX3v4F5i3a9a5QiFuc
	 aiTQHpXzSrlX/vyjYLlHpox8JhKoGik2LiJduA/3FGkLZVpX6wpXmRE5wESNhaNmG
	 amCWJcwe0Fc91MHCFGngIWsWzwVCB9nw6uu4J3zpk6fU8iNq1b6IpSflxUs1RIM+l
	 VrARuW8i8nfkW7uqhw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mr7eu-1svFS813mI-00oDwt; Tue, 21
 May 2024 07:16:34 +0200
Message-ID: <51368bcf-d2e3-42cc-a112-a1a485f29c73@web.de>
Date: Tue, 21 May 2024 07:15:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
To: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 platform-driver-x86@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Dan Carpenter <error27@gmail.com>
References: <20240517144946.289615-1-harshit.m.mogalapalli@oracle.com>
 <d5203ff5-8ed4-48ea-8e58-a2e6680b0542@web.de>
 <6d1bf351-77cc-7fe9-2d62-8bd99789e4f1@linux.intel.com>
 <d73fe99b-dea3-4792-aa1c-c3317f296003@web.de>
 <5287fc2e-91c5-442b-b66c-6eb1fe334ce4@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5287fc2e-91c5-442b-b66c-6eb1fe334ce4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t7NUvlE8czJwXU7Bpl/yyyB58A8Ut98ImsBGm7E04hmHCtuNbgN
 4MfJyi7qJtSUk0liZMfMjfw4Nd5s4AicD223LMbmD5W4p5lUd5JmAvCncdA+rfArMB09bId
 cTNdTWZdc6qKrIszMGzQfMpTWWW7SW95S1iORJdhQHpRvHFBQC70VKfnJMKQZCWyy1OypSB
 ND0a0yhmys61uVMfFKurw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7edThkPRkf0=;g2aiRURtDsylLBOGFMPs2cSvVjE
 ZmTdV8DCJsVx1y9cVHUz3zWOexys94PikniTlsZUQ4eR7TzrmHEkYX1hhXvg4jom8OtgnSRa0
 KJpz8ZfFUTrAU3fsCD17O39noWsaRuJDOoYBuYCCHms/mbbNWsVgEgBtzolbaKh3dT8eTLrpf
 hHhEKIW4D8Th2+L8n23qPFLz2+mmFyINzsHSmqUk16Jqz+8y7Zlgfrn3q1Xsx5hDyfKaNcAiE
 HDrDLfnrlVTkmnntGfXUOi9XgowS8tgm4nxwGsamu28EhbUeL2unigRYhddRo9a/BoP0suipY
 vYRvZ1IIccAPPieCNx/DTeodVUthcbm0EQsvk43zQK1mJyFMDijaTFvCKjso+q6bQV/14Ef5b
 ACjCPiZWeekFYny6rCKcyrlYS34bRZInaHtDafe5zdKKOVDBqlK2DgqrrC5ZPr/k/+kUHmasy
 BtCSlnI5Zl38JdylnwaUUG8/LSgj2Z4n3VSWXmwJ1GwIyZsmLbItjWP1TIWr7+DaUqlqsXpdD
 v5LXAfD3kxP0VUMhuStuixaE+G2qXQbLsQt7/xpRN7sHNh3PpyU9WSuhs+JmY7xC7maPkMyet
 EuNNFbOQa8j0JHrb5ubx28yV0EwmaSL9GkM5VH5YGbFA9gLXpgthru7e0HkYLIQBlx5GB02vk
 RXKyBuP+35V2Q+aCW6twP45h6E3lZl5EOtCMyM7TQIIlefKDqKR2zkvnxibfpLEA9CB2vMSEq
 vY+spUyfjK5avAgiS+F5St/YuCyL8UokdKVAhIgtwG4CD7aRltzP2BV4l4g99Dtm4y1MeAjNh
 TNVxgpQqWdCVhcQGkB+w+cmAnwAoWCqmL3Xuzfa9sb+vM=

>>>> =E2=80=A6
>>>>> Fix this by reordering the kfree() post the dereference.
=E2=80=A6
> The original wording of the commit message really is fine as is,
> I see no need for Harshit to send a new version and I plan to
> merge this as is.

Are there opportunities remaining to improve the discussed wording?

1. https://en.wiktionary.org/wiki/post#Etymology_1

2. https://en.wiktionary.org/wiki/reorder

3. Function call indication?
   https://elixir.bootlin.com/linux/v6.9.1/source/mm/slub.c#L4371

4. Rephrasing of =E2=80=9CFix this by =E2=80=A6=E2=80=9D?

5. https://en.wikipedia.org/wiki/Dangling_pointer#Cause_of_dangling_pointe=
rs

6. https://wiki.sei.cmu.edu/confluence/display/c/MEM30-C.+Do+not+access+fr=
eed+memory#MEM30C.Donotaccessfreedmemory-AutomatedDetection

7. https://en.wikipedia.org/wiki/Code_sanitizer#KernelAddressSanitizer


Regards,
Markus

