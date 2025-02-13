Return-Path: <linux-kernel+bounces-512190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8DAA3356A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6892C3A79BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A41EEA4E;
	Thu, 13 Feb 2025 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dm1jcDdm"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7321553AA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413105; cv=none; b=jmw/2I2WQnjU5898BOHXO5P8nRdeL6SiXEOAP2j8OWeKDPxwhEqDuqNLm8d3PTN2PuPnmI1/hys7lxv3fBCwQbfsimIP8hIzYaGdk54x9yFozNa03xWAJnWnorqfnqyGkkvOR+cICRn/xO2vl6wQ69c4dWsLpWEBjGgvth2VAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413105; c=relaxed/simple;
	bh=uc35jayGGffuOJi4y2IuWvYl52coHl0i/GDgIrz4vI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2OQAPgClAPr1INfutnDOvtgNrkWNuRHgNLjKyARXwZK+T/6pKtkIPse0JZbX7c0vBe9tFGllYIMRMJUfUku/rzk773z/bQj1ZzT6WcdVlGiIfRVesdUIGqD4daOEOxYttMB6QGyv0FT3yU1wVsbSL+7eMYxu1jgr1mKmbczULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dm1jcDdm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f55fbb72bso5120235ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739413103; x=1740017903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkUeuhghmcEnfGVNHiIeQglmuHdFuUx4rGyU3t8Jt0o=;
        b=Dm1jcDdmviT69G4KGYIXR8bjB/kkxwIE8StJ4VW8IlpdRdxiIsUySR44g/v8LdCDUd
         JRE+tj8AsPRdjimk7YKIR/En5x4ZO8Q4XM1SvxRVuXAwpR3sOyFnUD7pbvY8REdFVXTR
         KoBYVzc+buLtYHX39zZk90oh+n3x+LfJJUX04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739413103; x=1740017903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkUeuhghmcEnfGVNHiIeQglmuHdFuUx4rGyU3t8Jt0o=;
        b=WH++NIV92cEZaxgWklaNpo4rLTZAv6wQRRk9Eb8PG0jr/KxF1Jn69dBR2Q7LI2FTvK
         G3V6+KCzKLp2ZDEjuBHRngLtruzm1TQFrBpk0hq0bKH4Xn+uicKEApUWd/fUCK2I4/tN
         ncvjG39vKa7PAnsz2F3RiqrIucnT0hDo6jtj++EKlLRAk3vDl7AxNL/OMLnPrybFUHQM
         TLU+ddaqqax5ATMLE+8GAde/yee3wVAA08wpCD2L1qn5lR+p/Ko6ugeoLu4qKXW5yX9z
         DvuNpzlQd/RcM4sRStH1+/PRHRl5Z59waacgJW0jtYy5uy7oZsXpj6bSK7uhspW3ziR3
         KMQg==
X-Forwarded-Encrypted: i=1; AJvYcCWInENnwp609BJsNrWsD16dbzAfY+UISKL0Cncw9z8IjFSg24EOAoA79MEpjddJ7VyMM0rIAx/53jUE6sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYzm14uaqHZORyJEZPOXkHm3xrUhHsSmgEHa4NjrBPz6GSRWUp
	9KzoPxLIQqFSB3VKY7AKYxi88grbNmi18sQFgP0GO9/VmOMZ/rspA8TIUKmgSg==
X-Gm-Gg: ASbGncs6yMBquZAakcNxruMPlUkEbZk5APND19mKE14w/nJj2k57iVFV1wpcPNK2jXn
	xNtc/0KvRa4gtwiLuMT+EVqmYWq0GbaPKEZJwz40x4jG+eT5QcChYGoWuFY1h06y3pu6VPJfqdV
	xHsdhm8sFMAKksDjckQKLSyZ9/D08zCCh9KRduEStILDhrsHgq1Md3lUT2GkwW4BDVzt+5Sp5Jd
	SVOe/ftuVwkYC4IaCTF4Eb6yVks2b4zeodCfmz2VYffg651c90/s3fAZm3bFPNOkEsQm+7Q8Usf
	J9bgyHmwfzdfohiYoTs=
X-Google-Smtp-Source: AGHT+IFKEsKRkcJBjJ9UBAmjrpddU0JOq3nBRfAEG4b1jepZX6eANv8fec6u27NI43K9+bX7dEx+MQ==
X-Received: by 2002:a17:902:dacc:b0:21f:7880:8472 with SMTP id d9443c01a7336-220d213ef7bmr26597255ad.35.1739413103415;
        Wed, 12 Feb 2025 18:18:23 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3ed3:97ce:5f5f:1f61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536738csm2123775ad.68.2025.02.12.18.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:18:22 -0800 (PST)
Date: Thu, 13 Feb 2025 11:18:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCHv4 14/17] zsmalloc: make zspage lock preemptible
Message-ID: <rbco2k74plqedtqvn6ebu6wwssy5urw5mjvsk6n576d3urbjnx@tq43anmdvq35>
References: <lxottj72e7jcqw634qwudpsyqckfrvpmlhra43en4zlrlz4cip@erufv6w4n5j6>
 <Z6JMIKlO9U5P-5gE@google.com>
 <6vtpamir4bvn3snlj36tfmnmpcbd6ks6m3sdn7ewmoles7jhau@nbezqbnoukzv>
 <Z6O2oPP7lyRGXer_@google.com>
 <6uhsj4bckhursiblkxe54azfgyqal6tq2de3lpkxw6omkised6@uylodcjruuei>
 <Z6ThGFt6wyNpx9xi@google.com>
 <wnffho5jguo24wfy3qv5tvovoargezbu4kcvpk43ludrhyfo6i@6ogtvk5ivfjc>
 <Z6Z2l9uovxAiED6q@google.com>
 <droaoze6w4atf7guiv6t4imhcmkpteyvoaigdnw5p3vdg75ebx@m56xi2y527i4>
 <Z6y_3xS_8pmZ2bCz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6y_3xS_8pmZ2bCz@google.com>

On (25/02/12 15:35), Yosry Ahmed wrote:
> > Difference at 95.0% confidence
> > 	-1.03219e+08 +/- 55308.7
> > 	-27.9705% +/- 0.0149878%
> > 	(Student's t, pooled s = 58864.4)
> 
> Thanks for sharing these results, but I wonder if this will capture
> regressions from locking changes (e.g. a lock being preemtible)? IIUC
> this is counting the instructions executed in these paths, and that
> won't change if the task gets preempted. Lock contention may be captured
> as extra instructions, but I am not sure we'll directly see its effect
> in terms of serialization and delays.

Yeah..

> I think we also need some high level testing (e.g. concurrent
> swapins/swapouts) to find that out. I think that's what Kairui's testing
> covers.

I do a fair amount of high-level testing: heavy parallel (make -j36 and
parallel dd) workloads (multiple zram devices configuration - zram0 ext4,
zram1 writeback device, zram2 swap) w/ and w/o lockdep.  In addition I also
run these workloads under heavy memory pressure (a 4GB VM), when oom-killer
starts to run around with a pair of scissors.  But it's mostly regression
testing.

