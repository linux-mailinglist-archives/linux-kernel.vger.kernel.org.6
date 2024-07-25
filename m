Return-Path: <linux-kernel+bounces-262335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6832893C435
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0DE9B22E80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC73919DF62;
	Thu, 25 Jul 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Bb+h80nq"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1CD13DDB8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917857; cv=none; b=pu8WEe8+VSLUpaIk/msMwUukfti6X51p/aflTmIn7dAuCVK7hnZ66bFjD7iCCS2oL1GqRmhO4HemCX9A19nZRg/vnBy1YK++QeVA3OhXSxKeGq/o1nDAYXBUKmxMgkr538roDLJtz1xuFma3k/SYPBHjSvi5MlN36Z0YckiB4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917857; c=relaxed/simple;
	bh=xHs2jmKFXMf/OT7wpt/Mu6N9nCaIo8PjCCusIQvQ+qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cpum/QCbuXZtedIcEo0TjVbyR2wPVvjeF647Z8mXcxX6Kgu8VRQ5J+DXOMggMfj6fmwS1em3PNCL+Ze7SDJCNvKVCg5dXk9GE/R7r8zJHf0xKwMQ/glcWNAq0te+tLNNWP8lVEPy2e0xFlYOSRz8GPKuTWf1X8sxaX9Cl0lGFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Bb+h80nq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44931f038f9so18318441cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1721917854; x=1722522654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xHs2jmKFXMf/OT7wpt/Mu6N9nCaIo8PjCCusIQvQ+qY=;
        b=Bb+h80nqV1rd3VtplgnFqFTwCgRu4k1Pyt0IBqMQq3CjDVyDgZ7dEweNBrqZpDBYL2
         uHFUlGy0eXftq9Nlc0eYUS9xz611MOmb+u0DVPn6MkStk4xiSGExXWyFKjxk0PYJDzQp
         8AsSp/CsoO8QuamPImtfIqPwppWCRupSXfnPVqHJN5gjqXQP2543QW+jxfudHshQE0/H
         09ODYwxSZ0e5U0nXT9WLC3RGO7gw1pJBurxAl2I09bYJd2n7J3EspyoxGtzU/27KSI+A
         DnPaY5qKOQzSvYDzeGLA/4TNGZuvpOXnDhS2EEReze6xXeprNV9BBpyDlWkAXeIyIjep
         z5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917854; x=1722522654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHs2jmKFXMf/OT7wpt/Mu6N9nCaIo8PjCCusIQvQ+qY=;
        b=bVSU+X83kxdtQw1JS7qBva9oQTKVILU9IhIvm1Ls6z5qesePG6jpkR8VRX6/i+AjJW
         EHP1zlPr4ooYxK17lEaH+goV4Rx4Cg5VwWO41Kh+3yP5OVXvyF7gWR/boAfcCn5pUHOW
         XAiYwNMIpovHfFXqiabxk3/o2IbqIyiOt6A3Bo3wKyopYcWrV4kldEs7L0/9eAZnYnvI
         H2AM6QOTUa6gKvdwbSYtqaQAtRS9CzGC6PKiO3e4fQ25zqrnIxLBx26kbQbUk16BpTbu
         dX4GSE9OlOJlTORUOiD/lsdGk+dCNph683kiPWurdnWURQO7WIPAqIb4fCvIi9vpH/ew
         l2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCX3FbxyG5cgkZNLGWPUU/kYo4Kl6L//ap8Ak1Za/x7SLFBjgb3L4DAPM6ThM6/ahVPX0FJUuQ1G8Lkc00pMpp40vDxOqjRqzjBcOYEG
X-Gm-Message-State: AOJu0YwRaET9vgBNYqX8otvx4ZayoHsGQ2GFEkBhP0Qgg+eY1zsH7vRt
	NuIWwdnXdltrRtOq3H0PrH004faqzIUAc5OT1SibYvL9eFyKBXybhARn5DVOu5NExer++H8I53b
	FYgFpqJO6mC2J3ybUFsUrdzlY/csSQVOrbyC88g==
X-Google-Smtp-Source: AGHT+IFEc6g27wRZYSzkTDt9HUS72uG/RnoE+Py8rzXlwdepXV+xJDzAHcRFkyaUdnKR8MOH+tLYOee8/8CpPxxzt/A=
X-Received: by 2002:ac8:7d13:0:b0:447:dd66:8004 with SMTP id
 d75a77b69052e-44fe32d48edmr52381461cf.27.1721917853819; Thu, 25 Jul 2024
 07:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724203322.2765486-1-pasha.tatashin@soleen.com>
 <20240724203322.2765486-4-pasha.tatashin@soleen.com> <grznsm36eydexh7q3fpt57cd5w2g72mb57s7som3wf6c4jt2j6@komzdw3zm2lw>
In-Reply-To: <grznsm36eydexh7q3fpt57cd5w2g72mb57s7som3wf6c4jt2j6@komzdw3zm2lw>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 25 Jul 2024 10:30:15 -0400
Message-ID: <CA+CK2bAWbp7T5tvbFd7NKYYNWyOY1LSiOGAFQGe0BrmSRNQU3g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] task_stack: uninline stack_not_used
To: akpm@linux-foundation.org
Cc: Shakeel Butt <shakeel.butt@linux.dev>, jpoimboe@kernel.org, kent.overstreet@linux.dev, 
	peterz@infradead.org, nphamcs@gmail.com, cerasuolodomenico@gmail.com, 
	surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, vbabka@suse.cz, 
	ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Andrew,

You took the other two patches, but not this one. Should I drop it in
the next version?

Pasha

