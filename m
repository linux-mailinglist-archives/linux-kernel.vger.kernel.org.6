Return-Path: <linux-kernel+bounces-547063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92164A50294
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D88C1888D7C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A524E008;
	Wed,  5 Mar 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="IvgeIBDP"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3024E4A6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185842; cv=none; b=nDzA0hgjv/eRZItzH7tS2pokl60KMS2de7mhWatynPvd+cXf3WphfV6g0+2IajzFjTv0SSDqh4sSRYa8XgKD4RsVE2REb89cqHe418FzzreQeNjvyrItVHwd2sNdqC1zImPN7P0rsL9iYLefH/rMg3c/YUoRp78W6cQ+XN0spbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185842; c=relaxed/simple;
	bh=pcfZij1MUqUjvE1R8Bj+qorgSs7f5dQOpSppXAufupw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9bJvDPm0XSNTJPQ/6QbW6GkfG/cFkirTc3bRFaacgyzfo7t5E8qyszJu3LToGqjHVybQLKR0iHoyPki27MRyRkqh0BvcWXPtQLdc07c/5vqy/as+YpR8/yPvoFpf50YcKBTuqXPuyJQqRxEr/rJR9mnxmE1QYqHxAL0LPZkCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=IvgeIBDP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be8f281714so797149085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741185838; x=1741790638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m8f2GDESLoXks5iTtTl11BvauZGdfcVPK6WPs3q/K+I=;
        b=IvgeIBDP7moMBZ6K96+QgCA5C1i+Yi/q+4BY020ht2+FXz71qeQ7xpvcb5BYN39uV0
         /bGJni/vYRCDqPR376Y2DLeX1aCxrhXigaBRZUOwTAzo0CumO0XWZ8d7RaEtNrFYk1ky
         du/glqArqjxfL7pkXAOLeevSoB4iH7G0ldTR5A5a4fDocC57c6bjq+AdV81kNpt41rzQ
         NKueTfxYGGJjVvwGwR/oAC4J9aFHkBHGn4TIZLmxDKm/skGhHcNB6NyOrjJlgQPI4+XH
         LGJboRGu27LScHS5ISEWyofYqMPXB19MYl8+U4Qw1Zld2Qjz4u+8hBu20k8VsYUP9cSk
         F2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185838; x=1741790638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8f2GDESLoXks5iTtTl11BvauZGdfcVPK6WPs3q/K+I=;
        b=viDLmZvAjSyGZEclIOKEjtFEjDZNdWfBhV1XnTlZdEO+uTASVaKusqwBF3E3Q1bGoi
         esp39+kaGYAXfPkgv6QfkW9oPykEtL6zmZGxtDuyBRBatIWg0Ojzr4ziNa1v/bOgLF9t
         pnUDy4q/hSwAY/NMo5o1Q5ElvEj+9iYdD6QFlWWMZY4XHPVQPm514/QO+t9tRCB6RAKa
         rNSheko308IM70uNuTBKE4MGt4GqpSxjj9tnbJlFb9+O/O92ZVKeka/gD48B5Pu8vEcb
         FIKHGgy8z2pggXxzZtyITUo02kwMGCWeiat7i8gQ/JwebnmHXUaqjeh34qbv6UpM8MN2
         PT8A==
X-Forwarded-Encrypted: i=1; AJvYcCWGzBj8mqGczKn65/rtQNI1VrExfyo6Ixb/N8IyVaAUOj3DcBJozzwJndWxRS40HI8YC0CnivMZ0T62mkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJufQrDNVf8g2fs9O8dWhKb5vvg5iixyr4IbEoE04VFpsT+tdY
	HwJqky21p1hy25gLZLutQowTLTbztqYw4FIdEQlsun2Gz5ungiOCDy8SQlWBQaI=
X-Gm-Gg: ASbGncsAlS6BYLnZWUWZfogFNReE9hquM9Xfn6tJoenbt34F/1oSl4VeJu8i+zOefhQ
	Im10f8dGUbkLaA4og+efbCnysqGBKWtt44P4uqFrLKkfywsjqsj9aVohZMX2MziWhtCLgkgSKh2
	YpqgTY8PQ7OaB9qT6KABpooniHrVA4EAm8azXIMeWPV6N4piGPc/g4ldhPNzsemhZirMBPyOEsG
	PYLELozsPbtnloi5vff0OqROwCUUDrlYBdY1x7IrM/TGuw26kgHW8KMtPwNvFWF5fShTlRnSFxb
	elHYnHaAsqQ8DlMxTIDOeQU5psu9L9SmKtPNbXV5gIk=
X-Google-Smtp-Source: AGHT+IFX+ow3byGDTZw9C0w2IUK5a1lbN4mR9fGRC6Dqsc5MHt7AQp9jQ6MNPCZ09WKr58d/5jQqjQ==
X-Received: by 2002:a05:620a:6006:b0:7c0:b587:9e6 with SMTP id af79cd13be357-7c3d8eb3bf9mr568804385a.43.1741185838581;
        Wed, 05 Mar 2025 06:43:58 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c378d9e2d5sm885607885a.68.2025.03.05.06.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:43:57 -0800 (PST)
Date: Wed, 5 Mar 2025 09:43:56 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 1/5] mm: zpool: Add interfaces for object
 read/write APIs
Message-ID: <20250305144356.GA185622@cmpxchg.org>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-2-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-2-yosry.ahmed@linux.dev>

On Wed, Mar 05, 2025 at 06:11:29AM +0000, Yosry Ahmed wrote:
> Zsmalloc introduce new APIs to read/write objects besides mapping them.
> Add the necessary zpool interfaces.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

