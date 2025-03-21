Return-Path: <linux-kernel+bounces-570715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1317A6B3D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25EF3AF4AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49101E5B70;
	Fri, 21 Mar 2025 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jkMc9QBy"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2371D516F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532808; cv=none; b=Da/Q9c1FXnVdndb6/T8GO+RBwwAcCaFiB+KYx+D4Rcv5xH2muJy3Ho/yTAHWtG9THRypqVz1FpiqkQLlDgQYm9F7Y5/06vSXCYnekS2H8N36t7nh26FCgk5CcVukNfAIhPwSpTnNKDa4uU2bKBP0nEdt7ag6yjagRW0FkpVj2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532808; c=relaxed/simple;
	bh=8wjCsg0Dy294/vzOad6sb69pancKfSE93bXBiKtMzyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WByrdf1I2tVrrweNQvp3VpwatX3agRtQ4TFNAMadvv03EFmcZCj3q2qaYPUVvgKAJpX3e+iRde0bLD95wmShN6K7mWArT0lahqbj2V8eR7ix4q4glKEDIszcZjKrXhjQrkAcATs2EJp/yFkJDl5FxXBqm151UwegXvc3rc6qw8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jkMc9QBy; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso17212566d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742532805; x=1743137605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbzLWCTpNb9s8l8woW8btRsfZA3DuSpJz7B/kKMTLr4=;
        b=jkMc9QByfL6lp4W3YYEK2k3zGZNFg2hc6BhghRqIgIXJSqLR3TxpTokS4FFUqfRD9/
         QDUYkd0LDNJ+r5heTGk0XtNcli20mH9jRNfFRPWWDc+DIz6WMZIcXcsDJr+EYN0ykfCt
         VjqoZM4IAHBGSk4Ng6Wk1/O9Wrj+/Gj9khRJszxKGxqt3FI3bCHqG4ZYoJlM2kO/bBgR
         w908d3voUPKImFboN21p7hme75kBiVAgF1qZ6C/kFgSeq8N+Ot16rwpaeb1MrngK5/h9
         W2DrXaBUhwi9Vr3b7slPdSLYh/FtrTRoYN2IQR+Dn9x4sN01T/vqpEG32npYy/A74ab8
         IeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742532805; x=1743137605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbzLWCTpNb9s8l8woW8btRsfZA3DuSpJz7B/kKMTLr4=;
        b=FmG+fZP28Tg4v9SYh7cXHyFaTnUfftrb8ITcKIH8UANWBGE5sog4XHQ6oinn93ZvQp
         qoS+OD1989E1a79Vak4ebuqe/Z7y5DIsZRJxTK1Zmim/YVZibj59Q97vXYq8bJRAkE7o
         k93VuDOowhwqh3s2yQitZ+6Dq77ek6lLhPwRHafOKOxx9e0INlDt8+vs5RFZO+1Z5jko
         VEDRu19JqlcLdI8iwvzMzuRhv3BktLu8vBdsO70waPsXnwWU0hFRlpQw8t2B9qOoc4sj
         R+/E2EjyI50aI+fVnWZh9Io1NcuWsGEXMqd5sktu5FOFsMPj1AGMK0pKVwZfyJcSHkB9
         giGA==
X-Forwarded-Encrypted: i=1; AJvYcCWMqS0QuFY3sAUDTAXLUtDxEAPVbdYvKqIH/j0H2AJwUHbom6df4KKyAHfbPDuJrPO3SqGOKTQ8S1V3jZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6a4MHT5Mq6BiZzY3+UCtmeXQFhO2PDW/PeB09awMP6jqMFJNw
	QW6jdEh7Yo4HN6SrNw4rPHBtr/JMkzfoIOiMZEmyYQls6n3Bl1k4T5FtdP6CVmc=
X-Gm-Gg: ASbGncsKSuPXyaDHFfI9f97Qk6wLL05oN+bE02FSH6RkC5y9z0KBvNCnqWhGg+KKa1K
	LJ/vUBN3eJbVlVbhbgWebe8DUskLwYawwg3rRgO4EYsPzCYt4jncMYA1AgfnqAoYJYNAARLvg5h
	V0Q5io/v8eORRYS2GGk/pICu0YzK2aSkzsd5M6e4xlkUmMDtTCw1UUOD3RmwikUrzL2BM1jQqMj
	HBswJfSDsufUvwJ4KWk00pzzsS5xiCqNnpDymYpJFCnvkijvMqpqmc2sJ12CdOM7L9ia05kvjdn
	n6S0dEkYzszc8qNKI1IDsL6rTH2EH1Gu50SMGVgv6gEsSbAM0dgxfBpYmZVFNsG5M63IqH7X28m
	k+aRBHMBAt/KzE1smXCDhTif3Elw=
X-Google-Smtp-Source: AGHT+IGVL/LUMypx3aMhAzZdqNqW3DtQ7i5EEKUs3LjZvTQziSUDTdQgaVCU0DtLDh9wUbOPLCMkLA==
X-Received: by 2002:a05:6214:20c8:b0:6e1:6c94:b5c5 with SMTP id 6a1803df08f44-6eb3f26e984mr33048466d6.4.1742532805513;
        Thu, 20 Mar 2025 21:53:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f5d8sm6903586d6.45.2025.03.20.21.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 21:53:25 -0700 (PDT)
Date: Fri, 21 Mar 2025 00:53:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <Z9zww6ClrqH7lFom@gourry-fedora-PF4VCD3F>
References: <Z9xJdP29XEz6CljB@gourry-fedora-PF4VCD3F>
 <20250321043701.928-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321043701.928-1-rakie.kim@sk.com>

On Fri, Mar 21, 2025 at 01:36:55PM +0900, Rakie Kim wrote:
> 
> Patch 1 and Patch 2 are closely related, and I believe that both patches
> need to be combined to fully support the functionality.
> 
> Initially, I thought that Patch 1 was the fix for the original issue and
> considered it the candidate for a backport.
> However, upon further reflection, I believe that all changes in Patch 1
> through Patch 3 are necessary to fully address the underlying problem.
> 
> Therefore, I now think it makes more sense to merge Patch 1 and Patch 2
> into a single patch, then renumber the current Patch 3 as Patch 2,
> and treat the entire set as a proper -stable backport candidate.
> 
> I'd appreciate your thoughts on this suggestion.
> 
> Rakie
> 

All of this is fine, but it doesn't fix the bug in LTS kernels :]

It would be nice to do that too, since you identified it.
~Gregory

