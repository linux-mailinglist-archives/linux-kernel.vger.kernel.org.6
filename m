Return-Path: <linux-kernel+bounces-561968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C44FA61971
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FFF7A9634
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7603A202C39;
	Fri, 14 Mar 2025 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6ZgDMqT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD55155747
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977202; cv=none; b=BD5tHg9UCVm8J9mhZgovGWHrIVcsjJHiaVa7LHbxBaI6ufzD6cHZYlMc1LBKWhxd6J0nDHi5yfLuH5rPk83PHRRWfK0kMZ3JFYdwJlT3XqdXmMCoYlnsTqBA5o2EwL45a0nbKnY4sV2u/vItz/dxF4LChkYaaIElJ1fpKSgFTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977202; c=relaxed/simple;
	bh=kSqhQ5V9MXwxV9+FSHOerbqUZjqt2VktnP57eTKzuMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwWs/P24mzx3eLHTjvstFylPnDv/0xrgf69aIaddu/hKtL47IxW+cP+KbXlZhPv0+hNFWMCsXKg5o7fnKAQ8kovF9N/sNFO9xbEYOD+Yknt7KXgqmHs8JiBsHnGYWrfHjw8R5CRid4tBzBtkbIevHshcRE3KGANsZ9EYjKSwCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n6ZgDMqT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2242ac37caeso19595ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741977201; x=1742582001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMuwp82OD6r7IJy/Wg1idVZBlP+yv+xZWe1xkZ/dB2E=;
        b=n6ZgDMqTmwzY0Bu7geg/AZyC9yd9KhahAyVR2PuzSS9b0N7gwmWawdo6Feos84FfhD
         ED9Pwtp3GXwaY50sZkTDFhTei7F857rRnn6QKy/dbPjfyFaiLH2MUwREdsqTAGNzLGHE
         ca8nvI0XsRJpQba9aR9GkQvnFiL7huGoaCMLJzd+ZZbdmdalKMfMQurY/Hau9y/cE39a
         NYHGoAUoopPBjtFzalHgVDoYybu96FQm60q6TEw4O2C10Hk1rrlO340hDu4fu6IKldt8
         knPwzQM4HfCPdD9N/C7PzrLq8VFwGKBg9KVm1J+Jmb63y0Ugtx43cK6cxHGsbUz3xMcK
         PFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741977201; x=1742582001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMuwp82OD6r7IJy/Wg1idVZBlP+yv+xZWe1xkZ/dB2E=;
        b=EofzKXcpXZyGZT90duRP5MIylk+Ngzf/dUXEviPz8RkdtQs7qRrDy/3DQKNreETMGb
         MbCAWhiRnbj5eQao+iP88teJ76FHymKE+7amgO+GFjKUj3unoEwaXET4vRpBeOqSFrEn
         JLsJ9ddq7kZ/dDy2DC5u5KFRuZXGQ/8lxCnms3Jn3rkNZ/qsg0VcH6UuT8rxjg1uOFyX
         PjDkPcs7uxZ31Dw8JTzKCW3Yj/lxq6/oEFlJR1pj2TL+X9o6iCAbRiJ1fnCVS6SPfGks
         tH8O7MYMA3ShJ+Dr/j8c8DCtPkiIVA3oAjYfPSfjPnXi2cXDuWVEn7lBAauucCaf5Kvt
         ZPFw==
X-Forwarded-Encrypted: i=1; AJvYcCUigGy/Vls8Ypx0jSsnzFIMAnykAFWuBvB1fNi/GHy/buHwtCPJ2m01lsIgZrJgQHkwVG34jsTs8dNDCaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGpwURLXkHmTANrrdaVFHb8T6cQMf1kCximHc8AhPJwFDs9k3
	XY90TO120nUQbx2IfraurqqpW+dpUkQ3HKWa7nVKO239SLnv6+BKSnVJQ1SgMXO0mPULavED5FQ
	E4g==
X-Gm-Gg: ASbGncshYu39r+rBzlqwKt6Lc7hZWOqROr5t8T97CCURxG0vwK7dUpH/jIuzRHVwuhw
	fiOdMi4wu9X8xzFi4WArG65kYvDpHb/Eu+AddqW5uA0tPoK8YBZAJ/hP9KmoXu60z7es2bLljZU
	yqiMWpbzWQV5/0G8tRXcKvTq6551CExbT56jNZxY+9RACt3kj4dWVJQ+MO64bN6xn9pltnAyYnY
	WJ/oOMvCnQMkLsFbDl6HrNkTwbfxgI4EhtNS6pJlNQgDXVQGZEnly3SlCY1KEywjIu9eKeeGdRe
	qAem2B4vsKe5MF8GEDv/MV9KafwvL4E05M9geDV+yb+cex5vde9+W6ItIuG8Q9c9YpwJQtwQspI
	V0Ok3NuM=
X-Google-Smtp-Source: AGHT+IFf7OuTdgCNkjdYyNX6bnoAcfQ1rBweup8FhqoG/cZDltnywkm9Y6oo4leaXy1b9GiGuhBlRw==
X-Received: by 2002:a17:903:198e:b0:224:6c8:8d84 with SMTP id d9443c01a7336-225f3c0e859mr223475ad.4.1741977200647;
        Fri, 14 Mar 2025 11:33:20 -0700 (PDT)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d16sm31657585ad.139.2025.03.14.11.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 11:33:19 -0700 (PDT)
Date: Fri, 14 Mar 2025 18:33:15 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	"J. R. Okajima" <hooanon05g@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] lockdep: Fix upper limit for LOCKDEP_BITS configs
Message-ID: <Z9R2a_dX4YtK4jJ9@google.com>
References: <20250314064729.163602-1-zhangxiaomeng13@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314064729.163602-1-zhangxiaomeng13@huawei.com>

On Fri, Mar 14, 2025 at 06:47:29AM +0000, Xiaomeng Zhang wrote:
> The upper limit that was initially setup for LOCKDEP_BITS configs
> is too high (24 bit shift), which causes the kernel image size to exceed
> KERNEL_IMAGE_SIZE (1024MB) limit. When LOCKDEP_BITS is set to 24,
> the kernel image size grows to 1562.19MB.

This is not entirely accurate. Look at _how_ the new upper limits where
determined in commit e638072e6172. This should build just fine:

	$ make defconfig
	$ ./scripts/config -e PROVE_LOCKING --set-val LOCKDEP_BITS 24
	$ make -s olddefconfig all

Is it not the case for you? My guess is that you've also changed _other_
configs and combined with that you hit the limit. If not, can you please
provide the steps and commit you are using?

Thanks,
--
Carlos Llamas

