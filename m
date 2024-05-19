Return-Path: <linux-kernel+bounces-183267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D943B8C96A3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 23:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B7C281362
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 21:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC953811;
	Sun, 19 May 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHg9kvrd"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD96E605
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716152473; cv=none; b=uwE7Xwvtj0iU8Qwehogaav2EoF0rT/geoFRAgRQMszGojuhSvCkFKW433R2EMUfHsrmki04QWTjAgj9iYL10UA5TfvoY34ARpf1DmgEEBmAyNvAAMoTxjYqcs1n69vikmUFhtWCz7JYXU2z/hgc0ENFWmHoryyq3tfB2koDxrtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716152473; c=relaxed/simple;
	bh=/Bph7+K9Jkj+NTdSMK7OBzJ0wyGXSdYBZ9WleWfjtmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpnhfEFCqalFlgapS5ipGX78Kz30EyQM38E876jumukJWmVUVTa3tY0j9KU/dzGMDxERIUpm0gIgeglYP87GBv8N/2R/Z0k4EGNKbbQcxmYHJiWUWCO6pnys38SMBLPZVUgF+Y+KN5qIF5uDf6RvrcoKhLt2lWQyq4LHwgrVXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHg9kvrd; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f1e8eaee5so3233462e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716152470; x=1716757270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yHS+308itLVHd7M3dYFbOfs9US5TMAl7Ail4GLcbRQY=;
        b=rHg9kvrd8doUAiD6pghd894FCoM95U/J0jxnqacOpm6MRuuiNoc/hQh+W0EZBi636t
         MG1LCK4lTPWs05FnEmfWZQIFofFGGiZnoRebeFFqLUyzX4zyJ9DnN7ZcQnflR7c0cFqU
         Q7sUCR49MDc8vFAcbLvWBoJ/d+wroocp0VGJG9C4ZWHjWsSt9kqpHi67yMCf7vEDDGhl
         6jwnHaE0V6FMkV2ds0aTAV+KP6oNKgTMnDPFHtnNbaoXnlibP2N3+FX0aqCU+wdsj2DR
         tEyNZxPBVdzNkyXoESHBLoNQ1yRUiTr617e8cJ6PrcFXs5z6Ofp+Zb7uHUTY7L/AKsKW
         XY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716152470; x=1716757270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHS+308itLVHd7M3dYFbOfs9US5TMAl7Ail4GLcbRQY=;
        b=lQ0oKg8FNMpzN+hGAv0LD2o179uVpMss4g9A5gtcYUSXurtt+No5bI/d1kXq+fVh5M
         yQuq8kAj+8LmIG1ITa/p7DxHxR/5N5j6SiCwOAx6GgrD+w6T4Jlm6Xt3yfZ4fzKmlQjp
         XVPwMha8ZVle7GVrRnOb6wtBXTWpR3MtIjZ9qP06mS1mTPaXLXm8VhX3l75wysOLoJTm
         osWLZJoeuZzML5hfFotr3qETwwk5q6QuEahEDNBK2iByPxYobRYo9r/a0F0pyAIKkBXr
         Klj8PcyuujN1lRZxv9BuJKnBL70H9CERX04WqweOq8Q2Y73lvk36pl4nKRRl6nffU9YB
         x4uA==
X-Forwarded-Encrypted: i=1; AJvYcCWBWIW8d+wMUPiCT13kOhboULDLFg06NiYkKWUz2/PeZEIbJvQJnEMDH8OMntJl0W0UvBULI4pAkb7pZMGH4P7z/u4eE6RM1bWMPs3E
X-Gm-Message-State: AOJu0YwV8TnJ7gz69VkHGKVgJF76M0+gFHK/I9X3fAK+9lSektrjxeqy
	+6rRF00yAa/0h1pvwtgIr11b0PZBGTOTJdC1tYrnCl6T5yZj9aEp2lm8CINYdg==
X-Google-Smtp-Source: AGHT+IFzuf0OobYCCdKZZSJ9VsFix5Zsea7N4HzK7XLf1RNV2+5n9LskFwgvoInAbQpnu51OUAkyMQ==
X-Received: by 2002:a05:6512:1310:b0:51f:3f6c:f7d5 with SMTP id 2adb3069b0e04-524079b1f5bmr1431406e87.8.1716152470068;
        Sun, 19 May 2024 14:01:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:9677:a1ea:4905:181b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52426a16831sm448711e87.191.2024.05.19.14.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 14:01:09 -0700 (PDT)
Date: Sun, 19 May 2024 23:01:05 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf report: Support LLVM for addr2line()
Message-ID: <ZkpokaHRfQYCo3uG@google.com>
References: <20240518165335.3963530-1-sesse@google.com>
 <CAP-5=fW5YtzYz0R-9ZkgfdAFjkUDHu_Z1Sexs+2SmN0RwhrADw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW5YtzYz0R-9ZkgfdAFjkUDHu_Z1Sexs+2SmN0RwhrADw@mail.gmail.com>

On Sun, May 19, 2024 at 11:23:26AM -0700, Ian Rogers wrote:
> I think we might want to display this in the feature list during the build:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/build/Makefile.feature?h=perf-tools-next#n123

Ack.

> s/HAVE_LIBLLVM_SUPPORT/HAVE_LLVM_SUPPORT/

Ack.

>> +#pragma GCC diagnostic push
>> +#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM 14. */
> nit: pehaps disabling this should be conditional:
> #if LLVM_VERSION_MAJOR == 14

It doesn't seem LLVM_VERSION_MAJOR is defined yet at this point, so I
don't think that would work. (I just checked; 15 has the same issue.)
In any case, I think it would be just more clutter for dubious gain.

>> +       if (file) {
>> +               if (line_info.FileName == "<invalid>") {
>> +                       /* Match the convention of libbfd. */
>> +                       *file = nullptr;
> Should "*file" be cleared if "!file" so the caller can reliably free it?

I don't understand. If “!file”, then file == NULL and surely accessing
*file would mean a crash?

/* Steinar */

