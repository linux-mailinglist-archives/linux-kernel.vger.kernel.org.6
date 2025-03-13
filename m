Return-Path: <linux-kernel+bounces-559999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0DAA5FC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52787179C40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312A268FF4;
	Thu, 13 Mar 2025 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="d586gfzg"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3158126C03
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884487; cv=none; b=q1P/xVOln980r/niSC+580cUMYXmzFc6tEMetgRh4595abGLjeRJ9L4Esux0+XdOIvzIsI5mfP2tdy7okU/2z4QPYd/EXwVZlHEoXMkEenAFjeS+W0KS4T1b8N+VpV3+BzJC9ImctD8YfFLihDj0lb1RcPVjSc6BQchmHR6fRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884487; c=relaxed/simple;
	bh=x3SebGT4/hVZ6ltP0nnoHVJ04fj2Ha3ZkDNmZkkZT7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh6uDZA7D88imzNrWMJjhfv54qYLE0oj1jRxpy0yIHhqAU3OjKOvPyGWnsd2DOEZQ8+XZ/E3yBTBTlldekSki5hHEw7c1yaVv12Nv5FMhfaf0MCtcYOIr9JQCVPmBCE7CJrojpRUUutlhpeubQVr/37PuYXIhFj9VvQ8hqVI9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=d586gfzg; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c559b3eb0bso72713985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741884485; x=1742489285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gWJHqAH2Ne74hFxjKFTiD545xNbJagX+7KeghzOK3g=;
        b=d586gfzgfJyhVxd4XNlQfktvSGS84dn9PeUraszwv1OEJx7IcCbtFXDxvjLQhY5cVu
         My0MM1JnR4vDVmoLA792wLE8Qy0EFhS5MFeUhwrTtpnVxrOUDiL8TiqEdbBEqz/tOD+u
         FkdETLEl7q2fVDZti1IggUUOuBH9b8rDGOp2mRjbhkw+mdCUXtAj6saoVlePaaivG95a
         RxpvGKs+YOyqPPRwkMFPZRxyzlZGzSUkVNqPzrJ+AUfFC7UZoxDF0Z3YfVbZd4nTleba
         c2Erep2ekCflJVOnd3n7XiiPVH7YvCOUJzB/B9bj1cyHS/TKyf0jhXatHk0UqgYWXkkZ
         aYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884485; x=1742489285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gWJHqAH2Ne74hFxjKFTiD545xNbJagX+7KeghzOK3g=;
        b=gL6kqrZKmZP0VsycpS9RxFk9ZGQOhoqWi1saJ9CGMukpNB7k7Klt3ojX2tMXcYQyeb
         bC/Tf8OfYJn6AsELD8Kqta6HnE7Hmc1Swglx30/EPZriTvvyunCWF88/g6cgkgDZ19kY
         v57PJrVoFhrUGho0zkmH7X6vtuxRc8d691MK6X8Zz+tRa3VpywpCJvOmH8K2Tra7jArq
         2YkSm2uRtKqdN4jWIcGjctAsbcdCqMtRWizCcpUANHcKJkVD8C9OXOzvkf59UrfV5O5X
         f3ZMjbR2RGEZrrOYutCJxSyqZPfiX+pLykBZHUHtwrbtI839hida9yaKhIhWvJ0gvR6k
         xWuw==
X-Forwarded-Encrypted: i=1; AJvYcCXsrauKKRiyeNI7z7/obYjBHKx9rhxFHP5ODGZXDd+4IaYXVVKkvS7+SeTvq/V3h0QSb9wILrSorCdOuHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwpm0kSW96qvHrPdrhBS4n2l4iqo9ePLBDrUKYCAyPqar0a3Eu
	8HnNTEHamiKvd/+gDZd0W9y2SfhdokqC0r3tPzjpPu8qDy9uOcCXHtE4x/gR1BY=
