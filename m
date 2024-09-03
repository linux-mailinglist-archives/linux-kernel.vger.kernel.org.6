Return-Path: <linux-kernel+bounces-312226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9909693CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C491C22E47
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D5F1D3195;
	Tue,  3 Sep 2024 06:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kUln8g9V"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72E4315D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345352; cv=none; b=UYZgXybqbeSt7qFDR4K6q9rpfXbBgHkl6sIhohAmF9BHPXRYmHcJNwlJiJNz6Q69324JfFyEUn9/hzfJHLlAw8CK3ahwy+ScQFB5ipgQ8yhfMXTMNrjE2MzZJisPR51HJH2nyBmY/vijwUO5CnLY9RZMQU9NyOBa9FqWOazKF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345352; c=relaxed/simple;
	bh=KoRP5C8Fo0NRoaNNbK9FaeMuOaxZ04shz2PR9aLRa2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTcvn2DyTZmEgq5Pgtb9lnmG++h0AxXOqh8a9c6Ffm4BIly+QZ9j54FDT8v/FAKRdd97qvB2s7BbDO7ybKo4RfqwbYiCIGYhezwXJ1nIt1QMDu3R4QiYDkyszpv6szl+nWuNYA2j46b+F8PbRmvGmAH54Ys2dH092RSkr6u/vu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kUln8g9V; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-204f52fe74dso42974325ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725345350; x=1725950150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMcYnDXi1nwk3wZ9JjbOga8O8le1acBw0Um7eL3q7tM=;
        b=kUln8g9Vkm1E29AEQ959yaIJo+x6oL4Ovwu4iLhyZehC2ouum2I+8O8ENNv93Uj02/
         jMWdMaeSSVMGKOqI5BsuAe4pzdf4KPMaQq9eCbRNk87NicB81fDDavUy8qCPYHmDl5Sy
         +S+CpoZnTkCXWsb3ynoy5+f0U6kp+1liYV0Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725345350; x=1725950150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMcYnDXi1nwk3wZ9JjbOga8O8le1acBw0Um7eL3q7tM=;
        b=Uv6v08WYSfX2zSm0vf4eL/et1VoVeKxyb37Ehd233of+/R118dxli9wtoUn5jfrMlS
         Hcz6FgVStWgql+LFDOuTOzzLZiMBqS5QzSc+GqtLn874vrtMwAhBnAc0o8nR+GoZ+BGy
         ozvRtVr57w1tNKgVjdPa3clzyRgleAvQ8vFLP5a1cuO5sH88tPG7eSqst5HEwad7LfWj
         hCmR0/UQWXEubnBVzl2GSNWMoPjnMobP7mqmAJsdAQDgZLPUDqxNs5u2QoY93JP0bP8F
         IMNCaU0l4NFoCuaSfVv3IYjSFqSnHXHrBFAyN65afnXHU76Nxf1s3Ng4lYO0LX/JHr07
         kE1g==
X-Forwarded-Encrypted: i=1; AJvYcCUEplJSAPnpnaH+2lJDPHLFSkhZp6WjzH/ltHHHf9LDEEQJOtIM5s9eV+z8Hwb2V9vdKjJ+MVigvwgdvrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YybOOCQA8RKZwr/jKF7nnemS1Zj3Rd7Y+oPmOCq6MlGW6W2/n0D
	anfNpRy6+cRStkRV5VEVAtRSa6mD+xpReFBCEH9RPSVPzOnDrYIr8ZzacPU46HkmK33bIsk1oIg
	IyQ==
X-Google-Smtp-Source: AGHT+IFnRvcFCfPFPyk4ZfBeXFrYbKpHqAhnRyVKIYkiFQYBcEe+oDeninw8Ubny46Eq3HObSRaApw==
X-Received: by 2002:a17:902:e752:b0:205:861c:5c3e with SMTP id d9443c01a7336-205861c5ee2mr49081275ad.30.1725345350117;
        Mon, 02 Sep 2024 23:35:50 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:51ae:4bbd:c856:6cf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2056d4c33d1sm29229685ad.38.2024.09.02.23.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 23:35:49 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:35:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <20240903063546.GA1602548@google.com>
References: <20240903153732.37d6b860@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903153732.37d6b860@canb.auug.org.au>

On (24/09/03 15:37), Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/admin-guide/blockdev/zram.rst:312: WARNING: Title underline too short.
> 
> 10) Deactivate
> =============

Oh... I'll send a one-liner fixup to Andrew, thanks.

