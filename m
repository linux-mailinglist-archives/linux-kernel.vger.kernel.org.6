Return-Path: <linux-kernel+bounces-422518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53CF9D9AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA989284C97
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EDA1D63EA;
	Tue, 26 Nov 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWBTlRrM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D7F1D61A3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636249; cv=none; b=s1r3Bx7djscUGrbH0dGPgT69sZfyeVIRai0aMqPS9LjIDiX7Z+HMPGqIdBxhvKJiUgbCOorKbjmXQaqABdGxPp/9iNIw47KjeaUSO2PKYAyBu/mCYkmd0guyEpEgNL81WO+PcH+qhHDDXzZQYhldv3LKAkuyIS7/leBSE209r44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636249; c=relaxed/simple;
	bh=laXvtY4a55ACGAH1IApyJlQSRUw2sdwb1O3gMBJNBV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddepArROo10UmW2iPpCAmIZOCaddYIQByz848ujgb4FaUQPaSdwZSaMUQeHNQvkJiPplcDx7L40+cL/n/5b7zjdBTgJrInGWbgSxfUh1OQZoSzz1rJ3EDGuf+dif0IxrRmMq/wnS1cCK+5L/HHvfdzaBBnEzJ8mk+Z25CeDdD7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWBTlRrM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732636246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bCIgW4A2MDfF24AOQufoWb9ipMkOx9ancvKfw+6WNmQ=;
	b=PWBTlRrMlmAU1h9BmmC65/HWaX7q9+U56sJdHU2HQ/CrKvuAzTIrFJZDOsTX81yHHDj5om
	nksQOy3iHbvixOQcyTyd9I2EY7Pe4VMRHHOZG3oYmvNJVJZMXYfvbBA+I5OyRFISk8bK6w
	/dVDCQ91RyMQ+bJ+TlLt3DF33zpreSo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-Ku1Z91V9P1GmLudWoCXU0w-1; Tue, 26 Nov 2024 10:50:43 -0500
X-MC-Unique: Ku1Z91V9P1GmLudWoCXU0w-1
X-Mimecast-MFC-AGG-ID: Ku1Z91V9P1GmLudWoCXU0w
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4667c1c3181so55838041cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 07:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732636243; x=1733241043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCIgW4A2MDfF24AOQufoWb9ipMkOx9ancvKfw+6WNmQ=;
        b=UOlQ1v8xcghE5h5ngrB4uY28X0nxUmzdFWXy6HmpKOi0mQ7xnpKfy7TLKiDp3Dg1CB
         U5dTaWQD/mMiQlqxJ6u+ERTXqltkjHuddkWPhTF8HWbn+xyUnoL57gE34yNRjdGr8VaN
         +FkWKgFEwOnTNrFTj3o60JcZxo6OLdXZFsKji9XvKJCcijKeebNlXABCngTT81gxaEM8
         VujM6kNbiDEOYxC4i4nAc4ZWuJFbbRRfyDSnNvFBHJgSyEI/X+RcCynI0pmx/P2m2mwL
         sUm6anEHq98ZigchR3ZtuRPFXoHn8w2AtYWJjRIp5R0NqV6ny8httOiy91hFhmNtFWGA
         RIYA==
X-Forwarded-Encrypted: i=1; AJvYcCVG1xvMQh0JCIIO0s78sF+ci3SShLKCMHP0KYCRFxvdiqgfhvaFqj28GQ4Qa87EC7zPw1t0BjsfUtP/Tuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0G3EjyNVB0a0+H5dNLp0RYGasLFwGqunzbnUoFHgwIaDeUDU
	Xo6yBfwJzAOBrj/NK7XI+TUdwKgWhsxu0dlW0H/SyvEAtcns3Ryo9yil+UdiCfOT7RecCDVvEAQ
	C1x1ZA3kv6IZIOlFzgqgQI8NW3XHx0CidaCp8t9HYP7Xq3v+dhHDf3TjgjFKCaQ==
