Return-Path: <linux-kernel+bounces-510236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9149AA31A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2B07A22E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE3C4A3C;
	Wed, 12 Feb 2025 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dJUzPjTt"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A06A31
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318569; cv=none; b=lj3v9Y9BZOAVzWkcoAbmCOfG8ESBVevjRd0wBBLYvhHak8zDLfXLQW7JYJThXukI791ML0X/A18f0IotsvO7RUANfL2HrCE9LsoH+4JHxHr0EH6KUjQBvo+h9ecxkD+QBttv/ztZapLAEAU/colkTv23rIIs81NL+MVegnIEYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318569; c=relaxed/simple;
	bh=fMMFv+jSo7zzi7KLoGFNtsOVq+2ktkT4wQ9W9F6Rhc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSKIUAi3LoZqq722CKYPf9LRHUP93rfj1FELOBmo77ZxLjKG38HnsGMEMwBkW4BVbW/F4sDltrTxEdhWZnZiugcqUz4xDpulAnvNPcpeYXQ0XhwBppvX24rVgyLTPzza9s9UISq1dh5nTjXDxDAEmVVEi3yqvFSQZoOPytnBZFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dJUzPjTt; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4718b128eafso12253451cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739318566; x=1739923366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmoPrNZsGcS3Reb5Ece6K60aasyBoOFla2DRA7O2TJQ=;
        b=dJUzPjTtUztTCFH4SWClXrzf6ng8gwdoQ80K+RYd8xbJGpA5mzr1KTDitosZzfaOVe
         kvZ7a6rL43cOjdJE4Sio4hTsK7iXvIicLkiv6G5n3BAWlngz8dQ+qK21KSn7hzjYBPtO
         zuhdL2tlZKLhbzy+MbBE5kJEzcMRg95HfJtlxpoWXlUAoYf2tTeReedyA3lfaA1TJqw2
         kQX7EtdDad+amajBBEUXhpTiQMLTabSH6bsduzgypgRZ8S/PyVm0+UEmwPH8+S8erECN
         ij78Ic8eSgq7ZlLY3lMCi7cyp/MEqs8UHkUEsI3+wKkBj6uCBO8rzjEPxxT+y+4BP/lt
         rXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318566; x=1739923366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmoPrNZsGcS3Reb5Ece6K60aasyBoOFla2DRA7O2TJQ=;
        b=UGz1U/Y5VEv71ZBg23eyNTaUFBEG/y+jqwyMsE3aKJNBIOu8c2KArDz2O28kyL36Ou
         BPD2zCj2J+cLH/Z5pL5X11WPC9zF/mtQ+52NxJqrRMBO2Iil93jCCGUiLKk8pQcZYXDC
         jbwAl67F7v8p4McR+7AbEth1jl0c+c5q0lm/oQ7i/beaXShcJF37xCAVFt+SqgzkOsNG
         JH/5V8LlbPuiHbEObIs1mNNeJ+s/45Ha5o4If1je50dtcJ/OX4g3MkQV1CeqFp2Ua9ds
         tB0cGX3/EA/Dy66OJsk6XmRMmD+9ewji1iS4/o3m+tFjI2QL8jTwIbcgdgMShWs4yaPY
         MtDg==
X-Forwarded-Encrypted: i=1; AJvYcCU1eJ7SzoLqSQv02E8zI/cir+Dy4Be+Qv4x2XxUHu6rfuXO49YULPS8tuNQoOl7VjpA8LqVffU+NqkfWd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYTgVRKlrjAqy7QQblIZu/WrajDXaaadq8THBvvGGF4SwKO36
	XyjW1W+dWeL4i7xZ+rOfwxWMBL/O+jswTR4GeGWc3uw04osD/V9PHbOgpbE1ekA=
X-Gm-Gg: ASbGncsEr1b5x0XmRwEfOLRavcKs7fBBp8Pa4kAhP0Qj91h3HCGuNwbg6JId0LTtXXv
	9iz7PVNVeHzea5ScRQ25v6zMMZwmE2kRv5a8N2Ch/PCUsiXC6cDJR8Yo1bNTu0cQYUCI4vM1q7b
	B/XinMiN2rLSfGxlVy4rXg+SqsleoPqo0OYj8bI8LydsdptGqSIRmAndqWnRhW5sN14jvVnxRQ7
	7UqpK2u9qI7JHNqJANWxFHXc+/jrd3/iu0bmuwEw4BwLZZjIugSK1baOF+lGUHqywYL0jH5XzjZ
	XgQBtsvPB01jqIUtR8ghFHASb3qzbC73eZUHCO3x0I8nsnMdNRvjHxWYUrABal72Xp5K7BImOw=
	=
X-Google-Smtp-Source: AGHT+IEZ3bke8jjQfP0MZWNv6laQYll9viopbjSznSPRl/BmTopl9h8Rj2ahTL9C2o5Xhb2Twsk4aA==
X-Received: by 2002:ac8:7d47:0:b0:46c:9f53:4a45 with SMTP id d75a77b69052e-471afef8df2mr20155001cf.43.1739318565725;
        Tue, 11 Feb 2025 16:02:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bc6c85sm67018281cf.53.2025.02.11.16.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:02:45 -0800 (PST)
Date: Tue, 11 Feb 2025 19:02:42 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v7 06/17] PCI/AER: Add CXL PCIe Port uncorrectable error
 recovery in AER service driver
Message-ID: <Z6vlIhKFFqYKaivc@gourry-fedora-PF4VCD3F>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-7-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-7-terry.bowman@amd.com>

On Tue, Feb 11, 2025 at 01:24:33PM -0600, Terry Bowman wrote:
> cxl_do_recovery() uses the status from cxl_report_error_detected() to
> determine how to proceed. Non-fatal CXL UCE errors will be treated as
> fatal. If a UCE was present during handling then cxl_do_recovery()
> will kernel panic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

