Return-Path: <linux-kernel+bounces-538810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE14A49D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADAC1883323
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C7274264;
	Fri, 28 Feb 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rHQbS4AI"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B51EF399
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756142; cv=none; b=Doeexitn5DbJ3HkN2WQZfQwCTjl3/W+sH18iTcAZMMEMtEVawnhHXwxi8VT56AlVHYU58PPdgP0wlV/N226tJRaOFAbibvHXr/8VvMvMpRJzmDDFuzOe5HqoClMlXm3laLK7rogn/2rzZ5N5q2b8psMyYKa0ZWP1k8Cjp2q4p8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756142; c=relaxed/simple;
	bh=QqyLu6u+1ahNp3WxvxP4um+m+DWCdM/0jn00g31dnvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KudENCr86OwWCc9fQhLNMf8pUiw5PoCPZiHmHWfPBOb+4aKhGIGaDsZVq4F92f3uduWyLd+cuMLw72LenslR0my25YrynONHF8doeVv6IjHDD8bLhdRieCgkDc6lDXajQOmGNsLBX7rBE07FWq/eXIFlj9ajSpx11m0H2pMTBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rHQbS4AI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaeec07b705so349401966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740756139; x=1741360939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqyLu6u+1ahNp3WxvxP4um+m+DWCdM/0jn00g31dnvA=;
        b=rHQbS4AICxK61+BHGsx5IfT47Ine+qCwkDHJ5T/MuQg7hWZjlFO3oyK9iZXOLWnCWm
         Lnh95jQP4IM8r4KPzBiCiGx3Xfe/AmtbUisbLEiXTqQcX0ciVxdXSkEnzASkN3ri53sq
         C4jF7J1O+fewyXrvXjRyFW0fYH2OgO1C3ym1MgoxGme8g4FKCyjldf65rHTwp8wPEXGx
         W4+NBI8FKX6s/m1EFeltBRQXjwFiwixaT+iXMQw7VhYj1bL9sBrewpDxro0TyL6ar8ea
         i+f0qrN4cfBvMGZJ4IybUYQFnfv3b9I4R15g384NBiCBI4oijfKjb5l/MqkEnodtq/0j
         8rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756139; x=1741360939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqyLu6u+1ahNp3WxvxP4um+m+DWCdM/0jn00g31dnvA=;
        b=wDOFBdnLrIPk2MhhuYdGrXSYR0L68yVdwFLmDaeBsyGuWeOQlQ5CMujA3fYOCug92P
         HyakbByiMKRFaBygm4vGkEDUtx8aXgnpEdLFYLVEL4EChKUiV3tYYBefKesdnt82DpCe
         rjSv55CTKVN86QWt5BS4hh9sEfUAq8Roa4Atciu4gD+aC/wDvinTM8iScXKgY5fJHEL+
         DJsz/OqWsCIMhPHHEqdJcFaJFQcShvalXfjasZFcF6dK/rnlmaKCTTLNr5pjZRxDisGD
         CGGB2Ffizhrj8/vd+HsXwiPHPtPylf0/c/0AsrPvJv2TitRO687Vp7VbSf7Wpt+z22zZ
         Sw/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXowwJ7bY+nHyf0hIknzftyrNQMOrmujhnerOxi7+Puspj73ajHGwCjkikhX7TdR2lh5NitPkAiBkhI4rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCHVS5idffv1MBlvhHvn6QHIE8U6mgzVDpu3HhCRNBdmYyfet
	c7CMq7fYJhDm5JwHdgnCREExuHH84L4fxPtPJ/zEhFoNuxd/oATk9WJQeLAbb9c=
X-Gm-Gg: ASbGncvEj7ZmEJon4SUDQYvFuOKtXgPEJMoTvC9m7iDS5GcZeNWpWJgilP74Xynj9hO
	sU5a637MD+UX/d8Bx8fF2Bw8y6DWp0QSbhPKpBMf3pepV6aPsRYrrd/goODgsw4391zLHPmN29g
	Xt9NtbGdIw0CwY5sd42bztpd0EpktiNfCUzD2R8utvWxduApneTRdo0bW6gfhfi8XpNAxxRbqiB
	zUbbjgbAvplNqDirVOdOZuLJQH+N7YfTCaUMQPl3/nQTeZPnF6bjaNdMV850EEuzYPzDX9pIsGE
	GoVxTw5UrMmHpewONF0lCqsshl0DA+yuUo6Wo892n88g491+gV3csg==
X-Google-Smtp-Source: AGHT+IF9qp8a/UWBHc5Cf5P7FBXKmaSQUjAHQFD/EXiBNU4nniytV0W3aEh9jTooEY6MlyF55dubEA==
X-Received: by 2002:a17:906:2dc6:b0:abf:47cf:8323 with SMTP id a640c23a62f3a-abf47cfaacdmr49876266b.22.1740756139004;
        Fri, 28 Feb 2025 07:22:19 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b99a6sm309411866b.13.2025.02.28.07.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 07:22:18 -0800 (PST)
Date: Fri, 28 Feb 2025 16:22:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: przemyslaw.kitszel@intel.com, arkadiusz.kubalewski@intel.com, 
	davem@davemloft.net, jan.glaza@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH v4 net-next] dpll: Add an assertion to check
 freq_supported_num
Message-ID: <i4sqqg4wwlrh7gcvfrmif6jwv4uhjavwbzgzmvcsxc5ocma3jb@r5tf5wbairf4>
References: <20250228150210.34404-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228150210.34404-1-jiashengjiangcool@gmail.com>

Fri, Feb 28, 2025 at 04:02:10PM +0100, jiashengjiangcool@gmail.com wrote:
>Since the driver is broken in the case that src->freq_supported is not
>NULL but src->freq_supported_num is 0, add an assertion for it.
>
>Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

