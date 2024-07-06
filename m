Return-Path: <linux-kernel+bounces-243060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 460C9929102
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA037284660
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C382A3D;
	Sat,  6 Jul 2024 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UxGJoilL"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D13114295
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720242080; cv=none; b=Ev5Zm0UthNXLMZmbiOPw7/nZRGGKHAa2ZYjTWQltbrX38RTmxsY04WpXsC0AzcdMpr2hfGKLu4a+nPMbdPeRVd4jiGgdY8mFh92UTbJ4QRygxLWX+1DCdK9uJG1+/WtvjV/hreSiu/IC1KKdKKiyqwX0PaLDlf95rrwXO96kaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720242080; c=relaxed/simple;
	bh=5A3It7xYKKveVGiAQNxU6ksTAtLan18GbB4G/3FXkMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByeRcjZzyWzemEMJvb11l50A9yqK9a4y9Ue3U0FAv6I84URyuyk41vFemaYnp9HdOj2fuO7zSPwOllCiheZDvXuX6HvhIBQFb4TJu+SUf3fBGZ3nxyN2HTWHV+C1JuyPVAtcqdSCOUqk0viX6DtrME8Ci+2MgbQ1IM0G9UgVVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UxGJoilL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c7fa0c9a8cso1476982a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 22:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720242079; x=1720846879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXT3iSbWqgOp5QZQa1Y0sp3ukuJGwfGUFtVhvOnlDv8=;
        b=UxGJoilLFGVWX30Hy+1QNttfyVJzkTwlsTFFcVYvEA8uJ7HT6CvKBKw5sjx61UIuvj
         7DXanFiXO32AooRvOMRiDqaYWM9cKzhx6Netel3U9oUr2hsIo+r02Rl9JzyGwfqiSG9f
         q6vqtMW06iETYHqlucvvCAnP8KFtX0e+uRBf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720242079; x=1720846879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXT3iSbWqgOp5QZQa1Y0sp3ukuJGwfGUFtVhvOnlDv8=;
        b=lcLwS1wgwnd2hfAiNPL+M5bpUmjXp2u5JjFZcG4iM8gWNlskGrGSvnZTbSxpd+HLnX
         5DfHhysHihwbQemdBH9aySmZ0nb0pryQ6e7DytkWD3a2oRE2xeENtKdMkmrtpB8sAr8T
         JI6AFu84hLb8b61z1SMat1s/m/7u9FCPlEVepaIrkGcNkLEXOifAyABp5n737gswI0S9
         DUmTyfm7recYowaOAPbWtfHomyyZYucxu3SeQjKmAkEvHrKmGYZRkzZ+cGI02nh9UbpM
         n7Da9d+4tJJ7KGufjWiRgAAEvcZG9X4/kGnjXgxRFMlP6D8DbM/FS5q60eJDVBdDrFY2
         ajLg==
X-Gm-Message-State: AOJu0YwVvg/BuBX54+IV87tx0Cf7pb6u4EnIA2fyd+NTTP4YlYiahpIr
	pL1bAX/u3Afsh77rNCEUM0Fw2i14sp6EeMHZwZTuIa6PlhwVJo90cb+XlDy+B0Kj89lgM5syqZ7
	Aww==
X-Google-Smtp-Source: AGHT+IH8UQfsx3ilwLwsAxlpmZ+AhNz5TvX9Gqr2umny5/Dl1qEsltIprvY6FDSNeUBXGsDCqBiITQ==
X-Received: by 2002:a17:90a:688f:b0:2c9:58dd:e01d with SMTP id 98e67ed59e1d1-2c99c546e7bmr4678094a91.14.1720242078863;
        Fri, 05 Jul 2024 22:01:18 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa3196csm4203204a91.57.2024.07.05.22.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 22:01:18 -0700 (PDT)
Date: Sat, 6 Jul 2024 14:01:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv5 00/23] zram: compression algorithms tunables
Message-ID: <20240706050114.GA244190@google.com>
References: <20240706045641.631961-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706045641.631961-1-senozhatsky@chromium.org>

On (24/07/06 13:56), Sergey Senozhatsky wrote:
> This series introduces support for run-time compression algorithms
> tuning, so users, for instance, can adjust compression/acceleration
> levels and provide pre-trained compression/decompression dictionaries
> which certain algorithms support.
> 
> At this point we stop supporting (old/deprecated) comp API.  We may
> add new acomp API support in the future, but before that zram needs
> to undergo some major rework (we are not ready for async compression).

This is, mostly, what we previously had in mm-unstable for several weeks,
however, given that there were some major changes in the series, I'd
label it as 6.11 material.

