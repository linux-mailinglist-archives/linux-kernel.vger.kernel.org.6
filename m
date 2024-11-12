Return-Path: <linux-kernel+bounces-406198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE87F9C5C00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A691F22E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E85A201262;
	Tue, 12 Nov 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="lppQmzAN"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24EA201260
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425731; cv=none; b=nzhn+gvjm/BAwpGXrmRb6PDfwhafaTtNQVvv50+2+coRgRNaooX1qgvXAmmfoV2t3gbjMR6QhOo1HkcyfL5ewi28zt7CssQ0cvUnuBXrLYDcbYPppHMrUU/4MLnEKotw/de7ptedAo1Qn8XLWGjEVueQkYUI1XrwSY1N3dopoQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425731; c=relaxed/simple;
	bh=UYeXT/AwePy9sTmZKwKEffySuj7xikS7S0DtVBnKEQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdXqd/wuV4AFfrToFzV+7jDtyukunGeOxrPryOC+ND2EbH7FPS/FFq9J1dTK8n2TL36kOFZ+WoRZRnq5P3SHQer2L9PZiptsOQUw9cmlyXiJhf0npYNA1THl51GHEov7FRcBMOdIuof3B+H+29A83RID40fAAXOCDlJUJ26qp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=lppQmzAN; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b14443a71eso448404185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1731425729; x=1732030529; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bVzxNeB2db4M6YgRn5UBfiImbmQIKHlXCeQ683sEK/o=;
        b=lppQmzANW7t6EnuqK76h8ogDftZwOLx4Y6K7zyeICk6UYaj1aPHD40lHYhyhvlI/fV
         BikhxLz2kSzbVWg7duGSaDd5SZKunfcOUf4wjeQMwGW4njPZ+nEfS+JJNa0/hzqzILBG
         inofZjzX6oM9wY0OstBLGMMpZjNWtEhHl6gwarJrNeEmIK6qqoEHaRheOvJZ95tpWSnq
         Bv3OUTfZWOuixWiuYHX+7CFnoqzut/VUTwCvaNnc1MZJ3KX9MJfIwj/RYpG0cpfBSsop
         Fht5uL8pG7jwcS3DBL8lWfu1OBRtwTwOTjBw8oyUCQE4r345sUocEx7+3jab/rs/dx6y
         OVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731425729; x=1732030529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVzxNeB2db4M6YgRn5UBfiImbmQIKHlXCeQ683sEK/o=;
        b=ZzYlma+qfg/0uIh3p9LAhiiJ+IeLvkupq2+Aof56qgTkE4TqLnyGYm9NPOs0UZ6VbS
         DfRrq+Phre/mDXx2Qx0X+cCV1ljjOGdY4co4pKqwO9FgXIzf2RM7IK181MWOCiIpoKs9
         QrLUzu+chbHoo/wyNgewAmdHzw6jZ+rRuhpxIZ8YJt8HlORnm4p5Bhm/ti7PBIZD/VRy
         oYu4Ydr4UV496LEppRXiu5u8QX93Ul6YXugrLpnY9Y9Os6NUwTtgAQHoLY6JVVGn5hh3
         Xpb7uWRmofpVELWxpxQWSy3GWcfvaKVS9fjpjiYAFM5Ol0YNwdRIppOFzNlyCLQqSWre
         Brow==
X-Forwarded-Encrypted: i=1; AJvYcCWAOqg6U73/6pK5FzNh7KMxXAEC2yoqiTXmYKB1H/IXF4Vumg1O1Et+DqHQR5wbImZkneWeIrvv+d4tMiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bKiJtKf6swH5l/fbVcGRd4Z02UboeyR3u6QCr8CFyyfrLjGR
	l7RUK72z8wP5Gjm5jkQXSU6UdX90tRRQ/VupRYlZX4EsW+2Il/0QIifbtf9odA==
X-Google-Smtp-Source: AGHT+IHybDqzPi0+fdFMR/GnS2iUaULMc0zt9E4K9RWsWx3q/KhAXWdD+VJbesoisRQydZ8c4UTwPg==
X-Received: by 2002:a05:620a:269b:b0:7ac:b04e:34c6 with SMTP id af79cd13be357-7b331f20654mr2548341785a.50.1731425728749;
        Tue, 12 Nov 2024 07:35:28 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.12.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac56eb2sm597032685a.51.2024.11.12.07.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:35:28 -0800 (PST)
