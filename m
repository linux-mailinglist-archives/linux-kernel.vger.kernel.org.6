Return-Path: <linux-kernel+bounces-305694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4F9632E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C93B20F92
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CD01ACDED;
	Wed, 28 Aug 2024 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GlWXGPnB"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EDE1AC8A4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878110; cv=none; b=qYQLMXOL4wrYbpjmIKw4rArpByrc609Cwz2kz51ntjU8GvsX6I3F7TjtCFsjsvs1iQDZc4vKI0jD0Iq07sUwLO3X9sQuEYRwA6uIgpXjZQJ8VgHSy37EhNqx8S93r+SQUSIs28rwW8XznsRV6SQF4OG9P61fty/Xj4mx5uKCmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878110; c=relaxed/simple;
	bh=gJaEHXrTeNSaE4eFCVkHF+bcWMfkiaVOpQZnIb9GD4U=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=AQ0YeDED1pGVnYajmj2tuht9qIMUV9jvrDHtF26CIlswUR7NrGJUot6pjrIfli9XJCufeRFfYcHA8ASt4rLHn5voxkyGyOH/Dtl+1Pswg99y1S11nOzujHsiYIYDZjK59VfTR+9JGe0/F+40cDjFCY4A27EJg+LZkkEyPNVyRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GlWXGPnB; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1d984ed52so452150085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724878108; x=1725482908; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MFm1oliNMku3718rpHjj5GFBtdpffkYvzVOrkmijuG0=;
        b=GlWXGPnBBJwQNRZ8oLVwjXsh7T5iM2cG9JlXwHU1itcKLBeDEMbJi3T4tg/IXcNM3x
         gGBFE7P6UB+joqEbiY9rKvE42MLeC/zou62AZS+f2L87xCvcvy7KO+o7TrYGo7f8/vPo
         +lUMlgSNm7h/wdm5TmocX3Y0HJuLo2XMQrwErHNcApFyooGIceUNGmQ0ALSBK2Krok18
         SSaCDxpLyFo9ds3kIcCZhR++WxgSDig6cFOuGUUELIhDpsEDnJXk7tXa5oUSQkYNVtMi
         ILFYNhy0qCkpFUUOU6MIUCdqJJI2iKS0BrTEdewXbdULdSfaaWnQMD7Mhx8UlIJPMb3P
         BgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878108; x=1725482908;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MFm1oliNMku3718rpHjj5GFBtdpffkYvzVOrkmijuG0=;
        b=YrerpzpxRt4MIju7LW5/TO3IWc+pm8x6fPHxgB+ObFYbTV2zVF28X/1MkeaPLs3ks4
         oPpnUKDG5pC5xur+Xys0IBwFQUOYquorjvbAAlh5yaSHUe7T9p6EPOyn21yQUFzCbh+V
         bDq6oXUJMHRzCNky8U2v5jM0lP628L+wSe1dcVwQqTormt4l3sGEs5gwrW/IV3m57SXw
         ogPoAbgAjdqj3YGTKBY5roI0C5OG3SA281OUIO+H38eNkmZe1vZAPRNz9irbU9Vj5lvr
         X9sfqLJfkt2raJDX75Wk95vkAmLmTwQExYA8XMrTd00rt44CZ97IMWtxGmcOLOZ8I0yp
         IKpg==
X-Forwarded-Encrypted: i=1; AJvYcCVIuKVtT1vlWkC1AHTpZFt/KDAel2FkFgY4S/MY2mzsYHfxRcoTlNgLPHn/hLpPiD/d2ahW34HbIDD2OA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfW884bN1Faln+AedH/Pr51CEdn8Jq36WzAfH7B3fFVfsrvfH
	WB9g6fUPeO+RlEieuZVHE5t7FFXlyGxJietlsz8K+aghRuV2idcpo19J69yveg==
X-Google-Smtp-Source: AGHT+IHAdwjDarEQRu2k18EI8XasHntWYP53AaFrsz5sI5yRSFmJR7fmGFZ2aT0hMkzM5kEv5sHRug==
X-Received: by 2002:a05:620a:1a98:b0:79d:7d6e:e02b with SMTP id af79cd13be357-7a804267f40mr64537685a.70.1724878107666;
        Wed, 28 Aug 2024 13:48:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a80236a344sm35923085a.81.2024.08.28.13.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:48:27 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:48:26 -0400
Message-ID: <49419bd051ccdb64de7222e2d17aa77d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>, eparis@redhat.com, rgb@redhat.com
Subject: Re: [PATCH v2] audit: use task_tgid_nr() instead of task_pid_nr()
References: <20240828112528.954163-1-rrobaina@redhat.com>
In-Reply-To: <20240828112528.954163-1-rrobaina@redhat.com>

On Aug 28, 2024 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> In a few audit records, PIDs were being recorded with task_pid_nr()
> instead of task_tgid_nr().
> 
> $ grep "task_pid_nr" kernel/audit*.c
> audit.c:       task_pid_nr(current),
> auditfilter.c: pid = task_pid_nr(current);
> auditsc.c:     audit_log_format(ab, " pid=%u", task_pid_nr(current));
> 
> For single-thread applications, the process id (pid) and the thread
> group id (tgid) are the same. However, on multi-thread applications,
> task_pid_nr() returns the current thread id (user-space's TID), while
> task_tgid_nr() returns the main thread id (user-space's PID). Since
> the users are more interested in the process id (pid), rather than the
> thread id (tid), this patch converts these callers to the correct method.
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/126
> 
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
> V1 -> V2: Added a more detailed commit description
> 
>  kernel/audit.c       | 2 +-
>  kernel/auditfilter.c | 2 +-
>  kernel/auditsc.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Looks good to me, merged into audit/dev, thanks!

--
paul-moore.com

