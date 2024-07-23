Return-Path: <linux-kernel+bounces-259946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C4293A052
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76670283639
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806C11514ED;
	Tue, 23 Jul 2024 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wu9HOiBN"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B640B13D609
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735719; cv=none; b=OPUXsFOgaBMB7+UM4AAZ4QaYrqYcBa0GU0HwLusmJImRzcnVHjI1AJCo1iv4+J2RUPvbcCLfuqDt8o9tlEgJ/Xn/b9v1puqJ4gdI1NrK7RJ6qlRUeHF5HI8tiqYofDUKAZO7DNwUyve3ABgeIRczAiIu1Qj0tc5Y4saNaaapO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735719; c=relaxed/simple;
	bh=FOxCqSyEf0CvxvTenqZOAD0DVqWvt4ThHJZqpEjjwos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNVfbCu7MAhetNEl2NNOBXsE6klZsHfF3fpFOP5QmHdJovUp5SkuikcGUhi2I1wJFOYhSqR8T+xeYHEZhr9CEcQ1TeXyt6Y5BrykMmvNezSVaUGtI0ZEVg0aoiTqO7eL8KpWq82dD1uEwyoAtRv6WMkzP4CodfMHyKglWmY91kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wu9HOiBN; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso23494751fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721735715; x=1722340515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQoa6ehQ0YVDqTqctBCMle2kRcjPByagNYOUENJGnKA=;
        b=Wu9HOiBNI1thw55neck/bV9h2WuwIVOtqfVmNe17MEeIH/OpeDhMAFS9IY+Od8GYkg
         jCG/5mbl6zG2uHmvn2YJOYr84cr8UsqsTKGJmHVpWuQ5LYU6LIjWxjvUI7lCxhTRtDQy
         Q+iRkXzaNY5g+/ilER9onn2TLGMNrsw+cyazfj76vQ8ezx4nPMYgqvGqyFmH5Ue+9ELD
         ax5BF4i3Au8/bGi3e3Ix/vJe43HX7KCXjBZ3GWq+q5/Jm3bcQ/UKxS8FFBSuJSxk55yi
         L6oaeaYMHcy3fkL+Iw043wV47G174/jsnoCLgr3fBoUm2xfcS9bv0kEespNcLqjq+pkQ
         WODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721735715; x=1722340515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQoa6ehQ0YVDqTqctBCMle2kRcjPByagNYOUENJGnKA=;
        b=CPhtnQT9kPiPxGf8093RH6GK1ZXtZTD1vGeTCryfz3LZDvTTS0gA2xGvaU5JSsMkSP
         SxFQV68o24BO5kliVs+XwYw9FvVK2gapSxF+VuoehjYN34+bCNXUfJx371T3nTaN+n2c
         ZqQW54XRXuokoiPzb9TIZXkSZ0aDF2Bcty/LfYzU80omWhQV/8Qa3Ezf5XQSoiDwCxuY
         YuSXv5G1AlbWYTZBn1KtWn3yP2yvkonIoQIR9Rk/wLz9+zIl86M90bDhMldbLBw87ubj
         mao+bqB1gHXBVThFm+fmP3uvHYEOXbx88CZqxe/IvONuDRfhxEbOry9MTLhzfq8FEn/O
         g+pg==
X-Forwarded-Encrypted: i=1; AJvYcCUcJHm/1mZQS1eNkeLX7NmDa5kPPpsmIUou65J1mFJTeF4QXXBRH8w5d4FKfTPEPq0HJXder91DFv1lB9kEkyo9VQDYLTKrzMACIpga
X-Gm-Message-State: AOJu0YyUJpC+EfEQ8iNBaij73HJtAOINKOvzVj5quaY7FiEa5mVqCG0P
	wKqhmdipBDbCvGhRscYDeVV9211HumZlcqgzxlN6oyjt8qdjD+u/zUdNV25yGig=
X-Google-Smtp-Source: AGHT+IEvYNwyaaxdoUFWVu7x/WsjFTLx1CzKrLG5et/326ggkrbDQ2+hTQ74UgEfDVQNIvnoJEu/BQ==
X-Received: by 2002:a2e:95c2:0:b0:2ef:564c:a590 with SMTP id 38308e7fff4ca-2ef564ca663mr31778221fa.29.1721735714808;
        Tue, 23 Jul 2024 04:55:14 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d32e6sm7413595a12.84.2024.07.23.04.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 04:55:14 -0700 (PDT)
Date: Tue, 23 Jul 2024 13:55:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jianxiong Gao <jxgao@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix endless reclaim on machines with unaccepted
 memory.
Message-ID: <Zp-aIfs3DNhAVBmO@tiehlicka>
References: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
 <ZpdwcOv9WiILZNvz@tiehlicka>
 <xtcmz6b66wayqxzfio4funmrja7ezgmp3mvudjodt5xfx64rot@s6whj735oimb>
 <Zpez1rkIQzVWxi7q@tiehlicka>
 <brjw4kb3x4wohs4a6y5lqxr6a5zlz3m45hiyyyht5mgrqcryk7@m7mdyojo4h6a>
 <564ff8e4-42c9-4a00-8799-eaa1bef9c338@suse.cz>
 <dili5kn3xjjzamwmyxjgdkf5vvh6sqftm7qk4f2vbxuizfzlb2@xrtxlvlqaos5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dili5kn3xjjzamwmyxjgdkf5vvh6sqftm7qk4f2vbxuizfzlb2@xrtxlvlqaos5>

On Tue 23-07-24 12:49:41, Kirill A. Shutemov wrote:
> On Tue, Jul 23, 2024 at 09:30:27AM +0200, Vlastimil Babka wrote:
[...]
> > Although just removing the lazy accept mode would be much more appealing
> > solution than this :)
> 
> :P
> 
> Not really an option for big VMs. It might add many minutes to boot time.

Well a huge part of that can be done in the background so the boot
doesn't really have to wait for all of it. If we really have to start
playing whack-a-mole to plug all the potential ways to trigger reclaim
imbalance I think it is fair to re-evaluate how much lazy should the
initialization really be.
-- 
Michal Hocko
SUSE Labs

