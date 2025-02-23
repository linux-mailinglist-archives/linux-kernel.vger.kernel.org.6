Return-Path: <linux-kernel+bounces-528000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519DAA4124E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4438D1723A9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE29020013A;
	Sun, 23 Feb 2025 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/AP4ldu"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592410E4;
	Sun, 23 Feb 2025 23:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740354351; cv=none; b=FeleJf1IJ2o8wOpuD3k5YJWX4Y3Xn6zgpeBF3JX2/OnEBLGGmlSujVjFYSaJ2Nv4XXnap49xH/t9wJbUnccYQn+CnfG3vEjDQL/zeA1yZL0MDSGw52AxLsIs2oHyYttzSX2hF8KdtL77ogeGkaO/DyY01HJ+IykbLcw5NNxw/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740354351; c=relaxed/simple;
	bh=wY1xWMM/k5JTNZ/FzkmzKc7FAYv1gWfhj4nswE3dxFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4T4lh1BqQejX8NAAU0CR8mlzw1De3W7sF+HoQQnoZkvLkOCiOpn0dwTpSc0ZZc3R2qlpyUe/VgJG8clH9+9EntugSbGCGrcF5NqSKbAZaOUgC1yVDs725vM8pd5rddO8Mza6J/o7GMfRdf2+cSrpPKSKPRRUSa47dxlFmUgCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/AP4ldu; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e05717755bso5841568a12.0;
        Sun, 23 Feb 2025 15:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740354348; x=1740959148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCP1rbXh4MlA1hNlKO2PRwztVgKcVUG68KyRAFF7PGU=;
        b=K/AP4lduUdvGm7okk/tuuB0fRszGs3vOmXFEaAkQaN+Isczo4TZHW5BCzlxCzo3/AE
         4KBOYZfxoafW9H3Gdn8vO6ExuwRfeCBpFRZLeZ3G8IZg52EFXk+1ZmGyKGJVIwtr1SQS
         98SEgfA2aWOfs2dq4KmFORVYwQQYnB2oa3GZZrJaTNnQHr07RcJrWQBdQWbieB5PvIHb
         6pqfWz7qyK3RjEjWIZNvK4d69+iRYrimvsjifWOvLbcspi74bmt49AiAPnNoel4Nkqjt
         lkroIMesrymypH2LgK7VJhscxQ07sPCrvwwN97ix9ZU6ftNrgpa/D5C30AaMw2V9F4iv
         k37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740354348; x=1740959148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCP1rbXh4MlA1hNlKO2PRwztVgKcVUG68KyRAFF7PGU=;
        b=b74ww3qYhWh6cqz9VBAusH+ZD5lt/bxIuWP2IQe0qvrvn8rJJM81ODpK7e2XLwi4wb
         yzQ1obVZqzOXybwN/907HNd5JLMorEDAedQlH8pRPiv5ZIC/phdnJniRW9mFHSakLTVW
         8TmU12pFm21R0uiqUHkiitFZjts1S+6SVIjv2+L62tYTStzfDGtFOmG0wr5gUW5eTV3f
         +b539GEVYXmebuuLq9aUSn3tHTQQkoS9bCmikPkKjnEvJ+yW67k2zCpLaxBmAnzlpMS7
         Y5tzdmnZaRBawxCGi5NhvS1IjiFfsl6cfyz459CoDXbdYAabWq9diWOpBU0CeFTdW1Sj
         Ve9w==
X-Forwarded-Encrypted: i=1; AJvYcCWwrk4qRXJB5db+y8O5j+ctgSS3G8SiKJsbVhkNlXQkiXTKy5p8mjpuJDHeJkRi3ulHSxMi7KTKElX9ss0=@vger.kernel.org, AJvYcCXW4caBOuXIXjgoznAZnzCDX03kA0dclzDy2Uu7fCrsLWlsZyw+H6cgEdllKIiZyZMs2lItJuSnwDui@vger.kernel.org
X-Gm-Message-State: AOJu0YzR2cCDZ+qLH+uKPv02DQHz7/6aQZul/qozt/apD/jtHbWBKOrN
	2PpwOekCYFyn5LC6XMHmmkZtjvrGviTLC7FSiqJA/JUfClvzZIlp
