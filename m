Return-Path: <linux-kernel+bounces-295609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D9E959EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F751F22AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715311AD5FC;
	Wed, 21 Aug 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGB4OOyO"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357461D12F3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247802; cv=none; b=CEJ5UAEnvrEgjMPQxfUwBpqjZq4Hh154HCKEasDPKC7YGU3iW2xz/x0EPKBHzuVqP2xJhRu0XLxCftkvOhEtMN+UFqs/YNPLRRHaPz5kFZHOZ2rIo/oca2WkUXe2NYeWlxBAh+Knn/pSvlNzRU5mzRYJxP2xOMo52kQwS69UDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247802; c=relaxed/simple;
	bh=c93I54raOSbs0VRQIoGu5KAoP5RS/AuhuCp4Xi1YKXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0Rfv6FgCIXQYJ+re9MBW3cwHIoPiyNB/NvJjrjqVQOF/NIebB5zDYD/lDahD8xZNwQjtovhsI39eLZekvlzgdJEZq/SiPBpsjYp8sTK5SBK5p6c4WCqAt2gRxCbVNTYWEuX0s28uJyebsBFDQGy0SVNvp7JDynmtyVtW1Qm+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lGB4OOyO; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso41788971fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724247799; x=1724852599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq7tOAAcz6ewTIYXkiPmAfOTq4iDQRtjoPIe2wulO0E=;
        b=lGB4OOyOmhZ1K3q65RHndOFz3e0v/jvqCnC37nxznC9uhZB6uA+HygmyDywRITsKXk
         FctXHtEAOCb2IQVVTr3b23lMp8iLRNxqI7aQeFZjkL5qoDOHf0N3k3EUd5dMx6N+zlv/
         5ykdxYzAn33h7ihsr3TGv+kv+1SSjMAqTzV2d/EVZtkffpLBvQCFrplp+pXEoTQg/DV2
         +2qelBQ4Ewx37p0HTPEBwIJDZH0LyLWRNFnyg5/uuTSur5mu/n8O0wyGNa1fxHFCekbz
         lYX4ULvNl4SYhyFAnlbXSau9GC2iGc4RQ2QP/VUyli464C+7PPmQgC57iXnR7n5Jwm//
         yNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724247799; x=1724852599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq7tOAAcz6ewTIYXkiPmAfOTq4iDQRtjoPIe2wulO0E=;
        b=UXPe7JUCCSsS47Jv7lIvQZHT04xrlDXTzOni7v7+4H2MnrBPMv6i1R4phhrGwGvArf
         khR4EpP2udj4oa5W0Ymqqlpz8NG3RRuNPRQHvpWc97m0kif5uCv87D7bbZu9R6XYTAjz
         NA5LnCffXGgL8F3uY5doQj4hR8SV6yFXd14ulu3fpIKnoCBTe+ox8G/GvPaPidLy7amw
         M+zIJcxjAUIegpRi9jn1sUlgJdMsiWVlPQpnHJTotVXO8CzJVVxneT0oFmbLloBjaig1
         jyBCrG64+8EWX6uwh7FMol6pVJ4fhEWTZoneF43voUP5NS+/NEipQ1pT5tJQn4EZa2Wa
         LILg==
X-Gm-Message-State: AOJu0Yy4C9mJFd1npWWWFYWYRXAbsN2inNKrdLUCQco8KUdpNS/fQOJq
	OJfan9MUfdgAStfxNZZOHoJMy2JCHjx0cYNxLPpAy64kZmRVIpovv6YURtJBU0s=
X-Google-Smtp-Source: AGHT+IHQbdHH8LzMKMml3FZkZHmsIF0qxWUa69l3XY4StmtQ7T+OKiiLyZ1IaFB9tC0TLHlDr4Jl1Q==
X-Received: by 2002:a2e:b8cb:0:b0:2ef:1b1b:7f42 with SMTP id 38308e7fff4ca-2f3f89489a5mr23557941fa.36.1724247799207;
        Wed, 21 Aug 2024 06:43:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f17bsm8234877a12.59.2024.08.21.06.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 06:43:18 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:43:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Matthew Brost <matthew.brost@intel.com>, Tejun Heo <tj@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-block <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: next: x86_64: ahci 0000:00:1f.2: probe with driver ahci failed
 with error -12
Message-ID: <af7dea7d-446c-4b25-a1e9-bd1f3753f589@stanley.mountain>
References: <CA+G9fYuD4-qKAX9nDS-3cy+HwGbyJ6WoD7bZ_QL0J__A++P9aA@mail.gmail.com>
 <CA+G9fYuYfNA7NZDHpq2K24CsUn21LAb8vn38=JTz=54bsdSd9g@mail.gmail.com>
 <43be498f-5a25-4ee2-8c5d-1ef75c4d1ff3@stanley.mountain>
 <eb78af03-b407-49d9-b605-af9632eda08e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb78af03-b407-49d9-b605-af9632eda08e@stanley.mountain>

On Wed, Aug 21, 2024 at 02:54:28PM +0300, Dan Carpenter wrote:
> Give this patch a shot and I'll resend if it fixes the bug.
> 
> Fixes: b188c57af2b5 ("workqueue: Split alloc_workqueue into internal function and lockdep init")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Actually never mind.  Matthew sent this same patch today so this bug is fixed
on today's linux-next.

regards,
dan carpenter


