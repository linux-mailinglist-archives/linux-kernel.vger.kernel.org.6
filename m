Return-Path: <linux-kernel+bounces-280225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC00194C766
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6921A1F21948
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1015EFCD;
	Thu,  8 Aug 2024 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHhQlPJ7"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704AC55769
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723160220; cv=none; b=Fsbsdfw9b7P3P8u9klG/6StcnT9nS1X7GBO1axiMWZw70n6Lp5hrR8xxiaoVSG+/ppXNtsl/EdunrBoeqkXPgOP4yEtIjyjrh2r1gV9dSLItrmiTkANIk8Az9wEURABu2YzbJO0Ax34BO4ujfw896FlQ3ltSkcPMTNB6RF+8C98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723160220; c=relaxed/simple;
	bh=IFGCuVSOsdaGpfzk2MUva+8/dMtshSbq/rwFgRY8iQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1WsdS3c+TWXCLruYNz+W2YBRruDqHuE98P5b3ICNE3SOS6oIO4PL9Ik42bAEz1X+NERLkKgKvUZUV//Pv4cVducngcCoghzcFUT4/vOIiEC3sv2tPZXVwm34/KONUB9+ar2uPE7IlCj9TMabMcEiM8I9JuC4T5fts6yMhh/Tj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHhQlPJ7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc47abc040so12375095ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723160219; x=1723765019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mITn/MSXAVgt+5vmRw9rpVIRN+t7nOiV+AkQJ7hoJqo=;
        b=fHhQlPJ7N8eZApfzZAQz/JkzWqz2VkiA3bagiiVB8yBxxzzAhOfiNLOQ2rGCi2pJah
         bq6YDpoJcWJXNCp545Qddqq6/dxhDfTENnsHcdqSZR/wjd7sImhfsaCA4zfDxvZxsbTO
         RHSwRgGxZn7Wfs6eCk4olK6Q1GC+dAZrdKJf8YPPAtyS4k0jgfqHIo+nAsZtAKqZ3ogt
         jPsMNn5kKpkqCvvG/ZweDaMNqCV5Tj45W6VMpn0xBCK+a9hVIrv8QARAdJeMU8LeT/Uh
         2f0Y50Y55jBhDDn9AW2uP3IaDgBaUZslnkcsrN5CCQR0QOlA6mQIOH7m0No/H5UyBgqk
         4idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723160219; x=1723765019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mITn/MSXAVgt+5vmRw9rpVIRN+t7nOiV+AkQJ7hoJqo=;
        b=Bo5xUy9UVtxB9GQsPC9BP3h24wWv7DRQs58P/6LB/XwpdBScnZsE/gSINWkG294LqH
         vPNVJVSxEyeBit0olobjqX4oDQT3aZVtuN2/0aadnMWmr22fCvOnSXsgmgQNqgN1jYUT
         0sUssbUoYoj6Yr5Ag/Dn36Ykpfh5983Q0xckXbqdfcfUSH8yq/WtTnM0zD1h6Od8mXmU
         zNjFT8HyMvDhnLhrUO1zqBqigX1TuN+bqWEJLN8MkpIx590QJpsNRWrbuzuljpqChWbp
         3erCUNCTsuPJx1nT7flR0vM9BpxTrh0BFUW6hERu7G9n7BZDeV15U8F99nQrIJVjy9Ki
         4kFQ==
X-Gm-Message-State: AOJu0YxOsj4plDJxmTzLZ0/z1wv+zziHNeQt26jCLzx8guHs3PIsr0Yf
	RaCPJVyk1tz/CYn0NS86ZO7+Jb4QIPa1p2luAXdG3rxk/iLbDqqy
X-Google-Smtp-Source: AGHT+IGded0otR8FSuFL4IVWvRf7TfIZCGnzDGI86l/Bi3TGEofpMdbHenlzF+APj5QsoSYfUSXS7Q==
X-Received: by 2002:a17:902:ecc9:b0:1fb:9280:c96e with SMTP id d9443c01a7336-200953c3611mr39050135ad.62.1723160218513;
        Thu, 08 Aug 2024 16:36:58 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29e0dsm130271005ad.38.2024.08.08.16.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 16:36:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Aug 2024 13:36:56 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Fix unsafe list iteration
 in process_ddsp_deferred_locals()
Message-ID: <ZrVWmEY9dB9u6Twv@slm.duckdns.org>
References: <ZrPWYqSbif3eTME4@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrPWYqSbif3eTME4@slm.duckdns.org>

On Wed, Aug 07, 2024 at 10:17:38AM -1000, Tejun Heo wrote:
> process_ddsp_deferred_locals() executes deferred direct dispatches to the
> local DSQs of remote CPUs. It iterates the tasks on
> rq->scx.ddsp_deferred_locals list, removing and calling
> dispatch_to_local_dsq() on each. However, the list is protected by the rq
> lock that can be dropped by dispatch_to_local_dsq() temporarily, so the list
> can be modified during the iteration, which can lead to oopses and other
> failures.
> 
> Fix it by popping from the head of the list instead of iterating the list.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 5b26f7b920f7 ("sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispatches")

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

