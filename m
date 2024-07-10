Return-Path: <linux-kernel+bounces-247757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D0592D425
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC0D1F24331
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBED193465;
	Wed, 10 Jul 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MhkJh7bU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4F119046A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621382; cv=none; b=regvOo8Y3k3RjOEDrHRvbE4Ur9J51E6rV4B+ta9rCX01Y9TByfKtRRGxdRphRbl7NdoMqG7wQp/zZBJ6yqY4y4Z828lHoXoPE+i6Gbr6Gm+4GOLJlY12qComcapwKf9Q9cybp58tdt1BNH7n6QG+FHU33CgBVuW0HwtqnxWvhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621382; c=relaxed/simple;
	bh=p0+EoZLb+ZwsOTVF8E7aiOGT0pHxopGnpdy4Sf0UvpM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=InF8+vnNFOVh1rTY8QFAp5QwFYIYpliG1V3LNsx9gLPB6zSCApuksUPlQhE3/SkR7dfafKp2pKrH5jq9c+Fm/QU+gmvmBMggREuCgqichOOG+hpGVfPXoAaOXWPkK2g3nijE1/NGST93NJ9nGtutgdtvyfnvDQiEm6zuTXB0asc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MhkJh7bU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720621379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0aeBWS3AAsVoK9IvRxT7ZLtZehhCNS8N1P662U6sOik=;
	b=MhkJh7bUXTfP+Oj5vx52yT+u6L/xkqLCaEssRAA5pBs9piFIlXVq1i2rSO/DqT67tUJyb7
	0NM/n+xsCFpYw2SfXHiKpu3liu6jf9mnZe7Olxa8E07cXXWrTi+shqO0Z9hWGjrjF5p9l9
	lbM1CLIPJfPp1bphUNf8KYd498sTAbg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-DwKi0bO9PAemK9EIs6iHTQ-1; Wed, 10 Jul 2024 10:22:58 -0400
X-MC-Unique: DwKi0bO9PAemK9EIs6iHTQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52e9763468aso7448094e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720621376; x=1721226176;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0aeBWS3AAsVoK9IvRxT7ZLtZehhCNS8N1P662U6sOik=;
        b=LMnmVj95CcZvSIilNo55XYIfzxm4rM5pVY14JFoAK/b0krypMyBflEt6mDxqj9GfO2
         plbUtCIQ0BhL+Kos8AnAjjcnZlaurUx7KXLSqh+KnqoDli992udJJv1saexUgf2eYMq0
         Mf3Cl2wBbItI9Pcz1wC8v+OaEfn0N1wuBM5IphFjPIy3C4fbajoZbbLqR9WsLZnQQNxd
         qO1EL0DAwBaiVSaI8RcMBfocNQf9owHGuF3yWL4e6EowYPSly0qbkAIa0FAT7tWoW5yr
         E2RwBybYanNSbTqmHIp4rOPjYynjIQM3p2b8V3nY//NvYP51kWbKf3GebE080Qt9k483
         a67g==
X-Gm-Message-State: AOJu0YyUwxRLzIwtV9yppgjwdvaNiBLjO7/v4Evtb9o+OSaH7LaE7oxo
	HOtrPQbHp9KWUApOk+VpFyCss9JV4qdhdTa6QaU0DL4FYrp/jJc/u4ohbAj/4i112iOLeMBlJIS
	Hzlpdl/1yaBUQV1uUHiAXvsaRj1ko5zGoeMOQHRuIxftp9h86pAQKlZv795bLFw==
X-Received: by 2002:a05:6512:2349:b0:52c:a20e:4da4 with SMTP id 2adb3069b0e04-52eb99d6033mr5542875e87.57.1720621376656;
        Wed, 10 Jul 2024 07:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOf2cWFowYkkgGMGqSxA/m5lpqwUkfnLlyd2jqlVEYpWrczj89+qz7lKFVt10/WOFCvZ85Tw==
X-Received: by 2002:a05:6512:2349:b0:52c:a20e:4da4 with SMTP id 2adb3069b0e04-52eb99d6033mr5542854e87.57.1720621376273;
        Wed, 10 Jul 2024 07:22:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc876sm163398366b.5.2024.07.10.07.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 07:22:55 -0700 (PDT)
Message-ID: <4f4c8c2a-c7ae-46bc-babb-7c6df4501df5@redhat.com>
Date: Wed, 10 Jul 2024 16:22:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.10-6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Obviously I should not have jinxed things by saying that my previous pull-
request would be the last one for 6.10.

So here is one more 6.10 fixes pull-request with a 1 liner fix for
a dmi_system_id array in the toshiba_acpi driver not being terminated
properly. Something which somehow has escaped detection since being
introduced in 2022 until now.

Regards,

Hans


The following changes since commit e527a6127223b644e0a27b44f4b16e16eb6c7f0a:

  platform/x86: toshiba_acpi: Fix quickstart quirk handling (2024-07-02 16:01:45 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-6

for you to fetch changes up to b6e02c6b0377d4339986e07aeb696c632cd392aa:

  platform/x86: toshiba_acpi: Fix array out-of-bounds access (2024-07-10 16:12:12 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.10-6

Highlights:
 -  Fix missing dmi_system_id array termination in toshiba_acpi introduced in 2022

The following is an automated git shortlog grouped by driver:

toshiba_acpi:
 -  Fix array out-of-bounds access

----------------------------------------------------------------
Armin Wolf (1):
      platform/x86: toshiba_acpi: Fix array out-of-bounds access

 drivers/platform/x86/toshiba_acpi.c | 1 +
 1 file changed, 1 insertion(+)


