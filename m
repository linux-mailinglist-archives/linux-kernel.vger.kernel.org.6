Return-Path: <linux-kernel+bounces-184298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D38CA502
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F84281FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6B4502D;
	Mon, 20 May 2024 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRR/5/Wr"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C945BE7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247661; cv=none; b=ZO95yqbEMkoentLJP8auThufK8fC5b4AOFIRDeTymw8aaXamUDIGxc1Az4ag1oB2WonWCZBpQPdukaLfhbqp8XcARAxi+o9nLt5XbXfmSdiLX7IJReS5h8YCJDVVeTrdrNVuiRV8wW+aoYwo0Cm0Nxvf5ZP+c+LboC0o/s2SFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247661; c=relaxed/simple;
	bh=e/fo3G6lzIRuWHatgeCurXuLiyR06UN3U15H7QORf2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPiST4dLbeQ5hUJI8Qg4zcSgpPSaTT82jltwUi0+XbeGVEg5J+SECT4LakPmZDUMfRBSj+hdOXkRkAkd3ZBYxUt432dPG7WxkxPL32uPow3yzmsq5Xi4/QEGZUoZv/AvfJ8KYpztHENmOCSNHmR+QIn85fv6afLrXKSO1VrWIlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRR/5/Wr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f082d92864so91293515ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716247657; x=1716852457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdoD1HIhAQ+l2bSFFpdkl6IBifXHGQ29UTqb7xYC20s=;
        b=bRR/5/WrfRbndDFAV+uVcPv58o1DuVyh2+/GdrMOsOtRGmnnEd1qS4Gw4YMK1BUqsJ
         V0h1bs30XZSjqfMqbOgZguyEjlSPgM+tkfZGRemeAs3GIThUomReKoKk1cDUmD7+pW7i
         +nT/rmO0ZZnCnQRQBVQFsm2ikJlXyxXIjpmQ5Zwfp+jy/N+zRCBAzqmfKO2qWtECl7+O
         EUlXHPPTdG+lY+lroHVL0umxmKG0279cZ5yOKbSKUOah3D4NxSSkaBL71faFKDL3j2n+
         o8gMGRWESgg1HDuH/Q2En4CJCdRbHXfp40xPqI5nEeOdobjM7rgQY9fSClNSDdmDfGQs
         TGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716247657; x=1716852457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdoD1HIhAQ+l2bSFFpdkl6IBifXHGQ29UTqb7xYC20s=;
        b=rQTXTf8iE0lY6DSbI//bGjqR1DuQp9ZU4F8i6JKjK0OSj6mOapu2VtYdWcujapcZWp
         WhWb+aD4/4CeZLXxRxZQABoqX9UyZl7yUps1CdA1jyZGdCH8uBWwgP48J18WZx9f6Wbf
         R19FfULP760OHnwhVqTK3hKlzE7nR0ANJvme9UjNTQ5hWsO804PsIbBtGq97dVWs3ivo
         gJanMLGMmMUdgA2oYAQyevyNFlAYeYR2WPrBpmO7hE/LKanl77L1Z4zPvj9aEeXGQQx4
         ehhLv+el00NCdp5u8vVraVkL8xAfzN00OGlmh0kUey6QXhYOwtc/4c2PiEUeGnJQPxQI
         v5wg==
X-Forwarded-Encrypted: i=1; AJvYcCXedeEOYgAYi1K1u4Ls+oBVDXv/bhK2UtigLQRT2WxFWFBG7zBK/VMbat9v34y8J7zUq3S2Dgt9+bdpSdZ/S6miwhRjkyP4IlkmijeO
X-Gm-Message-State: AOJu0YxewfvGeEhSaRIeyMkiV4hYrnFY1WhvXSa823+X29wgsrZLnMLZ
	RW9HpePkEgtRno3Bo1GDkPJ9H75l95OfMiFgVcAa5WsXICx1mdXc8uQf7Q==
X-Google-Smtp-Source: AGHT+IGUH/CprBSVQGsDknYRI/EggLJwApkHiztdjUTetSPuAeZOVir7LTkUJsa7eXvr0UxyUSwnKw==
X-Received: by 2002:a05:6a00:ad4:b0:6ed:60a4:6d9c with SMTP id d2e1a72fcca58-6f4e02992c3mr32608971b3a.4.1716247656829;
        Mon, 20 May 2024 16:27:36 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f677a20c6bsm9750427b3a.129.2024.05.20.16.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 16:27:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 20 May 2024 13:27:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Engelhardt <jengelh@inai.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Craig Small <csmall@enc.com.au>, Yafang Shao <laoar.shao@gmail.com>,
	linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
Message-ID: <ZkvcZ6ykuFd2P_o-@slm.duckdns.org>
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr>
 <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org>
 <8r004s1r-06r2-1pq1-4s29-6177np23q0rq@vanv.qr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8r004s1r-06r2-1pq1-4s29-6177np23q0rq@vanv.qr>

Hello,

On Tue, May 21, 2024 at 01:26:28AM +0200, Jan Engelhardt wrote:
> Tested-by: Jan Engelhardt <jengelh@inai.de>

Thanks for testing. I'll apply the patch to wq/for-6.10-fixes with minor
description fixes.

Thanks.

-- 
tejun

