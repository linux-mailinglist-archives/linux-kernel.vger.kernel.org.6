Return-Path: <linux-kernel+bounces-391208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFB39B83D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF85A1F22742
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7303A1CEE92;
	Thu, 31 Oct 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaB2DkJ5"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1281CC8A8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404589; cv=none; b=LPglL/vhxNMrCORenqbMclNWwhkP2M8LKUZ+zg8McUU8zV5VYEwfl758Z1fCyq9xqwvhC1gSN31bkBqIsn5P9aelslTyP15HGVtOUXP5IZJV8JUrrKHL9TAXTfsw0A/brop5JHLBJo9P3N2QJyIqYBLFfHQUR/W57Jjpwi8FAKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404589; c=relaxed/simple;
	bh=irdmhu416PxIF988xDa7tIMGyvRLyDF64RSqw86O0Ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4OSV5HiaRUoC3dSE4jKo7RxhS2NMkJ/+rGWU4J/zyw5IuwwYlurq8KBvUSxlDVtRxDNzf7VE9vG0XkMbvzMyn4gKDoPVH+W5FfxdKO+/WRFB27grh2y/uovPUcChZLDpxm9dbNnHW+DJ2JDTFomIL95AgzDolnPy9gEFkAi1+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BaB2DkJ5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea527764c3so29197307b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404586; x=1731009386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcT/J95b+9035Ya9JfyYQ0TCrJz/IdJHOD9xyZsiM0Q=;
        b=BaB2DkJ5z11RKP6zMu2c5UAGueRrf1xWbbXDcBNXYQ+kZVdON7wr4WTuCLwzrX/XMZ
         YeLjnoMxbz99V7p3vdr1bvLowfxVuMiPq7+mp0C+UCppPg7VW9KDuCptMJ0KWxH1psQe
         fOHNaG4pHRXBro1+bgpqwMonH2FEo8qBmNcK/HveGrJxyvrJyjbf9nORfR/ksT37fooS
         KT4z/KBKpalFKSvw4uMNu3MesiwkOo05wkCUDk8oVA9u35xqfsrW2L+Y4o7pQelnvNad
         XKNwzjlZNAZaDjBsUmnDK+X/J4rBIGFurWv9mF9ZKrnkVAPalwlM838oyp7VYH61eo2G
         HI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404586; x=1731009386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcT/J95b+9035Ya9JfyYQ0TCrJz/IdJHOD9xyZsiM0Q=;
        b=nmS6SmiyKI2zxv0K6k+BVaHHbqYta5BOyfJsDR6n4j9dFVT9DlKYM4NsUGpbp3Y5hC
         ZkcFnPW/zCehqPTHz8B/upHZcR9hzOHdNTzOwSLJgCFhSxJb34FVOztxLpaJBkmyh1jf
         gipH569OteSklRVDj5+RRA50uyeyGY0CeZ3sIV6nnMFrucSjdwPKhjjpAbusQB5hzk0i
         YlbTma2hbaHFEchqurhnwQOwiW5+kaFCDmUoFRE4VvYwmBMRqfgYfUJN33qKhydQHj+O
         +VPP59PXLNslMtRG7HT7kpjjUrJXtt19J71YwM2Rm4Ulwf8ok8YM//QHThtSKmkjRHRw
         DTfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT0lVlu2o+767eKMPCI7QR4q/8m43/zr98XfiJ9a+CY5BZ9lxKQ728fshVCJPjGS4ITafAYz2OqW+Lk70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJPS2KpeYMX5AWmfIzn31Fbz2xr0O1ATMrVCtSCmrs85q75W3
	qei0tMrnx2qBRzkwVQFHdOEsMLpUk5TIubv46XAvlgl6DRo7ZBUnr0mZ1yxj35NudujufxndPtC
	elw==
X-Google-Smtp-Source: AGHT+IEmEp8u0KUn1vgmjUZHb/5zJ8j0UI9051gpFeWX3hQBJbdaH3En+U7SxFv81ttx+3Vv7JsNluVX+3g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:181e:b0:e28:fdfc:b788 with SMTP id
 3f1490d57ef6-e30cf4d455bmr5615276.9.1730404585605; Thu, 31 Oct 2024 12:56:25
 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:50 -0700
In-Reply-To: <20240903043135.11087-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240903043135.11087-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039502633.1508201.6734292194726141989.b4-ty@google.com>
Subject: Re: [PATCH] hardware_disable_test: remove unused macro
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Ba Jing <bajing@cmss.chinamobile.com>
Cc: shuah@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 03 Sep 2024 12:31:35 +0800, Ba Jing wrote:
> The macro GUEST_CODE_PIO_PORT is never referenced in the code,
> just remove it.

Applied to kvm-x86 selftests, thanks!

[1/1] hardware_disable_test: remove unused macro
      https://github.com/kvm-x86/linux/commit/600aa88014e9

--
https://github.com/kvm-x86/linux/tree/next

