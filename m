Return-Path: <linux-kernel+bounces-337692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703F3984DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995001C22FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F011474A5;
	Tue, 24 Sep 2024 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EC7bZf21"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07612E1C2
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216707; cv=none; b=dEzerXefAq/83K+JQCRYOo+flSOhXRcNMgaE//tZCQyaKRnrIiFkjHX0qEkunowOxnK1yuWKMiDu9aeHZilqv9qUyAtLd/7EwBTS+bS7RwYxOd5Hz5hOCF+V+5Vj5UH65TyuHTzgAdf+l0YfuvsvmCGnINHfIUXIkt2KhdtqiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216707; c=relaxed/simple;
	bh=NolPYPz09tShGzdLd/6zke2vJRGx7oTeN1mC/Y2qbpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpWmAkJhS+x0JblhjJjuIKBF5fgqk8yBn9g5kz/AoLbkLaRZVJ04u00l0kO4afu2pZ7DWlb1Lhv/YT/xCDm1uSXXhVlr8CLe0nyChqMi9IzxW2wA2n6WqHyuIC5GXWX1e1GI83jmq+fpECgP16LeMwHBIZliFPVkm2hbJ2m45JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EC7bZf21; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so893852766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727216704; x=1727821504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WesIl88BNTW+mHmunHUki38RltYdnZpJB4vIfDMtZWI=;
        b=EC7bZf21/o52o/96+k/IPoGThk+iiqMeRbKPunZlse78rUYGU1Dwj0Hr97P8MMVqYg
         zZq57K53FL7vVxDvXenKX/PF5eUFY9Pk5BXCXXBpALgHOOc1KBWMjkgMykVNWRK9Thpw
         ye9CN4T5Re+UoROBaX6MWAKqzkCYaXMAK2g8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727216704; x=1727821504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WesIl88BNTW+mHmunHUki38RltYdnZpJB4vIfDMtZWI=;
        b=uy97nP2k1M2wbl+8bm1S+K9HV4MSql4abJGfMi76QqY5XnqZ2hdG+GMdgyeD0JgvC2
         9InjgvtviGH3UOrb/nWofc1ODp3QaKM+VodQtifXpYOPcSEZ36wdqqrVh/fkO4AQVooH
         uI8zu+o/WY8L1QzTZVsrQxDXQhOtoTX0DmDf2sM/4A6o6orDqnARHkTntBuqexHoLToy
         WFNFvu4lt+MZVSjSsdE2L8R9wtHQuvL2HXCxitPFB6z4QYaHlw73jtYvMatHwd0QPD0H
         pz8A4+lT4puG9NaFF/UCEig6eWdEf4QurTYEcweMqZbWhr0LtaBQrbA0iBgGKQjdNAUq
         UzCg==
X-Forwarded-Encrypted: i=1; AJvYcCWCxeEfOuLx849AcSiIZTAK+c7YcMOFTCWaRLU+MYO/tnzyDG7w8fX9ywbWz709svr2Z/oSTPgTVJiTryQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9OyEVvqtyclm6qK+ybWiF0Aq6u5uWnCdduFDlyfnMRy6+PHWQ
	W9rXZov1kpe5Nh0sXoIZXS7EB83iBU6UJESvlwpQo/ulZR6MhM6chJeipSv6wiJ6kvXAebTQQ3w
	JeA3w7w==
X-Google-Smtp-Source: AGHT+IEk9VDff3lKRxaN7I5B1q7NHmxwXji6EBag+rlj88Z/DyGlUObqyVjrcBfhfP0p/RCOCerwGw==
X-Received: by 2002:a17:907:d05:b0:a86:96ca:7f54 with SMTP id a640c23a62f3a-a93a038408emr55107666b.21.1727216703887;
        Tue, 24 Sep 2024 15:25:03 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cb0e7sm139690966b.103.2024.09.24.15.25.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 15:25:03 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d43657255so936369666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:25:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSw3OBmOH8lo4l1cnWb8dDEYDqZLCqeFoghpwtNcXRz+LlLi06ewDQvanefqQiSyt8k4lIxasDolwV2xI=@vger.kernel.org
X-Received: by 2002:a17:906:dc95:b0:a86:81b8:543f with SMTP id
 a640c23a62f3a-a93a06c61ffmr54421566b.64.1727216702945; Tue, 24 Sep 2024
 15:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZvInHczHWvWeXEoF@google.com>
In-Reply-To: <ZvInHczHWvWeXEoF@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 15:24:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=dvXyr8b5Z1cYLa-A=-JpYVpJ854UMvftE2gaK==GMg@mail.gmail.com>
Message-ID: <CAHk-=wi=dvXyr8b5Z1cYLa-A=-JpYVpJ854UMvftE2gaK==GMg@mail.gmail.com>
Subject: Re: [GIT PULL] f2fs for 6.12-rc1
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 19:42, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> In this series, the main changes include 1) converting major IO paths to use
> folio, and 2) adding various knobs to control GC more flexibly for Zoned
> devices.

Hmm. I get mostly the same merge result as in linux-next, but I did
end up with a difference in f2fs_write_begin(). You might want to
check that out.

That said, the difference is a PAGE_SIZE vs folio_size(folio), and I
think in the end it doesn't matter because I don't think f2fs does
large folios yet.

But please check it regardless.

             Linus

