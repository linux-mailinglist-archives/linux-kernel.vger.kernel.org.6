Return-Path: <linux-kernel+bounces-510114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522E7A31858
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064383A4AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663AD268C4C;
	Tue, 11 Feb 2025 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVa8kEiT"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35A267AED
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311172; cv=none; b=SNPYYjAP2XXze9iAbGDduU5RFHZ9wC5JmrbO5iFUPtUEsi5UsLL744A7hupd0PRuvx3tz2gyy12wdo3Q/OL35YuuMvyfhz8e/3PRXvRx+BegFTaOX8oCb1hvIRKSc0mjeM1XkdcsagP8ofiJXlZfFMiMM1wTeH6bAyCm4KrTCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311172; c=relaxed/simple;
	bh=5lqoBiTkWp4nAjjdnJgWRRzXty3mpp66e4HfQbUks3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU44xxHfQnT9NFABoby6b1flmiG9dDQWpu2V8lv9XjpsCzwV9cT9wHs1W4PxnXpCCDveD3lYZEF25BTpoauO9IJMYQ3AoVvwdTvqY1Co6nl4g+IsJBDKtVE4AR2r6gVlay4sAj0KD4/BPMXb9tO2977jxuTuYNNnvCY2Ayptiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVa8kEiT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4719141e711so23476801cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 13:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739311170; x=1739915970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oWVLgu7olkt5+huG/rzR9Tf5v467L92GDvtiRJVBA8g=;
        b=WVa8kEiT5p0p58WuyqtxBRtBsExVElIXVsBM9t+XiqOdtwx2t9r+dO3LzCnKfirdsv
         GzM80i1e4cR6HuRWqvoZeCTWqr6ZSnHiDydxxorxFk2YX8Sflxtrxnz3Ak8VJ2A5qYQt
         AyTryORAKTlL2gPrfWaMoyl3R8QJmTdrksI7DIZLJrdOwEFZY2wC+1KisPUlasmvvDg2
         XZvF1gJjl5VM7Y6wNMK+On31OARrVI9M4Hi5LE6FdkZFFNYapv7UrSVRhNxb4KteOMQK
         oufOXiWQ4dUjEwyPmst/u9dw7huwpfG+0veywh6ETIPQysoQcFu3ACu39ShVg1nMq8ap
         qIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739311170; x=1739915970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWVLgu7olkt5+huG/rzR9Tf5v467L92GDvtiRJVBA8g=;
        b=Wi/Zw+Uu0TwuOMjyF0TIyUnLbTAxQkAOV9eCFt9CX2lot72HoxoNgM1eJvJnq1HV8L
         rebVZkBjorZeuLxLw0AclWV587Se5Lrly9GT7JV6qIph69BCnwX1zkxW32lfs3twSiYn
         6S9J1fzt1XZ3UecA+sSJFniOMlg+pev+2VGZzk84CFkx8SzsnO+Lz7DuOST4n6DEL/71
         /Lat3qHo1zg5bU554Vg2WK8dkbbxOllVPdWkDXR16Xa7Vamy0JFKrhdoCZ6CM3kaJqrY
         YAwkL1YdbyXQEjh6xkjp9VXWcV1MWl9etU6RW1vsN/Y2J5XP93j63i2kazrk8lIfEyiB
         S8Vw==
X-Forwarded-Encrypted: i=1; AJvYcCV5F6Np57szfq2deSpoo+hOBpGpyZJXccd7qfSDvP4cSrri3TIrpYeIW7oWqjpW2oE6lPdo373mmFGHiM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVUHcgVUUvLQx0eL5Zbfoz0TeOCuP6RngIERS3bUqxWMTmy/nR
	2jfk3R1FNmY9LHrkQufUhEOxlqaiFzHOM0G5VO1adH9U/zC67sHd
X-Gm-Gg: ASbGnctQYki7nQC57/SPr8WbfbOCGZI10EYxbZ5bixmcbGl+liLIDVsmR/GEGebhiID
	+en9uJralDmGvZnk5nDi8TUaOrBRKjSt5V4Ft3FUgBXd4t98w0aP0oXFaUkxiWef6pUbdCOMnzA
	wux3R+3pz5HxooMFAvNY+nsi2kECQ0w9vTBvP0P5LbMtR2WpR13SR7R+aYfqttXg7DuuckcI2ca
	V8gd2Vm0XxgDVRM8Lb+P+GR3kl/2CmFhLrXyGvM2FxsngcfSOaH/iYVKsQki9EnQ7WvMs9o4OOS
	eS2Ggay5k0/33bMK
X-Google-Smtp-Source: AGHT+IEWJDst8vVUPVOzrV15rAaTZFTwjzJudF4qLztVldbN/osRbxPXG0hpawApAKGPW+1aSKayug==
X-Received: by 2002:a05:622a:15ce:b0:471:90bd:1454 with SMTP id d75a77b69052e-471afe616bcmr13548361cf.23.1739311170152;
        Tue, 11 Feb 2025 13:59:30 -0800 (PST)
Received: from VM-Arch ([2600:1001:b149:3a35:2d69:a3ec:38da:b6af])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e4556d153asm42604646d6.13.2025.02.11.13.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 13:59:29 -0800 (PST)
Date: Tue, 11 Feb 2025 16:59:26 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: airlied@gmail.com, simona@ffwll.ch, tzimmermann@suse.de, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update maintainer of repaper and mi0283qt
Message-ID: <uwkyq63ovr3xcvgvxeuzgwyplkqxdgjqtosvftxtv6awtds2sp@wa6synmq76ja>
References: <20250210233232.3995143-1-lanzano.alex@gmail.com>
 <221ad1f2-307a-4ead-84e2-4b6c4331a20f@tronnes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221ad1f2-307a-4ead-84e2-4b6c4331a20f@tronnes.org>

On Tue, Feb 11, 2025 at 03:16:37PM +0100, Noralf Trønnes wrote:
> 
> 
> On 11.02.2025 00:32, Alex Lanzano wrote:
> > Add myself as the maintainer of the recently orphaned repaper and
> > mi0283qt drivers.
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> > ---
> 
> Thanks for picking these up:
> 
Of course. If anything changes in the future and you are able/want to maintain
these again don't hesitate to reach out.

Best,
Alex

