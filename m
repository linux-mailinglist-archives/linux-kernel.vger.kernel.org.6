Return-Path: <linux-kernel+bounces-539660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFE6A4A6FC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303EE189CEAA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879A81401B;
	Sat,  1 Mar 2025 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ToxcIgwB"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79843A926
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789013; cv=none; b=L1uJbupBkOlmtXaZVJPNzoU96zCHZdkdVWDbtqKIqb2jwakvqkLk5y/0VmB9ODooW0U71E9QHCQZDSgMxRi3mWWUwXniunKWpzRFmcdAd4lWTsRtBcDySkqv7RlM88opt6EFt2Rd1YrJjKbcpk47scj0kv0ob42AAleWIoQweJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789013; c=relaxed/simple;
	bh=FZkF3GDM9Co50Ilt0+rIiJqCj1sUDXhtjC6soaQyIto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHvfB6fZPoTZtB/3YQktzrAwD4KRXBk8VTiiUs2k8GAANcTNyj3l2GYJfu4Inu4SzCYPz6t2Np2YJOfJ9z2BtQNilj0cdwoysij2yvcanHT2mwT6/RYNZFg97oVToDtmRIWt1j+PLUmsOhTgbjC1M//140tBDnma6heLBzekk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ToxcIgwB; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-472180fec01so27888041cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740789011; x=1741393811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZkF3GDM9Co50Ilt0+rIiJqCj1sUDXhtjC6soaQyIto=;
        b=ToxcIgwBZa5Y4Xfz+fYUCsTYGbroHOttcem1B9019DL9MINjMdAUU4KLHzcnHFrnpM
         Ck0FYt6pw6Qtog8Ncwn8NmtJ+sE88j+kND/mmGSXfA4xXRJtTda/2RYMbl84iYDVJ8m1
         JdPrwE2PplqQPyaFAy70e3+eqBqweLAMuXRnWx3f/rd4hszEwDPaJnGXkHYo4Vhn+JgM
         VQCJ6tBdEhZ9r0cae0PWoYK/SEh6w6hFELn/6v/3mBKmH8wxpAk47qaB6Qmm8SVKVW89
         JlzfQ3vXSvhxfU85tBIEqnMvaqQeI2ht2pOPdANLBEn6k+jJUqHtcqfvhAbULj1aPpWs
         epiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740789011; x=1741393811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZkF3GDM9Co50Ilt0+rIiJqCj1sUDXhtjC6soaQyIto=;
        b=DohufGSJFy+ZObpT197j03t6clR7Gbh3toEbeSMDdywM+wY0Xt0/jejE1yRSzgseuf
         x5WRZiM0quuR4Qb04rW5l6m9Mz9WzrKpWTGT3/peeiyYcQQYpg14QiQujA0T0O2jyBjl
         j7gcdy/HX6zKWrT34BUiZ+hNS5Vab/Qgylud9LdTJw7owFGU3oX/mbsq2P3oqVVE4zzT
         0/zT+TgZPGFZEA55Xf5LmADutJ5abrQZY2cW5ECsyPlml9SG87e6vOgnt4yiKUYPlYK/
         4KCEKMu7ouFnP19EyHQPolShs98QKbfxq8TdtlfMZAsEMn9Xyn316hnP1y2MOpx/szvj
         bTQg==
X-Forwarded-Encrypted: i=1; AJvYcCUWxhTY6lMj8IbuSaDg5cA1BGQSK2RF7dNY/kfTxrUC4a39AUpkL6F1PZKvAoRf3WF/qqSwxtoFEAX41WY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63ya8qsPTO8BtEZdxHAz9TZVT9KroJYwHachlgVaWfE5uAaL+
	RKIA6Z30bAsbjV/DjBn3L5UrYShX8AYVxXYAiGcZ0/QWpag814rTSXJK+an+ym8=
X-Gm-Gg: ASbGncso0N3TElQMIC27f5V9gxnWj8tM6uR8EQMMF+Wq4LKZ659Tr91pQatiDdypHGb
	VQOiRCzL06ShwGjKj5StrjDJZ75aGgUI0QoybR+ffcz5JMKuM25I/qJku/ACXXGUjL/gMkKelsX
	QApywvogjpzoZMZun5ntry57YJIzuqj3/XWTn3xZcsUnlrJAEm7jWSDM9An9zDmsW0O8r120S/P
	DsQN5yUCknZ3RpHpEMm12LROD3HwcU9STY2jhW377PdkHevl7JiibkYhWrMIEufgtUXblERkVo7
	Mq+WmG5TdYNjuepU8q5GXczV2dFfSHsvQRuUa5aHY71tucO4lX5mVytJdHQ3O5Mx5/sIXzoP4sP
	MjqGgs5TJ3D1KfCbmwg==
X-Google-Smtp-Source: AGHT+IGoKXhCq1vdLsUCIzF4lunmHcwYw+D3mRuNmPD/25PERj7Y5vHDBX7k1/qClqDvWD+UHansAA==
X-Received: by 2002:ac8:570b:0:b0:471:ef27:a30a with SMTP id d75a77b69052e-474bc08cb95mr87868941cf.28.1740789011339;
        Fri, 28 Feb 2025 16:30:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721bf857sm30749961cf.38.2025.02.28.16.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:30:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1toAk5-00000000VNV-3jdd;
	Fri, 28 Feb 2025 20:30:09 -0400
Date: Fri, 28 Feb 2025 20:30:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 0/6] Enlightened vTPM support for SVSM on SEV-SNP
Message-ID: <20250301003009.GP5011@ziepe.ca>
References: <20250228170720.144739-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228170720.144739-1-sgarzare@redhat.com>

On Fri, Feb 28, 2025 at 06:07:14PM +0100, Stefano Garzarella wrote:
> I put RFC back in because we haven't yet decided if this is the best
> approach to support SVSM vTPM, but I really like to receive feedbacks
> especially from the maintainer/reviewers of the TPM subsystem, to see if
> this approach is acceptable.

I didn't look in high detail, but the overall shape is what I was
thinking about in our previous conversations. Very little TPM code is
under arch/, we have a nice simplifying helper in the core code, and
you have a tidy platform device to tie it all together.

Jason