X-Gm-Gg: ASbGncstPQPn9/B+mRtVzte8z+1hXYGIrxD8h50FUzB8e9NSrZlSU0cia05LXZpTCP9
	9VzxEsuldE5SmDyFzpQQgaWvvfRGD5CMa3V1pTO6zzNzP+os2G+io+k2hfveAN4MzTVeIfYdlNV
	vujoh2Xdin/x9XpZ+rm9M4oh8kpMdtdEf2msUX1tRt7a3kz65orIpIjHeL5/ohjcpMQw3rxZXRW
	Or8Zv273CfzOMbxY6wm7rhFkQNJNgcdYa6Y4XakXq/NhyZJ4BatFQg46Np3RbfhjiIT/8e+efYA
	pdaZ+DFLo3bwvCmM8EBv8JAMwFLPkRiC7V1KsMHjWVdw20g4WveAv9co5YS0cy8BukCvRduvTl+
	PiUl7C6ipkW6x8uqc3wj0+DIBS+M=
X-Google-Smtp-Source: AGHT+IHxF9ffTb10hBbkPjF4Gy9uvvCTgZFfxO5Mi/avamJ3LWPv9XNw4u9cLuY8UUZaXI1bajEgNQ==
X-Received: by 2002:a05:620a:618c:b0:7c5:64a5:d17e with SMTP id af79cd13be357-7c579f1eebbmr83505385a.25.1741884484673;
        Thu, 13 Mar 2025 09:48:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4f525sm118401585a.20.2025.03.13.09.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:48:04 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:48:02 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 4: Interleave
Message-ID: <Z9MMQjjw_QaOCxvD@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F>
 <Z9KX4/zF6/yFdWLQ@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9KX4/zF6/yFdWLQ@phytium.com.cn>

On Thu, Mar 13, 2025 at 04:31:31PM +0800, Yuquan Wang wrote:
> On Tue, Mar 11, 2025 at 08:09:02PM -0400, Gregory Price wrote:
> >              Window size : 0000000080000000   <- 2GB
> 
> I think is "Window size : 0000000100000000   <- 4GB" here.
>

Quite right. I am planning to migrate this all to a github somewhere
after LSF for edits, so i'll take all the feedback and incorporate it
then.

> > There are two targets at each level.  The host bridge has a granularity
> > of 512 to capture its parent's ways and granularity (`2*256`).
> > 
> > Each decoder is programmed with the total number of targets (4) and the
> > overall granularity (256B).
> 
> Is there any relationship between endpoints'decoder setup(IW&IG) and
> others decoder?
>

I'm sure there's a mathematical relationship that dictates this up the
heirarchy, but each endpoint decoder needs to be programmed with the
same interleave weight and granularity of all other endpoints.

Technically unbalanced configurations are possible, but Linux does not
support them.

> Hi, Gregory
> 
> Seeing this, I have an assumption to discuss.
> 
> If the same system uses tables like below:
> 
> CFMWS:
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>      Window base address : 0000000300000000   <- Memory Region
>              Window size : 0000000080000000   <- 2GB
>             First Target : 00000007           <- Host Bridge 7
> 
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>      Window base address : 0000000400000000   <- Memory Region
>              Window size : 0000000080000000   <- 2GB
>             First Target : 00000007           <- Host Bridge 7
> 
> SRAT:
>         Subtable Type : 01 [Memory Affinity]
>      Proximity Domain : 00000000          <- NUMA Node 0
>          Base Address : 0000000300000000  <- Physical Memory Region
> 
>         Subtable Type : 01 [Memory Affinity]
>      Proximity Domain : 00000001          <- NUMA Node 1
>          Base Address : 0000000400000000  <- Physical Memory Region
> 
> 
> The first 2GB cxl memory region would locate at node0 with DRAM.
> 
> NUMA Structure:
> 
>         ---------     --------   |            ----------
>         | cpu0  |-----| DRAM |---|------------| Node 0 |
>         ---------     --------   |   /        ----------
>             |                    |  /first 2GB
>          -------                 | /          ----------
>          | HB0 |-----------------|------------| Node 1 |
>          -------                 |second 2GB  ----------
>         /       \                |
>    CXL Dev     CXL Dev           |
> ```
> 
> Is above configuration and structure valid?
>

This is correct, the association between memory and numa node is pretty
much purely logical.

I'm not sure WHY you'd want to do this, but yeah you can do this
(assuming you can get the BIOS to produce that SRAT).

~Gregory