X-Gm-Gg: ASbGncuN/sa7yQGIqT8xj5ZsEyEABQN7rGXCWYCRv/dkwMRj+gx58oVKFJVJ3kEeApm
	Eer4QBnekoRC+Lfiv/mkYJh14x3DfmqFPOqDBrBqHxBA56hG2neGYDtQNowv2g5kw/9uX+j+8nl
	qowUtG3DqE+4/fPGi4AjtkjrEpMVeZ+MW23CtO+zG5FbIB5W1pkuDQBRro2Fdke4eJcFtzjnzjm
	Vjp0XfBnAEe2M99G+GKTvh9tnxXubvuvtQROzhQ70b3W1eAIYzAvABE8xnHIlM4A0bjPIu/77gU
	dDk6J8JL8TA=
X-Received: by 2002:ac8:5747:0:b0:460:996b:2896 with SMTP id d75a77b69052e-4653d63721fmr240796991cf.45.1732636243055;
        Tue, 26 Nov 2024 07:50:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN5S4TgDM+fG/qOPZTtdWIFlTF1kXp4ZhRxCEHUm9zkYOUkskjeKN3z9VxbCU06ZZAX1+ZkQ==
X-Received: by 2002:ac8:5747:0:b0:460:996b:2896 with SMTP id d75a77b69052e-4653d63721fmr240796741cf.45.1732636242769;
        Tue, 26 Nov 2024 07:50:42 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4668904ac7bsm32309901cf.32.2024.11.26.07.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 07:50:42 -0800 (PST)
Date: Tue, 26 Nov 2024 10:50:40 -0500
From: Peter Xu <peterx@redhat.com>
To: stsp <stsp2@yandex.ru>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: userfaultfd: two-step UFFDIO_API always gives -EINVAL
Message-ID: <Z0XuUBqBvUvhQzGn@x1n>
References: <2d35e5f7-2edc-4ef0-b71b-82186c0627b0@yandex.ru>
 <Z0Se4BuVfqwjeCWV@x1n>
 <b0818813-5a4c-4621-9810-dc7443a23dd1@yandex.ru>
 <Z0Ssq15MQd3rimBr@x1n>
 <da978e8c-2a72-4b7b-ae67-41e6ff0d5089@yandex.ru>
 <Z0SwOILi4R4g9JBa@x1n>
 <CAJHvVcgLPhAS583Hp_To1McpvZL2U9cXt+=LKRNcikat3JgMAQ@mail.gmail.com>
 <cfc58081-c49a-4f30-bb39-966c7f18b9eb@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfc58081-c49a-4f30-bb39-966c7f18b9eb@yandex.ru>

On Tue, Nov 26, 2024 at 10:39:19AM +0300, stsp wrote:
> Please, just why do you have that UFFD_API
> const? Only to call every screw-up like this
> one, a sailed ship? :)
> Why not to add UFFD_API_v2?
> Then UFFD_API_v3?
> Full binary and source compatibility is
> therefore preserved, you only need to
> update the man page to document the
> latest one.

We could.  I'd say we only need UFFDIO_FEATURE to fetch the features, if we
want the interface clean.  I just never feel strongly to add it.

"Creating two fds" is indeed awkward, but that isn't too bad either when
the userapp can easily wrap a function to do that, open+close the fd
within.  Actually that's what our unit test was doing.

int uffd_get_features(uint64_t *features)
{
	struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
	/*
	 * This should by default work in most kernels; the feature list
	 * will be the same no matter what we pass in here.
	 */
	int fd = uffd_open(UFFD_USER_MODE_ONLY);

	if (fd < 0)
		/* Maybe the kernel is older than user-only mode? */
		fd = uffd_open(0);

	if (fd < 0)
		return fd;

	if (ioctl(fd, UFFDIO_API, &uffdio_api)) {
		close(fd);
		return -errno;
	}

	*features = uffdio_api.features;
	close(fd);

	return 0;
}

-- 
Peter Xu


