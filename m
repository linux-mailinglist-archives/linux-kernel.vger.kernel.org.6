Return-Path: <linux-kernel+bounces-572708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677ABA6CDA3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 02:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296D3166D66
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 01:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3471F463A;
	Sun, 23 Mar 2025 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="z9dhFzuw"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABEF847C
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742693654; cv=none; b=dTU24LxkK7/NzxiGxVO5zH+N2gMDY76io7kPCm+0SxLtucVN45//WY0is/sRPCB/j+TmTVHgEAMgJi7uKNJXVcE7UoNrLVHw1khY24/mgZv4evqs/+P7SCsmL+Lz3RQi2MkezC5EfR5cYdZKaZ/atXDC2VKydVuvzQExG3yXd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742693654; c=relaxed/simple;
	bh=lKrvhOeZcj/4Df6v0ZP79ZMEvZZ51QsB6RYk3TKnQEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOhvCev5fDDEr2gW4Vqg+5CdkLVDb9Jg0ZhSMBeXnhiXwF9Z0Mksfs6k0OIgGSj0VIHaFAGF9/CLxw1W3/sO73WRyXN3c7lFmjTqnWiTVPYVBlgNg79Zs7F6LQ0JKLKkQSporQt1+uyrWADBoFrm6g3JgRfG7OPsBz/ZpwnPOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=z9dhFzuw; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c081915cf3so449793085a.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 18:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742693650; x=1743298450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1FOdP+bSRRYHzcPHH0Rlip7ghgqtNeSWLX/OCB9MYc=;
        b=z9dhFzuw3PlWIlY6JniRuuEGWI0mddOAhtumFviCJZ/f2AEi8tac1Bgw6zDdCddV8Z
         a5pN3esN0EZY/c8r3lvneA4DqfGkhMhY2er1B8PRqgJsdIpNMTnzCoP51kM94EWW5x2u
         5/cldlUUONXA1eyYxZEH0XOU7t3PWih2OvX9w4nh/iClISztvIsAU82robWy2BCHABIh
         bwHPG0ykB3JIFSTHtRO8tdvGZ1mE1NZ3/yMhCR+IOFHB3tR2v85KVVHOw0maqV4ucVEg
         qt1if182ydVTy8q3H51glF2wNefnnusrTcqzTALLG3LcdClMNLwKCPXSpgxTH0ZbtYq6
         DeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742693650; x=1743298450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1FOdP+bSRRYHzcPHH0Rlip7ghgqtNeSWLX/OCB9MYc=;
        b=GdAdn/xe0JzEGi5wNJP0V1Gm3MR0obuw1qaw+dWlSBQMUA9oHOK+E2MZAzX3d9vsEs
         g3FX7bLslBi8msJ5nJipfaNdCF79AMaZqk4UJDmjCtcs/57QodHXKgdtmOaqY+UHHWnU
         rU2PhFTOKr7x8uRtxMQwpwC5eSRl4Bo8DRBOysFsHM2wTz++h7wUMANBay8QoVI1YfF3
         wIbrl5aLfwKkCncgXHpzNBOxRObm7UgQwQaJCOBJNtVxRcpvMRiocu6i+N11h/4JVNWI
         EOSVbtNkJx7vsUkBSzadjZxkGK4nE82QGfEiwIRflExguTL2lnL8bIGR1vivRzGHuaBg
         AFHg==
X-Forwarded-Encrypted: i=1; AJvYcCWqKQIeXBRllXSK86GBVXD5RxLGFCgPU2raaQTQaUjren0ioLui0fDvw5vnFtTBqAPL2qiTrTf5kExbmIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRrN4mNBqOsx9bfFOUhS5Q1SuCUPagOLYVol3CayqtGUGDTCf
	zzPfp0hBQ8X5Y6Nd2Ri/FhNlnBeAcSP+Y0khUmtJizz1r0QgvSYee9emGu/dxNI=
X-Gm-Gg: ASbGncvhutq0ssj4OZ0VD1tlrTUjKfUZhHTic92uC3qnWJ6pcls0tU1nJiDMTZOuFse
	YJ0UumGX3LGyKHNJiz8jrR5xwWO171p30+brwDDSZXhiq+8Sf90KlmBhtV3ZUvV9u3URXwfxQSs
	J7V4LiiD0fs6GZf14WwaLwXI/v0P3ZqCEqju+7iNiw7JRWSsyHZFNto5i+id6QqsCgjamjM9bC8
	rJUYkt93pQERW6MPr9XDiD8Mr7sgAyjBWmZDebkyhWrctj1xgN4qmR+igpFw8az652EC5TtUt0Q
	7pqkbmSwOJM7n3FuXxUVlS6rSWGMTUuhgmRofkMSDCw=
X-Google-Smtp-Source: AGHT+IFm6W1qSo0vmznb+fewsV93cbQiKOUfP1imfL3yQ0EGbxw60fWJmZqiQrwOBv/b8hsnL6j2IA==
X-Received: by 2002:a05:620a:8019:b0:7c5:af0d:97e6 with SMTP id af79cd13be357-7c5ba15c349mr1328914085a.17.1742693649852;
        Sat, 22 Mar 2025 18:34:09 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5b92ec688sm312122185a.64.2025.03.22.18.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 18:34:09 -0700 (PDT)
Date: Sat, 22 Mar 2025 21:34:05 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: page_alloc: defrag_mode
Message-ID: <20250323013405.GC1894930@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
 <20250313210647.1314586-4-hannes@cmpxchg.org>
 <D8MVZ8L12HJN.1LN4G4H0ESLY6@google.com>
 <20250323005823.GB1894930@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323005823.GB1894930@cmpxchg.org>

On Sat, Mar 22, 2025 at 08:58:27PM -0400, Johannes Weiner wrote:
> On Sat, Mar 22, 2025 at 04:05:52PM +0100, Brendan Jackman wrote:
> > On Thu Mar 13, 2025 at 10:05 PM CET, Johannes Weiner wrote:
> > > +	/* Reclaim/compaction failed to prevent the fallback */
> > > +	if (defrag_mode) {
> > > +		alloc_flags &= ALLOC_NOFRAGMENT;
> > > +		goto retry;
> > > +	}
> > 
> > I can't see where ALLOC_NOFRAGMENT gets cleared, is it supposed to be
> > here (i.e. should this be ~ALLOC_NOFRAGMENT)?

Please ignore my previous email, this is actually a much more severe
issue than I thought at first. The screwed up clearing is bad, but
this will also not check the flag before retrying, which means the
thread will retry reclaim/compaction and never reach OOM.

This code has weeks of load testing, with workloads fine-tuned to
*avoid* OOM. A blatant OOM test shows this problem immediately.

A simple fix, but I'll put it through the wringer before sending it.



