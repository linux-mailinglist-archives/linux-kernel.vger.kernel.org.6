Return-Path: <linux-kernel+bounces-360761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F9999F31
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5BF1C229BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAE220B20B;
	Fri, 11 Oct 2024 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkgq/DKw"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86019208C4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636040; cv=none; b=Y/leb695Jo3PuCB4w5t3WXV2hf3JreTcgLJesIcxn+4c13wsblLJRuSD1oWbF7WlW+DeanDmWR/kJoy1x2p4NQUjSnPN2Fq2/7bWdCsu68+co33jLMLDiNhnt0k8QqKgG+3TB7X7ukoOd/FGIcxglwmJvpSaeKwbCMaM6Ylq+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636040; c=relaxed/simple;
	bh=TeXSRa2/IwuHj/4pFigZUyzxqrXent9UDGirBsM88dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLpGne1siy1Z1izkDsnCU8/AZsyGx/wEExuRmgr9mmE1j/Alczi9B8BEcAwNU06BBfTv01JHKTp1rQOP9uBQkQrwLuxIsPTwnA3oEQ8ZlbHpeKSyPkFSMhyo7gUcNeeMjPf6/fnm8HUSc6fxtLS0xmi6mMkRWKcZfQytDHWboAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nkgq/DKw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so1777475a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728636037; x=1729240837; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRQGWdjsoIEX0QX85YHeC0kcN0bRYkabhnExRIwtN4o=;
        b=Nkgq/DKwc/o9aFOREfxX/55/6mMRYy0XJ04T2G4mrc5GiD66Q54y/FExTcYGUCorQP
         UqiPh2q14dUi5e9XtfRPt6HNgrhdS/pE4Ccz+vYc9ey4n1npGwu98shgfiBDiNE+tP73
         uHv8hHWZ0UrKetw25fMGobnKB4zejjEvhlrilYTUpzV3Evyjedlm8OD/bxq1LWpYmz3h
         btscEz45c/ljQTNaNVnmeNBHjE4oWR/8zk9OZTUNzTcrkKhiPtPRK+JBISlSIsx2qPFd
         qMECz4zTwaPcG/1CDtud0Uqipk51BX42quLMNxbgEHpJqba7+7/1U+kBBxYXZZ6F/eZq
         EEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728636037; x=1729240837;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRQGWdjsoIEX0QX85YHeC0kcN0bRYkabhnExRIwtN4o=;
        b=WaHjng0bFQiCr3HGLbFhzRg9uN5JNMqmtwMWXyN7PWDXh02DCfVvGvrMqCTrKb9CL5
         vg8VlfhPws8C6oKYgJy0weXxbQxVdqv7MpnmX+eWL3BNMqanrA9uMp/QCsCCfgj6OInx
         +Yiq3C5bLw7VdpO1FGjsyWWhwYhvgV+wY1hMKsa/FIEfdXOpjV+FO29eUfcSVvN50pLU
         uUYegB5Mvkpp+UCfJkI2/fL98aRqmeNLv5a3AzJXDeiYN8AudGvJmGAjZgAUDjy3E5qw
         MZ9WDqL1uEzD5Mcg/AiJKQt9rvrq4XxPkWKh2UmiPEELhpuViS3eR1NeS1AihKuD0Ws4
         bOgg==
X-Forwarded-Encrypted: i=1; AJvYcCX3mLfWvBVf/kcL7QeGhqNeHzOhTF4ODqdDG/p9g8qfGATvv8af/41e5q6JPFG7FHltN1G8Zcud9oNoyts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bX4YkOoLUREIWojcYWqr8MXBcvYfzOlz6V7Ww9FYUdF20Psq
	ZDgYnFPJeknBjmXwjGXauNzzEuUDbKZN04dtSv5LZ13haY5BUlFH
X-Google-Smtp-Source: AGHT+IFBZ+7kra4S7LOuYyeokn84R5TLGMJ1E3B0ELwdW8VWCpEFzWUGbHGzzUzFwZ33TYukSthCYQ==
X-Received: by 2002:a05:6402:158b:b0:5c5:cdf0:177b with SMTP id 4fb4d7f45d1cf-5c948cdb1a9mr1136778a12.21.1728636036551;
        Fri, 11 Oct 2024 01:40:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93726096fsm1757157a12.71.2024.10.11.01.40.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2024 01:40:35 -0700 (PDT)
Date: Fri, 11 Oct 2024 08:40:34 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH hotfix 6.12 v3 2/2] maple_tree: add regression test for
 spanning store bug
Message-ID: <20241011084034.botw65q3csptwe25@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
 <30cdc101a700d16e03ba2f9aa5d83f2efa894168.1728314403.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30cdc101a700d16e03ba2f9aa5d83f2efa894168.1728314403.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Oct 07, 2024 at 04:28:33PM +0100, Lorenzo Stoakes wrote:
>Add a regression test to assert that, when performing a spanning store
>which consumes the entirety of the rightmost right leaf node does not
>result in maple tree corruption when doing so.
>
>This achieves this by building a test tree of 3 levels and establishing a
>store which ultimately results in a spanned store of this nature.
>
>Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

