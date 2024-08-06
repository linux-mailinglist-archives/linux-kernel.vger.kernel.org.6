Return-Path: <linux-kernel+bounces-276178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E137A948F80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA051C23380
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14D81C4634;
	Tue,  6 Aug 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gtStb8Zi"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFE1C4632
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948634; cv=none; b=twYWSmAa7ssNEZYHR+MRNtnOnLwFnV1YA9liXwuIZc8OJ9sqoEM43hOyWtMdaY+0JZgxj5+KdKCt/1u3y19RUnu73fuDr77172vDxeTVkn53UabIfpfUs5dXaxxrzhvz5uaXbtqWM26n1VbtgESqLcxBUfJ7cnlfXcUvbHgkeZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948634; c=relaxed/simple;
	bh=hqpYLUbSrBx+Ms4TCpH2o0p5eEmytp3xZzywbQZTl7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ue/spn5pVoQEYy1nhCxCwxNZ86H+2UUFhbD5W+ULmjboTOzeXUM65Q5tXpWPYjNDLNVakIK0X85AsgrzAkEjRB7kkDV5xy3MqO/CdMnmAJJCCPCrcJHMxmcY3VxT9E0pVBT4mfe6fYxvN92aucEL9RhZLBQhnTCvd5Cj+GGQyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gtStb8Zi; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso5573531fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722948630; x=1723553430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XG4NeBcyyPSmjnDlS9tdIhvr8OOHAlf3IVhyAESvUwk=;
        b=gtStb8Ziw/lPlpYxYeSu2smMSeJo4jBUgAYUo/rqOQUhE3doR4/WkAZtlkRLG+pPLk
         gJrMyNfiFeEOa6d3xeoS1lci7WWDal3rd/T9+nILu4/UioanQHoGbmz28R0EtM5DMIih
         /xnxisYPYfLYJ2oFMO6Xk1OkAqSWgH26gBwJxlXSNKVLWVLu9hzL4HA3wKjU4+azrT9P
         zKoJ3VrpTE9XCmhBTtu8UDtMLiuXRW9/F3+2TAnffmBhgjhsMyAmb605HLXsMyf3yzut
         eMJxUx21JdFcTnRjDUffNbBCE9vyERvDgLh6h2PrG+uvTUWbSRKo6vuzoUiNHBIoMDtT
         7YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948630; x=1723553430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG4NeBcyyPSmjnDlS9tdIhvr8OOHAlf3IVhyAESvUwk=;
        b=lktO15s3ZbcA0Wa+nLupcZ0yUihMkChsf4flPe+vDuWWYHgE2q786fFZlZlLjrVRfi
         Gaeeb1FJepyQ6GWe1SFkGqLlKbuVO2TKWTRV+S0lheEgs9d3ls8Y8NkXejlx1f1RQC+z
         ExA1d8r2wvHREvTdrw7EQ4j6fWocIbWs1zY2BN3GNsZdQGYVJVOIEo81oElpdAZDt1Rt
         Z3WcbxNls585mmYKTWgl3gtff/iHgDKHYwLzcSc0DGHQ83N6DBAywX0ZR8iK1Sld5MTR
         kuK19kuTObfUZwSCzyFKaznmmvyV7U5Sym53TbrgorcRl/Yt7h/YcBQzaCGiZ9s6pAcj
         V8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUEeiQ0TZ6vKr/WPn8JvofVFaXBAWEFWc/Rrd1ZjU6sptu/vwtj2/0aLuon/eyfFUMCtEAQd3ndvzz2VD7cXolJa66/Y+VnfvH81iJV
X-Gm-Message-State: AOJu0YyD4l40vU16d0nTXPV0dfPQKiG4YiGpcD9vm24AUWY023NmwPKD
	O0M0G6mUvooopJnpm7hkhBGeiQ6iViopts8HRUintZPTVoM/6YjjxsoRBlPyQ+c=
X-Google-Smtp-Source: AGHT+IFuVifWwaubpKNeGyxJkmF9Mx+7iipbAxcgLHweZl2BmaPRx8s2yz27jRA7TXXZqv9M3cwp3A==
X-Received: by 2002:a2e:8543:0:b0:2f0:19f5:9d99 with SMTP id 38308e7fff4ca-2f15aab0ae2mr110994121fa.23.1722948629748;
        Tue, 06 Aug 2024 05:50:29 -0700 (PDT)
Received: from u94a (2001-b011-fa04-f9ce-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:f9ce:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfaf67sm6914213b3a.150.2024.08.06.05.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:50:29 -0700 (PDT)
Date: Tue, 6 Aug 2024 20:50:25 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-42082: xdp: Remove WARN() from __xdp_reg_mem_model()
Message-ID: <fi2hlrhh5i3sczk5nkhqv7mi7pafv7obajht7waboy5jngbx6f@kjhzqlvkuh4k>
References: <2024072956-CVE-2024-42082-8411@gregkh>
 <25rzouzv3bf4opsbgcbwjn3ycip5s75awl5muu5fzcibwjnv4b@4khlyuarrnl5>
 <2024080634-electable-foyer-ad3c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024080634-electable-foyer-ad3c@gregkh>

On Tue, Aug 06, 2024 at 10:55:00AM GMT, Greg Kroah-Hartman wrote:
> On Tue, Aug 06, 2024 at 04:48:56PM +0800, Shung-Hsi Yu wrote:
> > On Mon, Jul 29, 2024 at 05:53:11PM GMT, Greg Kroah-Hartman wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > xdp: Remove WARN() from __xdp_reg_mem_model()
> > > 
> > > syzkaller reports a warning in __xdp_reg_mem_model().
> > > 
> > > The warning occurs only if __mem_id_init_hash_table() returns an error. It
> > > returns the error in two cases:
> > > 
> > >   1. memory allocation fails;
> > >   2. rhashtable_init() fails when some fields of rhashtable_params
> > >      struct are not initialized properly.
> > > 
> > > The second case cannot happen since there is a static const rhashtable_params
> > > struct with valid fields. So, warning is only triggered when there is a
> > > problem with memory allocation.
> > > 
> > > Thus, there is no sense in using WARN() to handle this error and it can be
> > > safely removed.
> > [...]
> > 
> > The mention fix (below) simply removed a WARN_ON(1) call, so I believe
> > there's no security implication here.
> 
> If memory allocation fails, and panic-on-warn is enabled, this will
> cause the machine to reboot, hence the need for a CVE allocation.

I had not considered that. Thanks for the explanation.

Shung-Hsi

