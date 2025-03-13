Return-Path: <linux-kernel+bounces-560090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9219A5FD95
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317F73B9D16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE079156653;
	Thu, 13 Mar 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IeYVjt4q"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE14125B9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886426; cv=none; b=A4V2zzpb0e+CKC+ocTlumAycFMzpK/3STZ0JMKM8nP/RuiQs/J6XWvWcw3RNDla9eOOBmdVkqhY2r6qFv48C/eI9uPfTp9wdYv+yjewO09OjBpHGf9V6EFSM7dyPvW1e437ol5Qi7vRePTiELE8VHrCnyLpDJsNCxDYdRhuNyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886426; c=relaxed/simple;
	bh=ytKnJ9KP84KTImnJGlrWYjrWTIpLk3zRxii5NGsffng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBXE+GNPWfsSFx0nr3fR0e0IiU46PdpoNP2W1S8UXCgFzFAG/ltux+PmbftDnH6PsBjmuIlFaWVB34s1siMNEhZ7l2+1CsLVyGaIUGviocEpLHkgJlUyf1UJyKI5suq7AFiv5jo/WBC+OVsOkZvv+89NDGRf6EDqBNiR0I3xXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IeYVjt4q; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f8657f29so10608876d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741886423; x=1742491223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9es5s5/MUGI5ZSuPglHG3X5LeltCJdtthknEMRc3Xk=;
        b=IeYVjt4qdD1EGKP5UuMVPW4UuG6dSwkhkmnpO2cqni8gKXWg4ZaCfh9zo3FMrZQnoU
         CCsWw1O4GtJ8v2/8noMxFHMHqNOL6+y9Hgci1ycTlAtZ6+0v2axGDQ6QPyx5aEOq159J
         0RokqF3eHulH9apvmG+xtdSXSwRYgH2io4uVqrxZUPtRcIlCYvEoLK2HjekTsEzB81fs
         +DI7m3DYdAk954K/u6xs3wJK/9adwzUo1hYH1bpyLolPd87Tb9uRnWIZojeIQjhZUyxe
         4d1JoANyllWrPMn06F6gV2S9Dq2klqMCGCpxnDG5n0CVnoR0/aBIPMIyykXyfCIJyTTO
         yuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886423; x=1742491223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9es5s5/MUGI5ZSuPglHG3X5LeltCJdtthknEMRc3Xk=;
        b=jKuaYqhd8p0gkJacVarWEZsBEvcTjFiyrF0ym4IqQfz+vj1016/jdyTa5wd0JFefgC
         QgqVc6RDlBW4m2ip+9LrAbnHJQWcQw+9LkgwTmZ/WEQC9SFpTPErGs/+W4RDdr76fNVN
         tygf+EAThn0kgLQ5J9xa+cUF2bUfVUfvEr3ey0AHU1QYx8MQc5UQtI9cTFs28iXdc6rI
         0zfMWYxFkq6ihVKspeFAJThYM+WYprdrzclqya9hzGXmMG0aymiGmCAuI4xk9qntcg3k
         mbJ3Fm9lRmKRh2cHYw7pppVhhQ6RMej/RSxEto9mTzupoUZkcgjARp0+cJjgYrGosmQN
         KrYA==
X-Forwarded-Encrypted: i=1; AJvYcCWtCVwbZN9DGV6/oPR+E3/kCMj66ykIu3sCjYB73CCNTKO/F9FODPLDTY1KZQOuf5qiMj7AnDXc+buw4XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWcbV+PKtl9sicM3YlO8FrlhgOwWu42Y9pdRwY9RBN5/An462
	zr82uSq1YOjzfgmGtWH5xiqygRcfwMZd3pceBtZ3czWIpHHrRFaEZYdqOgYXOxlE+iWX2/pQXI+
	/
X-Gm-Gg: ASbGnctCd5Zz1C6YLO85/2eyCTa1yz8C2j16cqWaMQHBJcnVJdSp7HXGbussBgS9245
	bWeVam4BsZ3TU17tLP5+4l27NYdtZvQ3qj1BZ2Kps8PrYjG8D+e11VocVcfA1BTu4oLKi/GVFac
	ZjgRl5hUz6cVrV2QOp+2Z7nD3hposolNuVxaXLSK32E22JhFzYe1fXQ5f5vD4Ag4aKvK9mBZntA
	6MQWVFBB0IK6SeBHHckM8u6wVl9UM8gyNWm2akmdgSgqPvUZR0CCNH0Wqq0pZ6EdX9fGQTjNO9u
	s0Wmq4/zOpYnQF3Y2IFXf91mtAWCOuzOX7LlfO8l8gcw9lQnVB12DmrJBd4AqrWJj5taDCxoUbA
	pOTt/wulPQ5lrqkiYVNxisO0CyoA=
X-Google-Smtp-Source: AGHT+IFdpX1W9er/zHGcaKcZDK6P6IdlPFmMWpHoDJmGALEDc3Dy7cqy8u/Hi7dFktDcXjTw7QG47A==
X-Received: by 2002:a05:6214:27ee:b0:6e4:3c52:d67e with SMTP id 6a1803df08f44-6eae7a11135mr7201476d6.18.1741886423325;
        Thu, 13 Mar 2025 10:20:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209313sm11867186d6.19.2025.03.13.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:20:22 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:20:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z9MT1fIKu0v1r9ss@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
 <Z8ZKKwDnuAjtyohz@gourry-fedora-PF4VCD3F>
 <20250313161226.00000038@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313161226.00000038@huawei.com>

On Thu, Mar 13, 2025 at 04:12:26PM +0000, Jonathan Cameron wrote:
> On Mon, 3 Mar 2025 19:32:43 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > 
> > SRAT entries are optional, CFMWS are required for each host bridge.
> 
> They aren't required for each HB.  You could have multiple host bridge and one CFMWS
> as long as you have decided to only support interleave.
> I would only expect to see this where the bios is instantiating CFMWS
> entries to match a specific locked down config though.
>

The further I dived into this, the more I realized CFMWS are the
opposite of required lol.  Platform vendors can kind of do whatever they
want here.

I'll be taking another pass at this section since i've done more diving
in to write the interleave section.  I probably got a handful of
comments here subtly wrong.

> > 
> > If SRAT entries are present, one NUMA node is created for each detected
> > proximity domain in the SRAT. Additional NUMA nodes are created for each
> > CFMWS without a matching SRAT entry.
> 
> Don't forget the fun of CFMWS covering multiple SRAT entries (I think
> we just go with the first one?)
>

Oh yeah, I guess that's technically possible. And technically each SRAT
could have a different proximity domain, because you know - value.

The dance between CFMWS and SRAT is quite intricate isn't it.

> > 
> > CFMWS describes host-bridge information, and so if SRAT is missing - all
> > devices behind the host bridge will become naturally associated with the
> > same NUMA node.
> 
> I wouldn't go with naturally for the reason below.  It happens, but maybe
> not natural :)
>

Yeah as above, I got this subtly wrong.  Thanks for the notes.

~Gregory

