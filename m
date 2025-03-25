Return-Path: <linux-kernel+bounces-574701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F5DA6E8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11B91895E36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE1A19EED3;
	Tue, 25 Mar 2025 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XgwUI2B2"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751F1FDD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742873089; cv=none; b=JEYwM5oQrBEbXP2V2vtAoFjLfPo5FEe2oybIBKwq7nbCyQUy0ogOzl+GO3jtRWUEWm9HBKDvpG24QjGzhYXR4Ti7meIYKhVxPt5yzigfPvDSp+Wo89JS4saUywcHJziwVEs2gCbbYirKTbGttX1QRzG+0x8rWzi2UlpJspOThFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742873089; c=relaxed/simple;
	bh=m3C+uTMvJM5RFkt7M/wtzib7q7b+9i6ok0fza3OH7Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXqDDPEcRFpWdG4ZIqkemO4LD03bELduT6ts05R+4v2aNzem2mvXdaqpncRg7vunVh+6yQRrv2zQVxnP/G5FjEyFYNs71MHA++WsaXc+/KkIgFs58/TGI0ztRZiS2ikZmytu9Tmv82w+qm9GAn4a74RkoPISAcibkxzKUJRD1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XgwUI2B2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso28253405ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 20:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742873087; x=1743477887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m3C+uTMvJM5RFkt7M/wtzib7q7b+9i6ok0fza3OH7Hg=;
        b=XgwUI2B2xNWYd3aYSfOrvIrmsGXd1yo53WYqeXsBHVSDRIcDvOULoDEXmScfJmGC9S
         YeanJZ6xjA6mXG6pe2DohUFawu922tv1guaCbhnobPLpRHOCYgRIFEgDULxyQnoHMnLL
         wHDjmNgzCsDb5owq4+YuI9dWXmNrZmpOWoHLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742873087; x=1743477887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3C+uTMvJM5RFkt7M/wtzib7q7b+9i6ok0fza3OH7Hg=;
        b=SQBgYnNQQ1PbyyNite7NtMZW5KLmjN+Dd4rFNEP6dP28M5Syimv164lbnnlkffL36P
         esz7ij6l0CnHvxTMF5PesHfOc5Vo549GbKJQQzUzxGWrQVm+fFiNODch3eaYgk7PrZpV
         LT8lxMXf/wncEdzwjud3d0BFsi3Dp4nkAIhwnKYDoJMkJVv9eDTRhn5bn3EeTEScm0ft
         WtUEYnCg6aiRWCtp0T7+axsn2aTHv8X25AARAjku0Ab72oy8y+o3MyCS1kSyuMoflu77
         tsQcXv8mfV/flJNnUdV/QxpcTYfk6MuesGPE0uEzuWgg6+y5cWN1X3rsjtA6mnyKdiZ0
         KEYw==
X-Forwarded-Encrypted: i=1; AJvYcCVbu0kt48XaoA5zlMjVEdrlixAQmlgqPz+78umTj2bOzpq/mMKn4Tgj3Q/AIChu/SkBYKN/S1/pR/jXEw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyyTv6xz6bNloxvY4jrFUr5Dz8Qs69BW9B2FHwdWR4jJ/m7dw
	sILI0DcPQcxE7P0WMfIiEzZW13UlKPzOuvdXU4M70EanbTqFGR2Tz6phMje/Iw==
X-Gm-Gg: ASbGncu76ihtI+YWHUGsclxTJKuRozX/uCEErSf//RgFRYtur8YiIRhVyw127ARpf2V
	VEGCEbwXXAfyCjTcN+/l/fZd4uatsrzHS35FVzddAhe9aa7SLc3tqhyjj/3M0R0X6DJWN2cxSjf
	nksz8fTsxJEHRGKKSkIlfyQ+BIqsLpDN84CpWCnddkIJEss1C034GuqNQlx9NmpecVitCF76ig9
	SwtNZtzsaOJa0LTdXdJXCBeSOVC1U6/R18CsjOtD8bPlpE+IbD6YNKVS12qVrLN+qGXOXcfWiGZ
	W29UTYq3oB31xmLdqqOmKuwH0zHp0dHmzXs94TyGEUsS+WmN
X-Google-Smtp-Source: AGHT+IFPnnSPt8FXPt92912/10CHAuk8319S+W0ptpwjnV6stjmMuK14t3Al2sS2qGfVMry24h2t4w==
X-Received: by 2002:a05:6a00:4648:b0:736:a973:748 with SMTP id d2e1a72fcca58-73905a2515emr22240445b3a.22.1742873087113;
        Mon, 24 Mar 2025 20:24:47 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f107:eb57:41d8:a285])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab82esm9223499b3a.14.2025.03.24.20.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 20:24:46 -0700 (PDT)
Date: Tue, 25 Mar 2025 12:24:41 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] mm/zsmalloc: prevent integer overflow in obj_free
Message-ID: <cn34qjr6ozsb7sgmomgd2srdxsl5n6eruihdaqa3yhtqfsrcjn@zzq6lmghwipx>
References: <20250313115147.47418-1-abelova@astralinux.ru>
 <w7ralg6gzp6kuqwulpczs7uv4htllt2rasuto5unoy7xasr5cv@2z6pd7syyj6q>
 <ad70d906-8889-40d3-9af6-6a2be68faf77@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad70d906-8889-40d3-9af6-6a2be68faf77@astralinux.ru>

On (25/03/20 12:12), Anastasia Belova wrote:
> If address (and unsigned long) is 64-bit, the result of multiplication
> won't fit 32-bit integer. Please correct me if I'm wrong.

Even if we'd consider s32 that should be an object offset of more
than 2B bytes within its zspage, we never have anything like this.

