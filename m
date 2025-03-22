Return-Path: <linux-kernel+bounces-572236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11075A6C818
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B833ACA5C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1121818C006;
	Sat, 22 Mar 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q25AJZVJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538D78F5D
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742629007; cv=none; b=bND7l9HDpDCCc3v6FKr6aTs+30gckUTBK2QL7WG5iW3Z5NsZGRFkc1klj37P9SOm9o57IGtFit+IJ3CJsQX+8T3hjjqNyK7uX8+9VgGLQi1aI+qtjLUbPoZpstwg0LGYgThnsJjb7IbVxEYBCUdnOjZZ/sRbhT0y6YUgXfLeuEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742629007; c=relaxed/simple;
	bh=IYSwwroPXdSj/5KGFMmEPXWXEM1pUuN0TEpInamJGLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0AugQ7bTY9sZJG/thetcwybMbUOof9Vzb535MWbyJQXalipYlUZ0aOriD0VXk0Q8rvE7giKzmF0bfjUtwy7DX6a9i0c6jszPZLhllCV0B88Mb9LSaQAuHmt3s09nEnfuiWHOwu0qbclZpgie80l1LwWEj3FP3AMBWicrHPCBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q25AJZVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C2DC4CEDD;
	Sat, 22 Mar 2025 07:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742629006;
	bh=IYSwwroPXdSj/5KGFMmEPXWXEM1pUuN0TEpInamJGLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q25AJZVJgMlkBGU9NLhxBMruBttHCzIuooXXwEWidMsNT+mVgeiZ8zYVY7iK7IHS4
	 dugf7FIErviVxyIYxhUDfh8GFBQwobAyWP0cpleyQ+PjdMYTf24jGgzekumxtR9s/G
	 wBH9QiBqgGTEvNRgMNy79e5jIhE+WPNjewWXu0wpCIw5L8uEfnQyP5Ult91ttfXYJ3
	 RUxcRF+EE/0GXfqM2R4/2GMWZ5Ox8u8taeJPYGo5s43LjKyAIaVxFalZABOTJ5UYln
	 h7HGT2f5JTDbY5PMHFWpcD2npcSXxoRSjTBBIS8Ww2wmm1VJI2C9w+ZlyCukbkvOG5
	 i1atlttou8OHQ==
Date: Sat, 22 Mar 2025 08:36:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, "terrelln@fb.com" <terrelln@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"brgerst@gmail.com" <brgerst@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compile problems w/gcc 9.4.0 in linux-next
Message-ID: <Z95oip1UjPofpHUq@gmail.com>
References: <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
 <SN6PR02MB415765C109AF9820DDC3AF0FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41575C4BA0C467B1C95EEB21D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z90XZqJVwuWkarnX@gmail.com>
 <SN6PR02MB4157E2AC0708EB2074302E6FD4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157E2AC0708EB2074302E6FD4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>


* Michael Kelley <mhklinux@outlook.com> wrote:

> From: Ingo Molnar <mingo@kernel.org> Sent: Friday, March 21, 2025 12:38 AM
> > 
> > * Michael Kelley <mhklinux@outlook.com> wrote:
> > 
> > > > What are your thoughts as maintainers of lib/zstd?
> > >
> > > FYI, the same segfault occurs with gcc 10.5. The problem is fixed
> > > in gcc 11.4.
> > 
> > So the patch below would work this around on GCC9 and GCC10?
> 
> I've confirmed that the patch gives a clean compile with gcc 9.4.
> 
> Note that I confirmed yesterday that the gcc problem is fixed with
> 11.4. I don't know about earlier gcc 11 minor versions. Lemme see
> if I can get the original gcc 11 release and try that to confirm that
> your patch has the right version cutoff.

Thank you for the testing!

> > +++ b/lib/zstd/common/portability_macros.h
> > @@ -55,7 +55,7 @@
> >  #ifndef DYNAMIC_BMI2
> >    #if ((defined(__clang__) && __has_attribute(__target__)) \
> >        || (defined(__GNUC__) \
> > -          && (__GNUC__ >= 5 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 8)))) \
> > +          && (__GNUC__ >= 11))) \
> >        && (defined(__x86_64__) || defined(_M_X64)) \
> >        && !defined(__BMI2__)
> >    #  define DYNAMIC_BMI2 1

Worst case, if it isn't, I suppose we'll get followup bug reports.

Thanks,

	Ingo

