Return-Path: <linux-kernel+bounces-550809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B53D6A56466
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3FA188E02D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EE820C479;
	Fri,  7 Mar 2025 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKcRlBRp"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD281E1DEE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341277; cv=none; b=XHFr0OA/DmbKR48VUojaXFQe2pSUciPJSRmQGsZN6RxBVIzQSnE3SxFFp8mO0f/RCjafpVDF/RL0kfqf7Sz4oFn/7kdBSon3Mhw42a4uUa5E8qizUVRecqfp5bdWJowiB4efPe5bZ+JS9UUhwSGf4MQudVn5sTsqqq/seqqGKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341277; c=relaxed/simple;
	bh=SNJTu6S+RxKk0mGGesiSe0L7+Yc327mwzneSBK2eWwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XX6cRAtgHglxkV8wznUnItCzmcAB6YiWmdfS+xGxIroWyvqyKtDFMh/17NxmzxdTy4ro5vMoqk7ZxwkIIt5GqZJh/geYh689c6hdshsSN6l6fBusBtB48okRDkWLaH5mA0nFdepTm9gDn9++ljIl7AvttOLxEhNXyRgi9IC6zAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKcRlBRp; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-474e1b8c935so217751cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741341275; x=1741946075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rKx/7WZeBAnXPF4y8oCkUH3yJ/CY8cCFbTvTuih92iE=;
        b=qKcRlBRpzHLPUApiTpdmPyvC+vR5x64cYaEFyjROkard/9J+zQDIQUVc0/KNZU65p9
         cH+SOtFGZ4sCAJ/zaLpGD81Q/wNqkEbG2bT0dD/Y/FGZZbfEQVzBrjqhBK0KbAyhYEwD
         i/P+hr6U7Vhr02KEvmADOFquZ1sB/q3A5aZLxz5recqvMcAAL0bQzVsNN9s5NlNvCiQR
         pTpyt8Q7vVTMMHr0XybP2+Nd50G+JFz8Jqv/+kUammqOuWKY/+RnMFsHFY59NDpqKFwT
         zciz6J6X+AmqD0Kbl6xCDdn8A1HkLByZfEcSFUJoR53fHJZC3+yzFEaSHtChOxzRnSJo
         1LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741341275; x=1741946075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKx/7WZeBAnXPF4y8oCkUH3yJ/CY8cCFbTvTuih92iE=;
        b=kc8sS9dHZihFc1/I7mFuMWbyMvBGBqESe3VQvpUnZ522OJ3hHUuiDs1Q1EBkL0rWXC
         JHovoULB+/nwRirIgtiJISHE8OBjwv/JjoRACXEVXkmjl5SOpeAK4WtWeMuYYYRx8LZn
         B8zsH/ZYRqGe9bCz5E4qNzOKuKzfN6zsVHDbTpymYiKWglpg/pO66XS2V4bZaSI8CBTz
         8RmcAlPiyLzT45bxcYXukRDJwpBhjHJ2Lcmd54Znm8vCRzeiWUPGsaj2NSawTSuA3hzB
         LJ7Ke8k5mI2kOgcahwNOfP4sls5O19OqoXSwgqWVvWMHhadz2TjoBM+DP7r2cwdk89Ri
         +iXw==
X-Forwarded-Encrypted: i=1; AJvYcCVKXDxzoimHlBg0IwXdPjjcFumfqvb57G6n4/ul++uSbqCfqZgDrx5ap3/rA7nBIdpekPMjxSX0oGb/Agg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjhIHxrrcNZGaCwOya5VFZclurLm+6kQ2HL/0ktpFV/fMsQfT/
	OyIClpz3AB6sGiaLDAsklhOrNnJZo/0isdyzEPIW73WTFevGPXs/M+X9NbKwnQTbpnc7GIEqXLm
	6g8p7RNE5X4Ed800/HTmMR7eDeGjABAz5we1c
X-Gm-Gg: ASbGncuPIQwQjpCsqzhjgc7S3uU/k//V8ppcOCQdiJQ2XOSBzr4opB6LGkPH+zoHher
	ziSetSvKyVnoo32EIQeOOD5IZyCRnYjhNiCosq3kgVIJXI8OiquP0pZttVNeqoXTfcmE58HVn/F
	G9A0LOwZmni+wynqZOixrCoCBAveZUwokyAbztHyzxN/O6dpVhuqSHT2Uw
X-Google-Smtp-Source: AGHT+IHocbYX04XnyKsC1RJwxG/GRnY9nk+ZaOYJZwAitetHw+vWivG5XOzbvlrUcVf71jsz/DdzJdaVcUStr/fGaHM=
X-Received: by 2002:ac8:5d54:0:b0:472:538:b795 with SMTP id
 d75a77b69052e-47621059cbfmr3098391cf.22.1741341274687; Fri, 07 Mar 2025
 01:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306182009.2255241-1-rmoar@google.com>
In-Reply-To: <20250306182009.2255241-1-rmoar@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 7 Mar 2025 10:54:23 +0100
X-Gm-Features: AQ5f1JpaRFS0OagxHIcY7KNQGrxr1iik6OffimOoxb01BkKIkyepohF5FdpbICo
Message-ID: <CA+i-1C2RgoRR-46uD+PBP0N5oLcJYDp05iE96QAXfRRz__e-BA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Fix bug in parsing test plan
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, davidgow@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 19:20, Rae Moar <rmoar@google.com> wrote:
>
> A bug was identified where the KTAP below caused an infinite loop:
>
>  TAP version 13
>  ok 4 test_case
>  1..4
>
> The infinite loop was caused by the parser not parsing a test plan
> if following a test result line.
>
> Fix this bug to correctly parse test plan line.
>
> Signed-off-by: Rae Moar <rmoar@google.com>

Hi Rae thanks again for taking a look at this. I just noticed
kunit_tool_test.py has unit tests for the parsing logic. Maybe worth
adding one for the case that was infinite looping before?

(I am not really able to offer an actual review as I couldn't really
understand the parsing code after a quick reading, but if you need it
then let me know and I'll chase you up to ask questions until I can
follow it, then I can review!)

