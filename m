Return-Path: <linux-kernel+bounces-401104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E079C15FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33AA1C22BD4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43F91CC161;
	Fri,  8 Nov 2024 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K5fNKBQa"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347F1CABF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731043792; cv=none; b=qX69K9hF1Ns5fTy8rsgAd0S0Ofs9cAvcyUaCbgwsGb5nVlUMtOd+u3sziofqjEQdQcx1hQnw+Gpm7yBXFkbgy9xcUgDHKBG1bmRoNHltJwIu5dpRCIrKKqtw2f4PM8AK9Aj/b/1RdpAsFpkMITVBbWOXKbGk4JRFQkssVx2xuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731043792; c=relaxed/simple;
	bh=CCCwNsttvHqLj9XZitFK8pDD8bjXnilxTftUf9wTADI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2uEkSsY2XTV2Vs0nI7zykGhnhuw5w/daxYkKrE8PYwR88GK4ucAJEW3Om/znbNGb/5lEelZUuUYkxBdBpZEwMEnxqWOuijK6fPBPga4RNULEdRmxgEeYkn6RMt+hG41/6meFFc9IMuIkBsay/MJgVjilaJ9Jj+trZGc4WtNA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K5fNKBQa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43163667f0eso15526805e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 21:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731043788; x=1731648588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s90UXkcKs3A/LDrUfownwKO128SBPpDtY4ua8QU03HQ=;
        b=K5fNKBQaxiRdZgs+RHmtmyncPtojPWfF2qfA09bnGOyD5ZsJYDG8o74vnRKEOGSoEt
         vHDbE3PaKjVoLuTs7RBPTGirpr1O1YCkw5eCLtj3df+FmehEqRX1h9mUVoingRnOI6aF
         wHM3Bxs/JA9HfX9bmNOYcDbMTbtT16F1bPqo25B/K7TX6KYg0YQfeZZzid+kmyek+Me6
         YHMbjqvjmUBnJtFAl/pTktH33npkJnYsWz0GdbYxKvQi+I6s9tf9cAy9Fyf6aw/91MeM
         u6Zs/KKEFm+2/94z6d/DLrSeVXjd+nxkfMxUrulRgIb9uQrya7sbF1yaZCBEuu1M0o40
         FB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731043788; x=1731648588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s90UXkcKs3A/LDrUfownwKO128SBPpDtY4ua8QU03HQ=;
        b=uRYFaBTijVPt7qhyPH1GYvWaTPJyOGYkH6JH3yTIZKGgJg7Vb+J866DTq6cN1hazrT
         6jMokln3uWeU4ToY854xEMWi2vKiU6kQFnH1fjts3HM5Lfx/TIacG3X19g2YVcxdwk8K
         wMpoaDntlm4mRYHbl4UxHHA+Da6U+JENIiTieFP8tkSaAcDuW9a+RbhYYPUflm4TIlUd
         GRtoiYsKhfdvUyQ8Ub9GzpTdre/w4i5DQEBmJJ+p/PrGzdcoj3gW3b83SVbY2CT6TnPe
         UwpIa2ZU/WE38ViK6Es2lJ9JJfITJFI0F7AnK5IIyDXv0ZYiGqahqSLtnTdgfssF5M15
         4r5g==
X-Forwarded-Encrypted: i=1; AJvYcCVUcijURxSm7/g+kaYg4i3L+oC5v8xOQ/kKSJyfwTqqeGfRseSuECVHCk6AbYhCvPNEZyikARgJ8QZOqCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydXEMciCQpGmn18yhXQsk1SWZ+QZjTr7KbYIxLXB6XwVZHHpDo
	jDccjMnXBPBgxavOmVdnTuliONTjfmCrCjokEfZyRFm/HHyQ+1T1deKCuzU28K2GU/Kf0XFTvLk
	ZmnixNw==
X-Google-Smtp-Source: AGHT+IH986jum1srZqxKElgt7ODodxcU+4p38IQyvOniyWcQ1Ycd4xDgJh4KIm/LAczW9rVQ264ZeA==
X-Received: by 2002:a05:6000:1acf:b0:381:cffb:f35e with SMTP id ffacd0b85a97d-381f18851cbmr1081416f8f.54.1731043788238;
        Thu, 07 Nov 2024 21:29:48 -0800 (PST)
Received: from u94a ([2401:e180:8800:eb21:7695:a769:ff9c:3830])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd154asm2556924a91.40.2024.11.07.21.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 21:29:47 -0800 (PST)
Date: Fri, 8 Nov 2024 13:29:43 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: cve@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-49888: bpf: Fix a sdiv overflow issue
Message-ID: <klr4llu43s4osw4o7234no33k6eujo2wvpeyhft2z5zgib6zac@hvg72k5q7w3f>
References: <2024102117-CVE-2024-49888-027c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024102117-CVE-2024-49888-027c@gregkh>

On Mon, Oct 21, 2024 at 08:01:36PM GMT, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> bpf: Fix a sdiv overflow issue
> 
...
> 
> The Linux kernel CVE team has assigned CVE-2024-49888 to this issue.
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 6.10.14 with commit 4902a6a0dc59
> 	Fixed in 6.11.3 with commit d22e45a369af
> 	Fixed in 6.12-rc1 with commit 7dd34d7b7dcf

The issue is introduced with the addition of signed division
instruction, part of the BPF v4 instruction-set, in commit ec0e2da95f72
("bpf: Support new signed div/mod instructions.").

I'll send a patch adding the ".vulnerable" file to the vulns.git repo
for this CVE.

Best,
Shung-Hsi Yu

