Return-Path: <linux-kernel+bounces-568820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DDFA69ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0096E4282EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BEC19259E;
	Wed, 19 Mar 2025 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHskQM3x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2431920C47B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419275; cv=none; b=u90Ui70vDrnrq1cbnG/cHczeG2L5aLe3NiKmlASmURZ5H29eREMGIkA+VOr0b+VEPq83fdFDNqoboaIQ1rJ08tqnFfNTevXRwL+RmLiZQEAr6Z+hPwDCYUbzvfTKipOyiI+j3t5GtQKFBtDWRrSGjgZSczJ6/MYac6YR4iKZlWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419275; c=relaxed/simple;
	bh=HMbgGCsuKeJaEf/xCUb+Bjd7Q9sYLjr0dcO6CXChWvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXTqcYymkgAuk/ixmzjbv1IgnPGY0+Vl3+gF0nFNyVssU0Qfb5CEK6r1p0Frz5HkOup4c+lkKcApyuG9iqgbStRTeUByYWw6VIRO2ZYcEMrdNus8Q6BvjuKNWiCjWRe88V/LOCJIvAMXv1grrpKWWzYmSFhPfevZg7EPGVQcdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHskQM3x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742419273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2hxaIYTY0GjVflh8gcVmWThYCrbWSu8r9v+XAR6H2E=;
	b=KHskQM3x7vgjsxsJOuFkW5WWLi4AW3w4ccbApPTazsTvzabtHglwH+wmGqXHaISQYrBcPa
	6pKrjZoJxAa6Tb6Yl0gOSxjxlisgFfSvOzmXW9oChUItE+yLJEmVulrcFDqObT+A4vu17+
	T45SC0X/Yr2C7y7qIsUjI/Vi+oqiDAs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-UIlB57qmPSOCq9R0NdX11A-1; Wed, 19 Mar 2025 17:21:12 -0400
X-MC-Unique: UIlB57qmPSOCq9R0NdX11A-1
X-Mimecast-MFC-AGG-ID: UIlB57qmPSOCq9R0NdX11A_1742419271
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39135d31ca4so50289f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419270; x=1743024070;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2hxaIYTY0GjVflh8gcVmWThYCrbWSu8r9v+XAR6H2E=;
        b=LGKKRDLJ3fdSRfiPiJm5QfkYtlECLdbL3DliqMjhkcqEa1cxyDwwLYChTxfOLzY5Oi
         gVo5I7Plxb8+RLoq3VqJEdlr0y3HN0B3TALgTAAS0M7nHradBo5fJeb5TrKYnjBwJZHQ
         MG//wFk6XUlscQKEOhmF59NzYhgkOaWZeXsm/BHUEEjiNbNb9603mLGdWIUN2/DjroFg
         527pXjRAKl7ML/krb6rE2sL/dYmeBkzJkXXz18DhBroXCc/28N8SD1bFdnb83gmkXwq8
         2bKvgjqB3jrNLyk2ZxNUQ7x5i5CtoioyzljGryWBPFt5rdWaZvuuocwzQQqkjDMikang
         Nf0w==
X-Forwarded-Encrypted: i=1; AJvYcCUeHADqdbww/w5HmTJzdeZdgFwp1O8RnXoi2po8yvi+4qj19IVyiUx/TNFVn+CojDqoesqHi/Fcs9HBEc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySz7tpe0e42E0HJXwDGWaM2GYociXyxlmk/TRdXnxofe5uppLS
	VxdbeUiVel47aVnzMWk5qr7snlTAmJlSMCGs2hO12GAIHuZ1Gftcbs6MFo2vS0IyWwqYIwVMJMi
	p1qSDHlk4TIUTAd5X1dNnXksEW8V/RXYMuTR8XYeb15GFwdZrSSmLQ8Yj70Y8eSpV76PGow==
