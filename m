Return-Path: <linux-kernel+bounces-558545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5FA5E76D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570473AA4DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7861F03DA;
	Wed, 12 Mar 2025 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRRTAXAn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433019E96D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818512; cv=none; b=Q05rDCqbPpS6y/0nebVmBaqQ8uZ1kv5JM4BE/77OqSlIkIHxzI6c3Ekx/y0k/2hjOoYHuQS6EMdkBDSIUOavnboOn5PCsW2dccMRBQkqOYTrFjs5CiP6LLm8RLJfScG3BsX49H5VLRtGoOyi7c6duYz5L5iKEzboevJ0rIudY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818512; c=relaxed/simple;
	bh=AWHqk1bwXkiWF4HoQgeESKzwMaDTmQfJXCLrcAs/HWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZp56e1PBHSW3TLyH67zxB53dr6reIJGEVah/TKTUJ3uJF2Z6J8toeMMPSsIo1Qqo4CN9PmLWqONtX155H7GSQPbnF4MaCLdtxKTlhkiL9Rok6cOH1eyFsh5xVRDuwTcM+piAE9lsOrLa/yycwrJKD7puloH20PdvZd5cAmJwW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRRTAXAn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741818509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tFAO1/pB5aZVcj94od1ckES2oLO0oEBjDEOvcZ4wXNE=;
	b=HRRTAXAnuqwQudN9U2GOZdEX+PE54H3BLN+kPN7eXtxVv0CMWJ8JiSxVWqLGXdt4/mGOSj
	4/ZsXowkj/k+GDJp1m93khSpddvM+DLX+KxOEJZu56qCBMcXdUKa53rG5o8s4EoPMUTAe9
	PjGaCPXYATk0IhoOR0+ohJpE8632WLo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-pyzGwNiSPdibw2K69TbUmg-1; Wed, 12 Mar 2025 18:28:27 -0400
X-MC-Unique: pyzGwNiSPdibw2K69TbUmg-1
X-Mimecast-MFC-AGG-ID: pyzGwNiSPdibw2K69TbUmg_1741818507
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4769a8d15afso6681491cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741818507; x=1742423307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFAO1/pB5aZVcj94od1ckES2oLO0oEBjDEOvcZ4wXNE=;
        b=wisS52YEOgH/cDpQc++2Z17PxRm5kkW2Fq8eI/TCvDfmS1l13qpsHXg0lkkpAXLpje
         LvG8fReoNVwZ5ptmwtBrkeSL8yQOPgaOdcj1SkbvauttZWNPSWt1WLtKWiUUH/YcE7CB
         i0SfXlKPcPqERXZKtuSGw2M5ikCp9cPMeyTdiM50brHjB+qxQGM5wiYew8DzNRXnd08M
         POKi3avtYaFc2mgsGTfl2HG0fufJMFPzEX9y+2rnJO0ssoCwxu5pjbTGaFyBClib81aF
         n+nnqTNFvKcjI7eY8A3kD8Zsj9M/OkrSEOZ82zAmDnuU1vPN/2CDM5SL94v13H/0ZBRC
         oYUA==
X-Gm-Message-State: AOJu0YxXiS24kayqdmvYHZvv7/SuhArIewe4ZfQqyLGZh/STYnATPWz+
	QOOs2VslzijDIsJ0QDSp3WLZyMJvS08iGLKfvh8H0cgpFedhCcedAa9QwIqybeT7PTiLtebCPuC
	kIS1cyWmL0iVTl/s3x3PN56SkuBvNYc4O0an8S08gbLEeRHtRjpzuzOgzPxrtUA==
X-Gm-Gg: ASbGnctKXcU2fYbxtBJmL0nhWYYWe89+CEK+EwXfmeEoQWhwgAu+UAHGisJB3gzHG6s
	kJgGe4R8I6/XQUmO1BRx/cFIL0lXHv/6aziKUfRZRIvUEOWfYb5hleFEuCMHaHUUtko2rblGt4k
	f0BjH5wdV7cuoiCl/teLmRb/bLOAyuQyhdDceLW8eP6/SvbGKiNHh616U98epfSGYgeYglcj669
	yja1PZDBUzcbZpeJbTW/j4yOB1JQyCnxAhuO9KqNLg36xoaCbI2TbLQtIyXGId5mheeADbvi0Km
	SMI8TiM=
X-Received: by 2002:a05:622a:2449:b0:476:75d0:a1d0 with SMTP id d75a77b69052e-47675d0a3b6mr297013111cf.1.1741818507134;
        Wed, 12 Mar 2025 15:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZeM9wczXZsu7wvYHlQhoFZMC1P9eBQ6a7llT4AWbfvkX2V4gxTt/g0q4aWxVJQlCpMgPGEQ==
X-Received: by 2002:a05:622a:2449:b0:476:75d0:a1d0 with SMTP id d75a77b69052e-47675d0a3b6mr297012831cf.1.1741818506831;
        Wed, 12 Mar 2025 15:28:26 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb66f9ccsm535261cf.47.2025.03.12.15.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 15:28:26 -0700 (PDT)
Date: Wed, 12 Mar 2025 18:28:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Mike Rapoport <rppt@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Pavel Emelyanov <xemul@virtuozzo.com>,
	Jinjiang Tu <tujinjiang@huawei.com>,
	Dimitris Siakavaras <jimsiak@cslab.ece.ntua.gr>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm/userfaultfd: Fix release hang over concurrent GUP
Message-ID: <Z9IKhq3JDjfEEk4q@x1.local>
References: <20250312145131.1143062-1-peterx@redhat.com>
 <20250312150411.f4a5b406600742a49b46d04e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312150411.f4a5b406600742a49b46d04e@linux-foundation.org>

On Wed, Mar 12, 2025 at 03:04:11PM -0700, Andrew Morton wrote:
> It would be good to have a Fixes: target but this bug seems to be so
> old that a bare cc:stable should be OK?

Yes I agree that should work for us, sorry I forgot to try attach that from
time to time..

AFAIU, such unwanted behavior (either GUP hangs, or if before commit
656710a60e36, the behavior could be a SIGBUS returned to GUP racing with
the userfaultfd_release()) should exist since the 1st day, but I didn't
verify the original commit.

Thanks,

-- 
Peter Xu


