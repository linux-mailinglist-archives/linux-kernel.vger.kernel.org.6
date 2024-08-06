Return-Path: <linux-kernel+bounces-276438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D24859493F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1679B227CE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148571D1748;
	Tue,  6 Aug 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ojaV+kP"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149AE1D47BC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955754; cv=none; b=K2TpKE9QHeflHpQpfQVCdqdcqJS4BzbVN76RsKsqrpADgTZkt399ThEWVgqhBYZW84s0v0X15ckrPS5RAWSRRiLowrtA56mrvy6wfRc5ZrtbmpUu8aVTiDQm/krtw+Y8A4DK7owym0Y4tF99XWibUREO5QdyaO7r//r4Kk6lTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955754; c=relaxed/simple;
	bh=2C/zKvKl9FGPU3xLwEybVW98UlH/dVTnM4JZmSi1yXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqcdB/fEDCKLooSskdJe30Sz+wwfz0ug2G1vYJNT1OMzTFQIrjDG70Nly1sJK5M4TWPBxSeYZv4e3B2DDXfdVElQK7Hw5HLCGQFUD2/rBl2/THYoDnW2y7LxhonGQLB785Ot4lGE2fkj1gmjwPYG6AFiQczMH2c8vV/apOHcTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ojaV+kP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7b8b1743a01so269878a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722955752; x=1723560552; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hw1okeFzQIXZQL7QGXIUOXdYXd5iHV8SBwCo7Wmj348=;
        b=2ojaV+kPEC52eL5F+3n0JqSk438hjbuFkwp+qCbtAn+pFqEstwsrkLlB9lCm2OxDBn
         Y+jkFEhjC9yXdWfHtisedL3metaZVac2qikQ8hzLsfo4Rd4ZsFQbnaTNw/cOhB/gpduT
         3RMki4s9OUpZ6QdyxuWCdBPOc88w8vwJxtInaQDYbx1Xf5qG9B3WNbQpUesmCJQOZYZ3
         c0v1OPgxJy48htn2nfoWS3U6KMuBaO2VDCLUYoxJlM7LpBsu/a6U0Y7sZxVIlkee4yxH
         goDaUiHw5+UFdRcToRzli/SbKfowI4fLZlQsMFpsqEukHWpEOAfwCRzV5hE1CJNfaTt7
         cLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722955752; x=1723560552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hw1okeFzQIXZQL7QGXIUOXdYXd5iHV8SBwCo7Wmj348=;
        b=mxpFltSCoRQZiWfvO7Y5IjJLQlvSFGExau5+NidaCKFZZDYusqKkjKx1yg6ys6qXqD
         Pl38WG4d+bu8hlsKUz1KUAw3QIXKKK7xs5W5Y6Iv/dkMhbUG9+dSUnQEGwQQ9MX233b1
         3g3PO2KJdNWaUashNB/Zjn+w+fa2hmeAzxa2VDTiqtipHGjBNfUQt7n/3cI4HHnvp27Q
         nwSFXYH12ZlKJ9i7JuI8zgC1QDK5S4ntuSPvmo02MRhKkZ+sULsuU9nERh0TeaUNmWcC
         K/HuLd8Fb2z891pGEtuku0sYUmCKe9fmTPwmEG9cHNtRw1BKcMZd+TjZYtMgUdR9lzPD
         MULA==
X-Forwarded-Encrypted: i=1; AJvYcCXt8m8RNlXN2VdwH6JYyVBJiq7R2dveRb+c5fdr6wdxK8oHW1jZEzqzMtHdtbfz6yGoD5sQw0O5QIRJ3qOhrI2EpX49FlgNeYXekltq
X-Gm-Message-State: AOJu0Yzzl7no6C0RAXwpUSIjJA4LVeFCLBfx9Gq0u4tN5LPDgtWqGRGf
	x7JUme5/d5/vGiogSvKmOwNZk6eW1EGov0mLEHC82HUsIr4Vw9yGqgN7sq7F2w==
X-Google-Smtp-Source: AGHT+IE1Zuaik0XEJ9HrbZun3OaGLGrprUOQHTu9VVu6AbpI1DMvg73gyh/KAxXpm6MrVDEaWfGCrA==
X-Received: by 2002:a17:902:d507:b0:1fd:6a00:582e with SMTP id d9443c01a7336-1ff572cdd9amr146128185ad.30.1722955752051;
        Tue, 06 Aug 2024 07:49:12 -0700 (PDT)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f57176sm88837205ad.80.2024.08.06.07.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:49:11 -0700 (PDT)
Date: Tue, 6 Aug 2024 14:49:07 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Huang Ying <ying.huang@intel.com>,
	"J. R. Okajima" <hooanon05g@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 3/3] lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS
 calculation
Message-ID: <ZrI34xNP1Szn1WnB@google.com>
References: <20240806010128.402852-1-cmllamas@google.com>
 <20240806010128.402852-4-cmllamas@google.com>
 <45ceeb38-06c4-4b8a-8b3f-afe57c891f9a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45ceeb38-06c4-4b8a-8b3f-afe57c891f9a@redhat.com>

On Mon, Aug 05, 2024 at 09:27:52PM -0400, Waiman Long wrote:
> 
> I think it is better to define another macro like
> 
> diff --git a/kernel/locking/lockdep_internals.h
> b/kernel/locking/lockdep_internals.h
> index bbe9000260d0..8805122cc9f1 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -119,7 +119,8 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
> 
>  #define MAX_LOCKDEP_CHAINS     (1UL << MAX_LOCKDEP_CHAINS_BITS)
> 
> -#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
> +#define AVG_LOCKDEP_CHAIN_DEPTH         5
> +#define MAX_LOCKDEP_CHAIN_HLOCKS
> (MAX_LOCKDEP_CHAINS*AVG_LOCKDEP_CHAIN_DEPTH)
> 
>  extern struct lock_chain lock_chains[];
> 
> Cheers,
> Longman

Sounds good, I'll add your suggestion for v2. Thanks!

