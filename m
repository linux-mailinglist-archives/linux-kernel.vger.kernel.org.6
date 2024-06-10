Return-Path: <linux-kernel+bounces-208909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDEC902A82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6EE1C21592
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D852F7A;
	Mon, 10 Jun 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lnq9RtXh"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506E210E7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054508; cv=none; b=PJM0ehbxbb2BiKVIouXqHnFFinqnJWtw1l9iVse8U2CrAWUF2roomdNUVHExHhL1zbzePKUlvLinhG3c+dGH8em2Z9k8JqBkXZ9Jj7m08ygc51FRuJQkQsUSGn5Nsh7JraUkK7lPWF0ampZf0vyQ668xYIZQ5ei0XqIWCeeZLtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054508; c=relaxed/simple;
	bh=Ebs4nqSyxTC7YOoKfmV5g2RqzN8IbP9gi80gVXxcZ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2yScM0bnjDvgs050fHNI/nvcCw+oYTZIqXMAo04SA+g5nheavHUVOfvr9h3I7y2O+f7Af/3CdPp2IxQ1snvR23LSB9c3dJ9LiASAqP2XQImeLMyzj3pX4CWcifP0lMI32CE+KOKkS0gt2IiTGLGs4KED7ME4AprhWN6lyxmM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lnq9RtXh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70435f4c330so363271b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718054507; x=1718659307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTrSzqroCnnfKu9jR+6XH4u/v9o6TOzSwKexLPygfMM=;
        b=lnq9RtXhXH4o8gYjQNFlYMZ8BKMW7NzfStlRS4aDMQI1/CpgZ1SjhjAWciblR4IhUS
         fRaKQOvHFHof0DmGZC2E1byvjQ57b9c9E5SF+LMeX2K3pLu8TH+jPbIfZHsE5d8kW07x
         28NqjdDcz6zFg/R7uCVdr3SemEAHhf89LgMA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718054507; x=1718659307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTrSzqroCnnfKu9jR+6XH4u/v9o6TOzSwKexLPygfMM=;
        b=ZwUWy1jJHJjr2KzvWtlLMRanlZwSzTeaKrPmko0XVBmyhWA8gMAWvbunR6lpZbWvAB
         8OD8GI8cDJRSsN1RNI5K+x0k7jEOwHhHUoZhZqwDxmI9BBOPpL//6B9WP79pvM2jiXHw
         X/81qJV+wHQDme6NgVEBm0Q5LBFF9obL41p53i228h3D60SGbXM/TpRt/gbWGr9m3pSl
         PKQgJ36zN6xyi9HPyn9eTPxrri4OeC0I40hU8CGL9Pw19fkcnaQkliWdxv8WWU6ireAr
         HuLW15oaVDB9SIL8ZEB6EIXh59jutmSTblOPFsKp1MHKExKYTI33dT9HzMWEUHRk4lAD
         Z4JA==
X-Forwarded-Encrypted: i=1; AJvYcCWGdie5HBaAZipE3wg4yBR58PztqOXXL4BRbICjMjbFzFvx4r+dYuOUx54Q78XOAXPNxMg+fm3UEzgirXUn0wSI3l/7LUlMLmQTydgI
X-Gm-Message-State: AOJu0YyBNy9l1mecohcdY4u7cgwULOnm/44Ax+0Ao0Njxnf2fO5MTwjy
	DG+y0gWpw36ty+tMTGLulmdBMAFOG8UqHrkuiCS3Vfh8Ijxo32cnrFEc7FcaJA==
X-Google-Smtp-Source: AGHT+IFdt/Bsl3sTReJ3JBfGbS+q7Lu3Ku1mz2XXqSLSqKVNSad8z3U2CIqeOp4Se5NL/2gJ/wOfeA==
X-Received: by 2002:a17:90a:4892:b0:2c3:f0a:9e3b with SMTP id 98e67ed59e1d1-2c30f0a9f3cmr3052068a91.16.1718054506625;
        Mon, 10 Jun 2024 14:21:46 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2c312c80edasm2118505a91.42.2024.06.10.14.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 14:21:46 -0700 (PDT)
From: jeffxu@chromium.org
To: aruna.ramakrishna@oracle.com
Cc: dave.hansen@linux.intel.com,
	keith.lucas@oracle.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	x86@kernel.org,
	andrew.brownsword@oracle.com,
	matthias.neugschwandtner@oracle.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jannh@google.com,
	keescook@chromium.org,
	sroettger@google.com,
	jorgelo@chromium.org,
	rick.p.edgecombe@intel.com
Subject: Re [PATCH v5 0/5] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Date: Mon, 10 Jun 2024 21:21:45 +0000
Message-ID: <20240610212145.3374270-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240606224035.3238985-1-aruna.ramakrishna@oracle.com>
References: <20240606224035.3238985-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi

On Thu, Jun 06, 2024 at 10:40:30PM +0000, Aruna Ramakrishna wrote:
> v5 updates:
> - No major changes, mostly a resend of v4 - except for updating the
>   commit description for patch 5/5
> 
> v4 updates (based on review feedback from Thomas Gleixner):
> - Simplified update_pkru_in_sigframe()
> - Changed sigpkru to enable minimally required keys (init_pkru and
>   current
>   pkru)
> - Modified pkey_sighandler_tests.c to use kselfttest framework
> - Fixed commit descriptions
> - Fixed sigreturn use case (pointed out by Jeff Xu)
> - Added a new sigreturn test case
> 
> v3 updates (based on review feedback from Ingo Molnar and Dave Hansen):
> - Split the original patch into 3:
>         - function interface changes
>         - helper functions
>         - functional change to write pkru on sigframe
> - Enabled all pkeys before XSAVE - i.e. wrpkru(0), rather than assuming
> that the alt sig stack is always protected by pkey 0.
> - Added a few test cases in pkey_sighandler_tests.c.
> 
> I had some trouble adding these tests to
> tools/testing/selftests/mm/protection_keys.c, so they're in a separate
> file.
> 

Please add me to the future thread of this patch ! Thanks

I added a few more people to the email list. We've dealt with similar
situations in the past ([1] [2]), so it might be a good idea to
keep them updated. Also, ChromeOS and Chrome will use the functionality
provided by this patch series.

[1] https://lore.kernel.org/all/202208221331.71C50A6F@keescook/

[2] https://docs.google.com/document/d/1DjPhBq-5gRKtTeaknQDTWfvqRBCONmYqkU1I6k-3Ai8/edit?resourcekey=0-GGQta3_yhKqK7xV5SxIrVQ&tab=t.0

Thanks!
-Jeff

