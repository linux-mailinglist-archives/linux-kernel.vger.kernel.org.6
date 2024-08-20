Return-Path: <linux-kernel+bounces-294690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAA6959165
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF39B213A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB94B1C9DD2;
	Tue, 20 Aug 2024 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fwszu/fR"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF31C8FB0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198059; cv=none; b=sKV1DcFm+CNHm0jYnSVgihzfSgXTDBCxXaN6f2NjN340iVhTGoMapmvTnkUlb1wD/OGQ/ETmRkK8oBvlfXbGOH/Vb6uOXLbNOkUjtn+5ZgCa/RKljXIoVdsFhf/ows71Sqyv8IDMb2KObw5aYJdvVjWrVxRFDrQtiOFYQEiGUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198059; c=relaxed/simple;
	bh=Je/DvH6y+/U5GaGamT+8PtiMLhNss8z4iEzpgHAU7WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIdSevOQMUn8TJwyZutBAYdsOTkFC3CcxSlh67WZb3ln91nIAb0HTuY104pEW0ya7wiQvco9EOutifnaBxoNsiJSWyfJhIqxFu7ebu4kwrLDUUPCaNUjQ69Yuzx2bbYxpq2UpdwL3oV8sCHopJRNDuWUWH0pvxnh6pfF3j6guow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fwszu/fR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7106cf5771bso5032613b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724198057; x=1724802857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jH9QMAocVusn8rV65VZPm5H26BBjsrQXwoBJWu2d8Q=;
        b=fwszu/fRY9jS7Je5wGDjwFmeL5HQYUj+Q6a9F5w1alsoYU09WyqAVPvAPKueEWc8uI
         oK0nbm7wmJKM2GCM+UYBQcI4ln8Xpj0OYTQ441dBRhQ4oYBiwotwMWvnYNJ2PF8FTS1W
         CMSZOhfxF/3nCxZ+HISUkYQDYvKcwRGBNTMKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724198057; x=1724802857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jH9QMAocVusn8rV65VZPm5H26BBjsrQXwoBJWu2d8Q=;
        b=OO7zISoTCjNdL5QlyfZKWiVILQwjNHZ066E20p5Xwnuj7jets6lu3DeBsAVCO3vLbY
         RJxpUewHXzN2JlKh4RF126+3QTAeD+jC4fej3XfnZlG03QqllV1fYWMlb218iKVfTqCd
         XYGCd6mOuIZryDTvW60b5slfjmyosrSKWZBy5WsvaSgCzQdzPawBMNZMX0iBn6QC4P/h
         1+HQC8OD9SyoO0zX+9Dk8HtAOUdtGx5vrSEtM4Dou2hkLzVCncS3YInC4AzY3nnf4tyP
         FBj7laT2XLPORQIBjbTUqHSyNWulx89xOwx3VFIFIPw9UDxsjRXgI7q1RsmhpMRNjxWd
         hTSw==
X-Forwarded-Encrypted: i=1; AJvYcCXtLv9AmRsmgsItYnqLjOSv/GGQnq4K8zEDqDVobzqBZvvT0emkX/0srxlhvz6O/5ZXbJXy7m7zM6FVLsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFt4bnIVWqm1fhhcYdOcYHrtk638an+QIibuSZv4dvQU/7xR0n
	wYU0QhdTNn8Qm4og8Sbz5hvnmJM+UDXs6hwoce4ECL6TdM6O+OnzjvW8nDEUdw==
X-Google-Smtp-Source: AGHT+IF7G4ZsCg6gY2k/0ptnDBpfiv4M3sFl74OVhCMZrvUgN6UPTGsPHTHBO1L8Dn6KqNxucl+24A==
X-Received: by 2002:a05:6a00:3e0b:b0:706:5dab:83c4 with SMTP id d2e1a72fcca58-714234a7294mr731296b3a.14.1724198057028;
        Tue, 20 Aug 2024 16:54:17 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a823:f22:fc71:fce1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0e96esm8804061b3a.83.2024.08.20.16.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 16:54:16 -0700 (PDT)
Date: Wed, 21 Aug 2024 08:54:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Tejun Heo <tj@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <20240820235412.GF12106@google.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
 <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
 <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>
 <20240816023831.GD12106@google.com>
 <Zr69QOysEfYXkMwb@DUT025-TGLU.fm.intel.com>
 <ZsO1-gCkeGuskOnT@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsO1-gCkeGuskOnT@slm.duckdns.org>

On (24/08/19 11:15), Tejun Heo wrote:
> Hello,
> 
> On Fri, Aug 16, 2024 at 02:45:20AM +0000, Matthew Brost wrote:
> > > Tejun, how do you plan to handle this?  Would it be possible to
> > > drop current series from your tree so that Matthew can send an
> > > updated version (with all the fixes squashed)?
> > 
> > Tejun, yes let me know how to move forward with this as it is highly
> > desired for Intel Xe team to get this into 6.12.
> 
> Can you just send a fixup patch?

Well, this will make the tree unbisectable (for a range of versions),
because the errors in question break the boot.

