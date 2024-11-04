Return-Path: <linux-kernel+bounces-395473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED60C9BBE54
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67561F2237B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D181CCB55;
	Mon,  4 Nov 2024 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4a6WM5J"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04218CC1B;
	Mon,  4 Nov 2024 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750289; cv=none; b=NjCsFb31uL64dge5VqMM0At0hRign1ZJt3N6HiECmwEzu9oD3UWYW3qTeCpJdW04JRPuEFnpW0HQihxEpxEcC+5/2jVm/RXkEIay3q2SyLPPis6SL/eRPMyNkS7qMoZi2DPYXZ8Ss+H9g1EHWZXCwdRir9Q5OJoJvhkQ90uKf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750289; c=relaxed/simple;
	bh=U6YAGRBLZ1jpjqi58H/3RwaLMYDj0nBH8huh+r5vjb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPCZynIx3iz04ZYVlSLEEAEbVGDsIG9hSeSfFI6uI7P3h/RdZ0VCpVAHRETm/pnKBxJWclL3+e13ZsR0DSIbf1Lg4uBTs5hTbCr2wV3LFRKtjJ2Jew12obaBJEpbuP9IugR9S8s4os0Yb4hlI6SS4IWHzyzQnZ40ESgzCDAupf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4a6WM5J; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so41230265e9.2;
        Mon, 04 Nov 2024 11:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730750286; x=1731355086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4KOOCs+eEUeL9lk4Gx5Rez5RKYEtGyaqv1oOBQzRqD0=;
        b=c4a6WM5JqSlWWu/P6sduBgCTy8PFh60LXcA5XQUOPXlRUTMeYJr7VaqtY//rA8BLfP
         VJiYTISGulS/Ue393VjD6W24v/Na1WpVwtGsPCTum8l/WJ6rzzOWusTteq3BvYrCIQiD
         09BO7u4eB0/IltSYkcsyV1pmAgd4nv1Nx1mzv+MIXvYcMPR7jkHWHHmRdVBLr7UovZu8
         G56XgRfSzKjumsngVdu1DoJyYLuL1G/69Sb4NB0KGBIl5AwVF78GAzinu4bgBAjeewHZ
         qlzPGmGszKwFain/rOvlsLZVeusE11J3jy7T7FobqlxLtFHKufUIxqx8OwTlb/aq4S8f
         EXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730750286; x=1731355086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KOOCs+eEUeL9lk4Gx5Rez5RKYEtGyaqv1oOBQzRqD0=;
        b=Qcs0WSEhEzjxjbRxrah4tRKIRD2s6yA2S5AFgDA8QCft/KPqtGYu7S2G0NAvB33imI
         rokTipIdGx851xO9ACFif0RA4otH56WOS3t7v7RUPAsG620uHWH2GOTJmIoOEGVFJpHC
         7YQ7P4qqU4NXPsgoOt5jCYEiAdkalh5wr/6HpRuLPeYqiOhPDF7mB3K2F7PRihuwKRPf
         xX9/djpJIkFF3cacQ0iKu4SEhiEhSCJ8iJlpyKgqf2W+hB+0Oqhruo8giRjjGdwk78yZ
         YTJz+IyDuHr24KtNdv5QhGHyxGkdhdnXzw050G1sOuo94tdS757UCMQxR5ErGubj2Z5g
         270g==
X-Forwarded-Encrypted: i=1; AJvYcCWtWMekLb4xEH2se17WRYLQP1pN5H5Ugh3CRXSEzCyDQIYzZnfXPKAEGbjWjXReDlYhZsYYHLuSnlEfCWUEeAQ=@vger.kernel.org, AJvYcCXhdVKes+ITcHgEIM3Za7l7qEoo5fDtcNlpU9KWXm/YGbqcoY90m899r77PSiuDIsWfIdBrcTH4xOBSaB/f@vger.kernel.org
X-Gm-Message-State: AOJu0Ywslq1vZIrYHBj0dFSr0K4w8PWC43abI9EzNGfyvSJUpHsJl30e
	FCLjHQ654YzSbi+e1n20a8wl9qlzdUbtvs7KBbW1PL+cn3FqjRYP
X-Google-Smtp-Source: AGHT+IF/aXzGn/5PDHDg4V1jAnzApl03/pds+DcXri2O0xl61zqTGqSCA0kXlZ9/qce0MAUVteik9w==
X-Received: by 2002:a05:600c:4f43:b0:431:5ecf:2a39 with SMTP id 5b1f17b1804b1-4327b8222f2mr135115565e9.35.1730750285734;
        Mon, 04 Nov 2024 11:58:05 -0800 (PST)
Received: from void.void ([141.226.8.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7392sm13993981f8f.55.2024.11.04.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:58:05 -0800 (PST)
Date: Mon, 4 Nov 2024 21:58:02 +0200
From: Andrew Kreimer <algonell@gmail.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] sched/topology: Fix a typo
Message-ID: <ZyknSoWK8zQ5MM2q@void.void>
References: <20241102131943.10103-1-algonell@gmail.com>
 <xhsmh34k757dj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh34k757dj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Mon, Nov 04, 2024 at 04:46:48PM +0100, Valentin Schneider wrote:
> Quick, hide behind this bush before Peter sees you!
> https://lore.kernel.org/lkml/?q=f%3A%22peter+zijlstra%22+borken
> 
> This happens to be valid internet-speak and isn't really a typo, see
> https://www.urbandictionary.com/define.php?term=borken

What a dataset, my bad!

