Return-Path: <linux-kernel+bounces-255659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930893435D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80D1281D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E71849C4;
	Wed, 17 Jul 2024 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4d9T+cZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDA1836D8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249370; cv=none; b=lmuPXWg7FKcLKom7CJ3FezSTcFuKKRs8OELTDgF7DwbPcm2dkPDwNMVDRMxnWuzhR+sa8PSZhtvk1KsDomwKYJ+DUBEeJETIRum3c1EvBMlB6A+6AwSBB1gUmfP1+dRNHt8UgH57dvRjjaFB+09uqy2rVwKaRWi1+GqXIGV0uQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249370; c=relaxed/simple;
	bh=JDSn0grBwzh6kdZ/RuAvNWsRAenmUTQXGIPExKe6FHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md6xAUAqiu0bpAsQyeWCGNrxtuZ33osop1vYYjBBtnO3OJ499r0zd74I9Rkn4uKhEqCeKXENSmyPh9mM3dm5q92Zh3jjeEZoAlqFtQezR1QbOr/DEfan7/CMPevWFDnvGEShzmZX1A7Hrsg5542ZLEVLraZHPEyonXZtQ12al10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4d9T+cZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721249367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6yqyiCjDiuWKnAEK2Ubaa9MJxWCaEI2x5X587Eb8o3o=;
	b=N4d9T+cZJVgDAhRuqiXXMKDbLuOKF/IZfoVCLmHp7mNq7VC7vBtYrByx4IdAgRiirmq6YX
	YMKdMfF9x9SMXocOSHViYgE+lvRHYK3sQI2fP8bi/L7s3M/JGXtjVS3uiCqwh2gHBTYEQa
	1scY4C+bT+5Kzekv9+IK9BF/FRHDDYk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-pWoSPyGpNri66HfSZunQJQ-1; Wed, 17 Jul 2024 16:49:26 -0400
X-MC-Unique: pWoSPyGpNri66HfSZunQJQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b5e21026fcso2240946d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721249365; x=1721854165;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yqyiCjDiuWKnAEK2Ubaa9MJxWCaEI2x5X587Eb8o3o=;
        b=Fy1BpK0Enc/Niekmsjq66nnOALZ9BQ3ybEIe1xP0I3m7A1br3ST9N002oyNUdiNP2j
         GTAzSkV4XjufPajeR5M7NV2sQSTEMJ5FR7utUOj/O5n/GOV3CgVzY+aWtsdBTWCwT/v0
         F4TLT3zXj13hN5QikkTg3vAWUHboPwzfxDO6Z7BSG57pmnbwUMBOyzfDYkPoG15GCpJ/
         V3seEXuSF71lFIdhBYcTq46VfvVG2cXJLBGJDRGAEg8R3ORWRnXWc5nb8DSvX2rXcF68
         XwB2nZSzOo9Gh3Iw52vJDb9KXtmokjI11kvGatPHImjpN8u+7HlNKq9puWyUO3Xd019c
         T62g==
X-Forwarded-Encrypted: i=1; AJvYcCXf07qLceNy7h4YfgAb8x+t8oLt2DrCswnbL9EYlD/9aTMCxvFXEnssrHuENFnpjhOb8Xb3Ao+sPRXrlkd9Dlnl9+qPmuxLO8D4ZvF1
X-Gm-Message-State: AOJu0YywEZHzhV4uW736/qOokaqt2meewmiA27g32Gs8p8+v11PWOA8u
	kc1uWA43xDMmFcLkvOI9659nFjMxgot5HQ9Torjd77u+WtStnwssXJ5IiwRFGcgrzQTmNsB7OuH
	9WKDUqt8RqsLiqCw/ANdIXP0wN9HCK7pxml+kK8jOGJVE/GZGZM1Jwe6sALxk3w==
X-Received: by 2002:a05:6214:410b:b0:6b5:52da:46f2 with SMTP id 6a1803df08f44-6b78ca51491mr39583386d6.6.1721249365306;
        Wed, 17 Jul 2024 13:49:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrgnTXq3RE542WMQqUS6NsqxtYgjyO5aJFGtpdKnMMZJpgkLH9LrtqDYAPHBU104WjJ87ISg==
X-Received: by 2002:a05:6214:410b:b0:6b5:52da:46f2 with SMTP id 6a1803df08f44-6b78ca51491mr39583286d6.6.1721249364980;
        Wed, 17 Jul 2024 13:49:24 -0700 (PDT)
Received: from optiplex-fbsd (c-174-169-122-120.hsd1.nh.comcast.net. [174.169.122.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c60dd19sm2078766d6.78.2024.07.17.13.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 13:49:24 -0700 (PDT)
Date: Wed, 17 Jul 2024 16:49:21 -0400
From: Rafael Aquini <aquini@redhat.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v4 2/2] kbuild: rpm-pkg: introduce a simple changelog
 section for kernel.spec
Message-ID: <ZpguUYXVno5OUVIJ@optiplex-fbsd>
References: <CAK7LNAT_b6hmN4W94D_7o5XZAc7jYhBi5rp=GUE=y+_BHjccGQ@mail.gmail.com>
 <20240716122505.3425582-1-aquini@redhat.com>
 <CAK7LNAS9FfGmB9aPL0+b+dUUH0v0Gf7tho1tE293szEQ3x5u+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAS9FfGmB9aPL0+b+dUUH0v0Gf7tho1tE293szEQ3x5u+A@mail.gmail.com>

On Thu, Jul 18, 2024 at 02:10:13AM +0900, Masahiro Yamada wrote:
> On Tue, Jul 16, 2024 at 9:25 PM Rafael Aquini <aquini@redhat.com> wrote:
> >
> > Fix the following rpmbuild warning:
> >
> >   $ make srcrpm-pkg
> >   ...
> >   RPM build warnings:
> >       source_date_epoch_from_changelog set but %changelog is missing
> >
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > ---
> 
> Applied to linux-kbuild.
> Thanks!
> 
>

Thank you.


