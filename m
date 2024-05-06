Return-Path: <linux-kernel+bounces-169712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 171208BCC70
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DBC1F216BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8F3142913;
	Mon,  6 May 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htJZwvNu"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D26CDCE
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992962; cv=none; b=p/2BTOy23r9izAi1QE2CytImc1o21VUF0ZmQaA8SZVGDZZ9wzc1PXKG7GcJUFaDXF13ZNmYkgmBZ0QgWP6+yX3xneLFtCH9yZ1CZ8E09PhTDCeNnAMYO4/dBEp0DoEF7Xe2xwxRao1HKEyaIfDe3d/ZmzoouM22bQ+LkmNkrYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992962; c=relaxed/simple;
	bh=zZngvlqyCL6lt3BJHbdtVUAb7J0Cz0c0iYFpk5DstmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6RhVDrn/yGqwUvMPdpeb9Q6qDYm2ZRbaskcn91S3zScWnAeSrAedX/rQI8e8qHuGs+9A1w67gEBAjm/fHB2hd5d5MxLJU0nBm3DaFWhRPhYH+2egt9HGNvlGfQtihc7JqQqRXA4K3HbdNBek/o9o0UCye+HyVekt4i7IVxfL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htJZwvNu; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f0307322d5so788863a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714992960; x=1715597760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbdkD91gK+weY24QVpNlpFJ35CtXEhcF4iFO2J9YLew=;
        b=htJZwvNuuFYiez8LEEt+8tvirsqIhSEYJ7GmppCy5O+aNf2xUkSDPw8E6rKo95PAYY
         BaUwP6SOhqadYAu986oS+nwyhZ8kMr8KTSPJciC0jPyAxqxNVWeLmigrgyVUHdhIfecy
         V5Rm/fOpKmSHtuqk2AaP1xZBhaEMUcfFLZZs/WM9mrPbwihcRWzRoz7JBxUZg8urU49A
         2zzZ9tfT8vSQfZTfEQs305mhO2yNQJbgwgdcYNZ67wdJp267Yi5JtdHlI3Ci3i1Td5HR
         5obLjqu+ewawfZQ6xpudguOvOnzVJev3fjL4rfBpYYraRLY+elgHTdEMT3UzYL8RrmEw
         YEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714992960; x=1715597760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbdkD91gK+weY24QVpNlpFJ35CtXEhcF4iFO2J9YLew=;
        b=DP08AwGO1B4Vn3m4ujatpEsecNzaji2gk4WtTpvwvwpsju+3N8fE78vElvW0ROenvY
         Vy1twYN2l8/0Z6EVgvshcnjlOI9Qb1FfBUTHN+P1aK9UifevbnJpPxdpMNe553wQzC/e
         OAsnpMmTaQjDPNwWZ/xyvcE8UU4dLrbcPvqOJSIeqTV2KJTl/4gWlpqTFxMjk7G4SWl5
         Kyw6eCDSQlfLi586wCI2FQlBeh4Ux9jfLKwha1tgQia6y6UQ6lIWfvWZaT/PTxX1JYnM
         I+ZAEODM08sO6ljnx91nq5IIpqg1n5ne/3gT+qGX7D/8DG/E03gKGcNl3UqUck7ePDKj
         2pfg==
X-Forwarded-Encrypted: i=1; AJvYcCW7d2m+zs4ogg/zcu2HLa6CmbZN/4mHPBpuumweP36X49yvkgRBqt7ThI6BGWbl/6Awv0sU+vH3L3QMwEcmVN+NcVUIwiqB5ZNkVQWz
X-Gm-Message-State: AOJu0YxnOjcRM7USlZ6rAN9cxPhuwmHRrOjsZC9I4AEa9BH3BQYu3i4o
	CUyzc0oyCoWlhtwDYaU3kliY3hk87oMYrooB2bTHJsuNLqIibG/B
X-Google-Smtp-Source: AGHT+IEAu9yQJXE0rK0WU9nlJugQ/eAbbALbUAv4nS2sFTIVfnfrEXaYEzIA5cWSngvleqfiSt3NwA==
X-Received: by 2002:a05:6870:a10c:b0:239:4a86:bbcd with SMTP id m12-20020a056870a10c00b002394a86bbcdmr12396045oae.3.1714992960430;
        Mon, 06 May 2024 03:56:00 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.242])
        by smtp.gmail.com with ESMTPSA id ge1-20020a056a00838100b006f46eb9d7ffsm2666490pfb.97.2024.05.06.03.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 03:55:59 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: baolin.wang@linux.alibaba.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	hughd@google.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	ying.huang@intel.com,
	ziy@nvidia.com
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
Date: Mon,  6 May 2024 18:54:47 +0800
Message-Id: <20240506105447.1171-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Baolin,

I found a compilation issue that failed one[1] of my configurations
after applying this series. The error message is as follows:

mm/shmem.c: In function ‘shmem_get_unmapped_area’:
/./include/linux/compiler_types.h:460:45: error: call to ‘__compiletime_assert_481’ declared with attribute error: BUILD_BUG failed
        _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                            ^
/./include/linux/compiler_types.h:441:25: note: in definition of macro ‘__compiletime_assert’
                         prefix ## suffix();                             \
                         ^~~~~~
/./include/linux/compiler_types.h:460:9: note: in expansion of macro ‘_compiletime_assert’
        _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        ^~~~~~~~~~~~~~~~~~~
/include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
/include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
                     ^~~~~~~~~~~~~~~~
/include/linux/huge_mm.h:97:28: note: in expansion of macro ‘BUILD_BUG’
 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
                            ^~~~~~~~~
/include/linux/huge_mm.h:104:35: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
 #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
                                   ^~~~~~~~~~~~~~~
mm/shmem.c:2419:36: note: in expansion of macro ‘HPAGE_PMD_SIZE’
        unsigned long hpage_size = HPAGE_PMD_SIZE;
                                   ^~~~~~~~~~~~~~~

It seems like we need to handle the case where CONFIG_PGTABLE_HAS_HUGE_LEAVES
is undefined.

[1] export ARCH=arm64 && make allnoconfig && make olddefconfig && make -j$(nproc)

Thanks,
Lance

