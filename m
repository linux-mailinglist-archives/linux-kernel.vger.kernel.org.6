Return-Path: <linux-kernel+bounces-420660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F4B9D80B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAAB280DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC1D18F2DF;
	Mon, 25 Nov 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="agwDQxUW"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041EB188010
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525562; cv=none; b=IMhiwDnjshDuwmKKW+Kd/QUFduELtwZiJOk39tdSNITAfNP8fs6KbzkHaf45IngieMmumkxgdClREieZjXgcC83flwxfFxQRCXka3kwuVWYwPmEpulGEjCeqRgutCQ3tCkFs4hayCqQ8Pk0a3wxbtpCdDrtWulGC89PBlz807Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525562; c=relaxed/simple;
	bh=JWC3XkTd2GO+Ofndu1/y/AaphGVRsS4eMBSmlwpg4Rg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qrfrLwxKf9LpHQuv+hhp23SHUFcDkv6RRHXIF+7tjTaTowrr/6DLEIsUGh5Ibj8CKi2aYUXQUC1UIla8AMR8bH70sQOghYXs/afKY2dQhHywfs1dFhJAcHn84P861YUVM54LdiUgm2CnYeBRPG67smHLZaWa8ur7AxyIynKtokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=agwDQxUW; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:320f:0:640:c550:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 8D8AE60FE5;
	Mon, 25 Nov 2024 12:05:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id n5Tj88fOkeA0-syUcmu4d;
	Mon, 25 Nov 2024 12:05:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732525550; bh=G3hvkv89yjkIHFEK3mF/zabPF5pLMTwnfFXj8Rw+ymM=;
	h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
	b=agwDQxUWJb+FoVOR3X9UVO2q656OrETFGfhsNCjkyqLolNsAywi/rdurFrclELRgM
	 npEcaJbzOtnyht14cQPCVycc5Uw9f7DK0SJMvWn2Nkv9TG+mKFtzJYwg82w/Ww5mJg
	 TMbdOfvDLxqz9aFvgervvNObpuJDIZ2TyHmzYO/8=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <cf4f6457-0aac-47ba-bbe6-ec755c62c4a6@yandex.ru>
Date: Mon, 25 Nov 2024 12:05:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
In-Reply-To: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

23.11.2024 18:13, stsp пишет:
> Hello.
>
> I tried to use userfaultfd and got
> that strange result: when I first do
> UFFDIO_API ioctl with features = 0,
> it succeeds. I check the needed
> features, and they are all in place.
> But on the second step, where I
> request the needed features,
> UFFDIO_API gives -EINVAL no matter
> what features I requested (or even
> set features to 0 again).
With the test patch below, the
problem can be reproduced. All
the code in selftests suggest
that UFFDIO_API should not be
called twice, whereas man page
says this:

```
        After the userfaultfd object is created with userfaultfd(), the 
applica‐
        tion must enable it using the UFFDIO_API ioctl(2) operation. 
This oper‐
        ation allows a two-step handshake between the kernel and user  
space  to
        determine what API version and features the kernel supports, and 
then to
        enable  those  features  user  space wants.
```
But the second part doesn't work and
is never being tested in selftests.
So is this a documentation problem?

This patch can be used to make
sure the second call doesn't work:

--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -171,6 +171,14 @@ static int test_uffd_api(bool use_dev)
                 goto out;
         }

+       /* Request valid feature via UFFDIO_API */
+       uffdio_api.api = UFFD_API;
+       uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+       if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
+               uffd_test_fail("UFFDIO_API should succeed but failed");
+               exit(1);
+       }
+
         uffd_test_pass();
  out:
         close(uffd);

