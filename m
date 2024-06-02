Return-Path: <linux-kernel+bounces-198431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297A88D7825
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C43281BE1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9277105;
	Sun,  2 Jun 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHyHmMQU"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2E6FE16
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717360795; cv=none; b=RUkcXkrz9MqLgA8vBq/aglHVAaxRZygeTZLTB5syww/kNVQ0DOQNyuqfiteq2h/0BMBWnHNTlFsTofbznzg6mOtxMp7MGnqCm8APfmLIrF8f00DL1KbyYT9rzXggUf46p6LWunUtIrRcjvUB2iWaFCP5QtoJnb6iLnA25jQevWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717360795; c=relaxed/simple;
	bh=oCD7Xok56uSrBOhqqQ/8Y3CjOMlJGTG4v9+1o2au5m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7D40Mc8OENAcjHvRSdERCehL0au2gR3vPowLu5drOs4LsG0Mt5271nIsIUb0k1YLfabpyMsLK0XfzsEUaO8cUT07b10hW6JUXiXqSE0zSq4vvZIifbogSZbusCI+JasyxnZxrRD5t5+N9cvM6RhmPNPXytcB8j4MWcIF60JRT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHyHmMQU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b9af7a01bso283818e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717360792; x=1717965592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T52p4Pn8Iw0ljBbOw7leDCNcjx0TlIT5pY7e2Y3YAzI=;
        b=mHyHmMQUU60IQXcVOpm5SagXlk49HTNx5ZVvSqLIKpd5+h6ZCOtjxpkjCluiWUMsc3
         14cPHjdTmVqAObj1zJxQkKHpTGjKmYxmy6HOc6VLiUp/ofbfCwXf7iHL+TjYSSQOAVKG
         PPHdEveo5aNkLaRI3xJ7STK8cuYgL49M1LFuJozGELoeO6dpzfy2RTpMzfuljaK1OR64
         a4A55rFOLbu4CpsvDEBC6tNSBk7s7g63qtJUyTvSDHXiYWyVrxhLOYp5W0VS97cSmyBo
         gICvgjYzfBC579xl6T1eKXoCtsCZgCQ1vYALM6J5aUHsYMo2qXy+tdLAdaZyEJiNL+C9
         BvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717360792; x=1717965592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T52p4Pn8Iw0ljBbOw7leDCNcjx0TlIT5pY7e2Y3YAzI=;
        b=T0xJH4sXl42u0fY4EBmdL/hEr7W7JZEiTxJdA8H0lklXE4NkmtZOdG6WrfTmyNaNun
         9yuHX28o4pQGpDtpgq6E/E9HqOfUcar0c68nXuhO6RRFqAskVsbyx/1GLGa/Z/53oAV8
         w/DHjnLqMqUUQ3AiBXdmnYudEESTG9h16j4UTnl0PWulEuA5DXd5JWV/zABDrrWvafLV
         hp7sxaAFdokNFi/ng044/F/nZ3n2S/wkNvZ7ZF3Ts1zSbqqQmqTJdoEsW8CoakBYRAT6
         RUQjLBUqIoN/OtUtBXiSWTIjJeoCyx+ZjYHBgoelE5MjxW3XOw824m0rXdORo8jAk2cn
         mUuA==
X-Forwarded-Encrypted: i=1; AJvYcCXlJHof/EXqM4m+RIdCRB7XHSoI69QQKeWLtadnho57tJN48t26bd0VaDhsf0CczMgTTwiXOpfjFI0DAPLrchkBwD7fC0bgjesvQBtT
X-Gm-Message-State: AOJu0Yydkx+qPd2T7uBAF6ElR9JwAQC7VwKRqTVkNLRNHmN4/F/haljC
	QQnxbI0vKPjfEB4FKW2pcTSyr6q++JDoL/FFGS/5zU72dvEgBHasJdDwGglvHg==
X-Google-Smtp-Source: AGHT+IEwc+0MkdbbHmcdiPaiwA0L1CjdfB5xGKlt8voRktXLdt+vU6HkYCl3N2Fw3v3szBfdAUf/Yw==
X-Received: by 2002:ac2:424c:0:b0:522:3817:6d4c with SMTP id 2adb3069b0e04-52b896f82cfmr4717051e87.68.1717360791393;
        Sun, 02 Jun 2024 13:39:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:138e:9906:1038:1841])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8736asm1034897e87.236.2024.06.02.13.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 13:39:50 -0700 (PDT)
Date: Sun, 2 Jun 2024 22:39:46 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com
Subject: Re: [PATCH v7 4/4] perf report: LLVM-based symbol listing
Message-ID: <ZlzYkpybqom9hvJx@google.com>
References: <20240526182212.544525-1-sesse@google.com>
 <20240526182212.544525-4-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526182212.544525-4-sesse@google.com>

On Sun, May 26, 2024 at 08:22:12PM +0200, Steinar H. Gunderson wrote:
> Similar to the previous LLVM patches, this allows symbol enumeration
> using LLVM instead of libbfd or libelf. This allows distro builds to
> reliably enumerate symbols in e.g. PE binaries as profiled with WINE.
> 
> A lot of the logic for e.g. length detection has been carried over
> from the libbfd code.

I'm dropping this patch; I don't need it myself, it hits some bugs, and
I don't have the resources to see it through. I'll send v8 of the rest
of the series soon.

/* Steinar */

