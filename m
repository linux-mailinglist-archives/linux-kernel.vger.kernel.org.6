Return-Path: <linux-kernel+bounces-177282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1AD8C3C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF5B1C21218
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F5147C67;
	Mon, 13 May 2024 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIuPWZJQ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98F71474DB
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586492; cv=none; b=GNoQ84Si4k3aTUywJrAZMBF3NvAYkgFpIpOy34f1rkWLbdZ1sALUD+poR5qfJMaTnibI44lhBc8tYTkSpEfEWvCKPR0gELb60VoB0UkP+fHW0WEbXURr/Zg05VoYZtHhY0wEqAhVQf8Z/GSv0cZ+6MXX0iGU4tQLGKV+qAVaU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586492; c=relaxed/simple;
	bh=8jVy/TnPQCA3n6zHUjHBc8iWECUepeqt2n5/4FS5ocQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NRDBmFsfFMNL41Vq6jFNzVWXBOikI6BOLELRQSK+ht5qN8QBBKoXPuPCr3T2Fn7m2s4EvlNMyUvisJw33HsafzXOo3Sj/w+Ed6ibOnq6A20Wg3vlB3U/6SrN9BShzOyodEVLqWb8EYUmBWs//NN80DdQ/737GZ/RxYqOqjW5le4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIuPWZJQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59b097b202so847424666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715586489; x=1716191289; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=blMhGw3Q5i0qanUdtvDWtendKRKpZYoVzXCsRjPVgQ8=;
        b=XIuPWZJQpnLugGqk0V8b/3N9je7Yg7sBvVxe/KtRGnN7ksVvXDKcgGkUe4HzFGmNP6
         3aVPIIeoteY98+HsFKWhT+8q8/8JUHYKbYIQZ7p4RBHEKFVnClH7D5JHjk114blhxwH0
         5Nwkr6Bmyh13Rxy/zsgV4wZ8rLrPmjyngiF2xUfxclV8NsyDsVmn5vEe2hxRan5+E2tv
         wxdqakFriTGGXlJmASNMqU50izWT36siIJOG1sWgvliL8Sf8Vkec+dn3/9nYaGwgJZFk
         /5VICtFMWzgk+Bzth3GRyzy4ohwuGxfKCIRZAm7OtpmpnjsDHwdOm/WpqEmS5NFTQmlJ
         ECkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586489; x=1716191289;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blMhGw3Q5i0qanUdtvDWtendKRKpZYoVzXCsRjPVgQ8=;
        b=Br6luyLcYyMn9l6uaWNNu2CxgFleaI1t3Js6hJq+9cRvhNTa6ELsgcg2YrK6nz38vk
         o/yn+499XGyjuryycxIVKRdjifDnKSByeZ9d1mAXKU2npCD2OreVYWhh7bWqZv3IbDM3
         Wmb7yZrF3Pg1MsuM/IDsWr0bGoFtxUUc09ICfNc2wTkvcqavJldNItfCQg0wmo3tXyLK
         o+EGSNgER5ndNQ9MlvabdWENH2u1u4GpnEXWPrBp5nYYD6FQFtrlhjhoDuUpAJ9sZoNO
         P6So8y8wo8n6l0M4meXidcFM5f7iT78AXDW/OpBE4sfUJ/1RwVx2WKqzqnVYJuxmKRjC
         CLzw==
X-Gm-Message-State: AOJu0Yx2pavHXa332vNh+L37BstDh1VqPunOeBHJsH/Zv0T1QDRYcb2z
	K2cE02+ot0UJ17vOSmJ97hvwtpLV48b06vDvO7YNBHdVY0XHC1rDBiyAqmca
X-Google-Smtp-Source: AGHT+IGBC5UzRSkynbwPCludUmk0w31BJuPTmpVwqXWq4KE7cKXAWnBEcMrAgs9z6fvEsYpURBAefA==
X-Received: by 2002:a17:906:235b:b0:a59:a532:ed58 with SMTP id a640c23a62f3a-a5a2d55ac04mr538419566b.28.1715586489056;
        Mon, 13 May 2024 00:48:09 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01676sm558889566b.152.2024.05.13.00.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 00:48:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 09:48:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Juergen Gross <jgross@suse.com>
Subject: [GIT PULL] x86/mm changes for v6.10
Message-ID: <ZkHFtnfjXcZQX5ds@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/mm Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2024-05-13

   # HEAD: 5bc8b0f5dac04cd4ebe47f8090a5942f2f2647ef x86/pat: Fix W^X violation false-positives when running as Xen PV guest

x86/mm changes for v6.10:

 - Fix W^X violation check false-positives in the CPA code when running as a Xen PV guest

 - Fix W^X violation warning false-positives in show_fault_oops()

 Thanks,

	Ingo

------------------>
Juergen Gross (4):
      x86/pat: Introduce lookup_address_in_pgd_attr()
      x86/mm: Use lookup_address_in_pgd_attr() in show_fault_oops()
      x86/pat: Restructure _lookup_address_cpa()
      x86/pat: Fix W^X violation false-positives when running as Xen PV guest


 arch/x86/include/asm/pgtable_types.h |  2 ++
 arch/x86/mm/fault.c                  |  7 ++--
 arch/x86/mm/pat/set_memory.c         | 68 ++++++++++++++++++++++++++++--------
 3 files changed, 60 insertions(+), 17 deletions(-)