X-Gm-Gg: ASbGnctQG3ZLQ5ksmjNC8bei/0BKjP2jImlje3Vbe3X9XMV2orhfy9s6UZYz/rN61Yd
	eFQwRZqT1BWYqvk/us9Y0PbgVutZJsR7I1+35UPn1Neh0seuY1LLsiQafFTSpgeZuT7Dt4v29MP
	StkVNwzUF+Lzik7HgmDq6LVDBELn5fLUyaIQmtFpLd7n+NL6c8OqYxLt6KzjjC03xT3XQRvoEFu
	YHyeV+oyRwk/2Ej8Sw16knIVITYnB0px6GPOPRl6qOJhiQJbaeycT+iwx3yJTrm+1CsJQABHHF2
	wVLfdhFl+g==
X-Received: by 2002:a05:6000:18a6:b0:390:e9ee:f27a with SMTP id ffacd0b85a97d-39979584450mr995066f8f.28.1742419270407;
        Wed, 19 Mar 2025 14:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExhzW9zZnUN2tPz7Fqf6gRe+qwJOMLcgOp2MJcenPvh8K6lyAKT8Ns0f1qp/bUHCnlP61Hng==
X-Received: by 2002:a05:6000:18a6:b0:390:e9ee:f27a with SMTP id ffacd0b85a97d-39979584450mr995050f8f.28.1742419269928;
        Wed, 19 Mar 2025 14:21:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebe3csm22319800f8f.99.2025.03.19.14.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:21:09 -0700 (PDT)
Date: Wed, 19 Mar 2025 17:21:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, arnd@arndb.de,
	gregkh@linuxfoundation.org, brueckner@linux.ibm.com,
	schnelle@linux.ibm.com
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio spec
Message-ID: <20250319172004-mutt-send-email-mst@kernel.org>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
 <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
 <649563cf1b8abd42401ed78d84bfd576d48bdbb8.camel@linux.ibm.com>
 <f27debf87882df65574f21cfced31fecf1dd1da3.camel@kernel.org>
 <dc3ff60fd16e5b5f94c12cf6a5a7893b94f705a8.camel@linux.ibm.com>
 <20250319105852-mutt-send-email-mst@kernel.org>
 <20250319181308.365ee0ea.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250319181308.365ee0ea.pasic@linux.ibm.com>

On Wed, Mar 19, 2025 at 06:13:08PM +0100, Halil Pasic wrote:
> On Wed, 19 Mar 2025 11:00:06 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > > I was mistaken in my earlier reply - I had missed this
> > > > virtio_console_resize definition in the spec.  So indeed there's a
> > > > discrepancy in Linux kernel and the spec's ordering for the control
> > > > message.
> > > > 
> > > > OK, that needs fixing someplace.  Perhaps in the kernel (like your
> > > > orig. patch), but with an accurate commit message.  
> > > 
> > > So should I send a patch v2 or should the spec be changed instead? Or
> > > would you like to first await the opinion of the spec maintainers?
> > > 
> > > The mail I initially sent to the virtio mailing list seems to have
> > > fallen on deaf ears. I now added Michael Tsirkin to this thread so that
> > > things might get going.  
> > 
> > 
> > If we can fix the driver to fit the spec, that's best.
> > We generally try to avoid changing the spec just because
> > drivers are buggy.
> 
> I think the call if fixing the driver is possible needs to be made by
> the maintainers of the driver. Fixing the driver IMHO implies that
> if this is seeing any usage in the wild where it properly works a
> fix on the driver side would imply a function regression. But any
> implementers should have complained. So IMHO it is not unreasonable to
> assume that this is not seeing any usage in the wild.
> 
> And people would still have the opportunity to catch the regression
> during testing and complain about it.
> 
> I agree with Michael, changing the spec because of a buggy
> implementation should rather be the exception than the rule. And AFAIK
> it is not like we have declared something a reference implementation,
> so in that sense the implementation in Linux is just one implementation.
> 
> I suppose making it runtime configurable via module parameter is an
> overkill at this point.
> 
> So based no what we know I'm slightly in favor of let us just fix it
> in Linux and see if anybody complains.
> 
> Another thing I noticed during looking at this. AFAICT Linux does not
> seem to handle endiannes here. And AFAIU the message is supposed to hold
> le16 that is little endian u16! Maximilian, is this in your opinion
> something we need to fix as well? Or am I just missing the conversion?
> 
> Regards,
> Halil

Agreed, still, please do a bit of research on open source hypervisors
at least (rust-vmm?) and include the info which ones you checked.


