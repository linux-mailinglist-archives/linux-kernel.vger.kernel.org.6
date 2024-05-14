Return-Path: <linux-kernel+bounces-178246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD4C8C4B08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28E1281E49
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412574A2F;
	Tue, 14 May 2024 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNgtyaw+"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9C337E
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715651760; cv=none; b=nHiWw3A59b221sp9/jZF8GktUilWKhX/pqAQYJngJUAGCbklWIeWA43vxrbmtYRH5NRJGFcEpXA3xAxYBQwWqMSiOiw25gML9zo1zi04gdRQSRTFWNUjjXy+MT03DNuugjtHSMHd+rCUYTlUbOb53rXHfFvgNBtr+5t8nSLNcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715651760; c=relaxed/simple;
	bh=fvgZ1X401aqiAge1yt4zkkrOC+wtlotVZy31r8hR8k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+zKM5jUDOE/NCzzPBsdUIbSbhD0pcVRlgdNpHZRPN8d11xHHBZVwsbtPJDSat04WIZ/0gunKXtYF5MlRSV9DidCmQ+zPMp1D427x/xgviI6QOohOtf/fUTZ9FyR6623N815wk+whcTVTX0mxl+Q8T3F0Dfxacctzvy+u2SCoHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNgtyaw+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f0537e39b3so24512685ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715651759; x=1716256559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKXXfS8el/DZmdvpD04J8D81FZHxXB/MjCkW9bjJgq4=;
        b=UNgtyaw+G4UJfPzN1C+WJYpmWcKHuDLLnhQUmIEULffBQWCIBAgQu131esTTLhR+ji
         +swWyo23KCBM4Y9dnwF9PrgmtT02ZZF+31gJ2To1XEoQvJbojmCSf3WjsYkFHISb++Rm
         Y9rmtHPoBIzwj9wwju4lV51i0kq1W5sygw/A1rdmdA876QVSXqAfFgRs79UkUQ27+8Ee
         9ifmd1s1mFU1UIswUB61tM6u8S+V9lt+3heWWrzVHjbPURAlc1FcruKKnuS5nS6s3rFg
         dcmalJ69R0EB2M6lFdvzqutKXEEZyBvxElJszavvql9WMy9JnvEb2kuCuNbxcGbZW+UC
         c/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715651759; x=1716256559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKXXfS8el/DZmdvpD04J8D81FZHxXB/MjCkW9bjJgq4=;
        b=VhkbUEZ9boqet3DGnktjqPE1UvQ0RyxId5+jzByo7RIXeegWVnMgO9MFjnkP9svzzC
         j+5zfCOHPgSb+y1OlQv0exCznO1DqoAC/Z+ruRQf97yWZQ/yDvyPjk77eesRwNK7VDmZ
         khNTpwhWajXiaP/bftkGZ2AhTCjH2p6ZLva9gCxznx2CE297l6cSK3+MSUqRQLuNrF7F
         gb5FQsBkb4ZOLk+yx709q6RQIw6s5DeqtVysYMcWR3Ebw1aCcPLSCD/h5sUyEGSbO0hF
         AWgyWXWJ0dxJ46semlNnpMP2yABR/2q6/Apo5thqniGJ9/KLw8uyh8dzrtGJRH/W6Jg8
         585Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4SsmnpfJVIeq03NAvHq/J7FeibdzNq4fNqSKpEfG86twP/Pb1vfXHth4erzhGlx+uxmABU14/E/KA2QLpK1pjc52cjh7DZRa4j62u
X-Gm-Message-State: AOJu0YznvRoF6Tj8hX5342sIG6FJMZDEB5zlIId0Xm2WnQMabdl1S4jK
	8eJlbAeVZDXzeAaTkTupUkw4JzQ0fDSidCE/75fT/4FLkWRAuSZY
X-Google-Smtp-Source: AGHT+IEAeLr5gR2zyJyESr0TsWuwI+yg74Uw400RHT1sQotR9z0GiMzWLFBnl26XBNRKfkFKrnTleg==
X-Received: by 2002:a17:90a:6c82:b0:2b2:7c53:2601 with SMTP id 98e67ed59e1d1-2b6ccd76d4emr9943193a91.37.1715651758658;
        Mon, 13 May 2024 18:55:58 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badcd88sm85802965ad.115.2024.05.13.18.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 18:55:58 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: dennis@kernel.org
Cc: akpm@linux-foundation.org,
	cl@linux.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tj@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH] percpu: simplify the logic of pcpu_alloc_first_chunk()
Date: Tue, 14 May 2024 09:55:52 +0800
Message-ID: <20240514015552.273677-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <ZkK-0Ykapl6jxG75@snowbird>
References: <ZkK-0Ykapl6jxG75@snowbird>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dennis,

On Mon, 13 May 2024 18:30:57 -0700, Dennis Zhou <dennis@kernel.org> wrote:
> Hi Yuntao,
> 
> On Tue, May 14, 2024 at 09:25:00AM +0800, Yuntao Wang wrote:
> > Hi Dennis,
> > 
> > Can this v2 version of the patch be merged? Or what else do I need to do?
> > 
> > Thanks,
> > Yuntao
> 
> I'm going to massage it just a little bit to format a bit more like the
> rest of percpu.c. If it's a little too much, I'll send out a v3 and keep
> you as the author, then apply it to for-6.10.
> 
> Thanks,
> Dennis

Thanks a lot. :-)

