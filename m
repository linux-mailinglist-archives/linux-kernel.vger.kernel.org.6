Return-Path: <linux-kernel+bounces-348118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC7798E2BF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FA21F234BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD82141C2;
	Wed,  2 Oct 2024 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lErW93qN"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0971D174C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894569; cv=none; b=tWL7OR1UUeGHOxt1gfBIXgoeyZlD2sGxT+ZNoYDc7SErDcfGE+K6AXiKi51wVVSA5LEaHiWhHMCwedgtoaoSCYH/VYZLSB8GLPds6+u2WHsRBeWDBY/UMdPeuskInMGy8UQ+sN1sJKxQYPmZEKKzZtq4TiWMIf79A9gUo42TN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894569; c=relaxed/simple;
	bh=5fXwlvu/i5SzI6mtM2CnEsX3QT/fay//U8wWAi6ZQHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTY/7SPTIOT2CBHaI+iqepeqrxiYqqa1KWA7IAE6xNexuXNyuiYs+PK/CksJH5mI5WJHjin+JjQ1fYgZ21ibjshF5lcheDPRrjZ5PMVH4prbEqbRT996tyK8ExcnkdDyeorLYw0IJ35hfKPzFNmKgR3M3DJDDyrEMXT1xwk69Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lErW93qN; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a1a22a7fa6so619155ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727894567; x=1728499367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4l60eyXSEPtt6iDstGelFULL3ABVlMng2oXtkcSsas=;
        b=lErW93qNlK5Tyix8w9AEngZFdOzydYg9fXSOiSITGTmt7HM/dJjx8rTZrTHs+AecMO
         2gNdlG8eqbTyesulkeA8kaZAzLIlz+HxPoCSe1HiEnVfB7MAxVJuCrhvCGT/ERX3SXlu
         E9cSrBdob7Ygz1n3lhTkYGasPj1NOgcvfBUCgLkUnhMuGWzEb6UtG07Z+ZjTbcNkdkyU
         D6cDRBrZuQvWKny9VbAWrj3qED576G2DLqfAI+SLfIKc0EWFe+SLZmsG04L8/7C2Pgtb
         ZQigX21dvexlkT1B6wBWnGNh3iYLmxbCF2pH+/DAXuuYkjbvDSjrIqvF7gk7Bl/AIPLN
         o/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727894567; x=1728499367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4l60eyXSEPtt6iDstGelFULL3ABVlMng2oXtkcSsas=;
        b=DPNMx1wwI26U12Uxf7W+GwwySWUuU7SWDUDVNuDL3S4+85p66SIfC1AWIj006v5zdo
         QKrhUx7Ed9K7oyun3surhCgjjkgPZzF9cR/m1kxiD+o6bPCRlgLwFIClRPeuNkf4aJ3q
         /dIH1xcD2vmeZIrqQC4u/4U0e1QVflaGWs61LalLTI51oGzilFXO0qUmX3001pjRsX0F
         SdTdAjU2Y2B1IPmHDiuj1EEbBfQ4v6/wf1K987b3ejnQDdguTbN7WKs3Gm0vQAA7gyFR
         M1NJtqQmusbf8VGbbmSY9+EDq0haYIKQDCwXqDLqz9/PPSFrwcL6KUnSjo+RBYO3EzUi
         KEdg==
X-Forwarded-Encrypted: i=1; AJvYcCVBgADDJC4lF/OqUpa79e0r3tsFws0o7TpnekA2KqckVzxh+jEtPMKeygtmD2J5uJgqOxPqAC7gGMPuFGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIstbmW/eTd+WYUA+yY2KDgTknKLs7B9tDaAzVIHUrQ+SbnDa
	HxIDDIiso3+WTFBrhSBDYbM7cCH0nxEv7bK24NClhPAH7c2NvWrz8kjHwg5dqVU=
X-Google-Smtp-Source: AGHT+IGkNOIHmtsK8Jc90wuVxQ7LqZmMQ2F0krBQMJ/mgjZyCRSzxGxp2bwS5hqNy2an5EN17b6Tvg==
X-Received: by 2002:a05:6e02:13a1:b0:3a1:a2b4:6665 with SMTP id e9e14a558f8ab-3a36e2a863cmr5918495ab.12.1727894566876;
        Wed, 02 Oct 2024 11:42:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344de1ce9sm37628065ab.58.2024.10.02.11.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 11:42:46 -0700 (PDT)
Message-ID: <5fff643c-5b24-40f9-8054-59cdbb6186ac@kernel.dk>
Date: Wed, 2 Oct 2024 12:42:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix kernel-doc warning
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241002184040.18315-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002184040.18315-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/24 12:40 PM, SurajSonawane2415 wrote:
> Fix a kernel-doc warning in blk-integrity.c where the 'rq' parameter
> was not described in the function blk_rq_map_integrity_sg. This
> warning was triggered when generating documentation.

Fix for this already exists, going upstream for -rc2.

-- 
Jens Axboe


