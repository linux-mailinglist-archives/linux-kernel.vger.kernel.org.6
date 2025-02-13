Return-Path: <linux-kernel+bounces-512116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F55EA33445
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E24167095
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F7878F24;
	Thu, 13 Feb 2025 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JsoEzPnx"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADD4D8A3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407886; cv=none; b=rPzcK/k5RZU9ouP0/WyxCEHVHV8xrxo3Tuc5B7xOt4HTGS4pHzAN5fHEfFzY17EgBP0/lx3m5EXnMrlej9bJGtS/kobFGRjpW6nlPdy9HiXFMM/Pikse3nC1vOzTAhW4XotVSK/aI1rnLVBlAycnd2jFbtPIWEwtOcPjBK2C2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407886; c=relaxed/simple;
	bh=HEEc1OQOOdaTanth8exTPs0cDMXFCNsQuNkN8Ht8j/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmEKmbSAZa6FMXTSzDJkRfqSRd+6PfShbstjM4vKT2GDhLeV75E523HhgmNGKv9acKGEZqI37NnptZRjg4JydoReZpvJfsVS3NmCWMOYWkuXMA5xMrnDeL014K0u63QCs9Tt9JTHtlirIefgstPsNuY/eo/J3c9F+r/5qkBzrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JsoEzPnx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f49bd087cso4110615ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739407883; x=1740012683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r05a82z1APr0gUiGEvrQLAFO4U9vsuwFZGbyN1oDXqs=;
        b=JsoEzPnxksc2l05SK9joPBc4UzhS7tqbcq55DDQF3y5QVbi4y4rylZbzdpbT80T4XU
         vPP//1xuTnBJPLNMe0NozMHAJZFEhSaDKNfGvFAWO1qdZjlFZV9v7C9bFdk1FgQzXpid
         2oab2cjZYqKoE0AFQPXQx+Giep2xWjxwoWXSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407883; x=1740012683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r05a82z1APr0gUiGEvrQLAFO4U9vsuwFZGbyN1oDXqs=;
        b=HmLTONNNVJqD97uv0U3xdOr5TL7ujJEj6R14F3O3EQn3/KCfNA1gNHgIzJPwPYwbEW
         YZWq7maCZAQMrMFR0mpDrMfvwH5E2eAT6ZTvFmV+cgHqGiP0MoDuDf3smBXmiOnp3aL+
         8MTaxxV1/vV4H99ZeUSb0jhZryZSq6vrCyKayNh3/WiHCoGq7ZHIzkrua1GQKxfSWN7d
         66EUkMm2xNTiECxqvi/toWWHoKLmquKgGt4GPaT6FPej9aFX6rUnW8BN1WNRMrqIDqJs
         8X7F8QX2HnblCXPLWXhYRHTa3BS7o78vKqn0VEdGVx6mclo/AwgNSZt/wCEPFFNQklRb
         YI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqBz3uN6g/GbiVpk8IYMkmnieaNjMGLPx4PeUsJAOnlByf/DJg1GSxDPovqftH+AsJiHCfMPzs/cllBJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZJa05BgvRlgKrh/tZcEU0PVCgAknLYewjuMe1pYoj5AJ5rGi
	cuU9DjOwxdxe5Y/hSML1C1QcQNUSHrJCkFOrpcxvdFPlpD0+WRaHgeq86mk3UA==
X-Gm-Gg: ASbGncueNfzGFZgCPtzt+P3ETzlpgHqIgj1/LdBkYd7JmjezyAVboP4R9LnUlxtbtdD
	XStS1z/04NpmueILypDsz13RZrtWyrFQPidTKE4zK/sk12+3Li/lrImJ3EAlRWn5bNV04TuNlyC
	vx/qljFlW6Uckq0AUJicUj9Zg1qYM0vuvqOm12K6GLQPjakRSNfdPoBJv1wyia88e6+0UTVzykK
	IVthAcX3v8QJPnCJaQNpTigX47nWBpMYp+m8qN/aaXMSesdSbAwaA3Uvr/kRMMh0OQvClyzwYqR
	SmYk+a+Y1TksOiqG0g0=
X-Google-Smtp-Source: AGHT+IGgz0RAEzqP4Wx85JQhy+tJfkh+g8KkMgjaQdFTqWqNqIMWapFbTKSFayf4RrSW0aN+jnkZgQ==
X-Received: by 2002:a05:6a20:3d86:b0:1ee:67ec:227d with SMTP id adf61e73a8af0-1ee6b399b6amr3133288637.34.1739407882799;
        Wed, 12 Feb 2025 16:51:22 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324276169fsm65303b3a.140.2025.02.12.16.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:51:22 -0800 (PST)
Date: Thu, 13 Feb 2025 09:51:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/18] zsmalloc/zram: there be preemption
Message-ID: <p5tmome7ycfezuunnz4l24lt6sir4nms524cfuebr5ndkokbk5@lflejozsvgtf>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212160956.8bc390876af3c6669b8031d2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212160956.8bc390876af3c6669b8031d2@linux-foundation.org>

On (25/02/12 16:09), Andrew Morton wrote:
> On Wed, 12 Feb 2025 15:26:58 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > First, zsmalloc is converted to use sleepable RW-"lock" (it's atomic_t
> > in fact) for zspage migration protection.
> 
> This sentence is stale?

I'd say it is accurate, zspage has 'atomic_t lock' which is reader-writer
type of lock (permitting scheduling for readers and forbidding scheduling
for writers).