X-Gm-Gg: ASbGnctnd0TMUstY+2rGE7DAkF4SNetK1C+tdCebSm8xoBn2XCzCeJ9baYLcOSgn3BQ
	+uvcH9ButKuwFldcdvvpU6yNhoilG/RBZPDUbcKOn35Ybi3hy2CwxadKCduoVsUgsorCivqTU+o
	X9m3OWZmRHbxgyynMUGibRFKTnTk8jYkCacGb4RqZu59boa2m/S56/tCeoyyelMwxwx9q/ASJzU
	xavozqHYKAsziixoKyLqeW4CG467uHeln+QBsRFW4xyZ3e3viJetMe9lZ3aEoFz0VKqxs0F1zZL
	pivcvGVTuOSbaFjaVwqO51h2JSmGgTruAGe97N6qLos=
X-Google-Smtp-Source: AGHT+IH5JTIGwwSbS6Io23GNPvRRsNaxcEO37VuXDdJwJd+0n+ZiS9fQzLm+6Ov5yiWBfEV2hyojwA==
X-Received: by 2002:a17:907:6d07:b0:abb:c394:63ee with SMTP id a640c23a62f3a-abc09e2c50amr1043158766b.55.1740354347437;
        Sun, 23 Feb 2025 15:45:47 -0800 (PST)
Received: from foxbook (adqm166.neoplus.adsl.tpnet.pl. [79.185.146.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb72b519c5sm1736839066b.173.2025.02.23.15.45.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 23 Feb 2025 15:45:47 -0800 (PST)
Date: Mon, 24 Feb 2025 00:45:42 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: xhci: Unify duplicate inc_enq() code
Message-ID: <20250224004542.5861d4dc@foxbook>
In-Reply-To: <d59a6694-e0e7-46b7-874e-0c6acd8c9126@linux.intel.com>
References: <20250220234355.2386cb6d@foxbook>
	<20250220234719.5dc47877@foxbook>
	<d59a6694-e0e7-46b7-874e-0c6acd8c9126@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 16:54:11 +0200, Mathias Nyman wrote:
> On 21.2.2025 0.47, Michal Pecio wrote:
> > Remove a block of code copied from inc_enq(). As often happens, the
> > two copies have diverged somewhat - in this case, inc_enq() has a
> > bug where it may leave the chain bit of a link TRB unset on a
> > quirky HC. Fix this. Remove the pointless 'next' variable which
> > only aliases ring->enqueue.  
> 
> The linnk TRB chain bit should be set when the ring is created, and
> never cleared on those quirky hosts.

OK, I see, there is stuff in xhci-mem.c. I'll remove the above text
and any code which touches the bit on quirky HCs.

Speaking of which, I have some evidence that NEC uPD720200 has the
exact same bug as AMD, namely after a Missed Service Error near the
end of a segment it fetches TRBs out of bounds and trips the IOMMU
or stops with Ring Underrun. Link chain quirk seems to fix it.

> maybe
> 
> if (trb_is_link(ring->enqueue) && (chain || more_trbs_coming))
> 	inc_eng_past_link(xhci, ring, chain);
> 
> Avoids calling inc_enq_past_link() every time we increase enqueue,
> and explains why we call it.

I can do that too. By the way, do we actually want this while loop in
inc_enq_past_link() at all? Currently links only exist at the end of a
segment and always point to the beginning of the next segment.

I noticed that per xHCI 4.11.7, "Software shall not define consecutive
Link TRBs within a TD". I suppose "consecutive" means "one pointing to
another". And if it's prohibited inside a TD, it will likely always be
easier to avoid doing it at all than try to manage special cases.

Regards,
Michal

