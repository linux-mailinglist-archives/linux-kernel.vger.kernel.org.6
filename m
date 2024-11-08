Return-Path: <linux-kernel+bounces-401069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70399C1596
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025F11C2178D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E11194151;
	Fri,  8 Nov 2024 04:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NjN/VemA"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12858322E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731040992; cv=none; b=Z026o49twOT2Pv8iuN47iJ46N8S8VR+mfWERi0bA9kCi297J+FDlQhfU2cl+SC+IgBuLJIhdGPr82D3gKfee1mLJLapL9kZdac2V44cHXBtMWBFchVVs9616KZKl0AFO9U0yNUXqb13CIed357Sl+beZF6ICrJyW2QE+qRO2+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731040992; c=relaxed/simple;
	bh=9yDxC5K9B9ZtqJkKp8CAgAQ0k1aHDoiETdUm0hvKysM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU0n71FkDoSdSb528Gl8HISe4Wl6zzAthgiwSHQuAeic39YHhn/3HINQ2FtfsiyUsCIahmdN8CJ48IUk7wplPSOu5rrhwAbCJJRq97yUhdZryDLeGBLudrf9hfsiyMMPpAU0vdoSfyFQfSlK1UJFzC11ObCzQP7KN6mYuquRhy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NjN/VemA; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso1144135f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 20:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731040988; x=1731645788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8mEDJcXR1a4gzsYHP5bUec4NcrTO1tb8meG2AFh7Pc=;
        b=NjN/VemAFbOuUESc2nGDr1p5xXgacOVUWBZ3fNXCYrwbvLPMDbhzhqT4WjLI0cvk2t
         rKPwSNm9pzGyJI4NepPrpubOndiBVgMNlSh+iJS4Qr09128miriXXkJ1w/BIHQ7B1rgv
         tP2+/Q/6VCLCe6fP9X7sv4JmxlfoPSchEcjdqBLUQ0aAm/laNK9k0e3knay7imZIpqlg
         v+RaZ/LwPMW9GUFrpUDBDoB/aZR93ySd1NV93P+Nw+t3P6nSfKmyoBghlMQJITdg1+wv
         rH+iYDA97SPEJEFxF6QBt1ts4wFQS1CaVtwHJA5+OyUxFo1wFg+K6tjGCktwimkZp9fY
         37Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731040988; x=1731645788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8mEDJcXR1a4gzsYHP5bUec4NcrTO1tb8meG2AFh7Pc=;
        b=IkZJCCjfKAIdKupnvc8Au3gjo93QvXZ8vFKF9CJnMEwdA72Mn+AczdwC5pUrLNYcHa
         QNVB+Zs4ULlOk/JiZ5y7VPZA4YysHHdlFIR5wcd90JUEfqxPIIG4+1w+4ukMyQ8+T9KC
         DsJPXBULuUrpeGFo19z3RUUKIxmWn7PhtMzp7VTpNrlSbp6xNLqBLaDQU0j6LFlcytu5
         KipjTLm1jJkBKudMgkD4uvbnRM0pWQ6/AWdrUhrE9uid5mK5NX5Ck5XgbKZ8uKinjiKw
         P/fqRajSwi/UzkxvAyTzq2QsSz9YY+e4mkkHZ6phCZRtBBglFuNWpIMLiqAhAKxZmVRB
         Xixg==
X-Forwarded-Encrypted: i=1; AJvYcCVGOkgzHAnpZOSkS/PNJA5ESsSdX6OzQHXD9B0wsvnJZj6nm8RJo1ATNSGilzqzv5T1NkxtbY8wFiNELdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0Y/jk8Sk10yZwGch32dNDhCFZTkq8ipRWSoVWZW+1gqgv+P9
	m62WPsVqiAm7ndnL2rO6TeFqSlycTFv25lVQ7RcLtA1PcdxLelm6FtVeM6ioII0=
X-Google-Smtp-Source: AGHT+IEms5Ma1E4aDkMxPG6FC7UojnSZo16D1atkX83FNicW0lp1mBMQ8J1crbcTyumAFhvhXAoW0Q==
X-Received: by 2002:a05:6000:1ac5:b0:37c:cdb6:6a9e with SMTP id ffacd0b85a97d-381f1866f1bmr942274f8f.9.1731040988171;
        Thu, 07 Nov 2024 20:43:08 -0800 (PST)
Received: from u94a (39-15-25-255.adsl.fetnet.net. [39.15.25.255])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6eacc8a30sm6848165ab.47.2024.11.07.20.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:43:06 -0800 (PST)
Date: Fri, 8 Nov 2024 12:42:54 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, cve@kernel.org
Cc: Tao Lyu <tao.lyu@epfl.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52920: bpf: support non-r10 register spill/fill to/from
 stack in precision tracking
Message-ID: <emjjveewgoegvinmjmba4ys34vbmb3sp6r6qefv77i5mtettmj@hsvm5vm3qivd>
References: <2024110518-CVE-2023-52920-17f6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024110518-CVE-2023-52920-17f6@gregkh>

Hi Andrii and Eduard,

I'm trying to determine the security implication of CVE-2023-52920, or
more specifically, what does commit 41f6f64e6999 ("bpf: support non-r10
register spill/fill to/from stack in precision tracking") fix.
Superficially this looks more like an improvement to the verifier.

On Tue, Nov 05, 2024 at 11:09:19AM GMT, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> bpf: support non-r10 register spill/fill to/from stack in precision tracking
...

Before this commit, precise tracking of stack spills/fills was only
supported if the frame pointer register r10 was directly used (and any
offset to the frame pointer had to be presented through insn->off).

In the case where r10 is indirectly used (e.g. using r6 where r6 = r10 -
16), backtrack_insn() would simply return 0, implying that precision
backtracking has completed; which technically isn't correct. However,
since any register that is stored to the stack is already marked as
precise in check_stack_write_fixed_off(), the verifier would not miss
marking registers as precise - it would just be much more conservative
than needed by marking more registers as precise than necessary.

In other words, even without commit 41f6f64e6999, it shouldn't be
possible to craft a BPF program that tricks the verifier into
incorrectly omitting precision marks, as the verifier would err on the
side of being more strict.

Without this commit, the most significant impact would appear to be that
a BPF program could trigger warnings as reported by Tao Lyu[1].

Does that assessment sound correct?


Thanks,
Shung-Hsi Yu

1: https://lore.kernel.org/all/20231020220216.263948-1-tao.lyu@epfl.ch/