Date: Tue, 12 Nov 2024 10:35:25 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: =?utf-8?B?U3rFkWtl?= Benjamin <egyszeregy@freemail.hu>,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, torvalds@linux-foundation.org
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
Message-ID: <75a5a694-1313-44b1-baff-d72559ac9039@rowland.harvard.edu>
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <62634bbe-edd6-4973-a96a-df543f39f240@rowland.harvard.edu>
 <61075efa-8d53-455b-bba3-e88bbf4da0a5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61075efa-8d53-455b-bba3-e88bbf4da0a5@paulmck-laptop>

On Mon, Nov 11, 2024 at 08:20:05PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 11, 2024 at 07:59:33PM -0500, Alan Stern wrote:
> > On Mon, Nov 11, 2024 at 10:15:30PM +0100, Szőke Benjamin wrote:
> > > warning: the following paths have collided (e.g. case-sensitive paths
> > > on a case-insensitive filesystem) and only one from the same
> > > colliding group is in the working tree:
> > > 
> > >   'tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus'
> > >   'tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus'
> > 
> > I support the idea of renaming one of these files.  Not to make things 
> > work on case-insensitive filesystems, but simply because having two 
> > files with rather long (and almost nonsensical) names that are identical 
> > aside from one single letter is an excellent way to confuse users.
> > 
> > Come on -- just look at the error report above.  Can you tell at a 
> > glance, without going through and carefully comparing the two strings 
> > letter-by-letter, exactly what the difference is?  Do you really think 
> > anybody could?
> > 
> > I haven't looked to see if there are any other similar examples in the 
> > litmus-tests directory, but if there are than they should be changed 
> > too.
> 
> It does jump out at me,

Maybe this means you've spent too much of your life concentrating on 
these files!  :-)

>  but even if it didn't, the usual use of tab
> completion and copy/paste should make it a non-problem, not?

Those things help when people want to type in a filename.  They do not 
help when people are trying to read the filenames, figure out what the 
difference between them is, compare a name mentioned in one place to a 
name mentioned in another place, or understand how the names are related 
to the file contents.

> find . -print | tr 'A-Z' 'a-z' | sort | uniq -c | sort -k1nr | awk '{ if ($1 > 1) print }'
> 
> The output for the kernel and the github litmus repo are shown below.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> For the kernel:
> 
> ------------------------------------------------------------------------
> 
>       2 ./include/uapi/linux/netfilter_ipv4/ipt_ecn.h
>       2 ./include/uapi/linux/netfilter_ipv4/ipt_ttl.h
>       2 ./include/uapi/linux/netfilter_ipv6/ip6t_hl.h
>       2 ./include/uapi/linux/netfilter/xt_connmark.h
>       2 ./include/uapi/linux/netfilter/xt_dscp.h
>       2 ./include/uapi/linux/netfilter/xt_mark.h
>       2 ./include/uapi/linux/netfilter/xt_rateest.h
>       2 ./include/uapi/linux/netfilter/xt_tcpmss.h
>       2 ./net/netfilter/xt_dscp.c
>       2 ./net/netfilter/xt_hl.c
>       2 ./net/netfilter/xt_rateest.c
>       2 ./net/netfilter/xt_tcpmss.c

Those are all fine.  The filenames are nice and short, and the case 
differences really do stand out because they affect entire words, not 
just a single letter in the middle of a long string of letters.

>       2 ./tools/memory-model/litmus-tests/z6.0+pooncelock+pooncelock+pombonce.litmus

This stands for the files we're talking about, right?  It needs help.

> ------------------------------------------------------------------------
> 
> For the github litmus repo, almost all of which are automatically
> generated:

I'm not so concerned about these.  A litmus test repo isn't in the same 
category as a kernel source directory.  Maybe it wouldn't hurt to make 
some of them more distinguishable (I haven't looked at the original 
names to tell), but they're not our problem here and now.

Alan

